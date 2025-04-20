<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");
    String doctorID = (String) session.getAttribute("doctorID");
    String specialization = (String) session.getAttribute("specialization");
    String specialty = (String) session.getAttribute("specialty");
    String qualification = (String) session.getAttribute("qualification");
    String licenseNumber = (String) session.getAttribute("licenseNumber");

    // Debug information
    System.out.println("Doctor Dashboard - Session attributes:");
    System.out.println("Username: " + username);
    System.out.println("UserRole: " + userRole);
    System.out.println("FullName: " + fullName);
    System.out.println("DoctorID: " + doctorID);
    System.out.println("Specialization: " + specialization);

    if (username == null || userRole == null || !userRole.equals("DOCTOR")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Set attributes as page context attributes for EL access
    pageContext.setAttribute("username", username);
    pageContext.setAttribute("fullName", fullName != null ? fullName : username);
    pageContext.setAttribute("doctorID", doctorID != null ? doctorID : "Unknown");
    pageContext.setAttribute("specialization", specialization != null ? specialization : "Specialist");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Modern Layout CSS -->
    <link rel="stylesheet" type="text/css" href="../styles/modern-layout.css">
</head>
<body>
    <!-- Green Header Bar -->
    <div class="top-header"></div>

    <!-- Main Layout Container -->
    <div class="layout-container">
        <!-- Mobile Menu Toggle -->
        <button class="mobile-menu-toggle" style="display: none; position: fixed; top: 12px; left: 12px; z-index: 1000; background: none; border: none; font-size: 20px; color: var(--text-medium); cursor: pointer;">
            <i class="fas fa-bars"></i>
        </button>
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <a href="../index.jsp" class="logo">
                    <i class="fas fa-heartbeat"></i>
                    <span>LifeCare</span>
                </a>
            </div>

            <div class="sidebar-section">
                <div class="sidebar-section-title">MAIN</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="dashboard.jsp" class="sidebar-menu-link active">
                            <i class="fas fa-home sidebar-menu-icon"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="appointments.jsp" class="sidebar-menu-link">
                            <i class="fas fa-calendar-alt sidebar-menu-icon"></i>
                            Appointments
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="patients.jsp" class="sidebar-menu-link">
                            <i class="fas fa-user-injured sidebar-menu-icon"></i>
                            Patients
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="medical-records.jsp" class="sidebar-menu-link">
                            <i class="fas fa-notes-medical sidebar-menu-icon"></i>
                            Medical Records
                        </a>
                    </li>
                </ul>
            </div>

            <div class="sidebar-section">
                <div class="sidebar-section-title">MANAGEMENT</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="prescriptions.jsp" class="sidebar-menu-link">
                            <i class="fas fa-pills sidebar-menu-icon"></i>
                            Prescriptions
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="lab-reports.jsp" class="sidebar-menu-link">
                            <i class="fas fa-file-medical-alt sidebar-menu-icon"></i>
                            Lab Reports
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="schedule.jsp" class="sidebar-menu-link">
                            <i class="fas fa-clock sidebar-menu-icon"></i>
                            Schedule
                        </a>
                    </li>
                </ul>
            </div>

            <div class="sidebar-section">
                <div class="sidebar-section-title">ACCOUNT</div>
                <ul class="sidebar-menu">
                    <li class="sidebar-menu-item">
                        <a href="profile.jsp" class="sidebar-menu-link">
                            <i class="fas fa-user-md sidebar-menu-icon"></i>
                            Profile
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="settings.jsp" class="sidebar-menu-link">
                            <i class="fas fa-cog sidebar-menu-icon"></i>
                            Settings
                        </a>
                    </li>
                    <li class="sidebar-menu-item">
                        <a href="../logout.jsp" class="sidebar-menu-link">
                            <i class="fas fa-sign-out-alt sidebar-menu-icon"></i>
                            Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1 class="page-title">Welcome, Dr. <%= fullName %>!</h1>

            <!-- Stats Row -->
            <div class="stats-row">
                <div class="stat-card blue">
                    <div class="stat-number">8</div>
                    <div class="stat-label">Today's Appointments</div>
                    <i class="fas fa-calendar-check stat-icon"></i>
                </div>

                <div class="stat-card green">
                    <div class="stat-number">45</div>
                    <div class="stat-label">Total Patients</div>
                    <i class="fas fa-user-injured stat-icon"></i>
                </div>

                <div class="stat-card yellow">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Pending Reports</div>
                    <i class="fas fa-file-medical-alt stat-icon"></i>
                </div>

                <div class="stat-card red">
                    <div class="stat-number">120</div>
                    <div class="stat-label">Completed Appointments</div>
                    <i class="fas fa-check-circle stat-icon"></i>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2 class="section-title">Quick Actions</h2>

                <div class="action-buttons">
                    <a href="appointments.jsp" class="action-button">
                        <i class="fas fa-calendar-check action-icon"></i>
                        <span class="action-label">View Appointments</span>
                    </a>

                    <a href="add-prescription.jsp" class="action-button">
                        <i class="fas fa-prescription action-icon"></i>
                        <span class="action-label">Add Prescription</span>
                    </a>

                    <a href="add-medical-record.jsp" class="action-button">
                        <i class="fas fa-file-medical action-icon"></i>
                        <span class="action-label">Add Medical Record</span>
                    </a>

                    <a href="schedule.jsp" class="action-button">
                        <i class="fas fa-clock action-icon"></i>
                        <span class="action-label">Update Schedule</span>
                    </a>
                </div>
            </div>

            <!-- Today's Appointments -->
            <div class="table-container">
                <div class="table-header">
                    <h2 class="section-title">Today's Appointments</h2>
                    <a href="appointments.jsp" class="action-button" style="padding: 8px 16px; margin: 0;">
                        <i class="fas fa-plus" style="margin: 0 4px 0 0; font-size: 14px;"></i>
                        Add New
                    </a>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Patient</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>09:00 AM</td>
                            <td>John Doe</td>
                            <td>General Checkup</td>
                            <td><span class="status-badge scheduled">Scheduled</span></td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>10:30 AM</td>
                            <td>Jane Smith</td>
                            <td>Follow-up</td>
                            <td><span class="status-badge in-progress">In Progress</span></td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Recent Patients -->
            <div class="table-container">
                <div class="table-header">
                    <h2 class="section-title">Recent Patients</h2>
                    <div style="width: 300px;">
                        <input type="text" placeholder="Search patients..." style="width: 100%; padding: 8px; border-radius: 4px; border: 1px solid #dadce0;">
                    </div>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Last Visit</th>
                            <th>Contact</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>John Doe</td>
                            <td>2 days ago</td>
                            <td>123-456-7890</td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Jane Smith</td>
                            <td>1 week ago</td>
                            <td>987-654-3210</td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Robert Johnson</td>
                            <td>Today</td>
                            <td>555-123-4567</td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Mary Williams</td>
                            <td>3 days ago</td>
                            <td>555-987-6543</td>
                            <td>
                                <div class="table-actions">
                                    <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
                                    <button class="action-icon-btn edit"><i class="fas fa-edit"></i></button>
                                    <button class="action-icon-btn delete"><i class="fas fa-trash"></i></button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // Add any JavaScript functionality here
        document.addEventListener('DOMContentLoaded', function() {
            // Mobile menu functionality
            const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
            const sidebar = document.querySelector('.sidebar');

            // Function to check window size and show/hide mobile menu toggle
            function checkWindowSize() {
                if (window.innerWidth <= 768) {
                    mobileMenuToggle.style.display = 'block';
                    sidebar.classList.remove('active');
                } else {
                    mobileMenuToggle.style.display = 'none';
                    sidebar.classList.remove('active');
                }
            }

            // Initial check
            checkWindowSize();

            // Listen for window resize
            window.addEventListener('resize', checkWindowSize);

            // Toggle sidebar on mobile
            if (mobileMenuToggle) {
                mobileMenuToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                });
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                if (window.innerWidth <= 768 &&
                    sidebar.classList.contains('active') &&
                    !sidebar.contains(event.target) &&
                    !mobileMenuToggle.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            });

            // Initialize table actions
            const viewButtons = document.querySelectorAll('.action-icon-btn.view');
            const editButtons = document.querySelectorAll('.action-icon-btn.edit');
            const deleteButtons = document.querySelectorAll('.action-icon-btn.delete');

            viewButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const name = row.cells[1].textContent;
                    alert('Viewing details for ' + name);
                });
            });

            editButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const name = row.cells[1].textContent;
                    alert('Editing details for ' + name);
                });
            });

            deleteButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const row = this.closest('tr');
                    const name = row.cells[1].textContent;
                    if (confirm('Are you sure you want to delete ' + name + '?')) {
                        alert('Delete functionality would be implemented here');
                    }
                });
            });
        });
    </script>
</body>
</html>
