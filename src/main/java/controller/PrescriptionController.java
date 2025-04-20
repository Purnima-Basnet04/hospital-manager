package controller;

import dao.PrescriptionDAO;
import dao.PrescriptionItemDAO;
import model.Prescription;
import model.PrescriptionItem;

import java.sql.Date;
import java.util.List;

public class PrescriptionController {
    
    private PrescriptionDAO prescriptionDAO;
    private PrescriptionItemDAO prescriptionItemDAO;
    
    public PrescriptionController() {
        prescriptionDAO = new PrescriptionDAO();
        prescriptionItemDAO = new PrescriptionItemDAO();
    }
    
    // Add a new prescription
    public boolean addPrescription(int medicalRecordId, int patientId, int doctorId, Date prescriptionDate, 
                                  String notes, List<PrescriptionItem> items) {
        Prescription prescription = new Prescription();
        prescription.setMedicalRecordId(medicalRecordId);
        prescription.setPatientId(patientId);
        prescription.setDoctorId(doctorId);
        prescription.setPrescriptionDate(prescriptionDate);
        prescription.setStatus("Active");
        prescription.setNotes(notes);
        prescription.setPrescriptionItems(items);
        
        return prescriptionDAO.addPrescription(prescription);
    }
    
    // Add a prescription item
    public boolean addPrescriptionItem(int prescriptionId, String medicationName, String dosage, 
                                      String frequency, String duration, String instructions) {
        PrescriptionItem item = new PrescriptionItem();
        item.setPrescriptionId(prescriptionId);
        item.setMedicationName(medicationName);
        item.setDosage(dosage);
        item.setFrequency(frequency);
        item.setDuration(duration);
        item.setInstructions(instructions);
        
        return prescriptionItemDAO.addPrescriptionItem(item);
    }
    
    // Get prescription by ID
    public Prescription getPrescriptionById(int id) {
        return prescriptionDAO.getPrescriptionById(id);
    }
    
    // Get prescriptions by patient ID
    public List<Prescription> getPrescriptionsByPatientId(int patientId) {
        return prescriptionDAO.getPrescriptionsByPatientId(patientId);
    }
    
    // Get prescriptions by doctor ID
    public List<Prescription> getPrescriptionsByDoctorId(int doctorId) {
        return prescriptionDAO.getPrescriptionsByDoctorId(doctorId);
    }
    
    // Get prescriptions by medical record ID
    public List<Prescription> getPrescriptionsByMedicalRecordId(int medicalRecordId) {
        return prescriptionDAO.getPrescriptionsByMedicalRecordId(medicalRecordId);
    }
    
    // Get all prescriptions
    public List<Prescription> getAllPrescriptions() {
        return prescriptionDAO.getAllPrescriptions();
    }
    
    // Get prescription items by prescription ID
    public List<PrescriptionItem> getPrescriptionItemsByPrescriptionId(int prescriptionId) {
        return prescriptionItemDAO.getPrescriptionItemsByPrescriptionId(prescriptionId);
    }
    
    // Update prescription
    public boolean updatePrescription(int id, int medicalRecordId, int patientId, int doctorId, 
                                     Date prescriptionDate, String status, String notes, 
                                     List<PrescriptionItem> items) {
        Prescription prescription = prescriptionDAO.getPrescriptionById(id);
        if (prescription == null) {
            return false;
        }
        
        prescription.setMedicalRecordId(medicalRecordId);
        prescription.setPatientId(patientId);
        prescription.setDoctorId(doctorId);
        prescription.setPrescriptionDate(prescriptionDate);
        prescription.setStatus(status);
        prescription.setNotes(notes);
        prescription.setPrescriptionItems(items);
        
        return prescriptionDAO.updatePrescription(prescription);
    }
    
    // Update prescription status
    public boolean updatePrescriptionStatus(int id, String status) {
        return prescriptionDAO.updatePrescriptionStatus(id, status);
    }
    
    // Delete prescription
    public boolean deletePrescription(int id) {
        return prescriptionDAO.deletePrescription(id);
    }
}
