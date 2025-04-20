/**
 * LifeCare Medical Center - Online Appointment Page JavaScript
 * This file contains JavaScript functionality specific to the online appointment page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initAnimations();
    initAppointmentForm();
    initDateValidation();
    initFaqAccordion();
});

/**
 * Mobile Navigation Toggle
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
 * Animations
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

    // Add animation classes to specific elements
    const appointmentInfo = document.querySelector('.appointment-info');
    if (appointmentInfo) {
        appointmentInfo.classList.add('animate-on-scroll');
    }

    const appointmentForm = document.querySelector('.appointment-form-container');
    if (appointmentForm) {
        appointmentForm.classList.add('animate-on-scroll');
    }

    const steps = document.querySelectorAll('.step');
    steps.forEach((step, index) => {
        step.classList.add('animate-on-scroll');
        step.style.animationDelay = `${0.2 + (index * 0.1)}s`;
    });
}

/**
 * Appointment Form Validation and Submission
 */
function initAppointmentForm() {
    const appointmentForm = document.getElementById('appointmentForm');

    if (appointmentForm) {
        // Add form validation
        appointmentForm.addEventListener('submit', function(event) {
            let isValid = true;

            // Validate department selection
            const department = document.getElementById('department');
            if (department.value === '') {
                isValid = false;
                highlightInvalidField(department, 'Please select a department');
            }

            // Validate full name (at least 3 characters)
            const fullName = document.getElementById('fullName');
            if (fullName.value.trim().length < 3) {
                isValid = false;
                highlightInvalidField(fullName, 'Please enter your full name (at least 3 characters)');
            }

            // Validate age (between 0 and 120)
            const age = document.getElementById('age');
            if (age.value === '' || parseInt(age.value) < 0 || parseInt(age.value) > 120) {
                isValid = false;
                highlightInvalidField(age, 'Please enter a valid age (0-120)');
            }

            // Validate contact number (at least 10 digits)
            const contactNumber = document.getElementById('contactNumber');
            if (!/^[0-9]{10,15}$/.test(contactNumber.value.replace(/[^0-9]/g, ''))) {
                isValid = false;
                highlightInvalidField(contactNumber, 'Please enter a valid contact number (10-15 digits)');
            }

            // Validate email
            const email = document.getElementById('email');
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                isValid = false;
                highlightInvalidField(email, 'Please enter a valid email address');
            }

            // Validate preferred date
            const preferredDate = document.getElementById('appointmentDate');
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const selectedDate = new Date(preferredDate.value);
            selectedDate.setHours(0, 0, 0, 0);

            // Add one day to today to get tomorrow
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);

            if (preferredDate.value === '' || selectedDate < tomorrow) {
                isValid = false;
                highlightInvalidField(preferredDate, 'Please select a date at least one day in the future');
            }

            // Validate preferred time
            const preferredTime = document.getElementById('preferredTime');
            if (preferredTime.value === '') {
                isValid = false;
                highlightInvalidField(preferredTime, 'Please select a preferred time');
            }

            // Validate reason (at least 10 characters)
            const reason = document.getElementById('reason');
            if (reason.value.trim().length < 10) {
                isValid = false;
                highlightInvalidField(reason, 'Please provide more details about your reason for the appointment (at least 10 characters)');
            }

            // If the form is not valid, prevent submission
            if (!isValid) {
                event.preventDefault();

                // Scroll to the first invalid field
                const firstInvalidField = document.querySelector('.invalid-field');
                if (firstInvalidField) {
                    firstInvalidField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } else {
                // If the form is valid, show a success message (in a real implementation, this would be handled by the server)
                // For demo purposes, we'll prevent the form submission and show a success message
                event.preventDefault();

                // Hide the form
                appointmentForm.style.display = 'none';

                // Create and show a success message
                const successMessage = document.createElement('div');
                successMessage.className = 'success-message';
                successMessage.innerHTML = `
                    <div class="success-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="success-content">
                        <h3>Appointment Request Submitted!</h3>
                        <p>Thank you, ${fullName.value}. Your appointment request has been submitted successfully. We will contact you shortly to confirm your appointment.</p>
                    </div>
                `;

                // Insert the success message before the form
                appointmentForm.parentNode.insertBefore(successMessage, appointmentForm);

                // Scroll to the success message
                successMessage.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        });

        // Add input event listeners to clear validation errors when the user types
        const formInputs = appointmentForm.querySelectorAll('input, select, textarea');
        formInputs.forEach(input => {
            input.addEventListener('input', function() {
                clearInvalidField(this);
            });
        });
    }
}

/**
 * Date Input Validation
 */
function initDateValidation() {
    const dateInput = document.getElementById('appointmentDate');

    if (dateInput) {
        // Set min date to tomorrow
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);

        const formattedTomorrow = tomorrow.toISOString().split('T')[0];
        dateInput.min = formattedTomorrow;

        // Set a default date (7 days from today)
        const defaultDate = new Date(today);
        defaultDate.setDate(defaultDate.getDate() + 7);

        const formattedDefaultDate = defaultDate.toISOString().split('T')[0];
        dateInput.value = formattedDefaultDate;
    }
}

/**
 * Highlight Invalid Form Field
 * @param {HTMLElement} field - The form field to highlight
 * @param {string} message - The error message to display
 */
function highlightInvalidField(field, message) {
    // Add invalid class to the field
    field.classList.add('invalid-field');

    // Check if an error message already exists
    let errorMessage = field.parentNode.querySelector('.error-message');

    if (!errorMessage) {
        // Create error message element
        errorMessage = document.createElement('div');
        errorMessage.className = 'error-message';
        errorMessage.textContent = message;

        // Insert error message after the field
        field.parentNode.insertBefore(errorMessage, field.nextSibling);
    } else {
        // Update existing error message
        errorMessage.textContent = message;
    }
}

/**
 * Clear Invalid Form Field
 * @param {HTMLElement} field - The form field to clear
 */
function clearInvalidField(field) {
    // Remove invalid class from the field
    field.classList.remove('invalid-field');

    // Remove error message if it exists
    const errorMessage = field.parentNode.querySelector('.error-message');
    if (errorMessage) {
        errorMessage.remove();
    }
}

/**
 * FAQ Accordion
 * Handles the expanding and collapsing of FAQ items with accessibility support
 */
function initFaqAccordion() {
    const faqItems = document.querySelectorAll('.faq-item');

    if (faqItems.length === 0) return;

    // Add keyboard accessibility and ARIA attributes
    faqItems.forEach((item, index) => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');

        if (question && answer) {
            // Generate unique IDs for ARIA attributes
            const questionId = `faq-question-${index}`;
            const answerId = `faq-answer-${index}`;

            // Set ARIA attributes
            question.setAttribute('id', questionId);
            question.setAttribute('aria-expanded', 'false');
            question.setAttribute('aria-controls', answerId);
            question.setAttribute('role', 'button');
            question.setAttribute('tabindex', '0');

            answer.setAttribute('id', answerId);
            answer.setAttribute('aria-labelledby', questionId);
            answer.setAttribute('role', 'region');
            answer.setAttribute('aria-hidden', 'true');

            // Add click event listener
            question.addEventListener('click', () => {
                // Close all other items
                faqItems.forEach(otherItem => {
                    if (otherItem !== item && otherItem.classList.contains('active')) {
                        const otherQuestion = otherItem.querySelector('.faq-question');
                        const otherAnswer = otherItem.querySelector('.faq-answer');

                        otherItem.classList.remove('active');
                        if (otherQuestion && otherAnswer) {
                            otherQuestion.setAttribute('aria-expanded', 'false');
                            otherAnswer.setAttribute('aria-hidden', 'true');
                        }
                    }
                });

                // Toggle current item
                const isExpanded = item.classList.toggle('active');
                question.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
                answer.setAttribute('aria-hidden', isExpanded ? 'false' : 'true');
            });

            // Add keyboard event listener for accessibility
            question.addEventListener('keydown', (event) => {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    question.click();
                }
            });
        }
    });

    // Open the first FAQ item by default on mobile devices
    if (window.innerWidth < 768 && faqItems.length > 0) {
        const firstQuestion = faqItems[0].querySelector('.faq-question');
        if (firstQuestion) {
            setTimeout(() => {
                firstQuestion.click();
            }, 1000); // Delay to ensure animations have completed
        }
    }
}
