<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Nhân Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 900px;
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
        .card {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 30px;
            margin-bottom: 20px;
        }
        .card h1 {
            margin: 0 0 30px 0;
            color: #333;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
        }
        .info-grid {
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
        .status-badge {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 4px;
            font-weight: 600;
        }
        .status-active {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #842029;
        }
        .btn-action {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
            text-decoration: none;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #333;
        }
        .btn-action:hover {
            opacity: 0.8;
        }
        .actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin?action=staff" class="back-link">← Quay Lại Danh Sách</a>

        <c:if test="${not empty requestScope.staff}">
            <c:set var="staff" value="${requestScope.staff}"/>
            <div class="card">
                <h1>👔 Thông Tin Nhân Viên</h1>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Mã NV</div>
                        <div class="info-value">#${staff.userId}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Tên Đầy Đủ</div>
                        <div class="info-value">${staff.fullName}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Mã Nhân Viên</div>
                        <div class="info-value">${staff.staffCode}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Vị trí</div>
                        <div class="info-value">${staff.position}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Bộ phận</div>
                        <div class="info-value">${staff.department}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">${staff.email}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Số Điện Thoại</div>
                        <div class="info-value">${staff.phone}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Lương</div>
                        <div class="info-value" style="font-size: 1.3em; color: #28a745; font-weight: bold;">
                            <fmt:formatNumber value="${staff.salary}" type="currency" currencySymbol="₫"/>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Trạng Thái</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${staff.status == 'ACTIVE'}">
                                    <span class="status-badge status-active">✓ Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-inactive">✗ Bị khóa</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Ngày Tạo</div>
                        <div class="info-value">
                            <fmt:formatDate value="${staff.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                </div>

                <div class="actions">
                    <h3>Thao Tác</h3>
                    <c:choose>
                        <c:when test="${staff.status == 'ACTIVE'}">
                            <a href="${pageContext.request.contextPath}/admin?action=block&userType=staff&id=${staff.userId}" class="btn-action btn-warning">⛔ Khóa Tài Khoản</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/admin?action=unblock&userType=staff&id=${staff.userId}" class="btn-action btn-primary">✓ Mở Khóa</a>
                        </c:otherwise>
                    </c:choose>
                    <form method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="delete_staff">
                        <input type="hidden" name="id" value="${staff.userId}">
                        <button type="submit" class="btn-action btn-danger" onclick="return confirm('Xóa nhân viên này vĩnh viễn?')">🗑️ Xóa Tài Khoản</button>
                    </form>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
