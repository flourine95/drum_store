<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<style>
    .section {
        background-color: white;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        margin-bottom: 20px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .section h5 {
        font-weight: bold;
        margin-bottom: 15px;
        color: #003087;
    }

    .section label {
        font-weight: 500;
        color: #333;
    }

    .form-check-input:checked + .form-check-label {
        color: #003087;
    }

    .order-summary {
        background-color: white;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        height: fit-content;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .order-item {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }

    .order-item img {
        width: 50px;
        height: 50px;
        margin-right: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .order-item-details {
        flex-grow: 1;
    }

    .order-item-details p {
        margin: 0;
        font-size: 14px;
    }

    .order-total {
        font-weight: bold;
        color: #003087;
    }

    .btn-primary {
        background-color: #003087;
        border: none;
        color: #fff;
        width: 100%;
        border-radius: 8px;
        padding: 10px;
        font-weight: 500;
    }

    .btn-primary:hover {
        background-color: #002669;
    }

    .form-select,
    .form-control {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 8px;
        transition: border-color 0.3s ease;
    }

    .form-select:focus,
    .form-control:focus {
        border-color: #003087;
        box-shadow: 0 0 5px rgba(0, 48, 135, 0.2);
    }

    .form-control.is-invalid {
        border-color: #dc3545;
    }

    .invalid-feedback {
        color: #dc3545;
        font-size: 14px;
    }

    .form-check-label {
        font-size: 14px;
        color: #333;
    }

    .text-muted {
        color: #6c757d;
    }

    .text-primary {
        color: #003087;
    }

    .payment-method {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 10px;
        transition: border-color 0.3s ease;
    }

    .payment-method:hover {
        border-color: #003087;
    }

    .payment-method input:checked + label {
        color: #003087;
    }

    .payment-method img {
        height: 20px;
        margin-left: 5px;
    }

    .shipping-options {
        display: flex; /* Hiển thị mặc định */
        flex-direction: column;
        gap: 10px;
        margin: 10px 0px;
    }

    .shipping-options h6 {
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }

    .shipping-type {
        display: flex;
        align-items: center;
        justify-content: space-between;
        border: 2px solid #ddd;
        padding: 10px 15px;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease-in-out;
    }

    .shipping-type input {
        display: none;
    }

    .shipping-type label {
        cursor: pointer;
        font-weight: 500;
        color: #333;
        display: flex;
        justify-content: space-between;
        width: 100%;
    }

    .shipping-type .price {
        font-weight: bold;
        color: #333;
    }

    .shipping-type:hover {
        border-color: #007bff;
    }

    .shipping-type input:checked + label {
        color: #007bff;
    }

    .shipping-type input:checked + label .price {
        color: #007bff;
    }

    .shipping-type input:checked + label::before {
        content: '';
        display: inline-block;
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        border: 2px solid #007bff;
        border-radius: 8px;
        z-index: -1;
    }

    .modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
    }

    .modal-content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border-radius: 10px;
        width: 50%;
        max-height: 70vh;
        overflow-y: auto;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }

    .address-list {
        margin-bottom: 15px;
    }

    .address-item {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 10px;
        cursor: pointer;
        transition: border-color 0.3s ease;
    }

    .address-item:hover {
        border-color: #003087;
    }

    .address-item.selected {
        border-color: #003087;
        background-color: #f0f4ff;
    }

    .btn-add-address {
        background-color: #003087;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 8px;
        cursor: pointer;
    }

    .btn-add-address:hover {
        background-color: #002669;
    }

    .hidden {
        display: none;
    }
</style>

<div class="container my-5">
    <div class="row">
        <!-- Phần thông tin khách hàng và thanh toán -->
        <div class="col-md-8">
            <!-- Tài khoản -->
            <c:set var="user" value="${sessionScope.user}"/>
            <div class="section">
                <label for="email">TÀI KHOẢN</label>
                <div class="input-group mb-3">
                    <input type="email" class="form-control" id="email" value="${user.email}" readonly>
                </div>
            </div>

            <!-- Giao hàng -->
            <div class="section">
                <h5>GIAO HÀNG</h5>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="shippingMethod" id="shipToAddress"
                           value="shipToAddress" checked>
                    <label class="form-check-label" for="shipToAddress">
                        Vận chuyển
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="shippingMethod" id="pickup" value="pickup">
                    <label class="form-check-label" for="pickup">
                        Nhận hàng tại cửa hàng
                    </label>
                </div>

                <div id="shippingOptions" class="shipping-options">
                    <h6>Phương thức vận chuyển</h6>
                    <div class="shipping-type">
                        <input class="form-check-input" type="radio" name="shippingType" id="fastShipping" value="fast" checked>
                        <label class="form-check-label" for="fastShipping">
                            Vận chuyển nhanh <span class="price">30.000 đ</span>
                        </label>
                    </div>
                    <div class="shipping-type">
                        <input class="form-check-input" type="radio" name="shippingType" id="economyShipping" value="economy">
                        <label class="form-check-label" for="economyShipping">
                            Vận chuyển tiết kiệm <span class="price">50.000 đ</span>
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name">Tên (*)</label>
                        <input type="text" class="form-control" id="name" name="name"
                               value="${not empty user.fullname ? user.fullname : ''}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="phone">Điện thoại (*)</label>
                        <input type="text" class="form-control" id="phone" name="phone"
                               value="${not empty user.phone ? user.phone : ''}" required>
                    </div>
                </div>

                <c:set var="mainAddress" value="${address['mainAddress']}"/>

                <div class="row address-section" data-address-id="${not empty mainAddress[0].id ? mainAddress[0].id : ''}">
                    <div class="col-md-4 mb-3">
                        <label for="shippingProvince">Tỉnh/Thành phố <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="shippingProvince" readonly
                               value="${not empty mainAddress[0].province ? mainAddress[0].province : ''}"
                               placeholder="Tỉnh/Thành phố">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="shippingDistrict">Quận/Huyện <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="shippingDistrict" readonly
                               value="${not empty mainAddress[0].district ? mainAddress[0].district : ''}"
                               placeholder="Quận/Huyện">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="shippingWard">Phường/Xã <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="shippingWard" readonly

                               value="${not empty mainAddress[0].ward ? mainAddress[0].ward : ''}"
                               placeholder="Phường/Xã">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="shippingStreet">Địa chỉ cụ thể</label>
                    <input type="text" class="form-control" id="shippingStreet" readonly
                           value="${not empty mainAddress[0].fullAddress ? mainAddress[0].fullAddress : ''}"
                           placeholder="Căn hộ, phòng, khu, v.v.">

                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="saveInfo">
                    <label class="form-check-label" for="saveInfo">
                        Gửi chi tiết tài khoản và địa chỉ tới tin nhắn
                    </label>
                </div>

                <!-- Phần THANH TOÁN -->
                <h5>THANH TOÁN</h5>
                <p>Tất cả các giao dịch được mã hóa và an toàn.</p>
                <div class="payment-method">
                    <div>
                        <input class="form-check-input" type="radio" name="paymentMethod" id="onepay" value="onepay">
                        <label class="form-check-label" for="onepay">
                            VNPAY
                        </label>
                    </div>
                    <div>
                        <img src="https://upload.wikimedia.org/wikipedia/commons/5/53/Visa_Logo.png" alt="VNPay">
                    </div>
                </div>
                <div id="cardDetails" class="card-details" style="display: none;">
                    <div class="container">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="-252.3 356.1 163 80.9" class="zjrzY">
                            <path fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="2"
                                  d="M-108.9 404.1v30c0 1.1-.9 2-2 2H-231c-1.1 0-2-.9-2-2v-75c0-1.1.9-2 2-2h120.1c1.1 0 2 .9 2 2v37m-124.1-29h124.1"></path>
                            <circle cx="-227.8" cy="361.9" r="1.8" fill="currentColor"></circle>
                            <circle cx="-222.2" cy="361.9" r="1.8" fill="currentColor"></circle>
                            <circle cx="-216.6" cy="361.9" r="1.8" fill="currentColor"></circle>
                            <path fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="2"
                                  d="M-128.7 400.1H-92m-3.6-4.1 4 4.1-4 4.1"></path>
                        </svg>
                        <p>Sau khi nhấp vào "Hoàn tất đơn hàng", bạn sẽ được chuyển hướng đến ONEPAY để hoàn tất mua
                            hàng an toàn.</p>
                    </div>
                </div>
                <div class="payment-method">
                    <div>
                        <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cod" checked>
                        <label class="form-check-label" for="cod">
                            Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>
                </div>

                <!-- Phần ĐỊA CHỈ THANH TOÁN -->
                <h5>ĐỊA CHỈ THANH TOÁN</h5>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="billingAddress" id="sameAsShipping"
                           value="sameAsShipping" checked>
                    <label class="form-check-label" for="sameAsShipping">
                        Sử dụng địa chỉ giao hàng
                    </label>
                </div>
                <div class="form-check mb-3">
                    <input class="form-check-input" type="radio" name="billingAddress" id="differentAddress"
                           value="differentAddress">
                    <label class="form-check-label" for="differentAddress" id="showAddressPopup">
                        Sử dụng địa chỉ thanh toán khác
                    </label>
                </div>
                <div id="billingAddressFields" class="hidden">
                    <div class="mb-3">
                        <label for="billingAddressInput">Địa chỉ thanh toán (*)</label>
                        <input type="text" class="form-control" id="billingAddressInput" readonly required
                               placeholder="Chọn địa chỉ thanh toán">
                    </div>
                </div>
            </div>
        </div>

        <!-- Phần tóm tắt đơn hàng -->
        <div class="col-md-4">
            <div class="order-summary">
                <c:forEach var="item" items="${cart.items}">
                    <div class="order-item">
                        <img src="${pageContext.request.contextPath}/assets/images/products/${item.cartItem.mainImage}" alt="${item.cartItem.name}" width="100">
                        <div class="order-item-details">
                            <p>${item.cartItem.name}</p>
                            <p class="text-muted">
                                <c:if test="${not empty item.cartItem.productVariant.color}">
                                    Màu: ${item.cartItem.productVariant.color.name}
                                </c:if>
                            </p>
                        </div>
                        <span><fmt:formatNumber value="${item.cartItem.getLowestSalePrice() * item.quantity}"
                                                type="currency" currencySymbol="đ"/></span>
                    </div>
                    <hr>
                </c:forEach>

                <div class="d-flex justify-content-between mb-2">
                    <c:if test="${not empty cart.voucher}">
                        <span>MÃ GIẢM GIÁ HOẶC THẺ QUÀ TẶNG</span>
                        <span>${cart.voucher.code}</span>
                    </c:if>
                </div>

                <div class="d-flex justify-content-between mb-2">
                    <span>Tạm tính</span>
                    <span><fmt:formatNumber value="${cart.total}" type="currency" currencySymbol="đ"/></span>
                </div>

                <div class="d-flex justify-content-between mb-2">
                    <span>Vận chuyển</span>
                    <span id="shippingFee">30.000 đ</span>
                </div>

                <hr>
                <div class="d-flex justify-content-between order-total">
                    <span>TỔNG</span>
                    <span id="totalAmount">
                        <fmt:formatNumber value="${total + 30000}" type="currency" currencySymbol="đ"/>
                    </span>
                </div>
                <button class="btn btn-primary mt-3" id="submitPayment">HOÀN TẤT ĐƠN HÀNG</button>
            </div>
        </div>
    </div>
</div>

<!-- Popup danh sách địa chỉ -->
<div id="addressPopup" class="modal">
    <div class="modal-content">
        <h5>Danh sách địa chỉ</h5>
        <div id="addressList" class="address-list">
            <!-- Danh sách địa chỉ sẽ được thêm bằng JS -->
        </div>
        <button class="btn-add-address" id="addNewAddress">Thêm địa chỉ mới</button>
        <button class="btn btn-secondary mt-2" id="closePopup">Đóng</button>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Đảm bảo các giá trị mặc định được hiển thị đúng khi tải trang
        $('#shipToAddress').prop('checked', true); // Mặc định chọn "Vận chuyển"
        $('#fastShipping').prop('checked', true); // Mặc định chọn "Vận chuyển nhanh"
        $('#cod').prop('checked', true); // Mặc định chọn "Thanh toán khi nhận hàng (COD)"
        $('#sameAsShipping').prop('checked', true); // Mặc định chọn "Sử dụng địa chỉ giao hàng"
        $('#shippingOptions').show(); // Hiển thị tùy chọn vận chuyển
        $('#cardDetails').hide(); // Ẩn chi tiết thẻ tín dụng
        $('#billingAddressFields').hide(); // Ẩn trường địa chỉ thanh toán khác

        // Hiển thị/ẩn lựa chọn vận chuyển khi chọn "Vận chuyển"
        $('input[name="shippingMethod"]').change(function () {
            if ($('#shipToAddress').is(':checked')) {
                $('#shippingOptions').show();
            } else {
                $('#shippingOptions').hide();
            }
        });

        // Cập nhật phí vận chuyển và tổng tiền khi thay đổi loại vận chuyển
        $('input[name="shippingType"]').change(function () {
            const shippingFee = $(this).val() === 'fast' ? 30000 : 50000;
            const baseTotal = ${total}; // Tổng tiền ban đầu từ server
            const newTotal = baseTotal + shippingFee;

            $('#shippingFee').text(formatCurrency(shippingFee));
            $('#totalAmount').text(formatCurrency(newTotal));

            // Cập nhật viền và màu sắc
            $('.shipping-type').css('border-color', '#ddd');
            $(this).closest('.shipping-type').css('border-color', '#007bff');
        });

        // Hiển thị popup khi nhấn "Sử dụng địa chỉ thanh toán khác"
        $('#showAddressPopup').click(function () {
            $('#addressPopup').show();
        });

        // Đóng popup
        $('#closePopup').click(function () {
            $('#addressPopup').hide();
        });

        // Xử lý nút "Thêm địa chỉ mới" (giả lập)
        $('#addNewAddress').click(function () {
            alert('Chức năng thêm địa chỉ mới đang được phát triển!');
        });

        // Hiển thị/ẩn trường địa chỉ thanh toán khác
        $('input[name="billingAddress"]').change(function () {
            if ($('#differentAddress').is(':checked')) {
                $('#billingAddressFields').show();
            } else {
                $('#billingAddressFields').hide();
            }
        });

        // Hiển thị/ẩn form nhập thẻ tín dụng khi chọn ONEPAY
        $('input[name="paymentMethod"]').change(function () {
            if ($('#onepay').is(':checked')) {
                $('#cardDetails').show();
            } else {
                $('#cardDetails').hide();
            }
        });

        // Kiểm tra form khi nhấn "Hoàn tất đơn hàng"
        $(document).ready(function () {
            // Xử lý khi nhấn nút "Hoàn tất đơn hàng"
            $('#submitPayment').click(function (e) {
                // Lấy data-address-id
                const addressId = $('.address-section').data('address-id');
                if (!addressId) {
                    e.preventDefault();
                    Swal.fire({
                        title: 'Không tìm thấy ID địa chỉ giao hàng!',
                        icon: "error",
                        draggable: true
                    });
                    return;
                }

                // Lấy giá trị totalAmount
                let totalAmountText = $('#totalAmount').text().trim();
                totalAmountText = totalAmountText.replace('đ', '').replace(/\.,/g, '');
                const totalAmount = parseFloat(totalAmountText);

                if (isNaN(totalAmount)) {
                    e.preventDefault();
                    Swal.fire({
                        title: 'Không thể lấy tổng tiền!',
                        icon: "error",
                        draggable: true
                    });
                    return;
                }

                // Lấy phương thức thanh toán
                const paymentMethod = $('input[name="paymentMethod"]:checked').val();

                // Xử lý theo phương thức thanh toán
                if (paymentMethod === 'cod') {
                    handleCodPayment(addressId, totalAmount, e);
                } else if (paymentMethod === 'onepay') {
                    handleVNPayPayment(addressId, totalAmount, e);
                }
            });
        });

        // Hàm xử lý thanh toán bằng COD
        function handleCodPayment(addressId, totalAmount, event) {
            $.ajax({
                url: '/order',
                method: 'POST',
                data: {
                    action: 'cod',
                    amount: totalAmount,
                    userAddressId: addressId
                },
                success: function (response) {
                    if (response.success === "true") {
                        Swal.fire({
                            title: 'Đặt hàng thành công!',
                            text: 'Mã đơn hàng: #' + response.orderId,
                            icon: 'success',
                            draggable: true
                        }).then(() => {
                            window.location.href = '/cart';
                        });
                    } else {
                        Swal.fire({
                            title: 'Đặt hàng thất bại!',
                            text: response.message,
                            icon: 'error',
                            draggable: true
                        });
                    }
                },
                error: function (error) {
                    Swal.fire({
                        title: 'Có lỗi xảy ra!',
                        text: 'Không thể kết nối đến server.',
                        icon: 'error',
                        draggable: true
                    });
                }
            });
        }

        // Hàm xử lý thanh toán bằng VNPay
        function handleVNPayPayment(addressId, totalAmount, event) {
            const orderData = {
                addressId: addressId,
                totalAmount: totalAmount,
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
                error: function (error) {
                    Swal.fire({
                        title: 'Có lỗi xảy ra khi tạo thanh toán VNPay!',
                        icon: 'error',
                        draggable: true
                    });
                }
            });
        }
    });

    function formatCurrency(value) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(value);
    }
</script>