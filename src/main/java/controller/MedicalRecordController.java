package controller;

import dao.MedicalRecordDAO;
import model.MedicalRecord;

import java.sql.Date;
import java.util.List;

public class MedicalRecordController {
    
    private MedicalRecordDAO medicalRecordDAO;
    
    public MedicalRecordController() {
        medicalRecordDAO = new MedicalRecordDAO();
    }
    
    // Add a new medical record
    public boolean addMedicalRecord(int patientId, int doctorId, int appointmentId, Date recordDate, 
                                   String diagnosis, String treatment, String prescription, 
                                   String notes, Date followUpDate) {
        MedicalRecord medicalRecord = new MedicalRecord();
        medicalRecord.setPatientId(patientId);
        medicalRecord.setDoctorId(doctorId);
        medicalRecord.setAppointmentId(appointmentId);
        medicalRecord.setRecordDate(recordDate);
        medicalRecord.setDiagnosis(diagnosis);
        medicalRecord.setTreatment(treatment);
        medicalRecord.setPrescription(prescription);
        medicalRecord.setNotes(notes);
        medicalRecord.setFollowUpDate(followUpDate);
        
        return medicalRecordDAO.addMedicalRecord(medicalRecord);
    }
    
    // Get medical record by ID
    public MedicalRecord getMedicalRecordById(int id) {
        return medicalRecordDAO.getMedicalRecordById(id);
    }
    
    // Get medical records by patient ID
    public List<MedicalRecord> getMedicalRecordsByPatientId(int patientId) {
        return medicalRecordDAO.getMedicalRecordsByPatientId(patientId);
    }
    
    // Get medical records by doctor ID
    public List<MedicalRecord> getMedicalRecordsByDoctorId(int doctorId) {
        return medicalRecordDAO.getMedicalRecordsByDoctorId(doctorId);
    }
    
    // Get medical record by appointment ID
    public MedicalRecord getMedicalRecordByAppointmentId(int appointmentId) {
        return medicalRecordDAO.getMedicalRecordByAppointmentId(appointmentId);
    }
    
    // Get all medical records
    public List<MedicalRecord> getAllMedicalRecords() {
        return medicalRecordDAO.getAllMedicalRecords();
    }
    
    // Update medical record
    public boolean updateMedicalRecord(int id, int patientId, int doctorId, int appointmentId, 
                                      Date recordDate, String diagnosis, String treatment, 
                                      String prescription, String notes, Date followUpDate) {
        MedicalRecord medicalRecord = medicalRecordDAO.getMedicalRecordById(id);
        if (medicalRecord == null) {
            return false;
        }
        
        medicalRecord.setPatientId(patientId);
        medicalRecord.setDoctorId(doctorId);
        medicalRecord.setAppointmentId(appointmentId);
        medicalRecord.setRecordDate(recordDate);
        medicalRecord.setDiagnosis(diagnosis);
        medicalRecord.setTreatment(treatment);
        medicalRecord.setPrescription(prescription);
        medicalRecord.setNotes(notes);
        medicalRecord.setFollowUpDate(followUpDate);
        
        return medicalRecordDAO.updateMedicalRecord(medicalRecord);
    }
    
    // Delete medical record
    public boolean deleteMedicalRecord(int id) {
        return medicalRecordDAO.deleteMedicalRecord(id);
    }
}
