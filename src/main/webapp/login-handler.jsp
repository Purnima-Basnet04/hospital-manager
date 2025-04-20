<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.UserController, model.User, model.Doctor, model.Admin, service.LoginService" %>
<%
    // Get parameters from request
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String redirect = request.getParameter("redirect");

    // Log the received parameters (except password)
    System.out.println("Login parameters - Username: " + username + ", Role: " + role + ", Redirect: " + redirect);

    // Validate parameters
    if (username == null || username.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {
        response.sendRedirect("login.jsp?error=missing" + (redirect != null ? "&redirect=" + redirect : ""));
        return;
    }

    // Authenticate user based on role
    LoginService loginService = new LoginService();
    Object userObj = null;

    // Get client IP address
    String ipAddress = request.getRemoteAddr();

    System.out.println("Login attempt - Username: " + username + ", Role: " + (role != null ? role : "not specified"));

    // First check the role and then call the relevant authenticate function
    if (role != null && !role.trim().isEmpty()) {
        // If role is specified, authenticate with that role directly
        switch (role) {
            case "PATIENT":
                userObj = loginService.authenticatePatient(username, password);
                break;
            case "DOCTOR":
                userObj = loginService.authenticateDoctor(username, password);
                break;
            case "ADMIN":
                userObj = loginService.authenticateAdmin(username, password);
                break;
            default:
                userObj = loginService.authenticateAny(username, password);
                break;
        }
    } else {
        // If no role is specified, try all roles
        userObj = loginService.authenticateAny(username, password);

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
            session.setAttribute("fullName", doctor.getName());
            session.setAttribute("specialization", doctor.getSpecialization());

            System.out.println("Doctor login successful - ID: " + doctorId + ", Name: " + doctor.getName() + ", Specialization: " + doctor.getSpecialization());

            // Store any other doctor-specific attributes if available
            // These are commented out as they may not be available in your Doctor model
            // Uncomment if you add these fields to your Doctor model
            /*
            if (doctor.getSpecialty() != null) {
                session.setAttribute("specialty", doctor.getSpecialty());
            }
            if (doctor.getQualification() != null) {
                session.setAttribute("qualification", doctor.getQualification());
            }
            if (doctor.getLicenseNumber() != null) {
                session.setAttribute("licenseNumber", doctor.getLicenseNumber());
            }
            */

        } else if (role.equals("ADMIN")) {
            Admin admin = (Admin) userObj;
            String adminId = String.valueOf(admin.getAdminID());
            session.setAttribute("userId", adminId);
            session.setAttribute("adminID", adminId);
            session.setAttribute("fullName", admin.getName());

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
                response.sendRedirect("dashboard-admin.jsp");
            } else if (role.equals("DOCTOR")) {
                response.sendRedirect("dashboard-doctor.jsp");
            } else {
                response.sendRedirect("dashboard-patient.jsp");
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
