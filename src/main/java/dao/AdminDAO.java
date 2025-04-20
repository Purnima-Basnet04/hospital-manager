package dao;

import model.Admin;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    // Add a new admin
    public boolean addAdmin(Admin admin) {
        String query = "INSERT INTO admin (Name, Email, Password, Phone) " +
                "VALUES (?, ?, ?, ?)";

        System.out.println("Adding admin to database: " + admin.getName());

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, admin.getName());
            pstmt.setString(2, admin.getEmail());
            pstmt.setString(3, admin.getPassword());
            pstmt.setString(4, admin.getPhone());

            System.out.println("Executing SQL: " + query +
                " with values: " + admin.getName() + ", " +
                admin.getEmail() + ", ******, " + admin.getPhone());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        admin.setAdminID(generatedKeys.getInt(1));
                        System.out.println("Admin added successfully with ID: " + admin.getAdminID());
                        return true;
                    }
                }
            }

            System.out.println("Admin registration failed");
            return false;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error adding admin: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get admin by ID
    public Admin getAdminById(int id) {
        String query = "SELECT * FROM admin WHERE AdminID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractAdminFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get admin by email
    public Admin getAdminByEmail(String email) {
        String query = "SELECT * FROM admin WHERE Email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractAdminFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Authenticate admin
    public Admin authenticateAdmin(String email, String password) {
        String query = "SELECT * FROM admin WHERE Email = ? AND Password = ?";

        System.out.println("Authenticating admin with email: " + email);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = extractAdminFromResultSet(rs);
                    System.out.println("Admin authenticated successfully: " + admin.getAdminID() + ", " + admin.getName());
                    return admin;
                } else {
                    System.out.println("Admin authentication failed: No matching record found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Authentication error: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get all admins
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String query = "SELECT * FROM admin";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                admins.add(extractAdminFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return admins;
    }

    // Update admin
    public boolean updateAdmin(Admin admin) {
        String query = "UPDATE admin SET Name = ?, Email = ?, Password = ?, Phone = ? WHERE AdminID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, admin.getName());
            pstmt.setString(2, admin.getEmail());
            pstmt.setString(3, admin.getPassword());
            pstmt.setString(4, admin.getPhone());
            pstmt.setInt(5, admin.getAdminID());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete admin
    public boolean deleteAdmin(int id) {
        String query = "DELETE FROM admin WHERE AdminID = ?";

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

    // Helper method to extract admin from ResultSet
    private Admin extractAdminFromResultSet(ResultSet rs) throws SQLException {
        try {
            Admin admin = new Admin();
            admin.setAdminID(rs.getInt("AdminID"));
            admin.setName(rs.getString("Name"));
            admin.setEmail(rs.getString("Email"));
            admin.setPassword(rs.getString("Password"));
            admin.setPhone(rs.getString("Phone"));

            return admin;
        } catch (SQLException e) {
            System.out.println("Error extracting admin from ResultSet: " + e.getMessage());
            throw e;
        }
    }
}
