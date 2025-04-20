/**
 * LifeCare Medical Center - Doctor Consultation Page JavaScript
 * This file contains JavaScript functionality specific to the doctor consultation page
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileNavigation();
    initAnimations();
    initDoctorSearch();
    initFaqAccordion();
    initConsultationTypeSelection();
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

    // Add animation classes to specific elements
    const heroSection = document.querySelector('.consultation-hero');
    if (heroSection) {
        heroSection.classList.add('animate-fade-in');
    }

    const typeCards = document.querySelectorAll('.type-card');
    typeCards.forEach((card, index) => {
        card.classList.add('animate-slide-up');
        card.style.animationDelay = `${0.1 + (index * 0.1)}s`;
    });

    const stepItems = document.querySelectorAll('.step-item');
    stepItems.forEach((item, index) => {
        item.classList.add('animate-fade-in');
        item.style.animationDelay = `${0.2 + (index * 0.1)}s`;
    });

    const doctorCards = document.querySelectorAll('.doctor-card');
    doctorCards.forEach((card, index) => {
        card.classList.add('animate-slide-up');
        card.style.animationDelay = `${0.1 + (index * 0.1)}s`;
    });

    const testimonialCards = document.querySelectorAll('.testimonial-card');
    testimonialCards.forEach((card, index) => {
        card.classList.add('animate-fade-in');
        card.style.animationDelay = `${0.1 + (index * 0.1)}s`;
    });

    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach((item, index) => {
        item.classList.add('animate-slide-up');
        item.style.animationDelay = `${0.1 + (index * 0.05)}s`;
    });
}

/**
 * Doctor Search
 * Handles the doctor search functionality and doctor card interactions
 */
function initDoctorSearch() {
    const searchForm = document.querySelector('.search-form');
    const doctorsList = document.querySelector('.doctors-list');
    const doctorCards = document.querySelectorAll('.doctor-card');

    // Initialize date input with today's date
    const dateInput = document.getElementById('date');
    if (dateInput) {
        const today = new Date();
        const formattedDate = today.toISOString().split('T')[0];
        dateInput.value = formattedDate;
        dateInput.min = formattedDate; // Prevent selecting past dates
    }

    // Handle search form submission
    if (searchForm) {
        searchForm.addEventListener('submit', function(event) {
            event.preventDefault();

            // Get search parameters
            const specialty = document.getElementById('specialty').value;
            const location = document.getElementById('location').value;
            const date = document.getElementById('date').value;
            const consultationType = document.getElementById('consultation-type').value;

            console.log('Search parameters:', { specialty, location, date, consultationType });

            // Show loading state
            const submitButton = this.querySelector('button[type="submit"]');
            if (submitButton) {
                const originalText = submitButton.textContent;
                submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Searching...';
                submitButton.disabled = true;

                // Simulate search delay
                setTimeout(() => {
                    submitButton.innerHTML = originalText;
                    submitButton.disabled = false;

                    // In a real implementation, this would fetch doctors based on search parameters
                    // For this demo, we'll just filter the existing doctor cards
                    filterDoctors(specialty, location, consultationType);

                    // Scroll to doctors list
                    if (doctorsList) {
                        doctorsList.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                }, 1000);
            }
        });
    }

    // Filter doctors based on search criteria
    function filterDoctors(specialty, location, consultationType) {
        if (!doctorCards.length) return;

        let visibleCount = 0;

        doctorCards.forEach(card => {
            // In a real implementation, we would check actual data attributes
            // For this demo, we'll use the text content
            const doctorSpecialty = card.querySelector('.specialty').textContent.toLowerCase();
            const doctorLocation = card.querySelector('.detail-item:first-child').textContent.toLowerCase();
            const doctorConsultationTypes = card.querySelector('.detail-item:nth-child(3)').textContent.toLowerCase();

            // Check if the doctor matches the search criteria
            const matchesSpecialty = !specialty || doctorSpecialty.includes(specialty.toLowerCase());
            const matchesLocation = !location || doctorLocation.includes(location.toLowerCase());
            const matchesConsultationType = !consultationType || doctorConsultationTypes.includes(consultationType.toLowerCase());

            // Show or hide the doctor card
            if (matchesSpecialty && matchesLocation && matchesConsultationType) {
                card.style.display = '';
                visibleCount++;

                // Add animation
                card.classList.add('filtered-in');
                setTimeout(() => {
                    card.classList.remove('filtered-in');
                }, 500);
            } else {
                card.style.display = 'none';
            }
        });

        // Show message if no doctors match the criteria
        const noResultsMessage = document.querySelector('.no-results-message');
        if (visibleCount === 0) {
            if (!noResultsMessage) {
                const message = document.createElement('div');
                message.className = 'no-results-message';
                message.innerHTML = `
                    <p>No doctors match your search criteria. Please try different filters.</p>
                    <button class="btn secondary reset-search">Reset Filters</button>
                `;

                if (doctorsList) {
                    doctorsList.appendChild(message);

                    // Add event listener to reset button
                    const resetButton = message.querySelector('.reset-search');
                    if (resetButton) {
                        resetButton.addEventListener('click', function() {
                            // Reset form fields
                            if (searchForm) {
                                searchForm.reset();

                                // Reset date to today
                                if (dateInput) {
                                    const today = new Date();
                                    dateInput.value = today.toISOString().split('T')[0];
                                }

                                // Show all doctors
                                doctorCards.forEach(card => {
                                    card.style.display = '';
                                });

                                // Remove no results message
                                message.remove();
                            }
                        });
                    }
                }
            }
        } else if (noResultsMessage) {
            noResultsMessage.remove();
        }
    }

    // Doctor card actions
    const bookButtons = document.querySelectorAll('.doctor-actions .btn.primary');
    const profileButtons = document.querySelectorAll('.doctor-actions .btn.secondary');

    bookButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();

            const doctorCard = this.closest('.doctor-card');
            const doctorName = doctorCard.querySelector('h4').textContent;
            const doctorSpecialty = doctorCard.querySelector('.specialty').textContent;

            console.log('Book appointment with:', doctorName, '(', doctorSpecialty, ')');

            // Get selected consultation type
            const selectedType = document.querySelector('.type-card.selected');
            const consultationType = selectedType ? selectedType.querySelector('h4').textContent : 'In-Person Consultation';

            // In a real implementation, this would open a booking form
            // For this demo, we'll just show a confirmation dialog
            if (confirm(`Would you like to book a ${consultationType.toLowerCase()} with ${doctorName}?`)) {
                // Redirect to appointment booking page
                const doctorId = this.getAttribute('href').split('=')[1];
                window.location.href = `online-appointment.jsp?doctor=${doctorId}&type=${consultationType.split(' ')[0].toLowerCase()}`;
            }
        });
    });

    profileButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();

            const doctorCard = this.closest('.doctor-card');
            const doctorName = doctorCard.querySelector('h4').textContent;

            console.log('View profile of:', doctorName);

            // In a real implementation, this would open the doctor's profile
            // For this demo, we'll just navigate to the profile page
            const doctorId = this.getAttribute('href').split('=')[1];
            window.location.href = `doctor-profile.jsp?id=${doctorId}`;
        });
    });

    // Add hover effects to doctor cards
    doctorCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.classList.add('hover');
        });

        card.addEventListener('mouseleave', function() {
            this.classList.remove('hover');
        });
    });
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

/**
 * Consultation Type Selection
 * Handles the selection of consultation type cards with enhanced interactivity
 */
function initConsultationTypeSelection() {
    const typeCards = document.querySelectorAll('.type-card');

    if (typeCards.length === 0) return;

    // Add keyboard accessibility and ARIA attributes
    typeCards.forEach((card, index) => {
        // Make cards focusable and accessible
        card.setAttribute('tabindex', '0');
        card.setAttribute('role', 'button');
        card.setAttribute('aria-pressed', 'false');

        // Add click event listener
        card.addEventListener('click', function() {
            // Remove selected class from all cards
            typeCards.forEach(c => {
                c.classList.remove('selected');
                c.setAttribute('aria-pressed', 'false');
            });

            // Add selected class to clicked card
            this.classList.add('selected');
            this.setAttribute('aria-pressed', 'true');

            // Get consultation type
            const typeTitle = this.querySelector('h4').textContent;
            const typePrice = this.querySelector('.type-price').textContent.trim();

            console.log('Selected consultation type:', typeTitle, 'Price:', typePrice);

            // Update consultation type in search form if it exists
            const consultationTypeSelect = document.getElementById('consultation-type');
            if (consultationTypeSelect) {
                // Extract the type from the title (e.g., "In-Person Consultation" -> "in-person")
                const typeValue = typeTitle.toLowerCase().split(' ')[0];

                // Find and select the matching option
                for (let i = 0; i < consultationTypeSelect.options.length; i++) {
                    if (consultationTypeSelect.options[i].value.includes(typeValue)) {
                        consultationTypeSelect.selectedIndex = i;
                        break;
                    }
                }
            }

            // Scroll to doctor search section
            const doctorSearch = document.getElementById('doctor-search');
            if (doctorSearch) {
                setTimeout(() => {
                    doctorSearch.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }, 300);
            }
        });

        // Add keyboard event listener for accessibility
        card.addEventListener('keydown', function(event) {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                this.click();
            }
        });

        // Add hover effects
        card.addEventListener('mouseenter', function() {
            this.classList.add('hover');
        });

        card.addEventListener('mouseleave', function() {
            this.classList.remove('hover');
        });
    });

    // Select the first card by default
    if (typeCards.length > 0) {
        setTimeout(() => {
            // Only auto-select on desktop to avoid scrolling issues on mobile
            if (window.innerWidth >= 768) {
                typeCards[0].classList.add('selected');
                typeCards[0].setAttribute('aria-pressed', 'true');
            }
        }, 500);
    }
}
