<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhân Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            margin-bottom: 30px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
        }
        .header h1 {
            margin: 0;
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
        .status-active {
            background-color: #d1e7dd;
            color: #0f5132;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #842029;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            margin-right: 5px;
            text-decoration: none;
        }
        .btn-view {
            background-color: #17a2b8;
            color: white;
        }
        .btn-block {
            background-color: #ffc107;
            color: #333;
        }
        .btn-unblock {
            background-color: #28a745;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-action:hover {
            opacity: 0.8;
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
    <div class="container">
        <div class="header" style="display: flex; justify-content: space-between; align-items: center; gap: 20px; flex-wrap: wrap;">
            <h1>👔 Quản Lý Nhân Viên</h1>
            <a href="${pageContext.request.contextPath}/admin?action=add_staff" class="btn-action btn-view" style="padding: 10px 20px;">+ Thêm nhân viên mới</a>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-error">${param.error}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty requestScope.staffList && fn:length(requestScope.staffList) > 0}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Mã NV</th>
                            <th>Vị trí</th>
                            <th>Bộ phận</th>
                            <th>Lương</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.staffList}" var="staff">
                            <tr>
                                <td>#${staff.userId}</td>
                                <td>${staff.fullName}</td>
                                <td>${staff.staffCode}</td>
                                <td>${staff.position}</td>
                                <td>${staff.department}</td>
                                <td><fmt:formatNumber value="${staff.salary}" type="currency" currencySymbol="₫"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${staff.status == 'ACTIVE'}">
                                            <span class="status-active">✓ Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-inactive">✗ Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin?action=view_staff&id=${staff.userId}" class="btn-action btn-view">Xem</a>
                                    <a href="${pageContext.request.contextPath}/admin?action=edit_staff&id=${staff.userId}" class="btn-action btn-view" style="background-color: #0d6efd;">Sửa</a>
                                    <c:choose>
                                        <c:when test="${staff.status == 'ACTIVE'}">
                                            <a href="${pageContext.request.contextPath}/admin?action=block&userType=staff&id=${staff.userId}" class="btn-action btn-block">Khóa</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin?action=unblock&userType=staff&id=${staff.userId}" class="btn-action btn-unblock">Mở Khóa</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <form method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="delete_staff">
                                        <input type="hidden" name="id" value="${staff.userId}">
                                        <button type="submit" class="btn-action btn-delete" onclick="return confirm('Xóa nhân viên này?')">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <p>Không có nhân viên nào</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/admin" class="btn-action btn-view">← Quay Lại Dashboard</a>
        </div>
    </div>
</body>
</html>
