package controller;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Admin;
import model.Doctor;
import model.User;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    private UserController userController;
    private DoctorController doctorController;
    private AdminController adminController;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        userController = new UserController();
        doctorController = new DoctorController();
        adminController = new AdminController();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the selected role
        String role = request.getParameter("role");
        if (role == null || role.isEmpty()) {
            role = "PATIENT"; // Default role if not specified
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String bloodGroup = request.getParameter("bloodGroup");
        String specialization = request.getParameter("specialization"); // For doctors

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=2");
            return;
        }

        // Convert date string to SQL Date
        Date dateOfBirth = null;
        try {
            if (dateOfBirthStr != null && !dateOfBirthStr.isEmpty()) {
                dateOfBirth = Date.valueOf(dateOfBirthStr);
            }
        } catch (IllegalArgumentException e) {
            response.sendRedirect("register.jsp?error=3");
            return;
        }

        boolean success = false;

        // Check for existing users based on role
        if ("PATIENT".equals(role)) {
            // Check if username already exists
            if (userController.getUserByUsername(username) != null) {
                response.sendRedirect("register.jsp?error=1");
                return;
            }

            // Create a new user (patient)
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            user.setGender(gender);
            user.setDob(dateOfBirth);
            user.setBloodGroup(bloodGroup);
            user.setRole("PATIENT");

            // Add the user to the database
            success = userController.registerUser(username, password, fullName, email, phone, address, role);

        } else if ("DOCTOR".equals(role)) {
            // Validate doctor-specific fields
            if (specialization == null || specialization.isEmpty()) {
                response.sendRedirect("register.jsp?error=5"); // Error code for missing specialization
                return;
            }

            // Check if email already exists
            if (doctorController.getDoctorByEmail(email) != null) {
                response.sendRedirect("register.jsp?error=1");
                return;
            }

            // Create a new doctor
            Doctor doctor = new Doctor();
            doctor.setName(fullName);
            doctor.setSpecialization(specialization);
            doctor.setEmail(email);
            doctor.setPassword(password);
            doctor.setPhone(phone);

            // Add the doctor to the database using the controller
            success = doctorController.addDoctor(doctor);

        } else if ("ADMIN".equals(role)) {
            // Check if email already exists
            if (adminController.getAdminByEmail(email) != null) {
                response.sendRedirect("register.jsp?error=1");
                return;
            }

            // Create a new admin
            Admin admin = new Admin();
            admin.setName(fullName);
            admin.setEmail(email);
            admin.setPassword(password);
            admin.setPhone(phone);

            // Add the admin to the database
            success = adminController.addAdmin(admin);
        }

        // Redirect to login if registration is successful, or show error message
        if (success) {
            response.sendRedirect("login.jsp?registered=1&role=" + role);
        } else {
            response.sendRedirect("register.jsp?error=4");
        }
    }
}
