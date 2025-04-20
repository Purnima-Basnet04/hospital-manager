<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    String fullName = (String) session.getAttribute("fullName");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String address = (String) session.getAttribute("address");
    String specialization = (String) session.getAttribute("specialization");
    String experience = (String) session.getAttribute("experience");
    
    if (username == null || userRole == null || !userRole.equals("DOCTOR")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Set default values for missing profile information
    if (fullName == null || fullName.isEmpty()) fullName = username;
    if (email == null) email = "doctor@lifecare.com";
    if (phone == null) phone = "Not provided";
    if (address == null) address = "Not provided";
    if (specialization == null) specialization = "General Medicine";
    if (experience == null) experience = "5 years";
    
    // Set username as a page context attribute for EL access
    pageContext.setAttribute("username", username);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Profile - LifeCare Medical Center</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Clean Dashboard CSS -->
    <link rel="stylesheet" type="text/css" href="styles/clean-dashboard.css">
    
    <!-- Elegant Cards CSS -->
    <link rel="stylesheet" type="text/css" href="styles/elegant-cards.css">
    
    <style>
        .profile-container {
            background-color: var(--white);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            padding: var(--space-lg);
            margin-bottom: var(--space-xl);
        }
        
        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: var(--space-lg);
            padding-bottom: var(--space-lg);
            border-bottom: 1px solid var(--border-color);
        }
        
        .profile-avatar {
            width: 100px;
            height: 100px;
            background-color: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: 500;
            color: var(--white);
            margin-right: var(--space-lg);
        }
        
        .profile-info h2 {
            margin: 0 0 var(--space-xs);
            color: var(--text-dark);
            font-size: 24px;
        }
        
        .profile-info p {
            margin: 0;
            color: var(--text-medium);
        }
        
        .profile-tabs {
            display: flex;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: var(--space-lg);
        }
        
        .profile-tab {
            padding: var(--space-md) var(--space-lg);
            cursor: pointer;
            color: var(--text-medium);
            font-weight: 500;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .profile-tab.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }
        
        .profile-tab:hover {
            color: var(--primary-dark);
        }
        
        .profile-section {
            margin-bottom: var(--space-xl);
        }
        
        .profile-section h3 {
            margin-top: 0;
            margin-bottom: var(--space-md);
            color: var(--text-dark);
            font-size: 18px;
            font-weight: 600;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: var(--space-lg);
        }
        
        .info-item {
            margin-bottom: var(--space-md);
        }
        
        .info-label {
            font-size: 14px;
            color: var(--text-medium);
            margin-bottom: var(--space-xs);
        }
        
        .info-value {
            font-size: 16px;
            color: var(--text-dark);
            font-weight: 500;
        }
        
        .form-group {
            margin-bottom: var(--space-md);
        }
        
        .form-group label {
            display: block;
            margin-bottom: var(--space-xs);
            font-weight: 500;
            color: var(--text-medium);
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-sm);
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            outline: none;
        }
        
        .form-actions {
            display: flex;
            gap: var(--space-md);
            margin-top: var(--space-lg);
        }
    </style>
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
          <span class="notification-badge">3</span>
        </div>
        
        <div class="user-menu">
          <div class="user-avatar">
            <span><%= username.substring(0, 1).toUpperCase() %></span>
          </div>
          <span class="user-name">Dr. <%= username %></span>
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
            <a href="dashboard-doctor.jsp" class="menu-link">
              <i class="fas fa-home menu-icon"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-appointments.jsp" class="menu-link">
              <i class="fas fa-calendar-alt menu-icon"></i>
              <span>Appointments</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-patients.jsp" class="menu-link">
              <i class="fas fa-user-injured menu-icon"></i>
              <span>Patients</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-medical-records.jsp" class="menu-link">
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
            <a href="doctor-prescriptions.jsp" class="menu-link">
              <i class="fas fa-pills menu-icon"></i>
              <span>Prescriptions</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-lab-reports.jsp" class="menu-link">
              <i class="fas fa-file-medical-alt menu-icon"></i>
              <span>Lab Reports</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-schedule.jsp" class="menu-link">
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
            <a href="doctor-profile.jsp" class="menu-link active">
              <i class="fas fa-user-md menu-icon"></i>
              <span>Profile</span>
            </a>
          </li>
          <li class="menu-item">
            <a href="doctor-settings.jsp" class="menu-link">
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
    <div class="page-header">
      <h1>Doctor Profile</h1>
      <p>View and manage your profile information</p>
    </div>
    
    <div class="profile-container">
      <div class="profile-header">
        <div class="profile-avatar">
          <%= username.substring(0, 1).toUpperCase() %>
        </div>
        <div class="profile-info">
          <h2>Dr. <%= fullName %></h2>
          <p><%= specialization %> • <%= experience %> Experience</p>
        </div>
      </div>
      
      <div class="profile-tabs">
        <div class="profile-tab active">Personal Information</div>
        <div class="profile-tab">Professional Details</div>
        <div class="profile-tab">Account Settings</div>
      </div>
      
      <div class="profile-section">
        <h3>Personal Information</h3>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">Full Name</div>
            <div class="info-value">Dr. <%= fullName %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Email Address</div>
            <div class="info-value"><%= email %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Phone Number</div>
            <div class="info-value"><%= phone %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Address</div>
            <div class="info-value"><%= address %></div>
          </div>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Professional Details</h3>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-label">Specialization</div>
            <div class="info-value"><%= specialization %></div>
          </div>
          <div class="info-item">
            <div class="info-label">Experience</div>
            <div class="info-value"><%= experience %></div>
          </div>
          <div class="info-item">
            <div class="info-label">License Number</div>
            <div class="info-value">MD12345678</div>
          </div>
          <div class="info-item">
            <div class="info-label">Department</div>
            <div class="info-value">Cardiology</div>
          </div>
        </div>
      </div>
      
      <div class="profile-section">
        <h3>Edit Profile</h3>
        <form action="update-doctor-profile" method="post">
          <div class="info-grid">
            <div class="form-group">
              <label for="fullName">Full Name</label>
              <input type="text" id="fullName" name="fullName" class="form-control" value="<%= fullName %>">
            </div>
            <div class="form-group">
              <label for="email">Email Address</label>
              <input type="email" id="email" name="email" class="form-control" value="<%= email %>">
            </div>
            <div class="form-group">
              <label for="phone">Phone Number</label>
              <input type="tel" id="phone" name="phone" class="form-control" value="<%= phone %>">
            </div>
            <div class="form-group">
              <label for="address">Address</label>
              <input type="text" id="address" name="address" class="form-control" value="<%= address %>">
            </div>
            <div class="form-group">
              <label for="specialization">Specialization</label>
              <input type="text" id="specialization" name="specialization" class="form-control" value="<%= specialization %>">
            </div>
            <div class="form-group">
              <label for="experience">Experience</label>
              <input type="text" id="experience" name="experience" class="form-control" value="<%= experience %>">
            </div>
          </div>
          
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <button type="reset" class="btn btn-secondary">Cancel</button>
          </div>
        </form>
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
      
      // Profile tabs functionality
      const tabs = document.querySelectorAll('.profile-tab');
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
