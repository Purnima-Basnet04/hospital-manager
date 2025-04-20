<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to the main register page
    response.sendRedirect("register.jsp");
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

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .register-container {
            display: flex;
            min-height: 100vh;
        }

        .register-image {
            flex: 1;
            background-image: url('https://images.unsplash.com/photo-1631248055158-edec7a3c072b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80');
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
            background: linear-gradient(135deg, rgba(41, 128, 185, 0.7), rgba(44, 62, 80, 0.9));
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

        .benefits {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
            animation: fadeIn 2s ease-out;
        }

        .benefit {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .benefit:hover {
            transform: translateX(5px);
        }

        .benefit i {
            font-size: 1.5rem;
            margin-right: 15px;
            color: #3498db;
            text-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
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
        }

        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
            margin-bottom: 25px;
        }

        .form-group.full-width {
            width: 100%;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
        }

        .input-with-icon input,
        .input-with-icon select,
        .input-with-icon textarea {
            padding-left: 45px;
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
            border-radius: 50px;
            font-size: 15px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="date"]:focus,
        select:focus,
        textarea:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            outline: none;
            background-color: white;
            transform: translateY(-2px);
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
            border-radius: 15px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.1);
            transition: all 0.5s ease;
            z-index: -1;
        }

        .btn:hover::before {
            width: 100%;
        }

        .btn:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .btn.secondary {
            background-color: #95a5a6;
        }

        .btn.secondary:hover {
            background-color: #7f8c8d;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
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
            animation: fadeIn 3s ease-out;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: #3498db;
            transition: width 0.3s ease;
        }

        .login-link a:hover {
            color: #2980b9;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        /* Responsive adjustments */
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

            .benefit i {
                font-size: 1.2rem;
            }

            .form-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-image">
            <div class="image-content">
                <h1>Your Family's Health Is Our Priority</h1>
                <p>Join our community of patients who trust us with their health. Create an account to access personalized care for you and your loved ones.</p>

                <div class="benefits">
                    <div class="benefit">
                        <i class="fas fa-baby"></i>
                        <span>Specialized pediatric care</span>
                    </div>
                    <div class="benefit">
                        <i class="fas fa-user-md"></i>
                        <span>Access to expert specialists</span>
                    </div>
                    <div class="benefit">
                        <i class="fas fa-heartbeat"></i>
                        <span>Comprehensive health monitoring</span>
                    </div>
                    <div class="benefit">
                        <i class="fas fa-calendar-check"></i>
                        <span>Easy appointment scheduling</span>
                    </div>
                    <div class="benefit">
                        <i class="fas fa-file-medical"></i>
                        <span>Digital medical records</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="register-form-container">
            <div class="register-form-wrapper">
                <div class="logo">
                    <img src="images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>

                <div class="form-header">
                    <h2>Create Your Account</h2>
                    <p>Fill in your details to register</p>
                </div>

                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                        String errorMsg = "";
                        switch (error) {
                            case "1": errorMsg = "Username already exists. Please choose a different username."; break;
                            case "2": errorMsg = "Passwords do not match."; break;
                            case "3": errorMsg = "Invalid date format. Please enter a valid date."; break;
                            case "4": errorMsg = "Registration failed. Please try again."; break;
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
                            <label for="fullName">Full Name</label>
                            <div class="input-with-icon">
                                <i class="fas fa-user"></i>
                                <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="username">Username</label>
                            <div class="input-with-icon">
                                <i class="fas fa-user-tag"></i>
                                <input type="text" id="username" name="username" placeholder="Choose a username" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <div class="input-with-icon">
                                <i class="fas fa-envelope"></i>
                                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone"></i>
                                <input type="text" id="phone" name="phone" placeholder="Enter your phone number" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="password" name="password" placeholder="Create a password" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <div class="input-with-icon">
                                <i class="fas fa-lock"></i>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
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
                            <label for="bloodGroup">Blood Group</label>
                            <div class="input-with-icon">
                                <i class="fas fa-tint"></i>
                                <select id="bloodGroup" name="bloodGroup" required>
                                    <option value="">Select Blood Group</option>
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
                            <label for="emergencyContact">Emergency Contact</label>
                            <div class="input-with-icon">
                                <i class="fas fa-phone-alt"></i>
                                <input type="text" id="emergencyContact" name="emergencyContact" placeholder="Emergency contact number" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <div class="input-with-icon">
                            <i class="fas fa-home"></i>
                            <textarea id="address" name="address" placeholder="Enter your full address" required></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="medicalHistory">Medical History (if any)</label>
                        <div class="input-with-icon">
                            <i class="fas fa-notes-medical"></i>
                            <textarea id="medicalHistory" name="medicalHistory" placeholder="Enter any relevant medical history"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="allergies">Allergies (if any)</label>
                        <div class="input-with-icon">
                            <i class="fas fa-allergies"></i>
                            <textarea id="allergies" name="allergies" placeholder="Enter any allergies you have"></textarea>
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

            // Form validation
            form.addEventListener('submit', function(event) {
                let hasError = false;
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

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
