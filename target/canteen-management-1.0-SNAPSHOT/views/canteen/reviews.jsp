<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javaweb.model.Review" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .rating-header {
            background: linear-gradient(135deg, #ff6b6b, #4ecdc4);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        .avg-rating {
            font-size: 2.5rem;
            font-weight: 700;
        }
        .star { color: #ffc107; font-size: 1.5rem; }
        .review-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #ff6b6b;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        .review-author {
            font-weight: 600;
            color: #2c3e50;
        }
        .review-date {
            color: #999;
            font-size: 0.9rem;
        }
        .review-comment {
            line-height: 1.6;
            color: #555;
        }
        .verified-badge {
            background: #4ecdc4;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            display: inline-block;
            margin-left: 10px;
        }
        .rating-distribution {
            margin: 20px 0;
        }
        .rating-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 10px 0;
        }
        .rating-label {
            width: 50px;
            text-align: right;
        }
        .rating-bar {
            flex: 1;
            background: #f0f0f0;
            height: 20px;
            border-radius: 10px;
            overflow: hidden;
        }
        .rating-bar-fill {
            background: #ffc107;
            height: 100%;
            transition: width 0.3s ease;
        }
        .rating-count {
            width: 50px;
            text-align: left;
            color: #666;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <div class="container mt-4">
        <a href="javascript:history.back()" class="btn btn-outline-secondary mb-3">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>

        <!-- Rating Header -->
        <div class="rating-header">
            <div class="avg-rating">
                <i class="bi bi-star-fill star"></i> ${avgRating}
            </div>
            <p class="mb-0">${reviewCount} đánh giá</p>
        </div>

        <!-- Rating Distribution -->
        <c:if test="${ratingDistribution != null}">
            <div class="rating-distribution">
                <h5 class="mb-3">Phân bố đánh giá</h5>
                <c:forEach var="i" begin="4" end="0" step="-1">
                    <div class="rating-row">
                        <div class="rating-label">
                            <i class="bi bi-star-fill star"></i> ${i+1}
                        </div>
                        <div class="rating-bar">
                            <div class="rating-bar-fill" style="width: ${ratingDistribution[i] > 0 ? (ratingDistribution[i] * 100 / reviewCount) : 0}%"></div>
                        </div>
                        <div class="rating-count">${ratingDistribution[i]}</div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- Reviews -->
        <h4 class="mt-4 mb-3">Tất cả đánh giá (${reviewCount})</h4>
        
        <c:if test="${not empty reviews}">
            <c:forEach items="${reviews}" var="review">
                <div class="review-card">
                    <div class="review-header">
                        <div>
                            <span class="review-author">Khách hàng #${review.customerId}</span>
                            <c:if test="${review.verifiedPurchase}">
                                <span class="verified-badge">✓ Mua thực tế</span>
                            </c:if>
                        </div>
                        <div class="review-date">${review.createdAt}</div>
                    </div>
                    
                    <div class="mb-2">
                        <c:forEach var="i" begin="0" end="4">
                            <c:if test="${i < review.rating}">
                                <i class="bi bi-star-fill star"></i>
                            </c:if>
                            <c:if test="${i >= review.rating}">
                                <i class="bi bi-star star" style="color: #ddd;"></i>
                            </c:if>
                        </c:forEach>
                    </div>
                    
                    <p class="review-comment">${review.comment}</p>
                    
                    <c:if test="${review.helpfulCount > 0}">
                        <small class="text-muted">
                            <i class="bi bi-hand-thumbs-up"></i> ${review.helpfulCount} người thấy hữu ích
                        </small>
                    </c:if>
                </div>
            </c:forEach>
        </c:if>
        
        <c:if test="${empty reviews}">
            <div style="text-align: center; padding: 40px; background: #f9f9f9; border-radius: 8px;">
                <i class="bi bi-chat-dots" style="font-size: 3rem; color: #ccc;"></i>
                <p class="text-muted mt-3">Chưa có đánh giá nào</p>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
