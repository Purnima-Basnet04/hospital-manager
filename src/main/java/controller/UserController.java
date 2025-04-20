package controller;

import dao.AdminDAO;
import dao.DoctorDAO;
import dao.UserDAO;
import model.Admin;
import model.Doctor;
import model.User;

import java.util.ArrayList;
import java.util.List;

public class UserController {

    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private AdminDAO adminDAO;

    public UserController() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        adminDAO = new AdminDAO();
    }

    // Register a new user (patient)
    public boolean registerUser(String username, String password, String fullName, String email,
                                String phone, String address, String role) {
        if ("PATIENT".equals(role)) {
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole(role);

            return userDAO.addUser(user);
        } else if ("DOCTOR".equals(role)) {
            Doctor doctor = new Doctor();
            doctor.setName(fullName);
            doctor.setEmail(email);
            doctor.setPassword(password);
            doctor.setPhone(phone);
            // Note: Specialization should be set by the caller before passing to this method

            return doctorDAO.addDoctor(doctor);
        } else if ("ADMIN".equals(role)) {
            Admin admin = new Admin();
            admin.setName(fullName);
            admin.setEmail(email);
            admin.setPassword(password);
            admin.setPhone(phone);

            return adminDAO.addAdmin(admin);
        }

        return false;
    }

    // Authenticate a user with username/email and password
    public Object authenticateUser(String username, String password) {
        // Try patient (user) first
        User user = userDAO.authenticateUser(username, password);
        if (user != null) {
            return user;
        }

        // Try doctor next
        Doctor doctor = doctorDAO.authenticateDoctor(username, password);
        if (doctor != null) {
            return doctor;
        }

        // Try admin last
        Admin admin = adminDAO.authenticateAdmin(username, password);
        if (admin != null) {
            return admin;
        }

        return null;
    }

    // Authenticate a user with username/email and password and specific role
    public Object authenticateUser(String username, String password, String role) {
        System.out.println("Authenticating user with role: " + role + ", username/email: " + username);

        if ("PATIENT".equals(role)) {
            // For patients, try both username and email
            User user = userDAO.authenticateUser(username, password);
            if (user != null) {
                return user;
            }
            // Try by email as fallback
            user = userDAO.authenticateUserByEmail(username, password);
            return user;
        } else if ("DOCTOR".equals(role)) {
            // For doctors, use email
            return doctorDAO.authenticateDoctor(username, password);
        } else if ("ADMIN".equals(role)) {
            // For admins, use email
            return adminDAO.authenticateAdmin(username, password);
        }

        return authenticateUser(username, password);
    }

    // Get user (patient) by ID
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    // Get user (patient) by username
    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    // Get all users (patients, doctors, admins)
    public List<Object> getAllUsers() {
        List<Object> allUsers = new ArrayList<>();

        // Add all patients
        allUsers.addAll(userDAO.getAllUsers());

        // Add all doctors
        allUsers.addAll(doctorDAO.getAllDoctors());

        // Add all admins
        allUsers.addAll(adminDAO.getAllAdmins());

        return allUsers;
    }

    // Get users by their role
    public List<?> getUsersByRole(String role) {
        if ("PATIENT".equals(role)) {
            return userDAO.getAllUsers();
        } else if ("DOCTOR".equals(role)) {
            return doctorDAO.getAllDoctors();
        } else if ("ADMIN".equals(role)) {
            return adminDAO.getAllAdmins();
        }

        return new ArrayList<>();
    }
}
