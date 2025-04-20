package dao;

import model.Prescription;
import model.PrescriptionItem;
import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO {

    // Add a new prescription
    public boolean addPrescription(Prescription prescription) {
        String query = "INSERT INTO prescriptions (medical_record_id, patient_id, doctor_id, prescription_date, status, notes) " +
                      "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, prescription.getMedicalRecordId());
            pstmt.setInt(2, prescription.getPatientId());
            pstmt.setInt(3, prescription.getDoctorId());
            pstmt.setDate(4, prescription.getPrescriptionDate());
            pstmt.setString(5, prescription.getStatus());
            pstmt.setString(6, prescription.getNotes());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        prescription.setId(generatedKeys.getInt(1));
                        
                        // Add prescription items if any
                        if (prescription.getPrescriptionItems() != null && !prescription.getPrescriptionItems().isEmpty()) {
                            PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                            for (PrescriptionItem item : prescription.getPrescriptionItems()) {
                                item.setPrescriptionId(prescription.getId());
                                prescriptionItemDAO.addPrescriptionItem(item);
                            }
                        }
                        
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

    // Get prescription by ID
    public Prescription getPrescriptionById(int id) {
        String query = "SELECT p.*, " +
                      "pt.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM prescriptions p " +
                      "JOIN users pt ON p.patient_id = pt.id " +
                      "JOIN users d ON p.doctor_id = d.id " +
                      "WHERE p.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Prescription prescription = extractPrescriptionFromResultSet(rs);
                    
                    // Load prescription items
                    PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                    List<PrescriptionItem> items = prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescription.getId());
                    prescription.setPrescriptionItems(items);
                    
                    return prescription;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get prescriptions by patient ID
    public List<Prescription> getPrescriptionsByPatientId(int patientId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String query = "SELECT p.*, " +
                      "pt.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM prescriptions p " +
                      "JOIN users pt ON p.patient_id = pt.id " +
                      "JOIN users d ON p.doctor_id = d.id " +
                      "WHERE p.patient_id = ? " +
                      "ORDER BY p.prescription_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, patientId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Prescription prescription = extractPrescriptionFromResultSet(rs);
                    
                    // Load prescription items
                    PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                    List<PrescriptionItem> items = prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescription.getId());
                    prescription.setPrescriptionItems(items);
                    
                    prescriptions.add(prescription);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return prescriptions;
    }

    // Get prescriptions by doctor ID
    public List<Prescription> getPrescriptionsByDoctorId(int doctorId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String query = "SELECT p.*, " +
                      "pt.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM prescriptions p " +
                      "JOIN users pt ON p.patient_id = pt.id " +
                      "JOIN users d ON p.doctor_id = d.id " +
                      "WHERE p.doctor_id = ? " +
                      "ORDER BY p.prescription_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, doctorId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Prescription prescription = extractPrescriptionFromResultSet(rs);
                    
                    // Load prescription items
                    PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                    List<PrescriptionItem> items = prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescription.getId());
                    prescription.setPrescriptionItems(items);
                    
                    prescriptions.add(prescription);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return prescriptions;
    }

    // Get prescriptions by medical record ID
    public List<Prescription> getPrescriptionsByMedicalRecordId(int medicalRecordId) {
        List<Prescription> prescriptions = new ArrayList<>();
        String query = "SELECT p.*, " +
                      "pt.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM prescriptions p " +
                      "JOIN users pt ON p.patient_id = pt.id " +
                      "JOIN users d ON p.doctor_id = d.id " +
                      "WHERE p.medical_record_id = ? " +
                      "ORDER BY p.prescription_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, medicalRecordId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Prescription prescription = extractPrescriptionFromResultSet(rs);
                    
                    // Load prescription items
                    PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                    List<PrescriptionItem> items = prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescription.getId());
                    prescription.setPrescriptionItems(items);
                    
                    prescriptions.add(prescription);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return prescriptions;
    }

    // Get all prescriptions
    public List<Prescription> getAllPrescriptions() {
        List<Prescription> prescriptions = new ArrayList<>();
        String query = "SELECT p.*, " +
                      "pt.full_name as patient_name, " +
                      "d.full_name as doctor_name " +
                      "FROM prescriptions p " +
                      "JOIN users pt ON p.patient_id = pt.id " +
                      "JOIN users d ON p.doctor_id = d.id " +
                      "ORDER BY p.prescription_date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Prescription prescription = extractPrescriptionFromResultSet(rs);
                
                // Load prescription items
                PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                List<PrescriptionItem> items = prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescription.getId());
                prescription.setPrescriptionItems(items);
                
                prescriptions.add(prescription);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return prescriptions;
    }

    // Update prescription
    public boolean updatePrescription(Prescription prescription) {
        String query = "UPDATE prescriptions SET medical_record_id = ?, patient_id = ?, doctor_id = ?, " +
                      "prescription_date = ?, status = ?, notes = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, prescription.getMedicalRecordId());
            pstmt.setInt(2, prescription.getPatientId());
            pstmt.setInt(3, prescription.getDoctorId());
            pstmt.setDate(4, prescription.getPrescriptionDate());
            pstmt.setString(5, prescription.getStatus());
            pstmt.setString(6, prescription.getNotes());
            pstmt.setInt(7, prescription.getId());
            
            int affectedRows = pstmt.executeUpdate();
            
            // Update prescription items if any
            if (affectedRows > 0 && prescription.getPrescriptionItems() != null && !prescription.getPrescriptionItems().isEmpty()) {
                PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
                
                // Delete existing items
                prescriptionItemDAO.deletePrescriptionItemsByPrescriptionId(prescription.getId());
                
                // Add new items
                for (PrescriptionItem item : prescription.getPrescriptionItems()) {
                    item.setPrescriptionId(prescription.getId());
                    prescriptionItemDAO.addPrescriptionItem(item);
                }
            }
            
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update prescription status
    public boolean updatePrescriptionStatus(int prescriptionId, String status) {
        String query = "UPDATE prescriptions SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, prescriptionId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete prescription
    public boolean deletePrescription(int id) {
        // First delete all prescription items
        PrescriptionItemDAO prescriptionItemDAO = new PrescriptionItemDAO();
        prescriptionItemDAO.deletePrescriptionItemsByPrescriptionId(id);
        
        // Then delete the prescription
        String query = "DELETE FROM prescriptions WHERE id = ?";
        
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

    // Helper method to extract a prescription from the ResultSet
    private Prescription extractPrescriptionFromResultSet(ResultSet rs) throws SQLException {
        Prescription prescription = new Prescription();
        prescription.setId(rs.getInt("id"));
        prescription.setMedicalRecordId(rs.getInt("medical_record_id"));
        prescription.setPatientId(rs.getInt("patient_id"));
        prescription.setDoctorId(rs.getInt("doctor_id"));
        prescription.setPrescriptionDate(rs.getDate("prescription_date"));
        prescription.setStatus(rs.getString("status"));
        prescription.setNotes(rs.getString("notes"));
        prescription.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Create minimal User objects for patient and doctor
        User patient = new User();
        patient.setId(rs.getInt("patient_id"));
        patient.setFullName(rs.getString("patient_name"));
        prescription.setPatient(patient);
        
        User doctor = new User();
        doctor.setId(rs.getInt("doctor_id"));
        doctor.setFullName(rs.getString("doctor_name"));
        prescription.setDoctor(doctor);
        
        return prescription;
    }
}
