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
    <title>Online Appointment - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/online-appointment.css">
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
            <section class="appointment-hero">
                <h2>Schedule Your Medical Appointment</h2>
                <p>Book an appointment with our experienced doctors for in-person visits, video consultations, or phone calls. We're here to provide the care you need, when you need it.</p>
            </section>

            <!-- Appointment Section -->
            <section class="appointment-section">
                <h2 class="section-title">Book an Online Appointment</h2>

                <div class="appointment-content">
                    <div class="appointment-info animate-on-scroll">
                        <h3>How It Works</h3>
                        <div class="step-container">
                            <div class="step">
                                <div class="step-number">1</div>
                                <div class="step-content">
                                    <h4>Select Department</h4>
                                    <p>Choose the medical department that matches your needs.</p>
                                </div>
                            </div>
                            <div class="step">
                                <div class="step-number">2</div>
                                <div class="step-content">
                                    <h4>Fill the Form</h4>
                                    <p>Provide your personal details and describe your symptoms.</p>
                                </div>
                            </div>
                            <div class="step">
                                <div class="step-number">3</div>
                                <div class="step-content">
                                    <h4>Confirm Appointment</h4>
                                    <p>Review your details and submit your appointment request.</p>
                                </div>
                            </div>
                            <div class="step">
                                <div class="step-number">4</div>
                                <div class="step-content">
                                    <h4>Receive Confirmation</h4>
                                    <p>Get a confirmation email with your appointment details.</p>
                                </div>
                            </div>
                        </div>

                        <div class="appointment-notes">
                            <h4>Important Notes:</h4>
                            <ul>
                                <li>Please arrive 15 minutes before your scheduled appointment.</li>
                                <li>Bring your ID and insurance information.</li>
                                <li>You can reschedule or cancel your appointment up to 24 hours before the scheduled time.</li>
                                <li>For emergency cases, please call our emergency hotline at (123) 456-7999.</li>
                            </ul>
                        </div>
                    </div>

                    <div class="appointment-form-container animate-on-scroll">
                        <h3>Appointment Request Form</h3>
                        <form action="OnlineAppointmentServlet" method="post" class="appointment-form" id="appointmentForm">
                            <div class="form-group">
                                <label for="appointmentType">Appointment Type:</label>
                                <select id="appointmentType" name="appointmentType" required>
                                    <option value="">Select Appointment Type</option>
                                    <option value="In-Person">In-Person Visit</option>
                                    <option value="Video">Video Consultation</option>
                                    <option value="Phone">Phone Consultation</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="department">Department/Specialty:</label>
                                <select id="department" name="department" required>
                                    <option value="">Select Department</option>
                                    <option value="General Medicine">General Medicine</option>
                                    <option value="Pediatrics">Pediatrics</option>
                                    <option value="Gynecology">Gynecology & Obstetrics</option>
                                    <option value="Orthopedics">Orthopedics</option>
                                    <option value="Cardiology">Cardiology</option>
                                    <option value="Dermatology">Dermatology</option>
                                    <option value="ENT">ENT (Ear, Nose, Throat)</option>
                                    <option value="Neurology">Neurology</option>
                                    <option value="Psychiatry">Psychiatry & Mental Health</option>
                                    <option value="Surgery">General Surgery</option>
                                    <option value="Urology">Urology</option>
                                    <option value="Gastroenterology">Gastroenterology</option>
                                    <option value="Ophthalmology">Ophthalmology</option>
                                    <option value="Physiotherapy">Physiotherapy</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="doctor">Select Doctor (Optional):</label>
                                <select id="doctor" name="doctor">
                                    <option value="">Any Available Doctor</option>
                                    <option value="Dr. Robert Smith">Dr. Robert Smith - Cardiologist</option>
                                    <option value="Dr. Sarah Williams">Dr. Sarah Williams - Pediatrician</option>
                                    <option value="Dr. James Wilson">Dr. James Wilson - Orthopedic Surgeon</option>
                                    <option value="Dr. Emily Rodriguez">Dr. Emily Rodriguez - Gynecologist</option>
                                    <option value="Dr. Michael Chen">Dr. Michael Chen - Neurologist</option>
                                    <option value="Dr. Lisa Johnson">Dr. Lisa Johnson - General Physician</option>
                                    <option value="Dr. David Thompson">Dr. David Thompson - Dermatologist</option>
                                </select>
                                <small>If you don't have a preference, we'll assign the best available doctor for you</small>
                            </div>

                            <div class="form-group">
                                <label for="fullName">Full Name:</label>
                                <input type="text" id="fullName" name="fullName" required>
                            </div>

                            <div class="form-group">
                                <label for="gender">Gender:</label>
                                <select id="gender" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="age">Age:</label>
                                <input type="number" id="age" name="age" min="0" max="120" required>
                            </div>

                            <div class="form-group">
                                <label for="contactNumber">Contact Number:</label>
                                <input type="text" id="contactNumber" name="contactNumber" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label for="preferredDate">Preferred Date:</label>
                                <input type="date" id="appointmentDate" name="preferredDate" required>
                                <small>Please select a date in the future (minimum 1 day ahead)</small>
                            </div>

                            <div class="form-group">
                                <label for="preferredTime">Preferred Time:</label>
                                <select id="preferredTime" name="preferredTime" required>
                                    <option value="">Select Time</option>
                                    <option value="Morning">Morning (9:00 AM - 12:00 PM)</option>
                                    <option value="Afternoon">Afternoon (1:00 PM - 5:00 PM)</option>
                                    <option value="Evening">Evening (6:00 PM - 8:00 PM)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="reason">Reason for Appointment:</label>
                                <textarea id="reason" name="reason" rows="4" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="previousVisit">Have you visited us before?</label>
                                <div class="radio-group">
                                    <input type="radio" id="visitYes" name="previousVisit" value="Yes">
                                    <label for="visitYes">Yes</label>
                                    <input type="radio" id="visitNo" name="previousVisit" value="No" checked>
                                    <label for="visitNo">No</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <button type="submit" class="btn primary">Request Appointment</button>
                                <button type="reset" class="btn secondary">Reset Form</button>
                            </div>
                        </form>
                    </div>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section class="testimonials-section">
                <h2 class="section-title">What Our Patients Say</h2>

                <div class="testimonials-container">
                    <!-- Testimonial 1 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"The online appointment system was so easy to use! I was able to book my appointment in just a few minutes, and the confirmation was instant. The doctor was punctual and very professional."</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-1.jpg" alt="John D.">
                                </div>
                                <div class="author-info">
                                    <h4>John D.</h4>
                                    <p>Cardiology Patient</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 2 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"I was nervous about my first video consultation, but it went so smoothly. The doctor was attentive and thorough, and I received my prescription right after the call. Highly recommend!"</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-2.jpg" alt="Maria L.">
                                </div>
                                <div class="author-info">
                                    <h4>Maria L.</h4>
                                    <p>Dermatology Patient</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 3 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"As a busy parent, being able to schedule appointments online has been a game-changer. The reminders are helpful, and the staff is always accommodating if I need to reschedule."</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-3.jpg" alt="Robert K.">
                                </div>
                                <div class="author-info">
                                    <h4>Robert K.</h4>
                                    <p>Pediatrics Parent</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- FAQ Section -->
            <section class="faq-section">
                <h2 class="section-title">Frequently Asked Questions</h2>

                <div class="faq-container">
                    <!-- FAQ Item 1 -->
                    <div class="faq-item">
                        <div class="faq-question">How far in advance should I book my appointment?</div>
                        <div class="faq-answer">
                            <p>We recommend booking routine appointments at least 1-2 weeks in advance to ensure availability with your preferred doctor. For urgent matters, we offer same-day or next-day appointments based on availability.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 2 -->
                    <div class="faq-item">
                        <div class="faq-question">What if I need to cancel or reschedule my appointment?</div>
                        <div class="faq-answer">
                            <p>You can cancel or reschedule your appointment up to 24 hours before your scheduled time without any penalty. Please call our scheduling line or use our online portal to make changes to your appointment.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 3 -->
                    <div class="faq-item">
                        <div class="faq-question">How do video consultations work?</div>
                        <div class="faq-answer">
                            <p>For video consultations, you'll receive a secure link via email before your appointment. Simply click the link at your scheduled time, and you'll be connected to your doctor. Make sure you have a stable internet connection and a device with a camera and microphone.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="faq-item">
                        <div class="faq-question">What should I bring to my in-person appointment?</div>
                        <div class="faq-answer">
                            <p>Please bring your ID, insurance card, a list of current medications, and any relevant medical records or test results. Arrive 15 minutes early to complete any necessary paperwork.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 5 -->
                    <div class="faq-item">
                        <div class="faq-question">Are my medical records secure?</div>
                        <div class="faq-answer">
                            <p>Yes, we take patient privacy very seriously. All medical records are stored securely in compliance with HIPAA regulations. Our online systems use encryption to protect your personal information.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CTA Section -->
            <section class="appointment-cta">
                <h3>Need Immediate Assistance?</h3>
                <p>Our patient support team is available to help you with any questions or concerns about your appointment.</p>
                <div class="cta-buttons">
                    <a href="tel:+11234567890" class="btn primary"><i class="fas fa-phone-alt"></i> Call Us: (123) 456-7890</a>
                    <a href="contact-us.jsp" class="btn secondary"><i class="fas fa-envelope"></i> Send a Message</a>
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
    <script src="js/online-appointment.js"></script>
</body>
</html>