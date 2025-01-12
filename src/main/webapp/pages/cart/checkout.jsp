<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thanh toán</title>
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@400;600&display=swap"
            rel="stylesheet">
    <link rel="icon" href="assets/images/logos/logo.png" type="image/png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

    <link rel="stylesheet" type="text/css" href="../../assets/css/custom.css">
    <link rel="stylesheet" href="../../assets/css/header-footer.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .order-container {
            background-color: #F1F1F1;
            max-width: 380px;
        }
        .order-container h5 {
            font-weight: bold;
            background-color: #F1F1F1;
        }
        .divider {
            display: flex;
            margin: 20px 0 20px 0;
            border-bottom: 2px solid #fd0;
        }
        .product-divider {
            display: flex;
            margin: 20px 0;
            border-bottom: 2px dashed #fd0;
        }
        .product {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            width: 100%;
            height: auto;
        }
        .product-information {
            display: flex;
            width: 100%;
        }
        .product-detail {
            position: relative;
            display: flex;
            flex-direction: column;
            width: 70%;
            line-height: 1.5rem;
            /*overflow: hidden;*/
        }
        .product-detail img {
            position: absolute;
            object-fit: cover;
            width: 30%;
            height: 100%;
        }
        .product-detail .detail-content {
            margin-left: 30%;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 16px;
        }
        .product-name {
            font-size: 1.2rem;
            font-weight: bold;
        }
        .product-price {
            color: gray;
        }
        .product-option {
            display: flex;
        }
        .option {
            margin: 0 2rem;
        }
        .option button {
            width: 120px;
            height: 40px;
            margin-top: 10px;
            border: 1px solid #ddd;
        }
        .quantity-container {
            display: flex;
            flex-wrap: nowrap;
            align-items: center;
        }
        .quantity-button {
            width: 35px;
            height: 35px;
            margin-top: 10px;
            border: 1px solid #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            user-select: none;
        }
        .quantity-button:hover {
            background-color: #e9ecef;
        }
        .quantity-input {
            width: 40px;
            height: 40px;
            margin-top: 10px;
            text-align: center;
            border: 1px solid #ddd;
            border-left: none;
            border-right: none;
        }
        .product-detail2 {
            width: 30%;
            display: flex;
            flex-direction: column;
            text-align: right;
            align-items: end;
        }
        .product-detail2 .option {
            margin: 0;
        }
        .product-detail2 .product-price {
            font-weight: bold;
            font-size: 1.2rem;
            color: #fd0;
        }
        .product-status {
            color: #fd0;
        }
        .favorite-button {
            width: 125px;
            height: 40px;
            background-image: url("../../assets/images/icon/Heart.svg");
            background-size: auto;
            background-repeat: no-repeat;
            background-position: center;
            background-color: transparent;
            cursor: pointer;
        }
        .favorite-button:hover {
            background-image: url("../../assets/images/icon/Heart_2.svg");
        }
        .delete-button {
            width: 125px;
            height: 40px;
            margin-top: 10px;
            background-image: url("../../assets/images/icon/Trash_bin.svg");
            background-size: auto;
            background-repeat: no-repeat;
            background-position: center;
            background-color: black;
            cursor: pointer;
        }
        @media (max-width: 768px) {
            .product {
                display: flex;
                flex-direction: column;
            }
            .product-information {
                display: flex;
                flex-direction: column;
                width: 100%;
            }
            .product-detail {
                position: relative;
                width: 100%;
                display: flex;
                line-height: 1rem;
            }
            .product-detail img {
                position: absolute;
                object-fit: cover;
                width: 30%;
                height: 100%;
            }
            .product-detail .detail-content {
                width: 100%;
                margin-left: 30%;
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                padding: 4px;
            }
            .product-name {
                font-size: 0.8rem;
                font-weight: bold;
            }
            .product-price {
                color: gray;
            }
            .option {
                margin: 0 1rem;
            }
            .product-option {
                display: flex;
            }
            .option button {
                width: 80px;
                height: 30px;
                border: 1px solid #ddd;
            }
            .product-detail2 {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: normal;
                justify-content: center;
            }
            .product-detail2 .detail-content {
                width: 100%;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
            }
            .product-detail2 .option {
                width: 100%;
                flex-direction: row;
            }
            .product-detail2 .detail-content .product-price {
                font-size: 1.2rem;
            }
            .product-detail2 .detail-content .product-status {

            }
        }

        .voucher-container {
            display: block;
        }
        .voucher-container p {
            font-size: 18px;
            font-weight: bold;
        }
        .voucher-input {
            display: flex;
        }
        .voucher-input input {
            width: 240px;
            height: 40px;
            margin-left: 0;
            border: none;
            border-radius: 0;
        }
        .voucher-input button {
            margin-left: 1px;
            width: 100px;
            height: 40px;
            background-color: #fd0;
            font-weight: bold;
            border: none;
        }
        .calc-price {
            display: flex;
            padding-bottom: 10px;
            padding-top: 20px;
            font-size: 16px;
            font-weight: bold;
            line-height: 0.75rem;
            color: #80808F;
            justify-content: space-between;
        }
        .total-price {
            display: flex;
            font-size: 18px;
            font-weight: bold;
            justify-content: space-between;
        }
        .payment-button {
            font-size: 22px;
            font-weight: bold;
            width: 100%;
            height: 80px;
            background-color: #fd0;
            border: none;
        }
        .product-slide {
            display: flex;
            justify-content: space-between;
            width: 50%;
            height: 100%;
        }
        .product-img-slide {
            object-fit: cover;
            width: 30%;
            height: 100%;
        }
        .product-detail-slide {
            display: flex;
            flex-direction: column;
            width: 70%;
            align-content: center;
        }
        .product-name-slide {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .product-price-slide {
            font-size: 1rem;
            color: #fd0;
            margin-bottom: 10px;
        }
        .button-add {
            font-size: 0.8rem;
            width: 6rem;
            height: 2.5rem;
            background-color: #fd0;
            font-weight: bold;
            border: none;
            border-radius: 0;
            cursor: pointer;
        }
        .button-add:hover {
            background-color: black;
            color: white;
        }

        .checkout-container {
            font-size: 1.2rem;
            padding: 0 15px;
        }
        .checkout-container h5 {
            font-weight: bold;
            padding: 10px;
            background-color: #F1F1F1;
        }
        .checkout-payment-container {
            padding: 20px;
            background-color: #F1F1F1;
            width: 100%;
        }
        .checkout-product {
            display: flex;
            margin: 10px;
            color: #808080;
        }
        .checkout-product .product-detail {
            display: flex;
            width: 50%;
            text-align: left;
            flex-direction: column;
        }
        .checkout-product .product-detail2 {
            display: flex;
            width: 50%;
            text-align: right;
        }
        .shipment-method {
            padding: 20px;
        }
        .payment-method {
            padding: 20px;
        }

        /*index page style by Nguyen Phy Long*/

        .dropdown-menu a {
            cursor: pointer;
        }

        .navbar-nav .nav-link {
            position: relative;
            padding: 0.5rem 1rem;
            margin: 0 0.2rem;
            transition: all 0.3s ease;
            color: black;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: var(--hover-color);
            transition: width 0.3s ease;
        }

        .navbar-nav .nav-link:hover::after {
            width: 100%;
        }

        .navbar-nav .nav-link:hover {
            color: whitesmoke;
        }

        .custom-box {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            text-decoration: none;
            background: linear-gradient(145deg, var(--bs-primary), #f1dc4f);
            border-radius: 8px;
            border: none;
            padding: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .custom-box:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }


        .card {
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .card-title {
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%;
        }

        .card-body .btn {
            margin-top: auto;
        }

        @media (max-width: 991.98px) {

            :root {
                --header-height: 60px;
                --bottom-nav-height: 60px;
                --primary-color: #0d6efd;
                --secondary-color: #f8f9fa;
            }

            /* Mobile Header */
            .mobile-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1030;
                background: #fff;
            }

            .mobile-banner {
                background: linear-gradient(90deg, var(--primary-color), #ffea6f);
                padding: 6px;
                text-align: center;
                font-size: 0.85rem;
                font-weight: 500;
                color: #fff;
            }

            .mobile-main-header {
                padding: 10px 15px;
                background: #fff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            }

            /* Improved Search Bar */
            .mobile-search {
                position: relative;
                margin: 12px 0 8px;
            }

            .mobile-search input {
                width: 100%;
                padding: 12px 45px 12px 20px;
                border: none;
                border-radius: 25px;
                background: var(--secondary-color);
                font-size: 0.95rem;
            }

            .mobile-search button {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                border: none;
                background: none;
                color: #666;
            }

            /* Side Menu Improvements */
            .mobile-side-menu {
                position: fixed;
                top: 0;
                left: -300px;
                width: 300px;
                height: 100vh;
                background: #fff;
                z-index: 1040;
                transition: 0.3s ease-out;
                overflow-y: auto;
            }

            .mobile-side-menu.active {
                left: 0;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            .menu-header {
                padding: 20px;
                background: var(--secondary-color);
                border-bottom: 1px solid #eee;
            }

            .menu-items {
                padding: 15px 0;
            }

            .menu-item {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: #333;
                text-decoration: none;
                transition: 0.2s;
            }

            .menu-item:hover {
                background: var(--secondary-color);
            }

            .menu-item i {
                margin-right: 15px;
                font-size: 1.2rem;
                color: var(--primary-color);
            }

            /* Bottom Navigation */
            .mobile-bottom-nav {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                background: #fff;
                box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
                z-index: 1030;
                padding: 8px 0 5px;
            }

            .mobile-nav-items {
                display: flex;
                justify-content: space-around;
            }

            .mobile-nav-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                color: #666;
                text-decoration: none;
                font-size: 0.8rem;
                padding: 5px;
            }

            .mobile-nav-item i {
                font-size: 1.4rem;
                margin-bottom: 4px;
            }

            .mobile-nav-item.active {
                color: var(--primary-color);
            }

            /* Overlay */
            .menu-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1035;
                opacity: 0;
                visibility: hidden;
                transition: 0.3s;
            }

            .menu-overlay.active {
                opacity: 1;
                visibility: visible;
            }

            /* Main Content Adjustment */
            main {
                padding-top: calc(var(--header-height) + 10px);
                padding-bottom: calc(var(--bottom-nav-height) + 10px);
            }

            /* Cart Badge */
            .cart-badge {
                position: absolute;
                top: -5px;
                right: -8px;
                background: #dc3545;
                color: white;
                border-radius: 50%;
                padding: 3px 6px;
                font-size: 0.7rem;
            }

        }
    </style>

</head>
<body>
<jsp:include page="../../includes/header.html"/>
<div class="container my-5">
    <div class="row">
        <div class="col-12 col-md-6">
            <form action="checkout" method="post">
                <div class="checkout-container">
                    <h5 class="background-color: #F1F1F1;">THÔNG TIN GIAO HÀNG</h5>
                    <div class="card-body">
                        <!-- Add New Address Button -->
                        <a href="#" class="btn btn-primary mb-3 text-black">Thêm địa chỉ mới</a>

                        <!-- Wrap Content Address using row and col -->
                        <div class="row">
                            <!-- Phần hiển thị địa chỉ -->
                            <div class="col-lg-6 col-md-12 mb-3">
                                <div class="card mb-3 address-card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <span>Nguyễn Hữu Nam (Địa chỉ mặc định)</span>
                                        <div>
                                            <button class="btn btn-link text-decoration-none btn-primary"
                                                    id="edit-btn"><i class="bi bi-pencil text-black"></i></button>
                                            <button class="btn  text-decoration-none btn-danger"><i
                                                    class="bi bi-x text-black"></i></button>
                                        </div>
                                    </div>
                                    <div class="card-body" id="address-content">
                                        <p><strong>Họ tên:</strong> Nguyễn Hữu Nam</p>
                                        <p><strong>Công ty:</strong> ABC Company</p>
                                        <p><strong>Địa chỉ:</strong> 123 Đường ABC, Phường XYZ, Quận 1, TP. Hồ Chí
                                            Minh
                                        </p>
                                        <p><strong>Điện thoại:</strong> 0375174172</p>
                                    </div>
                                    <div id="address-form" style="display: none;">
                                        <form>
                                            <div class="mb-3">
                                                <label for="ho" class="form-label">Họ</label>
                                                <input type="text" class="form-control" id="ho" placeholder="Họ">
                                            </div>
                                            <div class="mb-3">
                                                <label for="ten" class="form-label">Tên</label>
                                                <input type="text" class="form-control" id="ten" placeholder="Tên">
                                            </div>
                                            <div class="mb-3">
                                                <label for="congty" class="form-label">Công ty</label>
                                                <input type="text" class="form-control" id="congty"
                                                       placeholder="Công ty">
                                            </div>
                                            <div class="mb-3">
                                                <label for="diachi1" class="form-label">Địa chỉ 1</label>
                                                <input type="text" class="form-control" id="diachi1"
                                                       placeholder="Địa chỉ 1">
                                            </div>
                                            <div class="mb-3">
                                                <label for="diachi2" class="form-label">Địa chỉ 2</label>
                                                <input type="text" class="form-control" id="diachi2"
                                                       placeholder="Địa chỉ 2">
                                            </div>
                                            <div class="mb-3">
                                                <label for="quocgia" class="form-label">Quốc gia</label>
                                                <select class="form-select" id="quocgia">
                                                    <option selected>Chọn quốc gia</option>
                                                    <option value="Vietnam">Vietnam</option>
                                                    <option value="Khac">Khác</option>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label for="sodienthoai" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="sodienthoai"
                                                       placeholder="Số điện thoại">
                                            </div>
                                            <div class="form-check mb-3">
                                                <input type="checkbox" class="form-check-input" id="macdinh">
                                                <label class="form-check-label" for="macdinh">Đặt làm địa chỉ mặc
                                                    định</label>
                                            </div>
                                            <button type="submit" class="btn btn-dark">Sửa</button>
                                            <button type="button" class="btn btn-link" id="cancel-btn">Hủy</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <h5 class="background-color: #F1F1F1;">PHƯƠNG THỨC GIAO HÀNG</h5>
                    <div class="shipment-method">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="shipment-method" checked>
                            <label class="form-check-label" for="shipment-method">
                                Tốc độ tiêu chuẩn (từ 2 - 5 ngày làm việc)
                            </label>
                        </div>
                    </div>
                    <h5 class="background-color: #F1F1F1;">PHƯƠNG THỨC THANH TOÁN</h5>
                    <div class="payment-method">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="payment-method" id="COD" value="option1">
                            <label class="form-check-label" for="COD">
                                Thanh toán trực tiếp khi giao hàng
                            </label>
                            <img src="https://ananas.vn/wp-content/themes/ananas/fe-assets/images/svg/icon_COD.svg" alt="">
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="payment-method" id="MoMo" value="option2">
                            <label class="form-check-label" for="MoMo">
                                Thanh toán bằng MoMo
                            </label>
                            <img src="https://developers.momo.vn/v3/vi/img/logo.svg" alt="">
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-12 col-md-6">
            <div class="checkout-payment-container">
                <h5>ĐƠN HÀNG</h5>
                <div class="divider"></div>
                <div class="checkout-product">
                    <div class="product-detail">
                        <p><strong>PEARL Export Lacquer EXL725SP Standard</strong></p>
                        <p>Màu: Đen</p>
                    </div>
                    <div class="product-detail2">
                        <p>Giá: 11.990.000 VND</p>
                        <p>x1</p>
                    </div>
                </div>
                <div class="checkout-product">
                    <div class="product-detail">
                        <p><strong>Alesis Turbo Mesh Kit</strong></p>
                        <p>Màu: Đen</p>
                    </div>
                    <div class="product-detail2">
                        <p>Giá: 7.990.000 VND</p>
                        <p>x1</p>
                    </div>
                </div>
                <div class="product-divider"></div>
                <div class="calc-price">
                    <div>
                        <p>Đơn hàng</p>
                        <p>Giảm</p>
                        <p>Phí vận chuyển</p>
                    </div>
                    <div>
                        <p id="price" style="text-align: right">19.980.000 VND</p>
                        <p id="sale" style="text-align: right">1.000.000 VND</p>
                        <p id="ship" style="text-align: right">0 VND</p>
                    </div>
                </div>
                <div class="product-divider"></div>
                <div class="total-price">
                    <p>TẠM TÍNH</p>
                    <p id="total-price" style="text-align: right;font-size: 20px">19.980.000 VND</p>
                </div>

                <button type="submit" class="payment-button" name="checkout">HOÀN TẤT ĐẶT HÀNG</button>

            </div>
        </div>
    </div>
</div>

<jsp:include page="../../includes/footer.html"/>
</body>

<script>
    const adjustDesktopPadding = () => {
        if (window.innerWidth >= 992) {  // chỉ áp dụng cho desktop
            const header = document.querySelector('.fixed-top');
            const main = document.querySelector('main');
            if (header && main) {
                const headerHeight = header.offsetHeight - 85;
                main.style.paddingTop = headerHeight + 'px';
            }
        }
    };

    // Hàm điều chỉnh padding cho mobile
    const adjustMobilePadding = () => {
        if (window.innerWidth < 992) {  // chỉ áp dụng cho mobile
            const mobileHeader = document.querySelector('.mobile-header');
            const main = document.querySelector('main');
            if (mobileHeader && main) {
                const headerHeight = mobileHeader.offsetHeight;
                document.documentElement.style.setProperty('--header-height', `${headerHeight}px`);
                main.style.paddingTop = `${headerHeight}px`;
            }
        }
    };

    // Hàm chung để điều chỉnh padding dựa trên kích thước màn hình
    const adjustLayoutPadding = () => {
        const main = document.querySelector('main');
        // Reset padding trước khi áp dụng
        if (main) {
            main.style.paddingTop = '0';
        }

        // Áp dụng padding tương ứng với layout
        if (window.innerWidth >= 992) {
            adjustDesktopPadding();
        } else {
            adjustMobilePadding();
        }
    };

    // Xử lý menu mobile
    const initMobileMenu = () => {
        const menuToggle = document.getElementById('menuToggle');
        const sideMenu = document.getElementById('sideMenu');
        const menuOverlay = document.getElementById('menuOverlay');

        if (menuToggle && sideMenu && menuOverlay) {
            menuToggle.addEventListener('click', () => {
                sideMenu.classList.add('active');
                menuOverlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            });

            menuOverlay.addEventListener('click', () => {
                sideMenu.classList.remove('active');
                menuOverlay.classList.remove('active');
                document.body.style.overflow = '';
            });
        }
    };

    // Event listeners
    window.addEventListener('load', () => {
        adjustLayoutPadding();
        initMobileMenu();

        // Xử lý khi ảnh header load xong
        const headerImages = document.querySelectorAll('header img');
        headerImages.forEach(img => {
            img.addEventListener('load', adjustLayoutPadding);
        });
    });

    window.addEventListener('resize', () => {
        adjustLayoutPadding();
    });
</script>
</html>
