package servlet;

import controller.PrescriptionController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Prescription;
import model.PrescriptionItem;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PrescriptionServlet")
public class PrescriptionServlet extends HttpServlet {

    private PrescriptionController prescriptionController;

    @Override
    public void init() throws ServletException {
        prescriptionController = new PrescriptionController();
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
                viewPrescription(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePrescription(request, response);
                break;
            case "patient":
                listPatientPrescriptions(request, response);
                break;
            case "doctor":
                listDoctorPrescriptions(request, response);
                break;
            default:
                listAllPrescriptions(request, response);
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
                addPrescription(request, response);
                break;
            case "update":
                updatePrescription(request, response);
                break;
            case "updateStatus":
                updatePrescriptionStatus(request, response);
                break;
            default:
                listAllPrescriptions(request, response);
                break;
        }
    }

    private void listAllPrescriptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Prescription> prescriptions = prescriptionController.getAllPrescriptions();
        request.setAttribute("prescriptions", prescriptions);
        request.getRequestDispatcher("/admin-prescriptions.jsp").forward(request, response);
    }

    private void listPatientPrescriptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<Prescription> prescriptions = prescriptionController.getPrescriptionsByPatientId(userId);
        request.setAttribute("prescriptions", prescriptions);
        request.getRequestDispatcher("/patient-prescriptions.jsp").forward(request, response);
    }

    private void listDoctorPrescriptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int userId = Integer.parseInt(userIdStr);

        List<Prescription> prescriptions = prescriptionController.getPrescriptionsByDoctorId(userId);
        request.setAttribute("prescriptions", prescriptions);
        request.getRequestDispatcher("/doctor-prescriptions.jsp").forward(request, response);
    }

    private void viewPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Prescription prescription = prescriptionController.getPrescriptionById(id);

        if (prescription != null) {
            request.setAttribute("prescription", prescription);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-view-prescription.jsp").forward(request, response);
            } else if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-view-prescription.jsp").forward(request, response);
            } else if ("PATIENT".equals(userRole)) {
                request.getRequestDispatcher("/patient-view-prescription.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Prescription not found");
            response.sendRedirect("PrescriptionServlet");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("DOCTOR".equals(userRole)) {
            // If coming from a medical record, get the medical record ID
            String medicalRecordIdStr = request.getParameter("medicalRecordId");
            if (medicalRecordIdStr != null && !medicalRecordIdStr.isEmpty()) {
                int medicalRecordId = Integer.parseInt(medicalRecordIdStr);
                request.setAttribute("medicalRecordId", medicalRecordId);
            }

            request.getRequestDispatcher("/doctor-add-prescription.jsp").forward(request, response);
        } else if ("ADMIN".equals(userRole)) {
            request.getRequestDispatcher("/admin-add-prescription.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Prescription prescription = prescriptionController.getPrescriptionById(id);

        if (prescription != null) {
            request.setAttribute("prescription", prescription);

            HttpSession session = request.getSession();
            String userRole = (String) session.getAttribute("userRole");

            if ("DOCTOR".equals(userRole)) {
                request.getRequestDispatcher("/doctor-edit-prescription.jsp").forward(request, response);
            } else if ("ADMIN".equals(userRole)) {
                request.getRequestDispatcher("/admin-edit-prescription.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Prescription not found");
            response.sendRedirect("PrescriptionServlet");
        }
    }

    private void addPrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userIdStr = (String) session.getAttribute("userId");

        if (userIdStr == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Convert String userId to Integer
        int doctorId = Integer.parseInt(userIdStr);

        int medicalRecordId = Integer.parseInt(request.getParameter("medicalRecordId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        Date prescriptionDate = Date.valueOf(request.getParameter("prescriptionDate"));
        String notes = request.getParameter("notes");

        // Get prescription items
        String[] medicationNames = request.getParameterValues("medicationName");
        String[] dosages = request.getParameterValues("dosage");
        String[] frequencies = request.getParameterValues("frequency");
        String[] durations = request.getParameterValues("duration");
        String[] instructions = request.getParameterValues("instructions");

        List<PrescriptionItem> items = new ArrayList<>();

        if (medicationNames != null) {
            for (int i = 0; i < medicationNames.length; i++) {
                PrescriptionItem item = new PrescriptionItem();
                item.setMedicationName(medicationNames[i]);
                item.setDosage(dosages[i]);
                item.setFrequency(frequencies[i]);
                item.setDuration(durations[i]);
                item.setInstructions(instructions[i]);
                items.add(item);
            }
        }

        boolean success = prescriptionController.addPrescription(medicalRecordId, patientId, doctorId,
                                                               prescriptionDate, notes, items);

        if (success) {
            request.setAttribute("successMessage", "Prescription added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add prescription");
        }

        listDoctorPrescriptions(request, response);
    }

    private void updatePrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int medicalRecordId = Integer.parseInt(request.getParameter("medicalRecordId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        Date prescriptionDate = Date.valueOf(request.getParameter("prescriptionDate"));
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        // Get prescription items
        String[] itemIds = request.getParameterValues("itemId");
        String[] medicationNames = request.getParameterValues("medicationName");
        String[] dosages = request.getParameterValues("dosage");
        String[] frequencies = request.getParameterValues("frequency");
        String[] durations = request.getParameterValues("duration");
        String[] instructions = request.getParameterValues("instructions");

        List<PrescriptionItem> items = new ArrayList<>();

        if (medicationNames != null) {
            for (int i = 0; i < medicationNames.length; i++) {
                PrescriptionItem item = new PrescriptionItem();

                // If item ID exists, set it (for existing items)
                if (itemIds != null && i < itemIds.length && !itemIds[i].isEmpty()) {
                    item.setId(Integer.parseInt(itemIds[i]));
                }

                item.setPrescriptionId(id);
                item.setMedicationName(medicationNames[i]);
                item.setDosage(dosages[i]);
                item.setFrequency(frequencies[i]);
                item.setDuration(durations[i]);
                item.setInstructions(instructions[i]);
                items.add(item);
            }
        }

        boolean success = prescriptionController.updatePrescription(id, medicalRecordId, patientId, doctorId,
                                                                  prescriptionDate, status, notes, items);

        if (success) {
            request.setAttribute("successMessage", "Prescription updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update prescription");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllPrescriptions(request, response);
        } else {
            listDoctorPrescriptions(request, response);
        }
    }

    private void updatePrescriptionStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        boolean success = prescriptionController.updatePrescriptionStatus(id, status);

        if (success) {
            request.setAttribute("successMessage", "Prescription status updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update prescription status");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllPrescriptions(request, response);
        } else if ("DOCTOR".equals(userRole)) {
            listDoctorPrescriptions(request, response);
        } else {
            listPatientPrescriptions(request, response);
        }
    }

    private void deletePrescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = prescriptionController.deletePrescription(id);

        if (success) {
            request.setAttribute("successMessage", "Prescription deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete prescription");
        }

        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if ("ADMIN".equals(userRole)) {
            listAllPrescriptions(request, response);
        } else {
            listDoctorPrescriptions(request, response);
        }
    }
}
