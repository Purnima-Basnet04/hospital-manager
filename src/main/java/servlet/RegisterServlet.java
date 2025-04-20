package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/RegisterServletOld")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String bloodGroup = request.getParameter("bloodGroup");
        String emergencyContact = request.getParameter("emergencyContact");
        String address = request.getParameter("address");
        String medicalHistory = request.getParameter("medicalHistory");
        String allergies = request.getParameter("allergies");

        // Validate required fields
        if (fullName == null || username == null || email == null || password == null ||
            confirmPassword == null || phone == null || gender == null || dateOfBirthStr == null ||
            bloodGroup == null || emergencyContact == null || address == null ||
            fullName.isEmpty() || username.isEmpty() || email.isEmpty() || password.isEmpty() ||
            confirmPassword.isEmpty() || phone.isEmpty() || gender.isEmpty() || dateOfBirthStr.isEmpty() ||
            bloodGroup.isEmpty() || emergencyContact.isEmpty() || address.isEmpty()) {

            response.sendRedirect("register.jsp?error=missing");
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=2");
            return;
        }

        // Parse date of birth
        Date dateOfBirth;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            dateOfBirth = sdf.parse(dateOfBirthStr);
        } catch (ParseException e) {
            response.sendRedirect("register.jsp?error=3");
            return;
        }

        // Database operations
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();

            // Check if username already exists
            pstmt = conn.prepareStatement("SELECT username FROM users WHERE username = ?");
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=1");
                return;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=4");
            return;
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        try {
            // Insert new user
            pstmt = conn.prepareStatement(
                "INSERT INTO users (username, password, role) VALUES (?, ?, ?)"
            );
            pstmt.setString(1, username);
            pstmt.setString(2, password); // In a real application, you should hash the password
            pstmt.setString(3, "PATIENT");
            pstmt.executeUpdate();

            // Get the user ID
            pstmt = conn.prepareStatement("SELECT user_id FROM users WHERE username = ?");
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");

                // Insert patient details
                pstmt = conn.prepareStatement(
                    "INSERT INTO patients (user_id, full_name, email, phone, gender, date_of_birth, " +
                    "blood_group, emergency_contact, address, medical_history, allergies) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                );
                pstmt.setInt(1, userId);
                pstmt.setString(2, fullName);
                pstmt.setString(3, email);
                pstmt.setString(4, phone);
                pstmt.setString(5, gender);
                pstmt.setDate(6, new java.sql.Date(dateOfBirth.getTime()));
                pstmt.setString(7, bloodGroup);
                pstmt.setString(8, emergencyContact);
                pstmt.setString(9, address);
                pstmt.setString(10, medicalHistory);
                pstmt.setString(11, allergies);
                pstmt.executeUpdate();

                // Create session for the new user
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userRole", "PATIENT");
                session.setAttribute("fullName", fullName);
                session.setAttribute("userId", userId);

                // Redirect to home page
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("register.jsp?error=4");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=4");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
