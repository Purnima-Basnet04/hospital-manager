package controller;

import dao.PatientDAO;
import model.Patient;

import java.sql.Date;
import java.util.List;

public class PatientController {

    private PatientDAO patientDAO;

    public PatientController() {
        patientDAO = new PatientDAO();
    }

    public boolean registerPatient(Patient patient) {
        return patientDAO.addPatient(patient);
    }

    public boolean registerPatient(String patientID, String fullName, String username, String email, String password,
                                  String gender, Date dateOfBirth, String phone, String bloodGroup, String address) {
        Patient patient = new Patient(patientID, fullName, username, email, password, gender, dateOfBirth, phone, bloodGroup, address);
        return patientDAO.addPatient(patient);
    }

    public boolean registerPatientWithDetails(String patientID, String fullName, String username, String email, String password,
                                  String gender, Date dateOfBirth, String phone, String bloodGroup, String address,
                                  String emergencyContact, String medicalHistory, String allergies) {
        Patient patient = new Patient(patientID, fullName, username, email, password, gender, dateOfBirth, phone, bloodGroup, address);
        patient.setEmergencyContact(emergencyContact);
        patient.setMedicalHistory(medicalHistory);
        patient.setAllergies(allergies);
        patient.setRole("PATIENT");
        patient.setRegistrationDate(new Date(System.currentTimeMillis()));
        patient.setActive(true);

        return patientDAO.addPatient(patient);
    }

    public Patient getPatientById(String id) {
        return patientDAO.getPatientById(id);
    }

    // For backward compatibility
    public Patient getPatientById(int id) {
        return patientDAO.getPatientById(String.valueOf(id));
    }

    public Patient getPatientByUsername(String username) {
        return patientDAO.getPatientByUsername(username);
    }

    public Patient getPatientByEmail(String email) {
        return patientDAO.getPatientByEmail(email);
    }

    public Patient authenticatePatient(String username, String password) {
        return patientDAO.authenticatePatient(username, password);
    }

    public List<Patient> getAllPatients() {
        return patientDAO.getAllPatients();
    }

    public boolean updatePatient(Patient patient) {
        return patientDAO.updatePatient(patient);
    }

    public boolean deletePatient(String id) {
        return patientDAO.deletePatient(id);
    }

    // For backward compatibility
    public boolean deletePatient(int id) {
        return patientDAO.deletePatient(String.valueOf(id));
    }
}