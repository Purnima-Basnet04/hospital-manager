<%@ tag description="Dashboard template" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="true" rtexprvalue="true" %>
<%@ attribute name="userRole" required="true" rtexprvalue="true" %>
<%@ attribute name="userName" required="true" rtexprvalue="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="styles/dashboard.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/${pageContext.request.servletPath.substring(1).replace(".jsp", "")}.css">
</head>
<body>
    <div class="dashboard-container">
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>
                <h3>LifeCare Medical</h3>
            </div>

            <div class="user-profile">
                <div class="user-avatar">
                    ${userName.substring(0, 1).toUpperCase()}
                </div>
                <div class="user-info">
                    <h4>${userName}</h4>
                    <p>${userRole}</p>
                </div>
            </div>

            <nav class="sidebar-nav">
                <ul>
                    <!-- Common menu items -->
                    <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>

                    <!-- Role-specific menu items -->
                    <% if (userRole.equals("ADMIN")) { %>
                    <li><a href="dashboard-admin.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="admin-doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                    <li><a href="admin-patients.jsp"><i class="fas fa-user"></i> Patients</a></li>
                    <li><a href="admin-departments.jsp"><i class="fas fa-hospital"></i> Departments</a></li>
                    <li><a href="admin-appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li><a href="admin-reports.jsp"><i class="fas fa-chart-bar"></i> Reports</a></li>
                    <li><a href="admin-settings.jsp"><i class="fas fa-cog"></i> Settings</a></li>
                    <% } else if (userRole.equals("DOCTOR")) { %>
                    <li><a href="dashboard-doctor.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="doctor-appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                    <li><a href="doctor-patients.jsp"><i class="fas fa-user"></i> My Patients</a></li>
                    <li><a href="doctor-medical-records.jsp"><i class="fas fa-file-medical"></i> Medical Records</a></li>
                    <li><a href="doctor-prescriptions.jsp"><i class="fas fa-prescription"></i> Prescriptions</a></li>
                    <li><a href="doctor-schedule.jsp"><i class="fas fa-clock"></i> My Schedule</a></li>
                    <li><a href="doctor-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                    <% } else if (userRole.equals("PATIENT")) { %>
                    <li><a href="dashboard-patient.jsp" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="patient-appointments.jsp"><i class="fas fa-calendar-check"></i> My Appointments</a></li>
                    <li><a href="patient-prescriptions.jsp"><i class="fas fa-prescription"></i> My Prescriptions</a></li>
                    <li><a href="patient-medical-records.jsp"><i class="fas fa-file-medical"></i> Medical Records</a></li>
                    <li><a href="patient-doctors.jsp"><i class="fas fa-user-md"></i> Find Doctors</a></li>
                    <li><a href="patient-profile.jsp"><i class="fas fa-user-circle"></i> My Profile</a></li>
                    <% } %>

                    <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <header class="dashboard-header">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>

                <div class="header-actions">
                    <div class="notification-icon">
                        <i class="fas fa-bell"></i>
                        <span class="badge">3</span>
                    </div>

                    <div class="message-icon">
                        <i class="fas fa-envelope"></i>
                        <span class="badge">5</span>
                    </div>

                    <div class="user-dropdown">
                        <div class="user-avatar">
                            ${userName.substring(0, 1).toUpperCase()}
                        </div>
                        <div class="dropdown-content">
                            <a href="#"><i class="fas fa-user-circle"></i> My Profile</a>
                            <a href="#"><i class="fas fa-cog"></i> Settings</a>
                            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </div>
                </div>
            </header>

            <div class="content">
                <jsp:doBody/>
            </div>
        </main>
    </div>

    <!-- Common JavaScript -->
    <script src="js/common.js"></script>

    <!-- Dashboard JavaScript -->
    <script src="js/dashboard.js"></script>

    <!-- Page-specific JavaScript -->
    <script src="js/${pageContext.request.servletPath.substring(1).replace(".jsp", "")}.js"></script>
</body>
</html>