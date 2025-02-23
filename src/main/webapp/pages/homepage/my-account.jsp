<%@ page contentType="text/html;charset=UTF-8" %>

<style>
    .sidebar {
        background: var(--text-white);
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    .sidebar .list-group-item {
        border: none;
        padding: 15px 20px;
        transition: all 0.3s ease;
        border-radius: 5px;
        margin: 2px 0;
        color: var(--text-color);
    }

    .sidebar .list-group-item:hover {
        background-color: #f8f9fa;
        color: var(--hover-color);
        transform: translateX(5px);
    }

    .sidebar .list-group-item.active {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .avatar-wrapper {
        position: relative;
        width: 120px;
        height: 120px;
        margin: 0 auto;
    }

    .avatar {
        width: 120px;
        height: 120px;
        background-color: var(--bs-primary);
        color: var(--hover-color);
        font-size: 2.5rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    .avatar:hover {
        transform: scale(1.05);
    }

    .info-card {
        background: var(--text-white);
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    .info-card:hover {
        transform: translateY(-5px);
    }

    .info-item {
        padding: 15px;
        border-bottom: 1px solid #eee;
    }

    .info-item:last-child {
        border-bottom: none;
    }

    .info-item strong {
        color: var(--text-color);
    }

    .btn-update {
        padding: 10px 30px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        background-color: var(--bs-primary);
        color: var(--hover-color);
        border: none;
    }

    .btn-update:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .text-danger {
        color: var(--bs-secondary) !important;
    }

    .card-header {
        background-color: var(--bs-primary) !important;
        color: var(--hover-color) !important;
    }
</style>

<main class="py-5" style="margin-top: 80px; min-height: 700px; background-color: #f8f9fa;">
    <div class="container">
        <div class="row g-4">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar animate__animated animate__fadeInLeft">
                    <div class="card-body text-center py-4">
                        <div class="avatar-wrapper mb-4">
                            <div class="avatar">
                                NN
                            </div>
                        </div>
                        <h5 class="fw-bold mb-0" style="color: var(--text-color)">Nguyễn Hữu Nam</h5>
                        <p class="text-muted small">Thành viên</p>
                    </div>
                    <div class="px-3 pb-4">
                        <div class="list-group">
                            <a href="my-account.html" class="list-group-item active">
                                <i class="bi bi-person-circle me-2"></i>
                                Thông tin tài khoản
                            </a>
                            <a href="wishlist.html" class="list-group-item">
                                <i class="bi bi-heart me-2"></i>
                                Sản phẩm yêu thích
                            </a>
                            <a href="orders.html" class="list-group-item">
                                <i class="bi bi-bag-check me-2"></i>
                                Quản lý đơn hàng
                            </a>
                            <a href="addresses.html" class="list-group-item">
                                <i class="bi bi-geo-alt me-2"></i>
                                Danh sách địa chỉ
                            </a>
                            <a href="../home.html" class="list-group-item text-danger">
                                <i class="bi bi-box-arrow-right me-2"></i>
                                Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <div class="info-card animate__animated animate__fadeInRight">
                    <div class="card-header p-4">
                        <h5 class="mb-0">
                            <i class="bi bi-person-badge me-2"></i>
                            THÔNG TIN TÀI KHOẢN
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="info-item">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <strong>Họ và tên</strong>
                                </div>
                                <div class="col-md-8">
                                    Nguyễn Hữu Nam
                                </div>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <strong>Email</strong>
                                </div>
                                <div class="col-md-8">
                                    kiyosiakira@gmail.com
                                </div>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <strong>Điện thoại</strong>
                                </div>
                                <div class="col-md-8">
                                    0375174172
                                </div>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="row align-items-center">
                                <div class="col-md-4">
                                    <strong>Địa chỉ</strong>
                                </div>
                                <div class="col-md-8">
                                    <address class="mb-0">
                                        123 Đường ABC, Phường XYZ, Quận 1, TP.HCM
                                    </address>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer bg-light p-4 text-center">
                        <a href="edit-account.html" class="btn btn-update">
                            <i class="bi bi-pencil-square me-2"></i>
                            Cập nhật thông tin
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // Add smooth hover effect to cards
        $('.info-card').hover(
            function() {
                $(this).addClass('shadow-lg');
            },
            function() {
                $(this).removeClass('shadow-lg');
            }
        );

        // Add active class to current nav item
        const currentLocation = window.location.href;
        $('.list-group-item').each(function() {
            if ($(this).attr('href') === currentLocation) {
                $(this).addClass('active');
            }
        });
    });
</script>