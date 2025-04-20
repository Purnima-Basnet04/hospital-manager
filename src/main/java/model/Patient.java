package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Patient extends User {
    private String patientID;
    private String fullName;
    private String username;
    private String email;
    private String password;
    private String gender;
    private Date dob;
    private String phone;
    private String bloodGroup;
    private String address;
    private Timestamp createdAt;
    private Timestamp lastLogin;

    // Additional patient-specific fields
    private String emergencyContact;
    private String medicalHistory;
    private String allergies;

    // Constructors
    public Patient() {
        super();
    }

    public Patient(String patientID, String fullName, String username, String email, String password,
                  String gender, Date dob, String phone, String bloodGroup, String address) {
        this.patientID = patientID;
        this.fullName = fullName;
        this.username = username;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.dob = dob;
        this.phone = phone;
        this.bloodGroup = bloodGroup;
        this.address = address;

        // Set User properties for compatibility
        super.setUsername(username);
        super.setFullName(fullName);
        super.setEmail(email);
        super.setPassword(password);
        super.setPhone(phone);
        super.setAddress(address);
        super.setGender(gender);
        super.setDob(dob);
        super.setBloodGroup(bloodGroup);
        super.setRole("PATIENT");
    }

    // Getters and Setters for patient table fields
    public String getPatientIDString() {
        return patientID;
    }

    public void setPatientIDString(String patientID) {
        this.patientID = patientID;
    }

    // Override the User class method to maintain compatibility
    @Override
    public void setPatientID(int patientID) {
        this.patientID = String.valueOf(patientID);
        super.setPatientID(patientID);
    }

    @Override
    public int getPatientID() {
        try {
            return Integer.parseInt(patientID);
        } catch (NumberFormatException e) {
            return 0; // Default value if patientID is not a valid integer
        }
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
        super.setFullName(fullName); // Update User property
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
        super.setUsername(username); // Update User property
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
        super.setEmail(email); // Update User property
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
        super.setPassword(password); // Update User property
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
        super.setGender(gender); // Update User property
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
        super.setDob(dob); // Update User property
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
        super.setPhone(phone); // Update User property
    }

    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
        super.setBloodGroup(bloodGroup); // Update User property
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
        super.setAddress(address); // Update User property
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Timestamp lastLogin) {
        this.lastLogin = lastLogin;
    }

    // Getters and Setters for additional fields
    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getMedicalHistory() {
        return medicalHistory;
    }

    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }

    public String getAllergies() {
        return allergies;
    }

    public void setAllergies(String allergies) {
        this.allergies = allergies;
    }

    // These methods are needed for backward compatibility
    private String role;
    private Date registrationDate;
    private boolean active;

    public void setRole(String role) {
        this.role = role;
        super.setRole(role);
    }

    public String getRole() {
        return this.role;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public Date getRegistrationDate() {
        return this.registrationDate;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isActive() {
        return this.active;
    }
}