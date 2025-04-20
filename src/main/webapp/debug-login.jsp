<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="controller.*, model.*, dao.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Debug Login</title>
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
        input[type="text"], input[type="password"], input[type="email"], select {
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
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            margin-bottom: 20px;
        }
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
        }
        .tab button:hover {
            background-color: #ddd;
        }
        .tab button.active {
            background-color: #ccc;
        }
        .tabcontent {
            display: none;
            padding: 6px 12px;
            border: 1px solid #ccc;
            border-top: none;
        }
    </style>
</head>
<body>
    <h1>Debug Login</h1>
    
    <div class="tab">
        <button class="tablinks active" onclick="openTab(event, 'TestLogin')">Test Login</button>
        <button class="tablinks" onclick="openTab(event, 'UserData')">User Data</button>
        <button class="tablinks" onclick="openTab(event, 'DoctorData')">Doctor Data</button>
        <button class="tablinks" onclick="openTab(event, 'AdminData')">Admin Data</button>
    </div>
    
    <div id="TestLogin" class="tabcontent" style="display: block;">
        <h2>Test Login</h2>
        <form method="post">
            <table>
                <tr>
                    <td>Username/Email:</td>
                    <td><input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="password" value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>" required></td>
                </tr>
                <tr>
                    <td>Role:</td>
                    <td>
                        <select name="role">
                            <option value="">Auto-detect</option>
                            <option value="PATIENT" <%= "PATIENT".equals(request.getParameter("role")) ? "selected" : "" %>>Patient</option>
                            <option value="DOCTOR" <%= "DOCTOR".equals(request.getParameter("role")) ? "selected" : "" %>>Doctor</option>
                            <option value="ADMIN" <%= "ADMIN".equals(request.getParameter("role")) ? "selected" : "" %>>Admin</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Test Login"></td>
                </tr>
            </table>
        </form>
        
        <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        if (username != null && password != null) {
            UserController userController = new UserController();
            Object userObj = null;
            
            out.println("<h3>Login Test Results:</h3>");
            
            if (role != null && !role.trim().isEmpty()) {
                // If role is specified, authenticate with that role
                userObj = userController.authenticateUser(username, password, role);
                out.println("<p>Testing login with role: " + role + "</p>");
            } else {
                // If no role is specified, try all roles
                userObj = userController.authenticateUser(username, password);
                out.println("<p>Testing login with auto-detect role</p>");
            }
            
            if (userObj != null) {
                out.println("<p class='success'>Login successful!</p>");
                
                if (userObj instanceof User) {
                    User user = (User) userObj;
                    out.println("<p>Logged in as PATIENT</p>");
                    out.println("<p>Patient ID: " + user.getPatientID() + "</p>");
                    out.println("<p>Name: " + user.getFullName() + "</p>");
                    out.println("<p>Username: " + user.getUsername() + "</p>");
                    out.println("<p>Email: " + user.getEmail() + "</p>");
                } else if (userObj instanceof Doctor) {
                    Doctor doctor = (Doctor) userObj;
                    out.println("<p>Logged in as DOCTOR</p>");
                    out.println("<p>Doctor ID: " + doctor.getDoctorID() + "</p>");
                    out.println("<p>Name: " + doctor.getName() + "</p>");
                    out.println("<p>Email: " + doctor.getEmail() + "</p>");
                    out.println("<p>Specialization: " + doctor.getSpecialization() + "</p>");
                } else if (userObj instanceof Admin) {
                    Admin admin = (Admin) userObj;
                    out.println("<p>Logged in as ADMIN</p>");
                    out.println("<p>Admin ID: " + admin.getAdminID() + "</p>");
                    out.println("<p>Name: " + admin.getName() + "</p>");
                    out.println("<p>Email: " + admin.getEmail() + "</p>");
                }
            } else {
                out.println("<p class='error'>Login failed!</p>");
                
                // Try to find the user in each table to help diagnose the issue
                UserDAO userDAO = new UserDAO();
                DoctorDAO doctorDAO = new DoctorDAO();
                AdminDAO adminDAO = new AdminDAO();
                
                User user = null;
                Doctor doctor = null;
                Admin admin = null;
                
                // Check if username exists in users table
                try {
                    user = userDAO.getUserByUsername(username);
                } catch (Exception e) {
                    out.println("<p class='error'>Error checking user: " + e.getMessage() + "</p>");
                }
                
                // Check if email exists in doctor table
                try {
                    doctor = doctorDAO.getDoctorByEmail(username);
                } catch (Exception e) {
                    out.println("<p class='error'>Error checking doctor: " + e.getMessage() + "</p>");
                }
                
                // Check if email exists in admin table
                try {
                    admin = adminDAO.getAdminByEmail(username);
                } catch (Exception e) {
                    out.println("<p class='error'>Error checking admin: " + e.getMessage() + "</p>");
                }
                
                out.println("<h4>User Existence Check:</h4>");
                out.println("<ul>");
                out.println("<li>Patient with username '" + username + "': " + (user != null ? "<span class='success'>Found</span>" : "<span class='error'>Not found</span>") + "</li>");
                out.println("<li>Doctor with email '" + username + "': " + (doctor != null ? "<span class='success'>Found</span>" : "<span class='error'>Not found</span>") + "</li>");
                out.println("<li>Admin with email '" + username + "': " + (admin != null ? "<span class='success'>Found</span>" : "<span class='error'>Not found</span>") + "</li>");
                out.println("</ul>");
                
                if (user != null || doctor != null || admin != null) {
                    out.println("<p>User exists but login failed. This is likely a password mismatch.</p>");
                } else {
                    out.println("<p>User does not exist in any table with the provided username/email.</p>");
                }
            }
        }
        %>
    </div>
    
    <div id="UserData" class="tabcontent">
        <h2>User (Patient) Data</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Password</th>
                <th>Gender</th>
                <th>Phone</th>
            </tr>
            <%
            UserController userController = new UserController();
            List<User> users = userController.getUsersByRole("PATIENT");
            
            if (users != null && !users.isEmpty()) {
                for (User user : users) {
            %>
                <tr>
                    <td><%= user.getPatientID() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPassword() %></td>
                    <td><%= user.getGender() != null ? user.getGender() : "" %></td>
                    <td><%= user.getPhone() != null ? user.getPhone() : "" %></td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="7" style="text-align:center;">No users found</td>
                </tr>
            <%
            }
            %>
        </table>
    </div>
    
    <div id="DoctorData" class="tabcontent">
        <h2>Doctor Data</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Specialization</th>
                <th>Email</th>
                <th>Password</th>
                <th>Phone</th>
            </tr>
            <%
            DoctorController doctorController = new DoctorController();
            List<Doctor> doctors = doctorController.getAllDoctors();
            
            if (doctors != null && !doctors.isEmpty()) {
                for (Doctor doctor : doctors) {
            %>
                <tr>
                    <td><%= doctor.getDoctorID() %></td>
                    <td><%= doctor.getName() %></td>
                    <td><%= doctor.getSpecialization() != null ? doctor.getSpecialization() : "" %></td>
                    <td><%= doctor.getEmail() %></td>
                    <td><%= doctor.getPassword() %></td>
                    <td><%= doctor.getPhone() != null ? doctor.getPhone() : "" %></td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="6" style="text-align:center;">No doctors found</td>
                </tr>
            <%
            }
            %>
        </table>
    </div>
    
    <div id="AdminData" class="tabcontent">
        <h2>Admin Data</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Password</th>
                <th>Phone</th>
            </tr>
            <%
            AdminController adminController = new AdminController();
            List<Admin> admins = adminController.getAllAdmins();
            
            if (admins != null && !admins.isEmpty()) {
                for (Admin admin : admins) {
            %>
                <tr>
                    <td><%= admin.getAdminID() %></td>
                    <td><%= admin.getName() %></td>
                    <td><%= admin.getEmail() %></td>
                    <td><%= admin.getPassword() %></td>
                    <td><%= admin.getPhone() != null ? admin.getPhone() : "" %></td>
                </tr>
            <%
                }
            } else {
            %>
                <tr>
                    <td colspan="5" style="text-align:center;">No admins found</td>
                </tr>
            <%
            }
            %>
        </table>
    </div>
    
    <p><a href="initialize-database.jsp">Initialize Database</a> | <a href="login.jsp">Go to Login Page</a></p>
    
    <script>
    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }
    </script>
</body>
</html>
