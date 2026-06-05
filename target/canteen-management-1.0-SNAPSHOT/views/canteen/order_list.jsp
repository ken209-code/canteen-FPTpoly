<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${requestScope.pageTitle != null ? requestScope.pageTitle : 'Danh Sách Đơn Hàng'}"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
        }
        table tr:hover {
            background-color: #f5f5f5;
        }
        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-processing {
            background-color: #cfe2ff;
            color: #084298;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-received {
            background-color: #e6f7ff;
            color: #055160;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-completed {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-delivering {
            background-color: #cfe2ff;
            color: #084298;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-arrived {
            background-color: #d1fae5;
            color: #0f5132;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-delivered {
            background-color: #d1fae5;
            color: #0f5132;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-cancelled {
            background-color: #f8d7da;
            color: #842029;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            margin-right: 5px;
        }
        .btn-view {
            background-color: #17a2b8;
            color: white;
        }
        .btn-cancel {
            background-color: #dc3545;
            color: white;
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
    <div class="container">
        <div class="header">
            <h1><c:out value="${requestScope.pageTitle != null ? requestScope.pageTitle : 'Đơn Hàng'}"/></h1>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty requestScope.orders && fn:length(requestScope.orders) > 0}">
                <table>
                    <thead>
                        <tr>
                            <th>Mã Đơn</th>
                            <th>Ngày Đặt</th>
                            <th>Tổng Tiền</th>
                            <th>Người nhận</th>
                            <th>Thanh toán</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.orders}" var="order">
                        <tr>
                            <td>#${order.orderId}</td>
                            <td>
                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                            </td>
                            <td>${order.recipientName}<br/><small>${order.recipientPhone}</small></td>
                            <td>${order.paymentMethod}<br/>
                                <c:choose>
                                    <c:when test="${order.paymentStatus == 'PAID'}"> <span style="color:green; font-weight:600;">PAID</span> </c:when>
                                    <c:otherwise> <span style="color:orange; font-weight:600;">PENDING</span> </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="status-pending">⏳ Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status == 'RECEIVED'}">
                                            <span class="status-received">📥 Đã nhận đơn</span>
                                        </c:when>
                                        <c:when test="${order.status == 'PROCESSING'}">
                                            <span class="status-processing">⚙️ Đang làm</span>
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERING'}">
                                            <span class="status-delivering">🚚 Đang giao hàng</span>
                                        </c:when>
                                        <c:when test="${order.status == 'ARRIVED'}">
                                            <span class="status-arrived">✅ Đã đến nơi</span>
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="status-delivered">✅ Đã giao</span>
                                        </c:when>
                                        <c:when test="${order.status == 'COMPLETED'}">
                                            <span class="status-completed">✓ Hoàn thành</span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <span class="status-cancelled">✗ Đã hủy</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/order?action=view&id=${order.orderId}" class="btn-action btn-view">Xem Chi Tiết</a>
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
                                                <button type="submit" class="btn-action btn-cancel" onclick="return confirm('Hủy đơn hàng này?')">Hủy</button>
                                            </form>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${order.paymentMethod == 'COD'}">
                                        <a href="${pageContext.request.contextPath}/order?action=viewBill&id=${order.orderId}" class="btn-action">In Hóa Đơn</a>
                                    </c:if>
                                    <c:if test="${order.paymentMethod == 'ONLINE'}">
                                        <a href="${pageContext.request.contextPath}/order?action=pay&id=${order.orderId}" class="btn-action">Xem QR</a>
                                    </c:if>
                                    <c:if test="${order.status == 'PENDING' && sessionScope.role == 'CUSTOMER'}">
                                        <form method="POST" style="display:inline; margin-left:6px;">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="id" value="${order.orderId}">
                                            <button type="submit" class="btn-action btn-cancel" onclick="return confirm('Hủy đơn hàng này?')">Hủy</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <p>Không có đơn hàng nào</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
