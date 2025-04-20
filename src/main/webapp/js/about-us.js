/**
 * LifeCare Medical Center - About Us Page JavaScript
 * This file contains JavaScript functionality specific to the about us page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initAnimations();
    initTimelineAnimation();
    initCounters();
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
}

/**
 * Timeline Animation
 */
function initTimelineAnimation() {
    const timelineItems = document.querySelectorAll('.timeline-item');

    const animateTimeline = () => {
        timelineItems.forEach(item => {
            const itemTop = item.getBoundingClientRect().top;
            const itemVisible = 150;

            if (itemTop < window.innerHeight - itemVisible) {
                item.classList.add('visible');
            }
        });
    };

    // Add initial classes
    timelineItems.forEach((item, index) => {
        item.style.opacity = '0';
        item.style.transform = 'translateY(20px)';
        item.style.transition = `all 0.5s ease ${index * 0.2}s`;
    });

    // Check on initial load
    animateTimeline();

    // Check on scroll
    window.addEventListener('scroll', animateTimeline);
}

/**
 * Animated Counters
 */
function initCounters() {
    const counters = document.querySelectorAll('.counter');

    if (!counters.length) return;

    const animateCounter = (counter, target) => {
        let count = 0;
        const duration = 2000; // 2 seconds
        const increment = target / (duration / 16); // 60fps

        const updateCount = () => {
            count += increment;
            if (count < target) {
                counter.textContent = Math.ceil(count);
                requestAnimationFrame(updateCount);
            } else {
                counter.textContent = target;
            }
        };

        updateCount();
    };

    const checkCounters = () => {
        counters.forEach(counter => {
            const elementTop = counter.getBoundingClientRect().top;
            const elementVisible = 150;

            if (elementTop < window.innerHeight - elementVisible && !counter.classList.contains('counted')) {
                counter.classList.add('counted');
                const target = parseInt(counter.getAttribute('data-target'));
                animateCounter(counter, target);
            }
        });
    };

    // Check on initial load
    checkCounters();

    // Check on scroll
    window.addEventListener('scroll', checkCounters);
}
