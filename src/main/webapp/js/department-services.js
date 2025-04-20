/**
 * LifeCare Medical Center - Department Services Page JavaScript
 * This file contains JavaScript functionality specific to the department services page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initAnimations();
    initDepartmentNavigation();
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
 * Adds scroll-based animations to elements
 */
function initAnimations() {
    // General animations for elements with animate-on-scroll class
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

    // Department section animations
    const departmentSections = document.querySelectorAll('.department-section');
    departmentSections.forEach((section, index) => {
        // Add animation classes
        section.classList.add('animate-section');
        section.style.transitionDelay = `${index * 0.1}s`;

        // Animate department header
        const header = section.querySelector('.department-header');
        if (header) {
            header.classList.add('animate-from-left');
        }

        // Animate department content
        const content = section.querySelector('.department-content');
        if (content) {
            content.classList.add('animate-from-bottom');
        }

        // Animate service cards with staggered delay
        const serviceCards = section.querySelectorAll('.service-card');
        serviceCards.forEach((card, cardIndex) => {
            card.classList.add('animate-from-bottom');
            card.style.transitionDelay = `${0.2 + (cardIndex * 0.1)}s`;
        });

        // Animate doctor cards with staggered delay
        const doctorCards = section.querySelectorAll('.doctor-card');
        doctorCards.forEach((card, cardIndex) => {
            card.classList.add('animate-from-bottom');
            card.style.transitionDelay = `${0.3 + (cardIndex * 0.1)}s`;
        });

        // Animate FAQ items with staggered delay
        const faqItems = section.querySelectorAll('.faq-item');
        faqItems.forEach((item, itemIndex) => {
            item.classList.add('animate-from-right');
            item.style.transitionDelay = `${0.2 + (itemIndex * 0.05)}s`;
        });

        // Animate CTA section
        const cta = section.querySelector('.department-cta');
        if (cta) {
            cta.classList.add('animate-from-bottom');
            cta.style.transitionDelay = '0.4s';
        }
    });

    // Function to check if sections are in view and trigger animations
    const animateSections = () => {
        departmentSections.forEach(section => {
            const sectionTop = section.getBoundingClientRect().top;
            const windowHeight = window.innerHeight;

            if (sectionTop < windowHeight - 100) {
                section.classList.add('visible');
            }
        });
    };

    // Check on initial load with a slight delay to ensure DOM is ready
    setTimeout(animateSections, 100);

    // Check on scroll
    window.addEventListener('scroll', animateSections);
}

/**
 * Department Navigation
 * Handles the smooth scrolling and active state of department navigation
 */
function initDepartmentNavigation() {
    const departmentNavItems = document.querySelectorAll('.department-nav-item');

    // Set active department based on URL hash or default to first department
    const setActiveDepartment = () => {
        const hash = window.location.hash || '#general-medicine';

        departmentNavItems.forEach(item => {
            if (item.getAttribute('href') === hash) {
                item.classList.add('active');
            } else {
                item.classList.remove('active');
            }
        });

        // Scroll to department section with offset for fixed header
        const departmentSection = document.querySelector(hash);
        if (departmentSection) {
            const headerHeight = 100; // Approximate header height
            const sectionTop = departmentSection.getBoundingClientRect().top + window.pageYOffset;
            window.scrollTo({
                top: sectionTop - headerHeight,
                behavior: 'smooth'
            });
        }
    };

    // Set active department on page load
    if (window.location.hash) {
        setTimeout(setActiveDepartment, 100);
    } else {
        // If no hash, set the first department as active
        if (departmentNavItems.length > 0) {
            departmentNavItems[0].classList.add('active');
        }
    }

    // Update active department on hash change
    window.addEventListener('hashchange', setActiveDepartment);

    // Smooth scroll to department section on click
    departmentNavItems.forEach(item => {
        item.addEventListener('click', function(event) {
            event.preventDefault();

            const hash = this.getAttribute('href');
            window.location.hash = hash;

            // Update active state
            departmentNavItems.forEach(navItem => {
                navItem.classList.remove('active');
            });
            this.classList.add('active');

            // Scroll to section
            const departmentSection = document.querySelector(hash);
            if (departmentSection) {
                const headerHeight = 100; // Approximate header height
                const sectionTop = departmentSection.getBoundingClientRect().top + window.pageYOffset;
                window.scrollTo({
                    top: sectionTop - headerHeight,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Handle horizontal scrolling for department navigation
    const departmentNav = document.querySelector('.department-nav-list');
    if (departmentNav) {
        let isDown = false;
        let startX;
        let scrollLeft;

        departmentNav.addEventListener('mousedown', (e) => {
            isDown = true;
            startX = e.pageX - departmentNav.offsetLeft;
            scrollLeft = departmentNav.scrollLeft;
        });

        departmentNav.addEventListener('mouseleave', () => {
            isDown = false;
        });

        departmentNav.addEventListener('mouseup', () => {
            isDown = false;
        });

        departmentNav.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - departmentNav.offsetLeft;
            const walk = (x - startX) * 2; // Scroll speed
            departmentNav.scrollLeft = scrollLeft - walk;
        });

        // Add touch support for mobile devices
        departmentNav.addEventListener('touchstart', (e) => {
            isDown = true;
            startX = e.touches[0].pageX - departmentNav.offsetLeft;
            scrollLeft = departmentNav.scrollLeft;
        });

        departmentNav.addEventListener('touchend', () => {
            isDown = false;
        });

        departmentNav.addEventListener('touchmove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.touches[0].pageX - departmentNav.offsetLeft;
            const walk = (x - startX) * 2;
            departmentNav.scrollLeft = scrollLeft - walk;
        });
    }

    // Highlight the active department in the navigation when scrolling
    window.addEventListener('scroll', () => {
        const scrollPosition = window.scrollY;

        // Find which section is currently in view
        document.querySelectorAll('.department-section').forEach(section => {
            const sectionTop = section.offsetTop - 150; // Offset for header
            const sectionHeight = section.offsetHeight;
            const sectionId = '#' + section.getAttribute('id');

            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                // Remove active class from all nav items
                departmentNavItems.forEach(item => {
                    item.classList.remove('active');
                });

                // Add active class to corresponding nav item
                const activeNavItem = document.querySelector(`.department-nav-item[href="${sectionId}"]`);
                if (activeNavItem) {
                    activeNavItem.classList.add('active');

                    // Scroll the navigation to show the active item
                    if (departmentNav) {
                        const navItemLeft = activeNavItem.offsetLeft;
                        const navItemWidth = activeNavItem.offsetWidth;
                        const navWidth = departmentNav.offsetWidth;

                        departmentNav.scrollLeft = navItemLeft - (navWidth / 2) + (navItemWidth / 2);
                    }
                }
            }
        });
    });
}

/**
 * FAQ Accordion
 * Handles the expanding and collapsing of FAQ items
 */
function initFaqAccordion() {
    const faqItems = document.querySelectorAll('.faq-item');

    if (faqItems.length === 0) return;

    // Add keyboard accessibility
    faqItems.forEach((item, index) => {
        const question = item.querySelector('.faq-question');
        const answer = item.querySelector('.faq-answer');

        // Add ARIA attributes for accessibility
        if (question && answer) {
            const id = `faq-answer-${index}`;
            question.setAttribute('aria-expanded', 'false');
            question.setAttribute('aria-controls', id);
            question.setAttribute('role', 'button');
            question.setAttribute('tabindex', '0');
            answer.setAttribute('id', id);
            answer.setAttribute('aria-hidden', 'true');
        }

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
            if (question && answer) {
                question.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
                answer.setAttribute('aria-hidden', isExpanded ? 'false' : 'true');
            }
        });

        // Add keyboard event listener
        question.addEventListener('keydown', (event) => {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                question.click();
            }
        });
    });

    // Open the first FAQ item by default on mobile devices
    if (window.innerWidth < 768 && faqItems.length > 0) {
        const firstQuestion = faqItems[0].querySelector('.faq-question');
        if (firstQuestion) {
            firstQuestion.click();
        }
    }
}
