<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<style>
    .card-body {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        height: 100%;
    }

    .card-body .btn {
        margin-top: auto;
    }

    .page-link {
        color: var(--bs-primary);
    }

    .page-item.active .page-link {
        background-color: var(--bs-primary);
        border-color: var(--bs-primary);
        color: white;
    }

    .page-link:hover {
        color: white;
        background-color: var(--bs-primary);
        border-color: var(--bs-primary);
    }

    .form-control:focus,
    .form-select:focus {
        border-color: var(--bs-primary);
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }

    .card {
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 0.5rem 1rem rgba(var(--bs-primary), 0.15);
    }

    .form-select {
        padding: 0.375rem 0.75rem;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #212529;
        background-color: #fff;
        border: 1px solid #ced4da;
        border-radius: 0.25rem;
        transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }

    .form-select:focus {
        border-color: #86b7fe;
        outline: 0;
        box-shadow: 0 0 0 0.25rem rgba(13,110,253,.25);
    }

    .form-label {
        margin-bottom: 0.5rem;
        font-weight: 500;
    }
</style>

<main>
    <div class="container my-3">
        <div class="row">
            <div class="col-lg-3 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Bộ lọc</h5>
                    </div>
                    <div class="card-body">
                        <!-- Form tìm kiếm -->
                        <form action="${pageContext.request.contextPath}/products" method="get" id="filterForm">
                            <div class="mb-3">
                                <label for="search" class="form-label">Tìm kiếm</label>
                                <input type="text" class="form-control" id="search" name="search" 
                                       value="${searchKeyword}" placeholder="Nhập từ khóa...">
                            </div>

                            <!-- Select danh mục -->
                            <div class="mb-3">
                                <label for="category" class="form-label">Danh mục</label>
                                <select class="form-select" id="category" name="category" onchange="submitForm()">
                                    <option value="">Tất cả danh mục</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" 
                                            ${category.id == selectedCategory ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Select thương hiệu -->
                            <div class="mb-3">
                                <label for="brand" class="form-label">Thương hiệu</label>
                                <select class="form-select" id="brand" name="brand" onchange="submitForm()">
                                    <option value="">Tất cả thương hiệu</option>
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.id}" 
                                            ${brand.id == selectedBrand ? 'selected' : ''}>
                                            ${brand.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Khoảng giá -->
                            <div class="mb-3">
                                <label class="form-label">Khoảng giá</label>
                                <select class="form-select" name="priceRange" onchange="submitForm()">
                                    <option value="">Tất cả giá</option>
                                    <option value="0-1000000" ${selectedPriceRange == '0-1000000' ? 'selected' : ''}>
                                        Dưới 1 triệu
                                    </option>
                                    <option value="1000000-5000000" ${selectedPriceRange == '1000000-5000000' ? 'selected' : ''}>
                                        1 triệu - 5 triệu
                                    </option>
                                    <option value="5000000-10000000" ${selectedPriceRange == '5000000-10000000' ? 'selected' : ''}>
                                        5 triệu - 10 triệu
                                    </option>
                                    <option value="10000000-100000000" ${selectedPriceRange == '10000000-100000000' ? 'selected' : ''}>
                                        Trên 10 triệu
                                    </option>
                                </select>
                            </div>

                            <!-- Sắp xếp -->
                            <div class="mb-3">
                                <label for="sortBy" class="form-label">Sắp xếp</label>
                                <select class="form-select" id="sortBy" name="sortBy" onchange="submitForm()">
                                    <option value="">Mặc định</option>
                                    <option value="name_asc" ${sortBy == 'name_asc' ? 'selected' : ''}>
                                        Tên A-Z
                                    </option>
                                    <option value="name_desc" ${sortBy == 'name_desc' ? 'selected' : ''}>
                                        Tên Z-A
                                    </option>
                                    <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>
                                        Giá tăng dần
                                    </option>
                                    <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>
                                        Giá giảm dần
                                    </option>
                                </select>
                            </div>

                            <!-- Nút reset filter -->
                            <button type="button" class="btn btn-secondary w-100" onclick="resetFilter()">
                                Xóa bộ lọc
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Phần danh sách sản phẩm -->
            <div class="col-lg-9">
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <c:forEach items="${products}" var="product">
                        <div class="col">
                            <div class="card h-100 shadow-sm">
                                <img src="${pageContext.request.contextPath}/assets/images/products/${product.image}"
                                     class="card-img-top" alt="${product.name}">
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="card-title mb-0">${product.name}</h5>
                                        <span class="badge bg-secondary">${product.averageRating}⭐</span>
                                    </div>
                                    <p class="text-danger fw-bold mb-1">
                                        <c:choose>
                                            <c:when test="${not empty product.productSale}">
                                                <fmt:formatNumber value="${product.salePrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                <del class="text-muted">
                                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </del>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="small text-muted">Số lượt xem: ${product.totalViews}</p>
                                    <p class="card-text mb-3">${product.description}</p>
                                    <div class="d-flex justify-content-between align-items-center mt-auto">
                                        <button onclick="addToCart(${product.id})" class="btn btn-primary">
                                            <i class="bi bi-cart-plus"></i>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/product/${product.id}"
                                           class="btn btn-info text-white">
                                            <i class="bi bi-eye"></i> Xem chi tiết
                                        </a>
                                        <button onclick="toggleWishlist(${product.id})"
                                                class="btn btn-outline-secondary">
                                            <i class="bi bi-bookmark-heart"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Phân trang -->
                <nav aria-label="Page navigation" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="goToPage(${currentPage - 1})">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>
                        
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="#" onclick="goToPage(${i})">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="goToPage(${currentPage + 1})">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</main>

<script>
function handleSearch(event) {
    event.preventDefault();
    const searchValue = document.getElementById('searchInput').value;
    updateQueryParams({ search: searchValue, page: 1 });
}

function handleSort(value) {
    updateQueryParams({ sortBy: value, page: 1 });
}

function goToPage(page) {
    updateQueryParams({ page: page });
}

function removeFilter(filterType) {
    const params = new URLSearchParams(window.location.search);
    params.delete(filterType);
    params.set('page', '1');
    window.location.search = params.toString();
}

function resetFilter() {
    window.location.href = '${pageContext.request.contextPath}/products';
}

function updateQueryParams(newParams) {
    const params = new URLSearchParams(window.location.search);
    
    // Cập nhật/thêm các tham số mới
    Object.entries(newParams).forEach(([key, value]) => {
        if (value) {
            params.set(key, value);
        } else {
            params.delete(key);
        }
    });
    
    // Chuyển hướng đến URL mới
    window.location.search = params.toString();
}

function addToCart(productId) {
    // Implement add to cart logic
}

function toggleWishlist(productId) {
    // Implement wishlist logic
}

function submitForm() {
    document.getElementById('filterForm').submit();
}
</script>





