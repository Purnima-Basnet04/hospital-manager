<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");

    if (username == null || userRole == null || !userRole.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Clean Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="styles/clean-dashboard.css">

    <!-- Elegant Cards CSS -->
    <link rel="stylesheet" type="text/css" href="styles/elegant-cards.css">
</head>
<body>
  <!-- Header -->
  <header class="dashboard-header">
    <div class="header-container">
      <div style="display: flex; align-items: center;">
        <button class="mobile-menu-toggle" style="display: none; margin-right: 10px; background: none; border: none; font-size: 20px; color: var(--text-medium); cursor: pointer;">
          <i class="fas fa-bars"></i>
        </button>
        <a href="index.jsp" class="logo">
          <i class="fas fa-heartbeat"></i>
          <span>LifeCare</span>
        </a>
      </div>

      <div class="header-actions">
        <div class="notification-icon">
          <i class="far fa-bell"></i>
          <span class="notification-badge">5</span>
        </div>

        <div class="user-menu">
          <div class="user-avatar">
            <span><%= username.substring(0, 1).toUpperCase() %></span>
          </div>
          <span class="user-name"><%= username %></span>
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
            <a href="dashboard-admin.jsp" class="menu-link active">
              <i class="fas fa-home menu-icon"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-doctors.jsp" class="menu-link">
              <i class="fas fa-user-md menu-icon"></i>
              <span>Doctors</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-patients.jsp" class="menu-link">
              <i class="fas fa-user-injured menu-icon"></i>
              <span>Patients</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-appointments.jsp" class="menu-link">
              <i class="fas fa-calendar-alt menu-icon"></i>
              <span>Appointments</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">Management</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="admin-departments.jsp" class="menu-link">
              <i class="fas fa-hospital menu-icon"></i>
              <span>Departments</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-billing.jsp" class="menu-link">
              <i class="fas fa-file-invoice-dollar menu-icon"></i>
              <span>Billing</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-reports.jsp" class="menu-link">
              <i class="fas fa-chart-bar menu-icon"></i>
              <span>Reports</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">System</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="admin-users.jsp" class="menu-link">
              <i class="fas fa-users menu-icon"></i>
              <span>Users</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="admin-settings.jsp" class="menu-link">
              <i class="fas fa-cog menu-icon"></i>
              <span>Settings</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="logout.jsp" class="menu-link">
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
      <h1 class="welcome-title">Admin Dashboard</h1>
      <p class="welcome-subtitle">Hospital management system overview</p>
    </div>

    <!-- Stats Row -->
    <div class="admin-stats">
      <div class="admin-stat-card primary">
        <i class="fas fa-user-md stat-icon-bg"></i>
        <h2 class="stat-number">25</h2>
        <p class="stat-label">Total Doctors</p>
      </div>

      <div class="admin-stat-card secondary">
        <i class="fas fa-user-injured stat-icon-bg"></i>
        <h2 class="stat-number">150</h2>
        <p class="stat-label">Total Patients</p>
      </div>

      <div class="admin-stat-card accent">
        <i class="fas fa-calendar-check stat-icon-bg"></i>
        <h2 class="stat-number">42</h2>
        <p class="stat-label">Today's Appointments</p>
      </div>

      <div class="admin-stat-card warning">
        <i class="fas fa-hospital stat-icon-bg"></i>
        <h2 class="stat-number">8</h2>
        <p class="stat-label">Departments</p>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
      <h2 class="section-title">Quick Actions</h2>

      <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/add-doctor.jsp" class="action-button">
          <i class="fas fa-user-plus action-icon"></i>
          <span class="action-label">Add Doctor</span>
        </a>

        <a href="${pageContext.request.contextPath}/add-patient.jsp" class="action-button">
          <i class="fas fa-user-plus action-icon"></i>
          <span class="action-label">Add Patient</span>
        </a>

        <a href="${pageContext.request.contextPath}/add-department.jsp" class="action-button">
          <i class="fas fa-plus-circle action-icon"></i>
          <span class="action-label">Add Department</span>
        </a>

        <a href="${pageContext.request.contextPath}/generate-reports.jsp" class="action-button">
          <i class="fas fa-file-invoice action-icon"></i>
          <span class="action-label">Generate Report</span>
        </a>
      </div>
    </div>

    <!-- Recent Appointments -->
    <div class="data-table-container">
      <div class="table-header">
        <h2 class="section-title">Recent Appointments</h2>
        <a href="${pageContext.request.contextPath}/manage-appointments.jsp" class="btn btn-primary">
          <i class="fas fa-plus"></i> Add New
        </a>
      </div>

      <table class="data-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Patient</th>
            <th>Doctor</th>
            <th>Date & Time</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>John Doe</td>
            <td>Dr. Smith</td>
            <td>2023-06-10, 10:00 AM</td>
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
            <td>2</td>
            <td>Jane Smith</td>
            <td>Dr. Johnson</td>
            <td>2023-06-10, 11:30 AM</td>
            <td><span class="status-badge active">Completed</span></td>
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
          Showing 1 to 2 of 42 entries
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
            <th>Email</th>
            <th>Phone</th>
            <th>Registration Date</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>John Doe</td>
            <td>john@example.com</td>
            <td>123-456-7890</td>
            <td>2023-06-01</td>
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
            <td>jane@example.com</td>
            <td>987-654-3210</td>
            <td>2023-06-05</td>
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
          Showing 1 to 2 of 150 entries
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
    });
  </script>
</body>
</html>