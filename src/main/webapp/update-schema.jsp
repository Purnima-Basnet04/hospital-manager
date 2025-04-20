<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Database Schema</title>
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
    </style>
</head>
<body>
    <h1>Database Schema Update</h1>
    
    <%
    try (Connection conn = DatabaseConnection.getConnection()) {
        // Check if Password column exists in doctor table
        boolean passwordColumnExists = false;
        try (ResultSet rs = conn.getMetaData().getColumns(null, null, "doctor", "Password")) {
            passwordColumnExists = rs.next();
        }
        
        if (!passwordColumnExists) {
            // Add Password column to doctor table
            String alterDoctorTable = "ALTER TABLE doctor ADD COLUMN Password varchar(255) NOT NULL DEFAULT 'password'";
            try (Statement stmt = conn.createStatement()) {
                stmt.executeUpdate(alterDoctorTable);
                out.println("<p class='success'>Successfully added Password column to doctor table.</p>");
            }
        } else {
            out.println("<p>Password column already exists in doctor table.</p>");
        }
        
        // Display the current schema of the doctor table
        out.println("<h2>Current Doctor Table Schema:</h2>");
        out.println("<pre>");
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("DESCRIBE doctor")) {
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
            out.println("Error describing doctor table: " + e.getMessage());
        }
        out.println("</pre>");
        
        // Display the current data in the doctor table
        out.println("<h2>Current Doctor Table Data:</h2>");
        out.println("<pre>");
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM doctor")) {
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();
            
            // Print column headers
            for (int i = 1; i <= columnCount; i++) {
                out.print(metaData.getColumnName(i) + "\t");
            }
            out.println("\n-------------------------------------------------------------");
            
            // Print data rows
            while (rs.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    out.print(rs.getString(i) + "\t");
                }
                out.println();
            }
        } catch (SQLException e) {
            out.println("Error retrieving doctor data: " + e.getMessage());
        }
        out.println("</pre>");
        
    } catch (Exception e) {
        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
    %>
    
    <p><a href="login.jsp">Go to Login Page</a></p>
</body>
</html>
