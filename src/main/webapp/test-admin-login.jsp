<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.*, model.*, dao.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Admin Login</title>
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
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        form {
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            padding: 8px;
            margin: 5px 0;
            width: 300px;
        }
        input[type="submit"] {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Test Admin Login</h1>
    
    <form method="post">
        <table>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "admin@example.com" %>" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "password" %>" required></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Test Login"></td>
            </tr>
        </table>
    </form>
    
    <%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (email != null && password != null) {
        AdminController adminController = new AdminController();
        
        // Test direct authentication
        Admin admin = adminController.authenticateAdmin(email, password);
        
        // Test through UserController
        UserController userController = new UserController();
        Object userObj = userController.authenticateUser(email, password, "ADMIN");
        
        out.println("<h2>Authentication Results:</h2>");
        
        out.println("<p>Direct Authentication: ");
        if (admin != null) {
            out.println("<span class='success'>Success</span>");
            out.println("<br>Admin ID: " + admin.getAdminID());
            out.println("<br>Name: " + admin.getName());
            out.println("<br>Email: " + admin.getEmail());
        } else {
            out.println("<span class='error'>Failed</span>");
        }
        out.println("</p>");
        
        out.println("<p>UserController Authentication: ");
        if (userObj != null) {
            out.println("<span class='success'>Success</span>");
            Admin adminFromUserController = (Admin) userObj;
            out.println("<br>Admin ID: " + adminFromUserController.getAdminID());
            out.println("<br>Name: " + adminFromUserController.getName());
            out.println("<br>Email: " + adminFromUserController.getEmail());
        } else {
            out.println("<span class='error'>Failed</span>");
        }
        out.println("</p>");
        
        // Show all admins in the database
        out.println("<h2>All Admins in Database:</h2>");
        out.println("<table>");
        out.println("<tr><th>ID</th><th>Name</th><th>Email</th><th>Password</th><th>Phone</th></tr>");
        
        for (Admin a : adminController.getAllAdmins()) {
            out.println("<tr>");
            out.println("<td>" + a.getAdminID() + "</td>");
            out.println("<td>" + a.getName() + "</td>");
            out.println("<td>" + a.getEmail() + "</td>");
            out.println("<td>" + a.getPassword() + "</td>");
            out.println("<td>" + a.getPhone() + "</td>");
            out.println("</tr>");
        }
        
        out.println("</table>");
    }
    %>
    
    <p><a href="check-admin-table.jsp">Back to Admin Table</a></p>
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
