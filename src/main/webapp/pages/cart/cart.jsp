<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>My Cart</title>
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
    <link rel="stylesheet" type="text/css" href="../../assets/css/header-footer.css">
</head>
<body>

<div class="container my-5">
    <div class="row">
        <div class=" col-md-8 col-sm-12 mt-4">
            <h5 class="">BẠN CÓ CẦN THÊM?</h5>
            <div class="divider mt-3 mb-3"></div>

            <!--slide products-->
            <div id="carouselExampleIndicators" class="carousel slide">
                <div class="carousel-indicators" id="carouselIndicators"></div>
                <div class="carousel-inner" id="carouselItems"></div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
                        data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>

            <div class="my-5 col-12">
                <h5 class="p-3" style="font-weight: bold;background-color: #F1F1F1">GIỎ HÀNG</h5>
                <div class="product">
                    <div class="product-information">
                        <div class="product-detail">
                            <img class="me-2" src="/assets/images/instruments/pearl-export-lacquer.jpg" alt="pearl">
                            <div class="detail-content">
                                <p class="product-name">PEARL Export Lacquer EXL725SP Standard</p>
                                <p class="product-price"><strong>Giá:</strong> 11.990.000 VND</p>
                                <div class="product-option">
                                    <div class="option">
                                        <strong>Màu</strong>
                                        <div class="dropdown">
                                            <button class="dropdown-toggle" id="dropdownMenuButton" type="button"
                                                    data-bs-toggle="dropdown" aria-expanded="false">Đen
                                            </button>
                                            <ul class="dropdown-menu p-3" aria-labelledby="dropdownMenuButton">
                                                <li><a class="dropdown-item" href="#" data-color="Đen">Đen</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Trắng">Trắng</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Đỏ">Đỏ</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Vàng">Vàng</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="option">
                                        <strong>Số lượng</strong>
                                        <div class="quantity-container">
                                            <div id="decreaseBtn" class="quantity-button">-</div>
                                            <input type="text" id="quantityInput" class="quantity-input" value="1"
                                                   readonly>
                                            <div id="increaseBtn" class="quantity-button">+</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="product-detail2">
                            <div class="detail-content">
                                <p class="product-price">11.990.000 VND</p>
                                <p class="product-status">còn hàng</p>
                            </div>
                            <div class="option">
                                <button class="favorite-button"><img src="../../assets/images/icon/Heart.svg" alt="">
                                </button>
                                <button class="delete-button"><img src="../../assets/images/icon/Trash_bin.svg" alt="">
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="product-divider"></div>
                <div class="product">
                    <div class="product-information">
                        <div class="product-detail">
                            <img class="me-2" src="../../assets/images/instruments/alesis-turbo.jpg" alt="digital drum">
                            <div class="detail-content">
                                <p class="product-name" id="product-name">Alesis Turbo Mesh Kit Alesis</p>
                                <p class="product-price"><strong>Giá:</strong> 7.990.000 VND</p>
                                <div class="product-option">
                                    <div class="option">
                                        <strong>Màu</strong>
                                        <div class="dropdown">
                                            <button class="dropdown-toggle" id="dropdownMenuButton1" type="button"
                                                    data-bs-toggle="dropdown" aria-expanded="false">Đen
                                            </button>
                                            <ul class="dropdown-menu p-3" aria-labelledby="dropdownMenuButton">
                                                <li><a class="dropdown-item" href="#" data-color="Đen">Đen</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Trắng">Trắng</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Đỏ">Đỏ</a></li>
                                                <li><a class="dropdown-item" href="#" data-color="Vàng">Vàng</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="option">
                                        <strong>Số lượng</strong>
                                        <div class="quantity-container">
                                            <div id="decreaseBtn1" class="quantity-button">-</div>
                                            <input type="text" id="quantityInput1" class="quantity-input" value="1"
                                                   readonly>
                                            <div id="increaseBtn1" class="quantity-button">+</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="product-detail2">
                            <div class="detail-content">
                                <p class="product-price">7.990.000 VND</p>
                                <p class="product-status">còn hàng</p>
                            </div>
                            <div class="option">
                                <button class="favorite-button"><img src="../../assets/images/icon/Heart.svg" alt="">
                                </button>
                                <button class="delete-button"><img src="../../assets/images/icon/Trash_bin.svg" alt="">
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="divider "></div>
            </div>
        </div>
        <div class="col-12 col-md-4 mt-4">
            <div class="order-container p-4">
                <h5>ĐƠN HÀNG</h5>
                <div class="divider"></div>
                <div class="voucher-container">
                    <p>NHẬP MÃ KHUYẾN MÃI</p>
                    <div class="voucher-input">
                        <input type="text" class="form-control" id="voucher-input">
                        <button>ÁP DỤNG</button>
                    </div>
                </div>
                <div class="product-divider"></div>
                <div class="calc-price">
                    <div>
                        <p>Đơn hàng</p>
                        <p>Giảm</p>
                    </div>
                    <div>
                        <p id="price" style="text-align: right">19.980.000 VND</p>
                        <p id="sale" style="text-align: right">1.000.000 VND</p>
                    </div>
                </div>
                <div class="product-divider"></div>
                <div class="total-price">
                    <p>TẠM TÍNH</p>
                    <p id="total-price" style="text-align: right;font-size: 20px">18.980.000 VND</p>
                </div>
                <button type="submit" class="payment-button">TIẾP TỤC THANH TOÁN</button>

            </div>
        </div>
    </div>
</div>

</body>
</html>
