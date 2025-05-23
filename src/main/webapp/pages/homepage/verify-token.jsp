<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    :root {
        --primary-color: #1B2832;
        --accent-color: #FFD700;
        --text-color: #4A5568;
        --border-color: #E2E8F0;
        --input-bg: #F8FAFC;
        --error-color: #E53E3E;
        --success-color: #38A169;
        --light-bg: #F9FAFB;
    }
    
    .verification-page-container {
        min-height: calc(100vh - 200px);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 2rem 1rem;
        background-color: #f8f9fa;
    }

    .verification-container {
        background-color: #fff;
        border-radius: 16px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        width: 100%;
        max-width: 500px;
        margin: 0 auto;
    }

    .verification-header {
        background-color: var(--light-bg);
        padding: 2rem 2rem 1.5rem;
        text-align: center;
        border-bottom: 1px solid var(--border-color);
    }

    .verification-icon {
        width: 60px;
        height: 60px;
        background-color: var(--accent-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem;
    }

    .verification-icon i {
        color: var(--primary-color);
        font-size: 1.5rem;
    }

    .verification-title {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 0.5rem;
    }

    .verification-subtitle {
        color: var(--text-color);
        font-size: 1rem;
        line-height: 1.5;
    }

    .verification-body {
        padding: 2rem;
    }

    .otp-container {
        display: flex;
        justify-content: space-between;
        margin: 1.5rem 0;
        gap: 8px;
    }

    .otp-input {
        width: 50px;
        height: 60px;
        text-align: center;
        font-size: 1.5rem;
        font-weight: 600;
        border: 2px solid var(--border-color);
        border-radius: 8px;
        background-color: var(--input-bg);
        color: var(--primary-color);
        transition: all 0.2s ease;
    }

    .otp-input:focus {
        outline: none;
        border-color: var(--accent-color);
        box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
    }

    .btn-primary {
        width: 100%;
        padding: 0.875rem;
        background-color: var(--accent-color);
        border: none;
        border-radius: 8px;
        color: var(--primary-color);
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        margin-bottom: 1rem;
    }

    .btn-primary:hover {
        background-color: #FFC107;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .btn-secondary {
        width: 100%;
        padding: 0.875rem;
        background-color: transparent;
        border: 1px solid var(--border-color);
        border-radius: 8px;
        color: var(--text-color);
        font-weight: 500;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .btn-secondary:hover {
        background-color: var(--light-bg);
        border-color: var(--text-color);
    }

    .timer-container {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 1.5rem 0;
        color: var(--text-color);
        font-size: 0.9rem;
    }

    .timer-container i {
        margin-right: 0.5rem;
        color: var(--accent-color);
    }

    .timer-countdown {
        font-weight: 600;
        color: var(--primary-color);
    }

    .error-message {
        color: var(--error-color);
        font-size: 0.875rem;
        margin-top: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        text-align: center;
        justify-content: center;
    }

    .error-message i {
        font-size: 14px;
    }

    .alert-danger {
        background-color: #FEE2E2;
        border: 1px solid #FCA5A5;
        color: #DC2626;
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        font-size: 0.95rem;
        width: 100%;
        text-align: left;
    }

    .alert-success {
        background-color: #D1FAE5;
        border: 1px solid #6EE7B7;
        color: #047857;
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
        font-size: 0.95rem;
        width: 100%;
        text-align: left;
    }
</style>

<div class="verification-page-container">
    <div class="verification-container">
        <div class="verification-header">
            <div class="verification-icon">
                <i class="fas fa-envelope"></i>
            </div>
            <h1 class="verification-title">Xác thực tài khoản</h1>
            <p class="verification-subtitle">
                Chúng tôi đã gửi mã OTP đến email của bạn.
                Vui lòng nhập mã để hoàn tất đăng ký.
            </p>
        </div>

        <div class="verification-body">
            <c:if test="${not empty errors.general}">
                <div class="alert alert-danger" id="server-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errors.general}
                </div>
            </c:if>

            <div id="success-message" class="alert alert-success" style="display: none;">
                <i class="fas fa-check-circle"></i>
                <span id="success-text"></span>
            </div>

            <div id="attempts-message" class="error-message" style="display: none;">
                <i class="fas fa-exclamation-circle"></i>
                Bạn còn <span id="attempts-left">3</span> lần nhập.
            </div>

            <div id="ajax-error" class="error-message" style="display: none;"></div>

            <form id="verifyForm" method="POST">
                <div class="otp-container">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric">
                </div>
                <input type="hidden" id="token" name="token">

                <div class="timer-container">
                    <i class="far fa-clock"></i>
                    Mã hết hạn sau: <span class="timer-countdown" id="countdown">05:00</span>
                </div>

                <button type="submit" class="btn btn-primary" id="submitBtn">Xác nhận</button>
                <button type="button" class="btn btn-secondary" id="resendOtpBtn">Gửi lại mã OTP</button>
            </form>
        </div>
    </div>

    <div id="loadingOverlay"
         class="d-none position-fixed top-0 start-0 w-100 h-100 bg-dark bg-opacity-50 d-flex justify-content-center align-items-center"
         style="z-index: 9999;">
        <div class="spinner-border text-light" role="status">
            <span class="visually-hidden">Đang tải...</span>
        </div>
    </div>
</div>
<script>
    let attempts = 3;
    let timer;
    let timeLeft = 300;

    const otpInputs = document.querySelectorAll('.otp-input');
    const tokenInput = document.getElementById('token');

    otpInputs.forEach((input, index) => {
        input.addEventListener('keyup', (e) => {
            if (input.value.length === 1) {
                if (index < otpInputs.length - 1) {
                    otpInputs[index + 1].focus();
                }
            }

            if (e.key === 'Backspace' && input.value.length === 0) {
                if (index > 0) {
                    otpInputs[index - 1].focus();
                }
            }

            updateToken();
        });

        input.addEventListener('paste', (e) => {
            e.preventDefault();
            const pasteData = e.clipboardData.getData('text').trim();
            if (pasteData.length === 6 && /^\d+$/.test(pasteData)) {
                for (let i = 0; i < otpInputs.length; i++) {
                    otpInputs[i].value = pasteData.charAt(i);
                }
                updateToken();
            }
        });
    });

    function updateToken() {
        let code = '';
        otpInputs.forEach(input => {
            code += input.value;
        });
        tokenInput.value = code;
    }

    function startTimer() {
        clearInterval(timer);
        timeLeft = 300;
        updateTimerDisplay();
        
        timer = setInterval(() => {
            timeLeft--;
            updateTimerDisplay();
            
            if (timeLeft <= 0) {
                clearInterval(timer);
                document.getElementById('submitBtn').disabled = true;
                document.getElementById('ajax-error').style.display = 'block';
                document.getElementById('ajax-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Mã OTP đã hết hạn. Vui lòng yêu cầu mã mới.';
            }
        }, 1000);
    }

    function updateTimerDisplay() {
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        document.getElementById('countdown').textContent = 
            `\${minutes.toString().padStart(2, '0')}:\${seconds.toString().padStart(2, '0')}`;
    }

    startTimer();

    document.getElementById('verifyForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const token = document.getElementById('token').value;
        if (token.length !== 6) {
            document.getElementById('ajax-error').style.display = 'block';
            document.getElementById('ajax-error').innerHTML = '<i class="fas fa-exclamation-circle"></i> Vui lòng nhập đủ 6 chữ số của mã OTP.';
            return;
        }

        const submitBtn = document.getElementById('submitBtn');
        const ajaxError = document.getElementById('ajax-error');
        ajaxError.style.display = 'none';

        const loadingOverlay = document.querySelector('#loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.remove('d-none');
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/verify-token',
            method: 'POST',
            data: {
                token: token
            },
            dataType: 'json',
            success: function(data) {
                if (data.success) {
                    const successMessage = document.getElementById('success-message');
                    const successText = document.getElementById('success-text');
                    successMessage.style.display = 'block';
                    successText.textContent = 'Xác thực thành công! Đang chuyển hướng...';
                    
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/login';
                    }, 1500);
                } else {
                    attempts--;
                    document.getElementById('attempts-message').style.display = 'block';
                    document.getElementById('attempts-left').textContent = attempts;
                    ajaxError.style.display = 'block';
                    ajaxError.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + data.error;

                    otpInputs.forEach(input => {
                        input.value = '';
                    });
                    otpInputs[0].focus();
                    tokenInput.value = '';

                    if (attempts <= 0) {
                        submitBtn.disabled = true;
                        ajaxError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Bạn đã hết lượt nhập. Vui lòng yêu cầu mã OTP mới.';
                    }
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                ajaxError.style.display = 'block';
                ajaxError.innerHTML = '<i class="fas fa-exclamation-circle"></i> Có lỗi xảy ra. Vui lòng thử lại.';
            },
            complete: function() {
                if (loadingOverlay) {
                    loadingOverlay.classList.add('d-none');
                }
            }
        });
    });

    document.getElementById('resendOtpBtn').addEventListener('click', function () {
        const loadingOverlay = document.querySelector('#loadingOverlay');
        if (loadingOverlay) {
            loadingOverlay.classList.remove('d-none');
        }
        
        attempts = 3;
        document.getElementById('attempts-message').style.display = 'none';
        document.getElementById('ajax-error').style.display = 'none';
        document.getElementById('submitBtn').disabled = false;
        
        otpInputs.forEach(input => {
            input.value = '';
        });
        otpInputs[0].focus();
        tokenInput.value = '';
        
        $.ajax({
            url: '${pageContext.request.contextPath}/verify-token',
            method: 'POST',
            data: { action: 'resend' },
            dataType: 'json',
            success: function (data) {
                startTimer();
                
                Swal.fire({
                    title: "Mã OTP mới",
                    text: "Mã OTP mới đã được gửi đến email của bạn",
                    icon: "success"
                });
            },
            error: function () {
                Swal.fire({
                    title: "Lỗi",
                    text: "Có lỗi xảy ra, gửi mã OTP thất bại",
                    icon: "error"
                });
            },
            complete: function () {
                if (loadingOverlay) {
                    loadingOverlay.classList.add('d-none');
                }
            }
        });
    });
</script>