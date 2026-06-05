<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống Kê Doanh Thu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 1400px;
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
            color: #333;
        }
        .tabs {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .tab-btn {
            padding: 10px 20px;
            border: 1px solid #c5d7ff;
            background-color: #e7f0ff;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
            color: #1f2937;
            font-weight: 600;
            transition: background-color 0.2s ease, border-color 0.2s ease;
        }
        .tab-btn.active {
            background-color: #0056b3;
            border-color: #004494;
            color: white;
        }
        .tab-btn:hover {
            background-color: #cbdcff;
            border-color: #9bbfff;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .stat-card {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .stat-label {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 2em;
            font-weight: bold;
            color: #007bff;
        }
        .stat-detail {
            font-size: 0.85em;
            color: #666;
            margin-top: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        table th {
            background-color: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }
        table td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
        }
        table tr:hover {
            background-color: #f5f5f5;
        }
        .chart-container {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
    <div class="container">
        <div class="header">
            <h1>📊 Thống Kê Doanh Thu</h1>
            <div class="tabs">
                <a href="${pageContext.request.contextPath}/revenue" class="tab-btn ${param.action == null || param.action == 'summary' ? 'active' : ''}">Tóm Tắt</a>
                <a href="${pageContext.request.contextPath}/revenue?action=daily" class="tab-btn ${param.action == 'daily' ? 'active' : ''}">Theo Ngày</a>
                <a href="${pageContext.request.contextPath}/revenue?action=monthly" class="tab-btn ${param.action == 'monthly' ? 'active' : ''}">Theo Tháng</a>
            </div>
        </div>

        <!-- Tóm Tắt (Summary) -->
        <c:if test="${param.action == null || param.action == 'summary'}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Tổng Đơn Hàng</div>
                    <div class="stat-value">${requestScope.totalOrders}</div>
                    <div class="stat-detail">Hôm nay</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Đơn Hoàn Thành</div>
                    <div class="stat-value">${requestScope.completedOrders}</div>
                    <div class="stat-detail">✓ Thành công</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Đơn Hủy</div>
                    <div class="stat-value">${requestScope.cancelledOrders}</div>
                    <div class="stat-detail">✗ Không thành công</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Tổng Doanh Thu</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${requestScope.totalRevenue}" type="currency" currencySymbol="₫"/>
                    </div>
                    <div class="stat-detail">Trong ngày</div>
                </div>
            </div>

            <h2>Doanh Thu Theo Danh Mục</h2>
            <div class="chart-container">
                <c:if test="${not empty requestScope.productRevenue}">
                    <table>
                        <thead>
                            <tr>
                                <th>Danh Mục</th>
                                <th>Doanh Thu</th>
                                <th>% Tổng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.productRevenue}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="₫"/></td>
                                    <td>
                                        <c:set var="percentage" value="${(entry.value / requestScope.totalRevenue) * 100}"/>
                                        <fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <h2>Doanh Thu Theo Phương Thức Thanh Toán</h2>
            <div class="chart-container">
                <c:if test="${not empty requestScope.paymentRevenue}">
                    <table>
                        <thead>
                            <tr>
                                <th>Phương Thức</th>
                                <th>Doanh Thu</th>
                                <th>% Tổng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.paymentRevenue}" var="entry">
                                <tr>
                                    <td>${entry.key}</td>
                                    <td><fmt:formatNumber value="${entry.value}" type="currency" currencySymbol="₫"/></td>
                                    <td>
                                        <c:set var="percentage" value="${(entry.value / requestScope.totalRevenue) * 100}"/>
                                        <fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </c:if>

        <!-- Theo Ngày (Daily) -->
        <c:if test="${param.action == 'daily'}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Tổng Đơn Hôm Nay</div>
                    <div class="stat-value">${requestScope.totalOrders != null ? requestScope.totalOrders : 0}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Doanh Thu Hôm Nay</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${requestScope.totalRevenue != null ? requestScope.totalRevenue : 0}" type="currency" currencySymbol="₫"/>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Trung Bình / Đơn</div>
                    <div class="stat-value">
                        <c:set var="avg" value="${requestScope.totalOrders > 0 ? requestScope.totalRevenue / requestScope.totalOrders : 0}"/>
                        <fmt:formatNumber value="${avg}" type="currency" currencySymbol="₫"/>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Theo Tháng (Monthly) -->
        <c:if test="${param.action == 'monthly'}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Tổng Đơn Tháng Này</div>
                    <div class="stat-value">${requestScope.totalOrders != null ? requestScope.totalOrders : 0}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Doanh Thu Tháng Này</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${requestScope.totalRevenue != null ? requestScope.totalRevenue : 0}" type="currency" currencySymbol="₫"/>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Trung Bình / Ngày</div>
                    <div class="stat-value">
                        <c:set var="avgDaily" value="${requestScope.totalRevenue != null ? requestScope.totalRevenue / 30 : 0}"/>
                        <fmt:formatNumber value="${avgDaily}" type="currency" currencySymbol="₫"/>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
