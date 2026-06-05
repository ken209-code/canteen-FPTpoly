<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .order-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .info-item {
            margin-bottom: 15px;
        }
        .info-label {
            font-weight: 600;
            color: #666;
            font-size: 0.9em;
        }
        .info-value {
            color: #333;
            font-size: 1.1em;
            margin-top: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .status-badge {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 4px;
            font-weight: 600;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-received {
            background-color: #e6f7ff;
            color: #055160;
        }
        .status-processing {
            background-color: #cfe2ff;
            color: #084298;
        }
        .status-delivering {
            background-color: #cfe2ff;
            color: #084298;
        }
        .status-arrived {
            background-color: #d1fae5;
            color: #0f5132;
        }
        .status-delivered {
            background-color: #d1fae5;
            color: #0f5132;
        }
        .status-completed {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .summary {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-total {
            font-size: 1.3em;
            font-weight: bold;
            color: #007bff;
            border-top: 2px solid #ddd;
            padding-top: 10px;
        }
        .btn-action {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-action:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
    <div class="container">
        <a href="${pageContext.request.contextPath}/order" class="back-link">← Quay lại</a>

        <c:if test="${not empty requestScope.order}">
            <c:set var="order" value="${requestScope.order}"/>
            
            <!-- Order Header -->
            <div class="order-header">
                <h1>Đơn Hàng #${order.orderId}</h1>
                <div class="order-info">
                    <div class="info-item">
                        <div class="info-label">Ngày Đặt</div>
                        <div class="info-value"><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Trạng Thái</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">
                                    <span class="status-badge status-pending">⏳ Chờ xử lý</span>
                                </c:when>
                                <c:when test="${order.status == 'RECEIVED'}">
                                    <span class="status-badge status-received">📥 Đã nhận đơn</span>
                                </c:when>
                                <c:when test="${order.status == 'PROCESSING'}">
                                    <span class="status-badge status-processing">⚙️ Đang làm</span>
                                </c:when>
                                <c:when test="${order.status == 'DELIVERING'}">
                                    <span class="status-badge status-delivering">🚚 Đang giao hàng</span>
                                </c:when>
                                <c:when test="${order.status == 'ARRIVED'}">
                                    <span class="status-badge status-arrived">✅ Đã đến nơi</span>
                                </c:when>
                                <c:when test="${order.status == 'DELIVERED'}">
                                    <span class="status-badge status-delivered">✅ Đã giao</span>
                                </c:when>
                                <c:when test="${order.status == 'COMPLETED'}">
                                    <span class="status-badge status-completed">✓ Hoàn thành</span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Ghi Chú</div>
                        <div class="info-value">${order.notes}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Khách Hàng ID</div>
                        <div class="info-value">${order.customerId}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Người nhận</div>
                        <div class="info-value">${order.recipientName} - ${order.recipientPhone}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Địa chỉ giao</div>
                        <div class="info-value">${order.recipientAddress}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Thanh toán</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'PAID'}">
                                    <span style="color:green; font-weight:700;">Đã thanh toán</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:orange; font-weight:700;">Chưa thanh toán</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <h3>Chi Tiết Các Món</h3>
            <c:choose>
                <c:when test="${not empty order.orderDetails}">
                    <table>
                        <thead>
                            <tr>
                                <th>Tên Món</th>
                                <th>Số Lượng</th>
                                <th>Giá</th>
                                <th>Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${order.orderDetails}" var="detail">
                                <tr>
                                    <td>${detail.menuItem.itemName}</td>
                                    <td>${detail.quantity}</td>
                                    <td><fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="₫"/></td>
                                    <td><fmt:formatNumber value="${detail.subtotal}" type="currency" currencySymbol="₫"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Không có chi tiết đơn hàng</p>
                </c:otherwise>
            </c:choose>

            <!-- Summary -->
            <div class="summary">
                <div class="summary-row">
                    <span>Tổng Cộng:</span>
                    <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></span>
                </div>
                <c:if test="${order.paymentStatus == 'PAID'}">
                    <div class="summary-row">
                        <span>Thanh toán:</span>
                        <span><strong>${order.paymentReference}</strong></span>
                    </div>
                    <div class="summary-row">
                        <span>Ngày thanh toán:</span>
                        <span><fmt:formatDate value="${order.paymentDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </div>
                </c:if>
            </div>

            <!-- Actions -->
            <div style="margin-top: 20px;">
                        <c:choose>
                        <c:when test="${order.paymentMethod == 'COD'}">
                            <a href="${pageContext.request.contextPath}/order?action=viewBill&id=${order.orderId}" class="btn-action btn-primary">In Hóa Đơn</a>
                        </c:when>
                        <c:when test="${order.paymentMethod == 'ONLINE'}">
                            <a href="${pageContext.request.contextPath}/order?action=pay&id=${order.orderId}" class="btn-action btn-primary">Xem mã QR</a>
                        </c:when>
                    </c:choose>

                <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'STAFF'}">
                    <c:choose>
                        <c:when test="${order.status == 'PENDING'}">
                            <form method="POST" style="display:inline; margin-left:6px;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${order.orderId}">
                                <input type="hidden" name="status" value="RECEIVED">
                                <button type="submit" class="btn-action btn-primary">Nhận đơn</button>
                            </form>
                        </c:when>
                        <c:when test="${order.status == 'RECEIVED'}">
                            <form method="POST" style="display:inline; margin-left:6px;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${order.orderId}">
                                <input type="hidden" name="status" value="PROCESSING">
                                <button type="submit" class="btn-action btn-primary">Bắt đầu làm</button>
                            </form>
                        </c:when>
                        <c:when test="${order.status == 'PROCESSING'}">
                            <form method="POST" style="display:inline; margin-left:6px;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${order.orderId}">
                                <input type="hidden" name="status" value="DELIVERING">
                                <button type="submit" class="btn-action btn-primary">Giao hàng</button>
                            </form>
                        </c:when>
                        <c:when test="${order.status == 'DELIVERING'}">
                            <form method="POST" style="display:inline; margin-left:6px;">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${order.orderId}">
                                <input type="hidden" name="status" value="ARRIVED">
                                <button type="submit" class="btn-action btn-primary">Đã đến nơi</button>
                            </form>
                        </c:when>
                    </c:choose>
                    <c:if test="${order.status != 'CANCELLED' && order.status != 'ARRIVED'}">
                        <form method="POST" style="display:inline; margin-left:6px;">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="id" value="${order.orderId}">
                            <button type="submit" class="btn-action btn-danger" onclick="return confirm('Hủy đơn hàng?')">Hủy Đơn</button>
                        </form>
                    </c:if>
                </c:if>

                <c:if test="${order.status == 'PENDING' && sessionScope.role == 'CUSTOMER'}">
                    <form method="POST" style="display:inline; margin-left:6px;">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="id" value="${order.orderId}">
                        <button type="submit" class="btn-action btn-danger" onclick="return confirm('Hủy đơn hàng?')">Hủy Đơn</button>
                    </form>
                </c:if>

                <a href="${pageContext.request.contextPath}/order" class="btn-action btn-primary">Quay Lại</a>
            </div>
        </c:if>
    </div>
</body>
</html>
