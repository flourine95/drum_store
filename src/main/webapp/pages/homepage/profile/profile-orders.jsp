<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
        margin-bottom: 20px;
        transition: all 0.3s ease;
    }

    .order-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
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
        object-fit: contain;
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

    .product-list {
        margin-bottom: 20px;
    }

    .product-item {
        padding: 10px 0;
        border-bottom: 1px solid #f5f5f5;
        transition: all 0.3s ease;
    }

    .product-item:last-child {
        border-bottom: none;
    }

    .product-item:hover {
        background-color: #f9f9f9;
    }

    .order-footer {
        padding-top: 15px;
        border-top: 1px dashed #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .order-footer .order-info {
        flex: 1;
    }

    .order-footer .btn-actions {
        display: flex;
        gap: 10px;
    }

    .price-base {
        color: #6c757d;
        font-size: 0.9rem;
        text-decoration: line-through;
    }

    .price-final {
        color: #dc3545;
        font-size: 1.1rem;
        font-weight: bold;
    }

    .btn-outline-yellow {
        border: 1px solid var(--bs-yellow);
        color: var(--bs-yellow);
        background-color: transparent;
    }

    .btn-outline-yellow:hover {
        background-color: var(--bs-yellow);
        color: #000;
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

            <c:forEach var="order" items="${orderHistory}" varStatus="loop">
                <div class="order-item" data-order-id= ${order.orderId}>
                    <div class="order-header">
                        <div>
                            <span class="text-muted me-3">Mã đơn: #${order.orderId}</span>
                            <span class="text-muted">Ngày đặt: ${order.orderDate}</span>
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
                        <!-- Danh sách sản phẩm -->
                        <!-- Danh sách sản phẩm -->
                        <div class="product-list">
                            <c:forEach var="item" items="${order.items}">
                                <div class="product-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-2">
                                            <img src="/assets/images/products/${item.imageUrl}" alt="Product"
                                                 class="product-img w-100">
                                        </div>
                                        <div class="col-md-4">
                                            <h6 class="mb-1 fw-bold">${item.name}</h6>
                                            <p class="text-muted mb-0">Số lượng: ${item.quantity}</p>
                                        </div>
                                        <div class="col-md-4">
                                            <p class="mb-0"><strong>Giá gốc:</strong>
                                                <span class="price-base">
                                                      <fmt:formatNumber value="${item.basePrice}" type="currency" currencySymbol="đ"/>
                                                 </span>
                                            </p>
                                            <p class="mb-0"><strong>Giá bán:</strong>
                                                <span class="price-final">
                                                    <fmt:formatNumber value="${item.finalPrice}" type="currency" currencySymbol="đ"/>
                                                 </span>
                                            </p>
                                        </div>

                                        <!-- Chỉ hiển thị nút đánh giá nếu đơn hàng đã giao -->
                                        <c:if test="${order.orderStatusText == 'DELIVERED'}">
                                            <div class="col-md-2 text-end">
                                                <button class="btn btn-sm btn-outline-yellow review-product-btn"
                                                        data-product-id="${item.variantId}"
                                                        data-order-id="${order.orderId}">
                                                    Đánh giá
                                                </button>
                                            </div>
                                        </c:if>

                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                        <!-- Thông tin tổng quan và nút hành động -->
                        <div class="order-footer">
                            <div class="order-info">
                                <p class="mb-0"><strong>Tổng tiền:</strong><span class="price-final"> <fmt:formatNumber
                                        value="${order.totalAmount}" type="currency" currencySymbol="đ"/></span></p>
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
                                <p><strong>Địa chỉ giao hàng:</strong> ${order.shippingAddress.address}</p>
                            </div>
                            <div class="btn-actions">
                                <c:if test="${order.orderStatus == 0}">
                                    <button class="btn btn-order btn-cancel cancel-order"
                                            data-order-id="${order.orderId}">
                                        <i class="bi bi-x-circle me-2"></i>Hủy đơn
                                    </button>
                                </c:if>
                                <c:if test="${order.paymentMethodText == 'BANK_TRANSFER' && order.paymentStatusText == 'PENDING'}">
                                    <button class="btn btn-order btn-pay pay-order" data-order-id="${order.orderId}"
                                            data-amount="${order.totalAmount}" data-address-id="${order.userAddressId}">
                                        <i class="bi bi-credit-card me-2"></i>Thanh toán
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Modal đánh giá -->
<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form id="reviewForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="reviewModalLabel">Đánh giá sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="productId" id="reviewProductId">
                    <input type="hidden" name="orderId" id="reviewOrderId">

                    <div class="mb-3">
                        <label class="form-label">Đánh giá sản phẩm:</label>
                        <div style="display: flex; align-items: center;">
                            <div id="starRating" class="star-rating" style="font-size: 1.8rem; cursor: pointer;"></div>
                            <div id="ratingValue" class="ms-2 text-muted">0/5 sao</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nhận xét:</label>
                        <textarea name="comment" class="form-control" rows="3" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script>
    let selectedRating = 0;

    $(document).ready(function () {
        const starContainer = document.getElementById("starRating");
        const ratingDisplay = document.getElementById("ratingValue");

        if (starContainer && ratingDisplay) {
            function createFullStars() {
                starContainer.innerHTML = '';
                for (let i = 1; i <= 5; i++) {
                    const span = document.createElement("span");
                    span.className = "fa fa-star text-secondary";
                    span.dataset.value = i;
                    span.style.cursor = "pointer";

                    span.addEventListener("mouseover", function () {
                        updateStars(parseInt(this.dataset.value));
                    });

                    span.addEventListener("click", function () {
                        selectedRating = parseInt(this.dataset.value);
                        starContainer.dataset.selected = selectedRating;
                        updateStars(selectedRating);
                    });

                    starContainer.appendChild(span);
                }

                starContainer.addEventListener("mouseleave", function () {
                    updateStars(selectedRating);
                });
            }

            function updateStars(rating) {
                const stars = starContainer.querySelectorAll("span");
                stars.forEach(star => {
                    const val = parseInt(star.dataset.value);
                    if (val <= rating) {
                        star.classList.remove("text-secondary");
                        star.classList.add("text-warning");
                    } else {
                        star.classList.remove("text-warning");
                        star.classList.add("text-secondary");
                    }
                });
                ratingDisplay.innerText = `${rating}/5 sao`;
            }

            createFullStars();
        }

        // Mở modal đánh giá
        $(".review-product-btn").click(function () {
            const productId = $(this).data("product-id");
            const orderId = $(this).data("order-id");

            $("#reviewProductId").val(productId);
            $("#reviewOrderId").val(orderId);
            $("#reviewForm textarea").val("");

            selectedRating = 0;
            if (starContainer) {
                starContainer.dataset.selected = 0;
                updateStars(0);
            }

            new bootstrap.Modal(document.getElementById("reviewModal")).show();
        });
    });

    // Gửi đánh giá
    $("#reviewForm").submit(function (e) {
        e.preventDefault();

        const productId = $("#reviewProductId").val();
        const orderId = $("#reviewOrderId").val();
        const comment = $("#reviewForm textarea").val();

        if (selectedRating === 0) {
            Swal.fire({
                title: 'Lỗi!',
                text: 'Vui lòng chọn số sao trước khi gửi đánh giá.',
                icon: 'error',
                confirmButtonText: 'OK'
            });
            return;
        }

        $.ajax({
            url: "/product/review",
            method: "POST",
            data: { productId, orderId, rating: selectedRating, comment },
            success: function (res) {
                if (res.success) {
                    Swal.fire({
                        title: 'Cảm ơn bạn!',
                        text:  res.message || 'Cảm ơn bạn đã đánh giá!',
                        icon: 'success',
                        confirmButtonText: 'Đóng'
                    });
                    const modal = bootstrap.Modal.getInstance(document.getElementById("reviewModal"));
                    if (modal) modal.hide();
                }else if(!res.success) {
                    Swal.fire({
                        title: 'Thông báo!',
                        text:  res.message|| 'Bạn đã đánh giá sản phẩm này rồi!',
                        icon: 'info',
                        confirmButtonText: 'Đóng'
                    });
                    const modal = bootstrap.Modal.getInstance(document.getElementById("reviewModal"));
                    if (modal) modal.hide();
                }
                else {
                    Swal.fire({
                        title: 'Thất bại!',
                        text: 'Gửi đánh giá thất bại.',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    });
                }
            },
            error: function () {
                Swal.fire({
                    title: 'Lỗi!',
                    text: 'Lỗi khi gửi đánh giá.',
                    icon: 'error',
                    confirmButtonText: 'OK'
                });
            }
        });
    });

    // Hủy đơn hàng
    $(".cancel-order").click(function () {
        const orderId = $(this).data("order-id");

        Swal.fire({
            title: 'Bạn có chắc chắn muốn hủy đơn hàng này?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Hủy đơn hàng',
            cancelButtonText: 'Không'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/profile',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ action: 'cancel_order', orderId }),
                    success: function (response) {
                        const Toast = Swal.mixin({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            timerProgressBar: true
                        });

                        if (response.success) {
                            Toast.fire({ icon: 'success', title: response.message || 'Đã hủy đơn hàng!' });
                            const $orderItem = $('.order-item[data-order-id="' + orderId + '"]');
                            $orderItem.addClass('animate__animated animate__fadeOutRight');
                            setTimeout(() => $orderItem.remove(), 500);
                        } else {
                            Toast.fire({ icon: 'error', title: response.message || 'Lỗi khi hủy đơn hàng!' });
                        }
                    },
                    error: function () {
                        Swal.fire({ title: 'Có lỗi xảy ra!', icon: 'error' });
                    }
                });
            }
        });
    });

    // Thanh toán VNPay
    $(".pay-order").click(function () {
        const orderId = $(this).data("order-id");
        const totalAmount = $(this).data("amount");

        $.ajax({
            url: "/payment",
            type: "POST",
            data: { orderId, amount: totalAmount },
            success: function (response) {
                if (response.success && response.paymentUrl) {
                    window.location.href = response.paymentUrl;
                } else {
                    Swal.fire({
                        title: 'Lỗi thanh toán!',
                        text: response.message || 'Không thể tạo thanh toán VNPay.',
                        icon: 'error'
                    });
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    title: 'Lỗi kết nối!',
                    text: `Lỗi: ${xhr.responseText || error}`,
                    icon: 'error'
                });
            }
        });
    });
</script>

