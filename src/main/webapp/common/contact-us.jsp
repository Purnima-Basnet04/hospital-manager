<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        username = "Guest";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/contact-us.css">
</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo-container">
                <div class="logo">
                    <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>
                <h1>LifeCare Medical Center</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="about-us.jsp">About Us</a></li>
                    <li><a href="contact-us.jsp" class="active">Contact</a></li>
                    <% if (username.equals("Guest")) { %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                    <% } else { %>
                    <li><a href="home.jsp">Dashboard</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                    <% } %>
                </ul>
            </nav>
        </div>
    </header>

    <main>

        <!-- Hero Section -->
        <section class="contact-hero">
            <h2>Contact Us</h2>
            <p>We're here to help. Reach out to us with any questions, concerns, or feedback.</p>
        </section>

        <!-- Contact Information and Form Section -->
        <div class="contact-section">
            <!-- Contact Information -->
            <div class="contact-info">
                <h3>Get in Touch</h3>
                <div class="contact-details">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="contact-text">
                            <h4>Address</h4>
                            <p>123 Medical Avenue, Healthcare City</p>
                            <p>State, Country - 12345</p>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <div class="contact-text">
                            <h4>Phone</h4>
                            <p>Main: (123) 456-7890</p>
                            <p>Emergency: (123) 456-7999</p>
                            <p>Appointments: (123) 456-7800</p>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div class="contact-text">
                            <h4>Email</h4>
                            <p>General: info@lifecaremedical.com</p>
                            <p>Appointments: appointments@lifecaremedical.com</p>
                            <p>Feedback: feedback@lifecaremedical.com</p>
                        </div>
                    </div>

                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="contact-text">
                            <h4>Hours of Operation</h4>
                            <p><strong>Outpatient Services:</strong></p>
                            <p>Monday - Friday: 8:00 AM - 8:00 PM</p>
                            <p>Saturday: 8:00 AM - 4:00 PM</p>
                            <p>Sunday: Closed (Emergency services only)</p>
                            <p><strong>Emergency Services:</strong> 24/7</p>
                        </div>
                    </div>
                </div>

                <div class="social-links">
                    <a href="#" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#" aria-label="YouTube"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="contact-form-container">
                <h3>Send Us a Message</h3>
                <form action="ContactServlet" method="post" class="contact-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" placeholder="Your full name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" placeholder="Your email address" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="Your phone number" required>
                        </div>

                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <select id="subject" name="subject" required>
                                <option value="" disabled selected>Select a subject</option>
                                <option value="General Inquiry">General Inquiry</option>
                                <option value="Appointment">Appointment</option>
                                <option value="Feedback">Feedback</option>
                                <option value="Billing">Billing</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" rows="6" placeholder="Your message" required></textarea>
                    </div>

                    <div class="form-group">
                        <button type="submit">Send Message</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Map Section -->
        <section class="map-section">
            <h3>Our Location</h3>
            <div class="map-container">
                <img src="images/hospital-map.jpg" alt="Hospital Location Map" class="location-map">
            </div>
        </section>

        <!-- Department Contact Section -->
        <section class="departments-section">
            <h3>Department Contact Information</h3>
            <div class="departments-grid">
                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <h4>Cardiology</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7801</p>
                    <p><i class="fas fa-envelope"></i> cardiology@lifecaremedical.com</p>
                    <a href="department-services.jsp#cardiology" class="department-link">Learn More</a>
                </div>

                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                    <h4>Neurology</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7802</p>
                    <p><i class="fas fa-envelope"></i> neurology@lifecaremedical.com</p>
                    <a href="department-services.jsp#neurology" class="department-link">Learn More</a>
                </div>

                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-child"></i>
                    </div>
                    <h4>Pediatrics</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7803</p>
                    <p><i class="fas fa-envelope"></i> pediatrics@lifecaremedical.com</p>
                    <a href="department-services.jsp#pediatrics" class="department-link">Learn More</a>
                </div>

                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-bone"></i>
                    </div>
                    <h4>Orthopedics</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7804</p>
                    <p><i class="fas fa-envelope"></i> orthopedics@lifecaremedical.com</p>
                    <a href="department-services.jsp#orthopedics" class="department-link">Learn More</a>
                </div>

                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <h4>Surgery</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7805</p>
                    <p><i class="fas fa-envelope"></i> surgery@lifecaremedical.com</p>
                    <a href="department-services.jsp#surgery" class="department-link">Learn More</a>
                </div>

                <div class="department-card">
                    <div class="department-icon">
                        <i class="fas fa-stethoscope"></i>
                    </div>
                    <h4>General Medicine</h4>
                    <p><i class="fas fa-phone-alt"></i> (123) 456-7806</p>
                    <p><i class="fas fa-envelope"></i> medicine@lifecaremedical.com</p>
                    <a href="department-services.jsp#general-medicine" class="department-link">Learn More</a>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>LifeCare Medical Center</h3>
                <p>Providing exceptional healthcare with compassion and excellence since 2000.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="departments.jsp">Departments</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="about-us.jsp">About Us</a></li>
                    <li><a href="contact-us.jsp">Contact</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Contact Us</h3>
                <p><i class="fas fa-map-marker-alt"></i> 123 Medical Center Drive, Healthcare City, HC 12345</p>
                <p><i class="fas fa-phone"></i> (123) 456-7890</p>
                <p><i class="fas fa-envelope"></i> info@lifecaremedical.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>

    <!-- Common JavaScript -->
    <script src="js/common.js"></script>

    <!-- Page-specific JavaScript -->
    <script src="js/contact-us.js"></script>
</body>
</html>