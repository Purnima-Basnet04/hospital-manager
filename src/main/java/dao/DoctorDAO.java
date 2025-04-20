package dao;

import model.Doctor;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    // Add a new doctor
    public boolean addDoctor(Doctor doctor) {
        String query = "INSERT INTO doctor (Name, Specialization, Email, Phone, Password) " +
                "VALUES (?, ?, ?, ?, ?)";

        System.out.println("Adding doctor to database: " + doctor.getName() + ", " + doctor.getSpecialization());

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, doctor.getName());
            pstmt.setString(2, doctor.getSpecialization());
            pstmt.setString(3, doctor.getEmail());
            pstmt.setString(4, doctor.getPhone());
            pstmt.setString(5, doctor.getPassword());

            System.out.println("Executing SQL: " + query +
                " with values: " + doctor.getName() + ", " +
                doctor.getSpecialization() + ", " + doctor.getEmail() + ", " + doctor.getPhone() + ", ******");

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        doctor.setDoctorID(generatedKeys.getInt(1));
                        System.out.println("Doctor added successfully with ID: " + doctor.getDoctorID());
                        return true;
                    }
                }
            }

            System.out.println("Doctor registration failed");
            return false;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error adding doctor: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }



    // Get doctor by ID
    public Doctor getDoctorById(int id) {
        String query = "SELECT * FROM doctor WHERE DoctorID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractDoctorFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // For backward compatibility
    public Doctor getDoctorById(String id) {
        try {
            return getDoctorById(Integer.parseInt(id));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    // Get doctor by email
    public Doctor getDoctorByEmail(String email) {
        String query = "SELECT * FROM doctor WHERE Email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractDoctorFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Authenticate doctor
    public Doctor authenticateDoctor(String email, String password) {
        String query = "SELECT * FROM doctor WHERE Email = ? AND Password = ?";

        System.out.println("Authenticating doctor with email: " + email);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Doctor doctor = extractDoctorFromResultSet(rs);
                    System.out.println("Doctor authenticated successfully: " + doctor.getDoctorID() + ", " + doctor.getName());
                    return doctor;
                } else {
                    System.out.println("Doctor authentication failed: No matching record found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Authentication error: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Get all doctors
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String query = "SELECT * FROM doctor";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                doctors.add(extractDoctorFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return doctors;
    }

    // Get doctors by department (keeping this method for compatibility)
    public List<Doctor> getDoctorsByDepartment(int departmentId) {
        // In the new schema, we would need to add a department_id field to the doctor table
        // For now, just return all doctors
        return getAllDoctors();
    }

    // Update doctor
    public boolean updateDoctor(Doctor doctor) {
        String query = "UPDATE doctor SET Name = ?, Specialization = ?, Email = ?, Phone = ?, Password = ? WHERE DoctorID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, doctor.getName());
            pstmt.setString(2, doctor.getSpecialization());
            pstmt.setString(3, doctor.getEmail());
            pstmt.setString(4, doctor.getPhone());
            pstmt.setString(5, doctor.getPassword());
            pstmt.setInt(6, doctor.getDoctorID());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete doctor
    public boolean deleteDoctor(int id) {
        String query = "DELETE FROM doctor WHERE DoctorID = ?";

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

    // For backward compatibility
    public boolean deleteDoctor(String id) {
        try {
            return deleteDoctor(Integer.parseInt(id));
        } catch (NumberFormatException e) {
            return false;
        }
    }

    // Helper method to extract doctor from ResultSet
    private Doctor extractDoctorFromResultSet(ResultSet rs) throws SQLException {
        try {
            Doctor doctor = new Doctor();
            int doctorId = rs.getInt("DoctorID");
            String name = rs.getString("Name");
            String specialization = rs.getString("Specialization");
            String email = rs.getString("Email");
            String phone = rs.getString("Phone");
            String password = rs.getString("Password");

            System.out.println("Extracting doctor from ResultSet: " + doctorId + ", " + name + ", " + specialization);

            doctor.setDoctorID(doctorId);
            doctor.setName(name);
            doctor.setSpecialization(specialization);
            doctor.setEmail(email);
            doctor.setPhone(phone);
            doctor.setPassword(password);

            return doctor;
        } catch (SQLException e) {
            System.out.println("Error extracting doctor from ResultSet: " + e.getMessage());
            throw e;
        }
    }
}