<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-brand">FPoly Canteen 🍔</a>
    <div class="nav-menu">
        <c:choose>
            <c:when test="${sessionScope.role == 'CUSTOMER'}">
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">Menu</a>
                <a href="${pageContext.request.contextPath}/order" class="nav-link">Đơn Hàng</a>
                <a href="${pageContext.request.contextPath}/payment" class="nav-link">Thanh Toán</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link">Đăng xuất</a>
            </c:when>
            <c:when test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'STAFF'}">
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin" class="nav-link">Admin</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/staff" class="nav-link">Nhân viên</a>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">Quản lý thực đơn</a>
                <a href="${pageContext.request.contextPath}/order" class="nav-link">Quản lý đơn</a>
                <a href="${pageContext.request.contextPath}/revenue" class="nav-link">Doanh Thu</a>
                <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/menu" class="nav-link">Menu</a>
                <a href="${pageContext.request.contextPath}/login" class="nav-link">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
    </div>
    <div style="display:flex; align-items:center; gap:12px; margin-left:18px;">
        <c:if test="${not empty sessionScope.fullName}">
            <span style="font-weight:700; color:#0f172a;">${sessionScope.fullName}</span>
        </c:if>
        <c:if test="${not empty sessionScope.role}">
            <span style="background:#eef2ff; color:#075985; padding:6px 10px; border-radius:999px; font-size:0.85rem;">${sessionScope.role}</span>
        </c:if>
    </div>
</nav>
