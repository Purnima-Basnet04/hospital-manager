/**
 * LifeCare Medical Center - Register Page JavaScript
 * This file contains JavaScript functionality specific to the registration page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initRegisterFormValidation();
    initPasswordStrengthMeter();
    initDateOfBirthValidation();
});

/**
 * Mobile Navigation Toggle
 * Handles the responsive navigation menu for mobile devices
 */
function initMobileNavigation() {
    const navToggle = document.createElement('button');
    navToggle.className = 'nav-toggle';
    navToggle.innerHTML = '<span></span><span></span><span></span>';
    navToggle.setAttribute('aria-label', 'Toggle Navigation');
    
    const nav = document.querySelector('nav');
    if (nav) {
        nav.parentNode.insertBefore(navToggle, nav);
        
        navToggle.addEventListener('click', function() {
            nav.classList.toggle('active');
            navToggle.classList.toggle('active');
            document.body.classList.toggle('nav-open');
        });
    }
}

/**
 * Register Form Validation
 * Validates the registration form before submission
 */
function initRegisterFormValidation() {
    const registerForm = document.querySelector('.register-form');
    
    if (registerForm) {
        registerForm.addEventListener('submit', function(event) {
            let isValid = true;
            
            // Validate required fields
            const requiredFields = registerForm.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    highlightInvalidField(field, 'This field is required');
                } else {
                    removeInvalidHighlight(field);
                }
            });
            
            // Validate email format
            const emailField = document.getElementById('email');
            if (emailField.value.trim() && !isValidEmail(emailField.value)) {
                isValid = false;
                highlightInvalidField(emailField, 'Please enter a valid email address');
            }
            
            // Validate password match
            const passwordField = document.getElementById('password');
            const confirmPasswordField = document.getElementById('confirmPassword');
            if (passwordField.value !== confirmPasswordField.value) {
                isValid = false;
                highlightInvalidField(confirmPasswordField, 'Passwords do not match');
            }
            
            // Validate phone number
            const phoneField = document.getElementById('phone');
            if (phoneField.value.trim() && !isValidPhone(phoneField.value)) {
                isValid = false;
                highlightInvalidField(phoneField, 'Please enter a valid phone number');
            }
            
            if (!isValid) {
                event.preventDefault();
            }
        });
    }
}

/**
 * Password Strength Meter
 * Shows the strength of the password as the user types
 */
function initPasswordStrengthMeter() {
    const passwordField = document.getElementById('password');
    
    if (passwordField) {
        // Create password strength indicator
        const strengthIndicator = document.createElement('div');
        strengthIndicator.className = 'password-strength';
        passwordField.parentNode.appendChild(strengthIndicator);
        
        // Add small text to show password requirements
        const passwordHint = document.createElement('small');
        passwordHint.textContent = 'Password should be at least 8 characters with letters, numbers, and special characters';
        passwordField.parentNode.appendChild(passwordHint);
        
        passwordField.addEventListener('input', function() {
            const password = this.value;
            const strength = checkPasswordStrength(password);
            
            // Update strength indicator
            strengthIndicator.className = 'password-strength';
            if (password.length > 0) {
                if (strength < 3) {
                    strengthIndicator.classList.add('weak');
                    passwordHint.textContent = 'Weak password - add numbers and special characters';
                } else if (strength < 5) {
                    strengthIndicator.classList.add('medium');
                    passwordHint.textContent = 'Medium password - add more variety for better security';
                } else {
                    strengthIndicator.classList.add('strong');
                    passwordHint.textContent = 'Strong password';
                }
            } else {
                passwordHint.textContent = 'Password should be at least 8 characters with letters, numbers, and special characters';
            }
        });
    }
}

/**
 * Date of Birth Validation
 * Ensures the date of birth is in the past and not in the future
 */
function initDateOfBirthValidation() {
    const dobField = document.getElementById('dateOfBirth');
    
    if (dobField) {
        // Set max date to today
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const formattedDate = `${yyyy}-${mm}-${dd}`;
        
        dobField.setAttribute('max', formattedDate);
        
        // Add small text to show date format
        const dobHint = document.createElement('small');
        dobHint.textContent = 'Date must be in the past';
        dobField.parentNode.appendChild(dobHint);
        
        // Validate on change
        dobField.addEventListener('change', function() {
            const selectedDate = new Date(this.value);
            if (selectedDate > today) {
                highlightInvalidField(this, 'Date of birth cannot be in the future');
            } else {
                removeInvalidHighlight(this);
            }
        });
    }
}

/**
 * Check Password Strength
 * Returns a score from 0-6 based on password complexity
 */
function checkPasswordStrength(password) {
    let score = 0;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character variety checks
    if (/[a-z]/.test(password)) score++; // lowercase
    if (/[A-Z]/.test(password)) score++; // uppercase
    if (/[0-9]/.test(password)) score++; // numbers
    if (/[^a-zA-Z0-9]/.test(password)) score++; // special characters
    
    return score;
}

/**
 * Validate Email Format
 */
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Validate Phone Number Format
 * Accepts formats like: (123) 456-7890, 123-456-7890, 123.456.7890, 1234567890
 */
function isValidPhone(phone) {
    const phoneRegex = /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/;
    return phoneRegex.test(phone);
}

/**
 * Highlight invalid form field
 */
function highlightInvalidField(field, message) {
    field.classList.add('invalid');
    
    // Create or update error message
    let errorMessage = field.parentNode.querySelector('.error-text');
    if (!errorMessage) {
        errorMessage = document.createElement('div');
        errorMessage.className = 'error-text';
        field.parentNode.appendChild(errorMessage);
    }
    errorMessage.textContent = message;
}

/**
 * Remove invalid highlight from form field
 */
function removeInvalidHighlight(field) {
    field.classList.remove('invalid');
    const errorMessage = field.parentNode.querySelector('.error-text');
    if (errorMessage) {
        errorMessage.remove();
    }
}
