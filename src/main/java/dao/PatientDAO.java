package dao;

import model.Patient;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    // Add a new patient
    public boolean addPatient(Patient patient) {
        String query = "INSERT INTO patient (PatientID, FullName, Username, Email, Password, Gender, DateOfBirth, Phone, BloodGroup, Address) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, patient.getPatientIDString());
            pstmt.setString(2, patient.getFullName());
            pstmt.setString(3, patient.getUsername());
            pstmt.setString(4, patient.getEmail());
            pstmt.setString(5, patient.getPassword());
            pstmt.setString(6, patient.getGender());
            pstmt.setDate(7, patient.getDob());
            pstmt.setString(8, patient.getPhone());
            pstmt.setString(9, patient.getBloodGroup());
            pstmt.setString(10, patient.getAddress());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get patient by ID
    public Patient getPatientById(String id) {
        String query = "SELECT * FROM patient WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractPatientFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get patient by username
    public Patient getPatientByUsername(String username) {
        String query = "SELECT * FROM patient WHERE Username = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractPatientFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get patient by email
    public Patient getPatientByEmail(String email) {
        String query = "SELECT * FROM patient WHERE Email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractPatientFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Authenticate patient
    public Patient authenticatePatient(String username, String password) {
        String query = "SELECT * FROM patient WHERE (Username = ? OR Email = ?) AND Password = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            pstmt.setString(2, username); // Allow login with email as well
            pstmt.setString(3, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Patient patient = extractPatientFromResultSet(rs);

                    // Update last login time
                    updateLastLogin(patient.getPatientIDString());

                    return patient;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update last login time
    private void updateLastLogin(String patientId) {
        String query = "UPDATE patient SET LastLogin = CURRENT_TIMESTAMP WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, patientId);
            pstmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Get all patients
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String query = "SELECT * FROM patient";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                patients.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return patients;
    }

    // Update patient details
    public boolean updatePatient(Patient patient) {
        String query = "UPDATE patient SET FullName = ?, Username = ?, Email = ?, Password = ?, Gender = ?, DateOfBirth = ?, Phone = ?, BloodGroup = ?, Address = ? WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, patient.getFullName());
            pstmt.setString(2, patient.getUsername());
            pstmt.setString(3, patient.getEmail());
            pstmt.setString(4, patient.getPassword());
            pstmt.setString(5, patient.getGender());
            pstmt.setDate(6, patient.getDob());
            pstmt.setString(7, patient.getPhone());
            pstmt.setString(8, patient.getBloodGroup());
            pstmt.setString(9, patient.getAddress());
            pstmt.setString(10, patient.getPatientIDString());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete patient by ID
    public boolean deletePatient(String id) {
        String query = "DELETE FROM patient WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to extract a patient from the ResultSet
    private Patient extractPatientFromResultSet(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientIDString(rs.getString("PatientID"));
        patient.setFullName(rs.getString("FullName"));
        patient.setUsername(rs.getString("Username"));
        patient.setEmail(rs.getString("Email"));
        patient.setPassword(rs.getString("Password"));
        patient.setGender(rs.getString("Gender"));
        patient.setDob(rs.getDate("DateOfBirth"));
        patient.setPhone(rs.getString("Phone"));
        patient.setBloodGroup(rs.getString("BloodGroup"));
        patient.setAddress(rs.getString("Address"));

        // Set role for compatibility
        patient.setRole("PATIENT");

        return patient;
    }
}
