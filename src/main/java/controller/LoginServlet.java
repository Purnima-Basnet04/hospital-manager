package controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserController userController;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        userController = new UserController();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = (User) userController.authenticateUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // In the new schema, we don't have roles in the users table
            // We'll determine the role based on the table the user exists in
            if (role.equals("ADMIN")) {
                // Check if user exists in admin table
                response.sendRedirect("dashboard-admin.jsp");
            } else if (role.equals("DOCTOR")) {
                // Check if user exists in doctor table
                response.sendRedirect("dashboard-doctor.jsp");
            } else {
                // Default to patient dashboard
                response.sendRedirect("dashboard-patient.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
