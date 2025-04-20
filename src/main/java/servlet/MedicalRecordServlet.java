package servlet;

import controller.MedicalRecordController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.MedicalRecord;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/MedicalRecordServlet")
public class MedicalRecordServlet extends HttpServlet {

    private MedicalRecordController medicalRecordController;

    @Override
    public void init() throws ServletException {
        medicalRecordController = new MedicalRecordController();
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
                viewMedicalRecord(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteMedicalRecord(request, response);
                break;
            case "patient":
                listPatientMedicalRecords(request, response);
                break;
            case "doctor":
                listDoctorMedicalRecords(request, response);
                break;
            default:
                listAllMedicalRecords(request, response);
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
                addMedicalRecord(request, response);
                break;
            case "update":
                updateMedicalRecord(request, response);
                break;
            default:
                listAllMedicalRecords(request, response);
                break;
        }
    }

    private void listAllMedicalRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<MedicalRecord> medicalRecords = medicalRecordController.getAllMedicalRecords();
        request.setAttribute("medicalRecords", medicalRecords);
        request.getRequestDispatcher("/admin-medical-records.jsp").forward(request, response);
    }

    private void listPatientMedicalRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<MedicalRecord> medicalRecords = medicalRecordController.getMedicalRecordsByPatientId(userId);
        request.setAttribute("medicalRecords", medicalRecords);
        request.getRequestDispatcher("/patient-medical-records.jsp").forward(request, response);
    }

    private void listDoctorMedicalRecords(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<MedicalRecord> medicalRecords = medicalRecordController.getMedicalRecordsByDoctorId(userId);
        request.setAttribute("medicalRecords", medicalRecords);
        request.getRequestDispatcher("/doctor-medical-records.jsp").forward(request, response);
    }

    private void viewMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        MedicalRecord medicalRecord = medicalRecordController.getMedicalRecordById(id);

        if (medicalRecord != null) {
            request.setAttribute("medicalRecord", medicalRecord);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-view-medical-record.jsp").forward(request, response);
            } else if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-view-medical-record.jsp").forward(request, response);
            } else if ("PATIENT".equals(userRole)) {
                request.getRequestDispatcher("/patient-view-medical-record.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Medical record not found");
            response.sendRedirect("MedicalRecordServlet");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("DOCTOR".equals(userRole)) {
            // If coming from an appointment, get the appointment ID
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                int appointmentId = Integer.parseInt(appointmentIdStr);
                request.setAttribute("appointmentId", appointmentId);
            }

            request.getRequestDispatcher("/doctor-add-medical-record.jsp").forward(request, response);
        } else if ("ADMIN".equals(userRole)) {
            request.getRequestDispatcher("/admin-add-medical-record.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        MedicalRecord medicalRecord = medicalRecordController.getMedicalRecordById(id);

        if (medicalRecord != null) {
            request.setAttribute("medicalRecord", medicalRecord);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-edit-medical-record.jsp").forward(request, response);
            } else if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-edit-medical-record.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Medical record not found");
            response.sendRedirect("MedicalRecordServlet");
        }
    }

    private void addMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer doctorId = (Integer) session.getAttribute("userId");

        if (doctorId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int patientId = Integer.parseInt(request.getParameter("patientId"));

        // Appointment ID is optional
        String appointmentIdStr = request.getParameter("appointmentId");
        int appointmentId = 0;
        if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
            appointmentId = Integer.parseInt(appointmentIdStr);
        }

        Date recordDate = Date.valueOf(request.getParameter("recordDate"));
        String diagnosis = request.getParameter("diagnosis");
        String treatment = request.getParameter("treatment");
        String prescription = request.getParameter("prescription");
        String notes = request.getParameter("notes");

        // Follow-up date is optional
        String followUpDateStr = request.getParameter("followUpDate");
        Date followUpDate = null;
        if (followUpDateStr != null && !followUpDateStr.isEmpty()) {
            followUpDate = Date.valueOf(followUpDateStr);
        }

        boolean success = medicalRecordController.addMedicalRecord(patientId, doctorId, appointmentId,
                                                                 recordDate, diagnosis, treatment,
                                                                 prescription, notes, followUpDate);

        if (success) {
            request.setAttribute("successMessage", "Medical record added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add medical record");
        }

        listDoctorMedicalRecords(request, response);
    }

    private void updateMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));

        // Appointment ID is optional
        String appointmentIdStr = request.getParameter("appointmentId");
        int appointmentId = 0;
        if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
            appointmentId = Integer.parseInt(appointmentIdStr);
        }

        Date recordDate = Date.valueOf(request.getParameter("recordDate"));
        String diagnosis = request.getParameter("diagnosis");
        String treatment = request.getParameter("treatment");
        String prescription = request.getParameter("prescription");
        String notes = request.getParameter("notes");

        // Follow-up date is optional
        String followUpDateStr = request.getParameter("followUpDate");
        Date followUpDate = null;
        if (followUpDateStr != null && !followUpDateStr.isEmpty()) {
            followUpDate = Date.valueOf(followUpDateStr);
        }

        boolean success = medicalRecordController.updateMedicalRecord(id, patientId, doctorId, appointmentId,
                                                                    recordDate, diagnosis, treatment,
                                                                    prescription, notes, followUpDate);

        if (success) {
            request.setAttribute("successMessage", "Medical record updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update medical record");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllMedicalRecords(request, response);
        } else {
            listDoctorMedicalRecords(request, response);
        }
    }

    private void deleteMedicalRecord(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = medicalRecordController.deleteMedicalRecord(id);

        if (success) {
            request.setAttribute("successMessage", "Medical record deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete medical record");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllMedicalRecords(request, response);
        } else {
            listDoctorMedicalRecords(request, response);
        }
    }
}
