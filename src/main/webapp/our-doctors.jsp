<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Doctors - LifeCare Medical Center</title>

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

        header {
            text-align: center;
            margin-bottom: 50px;
        }

        header h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        header p {
            font-size: 1.1rem;
            color: #7f8c8d;
            max-width: 700px;
            margin: 0 auto;
        }

        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
        }

        .doctor-card {
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .doctor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .doctor-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .doctor-info {
            padding: 20px;
        }

        .doctor-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .doctor-title {
            font-size: 0.9rem;
            color: #3498db;
            margin-bottom: 15px;
        }

        .doctor-description {
            font-size: 0.9rem;
            color: #7f8c8d;
            margin-bottom: 15px;
        }

        .doctor-contact {
            display: flex;
            justify-content: space-between;
        }

        .contact-btn {
            display: inline-block;
            padding: 8px 15px;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: background-color 0.3s;
        }

        .contact-btn:hover {
            background-color: #2980b9;
        }

        .social-links {
            display: flex;
            gap: 10px;
        }

        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #f5f7fa;
            color: #3498db;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

        .social-link:hover {
            background-color: #3498db;
            color: white;
        }

        .section-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }

        .divider {
            height: 3px;
            width: 50px;
            background-color: #3498db;
            margin: 0 auto 50px;
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

        footer {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 50px 0 20px;
            margin-top: 50px;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .footer-section h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h3::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 30px;
            height: 2px;
            background-color: #3498db;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #3498db;
        }

        .contact-info p {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .contact-info i {
            margin-right: 10px;
            color: #3498db;
        }

        .social-media {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-media a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #34495e;
            color: #ecf0f1;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

        .social-media a:hover {
            background-color: #3498db;
        }

        .copyright {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #34495e;
            font-size: 0.9rem;
            color: #bdc3c7;
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
        <header>
            <h1>Our Expert Doctors</h1>
            <p>Meet our team of experienced healthcare professionals dedicated to providing you with the best medical care.</p>
        </header>

        <h2 class="section-title">Medical Specialists</h2>
        <div class="divider"></div>

        <div class="doctors-grid">
            <!-- Doctor 1 -->
            <div class="doctor-card">
                <img src="images/doctors/dr-james-wilson.jpg" alt="Dr. James Wilson" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. James Wilson</h3>
                    <p class="doctor-title">Chief Executive Officer</p>
                    <p class="doctor-description">With over 25 years of experience in healthcare management and cardiology.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=1" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Doctor 2 -->
            <div class="doctor-card">
                <img src="images/doctors/dr-sarah-johnson.jpg" alt="Dr. Sarah Johnson" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. Sarah Johnson</h3>
                    <p class="doctor-title">Chief Medical Officer</p>
                    <p class="doctor-description">Dr. Johnson oversees all medical operations, with expertise in internal medicine.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=2" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Doctor 3 -->
            <div class="doctor-card">
                <img src="images/doctors/dr-michael-chen.jpg" alt="Dr. Michael Chen" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. Michael Chen</h3>
                    <p class="doctor-title">Director of Operations</p>
                    <p class="doctor-description">Dr. Chen manages the day-to-day operations of our medical facilities.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=3" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Doctor 4 -->
            <div class="doctor-card">
                <img src="images/doctors/ms-emily-rodriguez.jpg" alt="Ms. Emily Rodriguez" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Ms. Emily Rodriguez</h3>
                    <p class="doctor-title">Chief Nursing Officer</p>
                    <p class="doctor-description">With extensive experience in nursing leadership and patient care.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=4" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h2 class="section-title" style="margin-top: 50px;">Specialized Departments</h2>
        <div class="divider"></div>

        <div class="doctors-grid">
            <!-- Additional doctors can be added here -->
            <div class="doctor-card">
                <img src="images/doctors/doctor-placeholder.jpg" alt="Dr. Robert Brown" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. Robert Brown</h3>
                    <p class="doctor-title">Cardiologist</p>
                    <p class="doctor-description">Specializing in cardiovascular health with 15+ years of experience.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=5" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="doctor-card">
                <img src="images/doctors/doctor-placeholder.jpg" alt="Dr. Lisa Wang" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. Lisa Wang</h3>
                    <p class="doctor-title">Neurologist</p>
                    <p class="doctor-description">Expert in neurological disorders and brain health.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=6" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="doctor-card">
                <img src="images/doctors/doctor-placeholder.jpg" alt="Dr. David Kim" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. David Kim</h3>
                    <p class="doctor-title">Orthopedic Surgeon</p>
                    <p class="doctor-description">Specialized in joint replacements and sports injuries.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=7" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="doctor-card">
                <img src="images/doctors/doctor-placeholder.jpg" alt="Dr. Maria Garcia" class="doctor-image">
                <div class="doctor-info">
                    <h3 class="doctor-name">Dr. Maria Garcia</h3>
                    <p class="doctor-title">Pediatrician</p>
                    <p class="doctor-description">Dedicated to children's health and development.</p>
                    <div class="doctor-contact">
                        <a href="doctor-public-profile.jsp?id=8" class="contact-btn">View Profile</a>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-section">
                <h3>LifeCare Medical Center</h3>
                <p>Providing quality healthcare services for over 25 years. Your health is our priority.</p>
                <div class="social-media">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul class="footer-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="services.jsp">Services</a></li>
                    <li><a href="our-doctors.jsp">Doctors</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Services</h3>
                <ul class="footer-links">
                    <li><a href="services.jsp#emergency">Emergency Care</a></li>
                    <li><a href="services.jsp#cardiology">Cardiology</a></li>
                    <li><a href="services.jsp#neurology">Neurology</a></li>
                    <li><a href="services.jsp#pediatrics">Pediatrics</a></li>
                    <li><a href="services.jsp#orthopedics">Orthopedics</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h3>Contact Us</h3>
                <div class="contact-info">
                    <p><i class="fas fa-map-marker-alt"></i> 123 Medical Center Drive, City, State 12345</p>
                    <p><i class="fas fa-phone"></i> (123) 456-7890</p>
                    <p><i class="fas fa-envelope"></i> info@lifecaremedical.com</p>
                    <p><i class="fas fa-clock"></i> Mon-Fri: 8:00 AM - 8:00 PM</p>
                </div>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
        </div>
    </footer>

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
