<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    /* Sidebar styles */
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
        width: 80px;
        height: 80px;
        background-color: var(--bs-primary);
        color: var(--hover-color);
        font-size: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        margin: 0 auto;
        transition: all 0.3s ease;
    }

    /* Table styles */
    .table {
        background: var(--text-white);
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 15px rgba(0,0,0,0.05);
    }

    .table thead {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .table th {
        font-weight: 600;
        padding: 15px;
        border: none;
    }

    .table td {
        padding: 15px;
        vertical-align: middle;
        border-bottom: 1px solid rgba(0,0,0,0.05);
    }

    /* Product image styles */
    .product-img {
        width: 130px;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        transition: transform 0.3s ease;
    }

    .product-img:hover {
        transform: scale(1.05);
    }

    /* Button styles */
    .btn-action {
        padding: 8px 15px;
        border-radius: 5px;
        font-weight: 500;
        transition: all 0.3s ease;
        margin: 0 5px;
    }

    .btn-cart {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        border: none;
    }

    .btn-cart:hover {
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .btn-remove {
        background-color: var(--bs-secondary);
        color: var(--text-white);
        border: none;
    }

    .btn-remove:hover {
        background-color: #8a2828;
    }

    /* Status badge styles */
    .badge {
        padding: 8px 12px;
        border-radius: 20px;
        font-weight: 500;
    }

    .badge-success {
        background-color: #28a745;
        color: var(--text-white);
    }

    .badge-danger {
        background-color: var(--bs-secondary);
        color: var(--text-white);
    }

    /* Product name styles */
    .product-name {
        font-weight: 500;
        color: var(--text-color);
        transition: color 0.3s ease;
    }

    .product-name:hover {
        color: var(--hover-color);
    }

    /* Price styles */
    .price {
        font-weight: 600;
        color: var(--bs-secondary);
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
                        <h5 class="card-title text-center fs-5">Nguyễn Hữu Nam</h5>
                    </div>
                    <ul class="list-group list-group-flush">
                        <a href="my-account.html" class="list-group-item">
                            <i class="bi bi-person-circle me-2"></i>Thông tin tài khoản
                        </a>
                        <a href="#" class="list-group-item active">
                            <i class="bi bi-heart me-2"></i>Sản phẩm yêu thích
                        </a>
                        <a href="orders.html" class="list-group-item">
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
                <div class="card">
                    <div class="card-header bg-primary py-3">
                        <h5 class="mb-0 text-hover-color">
                            <i class="bi bi-heart-fill me-2"></i>
                            Danh sách sản phẩm yêu thích
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr class="text-center">
                                    <th>Ảnh sản phẩm</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td class="text-center">
                                        <img src="../../assets/images/products/product_detail.jpg"
                                             alt="Trống Tama"
                                             class="product-img">
                                    </td>
                                    <td>
                                        <a href="#" class="product-name">Trống Tama Drum 5 Pcs</a>
                                    </td>
                                    <td class="price">32.000.000đ</td>
                                    <td class="text-center">
                                        <span class="badge badge-success">Còn hàng</span>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn-action btn-cart">
                                            <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                        </button>
                                        <button class="btn-action btn-remove">
                                            <i class="bi bi-trash"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                                <!-- Thêm các sản phẩm khác tương tự -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    $(document).ready(function() {
        // Hover effect for buttons
        $('.btn-cart').hover(
            function() {
                $(this).css({
                    'background-color': 'var(--hover-color)',
                    'color': 'var(--bs-primary)'
                });
            },
            function() {
                $(this).css({
                    'background-color': 'var(--bs-primary)',
                    'color': 'var(--hover-color)'
                });
            }
        );

        // Add animation when removing items
        $('.btn-remove').click(function() {
            $(this).closest('tr').addClass('animate__animated animate__fadeOutRight');
        });
    });
</script>