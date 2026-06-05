<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            margin-bottom: 40px;
        }
        .nav-brand {
            font-size: 1.8em;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .nav-menu {
            display: flex;
            gap: 15px;
        }
        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 5px;
            transition: all 0.3s;
            font-weight: 500;
        }
        .nav-link:hover {
            background-color: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }
        .container {
            max-width: 1600px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .header {
            margin-bottom: 40px;
        }
        .header h1 {
            font-size: 2.5em;
            color: #2d3748;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 50px;
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;
            border-left: 5px solid #667eea;
            transition: all 0.3s;
        }
        .stat-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
            transform: translateY(-5px);
        }
        .stat-label {
            color: #718096;
            font-size: 0.95em;
            margin-bottom: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .stat-value {
            font-size: 3em;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }
        .stat-detail {
            font-size: 0.9em;
            color: #a0aec0;
        }
        .section-title {
            font-size: 1.8em;
            font-weight: 700;
            margin: 40px 0 30px 0;
            color: #2d3748;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
            display: inline-block;
        }
        .menu-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 25px;
            margin-bottom: 60px;
        }
        .menu-card {
            flex: 1 1 280px;
            max-width: 280px;
            min-width: 260px;
            background: white;
            border-radius: 12px;
            padding: 30px 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2d3748;
            border-top: 4px solid transparent;
            position: relative;
            overflow: hidden;
        }
        .menu-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }
        .menu-card:hover::before {
            left: 100%;
        }
        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(102, 126, 234, 0.25);
            border-top-color: #667eea;
        }
        .menu-card:nth-child(2):hover {
            border-top-color: #764ba2;
        }
        .menu-card:nth-child(3):hover {
            border-top-color: #f093fb;
        }
        .menu-card:nth-child(4):hover {
            border-top-color: #4facfe;
        }
        .menu-card:nth-child(5):hover {
            border-top-color: #43e97b;
        }
        .menu-card:nth-child(6):hover {
            border-top-color: #fa709a;
        }
        .menu-icon {
            font-size: 3.5em;
            margin-bottom: 20px;
            display: block;
        }
        .menu-title {
            font-size: 1.35em;
            font-weight: 700;
            margin-bottom: 12px;
            color: #2d3748;
        }
        .menu-description {
            color: #718096;
            font-size: 0.95em;
            line-height: 1.5;
        }
        .grid-2col {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin-bottom: 60px;
        }
        @media (max-width: 768px) {
            .header h1 {
                font-size: 1.8em;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .menu-grid {
                grid-template-columns: 1fr;
            }
            .grid-2col {
                grid-template-columns: 1fr;
            }
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
            .nav-menu {
                flex-wrap: wrap;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <nav class="navbar">
        <span class="nav-brand">⚙️ ADMIN DASHBOARD</span>
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/revenue" class="nav-link">📊 Doanh Thu</a>
            <a href="${pageContext.request.contextPath}/menu" class="nav-link">🍔 Menu</a>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="nav-link">🚪 Đăng Xuất</a>
        </div>
    </nav>

    <div class="container">
        <div class="header">
            <h1>👋 Xin Chào ${sessionScope.user}!</h1>
        </div>

        <!-- Statistics Cards (Hàng ngang chuyên nghiệp) -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">👥 Tổng Khách Hàng</div>
                <div class="stat-value">${requestScope.totalCustomers}</div>
                <div class="stat-detail">Hoạt động: ${requestScope.activeCustomers}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">👔 Tổng Nhân Viên</div>
                <div class="stat-value">${requestScope.totalStaff}</div>
                <div class="stat-detail">Hoạt động: ${requestScope.activeStaff}</div>
            </div>
        </div>

        <!-- Main Menu Grid (3x2 layout) -->
        <h2 class="section-title">📋 Quản Lý Chức Năng</h2>
        <div class="menu-grid">
            <!-- Row 1 -->
            <a href="${pageContext.request.contextPath}/admin?action=customers" class="menu-card">
                <span class="menu-icon">👥</span>
                <div class="menu-title">Quản Lý Khách Hàng</div>
                <div class="menu-description">Xem, khóa, xóa tài khoản khách hàng</div>
            </a>

            <a href="${pageContext.request.contextPath}/admin?action=staff" class="menu-card">
                <span class="menu-icon">👔</span>
                <div class="menu-title">Quản Lý Nhân Viên</div>
                <div class="menu-description">Xem, khóa, xóa tài khoản nhân viên</div>
            </a>

            <a href="${pageContext.request.contextPath}/menu" class="menu-card">
                <span class="menu-icon">🍔</span>
                <div class="menu-title">Quản Lý Menu</div>
                <div class="menu-description">Thêm, sửa, xóa các món ăn</div>
            </a>

            <!-- Row 2 -->
            <a href="${pageContext.request.contextPath}/order" class="menu-card">
                <span class="menu-icon">📦</span>
                <div class="menu-title">Quản Lý Đơn Hàng</div>
                <div class="menu-description">Xem, cập nhật trạng thái đơn hàng</div>
            </a>

            <a href="${pageContext.request.contextPath}/payment" class="menu-card">
                <span class="menu-icon">💳</span>
                <div class="menu-title">Quản Lý Thanh Toán</div>
                <div class="menu-description">Xác nhận và theo dõi thanh toán</div>
            </a>

            <a href="${pageContext.request.contextPath}/revenue" class="menu-card">
                <span class="menu-icon">📊</span>
                <div class="menu-title">Thống Kê Doanh Thu</div>
                <div class="menu-description">Xem báo cáo doanh thu chi tiết</div>
            </a>
        </div>
    </div>
</body>
</html>
