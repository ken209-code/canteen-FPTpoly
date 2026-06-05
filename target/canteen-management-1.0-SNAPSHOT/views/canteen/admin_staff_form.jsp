<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle}"/></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            margin-bottom: 30px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .header h1 {
            margin: 0;
        }
        form {
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.06);
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }
        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .btn-action {
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            color: #fff;
        }
        .btn-save {
            background-color: #28a745;
        }
        .btn-cancel {
            background-color: #6c757d;
        }
        .alert {
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 5px;
        }
        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body><jsp:include page="back_button.jsp" /><div class="container">
    <div class="header">
        <h1><c:out value="${pageTitle}"/></h1>
        <a href="${pageContext.request.contextPath}/admin?action=staff" class="btn-action btn-cancel">Quay lại danh sách</a>
    </div>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-error">${requestScope.error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin?action=${formAction}" method="post">
        <c:if test="${not empty staff.userId}">
            <input type="hidden" name="id" value="${staff.userId}">
        </c:if>
        <div class="form-group">
            <label for="username">Tên đăng nhập</label>
            <input type="text" id="username" name="username" value="${staff.username}" required>
        </div>
        <div class="form-group">
            <label for="password">Mật khẩu</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="fullName">Họ tên</label>
            <input type="text" id="fullName" name="fullName" value="${staff.fullName}" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="${staff.email}" required>
        </div>
        <div class="form-group">
            <label for="staffCode">Mã nhân viên</label>
            <input type="text" id="staffCode" name="staffCode" value="${staff.staffCode}">
        </div>
        <div class="form-group">
            <label for="position">Vị trí</label>
            <select id="position" name="position">
                <option value="">Chọn vị trí (tùy chọn)</option>
                <option value="Nhân viên bán hàng" ${staff.position == 'Nhân viên bán hàng' ? 'selected' : ''}>Nhân viên bán hàng</option>
                <option value="Thu ngân" ${staff.position == 'Thu ngân' ? 'selected' : ''}>Thu ngân</option>
                <option value="Quản lý" ${staff.position == 'Quản lý' ? 'selected' : ''}>Quản lý</option>
                <option value="Nhân viên bếp" ${staff.position == 'Nhân viên bếp' ? 'selected' : ''}>Nhân viên bếp</option>
                <option value="Giao hàng" ${staff.position == 'Giao hàng' ? 'selected' : ''}>Giao hàng</option>
            </select>
        </div>
        <div class="form-group">
            <label for="department">Bộ phận</label>
            <select id="department" name="department">
                <option value="">Chọn bộ phận (tùy chọn)</option>
                <option value="Kinh doanh" ${staff.department == 'Kinh doanh' ? 'selected' : ''}>Kinh doanh</option>
                <option value="Tài chính" ${staff.department == 'Tài chính' ? 'selected' : ''}>Tài chính</option>
                <option value="Vận hành" ${staff.department == 'Vận hành' ? 'selected' : ''}>Vận hành</option>
                <option value="Bếp" ${staff.department == 'Bếp' ? 'selected' : ''}>Bếp</option>
                <option value="Kho" ${staff.department == 'Kho' ? 'selected' : ''}>Kho</option>
            </select>
        </div>
        <div class="form-group">
            <label for="salary">Lương</label>
            <input type="number" id="salary" name="salary" step="0.01" value="${staff.salary}">
        </div>
        <div class="actions">
            <button type="submit" class="btn-action btn-save">Lưu nhân viên</button>
            <a href="${pageContext.request.contextPath}/admin?action=staff" class="btn-action btn-cancel">Hủy</a>
        </div>
    </form>
</div>
</body>
</html>
