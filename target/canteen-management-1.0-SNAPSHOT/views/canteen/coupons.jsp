<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.javaweb.model.Coupon" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mã Giảm Giá - Canteen</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .coupon-card {
            background: linear-gradient(135deg, #ff6b6b, #ff8787);
            color: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(255,107,107,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
        }
        .coupon-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(255,107,107,0.3);
        }
        .coupon-info h5 {
            margin: 0 0 10px 0;
            font-weight: 700;
        }
        .coupon-discount {
            font-size: 1.8rem;
            font-weight: 700;
        }
        .coupon-description {
            font-size: 0.9rem;
            opacity: 0.95;
            margin: 5px 0;
        }
        .coupon-code {
            background: white;
            color: #ff6b6b;
            padding: 15px 20px;
            border-radius: 8px;
            font-weight: 700;
            text-align: center;
            min-width: 120px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .coupon-code:hover {
            background: #f0f0f0;
        }
        .coupon-code.copied {
            background: #4ecdc4;
            color: white;
        }
        .header-section {
            background: linear-gradient(135deg, #ff6b6b, #4ecdc4);
            color: white;
            padding: 30px 0;
            margin-bottom: 30px;
            border-radius: 12px;
        }
        @media (max-width: 768px) {
            .coupon-card {
                flex-direction: column;
                align-items: flex-start;
            }
            .coupon-code {
                width: 100%;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
    <div class="container mt-4">
        <div class="header-section">
            <h2><i class="bi bi-ticket-perforated"></i> Mã Giảm Giá Khả Dụng</h2>
            <p class="mb-0">Nhấp vào mã để sao chép và sử dụng</p>
        </div>

        <c:if test="${not empty coupons}">
            <c:forEach items="${coupons}" var="coupon">
                <div class="coupon-card">
                    <div class="coupon-info">
                        <h5>${coupon.description}</h5>
                        <div class="coupon-discount">
                            <c:if test="${coupon.discountType == 'PERCENT'}">
                                -${coupon.discountValue}%
                            </c:if>
                            <c:if test="${coupon.discountType == 'FIXED'}">
                                -<fmt:formatNumber value="${coupon.discountValue}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                            </c:if>
                        </div>
                        <div class="coupon-description">
                            <c:if test="${coupon.minOrderAmount > 0}">
                                Tối thiểu: <fmt:formatNumber value="${coupon.minOrderAmount}" type="number" groupingUsed="true" maxFractionDigits="0"/>đ
                            </c:if>
                            <c:if test="${coupon.validTo != null}">
                                | HSD: ${coupon.validTo}
                            </c:if>
                        </div>
                    </div>
                    <div class="coupon-code" onclick="copyCoupon('${coupon.couponCode}')">
                        ${coupon.couponCode}
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty coupons}">
            <div style="text-align: center; padding: 60px 20px; background: #f9f9f9; border-radius: 12px;">
                <i class="bi bi-ticket2" style="font-size: 4rem; color: #ccc;"></i>
                <p class="text-muted mt-3" style="font-size: 1.1rem;">Hiện không có mã giảm giá khả dụng</p>
            </div>
        </c:if>
    </div>

    <script>
        function copyCoupon(code) {
            navigator.clipboard.writeText(code).then(() => {
                alert('Đã sao chép mã: ' + code);
            });
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
