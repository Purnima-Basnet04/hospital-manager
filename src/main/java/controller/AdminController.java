package controller;

import dao.AdminDAO;
import model.Admin;

import java.util.List;

public class AdminController {

    private AdminDAO adminDAO;

    public AdminController() {
        adminDAO = new AdminDAO();
    }

    public boolean addAdmin(Admin admin) {
        return adminDAO.addAdmin(admin);
    }

    public boolean addAdmin(String name, String email, String password, String phone) {
        Admin admin = new Admin();
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(password);
        admin.setPhone(phone);
        return adminDAO.addAdmin(admin);
    }

    public Admin getAdminById(int id) {
        return adminDAO.getAdminById(id);
    }

    public Admin getAdminByEmail(String email) {
        return adminDAO.getAdminByEmail(email);
    }

    public Admin authenticateAdmin(String email, String password) {
        return adminDAO.authenticateAdmin(email, password);
    }

    public List<Admin> getAllAdmins() {
        return adminDAO.getAllAdmins();
    }

    public boolean updateAdmin(Admin admin) {
        return adminDAO.updateAdmin(admin);
    }

    public boolean deleteAdmin(int id) {
        return adminDAO.deleteAdmin(id);
    }
}
