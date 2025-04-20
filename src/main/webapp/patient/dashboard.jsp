<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");

    if (username == null || userRole == null || !userRole.equals("PATIENT")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard - LifeCare Medical Center</title>

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
          <span class="notification-badge">2</span>
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
            <a href="dashboard-patient.jsp" class="menu-link active">
              <i class="fas fa-home menu-icon"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-appointments.jsp" class="menu-link">
              <i class="fas fa-calendar-alt menu-icon"></i>
              <span>Appointments</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-medical-records.jsp" class="menu-link">
              <i class="fas fa-file-medical menu-icon"></i>
              <span>Medical Records</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-prescriptions.jsp" class="menu-link">
              <i class="fas fa-pills menu-icon"></i>
              <span>Prescriptions</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">Services</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="patient-doctors.jsp" class="menu-link">
              <i class="fas fa-user-md menu-icon"></i>
              <span>Find Doctor</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-lab-results.jsp" class="menu-link">
              <i class="fas fa-flask menu-icon"></i>
              <span>Lab Results</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-billing.jsp" class="menu-link">
              <i class="fas fa-file-invoice-dollar menu-icon"></i>
              <span>Billing</span>
            </a>
          </li>
        </ul>
      </div>

      <div class="menu-section">
        <div class="menu-title">Account</div>
        <ul class="menu-items">
          <li class="menu-item">
            <a href="patient-profile.jsp" class="menu-link">
              <i class="fas fa-user menu-icon"></i>
              <span>Profile</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="patient-settings.jsp" class="menu-link">
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
      <h1 class="welcome-title">Welcome, <%= username %>!</h1>
      <p class="welcome-subtitle">Here's your health dashboard</p>
    </div>

    <!-- Stats Row -->
    <div class="stats-row">
      <div class="stat-card primary">
        <div class="stat-content">
          <h3 class="stat-title">Upcoming Appointments</h3>
          <p class="stat-value">2</p>
        </div>
      </div>

      <div class="stat-card secondary">
        <div class="stat-content">
          <h3 class="stat-title">Prescriptions</h3>
          <p class="stat-value">5</p>
        </div>
      </div>

      <div class="stat-card accent">
        <div class="stat-content">
          <h3 class="stat-title">Medical Records</h3>
          <p class="stat-value">8</p>
        </div>
      </div>

      <div class="stat-card warning">
        <div class="stat-content">
          <h3 class="stat-title">Messages</h3>
          <p class="stat-value">3</p>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
      <h2 class="section-title">Quick Actions</h2>

      <div class="action-buttons">
        <a href="book-appointment.jsp" class="action-button">
          <i class="fas fa-calendar-plus action-icon"></i>
          <span class="action-label">Book Appointment</span>
        </a>

        <a href="patient-messages.jsp" class="action-button">
          <i class="fas fa-comment-medical action-icon"></i>
          <span class="action-label">Message Doctor</span>
        </a>

        <a href="refill-prescription.jsp" class="action-button">
          <i class="fas fa-file-prescription action-icon"></i>
          <span class="action-label">Refill Prescription</span>
        </a>

        <a href="emergency-contact.jsp" class="action-button">
          <i class="fas fa-ambulance action-icon"></i>
          <span class="action-label">Emergency Contact</span>
        </a>
      </div>
    </div>

    <!-- Upcoming Appointments -->
    <div class="appointments-section">
      <h2 class="section-title">
        Upcoming Appointments
        <a href="patient-appointments.jsp">View All</a>
      </h2>

      <div class="appointment-list">
        <div class="appointment-card upcoming">
          <div class="appointment-time">
            <div class="time-display">10:00 AM</div>
            <div class="date-display">June 15, 2023</div>
          </div>

          <div class="appointment-details">
            <h3 class="patient-name">Dr. Smith</h3>
            <p class="appointment-type">General Checkup</p>
          </div>

          <div class="appointment-actions">
            <button class="btn btn-sm btn-primary">Reschedule</button>
            <button class="btn btn-sm btn-secondary">Cancel</button>
          </div>
        </div>

        <div class="appointment-card upcoming">
          <div class="appointment-time">
            <div class="time-display">02:30 PM</div>
            <div class="date-display">June 20, 2023</div>
          </div>

          <div class="appointment-details">
            <h3 class="patient-name">Dr. Johnson</h3>
            <p class="appointment-type">Follow-up</p>
          </div>

          <div class="appointment-actions">
            <button class="btn btn-sm btn-primary">Reschedule</button>
            <button class="btn btn-sm btn-secondary">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Medical Records -->
    <div class="medical-records">
      <h2 class="section-title">
        Medical Records
        <a href="patient-medical-records.jsp">View All</a>
      </h2>

      <div class="record-tabs">
        <div class="record-tab active">All Records</div>
        <div class="record-tab">Lab Results</div>
        <div class="record-tab">Prescriptions</div>
        <div class="record-tab">Diagnoses</div>
      </div>

      <div class="record-list">
        <div class="record-item">
          <div class="record-icon">
            <i class="fas fa-file-medical"></i>
          </div>

          <div class="record-details">
            <h3 class="record-title">General Checkup</h3>
            <p class="record-date">June 1, 2023 - Dr. Smith</p>
          </div>

          <div class="record-actions">
            <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
            <button class="action-icon-btn"><i class="fas fa-download"></i></button>
          </div>
        </div>

        <div class="record-item">
          <div class="record-icon">
            <i class="fas fa-flask"></i>
          </div>

          <div class="record-details">
            <h3 class="record-title">Blood Test Results</h3>
            <p class="record-date">May 15, 2023 - Lab Department</p>
          </div>

          <div class="record-actions">
            <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
            <button class="action-icon-btn"><i class="fas fa-download"></i></button>
          </div>
        </div>

        <div class="record-item">
          <div class="record-icon">
            <i class="fas fa-pills"></i>
          </div>

          <div class="record-details">
            <h3 class="record-title">Prescription - Allergic Rhinitis</h3>
            <p class="record-date">May 15, 2023 - Dr. Johnson</p>
          </div>

          <div class="record-actions">
            <button class="action-icon-btn view"><i class="fas fa-eye"></i></button>
            <button class="action-icon-btn"><i class="fas fa-download"></i></button>
          </div>
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

      // Tab functionality
      const tabs = document.querySelectorAll('.record-tab');
      tabs.forEach(tab => {
        tab.addEventListener('click', function() {
          tabs.forEach(t => t.classList.remove('active'));
          this.classList.add('active');
        });
      });
    });
  </script>
</body>
</html>