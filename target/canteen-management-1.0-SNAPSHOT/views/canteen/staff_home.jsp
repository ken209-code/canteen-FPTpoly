<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhân viên Canteen - Trang chính</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .hero {
            max-width: 1100px;
            margin: 30px auto;
            padding: 24px;
        }
        .tiles {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-top: 18px;
        }
        .tile {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 8px 30px rgba(15,23,42,0.06);
            text-align: center;
            text-decoration: none;
            color: #0f172a;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        .tile .icon { font-size: 48px; }
        .tile h3 { margin: 0; font-size: 1.2rem; }
        .tile p { margin: 0; color: #64748b; }
        .tile .cta { margin-top: 12px; background:#2563eb; color:white; padding:8px 14px; border-radius:8px; text-decoration:none; }
        .recent { max-width:1100px; margin: 20px auto; padding:24px; background:white; border-radius:12px; box-shadow:0 8px 30px rgba(15,23,42,0.04); }
        .recent table { width:100%; border-collapse:collapse; }
        .recent th, .recent td { padding:10px; border-bottom:1px solid #eef2f7; text-align:left; }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
<div class="hero">
    <h1>Giao diện Nhân viên Canteen</h1>
    <p>Chọn một chức năng để bắt đầu — chỉ Admin hoặc Nhân viên có quyền truy cập.</p>
    <div class="tiles">
        <a class="tile" href="${pageContext.request.contextPath}/order">
            <div class="icon">📦</div>
            <h3>Quản lý đơn hàng</h3>
            <p>Xem, cập nhật trạng thái và xử lý đơn hàng.</p>
            <span class="cta">Quản lý đơn</span>
        </a>
        <a class="tile" href="${pageContext.request.contextPath}/menu">
            <div class="icon">🍔</div>
            <h3>Quản lý thực đơn</h3>
            <p>Thêm, sửa, xóa món ăn và tùy chỉnh menu.</p>
            <span class="cta">Quản lý menu</span>
        </a>
        <a class="tile" href="${pageContext.request.contextPath}/revenue">
            <div class="icon">📊</div>
            <h3>Thống kê doanh thu</h3>
            <p>Xem báo cáo doanh thu theo ngày, tháng và tổng quan.</p>
            <span class="cta">Xem thống kê</span>
        </a>
    </div>
</div>

<div class="recent">
    <h3>Đơn hàng mới nhất</h3>
    <c:choose>
        <c:when test="${not empty latestOrders}">
            <table>
                <thead>
                    <tr><th>Mã</th><th>Ngày</th><th>Tổng</th><th>Trạng thái</th><th></th></tr>
                </thead>
                <tbody>
                    <c:forEach items="${latestOrders}" var="order">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></td>
                            <td>${order.status}</td>
                            <td><a href="${pageContext.request.contextPath}/order?action=view&id=${order.orderId}">Xem</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>Chưa có đơn hàng nào.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
