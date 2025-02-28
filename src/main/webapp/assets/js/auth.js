document.addEventListener('DOMContentLoaded', function() {
    console.log('Auth.js loaded');
    
    window.logout = function() {
        console.log('Logout function called');
        
        if (typeof Swal === 'undefined') {
            console.error('Swal is not defined');
            return false;
        }
        
        Swal.fire({
            title: 'Xác nhận đăng xuất?',
            text: "Bạn có chắc chắn muốn đăng xuất?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Đăng xuất',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            console.log('Swal result:', result);
            if (result.isConfirmed) {
                const form = document.getElementById('logoutFormUser');
                if (form) {
                    form.submit();
                } else {
                    console.error('Logout form not found');
                }
            }
        }).catch(error => {
            console.error('Swal error:', error);
        });
        
        return false;
    };
});


// Xử lí nextStep bên quên mật khẩu
function nextStep() {
    document.getElementById('step1').classList.add('hidden');
    document.getElementById('step2').classList.remove('hidden');
}

function verifyOtp() {
    const otp = document.getElementById('otp').value;
    const result = document.getElementById('passwordResult');
    // Đây là nơi bạn có thể thêm logic xác thực OTP thực tế
    // Ví dụ giả lập:
    if (otp === '123456') { // OTP mẫu
        result.textContent = 'Mật khẩu mới của bạn là: NewPass123';
        result.classList.remove('hidden');
    } else {
        result.textContent = 'OTP không đúng, vui lòng thử lại!';
        result.classList.remove('hidden');
    }
}