package dao;

import model.Department;
import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAO {

    // Add a new department
    public boolean addDepartment(Department department) {
        String query = "INSERT INTO departments (name, description, location, head_doctor_id) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, department.getName());
            pstmt.setString(2, department.getDescription());
            pstmt.setString(3, department.getLocation());
            
            if (department.getHeadDoctorId() > 0) {
                pstmt.setInt(4, department.getHeadDoctorId());
            } else {
                pstmt.setNull(4, Types.INTEGER);
            }
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        department.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get department by ID
    public Department getDepartmentById(int id) {
        String query = "SELECT d.*, u.full_name as head_doctor_name FROM departments d " +
                      "LEFT JOIN users u ON d.head_doctor_id = u.id WHERE d.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractDepartmentFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get all departments
    public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        String query = "SELECT d.*, u.full_name as head_doctor_name FROM departments d " +
                      "LEFT JOIN users u ON d.head_doctor_id = u.id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                departments.add(extractDepartmentFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return departments;
    }

    // Update department
    public boolean updateDepartment(Department department) {
        String query = "UPDATE departments SET name = ?, description = ?, location = ?, head_doctor_id = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, department.getName());
            pstmt.setString(2, department.getDescription());
            pstmt.setString(3, department.getLocation());
            
            if (department.getHeadDoctorId() > 0) {
                pstmt.setInt(4, department.getHeadDoctorId());
            } else {
                pstmt.setNull(4, Types.INTEGER);
            }
            
            pstmt.setInt(5, department.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete department
    public boolean deleteDepartment(int id) {
        String query = "DELETE FROM departments WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to extract a department from the ResultSet
    private Department extractDepartmentFromResultSet(ResultSet rs) throws SQLException {
        Department department = new Department();
        department.setId(rs.getInt("id"));
        department.setName(rs.getString("name"));
        department.setDescription(rs.getString("description"));
        department.setLocation(rs.getString("location"));
        
        int headDoctorId = rs.getInt("head_doctor_id");
        if (!rs.wasNull()) {
            department.setHeadDoctorId(headDoctorId);
            
            // Create a minimal User object for the head doctor
            if (rs.getString("head_doctor_name") != null) {
                User headDoctor = new User();
                headDoctor.setId(headDoctorId);
                headDoctor.setFullName(rs.getString("head_doctor_name"));
                department.setHeadDoctor(headDoctor);
            }
        }
        
        return department;
    }
}
