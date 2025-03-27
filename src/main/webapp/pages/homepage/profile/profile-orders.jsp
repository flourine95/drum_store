<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

    <style>
        :root {
            --text-white: #fff;
            --hover-color: #ff4d4f;
            --bs-primary: #007bff;
            --bs-secondary: #6c757d;
        }

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
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .badge-confirmed {
            background-color: #17a2b8;
            color: var(--text-white);
        }

        .badge-shipping {
            background-color: #007bff;
            color: var(--text-white);
        }

        .badge-delivered {
            background-color: #28a745;
            color: var(--text-white);
        }

        .badge-cancelled {
            background-color: var(--bs-secondary);
            color: var(--text-white);
        }

        .payment-badge {
            padding: 4px 8px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .payment-pending {
            background-color: #ffd700;
            color: var(--hover-color);
        }

        .payment-completed {
            background-color: #28a745;
            color: var(--text-white);
        }

        .payment-failed {
            background-color: #dc3545;
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
            color: var(--text-white);
        }

        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: var(--hover-color);
            color: var(--text-white);
        }

        .btn-cancel {
            background-color: #dc3545;
            color: var(--text-white);
        }

        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: #c82333;
            color: var(--text-white);
        }

        .btn-pay {
            background-color: #28a745;
            color: var(--text-white);
        }

        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background-color: #218838;
            color: var(--text-white);
        }

        .order-content {
            margin-top: 15px;
        }

        .order-details {
            padding: 15px 0;
            border-top: 1px dashed #eee;
        }

        .order-details h6 {
            margin-top: 15px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .order-details .order-item {
            padding: 10px 0;
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
            <c:if test="${empty orderHistory}">
                <div class="order-item">
                    <p class="text-muted text-center">Bạn chưa có đơn hàng nào.</p>
                </div>
            </c:if>

            <div class="accordion" id="orderAccordion">
                <c:forEach var="order" items="${orderHistory}" varStatus="loop">
                    <div class="order-item">
                        <div class="accordion-item">
                            <div class="order-header">
                                <div>
                                    <span class="text-muted me-3">Mã đơn: #${order.orderId}</span>
                                    <span class="text-muted">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/></span>
                                </div>
                                <span class="order-badge badge-${order.orderStatusText.toLowerCase()}">
                                        <c:choose>
                                            <c:when test="${order.orderStatusText == 'PENDING'}">Đang xử lý</c:when>
                                            <c:when test="${order.orderStatusText == 'CONFIRMED'}">Đã xác nhận</c:when>
                                            <c:when test="${order.orderStatusText == 'SHIPPING'}">Đang giao</c:when>
                                            <c:when test="${order.orderStatusText == 'DELIVERED'}">Đã giao</c:when>
                                            <c:when test="${order.orderStatusText == 'CANCELLED'}">Đã hủy</c:when>
                                            <c:otherwise>Không xác định</c:otherwise>
                                        </c:choose>
                                    </span>
                            </div>

                            <div class="order-content">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <!-- Hiển thị hình ảnh sản phẩm đầu tiên trong đơn hàng -->
                                        <c:if test="${not empty order.items}">
                                            <img src="path_to_image_${order.items[0].variantId}" alt="Product" class="product-img w-100">
                                        </c:if>
                                    </div>
                                    <div class="col-md-4">
                                        <h6 class="mb-1">
                                            <c:if test="${not empty order.items}">
                                                Sản phẩm: Variant #${order.items[0].variantId}
                                            </c:if>
                                        </h6>
                                        <p class="text-muted mb-0">
                                            Số lượng: <c:if test="${not empty order.items}">${order.items[0].quantity}</c:if>
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <span class="fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="đ"/></span>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <button class="btn btn-order btn-detail" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${order.orderId}" aria-expanded="${loop.first ? 'true' : 'false'}" aria-controls="collapse${order.orderId}">
                                            <i class="bi bi-eye me-2"></i>Chi tiết
                                        </button>
                                        <c:if test="${order.orderStatus == 0}">
                                            <button class="btn btn-order btn-cancel cancel-order" data-order-id="${order.orderId}">
                                                <i class="bi bi-x-circle me-2"></i>Hủy đơn
                                            </button>
                                        </c:if>
                                        <c:if test="${order.paymentMethodText == 'VNPAY' && order.paymentStatusText == 'PENDING'}">
                                            <button class="btn btn-order btn-pay pay-order" data-order-id="${order.orderId}" data-amount="${order.totalAmount}" data-address-id="${order.userAddressId}">
                                                <i class="bi bi-credit-card me-2"></i>Thanh toán
                                            </button>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Chi tiết đơn hàng (khi mở rộng) -->
                                <div id="collapse${order.orderId}" class="accordion-collapse collapse ${loop.first ? 'show' : ''}" aria-labelledby="heading${order.orderId}" data-bs-parent="#orderAccordion">
                                    <div class="order-details">
                                        <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethodText}</p>
                                        <p><strong>Trạng thái thanh toán:</strong>
                                            <span class="payment-badge payment-${order.paymentStatusText.toLowerCase()}">
                                                    <c:choose>
                                                        <c:when test="${order.paymentStatusText == 'PENDING'}">Đang chờ</c:when>
                                                        <c:when test="${order.paymentStatusText == 'COMPLETED'}">Đã thanh toán</c:when>
                                                        <c:when test="${order.paymentStatusText == 'FAILED'}">Thất bại</c:when>
                                                        <c:otherwise>Không xác định</c:otherwise>
                                                    </c:choose>
                                                </span>
                                        </p>
                                        <c:if test="${not empty order.transactionId}">
                                            <p><strong>Mã giao dịch:</strong> ${order.transactionId}</p>
                                        </c:if>

                                        <!-- Danh sách sản phẩm -->
                                        <h6>Danh sách sản phẩm</h6>
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="order-item">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2">
                                                        <img src="path_to_image_${item.variantId}" alt="Product" class="product-img w-100">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 class="mb-1">Variant #${item.variantId}</h6>
                                                        <p class="text-muted mb-0">Số lượng: ${item.quantity}</p>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <p class="mb-0"><strong>Giá gốc:</strong> <fmt:formatNumber value="${item.basePrice}" type="currency" currencySymbol="đ"/></p>
                                                        <p class="mb-0"><strong>Giá cuối:</strong> <fmt:formatNumber value="${item.finalPrice}" type="currency" currencySymbol="đ"/></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                        <!-- Địa chỉ giao hàng -->
                                        <h6>Địa chỉ giao hàng</h6>
                                        <p><strong>Tỉnh/Thành phố:</strong> ${order.shippingProvince}</p>
                                        <p><strong>Quận/Huyện:</strong> ${order.shippingDistrict}</p>
                                        <p><strong>Phường/Xã:</strong> ${order.shippingWard}</p>
                                        <p><strong>Địa chỉ cụ thể:</strong> ${order.shippingFullAddress}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Xử lý hủy đơn hàng
        $('.cancel-order').click(function () {
            const orderId = $(this).data('order-id');
            Swal.fire({
                title: 'Bạn có chắc chắn muốn hủy đơn hàng này?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Hủy đơn hàng',
                cancelButtonText: 'Không'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '/order/cancel',
                        method: 'POST',
                        data: { orderId: orderId },
                        success: function (response) {
                            if (response.success) {
                                Swal.fire({
                                    title: 'Hủy đơn hàng thành công!',
                                    icon: 'success',
                                    draggable: true
                                }).then(() => {
                                    location.reload();
                                });
                            } else {
                                Swal.fire({
                                    title: 'Hủy đơn hàng thất bại!',
                                    text: response.message,
                                    icon: 'error',
                                    draggable: true
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                title: 'Có lỗi xảy ra!',
                                icon: 'error',
                                draggable: true
                            });
                        }
                    });
                }
            });
        });

        // Xử lý thanh toán VNPay
        $('.pay-order').click(function () {
            const orderId = $(this).data('order-id');
            const totalAmount = $(this).data('amount');
            const addressId = $(this).data('address-id');

            const orderData = {
                orderId: orderId,
                totalAmount: totalAmount,
                addressId: addressId,
                paymentMethod: 'onepay'
            };

            $.ajax({
                url: '/payment/vnpay',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(orderData),
                success: function (response) {
                    if (response.paymentUrl) {
                        window.location.href = response.paymentUrl;
                    } else {
                        Swal.fire({
                            title: 'Không thể tạo thanh toán VNPay!',
                            text: response.message || 'Có lỗi xảy ra.',
                            icon: 'error',
                            draggable: true
                        });
                    }
                },
                error: function () {
                    Swal.fire({
                        title: 'Có lỗi xảy ra khi tạo thanh toán VNPay!',
                        icon: 'error',
                        draggable: true
                    });
                }
            });
        });
    });
</script>
