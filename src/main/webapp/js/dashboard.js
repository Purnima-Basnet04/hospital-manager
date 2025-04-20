/**
 * LifeCare Medical Center - Dashboard JavaScript
 * This file contains JavaScript functionality for the dashboard pages
 */

document.addEventListener('DOMContentLoaded', function() {
    initSidebar();
    initCharts();
    initDataTables();
    initNotifications();
});

/**
 * Sidebar Functionality
 * Handles the sidebar toggle for mobile devices
 */
function initSidebar() {
    // Create sidebar toggle button if it doesn't exist
    if (!document.querySelector('.sidebar-toggle')) {
        const sidebarToggle = document.createElement('button');
        sidebarToggle.className = 'sidebar-toggle';
        sidebarToggle.innerHTML = '<i class="fas fa-bars"></i>';
        sidebarToggle.setAttribute('aria-label', 'Toggle Sidebar');
        
        const header = document.querySelector('.dashboard-header');
        const sidebar = document.querySelector('.sidebar');
        
        if (header && sidebar) {
            header.insertBefore(sidebarToggle, header.firstChild);
            
            sidebarToggle.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                document.body.classList.toggle('sidebar-open');
            });
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                if (window.innerWidth <= 768 && 
                    sidebar.classList.contains('active') && 
                    !sidebar.contains(event.target) && 
                    !sidebarToggle.contains(event.target)) {
                    sidebar.classList.remove('active');
                    document.body.classList.remove('sidebar-open');
                }
            });
        }
    }
    
    // Handle dropdown menus in sidebar
    const dropdownTriggers = document.querySelectorAll('.sidebar-nav .dropdown-trigger');
    dropdownTriggers.forEach(trigger => {
        trigger.addEventListener('click', function(e) {
            e.preventDefault();
            this.parentNode.classList.toggle('open');
            
            const dropdownContent = this.nextElementSibling;
            if (dropdownContent) {
                if (this.parentNode.classList.contains('open')) {
                    dropdownContent.style.maxHeight = dropdownContent.scrollHeight + 'px';
                } else {
                    dropdownContent.style.maxHeight = null;
                }
            }
        });
    });
}

/**
 * Charts Initialization
 * Sets up charts for the dashboard
 */
function initCharts() {
    // Check if Chart.js is available
    if (typeof Chart === 'undefined') {
        console.warn('Chart.js is not loaded. Charts will not be rendered.');
        return;
    }
    
    // Set default chart options
    Chart.defaults.font.family = getComputedStyle(document.body).getPropertyValue('--font-primary');
    Chart.defaults.color = getComputedStyle(document.body).getPropertyValue('--text-medium');
    
    // Initialize charts if elements exist
    initAppointmentsChart();
    initPatientsChart();
    initRevenueChart();
}

/**
 * Appointments Chart
 */
function initAppointmentsChart() {
    const chartElement = document.getElementById('appointmentsChart');
    if (!chartElement) return;
    
    const ctx = chartElement.getContext('2d');
    
    // Sample data - replace with actual data
    const data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Appointments',
            data: [65, 59, 80, 81, 56, 55],
            backgroundColor: 'rgba(44, 123, 229, 0.2)',
            borderColor: 'rgba(44, 123, 229, 1)',
            borderWidth: 2,
            tension: 0.4,
            fill: true
        }]
    };
    
    const options = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: false
            },
            tooltip: {
                mode: 'index',
                intersect: false,
                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                titleColor: '#12263f',
                bodyColor: '#3e4b5b',
                borderColor: '#d2ddec',
                borderWidth: 1,
                padding: 12,
                boxPadding: 6,
                usePointStyle: true,
                callbacks: {
                    label: function(context) {
                        return `Appointments: ${context.parsed.y}`;
                    }
                }
            }
        },
        scales: {
            x: {
                grid: {
                    display: false
                }
            },
            y: {
                beginAtZero: true,
                grid: {
                    color: 'rgba(210, 221, 236, 0.3)'
                },
                ticks: {
                    precision: 0
                }
            }
        }
    };
    
    new Chart(ctx, {
        type: 'line',
        data: data,
        options: options
    });
}

/**
 * Patients Chart
 */
function initPatientsChart() {
    const chartElement = document.getElementById('patientsChart');
    if (!chartElement) return;
    
    const ctx = chartElement.getContext('2d');
    
    // Sample data - replace with actual data
    const data = {
        labels: ['New', 'Returning', 'Referred'],
        datasets: [{
            data: [45, 30, 25],
            backgroundColor: [
                'rgba(44, 123, 229, 0.8)',
                'rgba(62, 207, 142, 0.8)',
                'rgba(246, 194, 62, 0.8)'
            ],
            borderColor: [
                'rgba(44, 123, 229, 1)',
                'rgba(62, 207, 142, 1)',
                'rgba(246, 194, 62, 1)'
            ],
            borderWidth: 1
        }]
    };
    
    const options = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'bottom',
                labels: {
                    usePointStyle: true,
                    padding: 20
                }
            },
            tooltip: {
                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                titleColor: '#12263f',
                bodyColor: '#3e4b5b',
                borderColor: '#d2ddec',
                borderWidth: 1,
                padding: 12,
                boxPadding: 6,
                usePointStyle: true
            }
        },
        cutout: '60%'
    };
    
    new Chart(ctx, {
        type: 'doughnut',
        data: data,
        options: options
    });
}

/**
 * Revenue Chart
 */
function initRevenueChart() {
    const chartElement = document.getElementById('revenueChart');
    if (!chartElement) return;
    
    const ctx = chartElement.getContext('2d');
    
    // Sample data - replace with actual data
    const data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Revenue',
            data: [12500, 15000, 17500, 16000, 19000, 21000],
            backgroundColor: 'rgba(62, 207, 142, 0.2)',
            borderColor: 'rgba(62, 207, 142, 1)',
            borderWidth: 2,
            type: 'bar'
        }, {
            label: 'Expenses',
            data: [8000, 9000, 10000, 9500, 11000, 12000],
            backgroundColor: 'rgba(230, 55, 87, 0.2)',
            borderColor: 'rgba(230, 55, 87, 1)',
            borderWidth: 2,
            type: 'bar'
        }]
    };
    
    const options = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: 'top',
                labels: {
                    usePointStyle: true,
                    padding: 20
                }
            },
            tooltip: {
                mode: 'index',
                intersect: false,
                backgroundColor: 'rgba(255, 255, 255, 0.9)',
                titleColor: '#12263f',
                bodyColor: '#3e4b5b',
                borderColor: '#d2ddec',
                borderWidth: 1,
                padding: 12,
                boxPadding: 6,
                usePointStyle: true,
                callbacks: {
                    label: function(context) {
                        return `${context.dataset.label}: $${context.parsed.y.toLocaleString()}`;
                    }
                }
            }
        },
        scales: {
            x: {
                grid: {
                    display: false
                }
            },
            y: {
                beginAtZero: true,
                grid: {
                    color: 'rgba(210, 221, 236, 0.3)'
                },
                ticks: {
                    callback: function(value) {
                        return '$' + value.toLocaleString();
                    }
                }
            }
        }
    };
    
    new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
    });
}

/**
 * DataTables Initialization
 * Sets up interactive data tables
 */
function initDataTables() {
    // Check if DataTable is available
    if (typeof $.fn.DataTable === 'undefined') {
        console.warn('DataTables is not loaded. Tables will not be enhanced.');
        return;
    }
    
    // Initialize all tables with the data-table class
    $('.data-table').each(function() {
        $(this).DataTable({
            responsive: true,
            language: {
                search: "_INPUT_",
                searchPlaceholder: "Search...",
                lengthMenu: "Show _MENU_ entries",
                info: "Showing _START_ to _END_ of _TOTAL_ entries",
                infoEmpty: "Showing 0 to 0 of 0 entries",
                infoFiltered: "(filtered from _MAX_ total entries)",
                paginate: {
                    first: '<i class="fas fa-angle-double-left"></i>',
                    previous: '<i class="fas fa-angle-left"></i>',
                    next: '<i class="fas fa-angle-right"></i>',
                    last: '<i class="fas fa-angle-double-right"></i>'
                }
            },
            dom: '<"table-top"<"table-search"f><"table-length"l>><"table-responsive"t><"table-bottom"<"table-info"i><"table-pagination"p>>',
            pageLength: 10,
            lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
        });
    });
}

/**
 * Notifications
 * Handles notification dropdown and marking as read
 */
function initNotifications() {
    const notificationIcon = document.querySelector('.notification-icon');
    const messageIcon = document.querySelector('.message-icon');
    
    if (notificationIcon) {
        notificationIcon.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleNotificationDropdown();
        });
    }
    
    if (messageIcon) {
        messageIcon.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleMessageDropdown();
        });
    }
    
    // Close dropdowns when clicking outside
    document.addEventListener('click', function() {
        closeAllDropdowns();
    });
    
    // Mark notifications as read
    const notificationItems = document.querySelectorAll('.notification-item');
    notificationItems.forEach(item => {
        item.addEventListener('click', function() {
            this.classList.add('read');
            updateNotificationCount();
        });
    });
    
    // Mark messages as read
    const messageItems = document.querySelectorAll('.message-item');
    messageItems.forEach(item => {
        item.addEventListener('click', function() {
            this.classList.add('read');
            updateMessageCount();
        });
    });
}

/**
 * Toggle notification dropdown
 */
function toggleNotificationDropdown() {
    const dropdown = document.querySelector('.notification-dropdown');
    if (dropdown) {
        dropdown.classList.toggle('active');
        
        // Close other dropdowns
        const messageDropdown = document.querySelector('.message-dropdown');
        if (messageDropdown) {
            messageDropdown.classList.remove('active');
        }
    }
}

/**
 * Toggle message dropdown
 */
function toggleMessageDropdown() {
    const dropdown = document.querySelector('.message-dropdown');
    if (dropdown) {
        dropdown.classList.toggle('active');
        
        // Close other dropdowns
        const notificationDropdown = document.querySelector('.notification-dropdown');
        if (notificationDropdown) {
            notificationDropdown.classList.remove('active');
        }
    }
}

/**
 * Close all dropdowns
 */
function closeAllDropdowns() {
    const dropdowns = document.querySelectorAll('.notification-dropdown, .message-dropdown');
    dropdowns.forEach(dropdown => {
        dropdown.classList.remove('active');
    });
}

/**
 * Update notification count
 */
function updateNotificationCount() {
    const badge = document.querySelector('.notification-icon .badge');
    const unreadItems = document.querySelectorAll('.notification-item:not(.read)');
    
    if (badge) {
        const count = unreadItems.length;
        badge.textContent = count;
        
        if (count === 0) {
            badge.style.display = 'none';
        } else {
            badge.style.display = 'flex';
        }
    }
}

/**
 * Update message count
 */
function updateMessageCount() {
    const badge = document.querySelector('.message-icon .badge');
    const unreadItems = document.querySelectorAll('.message-item:not(.read)');
    
    if (badge) {
        const count = unreadItems.length;
        badge.textContent = count;
        
        if (count === 0) {
            badge.style.display = 'none';
        } else {
            badge.style.display = 'flex';
        }
    }
}
