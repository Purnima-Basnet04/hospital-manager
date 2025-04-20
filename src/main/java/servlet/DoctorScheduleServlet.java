package servlet;

import controller.DoctorScheduleController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DoctorSchedule;

import java.io.IOException;
import java.sql.Time;
import java.util.List;

@WebServlet("/DoctorScheduleServlet")
public class DoctorScheduleServlet extends HttpServlet {

    private DoctorScheduleController doctorScheduleController;

    @Override
    public void init() throws ServletException {
        doctorScheduleController = new DoctorScheduleController();
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
                viewDoctorSchedule(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteDoctorSchedule(request, response);
                break;
            case "doctor":
                listDoctorSchedules(request, response);
                break;
            case "day":
                listSchedulesByDay(request, response);
                break;
            default:
                listAllSchedules(request, response);
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
            case "add":
                addDoctorSchedule(request, response);
                break;
            case "update":
                updateDoctorSchedule(request, response);
                break;
            default:
                listAllSchedules(request, response);
                break;
        }
    }

    private void listAllSchedules(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DoctorSchedule> schedules = doctorScheduleController.getAllDoctorSchedules();
        request.setAttribute("schedules", schedules);
        request.getRequestDispatcher("/admin-doctor-schedules.jsp").forward(request, response);
    }

    private void listDoctorSchedules(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<DoctorSchedule> schedules = doctorScheduleController.getDoctorSchedulesByDoctorId(userId);
        request.setAttribute("schedules", schedules);
        request.getRequestDispatcher("/doctor-schedule.jsp").forward(request, response);
    }

    private void listSchedulesByDay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dayOfWeek = request.getParameter("day");
        List<DoctorSchedule> schedules = doctorScheduleController.getDoctorSchedulesByDayOfWeek(dayOfWeek);
        request.setAttribute("schedules", schedules);
        request.setAttribute("dayOfWeek", dayOfWeek);
        request.getRequestDispatcher("/patient-book-appointment.jsp").forward(request, response);
    }

    private void viewDoctorSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        DoctorSchedule schedule = doctorScheduleController.getDoctorScheduleById(id);

        if (schedule != null) {
            request.setAttribute("schedule", schedule);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-view-doctor-schedule.jsp").forward(request, response);
            } else if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-view-schedule.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Schedule not found");
            response.sendRedirect("DoctorScheduleServlet");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("DOCTOR".equals(userRole)) {
            request.getRequestDispatcher("/doctor-add-schedule.jsp").forward(request, response);
        } else if ("ADMIN".equals(userRole)) {
            request.getRequestDispatcher("/admin-add-doctor-schedule.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        DoctorSchedule schedule = doctorScheduleController.getDoctorScheduleById(id);

        if (schedule != null) {
            request.setAttribute("schedule", schedule);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-edit-schedule.jsp").forward(request, response);
            } else if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-edit-doctor-schedule.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Schedule not found");
            response.sendRedirect("DoctorScheduleServlet");
        }
    }

    private void addDoctorSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        int doctorId;
        if ("DOCTOR".equals(userRole)) {
            doctorId = (Integer) session.getAttribute("userId");
        } else {
            doctorId = Integer.parseInt(request.getParameter("doctorId"));
        }

        String dayOfWeek = request.getParameter("dayOfWeek");
        Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
        Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

        boolean success = doctorScheduleController.addDoctorSchedule(doctorId, dayOfWeek, startTime, endTime, isAvailable);

        if (success) {
            request.setAttribute("successMessage", "Schedule added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add schedule");
        }

        if ("DOCTOR".equals(userRole)) {
            listDoctorSchedules(request, response);
        } else {
            listAllSchedules(request, response);
        }
    }

    private void updateDoctorSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        int doctorId;
        if ("DOCTOR".equals(userRole)) {
            doctorId = (Integer) session.getAttribute("userId");
        } else {
            doctorId = Integer.parseInt(request.getParameter("doctorId"));
        }

        String dayOfWeek = request.getParameter("dayOfWeek");
        Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
        Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));

        boolean success = doctorScheduleController.updateDoctorSchedule(id, doctorId, dayOfWeek, startTime, endTime, isAvailable);

        if (success) {
            request.setAttribute("successMessage", "Schedule updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update schedule");
        }

        if ("DOCTOR".equals(userRole)) {
            listDoctorSchedules(request, response);
        } else {
            listAllSchedules(request, response);
        }
    }

    private void deleteDoctorSchedule(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = doctorScheduleController.deleteDoctorSchedule(id);

        if (success) {
            request.setAttribute("successMessage", "Schedule deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete schedule");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("DOCTOR".equals(userRole)) {
            listDoctorSchedules(request, response);
        } else {
            listAllSchedules(request, response);
        }
    }
}
