<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xử lý đơn - Nhân viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="back_button.jsp" />
    <nav class="navbar" style="background:#0f172a; padding:16px 24px; display:flex; justify-content:space-between; align-items:center; color:white;">
        <a href="${pageContext.request.contextPath}/staff" class="nav-brand" style="color:white; text-decoration:none; font-size:1.1rem; font-weight:700;">Nhân viên Canteen 👨‍🍳</a>
        <div class="nav-menu" style="display:flex; gap:16px; align-items:center;">
            <a href="${pageContext.request.contextPath}/staff" class="nav-link" style="color:#93c5fd; text-decoration:none;">Dashboard</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link" style="color:#f8fafc; text-decoration:none;">Đăng xuất</a>
        </div>
    </nav>

    <div class="page-container" style="max-width:1120px; margin:30px auto; padding:0 24px;">
        <div class="page-header" style="margin-bottom:24px;">
            <h1 style="margin:0; font-size:2rem;">Xin chào, Nhân viên!</h1>
            <p style="margin:8px 0 0; color:#475569;">Chọn nhiệm vụ bạn muốn thực hiện ngay bên dưới.</p>
        </div>

        <div class="stats-grid" style="display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px; margin-bottom:36px;">
            <div class="stat-card" style="background:white; padding:24px; border-radius:20px; box-shadow:0 18px 50px rgba(15,23,42,0.06);">
                <div style="font-size:0.95rem; color:#64748b; margin-bottom:8px;">Tổng đơn</div>
                <div style="font-size:2rem; font-weight:700;">${totalOrders}</div>
            </div>
            <div class="stat-card" style="background:white; padding:24px; border-radius:20px; box-shadow:0 18px 50px rgba(15,23,42,0.06);">
                <div style="font-size:0.95rem; color:#64748b; margin-bottom:8px;">Đang chờ</div>
                <div style="font-size:2rem; font-weight:700;">${pendingOrders}</div>
            </div>
            <div class="stat-card" style="background:white; padding:24px; border-radius:20px; box-shadow:0 18px 50px rgba(15,23,42,0.06);">
                <div style="font-size:0.95rem; color:#64748b; margin-bottom:8px;">Đang xử lý</div>
                <div style="font-size:2rem; font-weight:700;">${processingOrders}</div>
            </div>
            <div class="stat-card" style="background:white; padding:24px; border-radius:20px; box-shadow:0 18px 50px rgba(15,23,42,0.06);">
                <div style="font-size:0.95rem; color:#64748b; margin-bottom:8px;">Tổng doanh thu</div>
                <div style="font-size:2rem; font-weight:700; color:#16a34a;"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="₫"/></div>
            </div>
        </div>

        <div class="menu-grid" style="display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:20px; margin-bottom:36px;">
            <a href="${pageContext.request.contextPath}/menu" class="menu-card" style="display:block; padding:24px; border-radius:20px; background:white; text-decoration:none; color:#0f172a; box-shadow:0 18px 50px rgba(15,23,42,0.06); transition:transform .2s ease, box-shadow .2s ease;">
                <div style="font-size:2rem; margin-bottom:16px;">🍔</div>
                <div style="font-size:1.1rem; font-weight:700; margin-bottom:10px;">Quản lý thực đơn</div>
                <p style="margin:0; color:#475569; line-height:1.7;">Thêm, sửa, xóa các món và cập nhật giá bán.</p>
            </a>
            <a href="${pageContext.request.contextPath}/order" class="menu-card" style="display:block; padding:24px; border-radius:20px; background:white; text-decoration:none; color:#0f172a; box-shadow:0 18px 50px rgba(15,23,42,0.06); transition:transform .2s ease, box-shadow .2s ease;">
                <div style="font-size:2rem; margin-bottom:16px;">📦</div>
                <div style="font-size:1.1rem; font-weight:700; margin-bottom:10px;">Quản lý đơn đặt hàng</div>
                <p style="margin:0; color:#475569; line-height:1.7;">Xem danh sách đơn, cập nhật trạng thái và xử lý giao hàng.</p>
            </a>
            <a href="${pageContext.request.contextPath}/revenue" class="menu-card" style="display:block; padding:24px; border-radius:20px; background:white; text-decoration:none; color:#0f172a; box-shadow:0 18px 50px rgba(15,23,42,0.06); transition:transform .2s ease, box-shadow .2s ease;">
                <div style="font-size:2rem; margin-bottom:16px;">📊</div>
                <div style="font-size:1.1rem; font-weight:700; margin-bottom:10px;">Quản lý doanh thu</div>
                <p style="margin:0; color:#475569; line-height:1.7;">Xem báo cáo doanh thu theo ngày, tháng và tổng quan.</p>
            </a>
        </div>

        <div style="background:white; border-radius:20px; padding:24px; box-shadow:0 18px 50px rgba(15,23,42,0.06); margin-bottom:30px;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px;">
                <div>
                    <h2 style="margin:0; font-size:1.4rem;">Đơn hàng mới nhất</h2>
                    <p style="margin:8px 0 0; color:#64748b;">Xem nhanh 5 đơn gần nhất và chuyển trạng thái nhanh.</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/order" style="background:#2563eb; color:white; padding:10px 18px; border-radius:12px; text-decoration:none;">Xem tất cả đơn hàng</a>
                    <a href="${pageContext.request.contextPath}/revenue" style="background:#0f172a; color:white; padding:10px 18px; border-radius:12px; margin-left:10px; text-decoration:none;">Báo cáo doanh thu</a>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty latestOrders}">
                    <table style="width:100%; border-collapse:collapse; min-width:560px;">
                        <thead>
                            <tr style="border-bottom:2px solid #e2e8f0; color:#475569; text-align:left;">
                                <th style="padding:14px 12px;">Mã Đơn</th>
                                <th style="padding:14px 12px;">Ngày</th>
                                <th style="padding:14px 12px;">Tổng</th>
                                <th style="padding:14px 12px;">Trạng thái</th>
                                <th style="padding:14px 12px;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${latestOrders}" var="order">
                                <tr style="border-bottom:1px solid #f1f5f9;">
                                    <td style="padding:14px 12px; font-weight:700;">#${order.orderId}</td>
                                    <td style="padding:14px 12px;"><fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td style="padding:14px 12px;"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></td>
                                    <td style="padding:14px 12px;">
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}"><span style="background:#fde68a; color:#92400e; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Chờ xử lý</span></c:when>
                                            <c:when test="${order.status == 'PROCESSING'}"><span style="background:#cfe2ff; color:#084298; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Đang xử lý</span></c:when>
                                            <c:when test="${order.status == 'COMPLETED'}"><span style="background:#d1e7dd; color:#0f5132; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Hoàn thành</span></c:when>
                                            <c:when test="${order.status == 'CANCELLED'}"><span style="background:#f8d7da; color:#842029; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Đã hủy</span></c:when>
                                            <c:otherwise><span style="background:#e2e8f0; color:#334155; padding:6px 12px; border-radius:999px; font-size:0.9rem;">${order.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="padding:14px 12px;">
                                        <a href="${pageContext.request.contextPath}/order?action=view&id=${order.orderId}" style="background:#2563eb; color:white; padding:8px 14px; border-radius:10px; text-decoration:none; font-size:0.95rem;">Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p style="padding:14px 12px; color:#475569;">Chưa có đơn hàng nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
                <thead>
                    <tr style="border-bottom:2px solid #e2e8f0; color:#475569; text-align:left;">
                        <th style="padding:14px 12px;">Mã Đơn</th>
                        <th style="padding:14px 12px;">Món ăn</th>
                        <th style="padding:14px 12px;">Sinh viên</th>
                        <th style="padding:14px 12px;">Trạng thái</th>
                        <th style="padding:14px 12px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="border-bottom:1px solid #f1f5f9;">
                        <td style="padding:14px 12px; font-weight:700;">#ORD-001</td>
                        <td style="padding:14px 12px;">Burger Bò Phô Mai, Trà Đào</td>
                        <td style="padding:14px 12px;">SV001</td>
                        <td style="padding:14px 12px;"><span style="background:#fde68a; color:#92400e; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Chờ làm</span></td>
                        <td style="padding:14px 12px;"><button class="btn btn-primary" style="padding:8px 16px; font-size:0.95rem;">Nhận món</button></td>
                    </tr>
                    <tr>
                        <td style="padding:14px 12px; font-weight:700;">#ORD-002</td>
                        <td style="padding:14px 12px;">Cơm Sườn Nướng</td>
                        <td style="padding:14px 12px;">SV099</td>
                        <td style="padding:14px 12px;"><span style="background:#d1fae5; color:#166534; padding:6px 12px; border-radius:999px; font-size:0.9rem;">Đã xong</span></td>
                        <td style="padding:14px 12px;"><button class="btn" style="padding:8px 16px; font-size:0.95rem; background:#f8fafc; color:#475569; border:1px solid #e2e8f0;">Giao hàng</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
