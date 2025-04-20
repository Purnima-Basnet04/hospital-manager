<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.AdminController, model.Admin" %>
<%
    // This is a simple script to add an admin account
    // Only run this once to create the admin account
    
    // Create admin controller
    AdminController adminController = new AdminController();
    
    // Check if admin with email "raju" already exists
    Admin existingAdmin = adminController.getAdminByEmail("raju");
    
    if (existingAdmin != null) {
        out.println("<h2>Admin with email 'raju' already exists!</h2>");
        out.println("<p>ID: " + existingAdmin.getAdminID() + "</p>");
        out.println("<p>Name: " + existingAdmin.getName() + "</p>");
        out.println("<p>Email: " + existingAdmin.getEmail() + "</p>");
    } else {
        // Create a new admin
        boolean success = adminController.addAdmin("Admin User", "raju", "password", "123-456-7890");
        
        if (success) {
            out.println("<h2>Admin account created successfully!</h2>");
            out.println("<p>Email: raju</p>");
            out.println("<p>Password: password</p>");
            out.println("<p>You can now log in with these credentials.</p>");
        } else {
            out.println("<h2>Failed to create admin account!</h2>");
            out.println("<p>Please check the server logs for more information.</p>");
        }
    }
%>
<p><a href="login.jsp">Go to Login Page</a></p>
