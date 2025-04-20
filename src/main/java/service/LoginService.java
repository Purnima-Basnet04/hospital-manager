package service;

import dao.AdminDAO;
import dao.DoctorDAO;
import dao.UserDAO;
import model.Admin;
import model.Doctor;
import model.User;

/**
 * Service class for handling login authentication
 */
public class LoginService {
    
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    private AdminDAO adminDAO;
    
    public LoginService() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
        adminDAO = new AdminDAO();
    }
    
    /**
     * Authenticate a user based on role
     * 
     * @param username Username or email
     * @param password Password
     * @param role Role (PATIENT, DOCTOR, ADMIN)
     * @return User object if authentication is successful, null otherwise
     */
    public Object authenticate(String username, String password, String role) {
        System.out.println("LoginService: Authenticating " + role + " with username/email: " + username);
        
        if (role == null || role.isEmpty()) {
            return authenticateAny(username, password);
        }
        
        switch (role) {
            case "PATIENT":
                return authenticatePatient(username, password);
            case "DOCTOR":
                return authenticateDoctor(username, password);
            case "ADMIN":
                return authenticateAdmin(username, password);
            default:
                return authenticateAny(username, password);
        }
    }
    
    /**
     * Authenticate a patient
     * 
     * @param username Username or email
     * @param password Password
     * @return User object if authentication is successful, null otherwise
     */
    public User authenticatePatient(String username, String password) {
        System.out.println("LoginService: Authenticating patient with username/email: " + username);
        
        // First try by username
        User user = userDAO.authenticateUser(username, password);
        if (user != null) {
            System.out.println("LoginService: Patient authenticated by username");
            return user;
        }
        
        // Then try by email
        user = userDAO.authenticateUserByEmail(username, password);
        if (user != null) {
            System.out.println("LoginService: Patient authenticated by email");
            return user;
        }
        
        System.out.println("LoginService: Patient authentication failed");
        return null;
    }
    
    /**
     * Authenticate a doctor
     * 
     * @param email Email
     * @param password Password
     * @return Doctor object if authentication is successful, null otherwise
     */
    public Doctor authenticateDoctor(String email, String password) {
        System.out.println("LoginService: Authenticating doctor with email: " + email);
        
        Doctor doctor = doctorDAO.authenticateDoctor(email, password);
        if (doctor != null) {
            System.out.println("LoginService: Doctor authenticated successfully");
            return doctor;
        }
        
        System.out.println("LoginService: Doctor authentication failed");
        return null;
    }
    
    /**
     * Authenticate an admin
     * 
     * @param email Email
     * @param password Password
     * @return Admin object if authentication is successful, null otherwise
     */
    public Admin authenticateAdmin(String email, String password) {
        System.out.println("LoginService: Authenticating admin with email: " + email);
        
        Admin admin = adminDAO.authenticateAdmin(email, password);
        if (admin != null) {
            System.out.println("LoginService: Admin authenticated successfully");
            return admin;
        }
        
        System.out.println("LoginService: Admin authentication failed");
        return null;
    }
    
    /**
     * Try to authenticate with any role
     * 
     * @param username Username or email
     * @param password Password
     * @return User object if authentication is successful, null otherwise
     */
    public Object authenticateAny(String username, String password) {
        System.out.println("LoginService: Trying to authenticate with any role");
        
        // Try patient first
        User user = authenticatePatient(username, password);
        if (user != null) {
            return user;
        }
        
        // Try doctor next
        Doctor doctor = authenticateDoctor(username, password);
        if (doctor != null) {
            return doctor;
        }
        
        // Try admin last
        Admin admin = authenticateAdmin(username, password);
        if (admin != null) {
            return admin;
        }
        
        System.out.println("LoginService: Authentication failed for all roles");
        return null;
    }
}
