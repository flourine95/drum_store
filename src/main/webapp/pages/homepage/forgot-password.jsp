<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    .container-fluid {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 50.5vh;
        margin: 0;
        background: #f0f2f5;
    }

    .container.forgot-password {
        background: white;
        padding: 2rem;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;

        transition: all 0.3s ease;
    }
    h2 {
        color: #333;
        margin: 0 0 1.5rem;
        text-align: center;
    }
    .form-group {
        margin-bottom: 1.5rem;
    }
    label {
        display: block;
        color: #555;
        margin-bottom: 0.5rem;
        font-weight: 500;
    }
    input {
        width: 100%;
        padding: 0.8rem;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 1rem;
    }
    input:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
    }
    .button {
        width: 100%;
        padding: 0.8rem;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 1rem;
        cursor: pointer;
        transition: background 0.3s;
    }
    .button:hover {
        background: #0056b3;
    }
    .message {
        text-align: center;
        color: #28a745;
        margin: 1rem 0;
    }
    .hidden {
        display: none;
    }
</style>
<div class="container-fluid">
    <div class="container forgot-password" id="step1">
        <h2>Đặt lại mật khẩu</h2>
        <form id="emailForm" onsubmit="nextStep(); return false;">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email của bạn" required>
            </div>
            <button type="submit" class="button">Gửi mã OTP</button>
        </form>
    </div>

    <div class="container hidden" id="step2">
        <h2>Xác nhận OTP</h2>
        <div class="message">
            Mã OTP đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư!
        </div>
        <form id="otpForm" onsubmit="verifyOtp(); return false;">
            <div class="form-group">
                <label for="otp">Mã OTP</label>
                <input type="text" id="otp" name="otp" placeholder="Nhập mã OTP" required>
            </div>
            <button type="submit" class="button">Xác nhận</button>
        </form>
        <div id="passwordResult" class="message hidden"></div>
    </div>
</div>