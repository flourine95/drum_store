<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    .address-card {
        background: var(--text-white);
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border-radius: 15px;
        overflow: hidden;
    }

    .address-item {
        background: var(--text-white);
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        height: 100%;
    }

    .address-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .address-header {
        padding: 15px;
        border-bottom: 1px solid #eee;
    }

    .address-content {
        padding: 15px;
    }

    .default-badge {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
    }

    .btn-address {
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
    }

    .btn-add {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .btn-edit {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        padding: 6px 12px;
    }

    .btn-delete {
        background-color: var(--bs-secondary);
        color: var(--text-white);
        padding: 6px 12px;
    }

    .address-form {
        background: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 8px;
        padding: 10px 15px;
        border: 1px solid rgba(0, 0, 0, 0.1);
    }

    .form-control:focus {
        border-color: var(--bs-primary);
        box-shadow: 0 0 0 0.2rem rgba(253, 0, 0, 0.25);
    }
</style>

<div class="col-md-9">
    <div class="address-card animate__animated animate__fadeInRight">
        <div class="card-header p-4">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="bi bi-geo-alt me-2"></i>
                    DANH SÁCH ĐỊA CHỈ
                </h5>
                <button class="btn btn-address btn-add" id="add-address-btn">
                    <i class="bi bi-plus-circle me-2"></i>Thêm địa chỉ mới
                </button>
            </div>
        </div>

        <div class="card-body p-4">
            <!-- Form thêm địa chỉ mới -->
            <div id="add-address-form" class="address-form" style="display: none;">
                <form>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" placeholder="Nhập họ và tên">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" placeholder="Nhập số điện thoại">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" placeholder="Nhập địa chỉ chi tiết">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="defaultAddress">
                                <label class="form-check-label" for="defaultAddress">Đặt làm địa chỉ mặc định</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-address btn-add">
                                <i class="bi bi-check-circle me-2"></i>Lưu địa chỉ
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Danh sách địa chỉ -->
            <div class="row g-4">
                <!-- Địa chỉ item -->
                <div class="col-md-6">
                    <div class="address-item">
                        <div class="address-header d-flex justify-content-between align-items-center">
                            <div>
                                <span class="fw-bold">Nguyễn Hữu Nam</span>
                                <span class="default-badge ms-2">Mặc định</span>
                            </div>
                            <div>
                                <button class="btn btn-address btn-edit me-2">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-address btn-delete">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </div>
                        <div class="address-content">
                            <p class="mb-2">
                                <i class="bi bi-geo-alt me-2"></i>
                                123 Đường ABC, Phường XYZ, Quận 1, TP.HCM
                            </p>
                            <p class="mb-0">
                                <i class="bi bi-telephone me-2"></i>
                                0375174172
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Thêm các địa chỉ khác tương tự -->
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Toggle form thêm địa chỉ
        $('#add-address-btn').click(function() {
            $('#add-address-form').slideToggle(300);
        });

        // Hiệu ứng hover cho address items
        $('.address-item').hover(
            function() {
                $(this).addClass('shadow-lg');
            },
            function() {
                $(this).removeClass('shadow-lg');
            }
        );

        // Animation khi xóa địa chỉ
        $('.btn-delete').click(function() {
            $(this).closest('.col-md-6').addClass('animate__animated animate__fadeOutRight');
        });
    });
</script>