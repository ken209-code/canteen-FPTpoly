package com.javaweb.servlet;

import com.javaweb.model.Customer;
import com.javaweb.model.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

/**
 * AdminServlet - Quản lý người dùng (Xem, Khóa, Xóa tài khoản)
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    // Dữ liệu mẫu lưu trong memory
    private static List<Customer> customers = new ArrayList<>();
    private static List<Staff> staffList = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo dữ liệu mẫu
        initSampleData();
    }

    /**
     * Khởi tạo dữ liệu mẫu
     */
    private void initSampleData() {
        if (customers.isEmpty()) {
            Customer c1 = new Customer("SV001", "password123", "sv001@student.edu.vn", "Nguyễn Văn A");
            c1.setUserId(1);
            c1.setStudentCode("SV001");
            c1.setClassName("C1");
            c1.setBalance(500000);
            c1.setStatus("ACTIVE");
            customers.add(c1);

            Customer c2 = new Customer("SV002", "password123", "sv002@student.edu.vn", "Trần Thị B");
            c2.setUserId(2);
            c2.setStudentCode("SV002");
            c2.setClassName("C2");
            c2.setBalance(750000);
            c2.setStatus("ACTIVE");
            customers.add(c2);
        }

        if (staffList.isEmpty()) {
            Staff s1 = new Staff("STAFF001", "password123", "staff001@canteen.edu.vn", "Lê Văn C");
            s1.setUserId(1);
            s1.setStaffCode("NV001");
            s1.setPosition("Quản lý bán hàng");
            s1.setDepartment("Kinh doanh");
            s1.setStatus("ACTIVE");
            staffList.add(s1);

            Staff s2 = new Staff("STAFF002", "password123", "staff002@canteen.edu.vn", "Phạm Thị D");
            s2.setUserId(2);
            s2.setStaffCode("NV002");
            s2.setPosition("Thu ngân");
            s2.setDepartment("Tài chính");
            s2.setStatus("ACTIVE");
            staffList.add(s2);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        // Only ADMIN or STAFF can access
        if (!("ADMIN".equals(role) || "STAFF".equals(role))) {
            response.sendError(403, "Bạn không có quyền truy cập!");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            // Dashboard admin
            showAdminDashboard(request, response);
        } else if ("customers".equals(action)) {
            // Quản lý khách hàng
            listCustomers(request, response);
        } else if ("staff".equals(action)) {
            // Quản lý nhân viên
            listStaff(request, response);
        } else if ("view_customer".equals(action)) {
            // Xem chi tiết khách hàng
            viewCustomer(request, response);
        } else if ("view_staff".equals(action)) {
            // Xem chi tiết nhân viên
            viewStaff(request, response);
        } else if ("edit_staff".equals(action)) {
            // Chỉnh sửa thông tin nhân viên
            showEditStaffForm(request, response);
        } else if ("add_staff".equals(action)) {
            // Form thêm nhân viên mới
            showAddStaffForm(request, response);
        } else if ("block".equals(action)) {
            // Khóa tài khoản
            blockUser(request, response);
        } else if ("unblock".equals(action)) {
            // Mở khóa tài khoản
            unblockUser(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete_customer".equals(action)) {
            deleteCustomer(request, response);
        } else if ("delete_staff".equals(action)) {
            deleteStaff(request, response);
        } else if ("save_staff".equals(action)) {
            saveStaff(request, response);
        }
    }

    /**
     * Hiển thị dashboard admin
     */
    private void showAdminDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Thống kê tổng quan
        int totalCustomers = customers.size();
        int totalStaff = staffList.size();
        int activeCustomers = (int) customers.stream().filter(c -> "ACTIVE".equals(c.getStatus())).count();
        int activeStaff = (int) staffList.stream().filter(s -> "ACTIVE".equals(s.getStatus())).count();

        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalStaff", totalStaff);
        request.setAttribute("activeCustomers", activeCustomers);
        request.setAttribute("activeStaff", activeStaff);

        request.getRequestDispatcher("/views/canteen/admin_dashboard.jsp").forward(request, response);
    }

    /**
     * Liệt kê danh sách khách hàng
     */
    private void listCustomers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/views/canteen/admin_customers.jsp").forward(request, response);
    }

    /**
     * Liệt kê danh sách nhân viên
     */
    private void listStaff(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/views/canteen/admin_staff.jsp").forward(request, response);
    }

    /**
     * Xem chi tiết khách hàng
     */
    private void viewCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        Customer customer = findCustomerById(customerId);
        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/views/canteen/admin_customer_detail.jsp").forward(request, response);
        } else {
            response.sendError(404, "Khách hàng không tồn tại");
        }
    }

    /**
     * Xem chi tiết nhân viên
     */
    private void viewStaff(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int staffId = Integer.parseInt(request.getParameter("id"));
        Staff staff = findStaffById(staffId);
        if (staff != null) {
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("/views/canteen/admin_staff_detail.jsp").forward(request, response);
        } else {
            response.sendError(404, "Nhân viên không tồn tại");
        }
    }

    /**
     * Khóa tài khoản
     */
    private void blockUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String actionTarget = "customers";
        if ("staff".equals(userType)) {
            actionTarget = "staff";
        }
        String redirectUrl = request.getContextPath() + "/admin?action=" + actionTarget;

        try {
            int userId = Integer.parseInt(request.getParameter("id"));

            if ("customer".equals(userType)) {
                Customer customer = findCustomerById(userId);
                if (customer != null) {
                    customer.setStatus("INACTIVE");
                    String success = URLEncoder.encode("Khóa tài khoản khách hàng thành công!", StandardCharsets.UTF_8);
                    redirectUrl += "&success=" + success;
                }
            } else if ("staff".equals(userType)) {
                Staff staff = findStaffById(userId);
                if (staff != null) {
                    staff.setStatus("INACTIVE");
                    String success = URLEncoder.encode("Khóa tài khoản nhân viên thành công!", StandardCharsets.UTF_8);
                    redirectUrl += "&success=" + success;
                }
            }
        } catch (Exception e) {
            String error = URLEncoder.encode("Lỗi: " + e.getMessage(), StandardCharsets.UTF_8);
            redirectUrl += "&error=" + error;
        }

        response.sendRedirect(redirectUrl);
    }

    /**
     * Mở khóa tài khoản
     */
    private void unblockUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String actionTarget = "customers";
        if ("staff".equals(userType)) {
            actionTarget = "staff";
        }
        String redirectUrl = request.getContextPath() + "/admin?action=" + actionTarget;

        try {
            int userId = Integer.parseInt(request.getParameter("id"));

            if ("customer".equals(userType)) {
                Customer customer = findCustomerById(userId);
                if (customer != null) {
                    customer.setStatus("ACTIVE");
                    String success = URLEncoder.encode("Mở khóa tài khoản khách hàng thành công!", StandardCharsets.UTF_8);
                    redirectUrl += "&success=" + success;
                }
            } else if ("staff".equals(userType)) {
                Staff staff = findStaffById(userId);
                if (staff != null) {
                    staff.setStatus("ACTIVE");
                    String success = URLEncoder.encode("Mở khóa tài khoản nhân viên thành công!", StandardCharsets.UTF_8);
                    redirectUrl += "&success=" + success;
                }
            }
        } catch (Exception e) {
            String error = URLEncoder.encode("Lỗi: " + e.getMessage(), StandardCharsets.UTF_8);
            redirectUrl += "&error=" + error;
        }

        response.sendRedirect(redirectUrl);
    }

    /**
     * Xóa khách hàng
     */
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("id"));
            Customer customer = findCustomerById(customerId);
            if (customer != null) {
                customers.remove(customer);
                request.setAttribute("success", "Xóa khách hàng thành công!");
            }
            listCustomers(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            listCustomers(request, response);
        }
    }

    /**
     * Xóa nhân viên
     */
    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int staffId = Integer.parseInt(request.getParameter("id"));
            Staff staff = findStaffById(staffId);
            if (staff != null) {
                staffList.remove(staff);
                request.setAttribute("success", "Xóa nhân viên thành công!");
            }
            listStaff(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            listStaff(request, response);
        }
    }

    /**
     * Tìm khách hàng theo ID
     */
    private Customer findCustomerById(int customerId) {
        for (Customer customer : customers) {
            if (customer.getUserId() == customerId) {
                return customer;
            }
        }
        return null;
    }

    /**
     * Tìm nhân viên theo ID
     */
    private Staff findStaffById(int staffId) {
        for (Staff staff : staffList) {
            if (staff.getUserId() == staffId) {
                return staff;
            }
        }
        return null;
    }

    private void showAddStaffForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Thêm nhân viên mới");
        request.setAttribute("formAction", "save_staff");
        request.setAttribute("staff", new Staff());
        request.getRequestDispatcher("/views/canteen/admin_staff_form.jsp").forward(request, response);
    }

    private void saveStaff(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String staffCode = request.getParameter("staffCode");
            String position = request.getParameter("position");
            String department = request.getParameter("department");
            double salary = 0;
            try {
                String salaryStr = request.getParameter("salary");
                if (salaryStr != null && !salaryStr.trim().isEmpty()) {
                    salary = Double.parseDouble(salaryStr);
                }
            } catch (NumberFormatException ignored) {
            }
            boolean isNewStaff = idParam == null || idParam.trim().isEmpty() || "0".equals(idParam.trim());
            Staff staff;
            if (!isNewStaff) {
                int staffId = Integer.parseInt(idParam.trim());
                staff = findStaffById(staffId);
                if (staff == null) {
                    request.setAttribute("error", "Nhân viên không tồn tại để cập nhật.");
                    listStaff(request, response);
                    return;
                }
                staff.setUsername(username);
                staff.setPassword(password);
                staff.setEmail(email);
                staff.setFullName(fullName);
            } else {
                staff = new Staff(username, password, email, fullName);
                staff.setUserId(staffList.isEmpty() ? 1 : staffList.get(staffList.size() - 1).getUserId() + 1);
                staff.setStatus("ACTIVE");
            }
            staff.setStaffCode(staffCode);
            staff.setPosition(position);
            staff.setDepartment(department);
            staff.setSalary(salary);
            if (isNewStaff) {
                staffList.add(staff);
                String success = URLEncoder.encode("Thêm nhân viên mới thành công", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/admin?action=staff&success=" + success);
            } else {
                String success = URLEncoder.encode("Cập nhật nhân viên thành công", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/admin?action=staff&success=" + success);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showAddStaffForm(request, response);
        }
    }

    private void showEditStaffForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int staffId = Integer.parseInt(request.getParameter("id"));
        Staff staff = findStaffById(staffId);
        if (staff == null) {
            response.sendError(404, "Nhân viên không tồn tại");
            return;
        }
        request.setAttribute("pageTitle", "Chỉnh sửa nhân viên");
        request.setAttribute("formAction", "save_staff");
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("/views/canteen/admin_staff_form.jsp").forward(request, response);
    }
}
