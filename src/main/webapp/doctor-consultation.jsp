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
    <title>Doctor Consultation - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/doctor-consultation.css">
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
            <section class="consultation-hero">
                <div class="decorative-element"></div>
                <h2>Expert Medical Consultations</h2>
                <p>Connect with our experienced doctors through in-person visits, video calls, or phone consultations. Get the medical advice you need, when you need it, in the way that works best for you.</p>
                <div class="hero-buttons">
                    <a href="#consultation-types" class="btn primary">Explore Consultation Options</a>
                    <a href="#doctor-search" class="btn secondary">Find a Doctor</a>
                </div>
            </section>

            <!-- Consultation Types Section -->
            <section id="consultation-types" class="consultation-types">
                <h3>Choose Your Consultation Type</h3>

                <div class="types-grid">
                    <!-- In-Person Consultation -->
                    <div class="type-card">
                        <div class="type-icon in-person">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h4>In-Person Consultation</h4>
                        <p>Visit our medical center for a face-to-face consultation with our experienced doctors.</p>
                        <div class="type-features">
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Comprehensive physical examination</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Immediate diagnostic tests if needed</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Direct interaction with healthcare team</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Same-day medication if required</span>
                            </div>
                        </div>
                        <div class="type-price">
                            $75 <span>per visit</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?type=in-person" class="btn primary">Book In-Person Visit</a>
                    </div>

                    <!-- Video Consultation -->
                    <div class="type-card">
                        <div class="type-icon video">
                            <i class="fas fa-video"></i>
                        </div>
                        <h4>Video Consultation</h4>
                        <p>Connect with our doctors from the comfort of your home through secure video calls.</p>
                        <div class="type-features">
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>No travel or waiting room time</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Visual assessment of symptoms</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Digital prescriptions sent instantly</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Secure, HIPAA-compliant platform</span>
                            </div>
                        </div>
                        <div class="type-price">
                            $50 <span>per session</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?type=video" class="btn primary">Schedule Video Call</a>
                    </div>

                    <!-- Phone Consultation -->
                    <div class="type-card">
                        <div class="type-icon phone">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <h4>Phone Consultation</h4>
                        <p>Speak directly with our medical professionals for quick advice and guidance.</p>
                        <div class="type-features">
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Convenient for follow-up questions</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Accessible from anywhere with phone service</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Ideal for quick medical advice</span>
                            </div>
                            <div class="feature-item">
                                <i class="fas fa-check-circle"></i>
                                <span>Prescription refills for existing patients</span>
                            </div>
                        </div>
                        <div class="type-price">
                            $35 <span>per call</span>
                        </div>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?type=phone" class="btn primary">Request Phone Consultation</a>
                    </div>
                </div>
            </section>

            <!-- How It Works Section -->
            <section class="how-it-works">
                <h3>How Doctor Consultation Works</h3>

                <div class="steps-container">
                    <!-- Step 1 -->
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h4>Choose Your Consultation Type</h4>
                            <p>Select the consultation method that works best for you: in-person visit, video call, or phone consultation.</p>
                        </div>
                    </div>

                    <!-- Step 2 -->
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h4>Find Your Doctor</h4>
                            <p>Browse our directory of specialists or search by specialty, availability, or location to find the right doctor for your needs.</p>
                        </div>
                    </div>

                    <!-- Step 3 -->
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h4>Book Your Appointment</h4>
                            <p>Select a convenient date and time from the available slots and confirm your appointment with a simple booking process.</p>
                        </div>
                    </div>

                    <!-- Step 4 -->
                    <div class="step-item">
                        <div class="step-number">4</div>
                        <div class="step-content">
                            <h4>Prepare for Your Consultation</h4>
                            <p>Receive confirmation and preparation instructions via email. For virtual consultations, you'll get a secure link to connect.</p>
                        </div>
                    </div>

                    <!-- Step 5 -->
                    <div class="step-item">
                        <div class="step-number">5</div>
                        <div class="step-content">
                            <h4>Attend Your Consultation</h4>
                            <p>Meet with your doctor at the scheduled time. Discuss your concerns, receive a diagnosis, and get a personalized treatment plan.</p>
                        </div>
                    </div>

                    <!-- Step 6 -->
                    <div class="step-item">
                        <div class="step-number">6</div>
                        <div class="step-content">
                            <h4>Follow-Up Care</h4>
                            <p>Access your consultation summary, prescriptions, and follow-up instructions through your patient portal. Schedule follow-up appointments if needed.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Doctor Search Section -->
            <section id="doctor-search" class="doctor-search">
                <h3>Find Your Doctor</h3>

                <div class="search-container">
                    <form class="search-form" action="doctor-search-results.jsp" method="get">
                        <div class="search-group">
                            <label for="specialty">Specialty</label>
                            <select id="specialty" name="specialty">
                                <option value="">All Specialties</option>
                                <option value="general-medicine">General Medicine</option>
                                <option value="cardiology">Cardiology</option>
                                <option value="dermatology">Dermatology</option>
                                <option value="gynecology">Gynecology & Obstetrics</option>
                                <option value="neurology">Neurology</option>
                                <option value="orthopedics">Orthopedics</option>
                                <option value="pediatrics">Pediatrics</option>
                                <option value="psychiatry">Psychiatry</option>
                                <option value="surgery">Surgery</option>
                            </select>
                        </div>

                        <div class="search-group">
                            <label for="location">Location</label>
                            <select id="location" name="location">
                                <option value="">All Locations</option>
                                <option value="main-campus">Main Campus</option>
                                <option value="north-clinic">North Clinic</option>
                                <option value="south-clinic">South Clinic</option>
                                <option value="east-clinic">East Clinic</option>
                                <option value="west-clinic">West Clinic</option>
                            </select>
                        </div>

                        <div class="search-group">
                            <label for="date">Appointment Date</label>
                            <input type="date" id="date" name="date">
                        </div>

                        <div class="search-group">
                            <label for="consultation-type">Consultation Type</label>
                            <select id="consultation-type" name="type">
                                <option value="">All Types</option>
                                <option value="in-person">In-Person</option>
                                <option value="video">Video Call</option>
                                <option value="phone">Phone Call</option>
                            </select>
                        </div>

                        <div class="search-actions">
                            <button type="submit" class="btn primary">Search Doctors</button>
                        </div>
                    </form>
                </div>

                <div class="doctors-list">
                    <!-- Doctor 1 -->
                    <div class="doctor-card">
                        <div class="doctor-header">
                            <div class="doctor-avatar">
                                <img src="images/doctors/doctor-1.jpg" alt="Dr. Robert Smith">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Robert Smith</h4>
                                <p class="specialty">Cardiologist</p>
                                <p class="experience">15+ years experience</p>
                            </div>
                        </div>
                        <div class="doctor-body">
                            <div class="doctor-details">
                                <div class="detail-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>Main Campus, 3rd Floor</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>Available: Mon, Wed, Fri</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-laptop-medical"></i>
                                    <span>In-person, Video & Phone</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-language"></i>
                                    <span>English, Spanish</span>
                                </div>
                            </div>
                            <div class="doctor-rating">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star-half-alt"></i>
                                </div>
                                <span class="rating-count">4.5 (128 reviews)</span>
                            </div>
                            <div class="doctor-actions">
                                <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=101" class="btn secondary">View Profile</a>
                                <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=101" class="btn primary">Book Appointment</a>
                            </div>
                        </div>
                    </div>

                    <!-- Doctor 2 -->
                    <div class="doctor-card">
                        <div class="doctor-header">
                            <div class="doctor-avatar">
                                <img src="images/doctors/doctor-2.jpg" alt="Dr. Sarah Williams">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Sarah Williams</h4>
                                <p class="specialty">Pediatrician</p>
                                <p class="experience">10+ years experience</p>
                            </div>
                        </div>
                        <div class="doctor-body">
                            <div class="doctor-details">
                                <div class="detail-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>North Clinic, 2nd Floor</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>Available: Tue, Thu, Sat</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-laptop-medical"></i>
                                    <span>In-person & Video</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-language"></i>
                                    <span>English, French</span>
                                </div>
                            </div>
                            <div class="doctor-rating">
                                <div class="rating-stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                <span class="rating-count">5.0 (96 reviews)</span>
                            </div>
                            <div class="doctor-actions">
                                <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=102" class="btn secondary">View Profile</a>
                                <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=102" class="btn primary">Book Appointment</a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="view-more-container">
                    <a href="doctor-directory.jsp" class="btn secondary">View All Doctors</a>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section class="testimonials">
                <h3>What Our Patients Say</h3>

                <div class="testimonials-container">
                    <!-- Testimonial 1 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"I was hesitant about video consultations, but Dr. Smith made the experience so comfortable. He was thorough, attentive, and the convenience of not having to travel to the clinic was a huge plus. Highly recommend!"</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-1.jpg" alt="John D.">
                                </div>
                                <div class="author-info">
                                    <h4>John D.</h4>
                                    <p>Video Consultation Patient</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 2 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"The in-person consultation with Dr. Williams was exceptional. She took the time to listen to all my concerns, explained everything clearly, and created a treatment plan that worked perfectly for my condition."</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-2.jpg" alt="Maria L.">
                                </div>
                                <div class="author-info">
                                    <h4>Maria L.</h4>
                                    <p>In-Person Consultation Patient</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Testimonial 3 -->
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">"I needed quick medical advice while traveling, and the phone consultation service was a lifesaver. The doctor was professional, gave me clear instructions, and followed up to ensure I was recovering well."</p>
                            <div class="testimonial-author">
                                <div class="author-avatar">
                                    <img src="images/testimonials/patient-3.jpg" alt="Robert K.">
                                </div>
                                <div class="author-info">
                                    <h4>Robert K.</h4>
                                    <p>Phone Consultation Patient</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- FAQ Section -->
            <section class="faq-section">
                <h3>Frequently Asked Questions</h3>

                <div class="faq-container">
                    <!-- FAQ Item 1 -->
                    <div class="faq-item">
                        <div class="faq-question">What is the difference between the consultation types?</div>
                        <div class="faq-answer">
                            <p>In-person consultations take place at our medical center and allow for physical examinations and immediate diagnostic tests. Video consultations are conducted through our secure telehealth platform, allowing you to see and speak with your doctor from home. Phone consultations are audio-only calls, ideal for quick medical advice, follow-ups, or when video isn't possible.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 2 -->
                    <div class="faq-item">
                        <div class="faq-question">How do I prepare for a video consultation?</div>
                        <div class="faq-answer">
                            <p>For a video consultation, ensure you have a stable internet connection, a device with a camera and microphone (smartphone, tablet, or computer), and a quiet, well-lit private space. Test your equipment beforehand, have any relevant medical records or medication lists ready, and prepare a list of symptoms or questions you want to discuss.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 3 -->
                    <div class="faq-item">
                        <div class="faq-question">Are online consultations as effective as in-person visits?</div>
                        <div class="faq-answer">
                            <p>Online consultations are effective for many conditions and situations, including follow-up care, medication management, reviewing test results, and discussing symptoms. However, some conditions may require physical examination or diagnostic tests that can only be done in person. Our doctors will advise if they believe you need to be seen in person.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="faq-item">
                        <div class="faq-question">How do I get prescriptions after an online consultation?</div>
                        <div class="faq-answer">
                            <p>If your doctor determines you need medication, they can send electronic prescriptions directly to your preferred pharmacy. For controlled substances or certain medications, an in-person visit may be required according to regulations.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 5 -->
                    <div class="faq-item">
                        <div class="faq-question">Are consultations covered by insurance?</div>
                        <div class="faq-answer">
                            <p>Many insurance plans cover both in-person and telehealth consultations. Coverage varies by provider and plan. We recommend checking with your insurance provider before scheduling. Our billing department can also help verify your coverage and explain any out-of-pocket costs.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 6 -->
                    <div class="faq-item">
                        <div class="faq-question">What if I need to cancel or reschedule my appointment?</div>
                        <div class="faq-answer">
                            <p>You can cancel or reschedule your appointment through your patient portal or by calling our scheduling line at least 24 hours in advance. Late cancellations or missed appointments may incur a fee as outlined in our appointment policy.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- CTA Section -->
            <section class="consultation-cta">
                <h3>Ready to Connect with Our Doctors?</h3>
                <p>Choose the consultation type that works best for you and take the first step towards better health today. Our experienced doctors are ready to provide the care you need.</p>
                <div class="cta-buttons">
                    <a href="${pageContext.request.contextPath}/online-appointment.jsp" class="btn primary">Book a Consultation</a>
                    <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
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
    <script src="js/doctor-consultation.js"></script>
</body>
</html>