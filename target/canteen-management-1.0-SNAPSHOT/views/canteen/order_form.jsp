<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />

<div class="container" style="max-width:800px; margin:30px auto 60px auto; display:flex; justify-content:center;">
    <div style="width:100%;">
        <h2>Đặt hàng</h2>

    <c:if test="${not empty requestScope.error}">
        <div class="alert alert-error">${requestScope.error}</div>
    </c:if>
    <c:if test="${not empty requestScope.success}">
        <div class="alert alert-success">${requestScope.success}</div>
    </c:if>

    <c:choose>
        <c:when test="${sessionScope.role == 'CUSTOMER'}">
            <form action="${pageContext.request.contextPath}/order?action=create" method="post">
        <c:if test="${not empty selectedItem}">
            <div class="form-group" style="padding: 16px; border: 1px solid #ddd; border-radius: 12px; background: #f9f9f9; margin-bottom: 24px;">
                <h3 style="margin-top: 0;">Món đã chọn</h3>
                <p style="margin: 0.35rem 0;"><strong>${selectedItem.itemName}</strong></p>
                <p style="margin: 0.35rem 0; color: #555;">Giá: <strong>${selectedItem.price}đ</strong></p>
                <c:if test="${not empty selectedItem.description}">
                    <p style="margin: 0.35rem 0; color: #555;">${selectedItem.description}</p>
                </c:if>
            </div>
        </c:if>
        <div class="form-group">
            <label for="itemId">Chọn món</label>
            <select id="itemId" name="itemId" class="form-control">
                <option value="">-- Chọn món --</option>
                <c:forEach items="${menuItems}" var="m">
                    <option value="${m.itemId}" <c:if test="${selectedItem != null && selectedItem.itemId == m.itemId}">selected</c:if>>${m.itemName} - ${m.price}đ</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="quantity">Số lượng</label>
            <input type="number" id="quantity" name="quantity" value="${not empty selectedQuantity ? selectedQuantity : 1}" min="1" class="form-control" />
        </div>
        <div class="form-group">
            <label for="notes">Ghi chú</label>
            <textarea id="notes" name="notes" class="form-control" rows="3"></textarea>
        </div>
        <hr />
        <h3>Thông tin người nhận</h3>
        <div class="form-group">
            <label for="recipientName">Họ và tên</label>
            <input type="text" id="recipientName" name="recipientName" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="recipientPhone">Số điện thoại</label>
            <input type="text" id="recipientPhone" name="recipientPhone" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="recipientAddress">Địa chỉ</label>
            <input type="text" id="recipientAddress" name="recipientAddress" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="paymentMethod">Phương thức thanh toán</label>
            <select id="paymentMethod" name="paymentMethod" class="form-control">
                <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                <option value="ONLINE">Thanh toán online (QR)</option>
            </select>
        </div>
        <div class="form-group" style="display:flex; gap:12px; justify-content:center; align-items:center; margin-top:30px;">
            <button type="submit" class="btn btn-primary">Đặt hàng</button>
            <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary">Hủy</a>
        </div>
            </form>
        </c:when>
        <c:otherwise>
            <div class="alert alert-error">Chức năng đặt hàng chỉ dành cho tài khoản khách hàng.</div>
        </c:otherwise>
    </c:choose>
    </div>
</div>
</body>
</html>