<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/dashboard-header.jsp" %>
<%
    // Check if user is logged in with correct role
   
    if (userRole == null || !userRole.equals("DOCTOR")) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>


<h2>Doctor Dashboard</h2>
<p>Welcome, Dr. <%= fullName %>!</p>

<div class="dashboard-stats">
    <div class="stat-card">
        <h3>Today's Appointments</h3>
        <p class="stat-number">8</p>
    </div>
    <div class="stat-card">
        <h3>Total Patients</h3>
        <p class="stat-number">45</p>
    </div>
    <div class="stat-card">
        <h3>Pending Reports</h3>
        <p class="stat-number">3</p>
    </div>
    <div class="stat-card">
        <h3>Completed Appointments</h3>
        <p class="stat-number">120</p>
    </div>
</div>

<div class="dashboard-actions">
    <h3>Quick Actions</h3>
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/doctor-appointments.jsp" class="btn primary">View Appointments</a>
        <a href="${pageContext.request.contextPath}/doctor-add-prescription.jsp" class="btn primary">Add Prescription</a>
        <a href="${pageContext.request.contextPath}/doctor-add-medical-record.jsp" class="btn primary">Add Medical Record</a>
        <a href="${pageContext.request.contextPath}/doctor-schedule.jsp" class="btn secondary">Update Schedule</a>
    </div>
</div>

<div class="recent-section">
    <h3>Today's Appointments</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Time</th>
                <th>Status</th>
                <th>Reason</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>John Doe</td>
                <td>10:00 AM</td>
                <td>Scheduled</td>
                <td>Regular Checkup</td>
                <td>
                    <a href="${pageContext.request.contextPath}/doctor-view-appointment.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/doctor-update-appointment.jsp?id=1" class="btn-small">Update</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Jane Smith</td>
                <td>11:30 AM</td>
                <td>Scheduled</td>
                <td>Follow-up</td>
                <td>
                    <a href="${pageContext.request.contextPath}/doctor-view-appointment.jsp?id=2" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/doctor-update-appointment.jsp?id=2" class="btn-small">Update</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="recent-section">
    <h3>Recent Medical Records</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Date</th>
                <th>Diagnosis</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>John Doe</td>
                <td>2023-06-05</td>
                <td>Hypertension</td>
                <td>
                    <a href="${pageContext.request.contextPath}/doctor-view-medical-record.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/doctor-edit-medical-record.jsp?id=1" class="btn-small">Edit</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Jane Smith</td>
                <td>2023-06-01</td>
                <td>Diabetes Type 2</td>
                <td>
                    <a href="${pageContext.request.contextPath}/doctor-view-medical-record.jsp?id=2" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/doctor-edit-medical-record.jsp?id=2" class="btn-small">Edit</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<%@ include file="includes/dashboard-footer.jsp" %>
