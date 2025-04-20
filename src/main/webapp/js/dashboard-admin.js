/**
 * LifeCare Medical Center - Admin Dashboard JavaScript
 * This file contains JavaScript functionality specific to the admin dashboard
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initMobileSidebar();
    initCharts();
    initDataTables();
    initSearchFilters();
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
 * Initialize Charts
 */
function initCharts() {
    // This is a placeholder for chart initialization
    // In a real implementation, you would use a charting library like Chart.js
    console.log('Charts initialized');
    
    // Example of chart filter functionality
    const chartFilters = document.querySelectorAll('.chart-filters button');
    
    chartFilters.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            chartFilters.forEach(btn => btn.classList.remove('active'));
            
            // Add active class to clicked button
            this.classList.add('active');
            
            // Update chart data (placeholder)
            console.log('Chart filter changed to:', this.textContent.trim());
        });
    });
}

/**
 * Initialize Data Tables
 */
function initDataTables() {
    // This is a placeholder for data table initialization
    // In a real implementation, you would use a library like DataTables
    
    // Example of pagination functionality
    const paginationButtons = document.querySelectorAll('.pagination-controls button');
    
    paginationButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            paginationButtons.forEach(btn => btn.classList.remove('active'));
            
            // Add active class to clicked button
            this.classList.add('active');
            
            // Update table data (placeholder)
            console.log('Page changed to:', this.textContent.trim());
        });
    });
    
    // Example of table action buttons
    const actionButtons = document.querySelectorAll('.action-btn');
    
    actionButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            
            const action = this.classList.contains('edit') ? 'edit' :
                          this.classList.contains('delete') ? 'delete' :
                          this.classList.contains('view') ? 'view' : 'unknown';
            
            const row = this.closest('tr');
            const id = row.dataset.id || 'unknown';
            
            console.log(`${action} action triggered for ID: ${id}`);
            
            // Example of confirmation dialog for delete
            if (action === 'delete') {
                if (confirm('Are you sure you want to delete this item?')) {
                    console.log(`Confirmed delete for ID: ${id}`);
                    // Perform delete action
                }
            }
        });
    });
}

/**
 * Initialize Search Filters
 */
function initSearchFilters() {
    const searchInputs = document.querySelectorAll('.search-box input');
    
    searchInputs.forEach(input => {
        input.addEventListener('input', function() {
            const searchTerm = this.value.trim().toLowerCase();
            const tableId = this.dataset.target;
            const table = document.getElementById(tableId);
            
            if (table) {
                const rows = table.querySelectorAll('tbody tr');
                
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(searchTerm) ? '' : 'none';
                });
            }
        });
    });
}
