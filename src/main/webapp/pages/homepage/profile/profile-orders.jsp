<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    .orders-card {
        background: var(--text-white);
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border-radius: 15px;
        overflow: hidden;
    }

    .order-item {
        border-bottom: 1px solid #eee;
        padding: 20px;
        transition: all 0.3s ease;
    }

    .order-item:last-child {
        border-bottom: none;
    }

    .order-item:hover {
        background-color: rgba(253, 0, 0, 0.02);
    }

    .order-header {
        padding-bottom: 15px;
        border-bottom: 1px dashed #eee;
    }

    .order-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .badge-pending {
        background-color: #ffd700;
        color: var(--hover-color);
    }

    .badge-completed {
        background-color: #28a745;
        color: var(--text-white);
    }

    .badge-cancelled {
        background-color: var(--bs-secondary);
        color: var(--text-white);
    }

    .product-img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        transition: transform 0.3s ease;
    }

    .product-img:hover {
        transform: scale(1.05);
    }

    .btn-order {
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
    }

    .btn-detail {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .btn-detail:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }
</style>

<div class="col-md-9">
    <div class="orders-card animate__animated animate__fadeInRight">
        <div class="card-header p-4">
            <h5 class="mb-0">
                <i class="bi bi-bag-check me-2"></i>
                QUẢN LÝ ĐƠN HÀNG
            </h5>
        </div>

        <div class="card-body p-0">
            <!-- Order Item -->
            <div class="order-item">
                <div class="order-header d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted me-3">Mã đơn: #ORD001</span>
                        <span class="text-muted">Ngày đặt: 20/03/2024</span>
                    </div>
                    <span class="order-badge badge-pending">Đang xử lý</span>
                </div>
                <div class="order-content mt-3">
                    <div class="row align-items-center">
                        <div class="col-md-2">
                            <img src="path_to_image" alt="Product" class="product-img w-100">
                        </div>
                        <div class="col-md-4">
                            <h6 class="mb-1">Trống Tama Drum 5 Pcs</h6>
                            <p class="text-muted mb-0">Số lượng: 1</p>
                        </div>
                        <div class="col-md-3">
                            <span class="fw-bold">32.000.000đ</span>
                        </div>
                        <div class="col-md-3 text-end">
                            <button class="btn btn-order btn-detail">
                                <i class="bi bi-eye me-2"></i>Chi tiết
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thêm các order item khác tương tự -->
        </div>
    </div>
</div>