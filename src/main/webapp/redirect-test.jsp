<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirect Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #3498db;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            margin-right: 10px;
        }
        .info {
            background-color: #e8f4f8;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Redirect Test Page</h1>
        
        <div class="info">
            <h2>Session Information</h2>
            <p><strong>Username:</strong> <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Not logged in" %></p>
            <p><strong>User Role:</strong> <%= session.getAttribute("userRole") != null ? session.getAttribute("userRole") : "N/A" %></p>
            <p><strong>Full Name:</strong> <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "N/A" %></p>
        </div>
        
        <div class="info">
            <h2>Request Parameters</h2>
            <p><strong>Redirect Parameter:</strong> <%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "None" %></p>
        </div>
        
        <h2>Test Links</h2>
        <p>Click the links below to test the redirect functionality:</p>
        
        <a href="login.jsp?redirect=redirect-test.jsp" class="btn">Login with Redirect</a>
        <a href="book-appointment.jsp" class="btn">Book Appointment (Protected)</a>
        <a href="index.jsp" class="btn">Home Page</a>
        
        <% if (session.getAttribute("username") != null) { %>
        <a href="logout.jsp" class="btn">Logout</a>
        <% } %>
    </div>
</body>
</html>
