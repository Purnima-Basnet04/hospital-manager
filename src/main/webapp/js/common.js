/**
 * LifeCare Medical Center - Common JavaScript
 * This file contains JavaScript functionality shared across all pages
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize common components
    initMobileNavigation();
    initAnimations();
    initTooltips();
    initAccessibility();
    initHeaderScroll();
    initSmoothScroll();
    initFormValidation();
    initAccordions();
    initTabs();
});

/**
 * Mobile Navigation Toggle
 * Handles the responsive navigation menu for mobile devices
 */
function initMobileNavigation() {
    // Create mobile toggle button if it doesn't exist
    if (!document.querySelector('.nav-toggle')) {
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

            // Close navigation when clicking outside
            document.addEventListener('click', function(event) {
                if (nav.classList.contains('active') &&
                    !nav.contains(event.target) &&
                    !navToggle.contains(event.target)) {
                    nav.classList.remove('active');
                    navToggle.classList.remove('active');
                    document.body.classList.remove('nav-open');
                }
            });
        }
    }
}

/**
 * Animations
 * Adds scroll-based animations to elements
 */
function initAnimations() {
    const animatedElements = document.querySelectorAll('.animate-on-scroll');

    if (animatedElements.length > 0) {
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
}

/**
 * Tooltips
 * Initializes tooltips for elements with data-tooltip attribute
 */
function initTooltips() {
    const tooltipElements = document.querySelectorAll('[data-tooltip]');

    tooltipElements.forEach(element => {
        element.addEventListener('mouseenter', function() {
            const tooltipText = this.getAttribute('data-tooltip');

            // Create tooltip element
            const tooltip = document.createElement('div');
            tooltip.className = 'tooltip';
            tooltip.textContent = tooltipText;

            // Position tooltip
            document.body.appendChild(tooltip);
            const elementRect = this.getBoundingClientRect();
            const tooltipRect = tooltip.getBoundingClientRect();

            tooltip.style.top = (elementRect.top - tooltipRect.height - 10) + 'px';
            tooltip.style.left = (elementRect.left + (elementRect.width / 2) - (tooltipRect.width / 2)) + 'px';

            // Add active class
            tooltip.classList.add('active');

            // Store tooltip reference
            this.tooltip = tooltip;
        });

        element.addEventListener('mouseleave', function() {
            if (this.tooltip) {
                this.tooltip.remove();
                this.tooltip = null;
            }
        });
    });
}

/**
 * Accessibility Enhancements
 */
function initAccessibility() {
    // Add focus styles for keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Tab') {
            document.body.classList.add('keyboard-navigation');
        }
    });

    document.addEventListener('mousedown', function() {
        document.body.classList.remove('keyboard-navigation');
    });

    // Skip to content link
    const skipLink = document.createElement('a');
    skipLink.href = '#main';
    skipLink.className = 'skip-link';
    skipLink.textContent = 'Skip to content';
    document.body.insertBefore(skipLink, document.body.firstChild);

    // Add id to main content if not present
    const main = document.querySelector('main');
    if (main && !main.id) {
        main.id = 'main';
    }
}

/**
 * Form Validation Helpers
 */

// Validate email format
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

// Validate phone number format
function isValidPhone(phone) {
    const phoneRegex = /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$/;
    return phoneRegex.test(phone);
}

// Highlight invalid form field
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

// Remove invalid highlight from form field
function removeInvalidHighlight(field) {
    field.classList.remove('invalid');
    const errorMessage = field.parentNode.querySelector('.error-text');
    if (errorMessage) {
        errorMessage.remove();
    }
}

/**
 * Header Scroll Effect
 * Adds a class to the header when scrolling down
 */
function initHeaderScroll() {
    const header = document.querySelector('header');
    if (header) {
        const scrollThreshold = 50;

        const handleScroll = () => {
            if (window.scrollY > scrollThreshold) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        };

        // Check on initial load
        handleScroll();

        // Check on scroll with debounce for performance
        window.addEventListener('scroll', debounce(handleScroll, 10));
    }
}

/**
 * Smooth Scroll
 * Adds smooth scrolling to anchor links
 */
function initSmoothScroll() {
    const anchorLinks = document.querySelectorAll('a[href^="#"]:not(.skip-link)');

    anchorLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                e.preventDefault();

                window.scrollTo({
                    top: targetElement.offsetTop - 80, // Offset for fixed header
                    behavior: 'smooth'
                });

                // Update URL without scrolling
                history.pushState(null, null, targetId);
            }
        });
    });
}

/**
 * Form Validation
 * Adds validation to forms
 */
function initFormValidation() {
    const forms = document.querySelectorAll('form');

    forms.forEach(form => {
        // Validate on submit
        form.addEventListener('submit', function(e) {
            let isValid = true;
            const requiredFields = form.querySelectorAll('[required]');

            requiredFields.forEach(field => {
                if (!validateField(field)) {
                    isValid = false;
                }
            });

            if (!isValid) {
                e.preventDefault();
                // Scroll to first invalid field
                const firstInvalid = form.querySelector('.invalid');
                if (firstInvalid) {
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                    firstInvalid.focus();
                }
            }
        });

        // Validate on blur
        const fields = form.querySelectorAll('input, select, textarea');
        fields.forEach(field => {
            field.addEventListener('blur', function() {
                validateField(field);
            });

            // Clear error on focus
            field.addEventListener('focus', function() {
                removeInvalidHighlight(field);
            });
        });
    });

    // Field validation function
    function validateField(field) {
        if (!field.value.trim()) {
            if (field.hasAttribute('required')) {
                highlightInvalidField(field, 'This field is required');
                return false;
            }
        } else if (field.type === 'email' && !isValidEmail(field.value)) {
            highlightInvalidField(field, 'Please enter a valid email address');
            return false;
        } else if (field.classList.contains('phone-input') && !isValidPhone(field.value)) {
            highlightInvalidField(field, 'Please enter a valid phone number');
            return false;
        } else if (field.type === 'password' && field.classList.contains('password-strength') && field.value.length < 8) {
            highlightInvalidField(field, 'Password must be at least 8 characters long');
            return false;
        } else {
            removeInvalidHighlight(field);
            return true;
        }

        return true;
    }
}

/**
 * Accordion Functionality
 */
function initAccordions() {
    const accordions = document.querySelectorAll('.accordion');

    accordions.forEach(accordion => {
        const items = accordion.querySelectorAll('.accordion-item');
        const singleOpen = accordion.classList.contains('single-open');

        items.forEach(item => {
            const header = item.querySelector('.accordion-header');
            const content = item.querySelector('.accordion-content');

            if (header && content) {
                header.addEventListener('click', function() {
                    // If single open mode, close other items
                    if (singleOpen) {
                        items.forEach(otherItem => {
                            if (otherItem !== item && otherItem.classList.contains('active')) {
                                otherItem.classList.remove('active');
                                const otherContent = otherItem.querySelector('.accordion-content');
                                if (otherContent) {
                                    otherContent.style.maxHeight = null;
                                }
                            }
                        });
                    }

                    // Toggle current item
                    item.classList.toggle('active');

                    // Animate content height
                    if (item.classList.contains('active')) {
                        content.style.maxHeight = content.scrollHeight + 'px';
                    } else {
                        content.style.maxHeight = null;
                    }
                });
            }
        });

        // Open first item by default if specified
        if (accordion.classList.contains('first-open') && items.length > 0) {
            items[0].classList.add('active');
            const content = items[0].querySelector('.accordion-content');
            if (content) {
                content.style.maxHeight = content.scrollHeight + 'px';
            }
        }
    });
}

/**
 * Tabs Functionality
 */
function initTabs() {
    const tabContainers = document.querySelectorAll('.tabs-container');

    tabContainers.forEach(container => {
        const tabButtons = container.querySelectorAll('.tab-button');
        const tabPanels = container.querySelectorAll('.tab-panel');

        // Set up tab switching
        tabButtons.forEach((button, index) => {
            button.addEventListener('click', function() {
                // Deactivate all tabs
                tabButtons.forEach(btn => btn.classList.remove('active'));
                tabPanels.forEach(panel => panel.classList.remove('active'));

                // Activate clicked tab
                button.classList.add('active');
                if (tabPanels[index]) {
                    tabPanels[index].classList.add('active');
                }

                // Update URL hash if data-tab-id is present
                const tabId = button.getAttribute('data-tab-id');
                if (tabId) {
                    history.pushState(null, null, `#${tabId}`);
                }
            });
        });

        // Check for hash in URL to activate specific tab
        const hash = window.location.hash.substring(1);
        if (hash) {
            const tabToActivate = container.querySelector(`.tab-button[data-tab-id="${hash}"]`);
            if (tabToActivate) {
                tabToActivate.click();
                return; // Skip default activation
            }
        }

        // Activate first tab by default
        if (tabButtons.length > 0 && tabPanels.length > 0) {
            tabButtons[0].classList.add('active');
            tabPanels[0].classList.add('active');
        }
    });
}

/**
 * Date Formatting
 */
function formatDate(date) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(date).toLocaleDateString('en-US', options);
}

/**
 * Time Formatting
 */
function formatTime(time) {
    if (!time) return '';

    // Handle different time formats
    let timeObj;
    if (time instanceof Date) {
        timeObj = time;
    } else if (typeof time === 'string') {
        // Handle HH:MM format
        if (time.includes(':')) {
            const [hours, minutes] = time.split(':');
            timeObj = new Date();
            timeObj.setHours(parseInt(hours, 10));
            timeObj.setMinutes(parseInt(minutes, 10));
        } else {
            timeObj = new Date(time);
        }
    } else {
        return '';
    }

    return timeObj.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: true });
}

/**
 * Debounce Function
 * Limits how often a function can be called
 */
function debounce(func, wait) {
    let timeout;
    return function(...args) {
        const context = this;
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(context, args), wait);
    };
}

/**
 * Throttle Function
 * Ensures a function is called at most once in a specified time period
 */
function throttle(func, limit) {
    let inThrottle;
    return function(...args) {
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}
