<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
.back-button {
    position: fixed;
    top: 18px;
    left: 18px;
    z-index: 9999;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 10px 14px;
    border-radius: 999px;
    border: 1px solid rgba(34, 34, 34, 0.12);
    background: rgba(255, 255, 255, 0.95);
    color: #222f3e;
    font-weight: 700;
    font-size: 0.95rem;
    text-decoration: none;
    box-shadow: 0 10px 24px rgba(0, 0, 0, 0.08);
    cursor: pointer;
    transition: transform 0.2s ease, background 0.2s ease, box-shadow 0.2s ease;
}
.back-button:hover {
    transform: translateY(-1px);
    background: #f4f6fb;
}
@media (max-width: 768px) {
    .back-button {
        top: 12px;
        left: 12px;
        padding: 10px 12px;
        font-size: 0.9rem;
    }
}
</style>
<script>
    function goBackSafe() {
        if (window.history.length > 1) {
            window.history.back();
        } else {
            window.location.href = '${pageContext.request.contextPath}/home';
        }
    }
</script>
<a class="back-button" href="javascript:goBackSafe()">&larr; Quay lại</a>
