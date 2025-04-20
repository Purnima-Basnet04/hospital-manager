package dao;

import model.MedicalRecord;
import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO {

    // Add a new medical record
    public boolean addMedicalRecord(MedicalRecord medicalRecord) {
        String query = "INSERT INTO medical_records (patient_id, doctor_id, appointment_id, record_date, " +
                      "diagnosis, treatment, prescription, notes, follow_up_date) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, medicalRecord.getPatientId());
            pstmt.setInt(2, medicalRecord.getDoctorId());
            
            if (medicalRecord.getAppointmentId() > 0) {
                pstmt.setInt(3, medicalRecord.getAppointmentId());
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            
            pstmt.setDate(4, medicalRecord.getRecordDate());
            pstmt.setString(5, medicalRecord.getDiagnosis());
            pstmt.setString(6, medicalRecord.getTreatment());
            pstmt.setString(7, medicalRecord.getPrescription());
            pstmt.setString(8, medicalRecord.getNotes());
            
            if (medicalRecord.getFollowUpDate() != null) {
                pstmt.setDate(9, medicalRecord.getFollowUpDate());
            } else {
                pstmt.setNull(9, Types.DATE);
            }
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        medicalRecord.setId(generatedKeys.getInt(1));
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

    // Get medical record by ID
    public MedicalRecord getMedicalRecordById(int id) {
        String query = "SELECT mr.*, " +
                      "p.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM medical_records mr " +
                      "JOIN users p ON mr.patient_id = p.id " +
                      "JOIN users d ON mr.doctor_id = d.id " +
                      "WHERE mr.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMedicalRecordFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get medical records by patient ID
    public List<MedicalRecord> getMedicalRecordsByPatientId(int patientId) {
        List<MedicalRecord> medicalRecords = new ArrayList<>();
        String query = "SELECT mr.*, " +
                      "p.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM medical_records mr " +
                      "JOIN users p ON mr.patient_id = p.id " +
                      "JOIN users d ON mr.doctor_id = d.id " +
                      "WHERE mr.patient_id = ? " +
                      "ORDER BY mr.record_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, patientId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    medicalRecords.add(extractMedicalRecordFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return medicalRecords;
    }

    // Get medical records by doctor ID
    public List<MedicalRecord> getMedicalRecordsByDoctorId(int doctorId) {
        List<MedicalRecord> medicalRecords = new ArrayList<>();
        String query = "SELECT mr.*, " +
                      "p.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM medical_records mr " +
                      "JOIN users p ON mr.patient_id = p.id " +
                      "JOIN users d ON mr.doctor_id = d.id " +
                      "WHERE mr.doctor_id = ? " +
                      "ORDER BY mr.record_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, doctorId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    medicalRecords.add(extractMedicalRecordFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return medicalRecords;
    }

    // Get medical records by appointment ID
    public MedicalRecord getMedicalRecordByAppointmentId(int appointmentId) {
        String query = "SELECT mr.*, " +
                      "p.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM medical_records mr " +
                      "JOIN users p ON mr.patient_id = p.id " +
                      "JOIN users d ON mr.doctor_id = d.id " +
                      "WHERE mr.appointment_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, appointmentId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMedicalRecordFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get all medical records
    public List<MedicalRecord> getAllMedicalRecords() {
        List<MedicalRecord> medicalRecords = new ArrayList<>();
        String query = "SELECT mr.*, " +
                      "p.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM medical_records mr " +
                      "JOIN users p ON mr.patient_id = p.id " +
                      "JOIN users d ON mr.doctor_id = d.id " +
                      "ORDER BY mr.record_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                medicalRecords.add(extractMedicalRecordFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return medicalRecords;
    }

    // Update medical record
    public boolean updateMedicalRecord(MedicalRecord medicalRecord) {
        String query = "UPDATE medical_records SET patient_id = ?, doctor_id = ?, appointment_id = ?, " +
                      "record_date = ?, diagnosis = ?, treatment = ?, prescription = ?, notes = ?, " +
                      "follow_up_date = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, medicalRecord.getPatientId());
            pstmt.setInt(2, medicalRecord.getDoctorId());
            
            if (medicalRecord.getAppointmentId() > 0) {
                pstmt.setInt(3, medicalRecord.getAppointmentId());
            } else {
                pstmt.setNull(3, Types.INTEGER);
            }
            
            pstmt.setDate(4, medicalRecord.getRecordDate());
            pstmt.setString(5, medicalRecord.getDiagnosis());
            pstmt.setString(6, medicalRecord.getTreatment());
            pstmt.setString(7, medicalRecord.getPrescription());
            pstmt.setString(8, medicalRecord.getNotes());
            
            if (medicalRecord.getFollowUpDate() != null) {
                pstmt.setDate(9, medicalRecord.getFollowUpDate());
            } else {
                pstmt.setNull(9, Types.DATE);
            }
            
            pstmt.setInt(10, medicalRecord.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete medical record
    public boolean deleteMedicalRecord(int id) {
        String query = "DELETE FROM medical_records WHERE id = ?";
        
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

    // Helper method to extract a medical record from the ResultSet
    private MedicalRecord extractMedicalRecordFromResultSet(ResultSet rs) throws SQLException {
        MedicalRecord medicalRecord = new MedicalRecord();
        medicalRecord.setId(rs.getInt("id"));
        medicalRecord.setPatientId(rs.getInt("patient_id"));
        medicalRecord.setDoctorId(rs.getInt("doctor_id"));
        
        int appointmentId = rs.getInt("appointment_id");
        if (!rs.wasNull()) {
            medicalRecord.setAppointmentId(appointmentId);
        }
        
        medicalRecord.setRecordDate(rs.getDate("record_date"));
        medicalRecord.setDiagnosis(rs.getString("diagnosis"));
        medicalRecord.setTreatment(rs.getString("treatment"));
        medicalRecord.setPrescription(rs.getString("prescription"));
        medicalRecord.setNotes(rs.getString("notes"));
        medicalRecord.setFollowUpDate(rs.getDate("follow_up_date"));
        medicalRecord.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Create minimal User objects for patient and doctor
        User patient = new User();
        patient.setId(rs.getInt("patient_id"));
        patient.setFullName(rs.getString("patient_name"));
        medicalRecord.setPatient(patient);
        
        User doctor = new User();
        doctor.setId(rs.getInt("doctor_id"));
        doctor.setFullName(rs.getString("doctor_name"));
        medicalRecord.setDoctor(doctor);
        
        return medicalRecord;
    }
}
