package controller;

import dao.DoctorDAO;
import model.Doctor;

import java.util.List;

public class DoctorController {

    private DoctorDAO doctorDAO;

    public DoctorController() {
        doctorDAO = new DoctorDAO();
    }

    public boolean addDoctor(Doctor doctor) {
        return doctorDAO.addDoctor(doctor);
    }

    public boolean addDoctor(String name, String specialization, String email,
                            String password, String phone) {
        Doctor doctor = new Doctor();
        doctor.setName(name);
        doctor.setSpecialization(specialization);
        doctor.setEmail(email);
        doctor.setPassword(password);
        doctor.setPhone(phone);
        return doctorDAO.addDoctor(doctor);
    }

    // Additional method for adding a doctor with specialty and other details
    public boolean addDoctorWithDetails(String name, String specialization, String email,
                            String password, String phone, String specialty, String qualification,
                            String licenseNumber, String availability, int departmentId) {
        Doctor doctor = new Doctor();
        doctor.setName(name);
        doctor.setSpecialization(specialization);
        doctor.setEmail(email);
        doctor.setPassword(password);
        doctor.setPhone(phone);
        doctor.setSpecialty(specialty);
        doctor.setQualification(qualification);
        doctor.setLicenseNumber(licenseNumber);
        doctor.setAvailability(availability);
        doctor.setDepartmentId(departmentId);

        return doctorDAO.addDoctor(doctor);
    }

    public Doctor getDoctorById(String id) {
        return doctorDAO.getDoctorById(id);
    }

    public Doctor getDoctorByEmail(String email) {
        return doctorDAO.getDoctorByEmail(email);
    }

    public Doctor authenticateDoctor(String email, String password) {
        return doctorDAO.authenticateDoctor(email, password);
    }

    public List<Doctor> getAllDoctors() {
        return doctorDAO.getAllDoctors();
    }

    public List<Doctor> getDoctorsByDepartment(int departmentId) {
        return doctorDAO.getDoctorsByDepartment(departmentId);
    }

    public boolean updateDoctor(Doctor doctor) {
        return doctorDAO.updateDoctor(doctor);
    }

    public boolean deleteDoctor(String id) {
        return doctorDAO.deleteDoctor(id);
    }
}