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
    <title>About Us - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/about-us.css">
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
                    <li><a href="about-us.jsp" class="active">About Us</a></li>
                    <li><a href="contact-us.jsp">Contact</a></li>
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
            <section class="about-hero">
                <h2>About LifeCare Medical Center</h2>
                <p>Providing exceptional healthcare with compassion and excellence since 2000</p>
            </section>

            <!-- Mission and Vision Section -->
            <section class="mission-vision-section">
                <div class="mission-vision">
                    <div class="mission-card animate-on-scroll">
                        <div class="card-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <h3>Our Mission</h3>
                        <p>At LifeCare Medical Center, our mission is to provide exceptional healthcare services with compassion, integrity, and excellence. We are committed to improving the health and well-being of the communities we serve through personalized care and innovative medical solutions.</p>
                    </div>

                    <div class="vision-card animate-on-scroll">
                        <div class="card-icon">
                            <i class="fas fa-eye"></i>
                        </div>
                        <h3>Our Vision</h3>
                        <p>To be the leading healthcare provider recognized for clinical excellence, patient-centered care, and innovative medical practices. We aim to set new standards in healthcare delivery, medical education, and research while maintaining our commitment to compassionate care.</p>
                    </div>
                </div>
            </section>

            <!-- Values Section -->
            <section class="values-section">
                <h2>Our Core Values</h2>
                <div class="values-container">
                    <div class="value-card animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-award"></i>
                        </div>
                        <h3>Excellence</h3>
                        <p>We strive for excellence in all aspects of patient care, continuously improving our services and standards.</p>
                    </div>

                    <div class="value-card animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-hands-helping"></i>
                        </div>
                        <h3>Compassion</h3>
                        <p>We treat every patient with kindness, dignity, and respect, understanding their unique needs and concerns.</p>
                    </div>

                    <div class="value-card animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-balance-scale"></i>
                        </div>
                        <h3>Integrity</h3>
                        <p>We uphold the highest ethical standards in our practice, ensuring transparency and honesty in all interactions.</p>
                    </div>

                    <div class="value-card animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-lightbulb"></i>
                        </div>
                        <h3>Innovation</h3>
                        <p>We embrace new technologies and approaches to improve healthcare delivery and patient outcomes.</p>
                    </div>

                    <div class="value-card animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3>Teamwork</h3>
                        <p>We collaborate effectively across disciplines to provide comprehensive care and achieve common goals.</p>
                    </div>
                </div>
            </section>



            <!-- Statistics Section -->
            <section class="stats-section">
                <h2>LifeCare by the Numbers</h2>
                <div class="stats-container">
                    <div class="stat-item">
                        <div class="stat-number">
                            <span class="counter" data-target="200">200</span>+
                        </div>
                        <div class="stat-label">Hospital Beds</div>
                    </div>

                    <div class="stat-item">
                        <div class="stat-number">
                            <span class="counter" data-target="150">150</span>+
                        </div>
                        <div class="stat-label">Specialized Doctors</div>
                    </div>

                    <div class="stat-item">
                        <div class="stat-number">
                            <span class="counter" data-target="50000">50000</span>+
                        </div>
                        <div class="stat-label">Patients Annually</div>
                    </div>

                    <div class="stat-item">
                        <div class="stat-number">
                            <span class="counter" data-target="25">25</span>+
                        </div>
                        <div class="stat-label">Specialized Departments</div>
                    </div>
                </div>
            </section>

            <!-- Achievements Section -->
            <section class="achievements-section">
                <h2>Our Achievements</h2>
                <div class="achievements-container">
                    <div class="achievement-card animate-on-scroll">
                        <div class="achievement-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <h3>Best Hospital Award 2022</h3>
                        <p>Recognized for excellence in patient care and medical services by the National Healthcare Association.</p>
                    </div>

                    <div class="achievement-card animate-on-scroll">
                        <div class="achievement-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h3>5-Star Rating for Patient Satisfaction</h3>
                        <p>Consistently rated highly by our patients for quality care, comfort, and service excellence.</p>
                    </div>

                    <div class="achievement-card animate-on-scroll">
                        <div class="achievement-icon">
                            <i class="fas fa-microscope"></i>
                        </div>
                        <h3>Research Excellence</h3>
                        <p>Published over 100 research papers in leading medical journals, contributing to advancements in healthcare.</p>
                    </div>

                    <div class="achievement-card animate-on-scroll">
                        <div class="achievement-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <h3>Community Service Award</h3>
                        <p>Recognized for our commitment to community health initiatives and outreach programs.</p>
                    </div>
                </div>
            </section>

            <!-- Leadership Team Section -->
            <section class="team-section">
                <div class="team-header">
                    <h2>Our Leadership Team</h2>
                    <div class="header-decoration">
                        <span class="decoration-line"></span>
                        <span class="decoration-icon"><i class="fas fa-user-md"></i></span>
                        <span class="decoration-line"></span>
                    </div>
                    <p class="section-subtitle">Meet the exceptional medical professionals who lead our healthcare services</p>
                </div>

                <div class="team-grid">
                    <!-- CEO -->
                    <div class="team-member">
                        <div class="member-image-container">
                            <div class="member-image">
                                <img src="images/doctors/ceo.jpg" alt="Dr. James Wilson">
                            </div>
                            <div class="member-overlay">
                                <div class="social-links">
                                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href="#" aria-label="Email"><i class="fas fa-envelope"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="member-info">
                            <h3>Dr. James Wilson</h3>
                            <p class="member-role">Chief Executive Officer</p>
                            <div class="member-divider"></div>
                            <p class="member-bio">With over 25 years of experience in healthcare management, Dr. Wilson leads our organization with vision and dedication.</p>
                        </div>
                    </div>

                    <!-- CMO -->
                    <div class="team-member">
                        <div class="member-image-container">
                            <div class="member-image">
                                <img src="images/doctors/cmo.jpg" alt="Dr. Sarah Johnson">
                            </div>
                            <div class="member-overlay">
                                <div class="social-links">
                                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href="#" aria-label="Email"><i class="fas fa-envelope"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="member-info">
                            <h3>Dr. Sarah Johnson</h3>
                            <p class="member-role">Chief Medical Officer</p>
                            <div class="member-divider"></div>
                            <p class="member-bio">Dr. Johnson oversees all medical operations, ensuring the highest standards of care across all departments.</p>
                        </div>
                    </div>

                    <!-- Director of Operations -->
                    <div class="team-member">
                        <div class="member-image-container">
                            <div class="member-image">
                                <img src="images/doctors/director.jpg" alt="Dr. Michael Chen">
                            </div>
                            <div class="member-overlay">
                                <div class="social-links">
                                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href="#" aria-label="Email"><i class="fas fa-envelope"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="member-info">
                            <h3>Dr. Michael Chen</h3>
                            <p class="member-role">Director of Operations</p>
                            <div class="member-divider"></div>
                            <p class="member-bio">Dr. Chen manages the day-to-day operations of our facility, ensuring efficiency and excellence in service delivery.</p>
                        </div>
                    </div>

                    <!-- Chief Nursing Officer -->
                    <div class="team-member">
                        <div class="member-image-container">
                            <div class="member-image">
                                <img src="images/doctors/nursing.jpg" alt="Ms. Emily Rodriguez">
                            </div>
                            <div class="member-overlay">
                                <div class="social-links">
                                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href="#" aria-label="Email"><i class="fas fa-envelope"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="member-info">
                            <h3>Ms. Emily Rodriguez</h3>
                            <p class="member-role">Chief Nursing Officer</p>
                            <div class="member-divider"></div>
                            <p class="member-bio">With extensive experience in nursing leadership, Ms. Rodriguez ensures excellence in patient care and nursing practices.</p>
                        </div>
                    </div>

                    <!-- CTO -->
                    <div class="team-member">
                        <div class="member-image-container">
                            <div class="member-image">
                                <img src="images/doctors/cto.jpg" alt="Dr. Robert Lee">
                            </div>
                            <div class="member-overlay">
                                <div class="social-links">
                                    <a href="#" aria-label="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="#" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
                                    <a href="#" aria-label="Email"><i class="fas fa-envelope"></i></a>
                                </div>
                            </div>
                        </div>
                        <div class="member-info">
                            <h3>Dr. Robert Lee</h3>
                            <p class="member-role">Chief Technology Officer</p>
                            <div class="member-divider"></div>
                            <p class="member-bio">Dr. Lee leads our technological initiatives, implementing innovative solutions to enhance patient care and operational efficiency.</p>
                        </div>
                    </div>

                    <!-- Add more team members here -->
                    <div class="team-member add-member">
                        <div class="add-member-content">
                            <div class="add-icon">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <h3>Join Our Team</h3>
                            <p>We're always looking for talented healthcare professionals to join our leadership team</p>
                            <a href="careers.jsp" class="btn-careers">View Opportunities</a>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CTA Section -->
            <section class="about-cta">
                <h2>Join Our Healthcare Journey</h2>
                <p>Whether you're seeking exceptional medical care or looking to build a career in healthcare, LifeCare Medical Center welcomes you.</p>
                <div class="cta-buttons">
                    <a href="online-appointment.jsp" class="btn primary">Book an Appointment</a>
                    <a href="careers.jsp" class="btn secondary">Explore Careers</a>
                </div>
            </section>

            <!-- Immediate initialization script -->
            <script>
                // Initialize counters immediately
                document.addEventListener('DOMContentLoaded', function() {
                    // Force counters to start immediately
                    const counters = document.querySelectorAll('.counter');
                    counters.forEach(counter => {
                        const target = parseInt(counter.getAttribute('data-target'));
                        counter.textContent = target;
                    });
                });
            </script>
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
    <script src="js/about-us.js"></script>
</body>
</html>