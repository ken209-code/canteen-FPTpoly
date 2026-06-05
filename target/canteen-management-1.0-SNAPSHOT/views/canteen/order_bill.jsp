<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .bill { max-width:800px; margin:30px auto; padding:20px; border:1px solid #ddd; border-radius:8px; background:white; }
        .bill-header { display:flex; justify-content:space-between; align-items:center; gap:12px; flex-wrap:wrap; }
        .btn-print, .btn-back { background:#4ecdc4; color:white; padding:10px 16px; border-radius:6px; text-decoration:none; display:inline-flex; align-items:center; justify-content:center; }
        .btn-back { background:#2563eb; }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
<div class="bill">
    <div class="bill-header">
        <h2>Hóa đơn - Đơn #${order.orderId}</h2>
        <div>
            <a href="${pageContext.request.contextPath}/menu" class="btn-back">Quay lại menu</a>
            <a href="#" class="btn-print" onclick="window.print(); return false;">In hóa đơn</a>
        </div>
    </div>
    <hr />
    <div>
        <p><strong>Khách hàng ID:</strong> ${order.customerId}</p>
        <p><strong>Người nhận:</strong> ${order.recipientName}</p>
        <p><strong>Số điện thoại:</strong> ${order.recipientPhone}</p>
        <p><strong>Địa chỉ:</strong> ${order.recipientAddress}</p>
        <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
        <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></p>
        <c:if test="${order.paymentStatus == 'PAID'}">
            <p><strong>Mã thanh toán:</strong> ${order.paymentReference}</p>
            <p><strong>Ngày thanh toán:</strong> <fmt:formatDate value="${order.paymentDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></p>
        </c:if>
    </div>
    <hr />
    <table style="width:100%; border-collapse:collapse;">
        <thead>
            <tr>
                <th style="text-align:left; padding:8px;">Món</th>
                <th style="text-align:right; padding:8px;">Số lượng</th>
                <th style="text-align:right; padding:8px;">Đơn giá</th>
                <th style="text-align:right; padding:8px;">Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${order.orderDetails}" var="d">
                <tr>
                    <td style="padding:8px;">${d.menuItem.itemName}</td>
                    <td style="padding:8px; text-align:right;">${d.quantity}</td>
                    <td style="padding:8px; text-align:right;">${d.unitPrice}</td>
                    <td style="padding:8px; text-align:right;">${d.subtotal}</td>
                </tr>
            </c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" style="text-align:right; padding:8px;"><strong>Tổng:</strong></td>
                <td style="text-align:right; padding:8px;"><strong><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> đ</strong></td>
            </tr>
        </tfoot>
    </table>
</div>
</body>
</html>