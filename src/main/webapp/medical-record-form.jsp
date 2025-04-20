<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    // Check if user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null || (!user.getRole().equals("DOCTOR") && !user.getRole().equals("ADMIN"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Medical Record Form - LifeCare Medical Center</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <div class="logo">
                    <img src="images/hospital-logo.png" alt="LifeCare Medical Center Logo">
                </div>
                <h1>LifeCare Medical Center</h1>
            </div>
            <nav>
                <ul>
                    <% if (user.getRole().equals("DOCTOR")) { %>
                    <li><a href="dashboard-doctor.jsp">Dashboard</a></li>
                    <li><a href="doctor-appointments.jsp">My Appointments</a></li>
                    <li><a href="doctor-patients.jsp">My Patients</a></li>
                    <li><a href="doctor-prescriptions.jsp">Prescriptions</a></li>
                    <li><a href="medical-record-form.jsp" class="active">Medical Records</a></li>
                    <li><a href="doctor-profile.jsp">My Profile</a></li>
                    <% } else { %>
                    <li><a href="dashboard-admin.jsp">Dashboard</a></li>
                    <li><a href="manage-doctors.jsp">Manage Doctors</a></li>
                    <li><a href="manage-patients.jsp">Manage Patients</a></li>
                    <li><a href="manage-departments.jsp">Manage Departments</a></li>
                    <li><a href="manage-appointments.jsp">Appointments</a></li>
                    <li><a href="medical-record-form.jsp" class="active">Medical Records</a></li>
                    <% } %>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <section class="medical-record-section">
                <h2>Medical Record Form</h2>
                
                <div class="medical-record-form-container">
                    <form action="MedicalRecordServlet" method="post" class="medical-record-form">
                        <div class="form-section">
                            <h3>Patient Information</h3>
                            <div class="form-group">
                                <label for="patientId">Patient:</label>
                                <select id="patientId" name="patientId" required>
                                    <option value="">Select Patient</option>
                                    <!-- This would be populated from the database -->
                                    <option value="1">John Doe (ID: 1)</option>
                                    <option value="2">Jane Smith (ID: 2)</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="doctorId">Doctor:</label>
                                <select id="doctorId" name="doctorId" required>
                                    <option value="">Select Doctor</option>
                                    <!-- This would be populated from the database -->
                                    <option value="1">Dr. Robert Smith (ID: 1)</option>
                                    <option value="2">Dr. Lisa Johnson (ID: 2)</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="recordDate">Record Date:</label>
                                <input type="date" id="recordDate" name="recordDate" required>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Medical History</h3>
                            <div class="form-group">
                                <label for="chiefComplaint">Chief Complaint:</label>
                                <textarea id="chiefComplaint" name="chiefComplaint" rows="3" required></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="historyOfPresentIllness">History of Present Illness:</label>
                                <textarea id="historyOfPresentIllness" name="historyOfPresentIllness" rows="4"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="pastMedicalHistory">Past Medical History:</label>
                                <textarea id="pastMedicalHistory" name="pastMedicalHistory" rows="3"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="familyHistory">Family History:</label>
                                <textarea id="familyHistory" name="familyHistory" rows="3"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="socialHistory">Social History:</label>
                                <textarea id="socialHistory" name="socialHistory" rows="3"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Allergies</h3>
                            <div class="form-group">
                                <label for="allergies">Known Allergies:</label>
                                <textarea id="allergies" name="allergies" rows="3"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="allergicReactions">Allergic Reactions:</label>
                                <textarea id="allergicReactions" name="allergicReactions" rows="3"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Current Medications</h3>
                            <div class="form-group">
                                <label for="currentMedications">Current Medications:</label>
                                <textarea id="currentMedications" name="currentMedications" rows="4"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Vital Signs</h3>
                            <div class="form-row">
                                <div class="form-group half">
                                    <label for="temperature">Temperature (°F):</label>
                                    <input type="number" id="temperature" name="temperature" step="0.1">
                                </div>
                                
                                <div class="form-group half">
                                    <label for="pulse">Pulse (bpm):</label>
                                    <input type="number" id="pulse" name="pulse">
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group half">
                                    <label for="respirationRate">Respiration Rate (breaths/min):</label>
                                    <input type="number" id="respirationRate" name="respirationRate">
                                </div>
                                
                                <div class="form-group half">
                                    <label for="bloodPressure">Blood Pressure (mmHg):</label>
                                    <input type="text" id="bloodPressure" name="bloodPressure" placeholder="e.g., 120/80">
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group half">
                                    <label for="height">Height (cm):</label>
                                    <input type="number" id="height" name="height">
                                </div>
                                
                                <div class="form-group half">
                                    <label for="weight">Weight (kg):</label>
                                    <input type="number" id="weight" name="weight" step="0.1">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="bmi">BMI:</label>
                                <input type="number" id="bmi" name="bmi" step="0.01" readonly>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Physical Examination</h3>
                            <div class="form-group">
                                <label for="physicalExamination">Physical Examination Findings:</label>
                                <textarea id="physicalExamination" name="physicalExamination" rows="4"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Diagnosis & Treatment</h3>
                            <div class="form-group">
                                <label for="diagnosis">Diagnosis:</label>
                                <textarea id="diagnosis" name="diagnosis" rows="3" required></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="treatment">Treatment Plan:</label>
                                <textarea id="treatment" name="treatment" rows="4" required></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="prescription">Prescription:</label>
                                <textarea id="prescription" name="prescription" rows="4"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="labTests">Laboratory Tests Ordered:</label>
                                <textarea id="labTests" name="labTests" rows="3"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="followUp">Follow-up Instructions:</label>
                                <textarea id="followUp" name="followUp" rows="3"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-section">
                            <h3>Additional Notes</h3>
                            <div class="form-group">
                                <label for="notes">Additional Notes:</label>
                                <textarea id="notes" name="notes" rows="4"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn primary">Save Medical Record</button>
                            <button type="reset" class="btn secondary">Reset Form</button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
        
        <footer>
            <div class="footer-content">
                <div class="footer-section">
                    <h3>LifeCare Medical Center</h3>
                    <p>Providing quality healthcare services since 2000.</p>
                </div>
                <div class="footer-section">
                    <h3>Contact Us</h3>
                    <p>123 Medical Avenue, Healthcare City</p>
                    <p>Phone: (123) 456-7890</p>
                    <p>Email: info@lifecaremedical.com</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2023 LifeCare Medical Center. All rights reserved.</p>
            </div>
        </footer>
    </div>
    
    <script>
        // Calculate BMI when height and weight are entered
        document.addEventListener('DOMContentLoaded', function() {
            const heightInput = document.getElementById('height');
            const weightInput = document.getElementById('weight');
            const bmiInput = document.getElementById('bmi');
            
            function calculateBMI() {
                const height = parseFloat(heightInput.value);
                const weight = parseFloat(weightInput.value);
                
                if (height && weight) {
                    // BMI formula: weight (kg) / (height (m))^2
                    const heightInMeters = height / 100;
                    const bmi = weight / (heightInMeters * heightInMeters);
                    bmiInput.value = bmi.toFixed(2);
                } else {
                    bmiInput.value = '';
                }
            }
            
            heightInput.addEventListener('input', calculateBMI);
            weightInput.addEventListener('input', calculateBMI);
        });
    </script>
</body>
</html>