package dao;

import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Add a new user (patient)
    public boolean addUser(User user) {
        String query = "INSERT INTO users (username, password, full_name, email, phone, address, Gender, DOB, BloodGroup) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPhone());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getGender());
            pstmt.setDate(8, user.getDob());
            pstmt.setString(9, user.getBloodGroup());

            System.out.println("Adding new patient: " + user.getUsername());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setPatientID(generatedKeys.getInt(1));
                        System.out.println("Patient added successfully with ID: " + user.getPatientID());
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error adding patient: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Get user by ID
    public User getUserById(int id) {
        String query = "SELECT * FROM users WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get user by username
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Get users by role
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, role);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    users.add(extractUserFromResultSet(rs));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Update user details
    public boolean updateUser(User user) {
        String query = "UPDATE users SET username = ?, password = ?, full_name = ?, email = ?, " +
                "phone = ?, address = ?, Gender = ?, DOB = ?, BloodGroup = ? WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPhone());
            pstmt.setString(6, user.getAddress());
            pstmt.setString(7, user.getGender());
            pstmt.setDate(8, user.getDob());
            pstmt.setString(9, user.getBloodGroup());
            pstmt.setInt(10, user.getPatientID());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete user by ID
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE PatientID = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Authenticate user (patient) by username
    public User authenticateUser(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";

        System.out.println("Authenticating patient with username: " + username);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = extractUserFromResultSet(rs);
                    System.out.println("Patient authenticated successfully by username: " + user.getPatientID());
                    return user;
                } else {
                    System.out.println("Patient authentication failed by username: No matching record found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Authentication error: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Authenticate user (patient) by email
    public User authenticateUserByEmail(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        System.out.println("Authenticating patient with email: " + email);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, email);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = extractUserFromResultSet(rs);
                    System.out.println("Patient authenticated successfully by email: " + user.getPatientID());
                    return user;
                } else {
                    System.out.println("Patient authentication failed by email: No matching record found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Authentication error: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    // Helper method to extract a user from the ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setPatientID(rs.getInt("PatientID"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setGender(rs.getString("Gender"));
        user.setDob(rs.getDate("DOB"));
        user.setBloodGroup(rs.getString("BloodGroup"));
        return user;
    }
}
