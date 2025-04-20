package controller;

import dao.DoctorScheduleDAO;
import model.DoctorSchedule;

import java.sql.Time;
import java.util.List;

public class DoctorScheduleController {
    
    private DoctorScheduleDAO doctorScheduleDAO;
    
    public DoctorScheduleController() {
        doctorScheduleDAO = new DoctorScheduleDAO();
    }
    
    // Add a new doctor schedule
    public boolean addDoctorSchedule(int doctorId, String dayOfWeek, Time startTime, Time endTime, boolean isAvailable) {
        DoctorSchedule schedule = new DoctorSchedule();
        schedule.setDoctorId(doctorId);
        schedule.setDayOfWeek(dayOfWeek);
        schedule.setStartTime(startTime);
        schedule.setEndTime(endTime);
        schedule.setAvailable(isAvailable);
        
        return doctorScheduleDAO.addDoctorSchedule(schedule);
    }
    
    // Get doctor schedule by ID
    public DoctorSchedule getDoctorScheduleById(int id) {
        return doctorScheduleDAO.getDoctorScheduleById(id);
    }
    
    // Get doctor schedules by doctor ID
    public List<DoctorSchedule> getDoctorSchedulesByDoctorId(int doctorId) {
        return doctorScheduleDAO.getDoctorSchedulesByDoctorId(doctorId);
    }
    
    // Get doctor schedules by day of week
    public List<DoctorSchedule> getDoctorSchedulesByDayOfWeek(String dayOfWeek) {
        return doctorScheduleDAO.getDoctorSchedulesByDayOfWeek(dayOfWeek);
    }
    
    // Get all doctor schedules
    public List<DoctorSchedule> getAllDoctorSchedules() {
        return doctorScheduleDAO.getAllDoctorSchedules();
    }
    
    // Update doctor schedule
    public boolean updateDoctorSchedule(int id, int doctorId, String dayOfWeek, Time startTime, Time endTime, boolean isAvailable) {
        DoctorSchedule schedule = doctorScheduleDAO.getDoctorScheduleById(id);
        if (schedule == null) {
            return false;
        }
        
        schedule.setDoctorId(doctorId);
        schedule.setDayOfWeek(dayOfWeek);
        schedule.setStartTime(startTime);
        schedule.setEndTime(endTime);
        schedule.setAvailable(isAvailable);
        
        return doctorScheduleDAO.updateDoctorSchedule(schedule);
    }
    
    // Delete doctor schedule
    public boolean deleteDoctorSchedule(int id) {
        return doctorScheduleDAO.deleteDoctorSchedule(id);
    }
}
