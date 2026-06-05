<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="back_button.jsp" />
    <jsp:include page="nav.jsp" />

    <div class="page-container">
        <div class="page-header">
            <h2>${pageTitle}</h2>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success" style="margin-bottom:20px; padding:15px; border-radius:12px; background:#e6ffed; color:#1f6f3d;">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error" style="margin-bottom:20px; padding:15px; border-radius:12px; background:#ffe6e6; color:#a03030;">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/menu" method="post" style="max-width: 700px; margin: 0 auto; background: white; padding: 30px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.08);">
            <input type="hidden" name="action" value="${formAction}" />
            <c:if test="${formAction == 'update'}">
                <input type="hidden" name="id" value="${menuItem.itemId}" />
            </c:if>

            <div class="form-group">
                <label class="form-label" for="itemName">Tên món ăn</label>
                <input class="form-control" type="text" id="itemName" name="itemName" required
                       value="${menuItem.itemName}" />
            </div>
            <div class="form-group">
                <label class="form-label" for="category">Danh mục</label>
                <input class="form-control" type="text" id="category" name="category" required
                       value="${menuItem.category}" placeholder="Ví dụ: Món ăn, Món ăn nước, Đồ uống, Combo" />
            </div>
            <div class="form-group">
                <label class="form-label" for="price">Giá tiền</label>
                <input class="form-control" type="number" id="price" name="price" required min="0"
                       step="1000" value="${menuItem.price}" />
            </div>
            <div class="form-group">
                <label class="form-label" for="imageUrl">URL hình ảnh</label>
                <input class="form-control" type="text" id="imageUrl" name="imageUrl"
                       value="${menuItem.imageUrl}" placeholder="https://example.com/image.jpg" />
            </div>
            <div class="form-group">
                <label class="form-label" for="description">Mô tả</label>
                <textarea class="form-control" id="description" name="description" rows="4"
                          placeholder="Mô tả ngắn gọn về món ăn">${menuItem.description}</textarea>
            </div>
            <div style="display: flex; justify-content: flex-start; gap: 15px; flex-wrap: wrap;">
                <button type="submit" class="btn btn-primary" style="width: auto;">
                    <c:choose>
                        <c:when test="${formAction == 'update'}">Cập nhật</c:when>
                        <c:otherwise>Thêm món</c:otherwise>
                    </c:choose>
                </button>
                <a href="${pageContext.request.contextPath}/menu" class="btn btn-secondary" style="width: auto;">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>
