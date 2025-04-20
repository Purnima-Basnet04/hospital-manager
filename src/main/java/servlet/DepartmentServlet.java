package servlet;

import controller.DepartmentController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Department;

import java.io.IOException;
import java.util.List;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    
    private DepartmentController departmentController;
    
    @Override
    public void init() throws ServletException {
        departmentController = new DepartmentController();
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
                viewDepartment(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteDepartment(request, response);
                break;
            default:
                listDepartments(request, response);
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
                addDepartment(request, response);
                break;
            case "update":
                updateDepartment(request, response);
                break;
            default:
                listDepartments(request, response);
                break;
        }
    }
    
    private void listDepartments(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Department> departments = departmentController.getAllDepartments();
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/admin-departments.jsp").forward(request, response);
    }
    
    private void viewDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Department department = departmentController.getDepartmentById(id);
        
        if (department != null) {
            request.setAttribute("department", department);
            request.getRequestDispatcher("/admin-view-department.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Department not found");
            listDepartments(request, response);
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/admin-add-department.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Department department = departmentController.getDepartmentById(id);
        
        if (department != null) {
            request.setAttribute("department", department);
            request.getRequestDispatcher("/admin-edit-department.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Department not found");
            listDepartments(request, response);
        }
    }
    
    private void addDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String headDoctorIdStr = request.getParameter("headDoctorId");
        
        int headDoctorId = 0;
        if (headDoctorIdStr != null && !headDoctorIdStr.isEmpty()) {
            headDoctorId = Integer.parseInt(headDoctorIdStr);
        }
        
        boolean success = departmentController.addDepartment(name, description, location, headDoctorId);
        
        if (success) {
            request.setAttribute("successMessage", "Department added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add department");
        }
        
        listDepartments(request, response);
    }
    
    private void updateDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String headDoctorIdStr = request.getParameter("headDoctorId");
        
        int headDoctorId = 0;
        if (headDoctorIdStr != null && !headDoctorIdStr.isEmpty()) {
            headDoctorId = Integer.parseInt(headDoctorIdStr);
        }
        
        boolean success = departmentController.updateDepartment(id, name, description, location, headDoctorId);
        
        if (success) {
            request.setAttribute("successMessage", "Department updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update department");
        }
        
        listDepartments(request, response);
    }
    
    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = departmentController.deleteDepartment(id);
        
        if (success) {
            request.setAttribute("successMessage", "Department deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete department");
        }
        
        listDepartments(request, response);
    }
}
