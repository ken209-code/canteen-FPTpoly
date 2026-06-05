package com.javaweb.servlet;

import com.javaweb.model.MenuItem;
import com.javaweb.model.Review;
import com.javaweb.util.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * ReviewServlet - Quản lý đánh giá sản phẩm
 */
@WebServlet("/review")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            // Xem các reviews của một sản phẩm
            int itemId = Integer.parseInt(request.getParameter("item_id"));
            
            List<Review> reviews = reviewDAO.getReviewsByItem(itemId);
            double avgRating = reviewDAO.getAverageRating(itemId);
            int reviewCount = reviewDAO.getReviewCount(itemId);
            int[] ratingDistribution = reviewDAO.getRatingDistribution(itemId);
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("avgRating", avgRating);
            request.setAttribute("reviewCount", reviewCount);
            request.setAttribute("ratingDistribution", ratingDistribution);
            request.setAttribute("itemId", itemId);
            
            request.getRequestDispatcher("/views/canteen/reviews.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("add".equals(action)) {
            try {
                int itemId = Integer.parseInt(request.getParameter("item_id"));
                int orderId = Integer.parseInt(request.getParameter("order_id"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                
                // Lấy customer từ session
                Object userObj = session.getAttribute("user");
                if (userObj == null) {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    request.setAttribute("error", "Bạn phải đăng nhập để đánh giá");
                    request.getRequestDispatcher("/views/canteen/login.jsp").forward(request, response);
                    return;
                }
                
                // Giả sử user là Customer - cần cast tùy vào cấu trúc thực tế
                Object customerId = session.getAttribute("userId");
                
                Review review = new Review(itemId, Integer.parseInt(customerId.toString()), orderId, rating, comment);
                
                if (reviewDAO.addReview(review)) {
                    // Cập nhật rating trên menu_items table
                    updateMenuItemRating(itemId);
                    
                    response.sendRedirect("/menu?action=view&id=" + itemId + "&success=review_added");
                } else {
                    request.setAttribute("error", "Lỗi khi thêm đánh giá");
                    request.getRequestDispatcher("/views/canteen/menu_detail.jsp?id=" + itemId).forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Dữ liệu không hợp lệ");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        }
    }

    /**
     * Cập nhật rating trung bình cho sản phẩm
     */
    private void updateMenuItemRating(int itemId) {
        double avgRating = reviewDAO.getAverageRating(itemId);
        int reviewCount = reviewDAO.getReviewCount(itemId);
        
        String sql = "UPDATE menu_items SET rating = ?, review_count = ? WHERE item_id = ?";
        
        try (java.sql.Connection conn = com.javaweb.util.DatabaseConnection.getConnection();
             java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDouble(1, avgRating);
            pstmt.setInt(2, reviewCount);
            pstmt.setInt(3, itemId);
            pstmt.executeUpdate();
        } catch (java.sql.SQLException e) {
            System.err.println("Error updating menu item rating: " + e.getMessage());
        }
    }
}
