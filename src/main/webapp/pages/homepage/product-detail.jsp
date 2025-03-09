<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
${product}
<%--<style>--%>
<%--    /* Product Detail Page Styles */--%>
<%--    .product-detail {--%>
<%--        padding: 2rem 0;--%>
<%--    }--%>

<%--    /* Product Gallery */--%>
<%--    .product-gallery {--%>
<%--        position: relative;--%>
<%--        height: var(--gallery-height);--%>
<%--        overflow: hidden;--%>
<%--        border-radius: var(--border-radius);--%>
<%--        box-shadow: var(--shadow-md);--%>
<%--        margin-bottom: 1.5rem;--%>
<%--    }--%>

<%--    .product-main-image {--%>
<%--        width: 100%;--%>
<%--        height: 100%;--%>
<%--        object-fit: cover;--%>
<%--        transition: var(--transition-normal);--%>
<%--    }--%>

<%--    .product-main-image-container {--%>
<%--        position: relative;--%>
<%--        overflow: hidden;--%>
<%--        height: var(--gallery-height);--%>
<%--        border-radius: var(--border-radius);--%>
<%--    }--%>

<%--    .product-thumbnails {--%>
<%--        display: flex;--%>
<%--        gap: 10px;--%>
<%--        margin-top: 1rem;--%>
<%--        overflow-x: auto;--%>
<%--        padding-bottom: 10px;--%>
<%--        scrollbar-width: thin;--%>
<%--    }--%>

<%--    .product-thumbnail {--%>
<%--        width: var(--thumbnail-size);--%>
<%--        height: var(--thumbnail-size);--%>
<%--        object-fit: cover;--%>
<%--        border-radius: 8px;--%>
<%--        cursor: pointer;--%>
<%--        opacity: 0.7;--%>
<%--        transition: var(--transition-fast);--%>
<%--        border: 2px solid transparent;--%>
<%--    }--%>

<%--    .product-thumbnail:hover,--%>
<%--    .product-thumbnail.active {--%>
<%--        opacity: 1;--%>
<%--        border-color: var(--bs-primary);--%>
<%--    }--%>

<%--    /* Image zoom effect */--%>
<%--    .zoom-container {--%>
<%--        position: relative;--%>
<%--        overflow: hidden;--%>
<%--        height: 100%;--%>
<%--    }--%>

<%--    .zoom-container:hover .product-main-image {--%>
<%--        transform: scale(var(--zoom-scale));--%>
<%--    }--%>

<%--    /* Product Info */--%>
<%--    .product-title {--%>
<%--        font-size: var(--product-title-size);--%>
<%--        font-weight: var(--product-title-weight);--%>
<%--        color: var(--product-title-color);--%>
<%--        margin-bottom: 1rem;--%>
<%--    }--%>

<%--    .product-price-container {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 1rem;--%>
<%--        margin-bottom: 1.5rem;--%>
<%--    }--%>

<%--    .product-price {--%>
<%--        font-size: var(--product-price-size);--%>
<%--        font-weight: 700;--%>
<%--        color: var(--product-price-color);--%>
<%--    }--%>

<%--    .product-original-price {--%>
<%--        font-size: 1rem;--%>
<%--        color: var(--product-original-price);--%>
<%--        text-decoration: line-through;--%>
<%--    }--%>

<%--    .discount-badge {--%>
<%--        background-color: var(--product-sale-badge);--%>
<%--        color: white;--%>
<%--        padding: 0.25rem 0.5rem;--%>
<%--        border-radius: 4px;--%>
<%--        font-size: 0.875rem;--%>
<%--        font-weight: 500;--%>
<%--    }--%>

<%--    .product-meta {--%>
<%--        margin-bottom: 1.5rem;--%>
<%--        color: var(--meta-color);--%>
<%--        font-size: 0.9rem;--%>
<%--    }--%>

<%--    .product-meta-item {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 0.5rem;--%>
<%--        margin-bottom: 0.5rem;--%>
<%--    }--%>

<%--    .product-meta-item i {--%>
<%--        color: var(--bs-primary);--%>
<%--    }--%>

<%--    .product-description {--%>
<%--        margin: 1.5rem 0;--%>
<%--        line-height: 1.6;--%>
<%--    }--%>

<%--    /* Rating styles */--%>
<%--    .product-rating {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 0.5rem;--%>
<%--        margin-bottom: 1rem;--%>
<%--    }--%>

<%--    .rating-stars {--%>
<%--        color: var(--rating-star);--%>
<%--    }--%>

<%--    .rating-count {--%>
<%--        color: var(--rating-count);--%>
<%--        font-size: 0.9rem;--%>
<%--    }--%>

<%--    .featured-tag {--%>
<%--        background-color: var(--bs-primary);--%>
<%--        color: var(--text-color);--%>
<%--        padding: 0.25rem 0.75rem;--%>
<%--        border-radius: 4px;--%>
<%--        font-size: 0.8rem;--%>
<%--        font-weight: 500;--%>
<%--        margin-left: 0.5rem;--%>
<%--    }--%>

<%--    /* Color selection */--%>
<%--    .product-colors {--%>
<%--        margin-bottom: 1.5rem;--%>
<%--    }--%>

<%--    .color-options {--%>
<%--        display: flex;--%>
<%--        gap: 0.5rem;--%>
<%--        margin-top: 0.5rem;--%>
<%--    }--%>

<%--    .color-option {--%>
<%--        width: 40px;--%>
<%--        height: 40px;--%>
<%--        border-radius: 50%;--%>
<%--        cursor: pointer;--%>
<%--        border: 2px solid transparent;--%>
<%--        transition: all 0.3s ease;--%>
<%--        position: relative;--%>
<%--    }--%>

<%--    .color-option:hover {--%>
<%--        transform: scale(1.1);--%>
<%--    }--%>

<%--    .color-option.active {--%>
<%--        border-color: var(--bs-primary);--%>
<%--        transform: scale(1.1);--%>
<%--    }--%>

<%--    .color-option.out-of-stock {--%>
<%--        opacity: 0.5;--%>
<%--        cursor: not-allowed;--%>
<%--    }--%>

<%--    .color-option.out-of-stock::after {--%>
<%--        content: '';--%>
<%--        position: absolute;--%>
<%--        top: 50%;--%>
<%--        left: -2px;--%>
<%--        right: -2px;--%>
<%--        height: 2px;--%>
<%--        background-color: #dc3545;--%>
<%--        transform: rotate(-45deg);--%>
<%--    }--%>

<%--    /* Buy button */--%>
<%--    .buy-button {--%>
<%--        background-color: var(--bs-primary);--%>
<%--        color: var(--text-color);--%>
<%--        border: none;--%>
<%--        padding: 1rem 2rem;--%>
<%--        font-size: 1.1rem;--%>
<%--        font-weight: 600;--%>
<%--        border-radius: var(--border-radius);--%>
<%--        cursor: pointer;--%>
<%--        transition: var(--transition-normal);--%>
<%--        width: 100%;--%>
<%--        margin-bottom: 1rem;--%>
<%--        box-shadow: var(--shadow-sm);--%>
<%--    }--%>

<%--    .buy-button:hover {--%>
<%--        background-color: var(--hover-color);--%>
<%--        color: var(--text-white);--%>
<%--        transform: translateY(-3px);--%>
<%--        box-shadow: var(--shadow-md);--%>
<%--    }--%>

<%--    /* Stock status */--%>
<%--    .stock-status {--%>
<%--        display: inline-block;--%>
<%--        padding: 0.25rem 0.75rem;--%>
<%--        border-radius: 4px;--%>
<%--        font-size: 0.875rem;--%>
<%--        font-weight: 500;--%>
<%--        margin-bottom: 1rem;--%>
<%--    }--%>

<%--    .in-stock {--%>
<%--        background-color: rgba(0, 184, 148, 0.1);--%>
<%--        color: var(--product-stock-in);--%>
<%--    }--%>

<%--    .out-of-stock {--%>
<%--        background-color: rgba(214, 48, 49, 0.1);--%>
<%--        color: var(--product-stock-out);--%>
<%--    }--%>

<%--    /* Promotions */--%>
<%--    .promotions-section {--%>
<%--        margin-top: 3rem;--%>
<%--        padding: 1.5rem;--%>
<%--        background-color: rgba(253, 221, 0, 0.05);--%>
<%--        border-radius: var(--border-radius);--%>
<%--    }--%>

<%--    .promotion-item {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 1rem;--%>
<%--        padding: 0.75rem 0;--%>
<%--        border-bottom: 1px solid rgba(0, 0, 0, 0.05);--%>
<%--    }--%>

<%--    .promotion-item:last-child {--%>
<%--        border-bottom: none;--%>
<%--    }--%>

<%--    .promotion-icon {--%>
<%--        color: var(--bs-primary);--%>
<%--        font-size: 1.2rem;--%>
<%--    }--%>

<%--    /* Related products */--%>
<%--    .related-products {--%>
<%--        margin-top: 3rem;--%>
<%--    }--%>

<%--    .related-product-card {--%>
<%--        border-radius: var(--card-radius);--%>
<%--        overflow: hidden;--%>
<%--        box-shadow: var(--card-shadow);--%>
<%--        transition: var(--transition-normal);--%>
<%--        height: 100%;--%>
<%--    }--%>

<%--    .related-product-card:hover {--%>
<%--        transform: var(--card-hover-transform);--%>
<%--        box-shadow: var(--card-hover-shadow);--%>
<%--    }--%>

<%--    .related-product-image {--%>
<%--        width: 100%;--%>
<%--        height: 200px;--%>
<%--        object-fit: cover;--%>
<%--    }--%>

<%--    .related-product-info {--%>
<%--        padding: 1rem;--%>
<%--    }--%>

<%--    .related-product-title {--%>
<%--        font-weight: 500;--%>
<%--        margin-bottom: 0.5rem;--%>
<%--        display: -webkit-box;--%>
<%--        -webkit-line-clamp: 2;--%>
<%--        -webkit-box-orient: vertical;--%>
<%--        overflow: hidden;--%>
<%--    }--%>

<%--    /* Reviews section */--%>
<%--    .reviews-section {--%>
<%--        margin-top: 3rem;--%>
<%--    }--%>

<%--    .review-card {--%>
<%--        padding: 1.5rem;--%>
<%--        border-radius: var(--border-radius);--%>
<%--        box-shadow: var(--shadow-sm);--%>
<%--        margin-bottom: 1rem;--%>
<%--    }--%>

<%--    .review-header {--%>
<%--        display: flex;--%>
<%--        justify-content: space-between;--%>
<%--        align-items: center;--%>
<%--        margin-bottom: 1rem;--%>
<%--    }--%>

<%--    .reviewer-name {--%>
<%--        font-weight: 500;--%>
<%--    }--%>

<%--    .review-date {--%>
<%--        color: var(--meta-color);--%>
<%--        font-size: 0.875rem;--%>
<%--    }--%>

<%--    /* Animation classes */--%>
<%--    .fade-in {--%>
<%--        opacity: 0;--%>
<%--        transform: translateY(20px);--%>
<%--        transition: opacity 0.6s ease, transform 0.6s ease;--%>
<%--    }--%>

<%--    .fade-in.visible {--%>
<%--        opacity: 1;--%>
<%--        transform: translateY(0);--%>
<%--    }--%>

<%--    /* Cart animation */--%>
<%--    @keyframes addToCartAnimation {--%>
<%--        0% {--%>
<%--            transform: scale(1);--%>
<%--            opacity: 1;--%>
<%--        }--%>
<%--        50% {--%>
<%--            transform: scale(1.2);--%>
<%--            opacity: 0.8;--%>
<%--        }--%>
<%--        100% {--%>
<%--            transform: scale(0.1);--%>
<%--            opacity: 0;--%>
<%--        }--%>
<%--    }--%>

<%--    .cart-animation {--%>
<%--        position: fixed;--%>
<%--        width: 50px;--%>
<%--        height: 50px;--%>
<%--        background-color: var(--bs-primary);--%>
<%--        border-radius: 50%;--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        justify-content: center;--%>
<%--        z-index: 1000;--%>
<%--        pointer-events: none;--%>
<%--    }--%>

<%--    .cart-animation i {--%>
<%--        color: white;--%>
<%--        font-size: 1.5rem;--%>
<%--    }--%>

<%--    /* Tabs for product info */--%>
<%--    .product-tabs {--%>
<%--        margin-top: 3rem;--%>
<%--    }--%>

<%--    .nav-tabs {--%>
<%--        border-bottom: 2px solid #f1f1f1;--%>
<%--    }--%>

<%--    .nav-tabs .nav-link {--%>
<%--        border: none;--%>
<%--        color: var(--text-color);--%>
<%--        font-weight: 500;--%>
<%--        padding: 1rem 1.5rem;--%>
<%--    }--%>

<%--    .nav-tabs .nav-link.active {--%>
<%--        color: var(--bs-primary);--%>
<%--        border-bottom: 2px solid var(--bs-primary);--%>
<%--    }--%>

<%--    .tab-content {--%>
<%--        padding: 2rem 0;--%>
<%--    }--%>

<%--    /* Responsive styles */--%>
<%--    @media (max-width: 992px) {--%>
<%--        .product-gallery {--%>
<%--            height: var(--mobile-gallery-height);--%>
<%--        }--%>

<%--        .product-main-image-container {--%>
<%--            height: var(--mobile-gallery-height);--%>
<%--        }--%>
<%--    }--%>

<%--    @media (max-width: 768px) {--%>
<%--        .product-title {--%>
<%--            font-size: 1.5rem;--%>
<%--        }--%>

<%--        .product-price {--%>
<%--            font-size: 1.5rem;--%>
<%--        }--%>

<%--        .buy-button {--%>
<%--            position: fixed;--%>
<%--            bottom: 0;--%>
<%--            left: 0;--%>
<%--            width: 100%;--%>
<%--            border-radius: 0;--%>
<%--            z-index: 100;--%>
<%--        }--%>

<%--        .product-detail {--%>
<%--            padding-bottom: 70px;--%>
<%--        }--%>
<%--    }--%>

<%--    /* Lazy loading effect */--%>
<%--    .lazy-image {--%>
<%--        opacity: 0;--%>
<%--        transition: opacity 0.3s ease;--%>
<%--    }--%>

<%--    .lazy-image.loaded {--%>
<%--        opacity: 1;--%>
<%--    }--%>

<%--    /* Lightbox styles */--%>
<%--    .lightbox {--%>
<%--        position: fixed;--%>
<%--        top: 0;--%>
<%--        left: 0;--%>
<%--        width: 100%;--%>
<%--        height: 100%;--%>
<%--        background-color: var(--lightbox-bg);--%>
<%--        z-index: var(--lightbox-z-index);--%>
<%--        display: none;--%>
<%--        justify-content: center;--%>
<%--        align-items: center;--%>
<%--    }--%>

<%--    .lightbox-content {--%>
<%--        position: relative;--%>
<%--        max-width: 90%;--%>
<%--        max-height: 90%;--%>
<%--    }--%>

<%--    .lightbox-image {--%>
<%--        max-width: 100%;--%>
<%--        max-height: 90vh;--%>
<%--        object-fit: contain;--%>
<%--    }--%>

<%--    .lightbox-close {--%>
<%--        position: absolute;--%>
<%--        top: 20px;--%>
<%--        right: 20px;--%>
<%--        color: white;--%>
<%--        font-size: 2rem;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .lightbox-nav {--%>
<%--        position: absolute;--%>
<%--        top: 50%;--%>
<%--        width: 100%;--%>
<%--        display: flex;--%>
<%--        justify-content: space-between;--%>
<%--        transform: translateY(-50%);--%>
<%--    }--%>

<%--    .lightbox-nav button {--%>
<%--        background: rgba(255, 255, 255, 0.2);--%>
<%--        border: none;--%>
<%--        color: white;--%>
<%--        padding: 10px 15px;--%>
<%--        border-radius: 50%;--%>
<%--        cursor: pointer;--%>
<%--        font-size: 1.5rem;--%>
<%--    }--%>

<%--    .product-quantity {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        gap: 10px;--%>
<%--    }--%>

<%--    .quantity-selector {--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        height: 40px;--%>
<%--        border: 1px solid #ddd;--%>
<%--        border-radius: 4px;--%>
<%--    }--%>

<%--    .quantity-btn {--%>
<%--        width: 40px;--%>
<%--        height: 100%;--%>
<%--        background: #f8f8f8;--%>
<%--        border: none;--%>
<%--        font-size: 16px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

<%--    .quantity-input {--%>
<%--        width: 60px;--%>
<%--        height: 100%;--%>
<%--        text-align: center;--%>
<%--        border: none;--%>
<%--        border-left: 1px solid #ddd;--%>
<%--        border-right: 1px solid #ddd;--%>
<%--        font-size: 16px;--%>
<%--    }--%>

<%--    .action-buttons-container {--%>
<%--        display: flex;--%>
<%--        gap: 10px;--%>
<%--        margin-bottom: 20px;--%>
<%--    }--%>

<%--    .btn-add-to-wishlist, .btn-add-to-cart, .btn-buy-now {--%>
<%--        padding: 12px 20px;--%>
<%--        border-radius: 4px;--%>
<%--        font-weight: 600;--%>
<%--        cursor: pointer;--%>
<%--        display: flex;--%>
<%--        align-items: center;--%>
<%--        justify-content: center;--%>
<%--        gap: 8px;--%>
<%--        transition: all 0.3s;--%>
<%--    }--%>

<%--    .btn-add-to-wishlist {--%>
<%--        background-color: white;--%>
<%--        color: #333;--%>
<%--        border: 1px solid #ddd;--%>
<%--    }--%>

<%--    .btn-add-to-cart {--%>
<%--        background-color: #f8f8f8;--%>
<%--        color: #333;--%>
<%--        border: 1px solid #ddd;--%>
<%--        flex-grow: 1;--%>
<%--    }--%>

<%--    .btn-buy-now {--%>
<%--        background-color: #ff6b6b;--%>
<%--        color: white;--%>
<%--        border: none;--%>
<%--        flex-grow: 1;--%>
<%--    }--%>

<%--    .btn-add-to-wishlist:hover {--%>
<%--        background-color: #f8f8f8;--%>
<%--    }--%>

<%--    .btn-add-to-cart:hover {--%>
<%--        background-color: #e9e9e9;--%>
<%--    }--%>

<%--    .btn-buy-now:hover {--%>
<%--        background-color: #ff5252;--%>
<%--    }--%>

<%--    .addon-options {--%>
<%--        margin-top: 1rem;--%>
<%--    }--%>

<%--    .addon-options .form-check {--%>
<%--        padding: 0.5rem;--%>
<%--        border: 1px solid #dee2e6;--%>
<%--        border-radius: 0.25rem;--%>
<%--        margin-bottom: 0.5rem;--%>
<%--        transition: all 0.3s ease;--%>
<%--    }--%>

<%--    .addon-options .form-check:hover {--%>
<%--        background-color: #f8f9fa;--%>
<%--    }--%>

<%--    .addon-options .form-check.out-of-stock {--%>
<%--        opacity: 0.7;--%>
<%--        background-color: #f8f9fa;--%>
<%--    }--%>

<%--    .addon-options .form-check-label {--%>
<%--        display: flex;--%>
<%--        justify-content: space-between;--%>
<%--        align-items: center;--%>
<%--        width: 100%;--%>
<%--        margin-left: 0.5rem;--%>
<%--    }--%>

<%--    .variant-stock {--%>
<%--        font-size: 0.9rem;--%>
<%--        color: #6c757d;--%>
<%--        margin-left: 15px;--%>
<%--        display: block;--%>
<%--    }--%>

<%--    .variant-stock.low-stock {--%>
<%--        color: #dc3545;--%>
<%--    }--%>

<%--    .stock-text {--%>
<%--        font-weight: 500;--%>
<%--        display: inline-block;--%>
<%--    }--%>
<%--</style>--%>
<%--<div class="container product-detail">--%>
<%--    <div class="row">--%>
<%--        <!-- Cột trái - Hình ảnh sản phẩm -->--%>
<%--        <div class="col-lg-6 fade-in">--%>
<%--            <div class="product-gallery">--%>
<%--                <div class="product-main-image-container">--%>
<%--                    <div class="zoom-container">--%>
<%--                        <img src="/assets/images/products/${product.mainImage}" alt="${product.name}"--%>
<%--                             class="product-main-image lazy-image" id="mainImage">--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="product-thumbnails">--%>
<%--                <img src="/assets/images/products/${product.mainImage}" alt="Thumbnail" class="product-thumbnail active"--%>
<%--                     onclick="changeMainImage('/assets/images/products/${product.mainImage}', this)">--%>
<%--                <c:forEach items="${product.images}" var="image">--%>
<%--                    <img src="/assets/images/products/${image.image}" alt="Thumbnail"--%>
<%--                         class="product-thumbnail lazy-image"--%>
<%--                         onclick="changeMainImage('/assets/images/products/${image.image}', this)">--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>

<%--        <!-- Cột phải - Thông tin sản phẩm -->--%>
<%--        <div class="col-lg-6 fade-in">--%>
<%--            <h1 class="product-title">${product.name}</h1>--%>

<%--            <div class="product-rating">--%>
<%--                <div class="rating-stars">--%>
<%--                    <c:forEach begin="1" end="5" var="i">--%>
<%--                        <c:choose>--%>
<%--                            <c:when test="${i <= product.averageRating}">--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                            </c:when>--%>
<%--                            <c:when test="${i <= product.averageRating + 0.5}">--%>
<%--                                <i class="fas fa-star-half-alt"></i>--%>
<%--                            </c:when>--%>
<%--                            <c:otherwise>--%>
<%--                                <i class="far fa-star"></i>--%>
<%--                            </c:otherwise>--%>
<%--                        </c:choose>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--                <span class="rating-count">(${product.totalReviews} đánh giá)</span>--%>
<%--                <c:if test="${product.isFeatured}">--%>
<%--                    <span class="featured-tag">--%>
<%--                        <i class="fas fa-fire"></i> Sản phẩm nổi bật--%>
<%--                    </span>--%>
<%--                </c:if>--%>
<%--            </div>--%>

<%--            <div class="product-price-container">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${product.discountPercent > 0}">--%>
<%--                        <span class="product-price">--%>
<%--                            <fmt:formatNumber value="${product.salePrice}" type="currency" currencySymbol="₫"--%>
<%--                                              maxFractionDigits="0"/>--%>
<%--                        </span>--%>
<%--                        <span class="product-original-price">--%>
<%--                            <fmt:formatNumber value="${product.basePrice}" type="currency" currencySymbol="₫"--%>
<%--                                              maxFractionDigits="0"/>--%>
<%--                        </span>--%>
<%--                        <span class="discount-badge">-${product.discountPercent}%</span>--%>
<%--                    </c:when>--%>
<%--                    <c:otherwise>--%>
<%--                        <span class="product-price">--%>
<%--                            <fmt:formatNumber value="${product.basePrice}" type="currency" currencySymbol="₫"--%>
<%--                                              maxFractionDigits="0"/>--%>
<%--                        </span>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </div>--%>

<%--            <div class="product-meta">--%>
<%--                <div class="product-meta-item">--%>
<%--                    <i class="fas fa-tag"></i>--%>
<%--                    <span>Thương hiệu: <strong>${product.brandName}</strong></span>--%>
<%--                </div>--%>
<%--                <div class="product-meta-item">--%>
<%--                    <i class="fas fa-folder"></i>--%>
<%--                    <span>Danh mục: <strong>${product.categoryName}</strong></span>--%>
<%--                </div>--%>
<%--                <div class="product-meta-item">--%>
<%--                    <i class="fas fa-eye"></i>--%>
<%--                    <span>Lượt xem: <strong>${product.totalViews}</strong></span>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="product-description">--%>
<%--                <h5>Mô tả sản phẩm:</h5>--%>
<%--                <p>${product.description}</p>--%>
<%--            </div>--%>

<%--            <c:if test="${product.stockManagementType == 1 || product.stockManagementType == 3}">--%>
<%--                <div class="product-colors">--%>
<%--                    <h5>Màu sắc:</h5>--%>
<%--                    <div class="color-options">--%>
<%--                        <c:forEach items="${product.colors}" var="color" varStatus="status">--%>
<%--                            <div class="color-option ${status.index == 0 ? 'active' : ''}"--%>
<%--                                 style="background-color: ${color.code}"--%>
<%--                                 data-color-id="${color.id}"--%>
<%--                                 data-additional-price="${color.additionalPrice}"--%>
<%--                                 title="${color.name}">--%>
<%--                            </div>--%>
<%--                        </c:forEach>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:if>--%>

<%--            <c:if test="${product.stockManagementType == 2 || product.stockManagementType == 3}">--%>
<%--                <div class="product-addons mt-3">--%>
<%--                    <h5>Tùy chọn thêm:</h5>--%>
<%--                    <div class="addon-options">--%>
<%--                        <c:forEach items="${product.addons}" var="addon">--%>
<%--                            <div class="form-check">--%>
<%--                                <input class="form-check-input" type="checkbox"--%>
<%--                                       value="${addon.id}" id="addon${addon.id}"--%>
<%--                                       data-additional-price="${addon.additionalPrice}"--%>
<%--                                    ${addon.isDefault ? 'checked' : ''}>--%>
<%--                                <label class="form-check-label" for="addon${addon.id}">--%>
<%--                                        ${addon.name} (+<fmt:formatNumber value="${addon.additionalPrice}"--%>
<%--                                                                          type="currency" currencySymbol="₫"--%>
<%--                                                                          maxFractionDigits="0"/>)--%>
<%--                                </label>--%>
<%--                            </div>--%>
<%--                        </c:forEach>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:if>--%>

<%--            <div class="variant-stock-info mt-3">--%>
<%--                <c:choose>--%>
<%--                    <c:when test="${product.stockManagementType == 0}">--%>
<%--                        <!-- Simple product -->--%>
<%--                        <c:set var="simpleVariant" value="${product.variants[0]}"/>--%>
<%--                        <div class="stock-status ${simpleVariant.stock > 0 ? 'in-stock' : 'out-of-stock'}">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${simpleVariant.stock > 0}">--%>
<%--                                    Còn ${simpleVariant.stock} sản phẩm--%>
<%--                                </c:when>--%>
<%--                                <c:otherwise>--%>
<%--                                    Hết hàng--%>
<%--                                </c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </div>--%>
<%--                    </c:when>--%>
<%--                    <c:otherwise>--%>
<%--                        <!-- Product with variants -->--%>
<%--                        <div class="variant-stock">--%>
<%--                            <span class="stock-text"></span>--%>
<%--                        </div>--%>
<%--                    </c:otherwise>--%>
<%--                </c:choose>--%>
<%--            </div>--%>

<%--            <div class="product-quantity mt-3 mb-4">--%>
<%--                <div class="d-flex align-items-center">--%>
<%--                    <div class="me-3">--%>
<%--                        <h5 class="mb-0">Số lượng:</h5>--%>
<%--                    </div>--%>
<%--                    <div class="quantity-selector me-3">--%>
<%--                        <button type="button" class="quantity-btn minus" id="decreaseQuantity">-</button>--%>
<%--                        <input type="number" id="quantity" name="quantity" value="1" min="1" class="quantity-input">--%>
<%--                        <button type="button" class="quantity-btn plus" id="increaseQuantity">+</button>--%>
<%--                    </div>--%>
<%--                    <div class="variant-stock">--%>
<%--                        <span class="stock-text"></span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="product-actions">--%>
<%--                <div class="action-buttons-container">--%>
<%--                    <button class="btn-add-to-wishlist" id="addToWishlistBtn" data-product-id="${product.id}">--%>
<%--                        <i class="far fa-heart"></i> Yêu thích--%>
<%--                    </button>--%>

<%--                    <button class="btn-add-to-cart" id="addToCartBtn" data-product-id="${product.id}">--%>
<%--                        <i class="fas fa-shopping-cart"></i> Thêm vào giỏ--%>
<%--                    </button>--%>

<%--                    <button class="btn-buy-now" id="buyNowBtn" data-product-id="${product.id}">--%>
<%--                        <i class="fas fa-bolt"></i> Mua ngay--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- Khuyến mãi -->--%>
<%--            <c:if test="${product.discountPercent > 0}">--%>
<%--                <div class="promotions-section fade-in">--%>
<%--                    <h5>Khuyến mãi đặc biệt:</h5>--%>
<%--                    <div class="promotion-item">--%>
<%--                        <div class="promotion-icon">--%>
<%--                            <i class="fas fa-gift"></i>--%>
<%--                        </div>--%>
<%--                        <div class="promotion-content">--%>
<%--                            <div class="promotion-title">Giảm giá ${product.discountPercent}%</div>--%>
<%--                            <div class="promotion-description">Giá gốc: ${product.basePrice}đ - Giá khuyến--%>
<%--                                mãi: ${product.salePrice}đ--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </c:if>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <!-- Tabs thông tin sản phẩm -->--%>
<%--    <div class="product-tabs fade-in">--%>
<%--        <ul class="nav nav-tabs" id="productTabs" role="tablist">--%>
<%--            <li class="nav-item" role="presentation">--%>
<%--                <button class="nav-link active" id="details-tab" data-bs-toggle="tab" data-bs-target="#details"--%>
<%--                        type="button" role="tab" aria-controls="details" aria-selected="true">Chi tiết sản phẩm--%>
<%--                </button>--%>
<%--            </li>--%>
<%--            <li class="nav-item" role="presentation">--%>
<%--                <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" type="button"--%>
<%--                        role="tab" aria-controls="reviews" aria-selected="false">Đánh giá--%>
<%--                </button>--%>
<%--            </li>--%>
<%--            <li class="nav-item" role="presentation">--%>
<%--                <button class="nav-link" id="related-tab" data-bs-toggle="tab" data-bs-target="#related" type="button"--%>
<%--                        role="tab" aria-controls="related" aria-selected="false">Sản phẩm liên quan--%>
<%--                </button>--%>
<%--            </li>--%>
<%--        </ul>--%>

<%--        <div class="tab-content" id="productTabsContent">--%>
<%--            <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">--%>
<%--                <div class="row">--%>
<%--                    <div class="col-md-12">--%>
<%--                        <h4>Thông số kỹ thuật</h4>--%>
<%--                        <div class="table-responsive">--%>
<%--                            <table class="table table-striped">--%>
<%--                                <tbody>--%>
<%--                                <tr>--%>
<%--                                    <td>Thương hiệu</td>--%>
<%--                                    <td>${product.brandName}</td>--%>
<%--                                </tr>--%>
<%--                                <tr>--%>
<%--                                    <td>Danh mục</td>--%>
<%--                                    <td>${product.categoryName}</td>--%>
<%--                                </tr>--%>
<%--                                <tr>--%>
<%--                                    <td>Ngày ra mắt</td>--%>
<%--                                    <td>${product.createdAt}</td>--%>
<%--                                </tr>--%>
<%--                                </tbody>--%>
<%--                            </table>--%>
<%--                        </div>--%>

<%--                        <div class="mt-4">--%>
<%--                            <h4>Mô tả chi tiết</h4>--%>
<%--                            <div class="product-full-description">--%>
<%--                                ${product.description}--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="tab-pane fade" id="reviews" role="tabpanel" aria-labelledby="reviews-tab">--%>
<%--                <div class="reviews-section">--%>
<%--                    <h4>Đánh giá từ khách hàng</h4>--%>

<%--                    <div class="review-summary mb-4">--%>
<%--                        <div class="row align-items-center">--%>
<%--                            <div class="col-md-3 text-center">--%>
<%--                                <div class="display-4">${product.averageRating}/5</div>--%>
<%--                                <div class="rating-stars">--%>
<%--                                    <c:forEach begin="1" end="5" var="i">--%>
<%--                                        <c:choose>--%>
<%--                                            <c:when test="${i <= product.averageRating}">--%>
<%--                                                <i class="fas fa-star"></i>--%>
<%--                                            </c:when>--%>
<%--                                            <c:when test="${i <= product.averageRating + 0.5}">--%>
<%--                                                <i class="fas fa-star-half-alt"></i>--%>
<%--                                            </c:when>--%>
<%--                                            <c:otherwise>--%>
<%--                                                <i class="far fa-star"></i>--%>
<%--                                            </c:otherwise>--%>
<%--                                        </c:choose>--%>
<%--                                    </c:forEach>--%>
<%--                                </div>--%>
<%--                                <div class="text-muted">5 đánh giá</div>--%>
<%--                            </div>--%>

<%--                            <div class="col-md-9">--%>
<%--                                <!-- Giả định có một phân phối xếp hạng -->--%>
<%--                                <div class="rating-bars">--%>
<%--                                    <div class="d-flex align-items-center mb-1">--%>
<%--                                        <span class="me-2">5 <i class="fas fa-star"></i></span>--%>
<%--                                        <div class="progress flex-grow-1" style="height: 8px;">--%>
<%--                                            <div class="progress-bar bg-warning" style="width: 65%"></div>--%>
<%--                                        </div>--%>
<%--                                        <span class="ms-2">65%</span>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-flex align-items-center mb-1">--%>
<%--                                        <span class="me-2">4 <i class="fas fa-star"></i></span>--%>
<%--                                        <div class="progress flex-grow-1" style="height: 8px;">--%>
<%--                                            <div class="progress-bar bg-warning" style="width: 20%"></div>--%>
<%--                                        </div>--%>
<%--                                        <span class="ms-2">20%</span>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-flex align-items-center mb-1">--%>
<%--                                        <span class="me-2">3 <i class="fas fa-star"></i></span>--%>
<%--                                        <div class="progress flex-grow-1" style="height: 8px;">--%>
<%--                                            <div class="progress-bar bg-warning" style="width: 10%"></div>--%>
<%--                                        </div>--%>
<%--                                        <span class="ms-2">10%</span>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-flex align-items-center mb-1">--%>
<%--                                        <span class="me-2">2 <i class="fas fa-star"></i></span>--%>
<%--                                        <div class="progress flex-grow-1" style="height: 8px;">--%>
<%--                                            <div class="progress-bar bg-warning" style="width: 3%"></div>--%>
<%--                                        </div>--%>
<%--                                        <span class="ms-2">3%</span>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-flex align-items-center mb-1">--%>
<%--                                        <span class="me-2">1 <i class="fas fa-star"></i></span>--%>
<%--                                        <div class="progress flex-grow-1" style="height: 8px;">--%>
<%--                                            <div class="progress-bar bg-warning" style="width: 2%"></div>--%>
<%--                                        </div>--%>
<%--                                        <span class="ms-2">2%</span>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <!-- Đánh giá mẫu -->--%>
<%--                    <div class="review-list">--%>
<%--                        <div class="review-card fade-in">--%>
<%--                            <div class="review-header">--%>
<%--                                <div class="reviewer-name">Nguyễn Văn A</div>--%>
<%--                                <div class="review-date">12/05/2023</div>--%>
<%--                            </div>--%>
<%--                            <div class="rating-stars mb-2">--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                            </div>--%>
<%--                            <div class="review-content">--%>
<%--                                <p>Sản phẩm rất tốt, đóng gói cẩn thận, giao hàng nhanh. Tôi rất hài lòng với chất lượng--%>
<%--                                    và dịch vụ. Sẽ ủng hộ shop dài dài!</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                        <div class="review-card fade-in">--%>
<%--                            <div class="review-header">--%>
<%--                                <div class="reviewer-name">Trần Thị B</div>--%>
<%--                                <div class="review-date">05/05/2023</div>--%>
<%--                            </div>--%>
<%--                            <div class="rating-stars mb-2">--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="far fa-star"></i>--%>
<%--                            </div>--%>
<%--                            <div class="review-content">--%>
<%--                                <p>Sản phẩm khá tốt, đúng với mô tả. Chất lượng tương xứng với giá tiền. Có thể cải--%>
<%--                                    thiện thêm về bao bì đóng gói.</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                        <div class="review-card fade-in">--%>
<%--                            <div class="review-header">--%>
<%--                                <div class="reviewer-name">Lê Văn C</div>--%>
<%--                                <div class="review-date">28/04/2023</div>--%>
<%--                            </div>--%>
<%--                            <div class="rating-stars mb-2">--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star"></i>--%>
<%--                                <i class="fas fa-star-half-alt"></i>--%>
<%--                            </div>--%>
<%--                            <div class="review-content">--%>
<%--                                <p>Sản phẩm đẹp, chất lượng tốt, giao hàng nhanh. Nhân viên tư vấn nhiệt tình. Đáng đồng--%>
<%--                                    tiền bát gạo!</p>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="text-center mt-4">--%>
<%--                        <button class="btn btn-outline-primary">Xem thêm đánh giá</button>--%>
<%--                    </div>--%>

<%--                    <!-- Form đánh giá -->--%>
<%--                    <div class="review-form mt-5">--%>
<%--                        <h5>Viết đánh giá của bạn</h5>--%>
<%--                        <form>--%>
<%--                            <div class="mb-3">--%>
<%--                                <label class="form-label">Đánh giá của bạn</label>--%>
<%--                                <div class="rating-input">--%>
<%--                                    <i class="far fa-star" data-rating="1"></i>--%>
<%--                                    <i class="far fa-star" data-rating="2"></i>--%>
<%--                                    <i class="far fa-star" data-rating="3"></i>--%>
<%--                                    <i class="far fa-star" data-rating="4"></i>--%>
<%--                                    <i class="far fa-star" data-rating="5"></i>--%>
<%--                                </div>--%>
<%--                                <input type="hidden" id="rating" name="rating" value="0">--%>
<%--                            </div>--%>
<%--                            <div class="mb-3">--%>
<%--                                <label for="reviewContent" class="form-label">Nội dung đánh giá</label>--%>
<%--                                <textarea class="form-control" id="reviewContent" name="reviewContent" rows="3"--%>
<%--                                          placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này"></textarea>--%>
<%--                            </div>--%>
<%--                            <button type="submit" class="btn btn-primary">Gửi đánh giá</button>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <div class="tab-pane fade" id="related" role="tabpanel" aria-labelledby="related-tab">--%>
<%--                <h4>Sản phẩm liên quan</h4>--%>
<%--                <div class="row">--%>
<%--                    <!-- Giả định có sản phẩm liên quan -->--%>
<%--                    <div class="col-md-3 mb-4">--%>
<%--                        <div class="related-product-card fade-in">--%>
<%--                            <img src="https://via.placeholder.com/300" class="related-product-image lazy-image"--%>
<%--                                 alt="Sản phẩm liên quan 1">--%>
<%--                            <div class="related-product-info">--%>
<%--                                <h5 class="related-product-title">Sản phẩm liên quan 1</h5>--%>
<%--                                <div class="d-flex justify-content-between align-items-center">--%>
<%--                                    <span class="product-price">1.200.000₫</span>--%>
<%--                                    <div class="rating-stars small">--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="far fa-star"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-md-3 mb-4">--%>
<%--                        <div class="related-product-card fade-in">--%>
<%--                            <img src="https://via.placeholder.com/300" class="related-product-image lazy-image"--%>
<%--                                 alt="Sản phẩm liên quan 2">--%>
<%--                            <div class="related-product-info">--%>
<%--                                <h5 class="related-product-title">Sản phẩm liên quan 2</h5>--%>
<%--                                <div class="d-flex justify-content-between align-items-center">--%>
<%--                                    <span class="product-price">950.000₫</span>--%>
<%--                                    <div class="rating-stars small">--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star-half-alt"></i>--%>
<%--                                        <i class="far fa-star"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-md-3 mb-4">--%>
<%--                        <div class="related-product-card fade-in">--%>
<%--                            <img src="https://via.placeholder.com/300" class="related-product-image lazy-image"--%>
<%--                                 alt="Sản phẩm liên quan 3">--%>
<%--                            <div class="related-product-info">--%>
<%--                                <h5 class="related-product-title">Sản phẩm liên quan 3</h5>--%>
<%--                                <div class="d-flex justify-content-between align-items-center">--%>
<%--                                    <span class="product-price">1.500.000₫</span>--%>
<%--                                    <div class="rating-stars small">--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div class="col-md-3 mb-4">--%>
<%--                        <div class="related-product-card fade-in">--%>
<%--                            <img src="https://via.placeholder.com/300" class="related-product-image lazy-image"--%>
<%--                                 alt="Sản phẩm liên quan 4">--%>
<%--                            <div class="related-product-info">--%>
<%--                                <h5 class="related-product-title">Sản phẩm liên quan 4</h5>--%>
<%--                                <div class="d-flex justify-content-between align-items-center">--%>
<%--                                    <span class="product-price">850.000₫</span>--%>
<%--                                    <div class="rating-stars small">--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="fas fa-star"></i>--%>
<%--                                        <i class="far fa-star"></i>--%>
<%--                                        <i class="far fa-star"></i>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- Lightbox -->--%>
<%--<div class="lightbox" id="productLightbox">--%>
<%--    <div class="lightbox-content">--%>
<%--        <img src="" alt="Product Image" class="lightbox-image" id="lightboxImage">--%>
<%--        <div class="lightbox-nav">--%>
<%--            <button class="lightbox-prev"><i class="fas fa-chevron-left"></i></button>--%>
<%--            <button class="lightbox-next"><i class="fas fa-chevron-right"></i></button>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="lightbox-close"><i class="fas fa-times"></i></div>--%>
<%--</div>--%>

<%--<!-- Scripts -->--%>
<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        // Khai báo các hằng số cho stock management type--%>
<%--        const STOCK_MANAGEMENT = {--%>
<%--            SIMPLE: 0,--%>
<%--            COLOR_ONLY: 1,--%>
<%--            ADDON_ONLY: 2,--%>
<%--            COLOR_AND_ADDON: 3--%>
<%--        };--%>

<%--        // Khai báo các hằng số cho status--%>
<%--        const STATUS = {--%>
<%--            INACTIVE: 0,--%>
<%--            ACTIVE: 1,--%>
<%--            DELETED: 2--%>
<%--        };--%>

<%--        // Khởi tạo dữ liệu sản phẩm từ server--%>
<%--        const product = {--%>
<%--            id: ${product.id},--%>
<%--            name: "${product.name}",--%>
<%--            basePrice: ${product.basePrice},--%>
<%--            salePrice: ${product.salePrice},--%>
<%--            discountPercent: ${product.discountPercent},--%>
<%--            stockManagementType: ${product.stockManagementType},--%>
<%--            isFeatured: ${product.isFeatured},--%>
<%--            status: ${product.status},--%>
<%--            averageRating: ${product.averageRating},--%>
<%--            totalReviews: ${product.totalReviews},--%>
<%--            mainImage: "${product.mainImage}",--%>
<%--            categoryId: ${product.categoryId},--%>
<%--            categoryName: "${product.categoryName}",--%>
<%--            brandId: ${product.brandId},--%>
<%--            brandName: "${product.brandName}"--%>
<%--        };--%>

<%--        // Khởi tạo danh sách variants--%>
<%--        const variants = [--%>
<%--            <c:forEach items="${product.variants}" var="variant" varStatus="status">--%>
<%--            {--%>
<%--                id: ${variant.id},--%>
<%--                productId: ${variant.productId},--%>
<%--                colorId: ${variant.colorId != null ? variant.colorId : 'null'},--%>
<%--                addonId: ${variant.addonId != null ? variant.addonId : 'null'},--%>
<%--                stock: ${variant.stock},--%>
<%--                status: ${variant.status}--%>
<%--            }<c:if test="${!status.last}">,</c:if>--%>
<%--            </c:forEach>--%>
<%--        ];--%>

<%--        // Khởi tạo danh sách colors--%>
<%--        const colors = [--%>
<%--            <c:forEach items="${product.colors}" var="color" varStatus="status">--%>
<%--            {--%>
<%--                id: ${color.id},--%>
<%--                name: "${color.name}",--%>
<%--                code: "${color.code}",--%>
<%--                additionalPrice: ${color.additionalPrice},--%>
<%--                status: ${color.status}--%>
<%--            }<c:if test="${!status.last}">,</c:if>--%>
<%--            </c:forEach>--%>
<%--        ];--%>

<%--        // Khởi tạo danh sách addons--%>
<%--        const addons = [--%>
<%--            <c:forEach items="${product.addons}" var="addon" varStatus="status">--%>
<%--            {--%>
<%--                id: ${addon.id},--%>
<%--                name: "${addon.name}",--%>
<%--                additionalPrice: ${addon.additionalPrice},--%>
<%--                isDefault: ${addon.isDefault},--%>
<%--                status: ${addon.status}--%>
<%--            }<c:if test="${!status.last}">,</c:if>--%>
<%--            </c:forEach>--%>
<%--        ];--%>

<%--        // Hàm tìm variant phù hợp--%>
<%--        function findMatchingVariant(colorId, addonId) {--%>
<%--            return variants.find(v => --%>
<%--                (colorId === null || v.colorId === colorId) &&--%>
<%--                (addonId === null || v.addonId === addonId) &&--%>
<%--                v.status === STATUS.ACTIVE--%>
<%--            );--%>
<%--        }--%>

<%--        // Hàm cập nhật hiển thị stock--%>
<%--        function updateStockDisplay(variant) {--%>
<%--            if (!variant || variant.status !== STATUS.ACTIVE) {--%>
<%--                $('.stock-text').text('Không có sản phẩm phù hợp');--%>
<%--                $('.variant-stock').addClass('out-of-stock');--%>
<%--                $('#addToCartBtn, #buyNowBtn').prop('disabled', true);--%>
<%--                return;--%>
<%--            }--%>

<%--            const stock = variant.stock;--%>
<%--            $('.stock-text').text(`Còn ${stock} sản phẩm`);--%>
<%--            $('.variant-stock').toggleClass('out-of-stock', stock <= 0);--%>
<%--            $('#addToCartBtn, #buyNowBtn').prop('disabled', stock <= 0);--%>

<%--            $('#quantity').attr('max', stock);--%>
<%--            if (parseInt($('#quantity').val()) > stock) {--%>
<%--                $('#quantity').val(1);--%>
<%--            }--%>
<%--        }--%>

<%--        // Khởi tạo hiển thị ban đầu--%>
<%--        if (product.stockManagementType === STOCK_MANAGEMENT.SIMPLE) {--%>
<%--            updateStockDisplay(variants[0]);--%>
<%--        } else {--%>
<%--            const firstColor = $('.color-option').first();--%>
<%--            if (firstColor.length) {--%>
<%--                firstColor.addClass('active');--%>
<%--                const variant = findMatchingVariant(--%>
<%--                    parseInt(firstColor.data('color-id')), --%>
<%--                    null--%>
<%--                );--%>
<%--                updateStockDisplay(variant);--%>
<%--            }--%>
<%--        }--%>

<%--        // Cập nhật giá--%>
<%--        function updateTotalPrice() {--%>
<%--            let totalPrice = product.basePrice;--%>

<%--            // Thêm giá của màu sắc được chọn--%>
<%--            const selectedColor = colors.find(c => --%>
<%--                c.id === parseInt($('.color-option.active').data('color-id'))--%>
<%--            );--%>
<%--            if (selectedColor) {--%>
<%--                totalPrice += selectedColor.additionalPrice;--%>
<%--            }--%>

<%--            // Thêm giá của các addon được chọn--%>
<%--            $('.addon-options input[type="checkbox"]:checked').each(function () {--%>
<%--                const addonId = parseInt($(this).val());--%>
<%--                const addon = addons.find(a => a.id === addonId);--%>
<%--                if (addon) {--%>
<%--                    totalPrice += addon.additionalPrice;--%>
<%--                }--%>
<%--            });--%>

<%--            // Áp dụng giảm giá--%>
<%--            if (product.discountPercent > 0) {--%>
<%--                totalPrice = totalPrice * (1 - product.discountPercent / 100);--%>
<%--            }--%>

<%--            // Cập nhật hiển thị giá--%>
<%--            $('.product-price').text(--%>
<%--                new Intl.NumberFormat('vi-VN', {--%>
<%--                    style: 'currency',--%>
<%--                    currency: 'VND'--%>
<%--                }).format(totalPrice)--%>
<%--            );--%>
<%--        }--%>

<%--        // Xử lý khi chọn màu--%>
<%--        $('.color-option').on('click', function () {--%>
<%--            if ($(this).hasClass('out-of-stock')) return;--%>

<%--            $('.color-option').removeClass('active');--%>
<%--            $(this).addClass('active');--%>

<%--            const colorId = parseInt($(this).data('color-id'));--%>
<%--            const selectedAddons = $('.addon-options input:checked').map(function () {--%>
<%--                return parseInt($(this).val());--%>
<%--            }).get();--%>

<%--            const variant = findMatchingVariant(--%>
<%--                colorId, --%>
<%--                selectedAddons.length ? selectedAddons[0] : null--%>
<%--            );--%>
<%--            updateStockDisplay(variant);--%>
<%--            updateTotalPrice();--%>
<%--        });--%>

<%--        // Xử lý khi chọn addon--%>
<%--        $('.addon-options input[type="checkbox"]').on('change', function () {--%>
<%--            const colorId = parseInt($('.color-option.active').data('color-id'));--%>
<%--            const addonId = $(this).is(':checked') ? parseInt($(this).val()) : null;--%>

<%--            // Chỉ cho phép chọn một addon--%>
<%--            if ($(this).is(':checked')) {--%>
<%--                $('.addon-options input[type="checkbox"]').not(this).prop('checked', false);--%>
<%--            }--%>

<%--            const variant = findMatchingVariant(colorId, addonId);--%>
<%--            updateStockDisplay(variant);--%>
<%--            updateTotalPrice();--%>
<%--        });--%>

<%--        // Khởi tạo hiển thị ban đầu--%>
<%--        const stockManagementType = ${product.stockManagementType};--%>
<%--        if (stockManagementType === 0) {--%>
<%--            // Simple product--%>
<%--            updateStockDisplay(variants[0]);--%>
<%--        } else {--%>
<%--            // Product with variants--%>
<%--            const firstColor = $('.color-option').first();--%>
<%--            if (firstColor.length) {--%>
<%--                firstColor.addClass('active');--%>
<%--                const variant = findMatchingVariant(firstColor.data('color-id'), null);--%>
<%--                updateStockDisplay(variant);--%>
<%--            }--%>
<%--        }--%>

<%--        // Khai báo các biến chung--%>
<%--        const basePrice = ${product.basePrice};--%>
<%--        const discountPercent = ${product.discountPercent};--%>
<%--        let currentPrice = ${product.salePrice};--%>

<%--        // Xử lý wishlist--%>
<%--        $('#addToWishlistBtn').on('click', function () {--%>
<%--            const productId = $(this).data('product-id');--%>
<%--            alert('Đã thêm sản phẩm vào danh sách yêu thích!');--%>
<%--        });--%>

<%--        // Xử lý thêm vào giỏ hàng--%>
<%--        $('#addToCartBtn').on('click', function () {--%>
<%--            const productId = $(this).data('product-id');--%>
<%--            const quantity = $('#quantity').val();--%>
<%--            alert('Đã thêm ' + quantity + ' sản phẩm vào giỏ hàng!');--%>
<%--        });--%>

<%--        // Xử lý mua ngay--%>
<%--        $('#buyNowBtn').on('click', function () {--%>
<%--            const productId = $(this).data('product-id');--%>
<%--            const quantity = $('#quantity').val();--%>
<%--            const selectedColor = $('.color-option.active').attr('title') || '';--%>

<%--            $.ajax({--%>
<%--                url: '/cart?action=add',--%>
<%--                method: 'POST',--%>
<%--                data: {--%>
<%--                    productId: productId,--%>
<%--                    quantity: quantity,--%>
<%--                    color: selectedColor--%>
<%--                },--%>
<%--                success: function (data) {--%>
<%--                    console.log(data);--%>
<%--                    alert('Đang chuyển đến trang thanh toán...');--%>
<%--                },--%>
<%--                error: function (error) {--%>
<%--                    console.error('Error:', error);--%>
<%--                    alert('Có lỗi xảy ra khi thêm vào giỏ hàng');--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>

<%--        // Xử lý đổi ảnh chính--%>
<%--        window.changeMainImage = function (src, thumbnail) {--%>
<%--            $('#mainImage').attr('src', src);--%>
<%--            $('.product-thumbnail').removeClass('active');--%>
<%--            $(thumbnail).addClass('active');--%>
<%--        };--%>

<%--        // Lightbox functionality--%>
<%--        $('#mainImage').on('click', function () {--%>
<%--            $('#lightboxImage').attr('src', $(this).attr('src'));--%>
<%--            $('#productLightbox').css('display', 'flex');--%>
<%--            $('body').css('overflow', 'hidden');--%>
<%--        });--%>

<%--        $('.lightbox-close').on('click', function () {--%>
<%--            $('#productLightbox').hide();--%>
<%--            $('body').css('overflow', '');--%>
<%--        });--%>

<%--        $('#productLightbox').on('click', function (e) {--%>
<%--            if (e.target === this) {--%>
<%--                $(this).hide();--%>
<%--                $('body').css('overflow', '');--%>
<%--            }--%>
<%--        });--%>

<%--        // Lightbox navigation--%>
<%--        if ($('.product-thumbnail').length > 0) {--%>
<%--            let currentIndex = 0;--%>
<%--            const thumbnails = $('.product-thumbnail');--%>

<%--            $('.lightbox-prev').on('click', function () {--%>
<%--                currentIndex = (currentIndex - 1 + thumbnails.length) % thumbnails.length;--%>
<%--                $('#lightboxImage').attr('src', $(thumbnails[currentIndex]).attr('src'));--%>
<%--            });--%>

<%--            $('.lightbox-next').on('click', function () {--%>
<%--                currentIndex = (currentIndex + 1) % thumbnails.length;--%>
<%--                $('#lightboxImage').attr('src', $(thumbnails[currentIndex]).attr('src'));--%>
<%--            });--%>
<%--        }--%>

<%--        // Rating functionality--%>
<%--        $('.rating-input i').hover(--%>
<%--            function () {--%>
<%--                const rating = $(this).data('rating');--%>
<%--                $('.rating-input i').each(function () {--%>
<%--                    if ($(this).data('rating') <= rating) {--%>
<%--                        $(this).removeClass('far').addClass('fas');--%>
<%--                    } else {--%>
<%--                        $(this).removeClass('fas').addClass('far');--%>
<%--                    }--%>
<%--                });--%>
<%--            },--%>
<%--            function () {--%>
<%--                const selectedRating = $('.rating-input').data('selectedRating') || 0;--%>
<%--                $('.rating-input i').each(function () {--%>
<%--                    if ($(this).data('rating') <= selectedRating) {--%>
<%--                        $(this).removeClass('far').addClass('fas');--%>
<%--                    } else {--%>
<%--                        $(this).removeClass('fas').addClass('far');--%>
<%--                    }--%>
<%--                });--%>
<%--            }--%>
<%--        ).click(function () {--%>
<%--            const rating = $(this).data('rating');--%>
<%--            $('.rating-input').data('selectedRating', rating);--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>
