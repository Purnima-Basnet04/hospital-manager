<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is already logged in
    String userRole = (String) session.getAttribute("userRole");
    if (userRole != null) {
        // Redirect to appropriate dashboard based on role
        if (userRole.equals("ADMIN")) {
            response.sendRedirect("dashboard-admin.jsp");
            return;
        } else if (userRole.equals("DOCTOR")) {
            response.sendRedirect("dashboard-doctor.jsp");
            return;
        } else if (userRole.equals("PATIENT")) {
            response.sendRedirect("dashboard-patient.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - LifeCare Medical Center</title>
    <link rel="stylesheet" href="styles/main.css">
    <link rel="stylesheet" href="styles/login.css">
    <style>
        /* Basic styles for the login form */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .form-section {
            max-width: 500px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        h2 {
            text-align: center;
            color: #1a73e8;
            margin-bottom: 30px;
        }
        
        .error-message {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        
        select {
            height: 40px;
        }
        
        small {
            display: block;
            margin-top: 5px;
            color: #666;
            font-size: 12px;
        }
        
        .text-center {
            text-align: center;
        }
        
        .margin-top-lg {
            margin-top: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #0d5bbc;
        }
        
        .form-links {
            margin-top: 20px;
            text-align: center;
        }
        
        .form-links p {
            margin: 10px 0;
        }
        
        .form-links a {
            color: #1a73e8;
            text-decoration: none;
        }
        
        .form-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <section class="form-section">
            <h2>Login to Your Account</h2>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="error-message">
                    Invalid username or password. Please try again.
                </div>
            <% } %>
            
            <form action="login-handler.jsp" method="post" class="login-form">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <small>Enter your secure password</small>
                </div>
                
                <div class="form-group">
                    <label for="role">Login As:</label>
                    <select id="role" name="role" required>
                        <option value="">Select Role</option>
                        <option value="ADMIN">Admin</option>
                        <option value="DOCTOR">Doctor</option>
                        <option value="PATIENT">Patient</option>
                    </select>
                </div>
                
                <div class="form-group text-center margin-top-lg">
                    <button type="submit" class="btn">Login</button>
                </div>
                
                <div class="form-links">
                    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                    <p><a href="forgot-password.jsp">Forgot Password?</a></p>
                </div>
            </form>
        </section>
    </div>
</body>
</html>
