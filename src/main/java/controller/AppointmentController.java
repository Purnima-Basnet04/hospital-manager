package controller;

import dao.AppointmentDAO;
import model.Appointment;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class AppointmentController {

    private AppointmentDAO appointmentDAO;

    public AppointmentController() {
        appointmentDAO = new AppointmentDAO();
    }

    public boolean bookAppointment(int patientId, int doctorId, Date appointmentDate,
                                  Time appointmentTime, String reason) {
        Appointment appointment = new Appointment();
        appointment.setPatientId(patientId);
        appointment.setDoctorId(doctorId);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setAppointmentTime(appointmentTime);
        appointment.setStatus("SCHEDULED");
        appointment.setReason(reason);
        appointment.setNotes("");

        return appointmentDAO.addAppointment(appointment);
    }

    public Appointment getAppointmentById(int id) {
        return appointmentDAO.getAppointmentById(id);
    }

    public List<Appointment> getAppointmentsByPatientId(int patientId) {
        return appointmentDAO.getAppointmentsByPatientId(patientId);
    }

    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        return appointmentDAO.getAppointmentsByDoctorId(doctorId);
    }

    public List<Appointment> getAllAppointments() {
        return appointmentDAO.getAllAppointments();
    }

    public boolean updateAppointmentStatus(int id, String status, String notes) {
        Appointment appointment = appointmentDAO.getAppointmentById(id);

        if (appointment != null) {
            appointment.setStatus(status);
            appointment.setNotes(notes);
            return appointmentDAO.updateAppointment(appointment);
        }

        return false;
    }

    public boolean rescheduleAppointment(int id, Date newDate, Time newTime) {
        Appointment appointment = appointmentDAO.getAppointmentById(id);

        if (appointment != null) {
            appointment.setAppointmentDate(newDate);
            appointment.setAppointmentTime(newTime);
            return appointmentDAO.updateAppointment(appointment);
        }

        return false;
    }

    public boolean cancelAppointment(int id) {
        return appointmentDAO.deleteAppointment(id);
    }

    public boolean updateAppointment(int id, int patientId, int doctorId, Date appointmentDate,
                                   Time appointmentTime, String status, String reason, String notes) {
        Appointment appointment = appointmentDAO.getAppointmentById(id);

        if (appointment != null) {
            appointment.setPatientId(patientId);
            appointment.setDoctorId(doctorId);
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setStatus(status);
            appointment.setReason(reason);
            appointment.setNotes(notes);

            return appointmentDAO.updateAppointment(appointment);
        }

        return false;
    }
}