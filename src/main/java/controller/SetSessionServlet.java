package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class SetSessionServlet
 * This servlet is used to set session attributes for the user
 */
@WebServlet("/SetSessionServlet")
public class SetSessionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SetSessionServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get parameters from request
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        String redirect = request.getParameter("redirect");

        // Validate parameters
        if (username == null || username.trim().isEmpty() || role == null || role.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=invalid");
            return;
        }

        // Create or get the session
        HttpSession session = request.getSession(true);

        // Set session attributes
        session.setAttribute("username", username);
        session.setAttribute("userRole", role);

        // Set session timeout (30 minutes)
        session.setMaxInactiveInterval(30 * 60);

        // Redirect to the appropriate page
        if (redirect != null && !redirect.trim().isEmpty()) {
            response.sendRedirect(redirect);
        } else {
            // Default redirect based on role
            if ("ADMIN".equals(role)) {
                response.sendRedirect("dashboard-admin.jsp");
            } else if ("DOCTOR".equals(role)) {
                response.sendRedirect("dashboard-doctor.jsp");
            } else if ("PATIENT".equals(role)) {
                response.sendRedirect("dashboard-patient.jsp");
            } else {
                response.sendRedirect("login.jsp");
            }
        }
    }
}
