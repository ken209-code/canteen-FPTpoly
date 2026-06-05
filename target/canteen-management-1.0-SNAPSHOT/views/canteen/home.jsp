<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ Căn Tin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body {
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .nav-brand {
            font-size: 1.5em;
            font-weight: bold;
            color: white;
        }
        .nav-menu {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .nav-link:hover {
            background-color: rgba(255,255,255,0.2);
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: #eef4ff;
            border-radius: 24px;
        }
        .welcome-section {
            background: #f8fbff;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
        }
        .welcome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .balance-card {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 8px;
            text-align: center;
        }
        .balance-label {
            font-size: 0.9em;
            opacity: 0.9;
        }
        .balance-amount {
            font-size: 2.5em;
            font-weight: bold;
            margin: 10px 0;
        }
        .menu-section {
            margin-bottom: 30px;
        }
        .section-title {
            font-size: 1.5em;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        .food-card {
            background: #f8fbff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            transition: transform 0.3s;
        }
        .food-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .food-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4em;
        }
        .food-info {
            padding: 15px;
        }
        .food-name {
            font-size: 1.1em;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }
        .food-category {
            font-size: 0.85em;
            color: #666;
            margin-bottom: 10px;
        }
        .food-price {
            font-size: 1.3em;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 15px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            width: 100%;
            text-align: center;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .quick-menu {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        .quick-menu a {
            flex: 1;
            padding: 15px;
            background-color: #f8fbff;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            color: #333;
            box-shadow: 0 2px 4px rgba(0,0,0,0.08);
            transition: background-color 0.3s;
        }
        .quick-menu a:hover {
            background-color: #e9ecef;
        }
        .quick-icon {
            font-size: 2em;
            margin-bottom: 10px;
        }
        .quick-title {
            font-weight: 600;
            margin-top: 5px;
        }
        .history-section {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.04);
        }
        .history-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 12px;
        }
        .history-table th,
        .history-table td {
            border-bottom: 1px solid #e5e7eb;
            padding: 10px 12px;
            text-align: left;
        }
        .history-table th {
            color: #4b5563;
            font-weight: 600;
            background: #f8fafc;
        }
        .history-table tr:hover {
            background: #f1f5f9;
        }
        .history-section .section-title {
            margin-bottom: 14px;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <!-- Navigation -->
    <jsp:include page="nav.jsp" />
    
    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-header">
                <div>
                    <h1 style="margin: 0 0 10px 0;">👋 Xin Chào ${sessionScope.user}!</h1>
                    <p style="color: #666; margin: 0;">Chào mừng bạn đến với Căn Tin FPoly</p>
                </div>
                <div class="balance-card">
                    <div class="balance-label">Số Dư Tài Khoản</div>
                    <div class="balance-amount">500.000đ</div>
                    <small>Khả dụng để đặt hàng</small>
                </div>
            </div>
        </div>

        <!-- Quick Menu -->
        <div class="quick-menu">
            <a href="${pageContext.request.contextPath}/menu">
                <div class="quick-icon">🍽️</div>
                <div class="quick-title">Xem Menu</div>
            </a>
            <a href="${pageContext.request.contextPath}/order">
                <div class="quick-icon">📋</div>
                <div class="quick-title">Đơn Hàng Của Tôi</div>
            </a>
            <a href="${pageContext.request.contextPath}/payment">
                <div class="quick-icon">💰</div>
                <div class="quick-title">Thanh Toán</div>
            </a>
        </div>

        <!-- Recent Order History -->
        <div class="history-section">
            <h2 class="section-title">📜 Lịch sử đơn hàng gần đây</h2>
            <c:choose>
                <c:when test="${not empty requestScope.recentOrders}">
                    <table class="history-table">
                        <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Ngày</th>
                            <th>Tổng</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.recentOrders}" var="order">
                            <tr>
                                <td>#${order.orderId}</td>
                                <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">Chờ xử lý</c:when>
                                        <c:when test="${order.status == 'PROCESSING'}">Đang làm</c:when>
                                        <c:when test="${order.status == 'DELIVERING'}">Đang giao hàng</c:when>
                                        <c:when test="${order.status == 'ARRIVED'}">Đã đến nơi</c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">Đã giao</c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">Hoàn thành</c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">Đã hủy</c:when>
                                        <c:otherwise>${order.status}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div style="margin-top: 14px; text-align: right;">
                        <a href="${pageContext.request.contextPath}/order" class="btn btn-primary">Xem tất cả đơn hàng</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-message" style="margin-top: 16px;">
                        Bạn chưa có đơn hàng nào. Hãy đặt món ngay để xem lịch sử đơn hàng ở đây.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Featured Items -->
        <div class="menu-section">
            <h2 class="section-title">🌟 Các Món Nổi Bật</h2>
            <div class="food-grid">
                <div class="food-card">
                    <div class="food-image">🍛</div>
                    <div class="food-info">
                        <div class="food-name">Cơm Tấm Sườn Nướng</div>
                        <div class="food-category">📁 Cơm</div>
                        <div class="food-price">35.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=1" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>

                <div class="food-card">
                    <div class="food-image">🍜</div>
                    <div class="food-info">
                        <div class="food-name">Phở Bò Nước Dùng</div>
                        <div class="food-category">📁 Món ăn nước</div>
                        <div class="food-price">45.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=2" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>

                <div class="food-card">
                    <div class="food-image">🥪</div>
                    <div class="food-info">
                        <div class="food-name">Bánh Mì Thịt</div>
                        <div class="food-category">📁 Bánh Mì</div>
                        <div class="food-price">25.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=3" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>

                <div class="food-card">
                    <div class="food-image">🍗</div>
                    <div class="food-info">
                        <div class="food-name">Gà Rán Giòn</div>
                        <div class="food-category">📁 Gà Rán</div>
                        <div class="food-price">55.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=5" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>

                <div class="food-card">
                    <div class="food-image">🧃</div>
                    <div class="food-info">
                        <div class="food-name">Nước Cam Tươi</div>
                        <div class="food-category">📁 Thức Uống</div>
                        <div class="food-price">15.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=4" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>

                <div class="food-card">
                    <div class="food-image">☕</div>
                    <div class="food-info">
                        <div class="food-name">Cà Phê Đen</div>
                        <div class="food-category">📁 Thức Uống</div>
                        <div class="food-price">12.000đ</div>
                        <a href="${pageContext.request.contextPath}/menu?action=view&id=6" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- CTA Section -->
        <div style="background: #f8fbff; border-radius: 8px; padding: 30px; text-align: center; margin-top: 40px; box-shadow: 0 2px 4px rgba(0,0,0,0.08);">
            <h2 style="margin-top: 0;">Sẵn sàng đặt hàng?</h2>
            <p style="color: #666;">Chọn các món yêu thích của bạn từ menu đầy đủ</p>
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary" style="display: inline-block; width: auto; padding: 15px 40px; font-size: 1.1em;">
                Xem Thực Đơn Đầy Đủ →
            </a>
        </div>
    </div>
</body>
</html>
