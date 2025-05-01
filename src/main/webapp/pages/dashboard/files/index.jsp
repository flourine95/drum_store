<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js"></script>
<div id="ckbox"></div>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        initCKBox();
    });

    async function initCKBox() {
        try {
            const response = await fetch('/api/keys?service=ckbox-dev');
            if (!response.ok) {
                throw new Error('Không thể lấy token');
            }

            const tokenUrl = await response.text();

            CKBox.mount(document.getElementById('ckbox'), {
                tokenUrl
            });
        } catch (error) {
            console.error('Lỗi khi khởi tạo CKBox:', error);
            alert('Đã xảy ra lỗi khi tải trình quản lý ảnh.');
        }
    }
</script>


