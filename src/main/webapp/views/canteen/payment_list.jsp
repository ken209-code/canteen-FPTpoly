<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Thanh Toán</title>
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
        .status-completed {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .status-failed {
            background-color: #f8d7da;
            color: #842029;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
        }
        .method-cash {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        .method-card {
            background-color: #ede7f6;
            color: #512da8;
        }
        .method-transfer {
            background-color: #e3f2fd;
            color: #1565c0;
        }
        .method-wallet {
            background-color: #fff3e0;
            color: #e65100;
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
        .btn-confirm {
            background-color: #28a745;
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
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <div class="container">
        <div class="header">
            <h1>Danh Sách Thanh Toán</h1>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty requestScope.payments && fn:length(requestScope.payments) > 0}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Đơn Hàng</th>
                            <th>Số Tiền</th>
                            <th>Phương Thức</th>
                            <th>Trạng Thái</th>
                            <th>Mã Giao Dịch</th>
                            <th>Thời Gian</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.payments}" var="payment">
                            <tr>
                                <td>#${payment.paymentId}</td>
                                <td>#${payment.orderId}</td>
                                <td><fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="₫"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${payment.paymentMethod == 'CASH'}">
                                            <span class="method-cash">💵 Tiền Mặt</span>
                                        </c:when>
                                        <c:when test="${payment.paymentMethod == 'CARD'}">
                                            <span class="method-card">💳 Thẻ</span>
                                        </c:when>
                                        <c:when test="${payment.paymentMethod == 'TRANSFER'}">
                                            <span class="method-transfer">🏦 Chuyển Khoản</span>
                                        </c:when>
                                        <c:when test="${payment.paymentMethod == 'WALLET'}">
                                            <span class="method-wallet">💰 Ví Điện Tử</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${payment.status == 'PENDING'}">
                                            <span class="status-pending">⏳ Chờ Xác Nhận</span>
                                        </c:when>
                                        <c:when test="${payment.status == 'COMPLETED'}">
                                            <span class="status-completed">✓ Hoàn Thành</span>
                                        </c:when>
                                        <c:when test="${payment.status == 'FAILED'}">
                                            <span class="status-failed">✗ Thất Bại</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${payment.transactionCode}</td>
                                <td>
                                    <c:if test="${not empty payment.paymentDate}">
                                        <fmt:formatDate value="${payment.paymentDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${payment.status == 'PENDING' && (sessionScope.role == 'STAFF' || sessionScope.role == 'ADMIN')}">
                                        <form method="POST" style="display:inline;">
                                            <input type="hidden" name="action" value="confirm">
                                            <input type="hidden" name="id" value="${payment.paymentId}">
                                            <button type="submit" class="btn-action btn-confirm">Xác Nhận</button>
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
                    <p>Không có giao dịch thanh toán nào</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
