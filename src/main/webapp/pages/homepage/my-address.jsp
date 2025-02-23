<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    /* Sidebar styles - đồng bộ với my-account.jsp */
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

    /* Avatar styles */
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

    /* Address card styles */
    .address-card {
        background: var(--text-white);
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        margin-bottom: 20px;
        border: none;
    }

    .address-card:hover {
        transform: translateY(-5px);
    }

    .address-card .card-header {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        border-radius: 15px 15px 0 0;
        padding: 15px 20px;
        border: none;
    }

    .address-card .card-body {
        padding: 20px;
    }

    /* Button styles */
    .btn-address {
        padding: 8px 20px;
        border-radius: 20px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .btn-add {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        border: none;
    }

    .btn-add:hover {
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .btn-edit {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .btn-edit:hover {
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .btn-delete {
        background-color: var(--bs-secondary);
        color: var(--text-white);
    }

    /* Form styles */
    .form-control {
        border-radius: 8px;
        border: 1px solid rgba(0,0,0,0.1);
        padding: 10px 15px;
    }

    .form-control:focus {
        border-color: var(--bs-primary);
        box-shadow: 0 0 0 0.2rem rgba(253, 0, 0, 0.25);
    }

    .form-label {
        color: var(--text-color);
        font-weight: 500;
    }

    /* Default address badge */
    .default-badge {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        padding: 5px 10px;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 500;
    }
</style>

<main class="py-5" style="margin-top: 80px; min-height: 700px; background-color: #f8f9fa;">
    <div class="container">
        <div class="row g-4">
            <!-- Sidebar - giống my-account.jsp -->
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
            <div class="col-md-9 animate__animated animate__fadeInRight">
                <div class="card address-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-geo-alt me-2"></i>
                            DANH SÁCH ĐỊA CHỈ
                        </h5>
                        <button class="btn btn-address btn-add" id="add-address-btn">
                            <i class="bi bi-plus-circle me-2"></i>Thêm địa chỉ mới
                        </button>
                    </div>

                    <div class="card-body">
                        <!-- Form thêm địa chỉ mới -->
                        <div id="add-address-form" class="mb-4" style="display: none;">
                            <!-- ... (giữ nguyên form như cũ nhưng thêm class và style mới) ... -->
                        </div>

                        <!-- Danh sách địa chỉ -->
                        <div class="row">
                            <!-- Mẫu cho một địa chỉ -->
                            <div class="col-md-6 mb-4">
                                <div class="address-card h-100">
                                    <div class="card-header d-flex justify-content-between align-items-center">
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
                                    <div class="card-body">
                                        <p class="mb-2"><i class="bi bi-geo-alt me-2"></i>123 Đường ABC, Phường XYZ, Quận 1, TP.HCM</p>
                                        <p class="mb-0"><i class="bi bi-telephone me-2"></i>0375174172</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Thêm các địa chỉ khác tương tự -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // Toggle form thêm địa chỉ
        $('#add-address-btn').click(function() {
            $('#add-address-form').slideToggle();
        });

        // Hiệu ứng hover cho cards
        $('.address-card').hover(
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

        // Active sidebar item
        const currentLocation = window.location.href;
        $('.list-group-item').each(function() {
            if ($(this).attr('href') === currentLocation) {
                $(this).addClass('active');
            }
        });
    });
</script>