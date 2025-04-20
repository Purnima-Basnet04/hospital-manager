<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is already logged in
    String userRole = (String) session.getAttribute("userRole");
    if (userRole != null) {
        // Redirect to home page if already logged in
        response.sendRedirect("../common/home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - LifeCare Medical Center</title>

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

        .login-container {
            display: flex;
            min-height: 100vh;
        }

        .login-image {
            flex: 1;
            background-image: url('https://images.unsplash.com/photo-1538108149393-fbbd81895907?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1528&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 40px;
        }

        .login-image::before {
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
        }

        .image-content h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .image-content p {
            font-size: 1.1rem;
            margin-bottom: 20px;
            opacity: 0.9;
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

        .login-form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            background-color: white;
        }

        .login-form-wrapper {
            width: 100%;
            max-width: 450px;
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

        .success-message {
            background-color: #e8f5e9;
            color: #2e7d32;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 500;
            border-left: 4px solid #2e7d32;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        .input-with-icon {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-with-icon i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #95a5a6;
            font-size: 14px;
            width: 16px;
            text-align: center;
            z-index: 1;
            pointer-events: none;
            background: transparent;
            margin-top: -1px;
        }

        .input-with-icon input,
        .input-with-icon select {
            width: 100%;
            padding-left: 35px;
            text-indent: 0;
            position: relative;
            z-index: 0;
            background-color: #fff;
        }

        /* Fix for icon alignment with text */
        .input-with-icon input[type="password"] {
            font-family: Arial, sans-serif;
            letter-spacing: 0.1em;
        }

        /* Fix for placeholder alignment */
        .input-with-icon input::placeholder,
        .input-with-icon select::placeholder {
            padding-top: 0;
            line-height: normal;
            position: relative;
            left: 0;
        }

        /* Fix for icon and text overlap */
        .input-with-icon .fa-user,
        .input-with-icon .fa-lock,
        .input-with-icon .fa-users {
            font-size: 13px;
            width: 15px;
            left: 8px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        ::placeholder {
            color: #999;
            opacity: 1;
            font-size: 13px;
        }

        ::-webkit-input-placeholder {
            color: #999;
            opacity: 1;
            font-size: 13px;
        }

        ::-moz-placeholder {
            color: #999;
            opacity: 1;
            font-size: 13px;
        }

        :-ms-input-placeholder {
            color: #999;
            opacity: 1;
            font-size: 13px;
        }

        :-moz-placeholder {
            color: #999;
            opacity: 1;
            font-size: 13px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
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

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            margin-right: 8px;
        }

        .forgot-password a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-password a:hover {
            text-decoration: underline;
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

        .register-link {
            text-align: center;
            margin-top: 25px;
        }

        .register-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
        }

        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background-color: #ddd;
        }

        .divider span {
            padding: 0 15px;
            color: #95a5a6;
            font-size: 14px;
        }

        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #f5f7fa;
            border: 1px solid #ddd;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .social-btn:hover {
            background-color: #ecf0f1;
            transform: translateY(-3px);
        }

        .social-btn i {
            font-size: 20px;
        }

        .social-btn.google i {
            color: #DB4437;
        }

        .social-btn.facebook i {
            color: #4267B2;
        }

        .social-btn.apple i {
            color: #000;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .login-container {
                flex-direction: column;
            }

            .login-image {
                min-height: 300px;
            }

            .features {
                flex-direction: column;
            }

            .feature {
                margin-right: 0;
                margin-bottom: 15px;
            }
        }

        @media (max-width: 576px) {
            .login-form-container {
                padding: 20px;
            }

            .remember-forgot {
                flex-direction: column;
                align-items: flex-start;
            }

            .forgot-password {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-image">
            <div class="image-content">
                <h1>LifeCare Medical Center</h1>
                <p>Your health is our priority. Experience the best healthcare services with our team of expert doctors and state-of-the-art facilities.</p>

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

        <div class="login-form-container">
            <div class="login-form-wrapper">
                <div class="logo">
                    <img src="../images/hospital-logo.svg" alt="LifeCare Medical Center Logo">
                </div>

                <div class="form-header">
                    <h2>Welcome Back</h2>
                    <p>Please login to your account</p>
                </div>

                <%
                    String registered = request.getParameter("registered");
                    if (registered != null && registered.equals("1")) {
                        String role = request.getParameter("role");
                        if (role == null) role = "PATIENT";
                %>
                    <div class="success-message">
                        <i class="fas fa-check-circle"></i> Registration successful! You can now login as a <%= role.toLowerCase() %>.
                    </div>
                <% } %>

                <%
                    String error = request.getParameter("error");
                    if (error != null) {
                        String errorMessage = "";
                        if (error.equals("auth")) {
                            String roleParam = request.getParameter("role");
                            if (roleParam != null && !roleParam.isEmpty()) {
                                errorMessage = "Invalid username or password for " + roleParam.toLowerCase() + " role. Please try again.";
                            } else {
                                errorMessage = "Invalid username or password. Please try again.";
                            }
                        } else if (error.equals("missing")) {
                            errorMessage = "Please fill in all required fields.";
                        } else if (error.equals("invalid")) {
                            errorMessage = "Invalid login attempt. Please try again.";
                        } else if (error.equals("session")) {
                            errorMessage = "Your session has expired. Please login again.";
                        } else {
                            errorMessage = "An error occurred. Please try again.";
                        }
                %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
                    </div>
                <% } %>

                <%
                    String redirectParam = request.getParameter("redirect");
                    String formAction = "login-handler.jsp" + (redirectParam != null ? "?redirect=" + redirectParam : "");
                %>
                <form action="<%= formAction %>" method="post" class="login-form">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user"></i>
                            <input type="text" id="username" name="username" placeholder="Enter your username" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-with-icon">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="role">Login As (Optional)</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user-tag"></i>
                            <select id="role" name="role">
                                <option value="">Auto-detect role</option>
                                <option value="ADMIN">Admin</option>
                                <option value="DOCTOR">Doctor</option>
                                <option value="PATIENT">Patient</option>
                            </select>
                        </div>
                        <small>If you have multiple roles, select the specific role you want to login as.</small>
                    </div>

                    <div class="remember-forgot">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Remember me</label>
                        </div>
                        <div class="forgot-password">
                            <a href="forgot-password.jsp">Forgot password?</a>
                        </div>
                    </div>

                    <button type="submit" class="btn">Login</button>

                    <div class="register-link">
                        <p>Don't have an account? <a href="register.jsp">Register now</a></p>
                    </div>

                    <div class="divider">
                        <span>OR</span>
                    </div>

                    <div class="social-login">
                        <a href="#" class="social-btn google">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-btn facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-btn apple">
                            <i class="fab fa-apple"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('.login-form');
            const roleSelect = document.getElementById('role');
            const usernameField = document.getElementById('username');
            const usernameLabel = document.querySelector('label[for="username"]');

            // Function to update form based on selected role
            function updateFormForRole(role) {
                // Reset to default
                usernameLabel.textContent = 'Username';
                usernameField.placeholder = 'Enter your username';

                // Update based on role
                if (role === 'ADMIN') {
                    usernameLabel.textContent = 'Email';
                    usernameField.placeholder = 'Enter your email';
                } else if (role === 'DOCTOR') {
                    usernameLabel.textContent = 'Email';
                    usernameField.placeholder = 'Enter your email';
                } else if (role === 'PATIENT') {
                    usernameLabel.textContent = 'Username or Email';
                    usernameField.placeholder = 'Enter your username or email';
                }
            }

            // Initial update
            updateFormForRole(roleSelect.value);

            // Update on role change
            roleSelect.addEventListener('change', function() {
                updateFormForRole(this.value);
            });

            // Form validation
            form.addEventListener('submit', function(event) {
                let hasError = false;

                // Validate required fields
                const requiredFields = form.querySelectorAll('[required]');
                requiredFields.forEach(field => {
                    if (!field.value.trim()) {
                        event.preventDefault();
                        hasError = true;
                        field.style.borderColor = '#d32f2f';
                    } else {
                        field.style.borderColor = '#ddd';
                    }
                });

                if (hasError) {
                    // Create error message
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'error-message';
                    errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> Please fill in all required fields.';

                    // Insert at the top of the form
                    const formHeader = document.querySelector('.form-header');
                    formHeader.insertAdjacentElement('afterend', errorDiv);
                }
            });

            // Set role from URL parameter if present
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('role')) {
                const roleParam = urlParams.get('role');
                if (roleParam) {
                    roleSelect.value = roleParam;
                    updateFormForRole(roleParam);
                }
            }
        });