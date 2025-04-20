package dao;

import model.DoctorSchedule;
import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorScheduleDAO {

    // Add a new doctor schedule
    public boolean addDoctorSchedule(DoctorSchedule schedule) {
        String query = "INSERT INTO doctor_schedules (doctor_id, day_of_week, start_time, end_time, is_available) " +
                      "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, schedule.getDoctorId());
            pstmt.setString(2, schedule.getDayOfWeek());
            pstmt.setTime(3, schedule.getStartTime());
            pstmt.setTime(4, schedule.getEndTime());
            pstmt.setBoolean(5, schedule.isAvailable());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        schedule.setId(generatedKeys.getInt(1));
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

    // Get doctor schedule by ID
    public DoctorSchedule getDoctorScheduleById(int id) {
        String query = "SELECT ds.*, u.full_name as doctor_name FROM doctor_schedules ds " +
                      "JOIN users u ON ds.doctor_id = u.id WHERE ds.id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractDoctorScheduleFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Get doctor schedules by doctor ID
    public List<DoctorSchedule> getDoctorSchedulesByDoctorId(int doctorId) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        String query = "SELECT ds.*, u.full_name as doctor_name FROM doctor_schedules ds " +
                      "JOIN users u ON ds.doctor_id = u.id WHERE ds.doctor_id = ? " +
                      "ORDER BY FIELD(ds.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, doctorId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    schedules.add(extractDoctorScheduleFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return schedules;
    }

    // Get doctor schedules by day of week
    public List<DoctorSchedule> getDoctorSchedulesByDayOfWeek(String dayOfWeek) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        String query = "SELECT ds.*, u.full_name as doctor_name FROM doctor_schedules ds " +
                      "JOIN users u ON ds.doctor_id = u.id WHERE ds.day_of_week = ? AND ds.is_available = true " +
                      "ORDER BY ds.start_time";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, dayOfWeek);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    schedules.add(extractDoctorScheduleFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return schedules;
    }

    // Get all doctor schedules
    public List<DoctorSchedule> getAllDoctorSchedules() {
        List<DoctorSchedule> schedules = new ArrayList<>();
        String query = "SELECT ds.*, u.full_name as doctor_name FROM doctor_schedules ds " +
                      "JOIN users u ON ds.doctor_id = u.id " +
                      "ORDER BY ds.doctor_id, FIELD(ds.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                schedules.add(extractDoctorScheduleFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return schedules;
    }

    // Update doctor schedule
    public boolean updateDoctorSchedule(DoctorSchedule schedule) {
        String query = "UPDATE doctor_schedules SET doctor_id = ?, day_of_week = ?, start_time = ?, " +
                      "end_time = ?, is_available = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, schedule.getDoctorId());
            pstmt.setString(2, schedule.getDayOfWeek());
            pstmt.setTime(3, schedule.getStartTime());
            pstmt.setTime(4, schedule.getEndTime());
            pstmt.setBoolean(5, schedule.isAvailable());
            pstmt.setInt(6, schedule.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete doctor schedule
    public boolean deleteDoctorSchedule(int id) {
        String query = "DELETE FROM doctor_schedules WHERE id = ?";
        
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

    // Helper method to extract a doctor schedule from the ResultSet
    private DoctorSchedule extractDoctorScheduleFromResultSet(ResultSet rs) throws SQLException {
        DoctorSchedule schedule = new DoctorSchedule();
        schedule.setId(rs.getInt("id"));
        schedule.setDoctorId(rs.getInt("doctor_id"));
        schedule.setDayOfWeek(rs.getString("day_of_week"));
        schedule.setStartTime(rs.getTime("start_time"));
        schedule.setEndTime(rs.getTime("end_time"));
        schedule.setAvailable(rs.getBoolean("is_available"));
        
        // Create a minimal User object for the doctor
        User doctor = new User();
        doctor.setId(rs.getInt("doctor_id"));
        doctor.setFullName(rs.getString("doctor_name"));
        schedule.setDoctor(doctor);
        
        return schedule;
    }
}
