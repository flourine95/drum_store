<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-4">
    <!-- Breadcrumb và nút quay lại -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard"
                                               class="text-decoration-none">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/orders"
                                               class="text-decoration-none">Đơn hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi tiết #${order.orderId}</li>
            </ol>
        </nav>
        <a href="${pageContext.request.contextPath}/dashboard/orders" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
        </a>
    </div>

    <!-- Thẻ thông tin tổng quan -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="card bg-primary text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Tổng tiền</h5>
                            <h2 class="mt-2 mb-0" id="order-total"><fmt:formatNumber value="${order.totalAmount}"
                                                                                     type="currency"
                                                                                     currencySymbol=" đ"/></h2>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3">
                            <i class="bi bi-cash-stack fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card ${order.orderStatusText == 'DELIVERED' ? 'bg-success' : order.orderStatusText == 'CANCELLED' ? 'bg-danger' : order.orderStatusText == 'SHIPPING' ? 'bg-info' : 'bg-warning'} text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Trạng thái</h5>
                            <h2 class="mt-2 mb-0">
                                <c:choose>
                                    <c:when test="${order.orderStatusText == 'PENDING'}">Chờ xác nhận</c:when>
                                    <c:when test="${order.orderStatusText == 'CONFIRMED'}">Đã xác nhận</c:when>
                                    <c:when test="${order.orderStatusText == 'SHIPPING'}">Đang giao</c:when>
                                    <c:when test="${order.orderStatusText == 'DELIVERED'}">Đã giao</c:when>
                                    <c:when test="${order.orderStatusText == 'CANCELLED'}">Đã hủy</c:when>
                                    <c:otherwise>${order.orderStatusText}</c:otherwise>
                                </c:choose>
                            </h2>
                        </div>
                        <div class="rounded-circle ${order.orderStatusText == 'DELIVERED' ? 'bg-success-subtle' : order.orderStatusText == 'CANCELLED' ? 'bg-danger-subtle' : order.orderStatusText == 'SHIPPING' ? 'bg-info-subtle' : 'bg-warning-subtle'} p-3">
                            <i class="bi ${order.orderStatusText == 'DELIVERED' ? 'bi-check-circle' : order.orderStatusText == 'CANCELLED' ? 'bi-x-circle' : order.orderStatusText == 'SHIPPING' ? 'bi-truck' : 'bi-hourglass-split'} fs-1 ${order.orderStatusText == 'DELIVERED' ? 'text-success' : order.orderStatusText == 'CANCELLED' ? 'text-danger' : order.orderStatusText == 'SHIPPING' ? 'text-info' : 'text-warning'}"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card ${order.paymentStatusText == 'COMPLETED' ? 'bg-success' : order.paymentStatusText == 'FAILED' ? 'bg-danger' : 'bg-warning'} text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Thanh toán</h5>
                            <h2 class="mt-2 mb-0">
                                <c:choose>
                                    <c:when test="${order.paymentStatusText == 'PENDING'}">Chờ thanh toán</c:when>
                                    <c:when test="${order.paymentStatusText == 'COMPLETED'}">Đã thanh toán</c:when>
                                    <c:when test="${order.paymentStatusText == 'FAILED'}">Thanh toán thất bại</c:when>
                                    <c:otherwise>${order.paymentStatusText}</c:otherwise>
                                </c:choose>
                            </h2>
                        </div>
                        <div class="rounded-circle ${order.paymentStatusText == 'COMPLETED' ? 'bg-success-subtle' : order.paymentStatusText == 'FAILED' ? 'bg-danger-subtle' : 'bg-warning-subtle'} p-3">
                            <i class="bi ${order.paymentStatusText == 'COMPLETED' ? 'bi-credit-card-check' : order.paymentStatusText == 'FAILED' ? 'bi-credit-card-fill' : 'bi-credit-card'} fs-1 ${order.paymentStatusText == 'COMPLETED' ? 'text-success' : order.paymentStatusText == 'FAILED' ? 'text-danger' : 'text-warning'}"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-secondary text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Phương thức</h5>
                            <h2 class="mt-2 mb-0">
                                <c:choose>
                                    <c:when test="${order.paymentMethodText == 'COD'}">Tiền mặt</c:when>
                                    <c:when test="${order.paymentMethodText == 'BANK_TRANSFER'}">Chuyển khoản</c:when>
                                    <c:when test="${order.paymentMethodText == 'E_WALLET'}">Ví điện tử</c:when>
                                    <c:otherwise>${order.paymentMethodText}</c:otherwise>
                                </c:choose>
                            </h2>
                        </div>
                        <div class="rounded-circle bg-secondary-subtle p-3">
                            <i class="bi ${order.paymentMethodText == 'COD' ? 'bi-cash' : order.paymentMethodText == 'BANK_TRANSFER' ? 'bi-bank' : order.paymentMethodText == 'E_WALLET' ? 'bi-wallet2' : 'bi-question-circle'} fs-1 text-secondary"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Thông tin khách hàng và đơn hàng -->
    <div class="row g-4 mb-4">
        <!-- Thông tin đơn hàng -->
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-info-circle me-2 text-primary"></i>
                        <h5 class="mb-0">Thông tin đơn hàng</h5>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-borderless mb-0">
                            <tbody>
                            <tr>
                                <td style="width: 40%" class="fw-medium">Mã đơn hàng:</td>
                                <td><span class="badge bg-primary">#${order.orderId}</span></td>
                            </tr>
                            <tr>
                                <td class="fw-medium">Ngày đặt hàng:</td>
                                <td>${order.orderDate}</td>
                            </tr>
                            <tr>
                                <td class="fw-medium">Phương thức thanh toán:</td>
                                <td>
                                        <span class="badge ${order.paymentMethodText == 'COD' ? 'bg-danger' : order.paymentMethodText == 'BANK_TRANSFER' ? 'bg-info' : order.paymentMethodText == 'E_WALLET' ? 'bg-success' : 'bg-secondary'}">
                                            <c:choose>
                                                <c:when test="${order.paymentMethodText == 'COD'}">Tiền mặt</c:when>
                                                <c:when test="${order.paymentMethodText == 'BANK_TRANSFER'}">Chuyển khoản</c:when>
                                                <c:when test="${order.paymentMethodText == 'E_WALLET'}">Ví điện tử</c:when>
                                                <c:otherwise>${order.paymentMethodText}</c:otherwise>
                                            </c:choose>
                                        </span>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-medium">Trạng thái thanh toán:</td>
                                <td>
                                        <span class="badge ${order.paymentStatusText == 'COMPLETED' ? 'bg-success' : order.paymentStatusText == 'FAILED' ? 'bg-danger' : 'bg-warning'}">
                                            <c:choose>
                                                <c:when test="${order.paymentStatusText == 'PENDING'}">Chờ thanh toán</c:when>
                                                <c:when test="${order.paymentStatusText == 'COMPLETED'}">Đã thanh toán</c:when>
                                                <c:when test="${order.paymentStatusText == 'FAILED'}">Thanh toán thất bại</c:when>
                                                <c:otherwise>${order.paymentStatusText}</c:otherwise>
                                            </c:choose>
                                        </span>
                                </td>
                            </tr>
                            <c:if test="${not empty order.transactionId}">
                                <tr>
                                    <td class="fw-medium">Mã giao dịch:</td>
                                    <td><code>${order.transactionId}</code></td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thông tin khách hàng -->
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-person-circle me-2 text-primary"></i>
                        <h5 class="mb-0">Thông tin khách hàng</h5>
                    </div>
                </div>
                <div class="card-body">
                    <c:if test="${not empty order.shippingAddress}">
                        <div class="table-responsive">
                            <table class="table table-borderless mb-0">
                                <tbody>
                                <tr>
                                    <td style="width: 40%" class="fw-medium">Tên người nhận:</td>
                                    <td>${order.shippingAddress.fullname}</td>
                                </tr>
                                <tr>
                                    <td class="fw-medium">Số điện thoại:</td>
                                    <td>${order.shippingAddress.phone}</td>
                                </tr>
                                <tr>
                                    <td class="fw-medium">Địa chỉ:</td>
                                    <td>${order.shippingAddress.address}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty order.shippingAddress}">
                        <div class="alert alert-warning mb-0">
                            <i class="bi bi-exclamation-triangle me-2"></i>Chưa có thông tin địa chỉ giao hàng.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex align-items-center">
                <i class="bi bi-box-seam me-2 text-primary"></i>
                <h5 class="mb-0">Danh sách sản phẩm</h5>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle border">
                    <thead class="table-light">
                    <tr>
                        <th class="text-center" style="width: 50px">#</th>
                        <th style="width: 80px">Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th class="text-center" style="width: 100px">Số lượng</th>
                        <th class="text-end" style="width: 130px">Giá gốc</th>
                        <th class="text-end" style="width: 130px">Giá cuối</th>
                        <th class="text-end" style="width: 130px">Thành tiền</th>
                        <th class="text-center" style="width: 150px">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${order.items}" varStatus="loop">
                        <tr data-variant-id="${item.id}">
                            <td class="text-center">${loop.count}</td>
                            <td>
                                <c:if test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}"
                                         alt="${item.name}" class="rounded" width="60" height="60"
                                         style="object-fit: cover;">
                                </c:if>
                                <c:if test="${empty item.imageUrl}">
                                    <div class="bg-light rounded d-flex align-items-center justify-content-center"
                                         style="width: 60px; height: 60px;">
                                        <i class="bi bi-image text-secondary"></i>
                                    </div>
                                </c:if>
                            </td>
                            <td>
                                <h6 class="mb-0 text-truncate" style="max-width: 250px;">${item.name}</h6>
                            </td>
                            <td class="text-center quantity fw-medium">${item.quantity}</td>
                            <td class="text-end"><fmt:formatNumber value="${item.basePrice}" type="currency"
                                                                   currencySymbol=" đ"/></td>
                            <td class="text-end"><fmt:formatNumber value="${item.finalPrice}" type="currency"
                                                                   currencySymbol=" đ"/></td>
                            <td class="text-end fw-bold total-price"><fmt:formatNumber
                                    value="${item.quantity * item.finalPrice}" type="currency"
                                    currencySymbol=" đ"/></td>
                            <td>
                                <div class="d-flex justify-content-center gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal"
                                            data-bs-target="#editQuantityModal-${item.variantId}">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                            onclick="deleteOrderItem(${item.id}, ${order.orderId}, this)">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot class="table-light fw-bold">
                    <tr>
                        <td colspan="6" class="text-end">Tổng cộng:</td>
                        <td class="text-end" id="order-total-footer"><fmt:formatNumber value="${order.totalAmount}"
                                                                                       type="currency"
                                                                                       currencySymbol=" đ"/></td>
                        <td></td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <!-- Modals -->
    <c:forEach var="item" items="${order.items}" varStatus="loop">
        <!-- Modal chỉnh sửa số lượng -->
        <div class="modal fade" id="editQuantityModal-${item.variantId}" tabindex="-1"
             aria-labelledby="editQuantityModalLabel-${item.variantId}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow">
                    <div class="modal-header bg-light">
                        <h5 class="modal-title" id="editQuantityModalLabel-${item.variantId}">
                            <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa số lượng
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="mb-4">
                            <div class="d-flex align-items-center mb-3">
                                <c:if test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}"
                                         alt="${item.name}" class="rounded me-3" width="60" height="60"
                                         style="object-fit: cover;">
                                </c:if>
                                <c:if test="${empty item.imageUrl}">
                                    <div class="bg-light rounded d-flex align-items-center justify-content-center me-3"
                                         style="width: 60px; height: 60px;">
                                        <i class="bi bi-image text-secondary"></i>
                                    </div>
                                </c:if>
                                <div>
                                    <h6 class="mb-1">${item.name}</h6>
                                    <div class="text-muted small">Giá: <fmt:formatNumber value="${item.finalPrice}"
                                                                                         type="currency"
                                                                                         currencySymbol=" đ"/></div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="quantity-${item.id}" class="form-label fw-medium">Số lượng:</label>
                                <div class="input-group">
                                    <button type="button" class="btn btn-outline-secondary"
                                            onclick="decrementQuantity('quantity-${item.id}')"><i
                                            class="bi bi-dash"></i></button>
                                    <input type="number" class="form-control text-center" id="quantity-${item.id}"
                                           name="quantity" value="${item.quantity}" min="1" required>
                                    <button type="button" class="btn btn-outline-secondary"
                                            onclick="incrementQuantity('quantity-${item.id}')"><i
                                            class="bi bi-plus"></i></button>
                                </div>
                                <input type="hidden" id="variantId-${item.id}" value="${item.variantId}">
                                <input type="hidden" id="orderId-${item.id}" value="${order.orderId}">
                                <input type="hidden" id="finalPrice-${item.id}" value="${item.finalPrice}">
                            </div>
                            <div id="message-${item.variantId}" class="mt-2"></div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary"
                                onclick="updateQuantity(${item.id}, ${order.orderId})">
                            <i class="bi bi-check2 me-1"></i>Lưu thay đổi
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script>
    // Hàm tăng giảm số lượng trong modal
    function incrementQuantity(inputId) {
        const input = document.getElementById(inputId);
        const currentValue = parseInt(input.value) || 0;
        input.value = currentValue + 1;
    }

    function decrementQuantity(inputId) {
        const input = document.getElementById(inputId);
        const currentValue = parseInt(input.value) || 0;
        if (currentValue > 1) {
            input.value = currentValue - 1;
        }
    }

    // Hàm cập nhật số lượng sản phẩm
    function updateQuantity(orderItemId, orderId) {
        const quantity = parseInt(document.getElementById('quantity-' + orderItemId).value);
        const finalPrice = parseFloat(document.getElementById('finalPrice-' + orderItemId).value);

        if (quantity < 1) {
            Swal.fire({
                icon: 'warning',
                title: 'Lỗi',
                text: 'Số lượng phải lớn hơn hoặc bằng 1.',
                confirmButtonColor: '#3085d6'
            });
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/dashboard/orders',
            type: 'POST',
            data: {
                action: 'update-quantity',
                orderItemId: orderItemId,
                quantity: quantity,
                orderId: orderId
            },
            success: function (response) {
                if (response.status === 'success') {
                    const row = $('tr[data-variant-id="' + orderItemId + '"]');
                    row.find('.quantity').text(quantity);
                    const newTotalPrice = (quantity * finalPrice).toLocaleString('vi-VN') + ' đ';
                    row.find('.total-price').text(newTotalPrice);

                    // Cập nhật lại tổng tiền
                    if (response.total) {
                        const formattedTotal = new Intl.NumberFormat('vi-VN').format(response.total) + ' đ';
                        $('#order-total').text(formattedTotal);
                        $('#order-total-footer').text(formattedTotal);
                    }

                    // Hiển thị thông báo thành công
                    toastr.success(response.message);

                    setTimeout(function () {
                        $('#editQuantityModal-' + orderItemId).modal('hide');
                        saveBtn.innerHTML = originalBtnHtml;
                        saveBtn.disabled = false;
                    }, 500);
                } else {
                    // Khôi phục nút
                    saveBtn.innerHTML = originalBtnHtml;
                    saveBtn.disabled = false;

                    Swal.fire({
                        icon: 'error',
                        title: 'Thất bại',
                        text: response.message,
                        confirmButtonColor: '#3085d6'
                    });
                }
            },
            error: function (xhr) {
                // Khôi phục nút
                saveBtn.innerHTML = originalBtnHtml;
                saveBtn.disabled = false;

                const errorMessage = xhr.responseJSON && xhr.responseJSON.message
                    ? xhr.responseJSON.message
                    : 'Đã xảy ra lỗi khi cập nhật số lượng.';

                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: errorMessage,
                    confirmButtonColor: '#3085d6'
                });
            }
        });
    }

    // Hàm xóa sản phẩm khỏi đơn hàng
    function deleteOrderItem(orderItemId, orderId, buttonElement) {
        Swal.fire({
            title: 'Xác nhận xóa sản phẩm',
            text: "Bạn có chắc muốn xóa sản phẩm này khỏi đơn hàng?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#dc3545',
            cancelButtonColor: '#6c757d',
            confirmButtonText: '<i class="bi bi-trash me-1"></i>Xóa sản phẩm',
            cancelButtonText: 'Hủy bỏ'
        }).then((result) => {
            if (result.isConfirmed) {
                // Hiển thị loading spinner
                const button = $(buttonElement);
                const originalHtml = button.html();
                button.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>');
                button.prop('disabled', true);

                $.ajax({
                    url: `${pageContext.request.contextPath}/dashboard/orders`,
                    method: 'POST',
                    data: {
                        action: "remove-orderItem",
                        orderItemId: orderItemId,
                        orderId: orderId
                    },
                    success: function (response) {
                        // Xóa hàng khỏi bảng với hiệu ứng fade
                        $(buttonElement).closest('tr').fadeOut(300, function () {
                            $(this).remove();

                            // Cập nhật lại tổng tiền
                            if (response.total) {
                                const formattedTotal = new Intl.NumberFormat('vi-VN').format(response.total) + ' đ';
                                $('#order-total').text(formattedTotal);
                                $('#order-total-footer').text(formattedTotal);
                            }

                            // Hiển thị thông báo thành công
                            toastr.success(response.message);
                        });
                    },
                    error: function (xhr) {
                        // Khôi phục nút
                        button.html(originalHtml);
                        button.prop('disabled', false);

                        const message = xhr.responseJSON?.message || 'Không thể xóa sản phẩm.';
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi',
                            text: message,
                            confirmButtonColor: '#3085d6'
                        });
                    }
                });
            }
        });
    }
</script>
