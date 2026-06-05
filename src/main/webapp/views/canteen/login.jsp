<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Canteen System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .auth-tabs {
            display: flex;
            gap: 0;
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 30px;
        }

        .auth-tab-btn {
            flex: 1;
            padding: 15px 20px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            color: #495057;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
        }

        .auth-tab-btn:hover {
            color: #007bff;
            background: #f8f9fa;
        }

        .auth-tab-btn.active {
            color: #007bff;
            border-bottom-color: #007bff;
        }

        .auth-tab-content {
            display: none;
        }

        .auth-tab-content.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .login-type-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: #f8f9fa;
            padding: 10px;
            border-radius: 8px;
        }

        .login-type-btn {
            flex: 1;
            padding: 10px 15px;
            background: white;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            color: #495057;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-type-btn:hover {
            border-color: #007bff;
            color: #007bff;
        }

        .login-type-btn.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }

        .login-form {
            display: none;
        }

        .login-form.active {
            display: block;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .switch-auth {
            text-align: center;
            color: #6c757d;
            font-size: 14px;
        }

        .switch-auth a {
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
            font-weight: 500;
        }

        .switch-auth a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ee5253;
            background: #ffeaa7;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #ee5253;
        }

        .success-message {
            color: #00b894;
            background: #d4edda;
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #00b894;
        }

        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 13px;
            color: #004085;
        }
    </style>
</head>
<body><jsp:include page="back_button.jsp" />    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>FPoly Canteen</h1>
                <p>Hệ thống quản lý căn tin trường học</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <% if (request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <!-- Main Tabs: Login and Registration -->
            <div class="auth-tabs">
                <button class="auth-tab-btn active" onclick="switchTab('login')">
                    <i>🔐</i> Đăng nhập
                </button>
                <button class="auth-tab-btn" onclick="switchTab('register')">
                    <i>📝</i> Đăng kí
                </button>
            </div>

            <!-- ===== LOGIN TAB ===== -->
            <div id="login" class="auth-tab-content active">
                <!-- Login Type Selection -->
                <div class="login-type-tabs">
                    <button class="login-type-btn active" onclick="switchLoginType('admin')">
                        Admin
                    </button>
                    <button class="login-type-btn" onclick="switchLoginType('customer')">
                        Khách hàng
                    </button>
                    <button class="login-type-btn" onclick="switchLoginType('staff')">
                        Nhân viên
                    </button>
                </div>

                <!-- Admin Login -->
                <div id="admin-login" class="login-form active">
                    <div class="info-box">
                        ℹ️ Đăng nhập với tài khoản admin
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="loginType" value="admin">
                        <div class="form-group">
                            <label class="form-label" for="admin-username">Tên đăng nhập</label>
                            <input type="text" id="admin-username" name="username" class="form-control" 
                                   placeholder="Mã admin..." required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="admin-password">Mật khẩu</label>
                            <input type="password" id="admin-password" name="password" class="form-control" 
                                   placeholder="••••••••" required>
                        </div>
                        <div style="margin-bottom: 20px; font-size: 13px; color: #6c757d; text-align: center;">
                            <input type="checkbox" name="remember" id="remember-admin"> 
                            <label for="remember-admin">Ghi nhớ tôi</label>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Đăng nhập</button>
                    </form>
                </div>

                <!-- Customer Login -->
                <div id="customer-login" class="login-form">
                    <div class="info-box">
                        ℹ️ Đăng nhập với tài khoản khách hàng / sinh viên
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="loginType" value="customer">
                        <div class="form-group">
                            <label class="form-label" for="customer-username">Mã sinh viên / Tên đăng nhập</label>
                            <input type="text" id="customer-username" name="username" class="form-control" 
                                   placeholder="SV001, SV002..." required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="customer-password">Mật khẩu</label>
                            <input type="password" id="customer-password" name="password" class="form-control" 
                                   placeholder="••••••••" required>
                        </div>
                        <div style="margin-bottom: 20px; font-size: 13px; color: #6c757d; text-align: center;">
                            <input type="checkbox" name="remember" id="remember-customer"> 
                            <label for="remember-customer">Ghi nhớ tôi</label>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Đăng nhập</button>
                    </form>
                    <div class="switch-auth" style="margin-top: 15px;">
                        Chưa có tài khoản? <a onclick="switchTab('register')">Đăng kí ngay</a>
                    </div>
                </div>

                <!-- Staff Login -->
                <div id="staff-login" class="login-form">
                    <div class="info-box">
                        ℹ️ Đăng nhập với tài khoản nhân viên căn tin
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="POST">
                        <input type="hidden" name="loginType" value="staff">
                        <div class="form-group">
                            <label class="form-label" for="staff-username">Tên đăng nhập</label>
                            <input type="text" id="staff-username" name="username" class="form-control"
                                   placeholder="Tên đăng nhập nhân viên..." required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="staff-password">Mật khẩu</label>
                            <input type="password" id="staff-password" name="password" class="form-control"
                                   placeholder="••••••••" required>
                        </div>
                        <div style="margin-bottom: 20px; font-size: 13px; color: #6c757d; text-align: center;">
                            <input type="checkbox" name="remember" id="remember-staff">
                            <label for="remember-staff">Ghi nhớ tôi</label>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Đăng nhập</button>
                    </form>
                </div>
            </div>

            <!-- ===== REGISTRATION TAB ===== -->
            <div id="register" class="auth-tab-content">
                <div class="info-box">
                    ℹ️ Đăng ký tài khoản khách hàng mới
                </div>

                <form action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="reg-username">Tên đăng nhập</label>
                            <input type="text" id="reg-username" name="username" class="form-control"
                                   placeholder="Tên đăng nhập..." required
                                   value="<%= request.getAttribute("val_username") != null ? request.getAttribute("val_username") : "" %>">
                            <% if (request.getAttribute("fieldError_username") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_username") %></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="reg-email">Email</label>
                            <input type="email" id="reg-email" name="email" class="form-control"
                                   placeholder="email@example.com" required
                                   value="<%= request.getAttribute("val_email") != null ? request.getAttribute("val_email") : "" %>">
                            <% if (request.getAttribute("fieldError_email") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_email") %></div>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="reg-fullname">Họ tên</label>
                            <input type="text" id="reg-fullname" name="fullName" class="form-control"
                                   placeholder="Họ tên đầy đủ..." required
                                   value="<%= request.getAttribute("val_fullName") != null ? request.getAttribute("val_fullName") : "" %>">
                            <% if (request.getAttribute("fieldError_fullName") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_fullName") %></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="reg-phone">Số điện thoại</label>
                            <input type="tel" id="reg-phone" name="phone" class="form-control"
                                   placeholder="0912345678" required
                                   value="<%= request.getAttribute("val_phone") != null ? request.getAttribute("val_phone") : "" %>">
                            <% if (request.getAttribute("fieldError_phone") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_phone") %></div>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="reg-dob">Ngày sinh</label>
                            <input type="date" id="reg-dob" name="dateOfBirth" class="form-control" required
                                   value="<%= request.getAttribute("val_dateOfBirth") != null ? request.getAttribute("val_dateOfBirth") : "" %>">
                            <% if (request.getAttribute("fieldError_dateOfBirth") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_dateOfBirth") %></div>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="reg-password">Mật khẩu</label>
                            <input type="password" id="reg-password" name="password" class="form-control"
                                   placeholder="••••••••" required minlength="6">
                            <% if (request.getAttribute("fieldError_password") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_password") %></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="reg-password-confirm">Xác nhận mật khẩu</label>
                            <input type="password" id="reg-password-confirm" name="passwordConfirm" class="form-control"
                                   placeholder="••••••••" required minlength="6">
                            <% if (request.getAttribute("fieldError_passwordConfirm") != null) { %>
                                <div class="error-message"><%= request.getAttribute("fieldError_passwordConfirm") %></div>
                            <% } %>
                        </div>
                    </div>

                    <div class="form-row full">
                        <div class="form-group" style="display: flex; align-items: center; gap: 10px;">
                            <input type="checkbox" id="agree-terms" name="agreeTerms" required>
                            <label for="agree-terms">Tôi đồng ý với các điều khoản dịch vụ</label>
                        </div>
                        <% if (request.getAttribute("fieldError_agreeTerms") != null) { %>
                            <div class="error-message"><%= request.getAttribute("fieldError_agreeTerms") %></div>
                        <% } %>
                    </div>

                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-bottom: 15px;">Đăng ký</button>

                    <div class="switch-auth">
                        Đã có tài khoản? <a onclick="switchTab('login')">Đăng nhập tại đây</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.auth-tab-content').forEach(el => {
                el.classList.remove('active');
            });
            document.querySelectorAll('.auth-tab-btn').forEach(el => {
                el.classList.remove('active');
            });

            // Show selected tab
            document.getElementById(tabName).classList.add('active');
            // Activate corresponding tab button (login=0, register=1)
            const tabs = document.querySelectorAll('.auth-tab-btn');
            if (tabName === 'login') tabs[0].classList.add('active');
            if (tabName === 'register') tabs[1].classList.add('active');
        }

        function switchLoginType(loginType) {
            // Hide all login forms
            document.querySelectorAll('.login-form').forEach(el => {
                el.classList.remove('active');
            });
            document.querySelectorAll('.login-type-btn').forEach(el => {
                el.classList.remove('active');
            });

            // Show selected login form
            document.getElementById(loginType + '-login').classList.add('active');
            // Activate corresponding login type button
            const btns = document.querySelectorAll('.login-type-btn');
            if (loginType === 'admin') btns[0].classList.add('active');
            if (loginType === 'customer') btns[1].classList.add('active');
            if (loginType === 'staff') btns[2].classList.add('active');
        }

        // Form validation
        document.addEventListener('submit', function(e) {
            if (e.target.method === 'POST' && e.target.action.includes('register')) {
                const password = document.getElementById('reg-password').value;
                const passwordConfirm = document.getElementById('reg-password-confirm').value;

                if (password !== passwordConfirm) {
                    e.preventDefault();
                    alert('Mật khẩu xác nhận không khớp!');
                    return false;
                }
            }
        });

        // If server requested to show registration tab (validation result), switch to it
        (function() {
            const showRegister = '<%= request.getAttribute("showRegisterTab") != null ? request.getAttribute("showRegisterTab") : "" %>';
            if (showRegister) {
                switchTab('register');
            }
        })();
    </script>
</body>
</html>
