<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>
    .wishlist-card {
        background: var(--text-white);
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border-radius: 15px;
        overflow: hidden;
    }

    .wishlist-item {
        padding: 20px;
        border-bottom: 1px solid #eee;
        transition: all 0.3s ease;
    }

    .wishlist-item:last-child {
        border-bottom: none;
    }

    .wishlist-item:hover {
        background-color: rgba(253, 0, 0, 0.02);
    }

    .product-img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 10px;
        transition: transform 0.3s ease;
    }

    .product-img:hover {
        transform: scale(1.05);
    }

    .product-name {
        color: var(--text-color);
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .product-name:hover {
        color: var(--hover-color);
    }

    .stock-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .in-stock {
        background-color: #28a745;
        color: var(--text-white);
    }

    .out-stock {
        background-color: var(--bs-secondary);
        color: var(--text-white);
    }

    .btn-wishlist {
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
    }

    .btn-cart {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .btn-remove {
        background-color: var(--bs-secondary);
        color: var(--text-white);
    }

    .btn-wishlist:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .btn-cart:hover {
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }
</style>

<div class="col-md-9">
    <div class="wishlist-card animate__animated animate__fadeInRight">
        <div class="card-header p-4">
            <h5 class="mb-0">
                <i class="bi bi-heart me-2"></i>
                SẢN PHẨM YÊU THÍCH
            </h5>
        </div>

        <div class="card-body p-0">
            <!-- Wishlist Item -->
            <c:forEach items = "${products}"  var = "product">
            <div class="wishlist-item">
                <div class="row align-items-center">
                    <div class="col-md-2">
                        <img src="${pageContext.request.contextPath}/assets/images/products/${product.image}" alt="Product" class="product-img w-100">
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/product/${product.id}" class="product-name">${product.name}</a>
                        <p class="text-muted mb-0 mt-2"> <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></p>
                    </div>
                    <div class="col-md-2 text-center">
                        <span class="stock-badge in-stock">Còn hàng</span>
                    </div>
                    <div class="col-md-4 text-end">
                        <button class="btn btn-wishlist btn-cart mb-2 mb-md-0">
                            <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ
                        </button>
                        <button class="btn btn-wishlist btn-remove">
                            <i class="bi bi-trash me-2"></i>Xóa
                        </button>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Animation khi xóa sản phẩm
        $('.btn-remove').click(function() {
            $(this).closest('.wishlist-item').addClass('animate__animated animate__fadeOutRight');
        });

        // Hiệu ứng hover cho ảnh sản phẩm
        $('.product-img').hover(
            function() {
                $(this).css('transform', 'scale(1.05)');
            },
            function() {
                $(this).css('transform', 'scale(1)');
            }
        );
    });
</script>