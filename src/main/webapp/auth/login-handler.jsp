<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.UserController, model.User, model.Doctor, model.Admin" %>
<%
    // Get parameters from request
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String redirect = request.getParameter("redirect");

    // Validate parameters
    if (username == null || username.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=missing" + (redirect != null ? "&redirect=" + redirect : ""));
        return;
    }

    // Authenticate user based on role
    UserController userController = new UserController();
    Object userObj = null;

    // Get client IP address
    String ipAddress = request.getRemoteAddr();

    System.out.println("Login attempt - Username: " + username + ", Role: " + (role != null ? role : "not specified"));

    if (role != null && !role.trim().isEmpty()) {
        // If role is specified, authenticate with that role
        userObj = userController.authenticateUser(username, password, role);
    } else {
        // If no role is specified, try all roles
        userObj = userController.authenticateUser(username, password);

        // Get the role from the user object
        if (userObj != null) {
            if (userObj instanceof User) {
                role = "PATIENT";
            } else if (userObj instanceof Doctor) {
                role = "DOCTOR";
            } else if (userObj instanceof Admin) {
                role = "ADMIN";
            }
        }
    }

    if (userObj != null) {
        // Set common session attributes
        session.setAttribute("username", username);
        session.setAttribute("userRole", role);

        // Set role-specific attributes
        if (role.equals("PATIENT")) {
            User user = (User) userObj;
            String userId = String.valueOf(user.getPatientID());
            session.setAttribute("userId", userId);
            session.setAttribute("patientID", userId);
            session.setAttribute("fullName", user.getFullName());

            // Store any other patient-specific attributes
            if (user.getBloodGroup() != null) {
                session.setAttribute("bloodGroup", user.getBloodGroup());
            }
            if (user.getGender() != null) {
                session.setAttribute("gender", user.getGender());
            }

            System.out.println("Patient login successful - ID: " + userId + ", Name: " + user.getFullName());

        } else if (role.equals("DOCTOR")) {
            Doctor doctor = (Doctor) userObj;
            String doctorId = String.valueOf(doctor.getDoctorID());
            session.setAttribute("userId", doctorId);
            session.setAttribute("doctorID", doctorId);
            session.setAttribute("fullName", doctor.getFullName());
            session.setAttribute("specialization", doctor.getSpecialization());

            System.out.println("Doctor login successful - ID: " + doctorId + ", Name: " + doctor.getName() + ", Specialization: " + doctor.getSpecialization());

            // Store any other doctor-specific attributes
            if (doctor.getSpecialty() != null) {
                session.setAttribute("specialty", doctor.getSpecialty());
            }
            if (doctor.getQualification() != null) {
                session.setAttribute("qualification", doctor.getQualification());
            }
            if (doctor.getLicenseNumber() != null) {
                session.setAttribute("licenseNumber", doctor.getLicenseNumber());
            }

        } else if (role.equals("ADMIN")) {
            Admin admin = (Admin) userObj;
            String adminId = String.valueOf(admin.getAdminID());
            session.setAttribute("userId", adminId);
            session.setAttribute("adminID", adminId);
            session.setAttribute("fullName", admin.getFullName());

            System.out.println("Admin login successful - ID: " + adminId + ", Name: " + admin.getName());
        }

        // Log successful login in console
        System.out.println("User " + username + " logged in successfully with role " + role);

        // Set session timeout (30 minutes)
        session.setMaxInactiveInterval(30 * 60);

        // Redirect to the specified page or home page after successful login
        if (redirect != null && !redirect.trim().isEmpty()) {
            response.sendRedirect(redirect);
        } else {
            // Redirect based on role
            if (role.equals("ADMIN")) {
                response.sendRedirect("../admin/dashboard.jsp");
            } else if (role.equals("DOCTOR")) {
                response.sendRedirect("../doctor/dashboard.jsp");
            } else {
                response.sendRedirect("../patient/dashboard.jsp");
            }
        }
    } else {
        // Authentication failed
        String errorParam = "error=auth";
        if (role != null && !role.trim().isEmpty()) {
            errorParam += "&role=" + role; // Include the role in the error redirect

            // Log failed login attempt with role
            System.out.println("Failed login attempt for username/email: " + username + " with role: " + role);
        } else {
            // Log failed login attempt without role
            System.out.println("Failed login attempt for username/email: " + username + " with no role specified");
        }

        response.sendRedirect("login.jsp?" + errorParam + (redirect != null ? "&redirect=" + redirect : ""));
    }
%>
