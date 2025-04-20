package dao;

import model.PrescriptionItem;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionItemDAO {

    // Add a new prescription item
    public boolean addPrescriptionItem(PrescriptionItem item) {
        String query = "INSERT INTO prescription_items (prescription_id, medication_name, dosage, frequency, duration, instructions) " +
                      "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, item.getPrescriptionId());
            pstmt.setString(2, item.getMedicationName());
            pstmt.setString(3, item.getDosage());
            pstmt.setString(4, item.getFrequency());
            pstmt.setString(5, item.getDuration());
            pstmt.setString(6, item.getInstructions());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        item.setId(generatedKeys.getInt(1));
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

    // Get prescription item by ID
    public PrescriptionItem getPrescriptionItemById(int id) {
        String query = "SELECT * FROM prescription_items WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractPrescriptionItemFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get prescription items by prescription ID
    public List<PrescriptionItem> getPrescriptionItemsByPrescriptionId(int prescriptionId) {
        List<PrescriptionItem> items = new ArrayList<>();
        String query = "SELECT * FROM prescription_items WHERE prescription_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, prescriptionId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    items.add(extractPrescriptionItemFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return items;
    }

    // Update prescription item
    public boolean updatePrescriptionItem(PrescriptionItem item) {
        String query = "UPDATE prescription_items SET prescription_id = ?, medication_name = ?, dosage = ?, " +
                      "frequency = ?, duration = ?, instructions = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, item.getPrescriptionId());
            pstmt.setString(2, item.getMedicationName());
            pstmt.setString(3, item.getDosage());
            pstmt.setString(4, item.getFrequency());
            pstmt.setString(5, item.getDuration());
            pstmt.setString(6, item.getInstructions());
            pstmt.setInt(7, item.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete prescription item
    public boolean deletePrescriptionItem(int id) {
        String query = "DELETE FROM prescription_items WHERE id = ?";
        
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

    // Delete all prescription items for a prescription
    public boolean deletePrescriptionItemsByPrescriptionId(int prescriptionId) {
        String query = "DELETE FROM prescription_items WHERE prescription_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, prescriptionId);
            
            pstmt.executeUpdate();
            return true;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to extract a prescription item from the ResultSet
    private PrescriptionItem extractPrescriptionItemFromResultSet(ResultSet rs) throws SQLException {
        PrescriptionItem item = new PrescriptionItem();
        item.setId(rs.getInt("id"));
        item.setPrescriptionId(rs.getInt("prescription_id"));
        item.setMedicationName(rs.getString("medication_name"));
        item.setDosage(rs.getString("dosage"));
        item.setFrequency(rs.getString("frequency"));
        item.setDuration(rs.getString("duration"));
        item.setInstructions(rs.getString("instructions"));
        return item;
    }
}
