package model;

public class Admin {
    private int adminID;
    private String password;
    private String name;
    private String email;
    private String phone;
    
    // Constructors
    public Admin() {
    }
    
    public Admin(int adminID, String password, String name, String email, String phone) {
        this.adminID = adminID;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phone = phone;
    }
    
    // Getters and Setters
    public int getAdminID() {
        return adminID;
    }
    
    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }
    
    public String getAdminIDString() {
        return String.valueOf(adminID);
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    // For compatibility with authentication system
    public String getRole() {
        return "ADMIN";
    }
    
    // For compatibility with session attributes
    public String getFullName() {
        return name;
    }
    
    public String getUsername() {
        return email; // Use email as username for admins
    }
}
