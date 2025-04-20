/**
 * LifeCare Medical Center - Main JavaScript File
 * This file contains all the JavaScript functionality for the Hospital Management System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initFormValidation();
    initSmoothScroll();
    initAnimations();
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
 * Form Validation
 * Validates forms before submission
 */
function initFormValidation() {
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            let isValid = true;
            
            // Validate required fields
            const requiredFields = form.querySelectorAll('[required]');
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    highlightInvalidField(field, 'This field is required');
                } else {
                    removeInvalidHighlight(field);
                }
            });
            
            // Validate email fields
            const emailFields = form.querySelectorAll('input[type="email"]');
            emailFields.forEach(field => {
                if (field.value.trim() && !isValidEmail(field.value)) {
                    isValid = false;
                    highlightInvalidField(field, 'Please enter a valid email address');
                }
            });
            
            // Validate password match if confirm password exists
            const passwordField = form.querySelector('input[name="password"]');
            const confirmPasswordField = form.querySelector('input[name="confirmPassword"]');
            if (passwordField && confirmPasswordField) {
                if (passwordField.value !== confirmPasswordField.value) {
                    isValid = false;
                    highlightInvalidField(confirmPasswordField, 'Passwords do not match');
                }
            }
            
            if (!isValid) {
                event.preventDefault();
            }
        });
    });
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
 * Validate email format
 */
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Smooth Scroll
 * Enables smooth scrolling for anchor links
 */
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                
                // Update URL without page reload
                history.pushState(null, null, targetId);
            }
        });
    });
}

/**
 * Animations
 * Adds scroll-based animations to elements
 */
function initAnimations() {
    const animatedElements = document.querySelectorAll('.animate-on-scroll');
    
    const checkInView = () => {
        animatedElements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            const elementVisible = 150;
            
            if (elementTop < window.innerHeight - elementVisible) {
                element.classList.add('visible');
            }
        });
    };
    
    // Check on initial load
    checkInView();
    
    // Check on scroll
    window.addEventListener('scroll', checkInView);
}

/**
 * Calculate BMI
 * Calculates BMI when height and weight are entered
 */
function calculateBMI() {
    const heightInput = document.getElementById('height');
    const weightInput = document.getElementById('weight');
    const bmiInput = document.getElementById('bmi');
    
    if (heightInput && weightInput && bmiInput) {
        const calculateAndUpdateBMI = () => {
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
        };
        
        heightInput.addEventListener('input', calculateAndUpdateBMI);
        weightInput.addEventListener('input', calculateAndUpdateBMI);
    }
}

/**
 * Appointment Date Validation
 * Ensures appointment dates are in the future
 */
function initAppointmentDateValidation() {
    const dateInput = document.getElementById('appointmentDate');
    if (dateInput) {
        // Set min date to today
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const formattedDate = `${yyyy}-${mm}-${dd}`;
        
        dateInput.setAttribute('min', formattedDate);
        
        // Validate on change
        dateInput.addEventListener('change', function() {
            const selectedDate = new Date(this.value);
            if (selectedDate < today) {
                highlightInvalidField(this, 'Please select a future date');
            } else {
                removeInvalidHighlight(this);
            }
        });
    }
}

// Initialize additional components if needed
document.addEventListener('DOMContentLoaded', function() {
    calculateBMI();
    initAppointmentDateValidation();
});
