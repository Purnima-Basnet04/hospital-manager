<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Profile - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 0;
        }

        .navbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .logo i {
            font-size: 1.8rem;
            color: #3498db;
            margin-right: 10px;
        }

        .logo span {
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
        }

        .nav-links {
            display: flex;
            list-style: none;
        }

        .nav-links li {
            margin-left: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #2c3e50;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #3498db;
        }

        .nav-links .active {
            color: #3498db;
        }

        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            color: #2c3e50;
            cursor: pointer;
        }

        .profile-header {
            display: flex;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .profile-image {
            width: 300px;
            height: 300px;
            object-fit: cover;
        }

        .profile-info {
            padding: 30px;
            flex: 1;
        }

        .profile-name {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .profile-title {
            font-size: 1.2rem;
            color: #3498db;
            margin-bottom: 20px;
        }

        .profile-details {
            margin-bottom: 20px;
        }

        .profile-detail {
            display: flex;
            margin-bottom: 10px;
        }

        .detail-icon {
            width: 20px;
            margin-right: 10px;
            color: #3498db;
        }

        .profile-bio {
            margin-bottom: 20px;
            line-height: 1.8;
        }

        .profile-actions {
            display: flex;
            gap: 15px;
        }

        .action-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .action-btn:hover {
            background-color: #2980b9;
        }

        .action-btn.secondary {
            background-color: #ecf0f1;
            color: #2c3e50;
        }

        .action-btn.secondary:hover {
            background-color: #bdc3c7;
        }

        .profile-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
        }

        .profile-section {
            background-color: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #ecf0f1;
        }

        .education-item, .experience-item {
            margin-bottom: 20px;
        }

        .item-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .item-subtitle {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .item-date {
            color: #3498db;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }

        .item-description {
            font-size: 0.95rem;
        }

        .sidebar-section {
            background-color: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .schedule-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ecf0f1;
        }

        .schedule-day {
            font-weight: 500;
        }

        .schedule-time {
            color: #7f8c8d;
        }

        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .contact-icon {
            width: 40px;
            height: 40px;
            background-color: #ecf0f1;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: #3498db;
        }

        .contact-info {
            flex: 1;
        }

        .contact-label {
            font-size: 0.8rem;
            color: #7f8c8d;
        }

        .contact-value {
            font-weight: 500;
        }

        .social-links {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #ecf0f1;
            color: #3498db;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

        .social-link:hover {
            background-color: #3498db;
            color: white;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #3498db;
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .back-link i {
            margin-right: 5px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 992px) {
            .profile-header {
                flex-direction: column;
            }

            .profile-image {
                width: 100%;
                height: 300px;
            }

            .profile-content {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: block;
            }

            .nav-links {
                position: fixed;
                top: 70px;
                left: 0;
                right: 0;
                background-color: #fff;
                flex-direction: column;
                padding: 20px;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
                transform: translateY(-100%);
                opacity: 0;
                pointer-events: none;
                transition: transform 0.3s, opacity 0.3s;
                z-index: 100;
            }

            .nav-links.active {
                transform: translateY(0);
                opacity: 1;
                pointer-events: auto;
            }

            .nav-links li {
                margin: 15px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="navbar-container">
            <a href="index.jsp" class="logo">
                <i class="fas fa-heartbeat"></i>
                <span>LifeCare</span>
            </a>

            <button class="mobile-menu-toggle">
                <i class="fas fa-bars"></i>
            </button>

            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="our-doctors.jsp" class="active">Doctors</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <a href="our-doctors.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Doctors
        </a>

        <%
            // Get doctor ID from request parameter
            String doctorId = request.getParameter("id");

            // Default values
            String doctorName = "Doctor Name";
            String doctorTitle = "Specialization";
            String doctorImage = "images/doctors/doctor-placeholder.jpg";
            String doctorBio = "Doctor biography goes here.";
            String doctorEmail = "doctor@example.com";
            String doctorPhone = "(123) 456-7890";
            String doctorOffice = "Room 101, Main Building";

            // Set doctor information based on ID
            if (doctorId != null) {
                switch(doctorId) {
                    case "1":
                        doctorName = "Dr. James Wilson";
                        doctorTitle = "Chief Executive Officer";
                        doctorImage = "images/doctors/dr-james-wilson.jpg";
                        doctorBio = "Dr. James Wilson has over 25 years of experience in healthcare management and cardiology. He leads our medical center with a focus on patient-centered care and innovative medical practices.";
                        doctorEmail = "james.wilson@lifecaremedical.com";
                        doctorPhone = "(123) 456-7890";
                        doctorOffice = "Executive Suite, 3rd Floor";
                        break;
                    case "2":
                        doctorName = "Dr. Sarah Johnson";
                        doctorTitle = "Chief Medical Officer";
                        doctorImage = "images/doctors/dr-sarah-johnson.jpg";
                        doctorBio = "Dr. Sarah Johnson oversees all medical operations at LifeCare Medical Center. With her expertise in internal medicine, she ensures that our patients receive the highest quality of care.";
                        doctorEmail = "sarah.johnson@lifecaremedical.com";
                        doctorPhone = "(123) 456-7891";
                        doctorOffice = "Medical Suite, 2nd Floor";
                        break;
                    case "3":
                        doctorName = "Dr. Michael Chen";
                        doctorTitle = "Director of Operations";
                        doctorImage = "images/doctors/dr-michael-chen.jpg";
                        doctorBio = "Dr. Michael Chen manages the day-to-day operations of our medical facilities. His background in healthcare administration and medicine helps ensure smooth operations across all departments.";
                        doctorEmail = "michael.chen@lifecaremedical.com";
                        doctorPhone = "(123) 456-7892";
                        doctorOffice = "Operations Center, 1st Floor";
                        break;
                    case "4":
                        doctorName = "Ms. Emily Rodriguez";
                        doctorTitle = "Chief Nursing Officer";
                        doctorImage = "images/doctors/ms-emily-rodriguez.jpg";
                        doctorBio = "Ms. Emily Rodriguez brings extensive experience in nursing leadership and patient care to her role as Chief Nursing Officer. She is dedicated to maintaining the highest standards of nursing practice.";
                        doctorEmail = "emily.rodriguez@lifecaremedical.com";
                        doctorPhone = "(123) 456-7893";
                        doctorOffice = "Nursing Department, 2nd Floor";
                        break;
                    default:
                        // Use default values for unknown IDs
                }
            }
        %>

        <!-- Doctor Profile Header -->
        <div class="profile-header">
            <img src="<%= doctorImage %>" alt="<%= doctorName %>" class="profile-image">
            <div class="profile-info">
                <h1 class="profile-name"><%= doctorName %></h1>
                <p class="profile-title"><%= doctorTitle %></p>

                <div class="profile-details">
                    <div class="profile-detail">
                        <span class="detail-icon"><i class="fas fa-envelope"></i></span>
                        <span><%= doctorEmail %></span>
                    </div>
                    <div class="profile-detail">
                        <span class="detail-icon"><i class="fas fa-phone"></i></span>
                        <span><%= doctorPhone %></span>
                    </div>
                    <div class="profile-detail">
                        <span class="detail-icon"><i class="fas fa-map-marker-alt"></i></span>
                        <span><%= doctorOffice %></span>
                    </div>
                </div>

                <p class="profile-bio"><%= doctorBio %></p>

                <div class="profile-actions">
                    <a href="appointment.jsp?doctor=<%= doctorId %>" class="action-btn">Book Appointment</a>
                    <a href="contact.jsp?doctor=<%= doctorId %>" class="action-btn secondary">Contact</a>
                </div>
            </div>
        </div>

        <!-- Doctor Profile Content -->
        <div class="profile-content">
            <div class="main-content">
                <!-- Education Section -->
                <div class="profile-section">
                    <h2 class="section-title">Education & Qualifications</h2>

                    <div class="education-item">
                        <h3 class="item-title">Medical Degree</h3>
                        <p class="item-subtitle">Harvard Medical School</p>
                        <p class="item-date">2005 - 2009</p>
                        <p class="item-description">Graduated with honors in Medicine with a focus on Internal Medicine.</p>
                    </div>

                    <div class="education-item">
                        <h3 class="item-title">Residency</h3>
                        <p class="item-subtitle">Johns Hopkins Hospital</p>
                        <p class="item-date">2009 - 2012</p>
                        <p class="item-description">Completed residency program with specialization in Cardiology.</p>
                    </div>

                    <div class="education-item">
                        <h3 class="item-title">Fellowship</h3>
                        <p class="item-subtitle">Mayo Clinic</p>
                        <p class="item-date">2012 - 2014</p>
                        <p class="item-description">Advanced fellowship in Interventional Cardiology.</p>
                    </div>
                </div>

                <!-- Experience Section -->
                <div class="profile-section">
                    <h2 class="section-title">Professional Experience</h2>

                    <div class="experience-item">
                        <h3 class="item-title"><%= doctorTitle %></h3>
                        <p class="item-subtitle">LifeCare Medical Center</p>
                        <p class="item-date">2018 - Present</p>
                        <p class="item-description">Leading the medical center's operations and strategic initiatives.</p>
                    </div>

                    <div class="experience-item">
                        <h3 class="item-title">Head of Cardiology</h3>
                        <p class="item-subtitle">City General Hospital</p>
                        <p class="item-date">2014 - 2018</p>
                        <p class="item-description">Led the cardiology department and performed complex cardiac procedures.</p>
                    </div>
                </div>
            </div>

            <div class="sidebar">
                <!-- Schedule Section -->
                <div class="sidebar-section">
                    <h2 class="section-title">Schedule</h2>

                    <div class="schedule-item">
                        <span class="schedule-day">Monday</span>
                        <span class="schedule-time">9:00 AM - 5:00 PM</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Tuesday</span>
                        <span class="schedule-time">9:00 AM - 5:00 PM</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Wednesday</span>
                        <span class="schedule-time">9:00 AM - 5:00 PM</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Thursday</span>
                        <span class="schedule-time">9:00 AM - 5:00 PM</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Friday</span>
                        <span class="schedule-time">9:00 AM - 3:00 PM</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Saturday</span>
                        <span class="schedule-time">Closed</span>
                    </div>
                    <div class="schedule-item">
                        <span class="schedule-day">Sunday</span>
                        <span class="schedule-time">Closed</span>
                    </div>
                </div>

                <!-- Contact Section -->
                <div class="sidebar-section">
                    <h2 class="section-title">Contact Information</h2>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="contact-info">
                            <div class="contact-label">Email</div>
                            <div class="contact-value"><%= doctorEmail %></div>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="contact-info">
                            <div class="contact-label">Phone</div>
                            <div class="contact-value"><%= doctorPhone %></div>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="contact-info">
                            <div class="contact-label">Office</div>
                            <div class="contact-value"><%= doctorOffice %></div>
                        </div>
                    </div>

                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    </div>
                </div>

                <!-- Specialties Section -->
                <div class="sidebar-section">
                    <h2 class="section-title">Specialties</h2>

                    <ul style="list-style-type: none; padding-left: 0;">
                        <li style="margin-bottom: 10px;"><i class="fas fa-check" style="color: #3498db; margin-right: 10px;"></i> Cardiology</li>
                        <li style="margin-bottom: 10px;"><i class="fas fa-check" style="color: #3498db; margin-right: 10px;"></i> Internal Medicine</li>
                        <li style="margin-bottom: 10px;"><i class="fas fa-check" style="color: #3498db; margin-right: 10px;"></i> Healthcare Management</li>
                        <li style="margin-bottom: 10px;"><i class="fas fa-check" style="color: #3498db; margin-right: 10px;"></i> Preventive Care</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
            const navLinks = document.querySelector('.nav-links');

            mobileMenuToggle.addEventListener('click', function() {
                navLinks.classList.toggle('active');
            });

            // Close mobile menu when clicking outside
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.navbar-container')) {
                    navLinks.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>
