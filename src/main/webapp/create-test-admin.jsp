<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Test Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>Create Test Admin</h1>
    
    <%
    // Get form parameters
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phone = request.getParameter("phone");
    
    if (name == null || email == null || password == null) {
        out.println("<p class='error'>Missing required parameters</p>");
    } else {
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if admin with this email already exists
            boolean adminExists = false;
            try (PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM admin WHERE Email = ?")) {
                pstmt.setString(1, email);
                try (ResultSet rs = pstmt.executeQuery()) {
                    adminExists = rs.next();
                }
            }
            
            if (adminExists) {
                out.println("<p class='error'>An admin with email '" + email + "' already exists</p>");
            } else {
                // Insert new admin
                String insertQuery = "INSERT INTO admin (Name, Email, Password, Phone) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertQuery)) {
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, password);
                    pstmt.setString(4, phone);
                    
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p class='success'>Admin created successfully!</p>");
                        out.println("<p>Name: " + name + "</p>");
                        out.println("<p>Email: " + email + "</p>");
                        out.println("<p>Password: " + password + "</p>");
                        out.println("<p>Phone: " + phone + "</p>");
                    } else {
                        out.println("<p class='error'>Failed to create admin</p>");
                    }
                }
            }
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
    }
    %>
    
    <p><a href="check-admin-table.jsp">Back to Admin Table</a></p>
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
