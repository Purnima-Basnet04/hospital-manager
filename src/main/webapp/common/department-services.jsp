<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is logged in
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    if (username == null) {
        username = "Guest";
        userRole = "GUEST";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Services - LifeCare Medical Center</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Common CSS -->
    <link rel="stylesheet" type="text/css" href="styles/common.css">

    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="styles/department-services.css">
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
            <section class="departments-hero">
                <h2>Our Medical Departments</h2>
                <p>Discover our specialized departments offering comprehensive healthcare services with state-of-the-art facilities and expert medical professionals.</p>
            </section>

            <div class="department-nav">
                <div class="department-nav-list">
                    <a href="#general-medicine" class="department-nav-item active">General Medicine</a>
                    <a href="#pediatrics" class="department-nav-item">Pediatrics</a>
                    <a href="#gynecology" class="department-nav-item">Gynecology & Obstetrics</a>
                    <a href="#orthopedics" class="department-nav-item">Orthopedics</a>
                    <a href="#cardiology" class="department-nav-item">Cardiology</a>
                    <a href="#dermatology" class="department-nav-item">Dermatology</a>
                    <a href="#ent" class="department-nav-item">ENT</a>
                    <a href="#neurology" class="department-nav-item">Neurology</a>
                    <a href="#psychiatry" class="department-nav-item">Psychiatry</a>
                    <a href="#surgery" class="department-nav-item">Surgery</a>
                </div>

            </div>

            <!-- General Medicine -->
            <section id="general-medicine" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-stethoscope"></i>
                    </div>
                    <div class="department-title">
                        <h2>General Medicine (Internal Medicine)</h2>
                        <p>Comprehensive care for adult patients</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our General Medicine department provides comprehensive care for adult patients, focusing on the prevention, diagnosis, and treatment of diseases affecting adults. Our team of experienced physicians offers personalized care to manage both acute and chronic conditions.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>Diagnosis and treatment of adult diseases</li>
                            <li>Management of chronic illnesses like diabetes, hypertension, asthma</li>
                            <li>Preventive healthcare and wellness programs</li>
                            <li>Health screenings and vaccinations</li>
                            <li>Comprehensive medical check-ups</li>
                            <li>Lifestyle modification counseling</li>
                            <li>Geriatric care for elderly patients</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/general-medicine.jpg" alt="General Medicine Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <div class="service-content">
                            <h4>Chronic Disease Management</h4>
                            <p>Comprehensive care for conditions like diabetes, hypertension, and heart disease with personalized treatment plans.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-lungs"></i>
                        </div>
                        <div class="service-content">
                            <h4>Respiratory Care</h4>
                            <p>Diagnosis and treatment of respiratory conditions including asthma, COPD, and respiratory infections.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-clipboard-check"></i>
                        </div>
                        <div class="service-content">
                            <h4>Preventive Care</h4>
                            <p>Regular health check-ups, screenings, and vaccinations to prevent diseases and maintain optimal health.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/general-med-1.jpg" alt="Dr. Robert Smith">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Robert Smith</h4>
                                <p class="specialty">Internal Medicine Specialist</p>
                                <p class="bio">Dr. Smith has over 15 years of experience in treating complex medical conditions with a patient-centered approach.</p>
                                <div class="doctor-actions">
                                    <a href="doctor-profile.jsp?id=101" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="online-appointment.jsp?doctor=101" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="login.jsp?redirect=online-appointment.jsp?doctor=101" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/general-med-2.jpg" alt="Dr. Lisa Johnson">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Lisa Johnson</h4>
                                <p class="specialty">General Physician</p>
                                <p class="bio">Dr. Johnson specializes in preventive care and management of chronic diseases with a holistic approach to wellness.</p>
                                <div class="doctor-actions">
                                    <a href="doctor-profile.jsp?id=102" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="online-appointment.jsp?doctor=102" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=102" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">When should I see a general physician?</div>
                            <div class="faq-answer">
                                <p>You should see a general physician for routine check-ups, when you're feeling unwell with common symptoms like fever or pain, for management of chronic conditions, or when you need preventive care services like vaccinations.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">How often should I have a general health check-up?</div>
                            <div class="faq-answer">
                                <p>For most adults, an annual health check-up is recommended. However, the frequency may vary based on your age, existing health conditions, and risk factors. Your doctor can provide personalized recommendations.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What should I bring to my first appointment?</div>
                            <div class="faq-answer">
                                <p>Please bring your identification, insurance information, a list of current medications, your medical history including previous diagnoses and surgeries, and any recent test results or medical records.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Ready to Schedule Your Visit?</h3>
                    <p>Our team of experienced general physicians is ready to provide you with comprehensive care tailored to your needs.</p>
                    <div class="cta-buttons">
                        <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=general-medicine" class="btn primary">Book an Appointment</a>
                        <% } else { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?dept=general-medicine" class="btn primary">Login to Book</a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Pediatrics -->
            <section id="pediatrics" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-baby"></i>
                    </div>
                    <div class="department-title">
                        <h2>Pediatrics</h2>
                        <p>Specialized care for infants, children, and adolescents</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our Pediatrics department is dedicated to providing comprehensive healthcare services for infants, children, and adolescents up to 18 years of age. Our child-friendly environment and specialized pediatricians ensure the best care for your little ones.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>Child health checkups and vaccinations</li>
                            <li>Treatment for infant/childhood illnesses</li>
                            <li>Growth and development monitoring</li>
                            <li>Behavioral and developmental assessments</li>
                            <li>Pediatric emergency care</li>
                            <li>Nutritional counseling for children</li>
                            <li>Adolescent healthcare</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/pediatrics.jpg" alt="Pediatrics Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-syringe"></i>
                        </div>
                        <div class="service-content">
                            <h4>Vaccinations & Immunizations</h4>
                            <p>Complete vaccination schedules following national guidelines to protect your child from preventable diseases.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="service-content">
                            <h4>Growth & Development Monitoring</h4>
                            <p>Regular assessment of your child's physical growth, cognitive development, and milestone achievements.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <div class="service-content">
                            <h4>Pediatric Consultations</h4>
                            <p>Diagnosis and treatment of common childhood illnesses, infections, allergies, and chronic conditions.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/pediatrics-1.jpg" alt="Dr. Sarah Williams">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Sarah Williams</h4>
                                <p class="specialty">Pediatrician</p>
                                <p class="bio">Dr. Williams specializes in general pediatrics with a focus on preventive care and childhood development.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=201" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=201" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=201" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/pediatrics-2.jpg" alt="Dr. Michael Chen">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Michael Chen</h4>
                                <p class="specialty">Pediatric Specialist</p>
                                <p class="bio">Dr. Chen has expertise in treating complex pediatric conditions and childhood allergies.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=202" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=202" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=202" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">How often should my child have a check-up?</div>
                            <div class="faq-answer">
                                <p>For newborns and infants, check-ups are recommended at 1, 2, 4, 6, 9, 12, 15, 18, and 24 months. For children aged 2-18, annual check-ups are typically sufficient unless there are specific health concerns.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What vaccinations does my child need?</div>
                            <div class="faq-answer">
                                <p>Vaccination schedules vary by age and can include immunizations for diseases like measles, mumps, rubella, polio, diphtheria, tetanus, pertussis, hepatitis, and more. Our pediatricians follow the latest guidelines and will provide a personalized vaccination schedule for your child.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">How can I prepare my child for a doctor's visit?</div>
                            <div class="faq-answer">
                                <p>Be honest with your child about the visit, explain what to expect in simple terms, bring a favorite toy or book for comfort, and consider role-playing doctor visits at home. Our child-friendly environment is designed to make the experience as comfortable as possible.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Your Child's Health is Our Priority</h3>
                    <p>Our team of pediatric specialists is committed to providing the highest quality care for your child's health and development.</p>
                    <div class="cta-buttons">
                        <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=pediatrics" class="btn primary">Book an Appointment</a>
                        <% } else { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?dept=pediatrics" class="btn primary">Login to Book</a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Gynecology & Obstetrics -->
            <section id="gynecology" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-venus"></i>
                    </div>
                    <div class="department-title">
                        <h2>Gynecology & Obstetrics</h2>
                        <p>Comprehensive women's healthcare and pregnancy services</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our Gynecology & Obstetrics department provides comprehensive care for women's reproductive health and pregnancy care. Our team of experienced gynecologists and obstetricians is dedicated to providing personalized care for women at every stage of life.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>Women's reproductive health services</li>
                            <li>Pregnancy care and deliveries</li>
                            <li>Family planning services</li>
                            <li>Gynecological surgeries</li>
                            <li>Menopause management</li>
                            <li>Infertility treatments</li>
                            <li>Preventive screenings and check-ups</li>
                            <li>Treatment for gynecological conditions</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/gynecology.jpg" alt="Gynecology & Obstetrics Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-baby-carriage"></i>
                        </div>
                        <div class="service-content">
                            <h4>Prenatal Care</h4>
                            <p>Comprehensive prenatal care including regular check-ups, ultrasounds, genetic testing, and preparation for childbirth.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <div class="service-content">
                            <h4>Gynecological Examinations</h4>
                            <p>Regular check-ups, Pap smears, breast examinations, and screenings for various gynecological conditions.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-procedures"></i>
                        </div>
                        <div class="service-content">
                            <h4>Gynecological Surgeries</h4>
                            <p>Various surgical procedures including hysterectomy, myomectomy, laparoscopy, and other minimally invasive surgeries.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="service-content">
                            <h4>Fertility Services</h4>
                            <p>Evaluation and treatment of infertility, including assisted reproductive technologies and counseling.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/gynecology-1.jpg" alt="Dr. Emily Rodriguez">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Emily Rodriguez</h4>
                                <p class="specialty">Gynecologist & Obstetrician</p>
                                <p class="bio">Dr. Rodriguez specializes in high-risk pregnancies and comprehensive women's healthcare with over 12 years of experience.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=301" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=301" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=301" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/gynecology-2.jpg" alt="Dr. Jennifer Lee">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Jennifer Lee</h4>
                                <p class="specialty">Reproductive Health Specialist</p>
                                <p class="bio">Dr. Lee is an expert in fertility treatments and reproductive endocrinology, helping couples achieve their dream of parenthood.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=302" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=302" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=302" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">How often should I have a gynecological check-up?</div>
                            <div class="faq-answer">
                                <p>Most women should have an annual gynecological examination. However, the frequency may vary based on age, medical history, and risk factors. Your doctor can provide personalized recommendations.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">When should I start prenatal care if I'm pregnant?</div>
                            <div class="faq-answer">
                                <p>Ideally, prenatal care should begin as soon as you know you're pregnant, typically within the first 8 weeks. Early prenatal care is important for monitoring your health and your baby's development from the beginning.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What fertility services do you offer?</div>
                            <div class="faq-answer">
                                <p>We offer a comprehensive range of fertility services including fertility evaluations, ovulation induction, intrauterine insemination (IUI), in vitro fertilization (IVF), and fertility preservation options. Our specialists will work with you to develop a personalized treatment plan.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Women's Health is Our Priority</h3>
                    <p>Our team of gynecologists and obstetricians is dedicated to providing compassionate and comprehensive care for women at every stage of life.</p>
                    <div class="cta-buttons">
                        <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=gynecology" class="btn primary">Book an Appointment</a>
                        <% } else { %>
                        <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?dept=gynecology" class="btn primary">Login to Book</a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Orthopedics -->
            <section id="orthopedics" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-bone"></i>
                    </div>
                    <div class="department-title">
                        <h2>Orthopedics</h2>
                        <p>Specialized care for bones, joints, and muscles</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our Orthopedics department specializes in the diagnosis, treatment, and prevention of disorders of the bones, joints, ligaments, tendons, and muscles. Our team of orthopedic surgeons and specialists uses the latest techniques and technologies to provide comprehensive care for musculoskeletal conditions.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>Bone, joint, and muscle care</li>
                            <li>Fracture treatment and management</li>
                            <li>Arthritis treatment</li>
                            <li>Joint replacement surgeries</li>
                            <li>Sports injury treatment</li>
                            <li>Spine disorders management</li>
                            <li>Minimally invasive orthopedic procedures</li>
                            <li>Rehabilitation services</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/orthopedics.jpg" alt="Orthopedics Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-walking"></i>
                        </div>
                        <div class="service-content">
                            <h4>Joint Replacement</h4>
                            <p>Advanced joint replacement surgeries including hip, knee, and shoulder replacements using the latest techniques and implants.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-running"></i>
                        </div>
                        <div class="service-content">
                            <h4>Sports Medicine</h4>
                            <p>Specialized care for athletes and active individuals, including treatment for sports injuries and performance enhancement.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-spine"></i>
                        </div>
                        <div class="service-content">
                            <h4>Spine Care</h4>
                            <p>Comprehensive treatment for spine disorders including herniated discs, spinal stenosis, and scoliosis.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-hand-paper"></i>
                        </div>
                        <div class="service-content">
                            <h4>Hand & Upper Extremity</h4>
                            <p>Specialized care for conditions affecting the hand, wrist, elbow, and shoulder, including carpal tunnel syndrome and tendonitis.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/orthopedics-1.jpg" alt="Dr. James Wilson">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. James Wilson</h4>
                                <p class="specialty">Orthopedic Surgeon</p>
                                <p class="bio">Dr. Wilson specializes in joint replacement surgeries and has performed over 1,000 successful procedures throughout his career.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=401" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=401" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=401" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/orthopedics-2.jpg" alt="Dr. David Thompson">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. David Thompson</h4>
                                <p class="specialty">Sports Medicine Specialist</p>
                                <p class="bio">Dr. Thompson has extensive experience in treating sports injuries and has worked with professional athletes throughout his career.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=402" class="btn secondary">View Profile</a>
                                    <% if (session.getAttribute("username") != null && session.getAttribute("userRole").equals("PATIENT")) { %>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=402" class="btn primary">Book Appointment</a>
                                    <% } else { %>
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=online-appointment.jsp?doctor=402" class="btn primary">Login to Book</a>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">When should I see an orthopedic specialist?</div>
                            <div class="faq-answer">
                                <p>You should consider seeing an orthopedic specialist if you experience persistent pain in your joints, bones, or muscles, have limited range of motion, difficulty performing daily activities, or have suffered an injury that hasn't improved with rest and home treatment.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What should I expect during recovery from joint replacement surgery?</div>
                            <div class="faq-answer">
                                <p>Recovery from joint replacement surgery typically involves a hospital stay of 1-3 days, followed by physical therapy. Most patients can resume light activities within 6 weeks, with full recovery taking 3-6 months. Our team will provide a personalized rehabilitation plan to ensure optimal recovery.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">Do you offer minimally invasive procedures?</div>
                            <div class="faq-answer">
                                <p>Yes, our orthopedic surgeons are trained in the latest minimally invasive techniques, which often result in smaller incisions, less pain, and faster recovery times compared to traditional open surgeries. The appropriate procedure will depend on your specific condition and needs.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Get Back to an Active Lifestyle</h3>
                    <p>Our orthopedic specialists are committed to helping you overcome pain and mobility issues to return to the activities you enjoy.</p>
                    <div class="cta-buttons">
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=orthopedics" class="btn primary">Book an Appointment</a>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Cardiology -->
            <section id="cardiology" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <div class="department-title">
                        <h2>Cardiology</h2>
                        <p>Comprehensive care for heart and cardiovascular conditions</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our Cardiology department specializes in diagnosing and treating diseases and conditions of the heart and blood vessels. Our team of experienced cardiologists uses advanced technology to provide comprehensive cardiac care, from prevention to treatment of complex heart conditions.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>Heart and blood vessel-related care</li>
                            <li>ECG, echocardiograms, and stress tests</li>
                            <li>Angiography and cardiac catheterization</li>
                            <li>Cardiac rehabilitation</li>
                            <li>Heart failure management</li>
                            <li>Preventive cardiology</li>
                            <li>Arrhythmia diagnosis and treatment</li>
                            <li>Coronary artery disease management</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/cardiology.jpg" alt="Cardiology Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-heart"></i>
                        </div>
                        <div class="service-content">
                            <h4>Diagnostic Cardiology</h4>
                            <p>Comprehensive cardiac testing including ECG, echocardiography, stress testing, and Holter monitoring to accurately diagnose heart conditions.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <div class="service-content">
                            <h4>Interventional Cardiology</h4>
                            <p>Minimally invasive procedures such as angioplasty, stent placement, and valve repairs to treat heart and blood vessel conditions.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <div class="service-content">
                            <h4>Cardiac Rehabilitation</h4>
                            <p>Personalized rehabilitation programs to help patients recover from heart attacks, heart surgery, or other cardiac events.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="service-content">
                            <h4>Preventive Cardiology</h4>
                            <p>Risk assessment, lifestyle modifications, and preventive strategies to reduce the risk of heart disease and related complications.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/cardiology-1.jpg" alt="Dr. Richard Brown">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Richard Brown</h4>
                                <p class="specialty">Cardiologist</p>
                                <p class="bio">Dr. Brown specializes in general cardiology and preventive cardiac care with over 15 years of experience in treating various heart conditions.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=501" class="btn secondary">View Profile</a>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=501" class="btn primary">Book Appointment</a>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/cardiology-2.jpg" alt="Dr. Maria Garcia">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Maria Garcia</h4>
                                <p class="specialty">Interventional Cardiologist</p>
                                <p class="bio">Dr. Garcia is an expert in interventional procedures such as angioplasty and stent placement, with specialized training in complex cardiac interventions.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=502" class="btn secondary">View Profile</a>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=502" class="btn primary">Book Appointment</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">What are the warning signs of heart problems?</div>
                            <div class="faq-answer">
                                <p>Common warning signs include chest pain or discomfort, shortness of breath, pain or discomfort in the arms, back, neck, jaw, or stomach, lightheadedness, cold sweats, and fatigue. If you experience these symptoms, especially chest pain, seek medical attention immediately.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">How can I prevent heart disease?</div>
                            <div class="faq-answer">
                                <p>Preventive measures include maintaining a healthy diet low in saturated fats and sodium, regular physical activity, avoiding tobacco, limiting alcohol consumption, managing stress, and controlling conditions like high blood pressure, high cholesterol, and diabetes.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What tests are used to diagnose heart conditions?</div>
                            <div class="faq-answer">
                                <p>Common diagnostic tests include electrocardiogram (ECG), echocardiogram, stress tests, cardiac CT or MRI, coronary angiogram, and blood tests. The specific tests recommended will depend on your symptoms and risk factors.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Take Care of Your Heart</h3>
                    <p>Our team of cardiologists is dedicated to providing comprehensive care for your heart health, from prevention to treatment of complex cardiac conditions.</p>
                    <div class="cta-buttons">
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=cardiology" class="btn primary">Book an Appointment</a>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Surgery -->
            <section id="surgery" class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <div class="department-title">
                        <h2>Surgery</h2>
                        <p>Advanced surgical procedures with expert surgeons</p>
                    </div>
                </div>

                <div class="department-content">
                    <div class="department-description">
                        <h3>About the Department</h3>
                        <p>Our Surgery department offers a wide range of surgical procedures performed by highly skilled surgeons using state-of-the-art technology. We are committed to providing safe, effective surgical care with a focus on minimally invasive techniques and enhanced recovery protocols.</p>

                        <h3>Services We Offer</h3>
                        <ul>
                            <li>General surgery</li>
                            <li>Minimally invasive laparoscopic procedures</li>
                            <li>Robotic-assisted surgery</li>
                            <li>Gastrointestinal surgery</li>
                            <li>Vascular surgery</li>
                            <li>Oncological surgery</li>
                            <li>Plastic and reconstructive surgery</li>
                            <li>Emergency surgical procedures</li>
                        </ul>
                    </div>

                    <div class="department-image">
                        <img src="images/departments/surgery.jpg" alt="Surgery Department">
                    </div>
                </div>

                <h3>Our Services</h3>
                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-cut"></i>
                        </div>
                        <div class="service-content">
                            <h4>General Surgery</h4>
                            <p>Surgical procedures for conditions affecting the abdomen, including the appendix, gallbladder, stomach, intestines, liver, and pancreas.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-microscope"></i>
                        </div>
                        <div class="service-content">
                            <h4>Minimally Invasive Surgery</h4>
                            <p>Advanced laparoscopic and endoscopic procedures that result in smaller incisions, less pain, and faster recovery times compared to traditional open surgery.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-robot"></i>
                        </div>
                        <div class="service-content">
                            <h4>Robotic Surgery</h4>
                            <p>Cutting-edge robotic-assisted surgical procedures that offer enhanced precision, flexibility, and control for complex operations.</p>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <div class="service-content">
                            <h4>Vascular Surgery</h4>
                            <p>Surgical treatment of diseases affecting the vascular system, including arteries, veins, and lymphatic vessels.</p>
                        </div>
                    </div>
                </div>

                <div class="doctors-section">
                    <h3>Meet Our Specialists</h3>
                    <div class="doctors-list">
                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/doctor-3.jpg" alt="Dr. Thomas Wright">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Thomas Wright</h4>
                                <p class="specialty">General Surgeon</p>
                                <p class="bio">Dr. Wright specializes in minimally invasive surgical techniques with over 15 years of experience in general and gastrointestinal surgery.</p>
                                <div class="doctor-actions">
                                    <a href="doctor-profile.jsp?id=601" class="btn secondary">View Profile</a>
                                    <a href="online-appointment.jsp?doctor=601" class="btn primary">Book Appointment</a>
                                </div>
                            </div>
                        </div>

                        <div class="doctor-card">
                            <div class="doctor-image">
                                <img src="images/doctors/doctor-4.jpg" alt="Dr. Amanda Chen">
                            </div>
                            <div class="doctor-info">
                                <h4>Dr. Amanda Chen</h4>
                                <p class="specialty">Vascular Surgeon</p>
                                <p class="bio">Dr. Chen is an expert in vascular surgery and has pioneered several innovative surgical techniques for complex vascular conditions.</p>
                                <div class="doctor-actions">
                                    <a href="${pageContext.request.contextPath}/doctor-profile.jsp?id=602" class="btn secondary">View Profile</a>
                                    <a href="${pageContext.request.contextPath}/online-appointment.jsp?doctor=602" class="btn primary">Book Appointment</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq-section">
                    <h3>Frequently Asked Questions</h3>
                    <div class="faq-list">
                        <div class="faq-item">
                            <div class="faq-question">What is the difference between traditional and minimally invasive surgery?</div>
                            <div class="faq-answer">
                                <p>Traditional (open) surgery typically involves a large incision to access the surgical site, while minimally invasive surgery uses several small incisions through which specialized instruments and a camera are inserted. Minimally invasive procedures generally result in less pain, smaller scars, shorter hospital stays, and faster recovery times.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">How should I prepare for surgery?</div>
                            <div class="faq-answer">
                                <p>Preparation varies depending on the procedure, but generally includes: following fasting instructions (typically no food or drink for 8-12 hours before surgery), stopping certain medications as advised by your doctor, arranging for someone to drive you home, and following any specific pre-operative instructions provided by your surgical team.</p>
                            </div>
                        </div>

                        <div class="faq-item">
                            <div class="faq-question">What can I expect during recovery from surgery?</div>
                            <div class="faq-answer">
                                <p>Recovery experiences vary based on the type of surgery, your overall health, and other factors. You may experience some pain, swelling, and fatigue. Your surgical team will provide specific instructions for wound care, activity restrictions, medication management, and follow-up appointments. It's important to follow these instructions carefully to ensure proper healing.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="department-cta">
                    <h3>Expert Surgical Care</h3>
                    <p>Our team of skilled surgeons is committed to providing the highest quality surgical care using the latest techniques and technologies.</p>
                    <div class="cta-buttons">
                        <a href="${pageContext.request.contextPath}/online-appointment.jsp?dept=surgery" class="btn primary">Book a Consultation</a>
                        <a href="${pageContext.request.contextPath}/contact-us.jsp" class="btn secondary">Contact Us</a>
                    </div>
                </div>
            </section>

            <!-- Diagnostic & Lab Services -->
            <section class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-microscope"></i>
                    </div>
                    <div class="department-title">
                        <h2>Diagnostic & Lab Services</h2>
                        <p>Advanced diagnostic testing and laboratory services</p>
                    </div>
                </div>

                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-x-ray"></i>
                        </div>
                        <div class="service-content">
                            <h4>Radiology & Imaging</h4>
                            <p>Comprehensive imaging services including X-rays, ultrasound, CT scans, MRI, and mammography for accurate diagnosis.</p>
                            <ul>
                                <li>X-rays</li>
                                <li>Ultrasound</li>
                                <li>CT scan</li>
                                <li>MRI</li>
                                <li>Mammography</li>
                            </ul>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-vial"></i>
                        </div>
                        <div class="service-content">
                            <h4>Pathology & Laboratory</h4>
                            <p>Full-service laboratory offering a wide range of tests for diagnosis, treatment monitoring, and preventive health screenings.</p>
                            <ul>
                                <li>Blood tests</li>
                                <li>Urine tests</li>
                                <li>Biopsies</li>
                                <li>Routine health screening packages</li>
                                <li>Microbiology tests</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Support & Allied Health Services -->
            <section class="department-section">
                <div class="department-header">
                    <div class="department-icon">
                        <i class="fas fa-hands-helping"></i>
                    </div>
                    <div class="department-title">
                        <h2>Support & Allied Health Services</h2>
                        <p>Comprehensive support services for complete patient care</p>
                    </div>
                </div>

                <div class="services-list">
                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-walking"></i>
                        </div>
                        <div class="service-content">
                            <h4>Physiotherapy</h4>
                            <p>Specialized physical therapy services to help patients recover from injuries, surgeries, and manage chronic conditions.</p>
                            <ul>
                                <li>Rehabilitation for injuries</li>
                                <li>Post-surgery recovery</li>
                                <li>Exercises and manual therapy</li>
                                <li>Pain management</li>
                            </ul>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-apple-alt"></i>
                        </div>
                        <div class="service-content">
                            <h4>Nutrition & Dietetics</h4>
                            <p>Personalized nutrition counseling and diet planning to support overall health and manage medical conditions.</p>
                            <ul>
                                <li>Diet plans for medical conditions</li>
                                <li>Weight loss programs</li>
                                <li>Diabetes management</li>
                                <li>Wellness counseling</li>
                            </ul>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-ambulance"></i>
                        </div>
                        <div class="service-content">
                            <h4>Emergency/Trauma Care</h4>
                            <p>24/7 emergency services with specialized teams ready to respond to medical emergencies and trauma cases.</p>
                            <ul>
                                <li>24/7 emergency services</li>
                                <li>Accident response</li>
                                <li>CPR and life support</li>
                                <li>Ambulance services</li>
                            </ul>
                        </div>
                    </div>

                    <div class="service-card">
                        <div class="service-icon">
                            <i class="fas fa-procedures"></i>
                        </div>
                        <div class="service-content">
                            <h4>Intensive Care Unit (ICU)</h4>
                            <p>Advanced critical care facilities with state-of-the-art equipment and specialized staff for critically ill patients.</p>
                            <ul>
                                <li>Critical care support</li>
                                <li>Advanced monitoring</li>
                                <li>Life support systems</li>
                                <li>Specialized nursing care</li>
                            </ul>
                        </div>
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
    <script src="js/department-services.js"></script>
</body>
</html>