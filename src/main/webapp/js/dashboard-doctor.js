/**
 * LifeCare Medical Center - Doctor Dashboard JavaScript
 * This file contains JavaScript functionality specific to the doctor dashboard
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileSidebar();
    initScheduleNavigation();
    initPatientSearch();
    initAppointmentDetails();
});

/**
 * Mobile Sidebar Toggle
 */
function initMobileSidebar() {
    // Create mobile toggle button
    const mobileToggle = document.createElement('button');
    mobileToggle.className = 'mobile-toggle';
    mobileToggle.innerHTML = '<i class="fas fa-bars"></i>';
    mobileToggle.setAttribute('aria-label', 'Toggle Sidebar');
    
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');
    
    if (sidebar && mainContent) {
        document.body.appendChild(mobileToggle);
        
        mobileToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
        
        // Close sidebar when clicking outside
        document.addEventListener('click', function(event) {
            if (!sidebar.contains(event.target) && !mobileToggle.contains(event.target) && sidebar.classList.contains('active')) {
                sidebar.classList.remove('active');
            }
        });
    }
}

/**
 * Schedule Navigation
 */
function initScheduleNavigation() {
    const prevButton = document.querySelector('.schedule-date-nav button:first-child');
    const nextButton = document.querySelector('.schedule-date-nav button:last-child');
    const currentDateElement = document.querySelector('.current-date');
    
    if (prevButton && nextButton && currentDateElement) {
        // Get current date
        let currentDate = new Date();
        updateDateDisplay();
        
        // Previous week button
        prevButton.addEventListener('click', function() {
            currentDate.setDate(currentDate.getDate() - 7);
            updateDateDisplay();
            updateSchedule();
        });
        
        // Next week button
        nextButton.addEventListener('click', function() {
            currentDate.setDate(currentDate.getDate() + 7);
            updateDateDisplay();
            updateSchedule();
        });
        
        // Update date display
        function updateDateDisplay() {
            const options = { month: 'long', day: 'numeric', year: 'numeric' };
            const startDate = new Date(currentDate);
            startDate.setDate(currentDate.getDate() - currentDate.getDay()); // Start of week (Sunday)
            
            const endDate = new Date(startDate);
            endDate.setDate(startDate.getDate() + 6); // End of week (Saturday)
            
            currentDateElement.textContent = `${startDate.toLocaleDateString('en-US', options)} - ${endDate.toLocaleDateString('en-US', options)}`;
        }
        
        // Update schedule (placeholder)
        function updateSchedule() {
            console.log('Updating schedule for week of:', currentDate);
            // In a real implementation, this would fetch and display appointments for the selected week
        }
    }
}

/**
 * Patient Search
 */
function initPatientSearch() {
    const searchInput = document.querySelector('.patient-search input');
    
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.trim().toLowerCase();
            const patientItems = document.querySelectorAll('.patient-item');
            
            patientItems.forEach(item => {
                const patientName = item.querySelector('h4').textContent.toLowerCase();
                const patientInfo = item.querySelector('p').textContent.toLowerCase();
                
                if (patientName.includes(searchTerm) || patientInfo.includes(searchTerm)) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    }
}

/**
 * Appointment Details
 */
function initAppointmentDetails() {
    const appointmentItems = document.querySelectorAll('.appointment-item');
    
    appointmentItems.forEach(item => {
        item.addEventListener('click', function() {
            // In a real implementation, this would show a modal with appointment details
            const patientName = this.querySelector('.appointment-patient').textContent;
            const appointmentTime = this.querySelector('.appointment-time').textContent;
            
            console.log('Appointment details:', patientName, appointmentTime);
            
            // Example of showing a modal (placeholder)
            alert(`Appointment with ${patientName} at ${appointmentTime}`);
        });
    });
}
