<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is already logged in
    String userRole = (String) session.getAttribute("userRole");
    if (userRole != null) {
        // Redirect to home page if already logged in
        response.sendRedirect("home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - LifeCare Medical Center</title>

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

        html, body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .register-container {
            display: flex;
            min-height: 100vh;
        }

        .register-image {
            flex: 1;
            background-image: url('https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 40px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .register-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0.1), rgba(0,0,0,0.7));
        }

        .image-content {
            position: relative;
            color: white;
            max-width: 500px;
            animation: fadeIn 1.5s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .image-content h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            letter-spacing: 1px;
        }

        .image-content p {
            font-size: 1.1rem;
            margin-bottom: 20px;
            opacity: 0.95;
            line-height: 1.6;
            text-shadow: 0 1px 5px rgba(0, 0, 0, 0.2);
        }

        .features {
            display: flex;
            margin-top: 20px;
        }

        .feature {
            display: flex;
            align-items: center;
            margin-right: 30px;
        }

        .feature i {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #4CAF50;
        }

        .register-form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            background-color: white;
            overflow-y: auto;
            max-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            position: relative;
        }

        .register-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, #3498db, #2980b9);
        }

        .register-form-wrapper {
            width: 100%;
            max-width: 600px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 10px;
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo img {
            height: 60px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #7f8c8d;
            font-size: 1rem;
        }

        .main-heading {
            text-align: center;
            margin-bottom: 20px;
            color: #3498db;
            font-size: 2.5rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }



        .error-message {
            background-color: #ffebee;
            color: #d32f2f;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 500;
            border-left: 4px solid #d32f2f;
            font-size: 14px;
        }

        /* Form row styles already defined above */

        .form-group {
            flex: 1;
            margin-bottom: 25px;
            min-width: 120px;
        }

        .form-group.full-width {
            flex: 1 0 100%;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
            font-size: 14px;
        }

        .input-with-icon {
            position: relative;
            display: block;
            width: 100%;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
            font-size: 16px;
            width: 20px;
            text-align: center;
            z-index: 1;
            pointer-events: none;
        }

        .input-with-icon input,
        .input-with-icon select,
        .input-with-icon textarea {
            width: 100%;
            padding-left: 45px !important;
            text-indent: 0;
            padding-top: 12px;
            padding-bottom: 12px;
            padding-right: 15px;
        }

        /* Fix for icon alignment with text */
        .input-with-icon input[type="password"] {
            font-family: Arial, sans-serif;
            letter-spacing: 0.1em;
        }

        /* Fix for placeholder alignment */
        .input-with-icon input::placeholder,
        .input-with-icon select::placeholder,
        .input-with-icon textarea::placeholder {
            padding-top: 0;
            line-height: normal;
            position: relative;
            left: 0;
        }

        /* Fix for icon and text overlap */
        .input-with-icon .fa-lock,
        .input-with-icon .fa-user,
        .input-with-icon .fa-envelope,
        .input-with-icon .fa-phone,
        .input-with-icon .fa-venus-mars,
        .input-with-icon .fa-calendar-alt,
        .input-with-icon .fa-tint,
        .input-with-icon .fa-phone-alt,
        .input-with-icon .fa-home,
        .input-with-icon .fa-notes-medical,
        .input-with-icon .fa-allergies,
        .input-with-icon .fa-user-tag {
            font-size: 16px;
            width: 20px;
            left: 18px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
            background-color: #fff;
            height: 45px;
            text-indent: 0;
        }

        ::placeholder {
            color: #999;
            opacity: 1;
            font-size: 14px;
        }

        ::-webkit-input-placeholder {
            color: #999;
            opacity: 1;
            font-size: 14px;
        }

        ::-moz-placeholder {
            color: #999;
            opacity: 1;
            font-size: 14px;
        }

        :-ms-input-placeholder {
            color: #999;
            opacity: 1;
            font-size: 14px;
        }

        :-moz-placeholder {
            color: #999;
            opacity: 1;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="date"]:focus,
        select:focus,
        textarea:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            outline: none;
        }

        select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23666" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
            border-radius: 8px;
            height: auto;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .btn.secondary {
            background-color: #95a5a6;
        }

        .btn.secondary:hover {
            background-color: #7f8c8d;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            animation: fadeIn 2.5s ease-out;
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .register-form-wrapper {
                max-width: 500px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="date"],
            select,
            textarea {
                padding: 8px;
                font-size: 14px;
            }
        }

        @media (max-width: 992px) {
            .register-container {
                flex-direction: column;
            }

            .register-image {
                min-height: 350px;
            }

            .form-row {
                flex-direction: column;
                gap: 15px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="date"],
            select,
            textarea {
                padding: 10px 15px;
                font-size: 14px;
            }


        }

        @media (max-width: 576px) {
            .register-form-container {
                padding: 20px;
            }

            .form-actions {
                flex-direction: column;
            }

            .register-image {
                min-height: 250px;
                padding: 20px;
            }

            .image-content h1 {
                font-size: 1.8rem;
            }

            .image-content p {
                font-size: 1rem;
            }

            .features {
                flex-direction: column;
            }

            .feature {
                margin-right: 0;
                margin-bottom: 15px;
            }

            .form-header h2 {
                font-size: 1.5rem;
            }


        }

        @media (max-height: 700px) {
            .register-image {
                min-height: 200px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-row {
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="date"],
            select {
                padding: 8px 15px;
                height: 40px;
            }

            .btn {
                padding: 10px;
                height: auto;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-image">
            <div class="image-content">
                <h1>LifeCare Medical Center</h1>
                <p>Your health is our priority. Create an account to access our healthcare services and manage your medical records.</p>

                <div class="features">
                    <div class="feature">
                        <i class="fas fa-user-md"></i>
                        <span>Expert Doctors</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-heartbeat"></i>
                        <span>Quality Care</span>
                    </div>
                    <div class="feature">
                        <i class="fas fa-clock"></i>
                        <span>24/7 Service</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="register-form-container">
            <div class="register-form-wrapper">
            <h1 class="main-heading">Account Registration</h1>

            <div class="logo">
                <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
            </div>

            <div class="form-header">
                <h2>Create Account</h2>
                <p>Please fill in your details to register</p>
            </div>

            <%
                String error = request.getParameter("error");
                if (error != null) {
                    String errorMsg = "";
                    switch (error) {
                        case "1": errorMsg = "Username or email already exists. Please choose a different one."; break;
                        case "2": errorMsg = "Passwords do not match."; break;
                        case "3": errorMsg = "Invalid date format. Please enter a valid date."; break;
                        case "4": errorMsg = "Registration failed. Please try again."; break;
                        case "5": errorMsg = "Please select a specialization for doctor registration."; break;
                        default: errorMsg = "An unknown error occurred.";
                    }
            %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
                </div>
            <% } %>

            <form action="RegisterServlet" method="post" id="registerForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Name</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user"></i>
                            <input type="text" id="fullName" name="fullName" placeholder="Your name" required>
                        </div>
                    </div>

                        <div class="form-group">
                            <label for="username">Username</label>
                            <div class="input-with-icon">
                                <i class="fas fa-user-tag"></i>
                                <input type="text" id="username" name="username" placeholder="Username" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <div class="input-with-icon">
                                <i class="fas fa-envelope"></i>
                                <input type="email" id="email" name="email" placeholder="Email address" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone"></i>
                                <input type="text" id="phone" name="phone" placeholder="Phone number" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="password" name="password" placeholder="Password" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm</label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="role">Role</label>
                            <div class="input-with-icon">
                                <i class="fas fa-user-shield"></i>
                                <select id="role" name="role" required>
                                    <option value="">Select Role</option>
                                    <option value="PATIENT" selected>Patient</option>
                                    <option value="DOCTOR">Doctor</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="gender">Gender</label>
                            <div class="input-with-icon">
                                <i class="fas fa-venus-mars"></i>
                                <select id="gender" name="gender" required>
                                    <option value="">Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="dateOfBirth">Date of Birth</label>
                            <div class="input-with-icon">
                                <i class="fas fa-calendar-alt"></i>
                                <input type="date" id="dateOfBirth" name="dateOfBirth" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="bloodGroup">Blood</label>
                            <div class="input-with-icon">
                                <i class="fas fa-tint"></i>
                                <select id="bloodGroup" name="bloodGroup" required>
                                    <option value="">Select</option>
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="emergencyContact">Emergency</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone-alt"></i>
                                <input type="text" id="emergencyContact" name="emergencyContact" placeholder="Emergency number" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group" style="flex: 2;">
                            <label for="address">Address</label>
                            <div class="input-with-icon">
                                <i class="fas fa-home"></i>
                                <input type="text" id="address" name="address" placeholder="Your address" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="medicalHistory">Medical</label>
                            <div class="input-with-icon">
                                <i class="fas fa-notes-medical"></i>
                                <input type="text" id="medicalHistory" name="medicalHistory" placeholder="Medical history">
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="allergies">Allergies</label>
                            <div class="input-with-icon">
                                <i class="fas fa-allergies"></i>
                                <input type="text" id="allergies" name="allergies" placeholder="List allergies">
                            </div>
                        </div>
                    </div>

                    <!-- Doctor-specific fields -->
                    <div id="doctor-fields" style="display: none;">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="specialization">Specialization</label>
                                <div class="input-with-icon">
                                    <i class="fas fa-stethoscope"></i>
                                    <select id="specialization" name="specialization">
                                        <option value="">Select Specialization</option>
                                        <option value="Cardiologist">Cardiologist</option>
                                        <option value="Dermatologist">Dermatologist</option>
                                        <option value="Neurologist">Neurologist</option>
                                        <option value="Orthopedic">Orthopedic</option>
                                        <option value="Pediatrician">Pediatrician</option>
                                        <option value="Psychiatrist">Psychiatrist</option>
                                        <option value="Surgeon">Surgeon</option>
                                        <option value="General Physician">General Physician</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">Register</button>
                        <button type="reset" class="btn secondary">Reset</button>
                    </div>

                    <div class="login-link">
                        <p>Already have an account? <a href="login.jsp">Login here</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registerForm');
            const roleSelect = document.getElementById('role');
            const mainHeading = document.querySelector('.main-heading');

            const doctorFields = document.getElementById('doctor-fields');
            const patientFields = document.querySelectorAll('#bloodGroup, #emergencyContact, #medicalHistory, #allergies');
            const patientLabels = document.querySelectorAll('label[for="bloodGroup"], label[for="emergencyContact"], label[for="medicalHistory"], label[for="allergies"]');

            // Function to toggle fields based on role
            function toggleFieldsByRole(role) {
                if (role === 'DOCTOR') {
                    doctorFields.style.display = 'block';
                    document.getElementById('specialization').setAttribute('required', 'required');

                    // Make patient-specific fields optional
                    patientFields.forEach(field => {
                        field.removeAttribute('required');
                        field.closest('.form-group').style.opacity = '0.5';
                    });
                    patientLabels.forEach(label => {
                        label.innerHTML = label.innerHTML.replace(' *', '');
                    });
                } else {
                    doctorFields.style.display = 'none';
                    document.getElementById('specialization').removeAttribute('required');

                    // Make patient-specific fields required for patients
                    if (role === 'PATIENT') {
                        patientFields.forEach(field => {
                            if (field.id === 'bloodGroup' || field.id === 'emergencyContact') {
                                field.setAttribute('required', 'required');
                            }
                            field.closest('.form-group').style.opacity = '1';
                        });
                    }
                }

                // Update heading
                if (role) {
                    mainHeading.textContent = role.charAt(0) + role.slice(1).toLowerCase() + ' Registration';
                } else {
                    mainHeading.textContent = 'Account Registration';
                }
            }

            // Initial setup based on default role
            toggleFieldsByRole(roleSelect.value);

            // Update fields when role changes
            roleSelect.addEventListener('change', function() {
                toggleFieldsByRole(this.value);
            });

            // Form validation
            form.addEventListener('submit', function(event) {
                let hasError = false;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const role = document.getElementById('role').value;

                // Check if role is selected
                if (!role) {
                    event.preventDefault();
                    showError('role', 'Please select a role');
                    hasError = true;
                }

                // Check for role-specific required fields
                if (role === 'DOCTOR') {
                    const specialization = document.getElementById('specialization').value;
                    if (!specialization) {
                        event.preventDefault();
                        showError('specialization', 'Please select a specialization');
                        hasError = true;
                    }
                }

                // Check if passwords match
                if (password !== confirmPassword) {
                    event.preventDefault();
                    showError('confirmPassword', 'Passwords do not match!');
                    hasError = true;
                }

                // Check password strength
                if (password.length < 8) {
                    event.preventDefault();
                    showError('password', 'Password must be at least 8 characters long');
                    hasError = true;
                }

                if (hasError) {
                    event.preventDefault();
                }
            });

            // Function to show error message
            function showError(fieldId, message) {
                const field = document.getElementById(fieldId);
                field.style.borderColor = '#d32f2f';
                field.style.boxShadow = '0 0 0 3px rgba(211, 47, 47, 0.2)';

                // Create error message if it doesn't exist
                let errorDiv = field.parentNode.querySelector('.error-text');
                if (!errorDiv) {
                    errorDiv = document.createElement('div');
                    errorDiv.className = 'error-text';
                    errorDiv.style.color = '#d32f2f';
                    errorDiv.style.fontSize = '12px';
                    errorDiv.style.marginTop = '5px';
                    field.parentNode.appendChild(errorDiv);
                }

                errorDiv.textContent = message;
            }

            // Add focus and blur event listeners to improve user experience
            const inputFields = document.querySelectorAll('input, select, textarea');
            inputFields.forEach(field => {
                field.addEventListener('focus', function() {
                    this.style.borderColor = '#3498db';
                    this.style.boxShadow = '0 0 0 3px rgba(52, 152, 219, 0.2)';

                    // Remove error styling on focus
                    const errorDiv = this.parentNode.querySelector('.error-text');
                    if (errorDiv) {
                        errorDiv.textContent = '';
                    }
                });

                field.addEventListener('blur', function() {
                    if (!this.value.trim() && this.hasAttribute('required')) {
                        this.style.borderColor = '#d32f2f';
                        this.style.boxShadow = '0 0 0 3px rgba(211, 47, 47, 0.2)';
                    } else {
                        this.style.borderColor = '#ddd';
                        this.style.boxShadow = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>
