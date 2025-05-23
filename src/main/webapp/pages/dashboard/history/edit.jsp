<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/history">Logs</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa Log</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa Log
                    </h6>
                </div>
                <div class="card-body">
                    <form id="logForm">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${log.id}">

                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <input type="number" class="form-control" readonly id="id" name="userId" placeholder="ID người dùng" value="${log.userId}" required>
                                    <label for="userId">ID <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="userName" name="userName" placeholder="Tên người dùng" value="${log.userName}" required>
                                    <label for="userName">Mã_Tên người dùng <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="action" name="action" placeholder="Hành động" value="${log.action}" required>
                                    <label for="action">Hành động <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="oldData" name="oldData" placeholder="Dữ liệu cũ" style="height: 120px">${log.oldData}</textarea>
                                    <label for="oldData">Dữ liệu cũ</label>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="newData" name="newData" placeholder="Dữ liệu mới" style="height: 120px">${log.newData}</textarea>
                                    <label for="newData">Dữ liệu mới</label>
                                </div>
                            </div>

                            <div class="col-12 d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/dashboard/history" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-1"></i> Quay lại
                                </a>
<%--                                <button type="button" id="saveLogBtn" class="btn btn-primary">--%>
<%--                                    <i class="bi bi-save me-1"></i> Lưu thay đổi--%>
<%--                                </button>--%>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <h6 class="m-0 font-weight-bold text-primary">
                        <i class="bi bi-info-circle me-2"></i>Thông tin Log
                    </h6>
                </div>
                <div class="card-body">
                    <div class="alert alert-info mb-0">
                        <h6 class="alert-heading">Chi tiết Log</h6>
                        <hr>
                        <ul class="mb-0 ps-3">
                            <li>ID: <strong>${log.id}</strong></li>
                            <li>Thời gian ghi log: <strong>${log.timestamp}</strong></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<script>
    $('#saveLogBtn').on('click', function (event) {
        event.preventDefault();
        const data = {
            action: 'update',
            id: $('input[name="id"]').val().trim(),
            userId: $('#userId').val().trim(),
            userName: $('#userName').val().trim(),
            actionText: $('#action').val().trim(),
            oldData: $('#oldData').val().trim(),
            newData: $('#newData').val().trim()
        };

        if (!data.userId || !data.userName || !data.actionText) {
            Swal.fire({
                icon: "warning",
                title: "Thiếu dữ liệu",
                text: "Vui lòng điền đầy đủ ID, tên người dùng và hành động",
                confirmButtonText: "OK"
            });
            return;
        }

        Swal.fire({
            title: "Đang lưu...",
            text: "Vui lòng chờ trong giây lát",
            allowOutsideClick: false,
            didOpen: () => Swal.showLoading()
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/dashboard/history',
            method: 'POST',
            data: data,
            success: function (response) {
                if (response.success) {
                    Swal.fire({
                        icon: "success",
                        title: "Cập nhật thành công",
                        text: response.message,
                        confirmButtonText: "OK"
                    }).then(() => {
                        window.location.href = response.redirectUrl || '${pageContext.request.contextPath}/dashboard/history';
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Lỗi",
                        text: response.message || "Lỗi không xác định"
                    });
                }
            },
            error: function (xhr) {
                let errorMessage = "Không thể cập nhật log";
                try {
                    const res = JSON.parse(xhr.responseText);
                    if (res.message) errorMessage = res.message;
                } catch (e) {}
                Swal.fire({
                    icon: "error",
                    title: "Lỗi",
                    text: errorMessage
                });
            }
        });
    });
</script>
