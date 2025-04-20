<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.UserController, controller.PatientController, model.User, model.Patient, java.sql.Date" %>
<%
    // Get form parameters
    String fullName = request.getParameter("fullName");
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("gender");
    String dateOfBirthStr = request.getParameter("dateOfBirth");
    String bloodGroup = request.getParameter("bloodGroup");
    String emergencyContact = request.getParameter("emergencyContact");
    String address = request.getParameter("address");
    String medicalHistory = request.getParameter("medicalHistory");
    String allergies = request.getParameter("allergies");

    // Validate required fields
    if (fullName == null || username == null || email == null || password == null ||
        confirmPassword == null || phone == null || gender == null || dateOfBirthStr == null ||
        bloodGroup == null || emergencyContact == null || address == null ||
        fullName.isEmpty() || username.isEmpty() || email.isEmpty() || password.isEmpty() ||
        confirmPassword.isEmpty() || phone.isEmpty() || gender.isEmpty() || dateOfBirthStr.isEmpty() ||
        bloodGroup.isEmpty() || emergencyContact.isEmpty() || address.isEmpty()) {

        response.sendRedirect("register.jsp?error=missing");
        return;
    }

    // Check if passwords match
    if (!password.equals(confirmPassword)) {
        response.sendRedirect("register.jsp?error=2");
        return;
    }

    // Parse date of birth
    Date dateOfBirth = null;
    try {
        dateOfBirth = Date.valueOf(dateOfBirthStr);
    } catch (IllegalArgumentException e) {
        response.sendRedirect("register.jsp?error=3");
        return;
    }

    // Initialize controllers
    UserController userController = new UserController();
    PatientController patientController = new PatientController();

    // Check if username already exists
    if (userController.getUserByUsername(username) != null) {
        response.sendRedirect("register.jsp?error=1");
        return;
    }

    // Create a User object
    User user = new User();
    user.setUsername(username);
    user.setPassword(password);
    user.setFullName(fullName);
    user.setEmail(email);
    user.setPhone(phone);
    user.setAddress(address);
    user.setRole("PATIENT");
    user.setRegistrationDate(new Date(System.currentTimeMillis()));
    user.setActive(true);

    // Add the user
    boolean userAdded = userController.registerUser(username, password, fullName, email, phone, address, "PATIENT");

    if (!userAdded) {
        response.sendRedirect("register.jsp?error=4");
        return;
    }

    // Get the user ID
    User addedUser = userController.getUserByUsername(username);
    
    if (addedUser == null) {
        response.sendRedirect("register.jsp?error=4");
        return;
    }

    // Create a session for the user
    session.setAttribute("username", username);
    session.setAttribute("userRole", "PATIENT");
    session.setAttribute("fullName", fullName);
    session.setAttribute("userId", addedUser.getId());

    // Redirect to home page
    response.sendRedirect("home.jsp");
%>
