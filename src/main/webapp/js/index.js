/**
 * LifeCare Medical Center - Index Page JavaScript
 * This file contains JavaScript functionality specific to the homepage
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initAnimations();
    
    // Add any page-specific functionality here
    initHeroAnimation();
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
 * Hero Animation
 * Adds a subtle animation to the hero section
 */
function initHeroAnimation() {
    const hero = document.querySelector('.hero');
    if (hero) {
        // Add a subtle parallax effect on mouse move
        hero.addEventListener('mousemove', function(e) {
            const moveX = (e.clientX - window.innerWidth / 2) * 0.01;
            const moveY = (e.clientY - window.innerHeight / 2) * 0.01;
            
            hero.style.backgroundPosition = `calc(50% + ${moveX}px) calc(50% + ${moveY}px)`;
        });
        
        // Reset when mouse leaves
        hero.addEventListener('mouseleave', function() {
            hero.style.backgroundPosition = '50% 50%';
        });
    }
}
