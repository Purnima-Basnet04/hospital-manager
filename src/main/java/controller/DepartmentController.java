package controller;

import dao.DepartmentDAO;
import model.Department;

import java.util.List;

public class DepartmentController {

    private DepartmentDAO departmentDAO;

    public DepartmentController() {
        departmentDAO = new DepartmentDAO();
    }

    // Add a new department
    public boolean addDepartment(String name, String description, String location, int headDoctorId) {
        Department department = new Department();
        department.setName(name);
        department.setDescription(description);
        department.setLocation(location);
        department.setHeadDoctorId(headDoctorId);

        return departmentDAO.addDepartment(department);
    }

    // Get department by ID
    public Department getDepartmentById(int id) {
        return departmentDAO.getDepartmentById(id);
    }

    // Get all departments
    public List<Department> getAllDepartments() {
        return departmentDAO.getAllDepartments();
    }

    // Update department
    public boolean updateDepartment(int id, String name, String description, String location, int headDoctorId) {
        Department department = departmentDAO.getDepartmentById(id);
        if (department == null) {
            return false;
        }

        department.setName(name);
        department.setDescription(description);
        department.setLocation(location);
        department.setHeadDoctorId(headDoctorId);

        return departmentDAO.updateDepartment(department);
    }

    // Delete department
    public boolean deleteDepartment(int id) {
        return departmentDAO.deleteDepartment(id);
    }
}
