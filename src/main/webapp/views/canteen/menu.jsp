<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javaweb.model.MenuItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực đơn - Canteen System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #ff6b6b;
            --secondary: #4ecdc4;
            --surface: #ffffff;
            --surface-soft: #f6f8ff;
            --text: #1f2937;
            --shadow: 0 20px 50px rgba(34, 60, 80, 0.08);
        }
        body {
            background: #eef4ff;
            color: var(--text);
        }
        .search-section {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            padding: 30px 0 22px;
            margin-bottom: 0;
            color: white;
        }
        .search-section h4 {
            font-size: 1.35rem;
            letter-spacing: 0.02em;
            margin-bottom: 18px;
        }
        .search-form {
            display: flex;
            gap: 14px;
            flex-wrap: wrap;
            align-items: center;
        }
        .search-form input,
        .search-form select {
            border-radius: 14px;
            border: none;
            padding: 14px 18px;
            font-size: 0.95rem;
            min-height: 48px;
            background: rgba(255,255,255,0.95);
            box-shadow: 0 18px 40px rgba(0,0,0,0.08);
        }
        .search-form select {
            min-width: 220px;
        }
        .btn-search {
            background: white;
            color: var(--primary);
            border: none;
            font-weight: 700;
            border-radius: 14px;
            padding: 14px 30px;
            cursor: pointer;
            box-shadow: 0 18px 40px rgba(255,255,255,0.5);
            transition: transform 0.2s ease, filter 0.2s ease;
        }
        .btn-search:hover {
            transform: translateY(-1px);
            filter: brightness(1.02);
        }
        .category-panel {
            background: rgba(255,255,255,0.95);
            border-radius: 18px;
            padding: 18px 20px;
            box-shadow: 0 18px 40px rgba(34, 60, 80, 0.08);
        }
        .category-pill {
            color: #2d2d2d;
            border-color: rgba(255,255,255,0.8);
            background: rgba(255,255,255,0.95);
            transition: all 0.25s ease;
            font-weight: 600;
        }
        .category-pill:hover,
        .category-pill.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        .section-title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 18px;
        }
        .product-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.35s ease, box-shadow 0.35s ease;
            height: 100%;
            background: var(--surface);
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 25px 60px rgba(34,60,80,0.12);
        }
        .product-image-wrapper {
            position: relative;
            height: 220px;
            overflow: hidden;
            background: #f0f0f0;
        }
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }
        .product-card:hover .product-image { transform: scale(1.06); }
        .rating-badge {
            position: absolute;
            top: 14px;
            right: 14px;
            background: var(--primary);
            color: white;
            padding: 8px 14px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 700;
        }
        .card-body {
            padding: 22px;
        }
        .card-title {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .card-text {
            color: #58616c;
            font-size: 0.95rem;
            line-height: 1.6;
            min-height: 46px;
        }
        .btn-sm {
            border-radius: 14px;
            padding: 8px 14px;
        }
        @media (min-width: 992px) {
            .search-section { padding: 50px 0 42px; }
            .search-form { gap: 18px; }
            .search-form input,
            .search-form select { min-height: 54px; padding: 16px 20px; }
        }
        @media (max-width: 991px) {
            .search-form { flex-direction: column; align-items: stretch; }
            .search-form input,
            .search-form select,
            .btn-search { width: 100%; }
            .search-section { padding: 26px 0 18px; }
        }
        @media (max-width: 767px) {
            .container-lg { padding-left: 16px; padding-right: 16px; }
            .category-panel { padding: 16px; }
            .product-image-wrapper { height: 180px; }
            .section-title { font-size: 1.35rem; }
            .search-section h4 { font-size: 1.2rem; }
            .nav-link { padding: 8px 10px; }
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <jsp:include page="nav.jsp" />

    <!-- Search Section -->
    <div class="search-section">
        <div class="container-lg">
            <h4 class="mb-3" style="color: white;"><i class="bi bi-search"></i> Tìm kiếm & Lọc Thực Đơn</h4>
            <form method="GET" action="${pageContext.request.contextPath}/menu" class="search-form">
                <input type="hidden" name="action" value="search">
                <input type="text" name="search" placeholder="🔍 Tìm kiếm món ăn..." 
                       class="form-control" style="flex: 1; min-width: 200px;"
                       value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                
                <select name="category" class="form-select" style="min-width: 190px;">
                    <option value="">📌 Tất cả danh mục</option>
                    <option value="Món ăn">Món ăn</option>
                    <option value="Món ăn nước">Món ăn nước</option>
                    <option value="Đồ uống">Đồ uống</option>
                    <option value="Combo">Combo</option>
                </select>
                
                <button type="submit" class="btn btn-search">Tìm kiếm</button>
            </form>
        </div>
    </div>

    <div class="container-lg" style="margin-top: 16px;">
        <div class="category-panel" style="display:flex; flex-wrap:wrap; gap:12px; justify-content:center; margin-bottom:30px;">
            <a href="#food" class="category-pill btn btn-outline-light">Món ăn</a>
            <a href="#soups" class="category-pill btn btn-outline-light">Món ăn nước</a>
            <a href="#drinks" class="category-pill btn btn-outline-light">Đồ uống</a>
            <a href="#combo" class="category-pill btn btn-outline-light">Combo</a>
        </div>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div style="display:flex; justify-content:space-between; align-items:center; margin:18px 0;">
            <h3 class="section-title">Món ăn</h3>
            <div>
                <c:if test="${canAdd}">
                    <a href="${pageContext.request.contextPath}/menu?action=add" class="btn btn-light btn-sm">➕ Thêm món</a>
                </c:if>
            </div>
        </div>
        <div class="menu-section" id="food" style="margin-bottom: 50px;">
            <h3 class="section-title">Món ăn</h3>
            <div class="row g-4">
                <c:forEach items="${menuItems}" var="item">
                    <c:if test="${item.category == 'Món ăn'}">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <c:if test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.itemName}" class="product-image">
                                    </c:if>
                                    <c:if test="${empty item.imageUrl}">
                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-light text-dark">${item.category}</span>
                                    <h5 class="card-title mt-2">${item.itemName}</h5>
                                    <p class="card-text text-muted" style="font-size: 0.9rem; min-height: 40px;">
                                        ${item.description != null ? item.description : 'Không có mô tả'}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5" style="color: #ff6b6b; margin: 0;"><strong><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</strong></span>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <a href="${pageContext.request.contextPath}/menu?action=view&id=${item.itemId}" class="btn btn-sm" style="background: #4ecdc4; color: white;">
                                                <i class="bi bi-eye"></i> Xem
                                            </a>
                                            <c:if test="${canEdit}">
                                                <a href="${pageContext.request.contextPath}/menu?action=edit&id=${item.itemId}" class="btn btn-sm btn-outline-secondary">Sửa</a>
                                            </c:if>
                                            <c:if test="${canDelete}">
                                                <form method="post" action="${pageContext.request.contextPath}/menu" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${item.itemId}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Xóa món này?')">Xóa</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="menu-section" id="soups" style="margin-bottom: 50px;">
            <h3 class="section-title">Món ăn nước</h3>
            <div class="row g-4">
                <c:forEach items="${menuItems}" var="item">
                    <c:if test="${item.category == 'Món ăn nước'}">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <c:if test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.itemName}" class="product-image">
                                    </c:if>
                                    <c:if test="${empty item.imageUrl}">
                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-light text-dark">${item.category}</span>
                                    <h5 class="card-title mt-2">${item.itemName}</h5>
                                    <p class="card-text text-muted" style="font-size: 0.9rem; min-height: 40px;">
                                        ${item.description != null ? item.description : 'Không có mô tả'}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5" style="color: #ff6b6b; margin: 0;"><strong><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</strong></span>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <a href="${pageContext.request.contextPath}/menu?action=view&id=${item.itemId}" class="btn btn-sm" style="background: #4ecdc4; color: white;">
                                                <i class="bi bi-eye"></i> Xem
                                            </a>
                                            <c:if test="${canEdit}">
                                                <a href="${pageContext.request.contextPath}/menu?action=edit&id=${item.itemId}" class="btn btn-sm btn-outline-secondary">Sửa</a>
                                            </c:if>
                                            <c:if test="${canDelete}">
                                                <form method="post" action="${pageContext.request.contextPath}/menu" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${item.itemId}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Xóa món này?')">Xóa</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="menu-section" id="drinks" style="margin-bottom: 50px;">
            <h3 class="section-title">Đồ uống</h3>
            <div class="row g-4">
                <c:forEach items="${menuItems}" var="item">
                    <c:if test="${item.category == 'Đồ uống'}">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <c:if test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.itemName}" class="product-image">
                                    </c:if>
                                    <c:if test="${empty item.imageUrl}">
                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-light text-dark">${item.category}</span>
                                    <h5 class="card-title mt-2">${item.itemName}</h5>
                                    <p class="card-text text-muted" style="font-size: 0.9rem; min-height: 40px;">
                                        ${item.description != null ? item.description : 'Không có mô tả'}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5" style="color: #ff6b6b; margin: 0;"><strong><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</strong></span>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <a href="${pageContext.request.contextPath}/menu?action=view&id=${item.itemId}" class="btn btn-sm" style="background: #4ecdc4; color: white;">
                                                <i class="bi bi-eye"></i> Xem
                                            </a>
                                            <c:if test="${canEdit}">
                                                <a href="${pageContext.request.contextPath}/menu?action=edit&id=${item.itemId}" class="btn btn-sm btn-outline-secondary">Sửa</a>
                                            </c:if>
                                            <c:if test="${canDelete}">
                                                <form method="post" action="${pageContext.request.contextPath}/menu" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${item.itemId}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Xóa món này?')">Xóa</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="menu-section" id="combo" style="margin-bottom: 50px;">
            <h3 class="section-title">Combo</h3>
            <div class="row g-4">
                <c:forEach items="${menuItems}" var="item">
                    <c:if test="${item.category == 'Combo'}">
                        <div class="col-12 col-sm-6 col-lg-4">
                            <div class="product-card">
                                <div class="product-image-wrapper">
                                    <c:if test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.itemName}" class="product-image">
                                    </c:if>
                                    <c:if test="${empty item.imageUrl}">
                                        <div style="width: 100%; height: 100%; background: #f0f0f0; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-light text-dark">${item.category}</span>
                                    <h5 class="card-title mt-2">${item.itemName}</h5>
                                    <p class="card-text text-muted" style="font-size: 0.9rem; min-height: 40px;">
                                        ${item.description != null ? item.description : 'Không có mô tả'}
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <span class="h5" style="color: #ff6b6b; margin: 0;"><strong><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ</strong></span>
                                        <div style="display:flex; gap:8px; align-items:center;">
                                            <a href="${pageContext.request.contextPath}/menu?action=view&id=${item.itemId}" class="btn btn-sm" style="background: #4ecdc4; color: white;">
                                                <i class="bi bi-eye"></i> Xem
                                            </a>
                                            <c:if test="${canEdit}">
                                                <a href="${pageContext.request.contextPath}/menu?action=edit&id=${item.itemId}" class="btn btn-sm btn-outline-secondary">Sửa</a>
                                            </c:if>
                                            <c:if test="${canDelete}">
                                                <form method="post" action="${pageContext.request.contextPath}/menu" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="id" value="${item.itemId}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Xóa món này?')">Xóa</button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <c:if test="${empty menuItems}">
            <div class="col-12">
                <div style="text-align: center; padding: 60px 20px; background: white; border-radius: 12px;">
                    <i class="bi bi-inbox" style="font-size: 4rem; color: #ccc;"></i>
                    <h4 class="mt-3 text-muted">Không tìm thấy sản phẩm</h4>
                    <p class="text-muted">Hãy thử tìm kiếm với từ khóa khác</p>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
