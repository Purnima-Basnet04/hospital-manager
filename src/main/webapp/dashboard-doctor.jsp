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
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Clean Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="../styles/clean-dashboard.css">

    <!-- Elegant Cards CSS -->
    <link rel="stylesheet" type="text/css" href="../styles/elegant-cards.css">

    <!-- Admin Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="../styles/admin-dashboard.css">
</head>
<body>
  <!-- Header -->
  <header class="dashboard-header">
    <div class="header-container">
      <div style="display: flex; align-items: center;">
        <button class="mobile-menu-toggle" style="display: none; margin-right: 10px; background: none; border: none; font-size: 20px; color: var(--text-medium); cursor: pointer;">
          <i class="fas fa-bars"></i>
        </button>
        <a href="../index.jsp" class="logo">
          <i class="fas fa-heartbeat"></i>
          <span>LifeCare</span>
        </a>
      </div>

      <div class="header-actions">
        <div class="notification-icon">
          <i class="far fa-bell"></i>
          <span class="notification-badge">3</span>
        </div>

        <div class="user-menu">
          <div class="user-avatar">
            <span><%= fullName.substring(0, 1).toUpperCase() %></span>
          </div>
          <div style="display: flex; flex-direction: column;">
            <span class="user-name">Dr. <%= fullName %></span>
            <span style="font-size: 0.8rem; color: var(--text-light);"><%= specialization %></span>
          </div>
        </div>
      </div>
    </div>
  </header>

  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="sidebar-menu">
      <div class="menu-section">
        <div class="menu-title">Main</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="dashboard.jsp" class="menu-link active">
              <i class="fas fa-home menu-icon"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="appointments.jsp" class="menu-link">
              <i class="fas fa-calendar-alt menu-icon"></i>
              <span>Appointments</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patients.jsp" class="menu-link">
              <i class="fas fa-user-injured menu-icon"></i>
              <span>Patients</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="medical-records.jsp" class="menu-link">
              <i class="fas fa-notes-medical menu-icon"></i>
              <span>Medical Records</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">Management</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="prescriptions.jsp" class="menu-link">
              <i class="fas fa-pills menu-icon"></i>
              <span>Prescriptions</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="lab-reports.jsp" class="menu-link">
              <i class="fas fa-file-medical-alt menu-icon"></i>
              <span>Lab Reports</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="schedule.jsp" class="menu-link">
              <i class="fas fa-clock menu-icon"></i>
              <span>Schedule</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">Account</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="profile.jsp" class="menu-link">
              <i class="fas fa-user-md menu-icon"></i>
              <span>Profile</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="settings.jsp" class="menu-link">
              <i class="fas fa-cog menu-icon"></i>
              <span>Settings</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="../logout.jsp" class="menu-link">
              <i class="fas fa-sign-out-alt menu-icon"></i>
              <span>Logout</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </aside>

  <!-- Main Content -->
  <main class="main-content">
    <!-- Welcome Section -->
    <div class="doctor-welcome">
      <div>
        <h1 class="welcome-title">Welcome, Dr. <%= fullName %>!</h1>
        <p class="welcome-subtitle"><%= specialization %> | ID: <%= doctorID %></p>
        <p class="welcome-subtitle">Here's your dashboard overview for today</p>
      </div>
    </div>

    <!-- Stats Row (Admin Style) -->
    <div class="admin-stats">
      <div class="admin-stat-card primary">
        <i class="fas fa-calendar-check stat-icon-bg"></i>
        <h2 class="stat-number">8</h2>
        <p class="stat-label">Today's Appointments</p>
      </div>

      <div class="admin-stat-card secondary">
        <i class="fas fa-user-injured stat-icon-bg"></i>
        <h2 class="stat-number">45</h2>
        <p class="stat-label">Total Patients</p>
      </div>

      <div class="admin-stat-card accent">
        <i class="fas fa-file-medical-alt stat-icon-bg"></i>
        <h2 class="stat-number">3</h2>
        <p class="stat-label">Pending Reports</p>
      </div>

      <div class="admin-stat-card warning">
        <i class="fas fa-check-circle stat-icon-bg"></i>
        <h2 class="stat-number">120</h2>
        <p class="stat-label">Completed Appointments</p>
      </div>
    </div>

    <!-- Quick Actions (Admin Style) -->
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
    <div class="data-table-container">
      <div class="table-header">
        <h2 class="section-title">Today's Appointments</h2>
        <a href="appointments.jsp" class="btn btn-primary">
          <i class="fas fa-plus"></i> Add New
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
            <td><span class="status-badge pending">Scheduled</span></td>
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
            <td><span class="status-badge active">In Progress</span></td>
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

      <div class="pagination">
        <div class="pagination-info">
          Showing 1 to 2 of 8 entries
        </div>
        <div class="pagination-controls">
          <button class="page-btn"><i class="fas fa-angle-left"></i></button>
          <button class="page-btn active">1</button>
          <button class="page-btn">2</button>
          <button class="page-btn"><i class="fas fa-angle-right"></i></button>
        </div>
      </div>
    </div>

    <!-- Recent Patients -->
    <div class="data-table-container">
      <div class="table-header">
        <h2 class="section-title">Recent Patients</h2>
        <div class="patient-search" style="width: 300px; margin-bottom: 0;">
          <input type="text" class="search-input" placeholder="Search patients...">
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

      <div class="pagination">
        <div class="pagination-info">
          Showing 1 to 4 of 45 entries
        </div>
        <div class="pagination-controls">
          <button class="page-btn"><i class="fas fa-angle-left"></i></button>
          <button class="page-btn active">1</button>
          <button class="page-btn">2</button>
          <button class="page-btn">3</button>
          <button class="page-btn">4</button>
          <button class="page-btn">5</button>
          <button class="page-btn"><i class="fas fa-angle-right"></i></button>
        </div>
      </div>
    </div>
  </main>

  <script>
    // Mobile menu functionality
    document.addEventListener('DOMContentLoaded', function() {
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
          const id = row.cells[0].textContent;
          const name = row.cells[1].textContent;
          alert('Viewing details for ' + name + ' (ID: ' + id + ')');
        });
      });

      editButtons.forEach(button => {
        button.addEventListener('click', function() {
          const row = this.closest('tr');
          const id = row.cells[0].textContent;
          const name = row.cells[1].textContent;
          alert('Editing ' + name + ' (ID: ' + id + ')');
        });
      });

      deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
          const row = this.closest('tr');
          const id = row.cells[0].textContent;
          const name = row.cells[1].textContent;
          if (confirm('Are you sure you want to delete ' + name + ' (ID: ' + id + ')?')) {
            alert('Delete functionality would be implemented here');
          }
        });
      });
    });
  </script>
</body>
</html>