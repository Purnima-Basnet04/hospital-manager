package model;

public class Doctor {
    private int doctorID;
    private String name;
    private String specialization;
    private String email;
    private String phone;
    private String password; // Not in DB schema, but needed for authentication

    // Additional fields not in the schema but useful for the application
    private String specialty;
    private String qualification;
    private String licenseNumber;
    private String availability;
    private int departmentId;

    // Constructors
    public Doctor() {
    }

    public Doctor(int doctorID, String name, String specialization, String email, String phone) {
        this.doctorID = doctorID;
        this.name = name;
        this.specialization = specialization;
        this.email = email;
        this.phone = phone;
    }

    // Getters and Setters
    public int getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(int doctorID) {
        this.doctorID = doctorID;
    }

    public String getDoctorIDString() {
        return String.valueOf(doctorID);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // For compatibility with authentication system
    public String getRole() {
        return "DOCTOR";
    }

    // For compatibility with session attributes
    public String getFullName() {
        return name;
    }

    // Getters and Setters for additional doctor-specific fields
    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }
}