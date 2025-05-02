const SwalHelper = {
    loading: (title = 'Đang xử lý...', html = 'Vui lòng đợi trong giây lát') => {
        return Swal.fire({
            title,
            html,
            allowOutsideClick: false,
            showConfirmButton: false,
            didOpen: () => Swal.showLoading()
        });
    },

    success: (text = '', title = 'Thành công!', timer = 1500) => {
        return Swal.fire({
            icon: 'success',
            title,
            text,
            timer,
            showConfirmButton: false
        });
    },

    error: (text = 'Có lỗi xảy ra', title = 'Lỗi!') => {
        return Swal.fire({
            icon: 'error',
            title,
            text
        });
    },

    warning: (title, html, timer = 3000) => {
        return Swal.fire({
            icon: 'warning',
            title,
            html,
            timer,
            showConfirmButton: false
        });
    },

    confirm: async (title, text, confirmText = 'Xác nhận', cancelText = 'Hủy') => {
        return Swal.fire({
            icon: 'question',
            title,
            text,
            showCancelButton: true,
            confirmButtonText: confirmText,
            cancelButtonText: cancelText
        });
    },

    customHtml: (title, html, icon = 'info', timer = 3000) => {
        return Swal.fire({
            icon,
            title,
            html,
            timer,
            showConfirmButton: false
        });
    },

    updateHtml: (html) => Swal.update({html})
};
