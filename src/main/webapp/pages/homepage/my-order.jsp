<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    /* Sidebar styles */
    .sidebar {
        background: var(--text-white);
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }

    .list-group-item {
        border: none;
        padding: 15px 20px;
        transition: all 0.3s ease;
        border-radius: 5px;
        margin: 2px 0;
        color: var(--text-color);
    }

    .list-group-item:hover {
        background-color: #f8f9fa;
        color: var(--hover-color);
        transform: translateX(5px);
    }

    .list-group-item.active {
        background-color: var(--bs-primary) !important;
        color: var(--hover-color) !important;
    }

    /* Avatar styles */
    .avatar {
        width: 80px;
        height: 80px;
        background-color: var(--bs-primary);
        color: var(--hover-color);
        font-size: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        transition: all 0.3s ease;
    }

    .avatar:hover {
        transform: scale(1.05);
    }

    /* Table styles */
    .table {
        background: var(--text-white);
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }

    .table thead {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .table th {
        font-weight: 600;
        padding: 15px;
        border: none;
        text-align: center;
        vertical-align: middle;
    }

    .table td {
        padding: 15px;
        vertical-align: middle;
        border-bottom: 1px solid rgba(0,0,0,0.05);
        color: var(--text-color);
    }

    /* Product image styles */
    .product-img {
        width: 130px;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        transition: transform 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .product-img:hover {
        transform: scale(1.05);
    }

    /* Status badge styles */
    .badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 500;
        font-size: 0.9rem;
    }

    .bg-primary {
        background-color: var(--bs-primary) !important;
        color: var(--hover-color) !important;
    }

    .bg-danger {
        background-color: var(--bs-secondary) !important;
        color: var(--text-white) !important;
    }

    .bg-success {
        background-color: #28a745 !important;
        color: var(--text-white) !important;
    }

    /* Card styles */
    .card {
        border: none;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        background: var(--text-white);
    }

    .card-title {
        color: var(--text-color);
        font-weight: 600;
    }

    /* Order title */
    .order-title {
        color: var(--text-color);
        font-weight: 600;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid var(--bs-primary);
        display: inline-block;
    }

    /* Table hover effect */
    .table-hover tbody tr:hover {
        background-color: rgba(253, 0, 0, 0.02);
        transition: all 0.3s ease;
    }

    /* Product name styles */
    .product-name {
        color: var(--text-color);
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .product-name:hover {
        color: var(--hover-color);
    }
</style>

<main style="margin-top: 100px; min-height: 700px; background-color: #f8f9fa;">
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar animate__animated animate__fadeInLeft">
                    <div class="card-body d-flex flex-column align-items-center">
                        <div class="avatar mb-3">
                            NN
                        </div>
                        <h5 class="card-title text-center">Nguyễn Hữu Nam</h5>
                    </div>
                    <ul class="list-group list-group-flush">
                        <a href="my-account.html" class="list-group-item">
                            <i class="bi bi-person-circle me-2"></i>Thông tin tài khoản
                        </a>
                        <a href="wishlist.html" class="list-group-item">
                            <i class="bi bi-heart me-2"></i>Sản phẩm yêu thích
                        </a>
                        <a href="#" class="list-group-item active">
                            <i class="bi bi-bag-check me-2"></i>Quản lý đơn hàng
                        </a>
                        <a href="addresses.html" class="list-group-item">
                            <i class="bi bi-geo-alt me-2"></i>Danh sách địa chỉ
                        </a>
                        <a href="../home.html" class="list-group-item text-danger">
                            <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                        </a>
                    </ul>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 animate__animated animate__fadeInRight">
                <h3 class="order-title">
                    <i class="bi bi-bag-check me-2"></i>
                    Danh sách đơn hàng
                </h3>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Tên sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Mô tả sản phẩm</th>
                            <th>Ảnh sản phẩm</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- Giữ nguyên nội dung tbody -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // Add hover effect for table rows
        $('.table tbody tr').hover(
            function() {
                $(this).css('transform', 'translateY(-2px)');
            },
            function() {
                $(this).css('transform', 'none');
            }
        );

        // Add animation for badges
        $('.badge').hover(
            function() {
                $(this).css('transform', 'scale(1.1)');
            },
            function() {
                $(this).css('transform', 'none');
            }
        );
    });
</script>