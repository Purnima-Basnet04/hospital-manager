<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/dashboard-header.jsp" %>
<%
    // Check if user is logged in with correct role
    
    if (userRole == null || !userRole.equals("PATIENT")) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>


<h2>Patient Dashboard</h2>
<p>Welcome, <%= fullName %>!</p>

<div class="dashboard-stats">
    <div class="stat-card">
        <h3>Upcoming Appointments</h3>
        <p class="stat-number">2</p>
    </div>
    <div class="stat-card">
        <h3>Prescriptions</h3>
        <p class="stat-number">3</p>
    </div>
    <div class="stat-card">
        <h3>Medical Records</h3>
        <p class="stat-number">5</p>
    </div>
    <div class="stat-card">
        <h3>Messages</h3>
        <p class="stat-number">1</p>
    </div>
</div>

<div class="dashboard-actions">
    <h3>Quick Actions</h3>
    <div class="action-buttons">
        <a href="patient-book-appointment.jsp" class="btn primary">Book Appointment</a>
        <a href="patient-medical-records.jsp" class="btn primary">View Medical Records</a>
        <a href="patient-prescriptions.jsp" class="btn primary">View Prescriptions</a>
        <a href="patient-messages.jsp" class="btn secondary">Check Messages</a>
    </div>
</div>

<div class="recent-section">
    <h3>Upcoming Appointments</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Doctor</th>
                <th>Date</th>
                <th>Time</th>
                <th>Department</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Dr. John Smith</td>
                <td>2023-06-15</td>
                <td>10:00 AM</td>
                <td>Cardiology</td>
                <td>
                    <a href="${pageContext.request.contextPath}/patient-view-appointment.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/patient-reschedule-appointment.jsp?id=1" class="btn-small">Reschedule</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Dr. Sarah Johnson</td>
                <td>2023-06-20</td>
                <td>2:30 PM</td>
                <td>Neurology</td>
                <td>
                    <a href="${pageContext.request.contextPath}/patient-view-appointment.jsp?id=2" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/patient-reschedule-appointment.jsp?id=2" class="btn-small">Reschedule</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="recent-section">
    <h3>Recent Prescriptions</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Doctor</th>
                <th>Date</th>
                <th>Medication</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Dr. John Smith</td>
                <td>2023-06-01</td>
                <td>Lisinopril 10mg</td>
                <td>Active</td>
                <td>
                    <a href="${pageContext.request.contextPath}/patient-view-prescription.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/patient-request-refill.jsp?id=1" class="btn-small">Request Refill</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Dr. Sarah Johnson</td>
                <td>2023-05-15</td>
                <td>Amoxicillin 500mg</td>
                <td>Completed</td>
                <td>
                    <a href="${pageContext.request.contextPath}/patient-view-prescription.jsp?id=2" class="btn-small">View</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<%@ include file="includes/dashboard-footer.jsp" %>
