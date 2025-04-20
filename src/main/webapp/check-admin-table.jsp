<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Admin Table</title>
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
    </style>
</head>
<body>
    <h1>Admin Table Information</h1>
    
    <%
    try (Connection conn = DatabaseConnection.getConnection()) {
        // Display the current schema of the admin table
        out.println("<h2>Admin Table Schema:</h2>");
        out.println("<pre>");
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("DESCRIBE admin")) {
            out.println("Field\t\tType\t\tNull\tKey\tDefault\tExtra");
            out.println("-------------------------------------------------------------");
            while (rs.next()) {
                out.println(rs.getString(1) + "\t\t" + 
                           rs.getString(2) + "\t\t" + 
                           rs.getString(3) + "\t" + 
                           rs.getString(4) + "\t" + 
                           rs.getString(5) + "\t" + 
                           rs.getString(6));
            }
        } catch (SQLException e) {
            out.println("Error describing admin table: " + e.getMessage());
        }
        out.println("</pre>");
        
        // Display the current data in the admin table
        out.println("<h2>Admin Table Data:</h2>");
        out.println("<table>");
        out.println("<tr><th>AdminID</th><th>Name</th><th>Email</th><th>Password</th><th>Phone</th></tr>");
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM admin")) {
            
            boolean hasData = false;
            
            while (rs.next()) {
                hasData = true;
                out.println("<tr>");
                out.println("<td>" + rs.getInt("AdminID") + "</td>");
                out.println("<td>" + rs.getString("Name") + "</td>");
                out.println("<td>" + rs.getString("Email") + "</td>");
                out.println("<td>" + rs.getString("Password") + "</td>");
                out.println("<td>" + rs.getString("Phone") + "</td>");
                out.println("</tr>");
            }
            
            if (!hasData) {
                out.println("<tr><td colspan='5' style='text-align:center;'>No data found in admin table</td></tr>");
            }
        } catch (SQLException e) {
            out.println("<tr><td colspan='5' style='color:red;'>Error retrieving admin data: " + e.getMessage() + "</td></tr>");
        }
        out.println("</table>");
        
        // Add a form to create a test admin
        out.println("<h2>Create Test Admin</h2>");
        out.println("<form method='post' action='create-test-admin.jsp'>");
        out.println("<table>");
        out.println("<tr><td>Name:</td><td><input type='text' name='name' value='Test Admin' required></td></tr>");
        out.println("<tr><td>Email:</td><td><input type='email' name='email' value='admin@example.com' required></td></tr>");
        out.println("<tr><td>Password:</td><td><input type='text' name='password' value='password' required></td></tr>");
        out.println("<tr><td>Phone:</td><td><input type='text' name='phone' value='123-456-7890'></td></tr>");
        out.println("<tr><td colspan='2'><input type='submit' value='Create Admin'></td></tr>");
        out.println("</table>");
        out.println("</form>");
        
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
    %>
    
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
