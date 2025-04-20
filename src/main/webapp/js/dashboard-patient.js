/**
 * LifeCare Medical Center - Patient Dashboard JavaScript
 * This file contains JavaScript functionality specific to the patient dashboard
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileSidebar();
    initAppointmentActions();
    initHealthMetricsChart();
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
 * Appointment Actions
 */
function initAppointmentActions() {
    // Reschedule appointment
    const rescheduleButtons = document.querySelectorAll('.appointment-action-btn.reschedule');
    
    rescheduleButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.stopPropagation();
            
            const appointmentItem = this.closest('.appointment-item');
            const appointmentId = appointmentItem.dataset.id || 'unknown';
            const doctorName = appointmentItem.querySelector('.appointment-details h4').textContent;
            
            console.log(`Reschedule appointment ${appointmentId} with ${doctorName}`);
            
            // Example of showing a modal (placeholder)
            alert(`Reschedule appointment with ${doctorName}`);
        });
    });
    
    // Cancel appointment
    const cancelButtons = document.querySelectorAll('.appointment-action-btn.cancel');
    
    cancelButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.stopPropagation();
            
            const appointmentItem = this.closest('.appointment-item');
            const appointmentId = appointmentItem.dataset.id || 'unknown';
            const doctorName = appointmentItem.querySelector('.appointment-details h4').textContent;
            
            if (confirm(`Are you sure you want to cancel your appointment with ${doctorName}?`)) {
                console.log(`Cancel appointment ${appointmentId} with ${doctorName}`);
                
                // Example of removing the appointment from the list (placeholder)
                appointmentItem.style.opacity = '0';
                setTimeout(() => {
                    appointmentItem.remove();
                }, 300);
            }
        });
    });
    
    // View appointment details
    const appointmentItems = document.querySelectorAll('.appointment-item');
    
    appointmentItems.forEach(item => {
        item.addEventListener('click', function() {
            const appointmentId = this.dataset.id || 'unknown';
            const doctorName = this.querySelector('.appointment-details h4').textContent;
            
            console.log(`View appointment ${appointmentId} with ${doctorName}`);
            
            // Example of showing a modal (placeholder)
            alert(`Appointment details with ${doctorName}`);
        });
    });
}

/**
 * Health Metrics Chart
 */
function initHealthMetricsChart() {
    // This is a placeholder for health metrics chart initialization
    // In a real implementation, you would use a charting library like Chart.js
    console.log('Health metrics chart initialized');
    
    // Example of chart data (placeholder)
    const weightData = [75, 74.5, 74, 73.8, 73.5, 73.2];
    const bloodPressureData = [
        { systolic: 120, diastolic: 80 },
        { systolic: 118, diastolic: 78 },
        { systolic: 122, diastolic: 82 },
        { systolic: 119, diastolic: 79 },
        { systolic: 121, diastolic: 81 },
        { systolic: 118, diastolic: 78 }
    ];
    const heartRateData = [72, 70, 74, 71, 73, 69];
    const glucoseData = [95, 98, 92, 94, 96, 93];
    
    // Example of chart options (placeholder)
    const chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        scales: {
            y: {
                beginAtZero: false
            }
        }
    };
    
    console.log('Chart data and options prepared');
}
