<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/dashboard-header.jsp" %>
<%
    // Check if user is logged in with correct role
    if (userRole == null || !userRole.equals("ADMIN")) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>


<h2>Admin Dashboard</h2>
<p>Welcome, <%= fullName %>!</p>

<div class="dashboard-stats">
    <div class="stat-card">
        <h3>Total Doctors</h3>
        <p class="stat-number">15</p>
    </div>
    <div class="stat-card">
        <h3>Total Patients</h3>
        <p class="stat-number">250</p>
    </div>
    <div class="stat-card">
        <h3>Appointments Today</h3>
        <p class="stat-number">32</p>
    </div>
    <div class="stat-card">
        <h3>Departments</h3>
        <p class="stat-number">8</p>
    </div>
</div>

<div class="dashboard-actions">
    <h3>Quick Actions</h3>
    <div class="action-buttons">
        <a href="${pageContext.request.contextPath}/admin-add-doctor.jsp" class="btn primary">Add Doctor</a>
        <a href="${pageContext.request.contextPath}/admin-add-patient.jsp" class="btn primary">Add Patient</a>
        <a href="${pageContext.request.contextPath}/admin-appointments.jsp" class="btn primary">View Appointments</a>
        <a href="${pageContext.request.contextPath}/admin-reports.jsp" class="btn secondary">Generate Reports</a>
    </div>
</div>

<div class="recent-section">
    <h3>Recent Doctors</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Specialization</th>
                <th>Contact</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Dr. John Smith</td>
                <td>Cardiology</td>
                <td>john.smith@lifecare.com</td>
                <td>Active</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin-view-doctor.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/admin-edit-doctor.jsp?id=1" class="btn-small">Edit</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Dr. Sarah Johnson</td>
                <td>Neurology</td>
                <td>sarah.johnson@lifecare.com</td>
                <td>Active</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin-view-doctor.jsp?id=2" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/admin-edit-doctor.jsp?id=2" class="btn-small">Edit</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="recent-section">
    <h3>Recent Patients</h3>
    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Contact</th>
                <th>Last Visit</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Michael Brown</td>
                <td>45</td>
                <td>michael.brown@email.com</td>
                <td>2023-06-10</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin-view-patient.jsp?id=1" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/admin-edit-patient.jsp?id=1" class="btn-small">Edit</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Emily Davis</td>
                <td>32</td>
                <td>emily.davis@email.com</td>
                <td>2023-06-08</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin-view-patient.jsp?id=2" class="btn-small">View</a>
                    <a href="${pageContext.request.contextPath}/admin-edit-patient.jsp?id=2" class="btn-small">Edit</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<%@ include file="includes/dashboard-footer.jsp" %>
