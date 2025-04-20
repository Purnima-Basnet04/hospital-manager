/**
 * LifeCare Medical Center - Login Page JavaScript
 * This file contains JavaScript functionality specific to the login page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initLoginFormValidation();
    checkForLoginError();
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
 * Login Form Validation
 * Validates the login form before submission
 */
function initLoginFormValidation() {
    const loginForm = document.getElementById('loginForm');

    if (loginForm) {
        loginForm.addEventListener('submit', function(event) {
            let isValid = true;

            // Validate username
            const username = document.getElementById('username');
            if (!username.value.trim()) {
                isValid = false;
                highlightInvalidField(username, 'Username is required');
            } else {
                removeInvalidHighlight(username);
            }

            // Validate password
            const password = document.getElementById('password');
            if (!password.value.trim()) {
                isValid = false;
                highlightInvalidField(password, 'Password is required');
            } else {
                removeInvalidHighlight(password);
            }

            // Validate role selection
            const role = document.getElementById('role');
            if (!role.value) {
                isValid = false;
                highlightInvalidField(role, 'Please select a role');
            } else {
                removeInvalidHighlight(role);
            }

            if (!isValid) {
                event.preventDefault();
            }
        });
    }
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

/**
 * Check for login error parameter in URL
 * Displays error message if error parameter is present
 */
function checkForLoginError() {
    // Get URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');

    // If error parameter is '1', show the error message
    if (error === '1') {
        const errorMessage = document.getElementById('errorMessage');
        if (errorMessage) {
            errorMessage.style.display = 'block';

            // Scroll to error message
            errorMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });

            // Add animation to draw attention
            errorMessage.classList.add('shake');

            // Remove animation class after animation completes
            setTimeout(() => {
                errorMessage.classList.remove('shake');
            }, 1000);
        }
    }
}
