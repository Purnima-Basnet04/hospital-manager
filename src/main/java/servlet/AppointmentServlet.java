package servlet;

import controller.AppointmentController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    private AppointmentController appointmentController;

    @Override
    public void init() throws ServletException {
        appointmentController = new AppointmentController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewAppointment(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteAppointment(request, response);
                break;
            case "patient":
                listPatientAppointments(request, response);
                break;
            case "doctor":
                listDoctorAppointments(request, response);
                break;
            default:
                listAllAppointments(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "book":
                bookAppointment(request, response);
                break;
            case "update":
                updateAppointment(request, response);
                break;
            case "updateStatus":
                updateAppointmentStatus(request, response);
                break;
            case "reschedule":
                rescheduleAppointment(request, response);
                break;
            default:
                listAllAppointments(request, response);
                break;
        }
    }

    private void listAllAppointments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> appointments = appointmentController.getAllAppointments();
        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/admin-appointments.jsp").forward(request, response);
    }

    private void listPatientAppointments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<Appointment> appointments = appointmentController.getAppointmentsByPatientId(userId);
        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/appointments.jsp").forward(request, response);
    }

    private void listDoctorAppointments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<Appointment> appointments = appointmentController.getAppointmentsByDoctorId(userId);
        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/doctor-appointments.jsp").forward(request, response);
    }

    private void viewAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Appointment appointment = appointmentController.getAppointmentById(id);

        if (appointment != null) {
            request.setAttribute("appointment", appointment);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-view-appointment.jsp").forward(request, response);
            } else if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-view-appointment.jsp").forward(request, response);
            } else if ("PATIENT".equals(userRole)) {
                request.getRequestDispatcher("/patient-view-appointment.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Appointment not found");
            response.sendRedirect("AppointmentServlet");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            request.getRequestDispatcher("/admin-add-appointment.jsp").forward(request, response);
        } else if ("PATIENT".equals(userRole)) {
            request.getRequestDispatcher("/patient-book-appointment.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Appointment appointment = appointmentController.getAppointmentById(id);

        if (appointment != null) {
            request.setAttribute("appointment", appointment);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-edit-appointment.jsp").forward(request, response);
            } else if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-update-appointment.jsp").forward(request, response);
            } else if ("PATIENT".equals(userRole)) {
                request.getRequestDispatcher("/patient-reschedule-appointment.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Appointment not found");
            response.sendRedirect("AppointmentServlet");
        }
    }

    private void bookAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int patientId = Integer.parseInt(userIdStr);

        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        Date appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time appointmentTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");
        String reason = request.getParameter("reason");

        boolean success = appointmentController.bookAppointment(patientId, doctorId, appointmentDate, appointmentTime, reason);

        if (success) {
            request.setAttribute("successMessage", "Appointment booked successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to book appointment");
        }

        listPatientAppointments(request, response);
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        Date appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time appointmentTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");
        String status = request.getParameter("status");
        String reason = request.getParameter("reason");
        String notes = request.getParameter("notes");

        boolean success = appointmentController.updateAppointment(id, patientId, doctorId, appointmentDate,
                                                                appointmentTime, status, reason, notes);

        if (success) {
            request.setAttribute("successMessage", "Appointment updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update appointment");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllAppointments(request, response);
        } else if ("DOCTOR".equals(userRole)) {
            listDoctorAppointments(request, response);
        } else {
            listPatientAppointments(request, response);
        }
    }

    private void updateAppointmentStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        boolean success = appointmentController.updateAppointmentStatus(id, status, notes);

        if (success) {
            request.setAttribute("successMessage", "Appointment status updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update appointment status");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllAppointments(request, response);
        } else if ("DOCTOR".equals(userRole)) {
            listDoctorAppointments(request, response);
        } else {
            listPatientAppointments(request, response);
        }
    }

    private void rescheduleAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Date appointmentDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time appointmentTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");

        boolean success = appointmentController.rescheduleAppointment(id, appointmentDate, appointmentTime);

        if (success) {
            request.setAttribute("successMessage", "Appointment rescheduled successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to reschedule appointment");
        }

        listPatientAppointments(request, response);
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = appointmentController.cancelAppointment(id);

        if (success) {
            request.setAttribute("successMessage", "Appointment cancelled successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to cancel appointment");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllAppointments(request, response);
        } else if ("DOCTOR".equals(userRole)) {
            listDoctorAppointments(request, response);
        } else {
            listPatientAppointments(request, response);
        }
    }
}
