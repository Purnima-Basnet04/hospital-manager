package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class Prescription {
    private int id;
    private int medicalRecordId;
    private int patientId;
    private int doctorId;
    private Date prescriptionDate;
    private String status; // Active, Completed, Cancelled
    private String notes;
    private Timestamp createdAt;
    
    // References to related objects
    private MedicalRecord medicalRecord;
    private User patient;
    private User doctor;
    private List<PrescriptionItem> prescriptionItems;
    
    // Constructors
    public Prescription() {}
    
    public Prescription(int id, int medicalRecordId, int patientId, int doctorId, Date prescriptionDate, 
                       String status, String notes, Timestamp createdAt) {
        this.id = id;
        this.medicalRecordId = medicalRecordId;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.prescriptionDate = prescriptionDate;
        this.status = status;
        this.notes = notes;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getMedicalRecordId() {
        return medicalRecordId;
    }
    
    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }
    
    public int getPatientId() {
        return patientId;
    }
    
    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }
    
    public int getDoctorId() {
        return doctorId;
    }
    
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    
    public Date getPrescriptionDate() {
        return prescriptionDate;
    }
    
    public void setPrescriptionDate(Date prescriptionDate) {
        this.prescriptionDate = prescriptionDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public MedicalRecord getMedicalRecord() {
        return medicalRecord;
    }
    
    public void setMedicalRecord(MedicalRecord medicalRecord) {
        this.medicalRecord = medicalRecord;
    }
    
    public User getPatient() {
        return patient;
    }
    
    public void setPatient(User patient) {
        this.patient = patient;
    }
    
    public User getDoctor() {
        return doctor;
    }
    
    public void setDoctor(User doctor) {
        this.doctor = doctor;
    }
    
    public List<PrescriptionItem> getPrescriptionItems() {
        return prescriptionItems;
    }
    
    public void setPrescriptionItems(List<PrescriptionItem> prescriptionItems) {
        this.prescriptionItems = prescriptionItems;
    }
}
