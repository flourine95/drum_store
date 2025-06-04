<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>
    .product-card {
        cursor: pointer;
        transition: var(--product-hover-transition);
        border-radius: var(--card-radius);
        border: var(--card-border);
        overflow: hidden;
        background-color: var(--card-bg);
        box-shadow: var(--product-card-shadow);
    }

    .product-card:hover {
        transform: var(--card-hover-transform);
        box-shadow: var(--product-hover-shadow);
    }
    
    .product-card .card-img-container {
        position: relative;
        overflow: hidden;
        height: 220px;
    }
    
    .product-card .card-img-top {
        transition: transform 0.5s ease;
        height: 100%;
        width: 100%;
    }
    
    .product-card:hover .card-img-top {
        transform: scale(1.05);
    }
    
    .badges {
        position: absolute;
        top: 12px;
        right: 12px;
        display: flex;
        flex-direction: row;
        gap: 8px;
        z-index: 1;
    }

    .discount-badge {
        position: static;
        background-color: #dc3545;
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-weight: 600;
        font-size: 0.85rem;
        order: 1;
    }
    
    .product-brand {
        font-size: 0.8rem;
        color: var(--meta-color);
        font-weight: 500;
        margin-bottom: 5px;
    }
    
    .product-title {
        font-weight: var(--product-title-weight);
        margin-bottom: 10px;
        color: var(--product-title-color);
        font-size: 1rem;
        line-height: 1.4;
        height: 2.8rem;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    
    .price-section {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
    }
    
    .current-price {
        font-weight: bold;
        color: var(--price-sale);
        font-size: 1.1rem;
        margin-right: 10px;
    }
    
    .original-price {
        text-decoration: line-through;
        color: var(--price-original);
        font-size: 0.9rem;
    }

    .product-meta {
        display: flex;
        justify-content: space-between;
        font-size: 0.9rem;
        color: #666;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .rating-section {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .stars {
        color: #ffc107;
        font-size: 0.9rem;
    }

    .rating-text {
        font-size: 0.85rem;
        color: #666;
    }

    .review-count {
        font-size: 0.85rem;
        color: #666;
    }

    .view-count {
        display: flex;
        align-items: center;
        gap: 4px;
        font-size: 0.85rem;
        color: #666;
    }

    .product-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;
        margin-top: auto;
    }

    .category-tag, .brand-tag {
        background-color: rgba(0, 0, 0, 0.05);
        color: #666;
        padding: 3px 8px;
        border-radius: 4px;
        font-size: 0.75rem;
        font-weight: 400;
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
</style>
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

<div class="container mt-5">
    <div class="row">
        <div class="col-md-3 mb-4">
            <div class="custom-box h-100 text-decoration-none">
                <div class="me-3 fs-1">
                    <i class="bi bi-credit-card"></i>
                </div>
                <div class="text-start">
                    <h5 class="fs-5 fw-medium">Trả góp</h5>
                    <p class="fs-6 text-muted mt-2">Mua hàng với lãi suất 0%</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="custom-box h-100 text-decoration-none">
                <div class="me-3 fs-1">
                    <i class="bi bi-truck"></i>
                </div>
                <div class="text-start">
                    <h5 class="fs-5 fw-medium">Vận chuyển</h5>
                    <p class="fs-6 text-muted mt-2">Chuyên nghiệp - Tốc độ</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="custom-box h-100 text-decoration-none">
                <div class="me-3 fs-1">
                    <i class="bi bi-shield-check"></i>
                </div>
                <div class="text-start">
                    <h5 class="fs-5 fw-medium">Bảo hành</h5>
                    <p class="fs-6 text-muted mt-2">Hiệu quả - Chất lượng</p>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="custom-box h-100 text-decoration-none">
                <div class="me-3 fs-1">
                    <i class="bi bi-shop"></i>
                </div>
                <div class="text-start">
                    <h5 class="fs-5 fw-medium">Đại lý</h5>
                    <p class="fs-6 text-muted mt-2">Trải rộng khắp Việt Nam</p>
                </div>
            </div>
        </div>

    </div>
</div>
<div class="container mt-5">
    <h2 class="text-start mb-4">SẢN PHẨM NỔI BẬT</h2>
    <div class="row row-cols-1 row-cols-md-3 g-4" id="featuredProducts">
        <c:forEach var="product" items="${featuredProducts}">
            <div class="col-6 col-md-4 col-lg-3 mb-4">
                <div class="card product-card h-100"
                     onclick="window.location.href='${pageContext.request.contextPath}/product/${product.id}'">
                    <div class="card-img-container">
                        <div class="badges">
                            <c:if test="${product.discountPercent > 0}">
                                <div class="discount-badge">
                                    -<fmt:formatNumber value="${product.discountPercent}" type="number" pattern="0"/>%
                                </div>
                            </c:if>
                        </div>
                        <img src="${product.mainImage}"
                             class="card-img-top object-fit-cover"
                             alt="${product.name}">
                    </div>
                    <div class="card-body d-flex flex-column">
                        <div class="product-brand">${product.brandName}</div>
                        <h5 class="product-title">${product.name}</h5>
                        <div class="price-section">
                            <c:choose>
                                <c:when test="${product.discountPercent > 0}">
                                    <span class="current-price">
                                        <fmt:formatNumber value="${product.lowestSalePrice}" type="number" pattern="#,##0 ₫"/>
                                    </span>
                                    <span class="original-price">
                                        <fmt:formatNumber value="${product.basePrice}" type="number" pattern="#,##0 ₫"/>
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="current-price">
                                        <fmt:formatNumber value="${product.basePrice}" type="number" pattern="#,##0 ₫"/>
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="product-meta">
                            <div class="rating-section">
                                <div class="stars">
                                    <c:set var="rating" value="${product.averageRating}"/>
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= Math.floor(rating)}">
                                                <i class="bi bi-star-fill"></i>
                                            </c:when>
                                            <c:when test="${i == Math.ceil(rating) && rating % 1 != 0}">
                                                <i class="bi bi-star-half"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <span class="rating-text">
                                        (${product.averageRating > 0 ? String.format("%.1f", product.averageRating) : "Chưa có đánh giá"})
                                    </span>
                                </div>
                                <span class="review-count">
                                    ${product.totalReviews} đánh giá
                                </span>
                            </div>
                            <div class="view-count">
                                <i class="bi bi-eye"></i> ${product.totalViews}
                            </div>
                        </div>

                        <div class="product-tags">
                            <span class="category-tag">${product.categoryName}</span>
                            <span class="brand-tag">${product.brandName}</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<section id="about" class="py-5 bg-primary mt-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <img src="https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/FclXZOFcv6pw/file" class="img-fluid rounded shadow" alt="About Us">
            </div>
            <div class="col-md-6">
                <h2 class="mb-4">VỀ CHÚNG TÔI</h2>
                <p>Drum Store tự hào là đơn vị hàng đầu trong lĩnh vực cung cấp nhạc cụ trống tại Việt Nam. Với
                    hơn
                    20 năm kinh nghiệm, chúng tôi cam kết mang đến những sản phẩm chất lượng nhất từ các thương
                    hiệu
                    uy tín trên thế giới.</p>
                <ul class="list-unstyled">
                    <li class="mb-2">✓ 100% sản phẩm chính hãng</li>
                    <li class="mb-2">✓ Đội ngũ tư vấn chuyên nghiệp</li>
                    <li class="mb-2">✓ Chế độ bảo hành tốt nhất</li>
                    <li class="mb-2">✓ Giao hàng toàn quốc</li>
                </ul>
            </div>
        </div>
    </div>
</section>
<script>
    const slides = [
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/Rpp7UboqEkYM/file", alt: "Slide 1"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/xHJ4mV-CzDtj/file", alt: "Slide 2"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/HPbQtwkQVAs2/file", alt: "Slide 3"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/t6rwmJ78Erol/file", alt: "Slide 4"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/lj2KpKs8aVDs/file", alt: "Slide 5"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/RhOlalq6LIrf/file", alt: "Slide 6"},
        {src: "https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/7EY_2OoIp3WC/file", alt: "Slide 7"}
    ];
    const indicatorsContainer = document.getElementById('carouselIndicators');
    const itemsContainer = document.getElementById('carouselItems');

    slides.forEach((slide, index) => {
        const indicatorButton = document.createElement('button');
        indicatorButton.type = 'button';
        indicatorButton.classList.add('carousel-indicator');
        indicatorButton.setAttribute('data-bs-target', 'pages/posts/post-detail.htmlcarouselExampleIndicators');
        indicatorButton.setAttribute('data-bs-slide-to', index);
        indicatorButton.setAttribute('aria-label', `Slide \${index + 1}`);
        if (index === 0) indicatorButton.classList.add('active');
        indicatorsContainer.appendChild(indicatorButton);

        const slideItem = document.createElement('div');
        slideItem.classList.add('carousel-item');
        if (index === 0) slideItem.classList.add('active');

        const img = document.createElement('img');
        img.src = slide.src;
        img.classList.add('d-block', 'w-100');
        img.alt = slide.alt;
        slideItem.appendChild(img);

        itemsContainer.appendChild(slideItem);
    });
</script>