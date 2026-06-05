<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QR Thanh toán</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background: linear-gradient(180deg, #f4f7fb 0%, #e9eff8 100%);
            font-family: "Segoe UI", Arial, sans-serif;
            color: #1f2937;
        }
        .page-shell {
            min-height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }
        .card {
            width: min(520px, 100%);
            background: white;
            border-radius: 24px;
            box-shadow: 0 24px 60px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            border: 1px solid rgba(15, 23, 42, 0.08);
        }
        .card-header {
            padding: 28px 32px 22px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: white;
        }
        .card-header h1 {
            margin: 0 0 8px;
            font-size: 1.45rem;
            letter-spacing: -0.03em;
        }
        .card-header p {
            margin: 0;
            opacity: 0.88;
            line-height: 1.6;
        }
        .card-body {
            padding: 28px 32px 32px;
        }
        .qr-panel {
            display: grid;
            gap: 20px;
            place-items: center;
            padding: 18px;
            border: 1px dashed #dbeafe;
            border-radius: 18px;
            background: #f8fbff;
        }
        .qr-panel img.qr {
            width: 280px;
            max-width: 100%;
            border-radius: 18px;
            background: white;
            padding: 12px;
            box-shadow: 0 18px 48px rgba(59, 130, 246, 0.12);
        }
        .info-row {
            display: grid;
            gap: 10px;
            margin-top: 16px;
        }
        .info-row span {
            display: inline-flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            border-radius: 14px;
            background: #f8fafc;
            color: #111827;
            font-size: 0.98rem;
        }
        .info-row span strong {
            font-weight: 600;
        }
        .payment-instructions {
            margin-top: 18px;
            padding: 18px;
            border-radius: 18px;
            background: #eef6ff;
            border: 1px solid #dbeafe;
        }
        .payment-instructions p {
            margin: 0 0 10px;
            color: #1e40af;
            font-weight: 600;
        }
        .payment-instructions div {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            font-size: 0.98rem;
            color: #334155;
        }
        .payment-instructions span {
            flex: 1 1 100%;
            background: white;
            border-radius: 12px;
            padding: 12px 14px;
            border: 1px solid #c7d2fe;
            overflow-wrap: anywhere;
        }
        .copy-btn {
            margin-top: 14px;
            background: #2563eb;
            border: none;
            color: white;
            padding: 12px 18px;
            border-radius: 14px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }
        .copy-btn:hover {
            background: #1d4ed8;
        }
        .countdown {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1d4ed8;
            text-align: center;
            margin-top: 10px;
        }
        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            justify-content: center;
            margin-top: 24px;
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 170px;
            padding: 14px 18px;
            border-radius: 14px;
            text-decoration: none;
            color: white;
            font-weight: 600;
            transition: transform 0.2s ease, box-shadow 0.2s ease, opacity 0.2s ease;
        }
        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 30px rgba(59, 130, 246, 0.2);
        }
        .btn-outline {
            background: white;
            color: #2563eb;
            border: 1px solid #c7d2fe;
        }
        .btn-primary {
            background: #2563eb;
        }
        .btn-secondary {
            background: #0ea5e9;
        }
        .btn.disabled,
        .btn:disabled {
            opacity: 0.55;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }
        .alert {
            margin-top: 18px;
            padding: 16px 18px;
            border-radius: 16px;
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="back_button.jsp" />
<jsp:include page="nav.jsp" />
<div class="page-shell">
    <div class="card">
        <div class="card-header">
            <h1>Thanh toán QR</h1>
            <p>Vui lòng quét mã QR và hoàn tất thanh toán trong vòng 5 phút.</p>
        </div>
        <div class="card-body">
            <div class="qr-panel">
                <img id="qrImg" class="qr" src="${qrUrl}" alt="QR Payment" />
                <div class="countdown" id="countdown">Thời gian còn lại: 05:00</div>
            </div>

            <div class="info-row">
                <span><strong>Đơn hàng:</strong> <em>#${order.orderId}</em></span>
                <span><strong>Số tiền:</strong> <em><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></em></span>
                <span><strong>Hạn thanh toán:</strong> <em><fmt:formatDate value="${order.paymentExpiresAtAsDate}" pattern="HH:mm dd/MM/yyyy"/></em></span>
            </div>

            <div class="payment-instructions">
                <p>Nội dung chuyển khoản & số tiền sẽ được điền tự động khi quét mã QR:</p>
                <div>
                    <span id="qrContent">Thanh toán đơn hàng #${order.orderId} - Số tiền: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></span>
                </div>
                <button id="copyBtn" type="button" class="copy-btn">Sao chép nội dung chuyển khoản</button>
            </div>

            <div class="actions">
                <a id="openBtn" class="btn btn-outline" href="${qrUrl}" target="_blank">Mở ảnh mã QR</a>
                <a id="downloadBtn" class="btn btn-outline" style="display:none;" href="#">Tải mã QR</a>
                <a id="paidBtn" class="btn btn-primary" href="#">Tôi đã chuyển / Đã thanh toán</a>
            </div>
            <div class="alert" id="statusAlert">Thanh toán sẽ hết hạn sau 5 phút. Sau thời gian này, đơn sẽ bị huỷ.</div>
        </div>
    </div>
</div>

<script>
    // Fetch the QR image as a blob and create a downloadable URL so users can save a clean QR file
    (function(){
        var qrUrl = '${qrUrl}';
        var downloadBtn = document.getElementById('downloadBtn');
        var paidBtn = document.getElementById('paidBtn');
        fetch(qrUrl, {mode: 'cors'})
            .then(function(resp){ if(!resp.ok) throw new Error('Fetch failed'); return resp.blob(); })
            .then(function(blob){
                var url = URL.createObjectURL(blob);
                downloadBtn.href = url;
                downloadBtn.download = 'order-${order.orderId}-qr.png';
                downloadBtn.style.display = 'inline-flex';
            })
            .catch(function(){
                // fallback: leave download hidden
            });

        var expiresAt = new Date(${order.paymentExpiresAtAsDate.time});
        var countdownEl = document.getElementById('countdown');
        var statusAlert = document.getElementById('statusAlert');
        var confirmUrl = '${pageContext.request.contextPath}/order/payment/confirm?id=${order.orderId}&redirect=1';

        function disableActions() {
            paidBtn.classList.add('disabled');
            paidBtn.setAttribute('aria-disabled', 'true');
            paidBtn.href = '#';
            downloadBtn.classList.add('disabled');
            downloadBtn.removeAttribute('href');
            statusAlert.textContent = 'Thời hạn 5 phút đã kết thúc. Đơn hàng này hiện không thể thanh toán bằng mã QR.';
        }

        function updateCountdown() {
            var now = new Date();
            var diff = expiresAt - now;
            if (diff <= 0) {
                countdownEl.textContent = 'Thời gian đã hết hạn';
                disableActions();
                return;
            }
            var minutes = Math.floor(diff / 60000);
            var seconds = Math.floor((diff % 60000) / 1000);
            countdownEl.textContent = 'Thời gian còn lại: ' + String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
        }

        var countdownTimer = setInterval(function() {
            updateCountdown();
            if (new Date() >= expiresAt) {
                clearInterval(countdownTimer);
            }
        }, 1000);
        updateCountdown();

        var copyBtn = document.getElementById('copyBtn');
        var qrContentText = document.getElementById('qrContent').textContent;
        if (copyBtn) {
            copyBtn.addEventListener('click', function(){
                navigator.clipboard.writeText(qrContentText).then(function(){
                    copyBtn.textContent = 'Đã sao chép';
                    setTimeout(function(){ copyBtn.textContent = 'Sao chép nội dung chuyển khoản'; }, 1800);
                }).catch(function(){
                    alert('Không thể sao chép nội dung. Vui lòng thử lại.');
                });
            });
        }

        if (paidBtn) {
            paidBtn.addEventListener('click', function(e){
                e.preventDefault();
                if (new Date() >= expiresAt) {
                    alert('Thời gian thanh toán đã hết hạn. Vui lòng tạo đơn mới.');
                    disableActions();
                    return;
                }
                fetch(confirmUrl)
                    .then(function(response){
                        if (!response.ok) {
                            return response.text().then(function(text){ throw new Error(text || 'Không thể xác nhận thanh toán'); });
                        }
                        window.location = '${pageContext.request.contextPath}/order?action=view&id=${order.orderId}';
                    })
                    .catch(function(err){
                        alert(err.message || 'Không thể xác nhận thanh toán. Vui lòng thử lại.');
                    });
            });
        }
    })();
</script>
</body>
</html>