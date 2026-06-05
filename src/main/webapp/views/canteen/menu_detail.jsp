<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết món ăn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="back_button.jsp" />
    <jsp:include page="nav.jsp" />

    <div class="page-container">
        <div class="card" style="padding: 30px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.08);">
            <h2 style="margin-bottom: 20px;">${menuItem.itemName}</h2>
            <div style="display: flex; gap: 30px; flex-wrap: wrap; align-items: flex-start;">
                <div style="flex: 1 1 350px; min-width: 280px;">
                    <img src="${not empty menuItem.imageUrl ? menuItem.imageUrl : 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?q=80&w=1500&auto=format&fit=crop'}" alt="${menuItem.itemName}" style="width: 100%; border-radius: 20px; object-fit: cover; max-height: 420px;" />
                </div>
                <div style="flex: 1 1 320px; min-width: 280px;">
                    <div style="margin-bottom: 15px;"><strong>Danh mục:</strong> ${menuItem.category}</div>
                    <div style="margin-bottom: 15px;"><strong>Giá:</strong> ${menuItem.price} đ</div>
                    <div style="margin-bottom: 15px;"><strong>Mô tả:</strong></div>
                    <div style="color: #505050; margin-bottom: 25px;">${menuItem.description}</div>
                    <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary">Quay lại</a>
                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'STAFF'}">
                            <a href="${pageContext.request.contextPath}/menu?action=edit&id=${menuItem.itemId}" class="btn btn-primary">Sửa món</a>
                        </c:if>
                        <c:choose>
                            <c:when test="${sessionScope.role == 'CUSTOMER'}">
                                <form action="${pageContext.request.contextPath}/checkout" method="get" style="display:inline-flex; align-items:center; gap:8px;">
                                    <input type="hidden" name="itemId" value="${menuItem.itemId}" />
                                    <label for="qty" style="margin:0; font-weight:600;">Số lượng</label>
                                    <input id="qty" name="quantity" type="number" value="1" min="1" style="width:80px; padding:6px; border-radius:6px; border:1px solid #ccc;" />
                                    <button class="btn btn-primary" type="submit">Đặt ngay</button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Chức năng đặt hàng chỉ dành cho khách hàng.</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
