<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .page-title-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(13, 110, 253, 0.1);
        color: #0d6efd;
        border-radius: 12px;
        margin-right: 1rem;
    }
    
    .search-card {
        background-color: #f8f9fa;
        border-radius: 0.25rem;
        padding: 1rem;
        margin-bottom: 1.5rem;
    }
    
    .search-input {
        border-radius: 50rem;
        padding-left: 2.5rem;
        height: 45px;
    }
    
    .search-icon {
        position: absolute;
        left: 1.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: #0d6efd;
        z-index: 3;
    }
    
    .filter-select {
        border-radius: 50rem;
        height: 45px;
        padding-left: 2.5rem;
        background-position: right 1rem center;
    }
    
    .filter-icon {
        position: absolute;
        left: 1.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: #0d6efd;
        z-index: 3;
    }
    
    .search-btn {
        border-radius: 50rem;
        height: 45px;
        padding-left: 1.5rem;
        padding-right: 1.5rem;
        font-weight: 500;
        box-shadow: 0 0.125rem 0.25rem rgba(13, 110, 253, 0.2);
    }
    
    .search-btn:hover {
        transform: translateY(-1px);
    }
    
    .products-table {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .products-table thead th {
        background-color: #f8f9fa;
        color: #212529;
        font-weight: 600;
        border-bottom: 2px solid #dee2e6;
        padding: 1rem;
    }
    
    .products-table tbody tr:hover {
        background-color: rgba(13, 110, 253, 0.04);
    }
    
    .products-table td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
    }
    
    .product-image {
        width: 50px;
        height: 50px;
        object-fit: cover;
        border-radius: 8px;
    }
    
    .sale-badge {
        display: inline-block;
        padding: 0.4rem 0.65rem;
        border-radius: 50rem;
        font-size: 0.75rem;
        font-weight: 600;
        text-align: center;
        white-space: nowrap;
    }
    
    .sale-badge-active {
        background-color: rgba(25, 135, 84, 0.1);
        color: #198754;
    }
    
    .sale-badge-inactive {
        background-color: rgba(108, 117, 125, 0.1);
        color: #6c757d;
    }
    
    .product-name {
        font-weight: 500;
        color: #212529;
    }
    
    .product-category {
        font-size: 0.875rem;
        color: #6c757d;
    }
    
    .action-btn {
        border-radius: 50rem;
        padding: 0.4rem 1rem;
        font-weight: 500;
    }
    
    .action-btn:hover {
        transform: translateY(-1px);
    }
    
    .alert {
        border-radius: 12px;
        border: none;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .pagination-container {
        display: flex;
        justify-content: flex-end;
        margin-top: 1rem;
    }
    
    .pagination .page-link {
        border-radius: 50%;
        margin: 0 0.2rem;
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .pagination .page-item.active .page-link {
        background-color: #0d6efd;
        border-color: #0d6efd;
    }
    
    .table th {
        font-weight: 500;
        color: #495057;
    }
    
    .table td {
        vertical-align: middle;
    }
    
    .discount-badge {
        font-size: 0.875rem;
        padding: 0.25rem 0.5rem;
    }
    
    .action-buttons .btn {
        padding: 0.25rem 0.5rem;
        font-size: 0.875rem;
    }
</style>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <div class="page-title-icon">
            <i class="fas fa-tags fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Quản lý giảm giá sản phẩm</h2>
            <p class="text-muted mb-0">Thiết lập và quản lý chương trình giảm giá cho sản phẩm</p>
        </div>
    </div>
    
    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-check-circle me-2"></i>
                <strong>${sessionScope.success}</strong>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-circle me-2"></i>
                <strong>${sessionScope.error}</strong>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <!-- Search and Filter Card -->
    <div class="card search-card mb-4">
        <div class="card-body p-4">
            <form method="GET" action="${pageContext.request.contextPath}/dashboard/product-sales" class="row g-3">
                <div class="col-md-4 position-relative">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="form-control search-input" id="search" name="search"
                           placeholder="Tìm kiếm theo tên sản phẩm..." value="${search}">
                </div>
                <div class="col-md-3 position-relative">
                    <i class="fas fa-filter filter-icon"></i>
                    <select class="form-select filter-select" id="category" name="category">
                        <option value="">Tất cả danh mục</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${categoryFilter == category.id ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3 position-relative">
                    <i class="fas fa-building filter-icon"></i>
                    <select class="form-select filter-select" id="brand" name="brand">
                        <option value="">Tất cả thương hiệu</option>
                        <c:forEach items="${brands}" var="brand">
                            <option value="${brand.id}" ${brandFilter == brand.id ? 'selected' : ''}>
                                ${brand.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary search-btn w-100">
                        <i class="fas fa-search me-2"></i>Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Products Sale List Card -->
    <div class="card border-0 shadow-sm rounded-3 mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <div>
                <i class="fas fa-table text-primary me-2"></i>
                <span class="fw-bold">Danh sách sản phẩm</span>
            </div>
            <div>
                <button type="button" class="btn btn-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#addSaleModal">
                    <i class="fas fa-plus me-2"></i>Thêm giảm giá
                </button>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle products-table mb-0">
                    <thead>
                        <tr>
                            <th style="width: 60px;">Hình ảnh</th>
                            <th>Sản phẩm</th>
                            <th>Giá gốc</th>
                            <th>Danh mục</th>
                            <th>Thương hiệu</th>
                            <th>Giảm giá</th>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="product">
                            <tr>
                                <td>
                                    <img src="${product.mainImage}" alt="${product.name}" class="product-image">
                                </td>
                                <td>
                                    <div class="d-flex flex-column">
                                        <span class="product-name">${product.name}</span>
                                        <span class="product-category">ID: ${product.id}</span>
                                    </div>
                                </td>
                                <td><fmt:formatNumber value="${product.basePrice}" type="currency" currencySymbol="₫"/></td>
                                <td>${product.categoryName}</td>
                                <td>${product.brandName}</td>
                                <td>
                                    <c:if test="${not empty product.sale}">
                                        <div class="d-flex flex-column">
                                            <span class="badge bg-danger discount-badge mb-1">
                                                -${product.sale.discountPercentage}%
                                            </span>
                                            <small class="text-muted">
                                                <fmt:formatDate value="${product.sale.startDate}" pattern="dd/MM/yyyy"/> - 
                                                <fmt:formatDate value="${product.sale.endDate}" pattern="dd/MM/yyyy"/>
                                            </small>
                                        </div>
                                    </c:if>
                                    <c:if test="${empty product.sale}">
                                        <span class="text-muted">Không có giảm giá</span>
                                    </c:if>
                                </td>
                                <td class="text-end">
                                    <c:if test="${empty product.sale}">
                                        <a href="${pageContext.request.contextPath}/dashboard/product-sales?action=create&productId=${product.id}" 
                                           class="btn btn-primary btn-sm">
                                            <i class="fas fa-plus"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty product.sale}">
                                        <a href="${pageContext.request.contextPath}/dashboard/product-sales?action=edit&id=${product.sale.id}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" class="btn btn-danger btn-sm" 
                                                onclick="deleteSale(${product.sale.id})">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white py-3">
            <div class="d-flex flex-wrap align-items-center">
                <div class="small text-muted mb-2 mb-md-0">
                    <i class="fas fa-info-circle me-1"></i> Hiển thị ${products.size()} / ${totalProducts} sản phẩm (Trang ${currentPage}/${totalPages})
                </div>
                <div class="ms-auto">
                    <nav aria-label="Pagination">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Previous page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/dashboard/product-sales?page=${currentPage - 1}&search=${search}&category=${categoryFilter}&brand=${brandFilter}" aria-label="Previous">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            
                            <!-- First page -->
                            <c:if test="${currentPage > 3}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/product-sales?page=1&search=${search}&category=${categoryFilter}&brand=${brandFilter}">1</a>
                                </li>
                                <c:if test="${currentPage > 4}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>
                            
                            <!-- Page numbers -->
                            <c:set var="startPage" value="${(currentPage > 2) ? (currentPage - 2) : 1}" />
                            <c:set var="endPage" value="${(totalPages > currentPage + 2) ? (currentPage + 2) : totalPages}" />
                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/product-sales?page=${i}&search=${search}&category=${categoryFilter}&brand=${brandFilter}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <!-- Last page -->
                            <c:if test="${currentPage < totalPages - 2}">
                                <c:if test="${currentPage < totalPages - 3}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/product-sales?page=${totalPages}&search=${search}&category=${categoryFilter}&brand=${brandFilter}">${totalPages}</a>
                                </li>
                            </c:if>
                            
                            <!-- Next page -->
                            <li class="page-item ${currentPage == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/dashboard/product-sales?page=${currentPage + 1}&search=${search}&category=${categoryFilter}&brand=${brandFilter}" aria-label="Next">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Help Card -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4">
            <h5 class="card-title fw-bold mb-3">
                <i class="fas fa-info-circle text-primary me-2"></i>Hướng dẫn
            </h5>
            <div class="row">
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Sử dụng bộ lọc để tìm kiếm sản phẩm theo tên</li>
                        <li class="mb-2">Chọn danh mục để lọc danh sách sản phẩm theo danh mục cụ thể</li>
                        <li>Nhấn vào nút "Thêm giảm giá" để tạo chương trình giảm giá mới</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Sử dụng các nút thao tác để xem, sửa hoặc xóa giảm giá</li>
                        <li class="mb-2">Dấu hiệu màu xanh lá chỉ sản phẩm đang được giảm giá</li>
                        <li>Hãy cẩn thận khi xóa các chương trình giảm giá đang hoạt động</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Sale Modal -->
<div class="modal fade" id="addSaleModal" tabindex="-1" aria-labelledby="addSaleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addSaleModalLabel">
                    <i class="fas fa-plus-circle text-primary me-2"></i>Thêm giảm giá mới
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addSaleForm">
                    <div class="mb-3">
                        <label for="productId" class="form-label">Sản phẩm</label>
                        <select class="form-select" id="productId" name="productId" required>
                            <option value="">Chọn sản phẩm</option>
                            <c:forEach items="${products}" var="product">
                                <option value="${product.id}">${product.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="discountType" class="form-label">Loại giảm giá</label>
                        <select class="form-select" id="discountType" name="discountType" required>
                            <option value="PERCENTAGE">Phần trăm</option>
                            <option value="FIXED">Số tiền cố định</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="discountValue" class="form-label">Giá trị giảm giá</label>
                        <input type="number" class="form-control" id="discountValue" name="discountValue" required>
                    </div>
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Ngày bắt đầu</label>
                        <input type="datetime-local" class="form-control" id="startDate" name="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="endDate" class="form-label">Ngày kết thúc</label>
                        <input type="datetime-local" class="form-control" id="endDate" name="endDate" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i>Đóng
                </button>
                <button type="button" class="btn btn-primary rounded-pill" onclick="saveSale()">
                    <i class="fas fa-save me-1"></i>Lưu
                </button>
            </div>
        </div>
    </div>
</div>

<!-- View Sales Modal -->
<div class="modal fade" id="viewSalesModal" tabindex="-1" aria-labelledby="viewSalesModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewSalesModalLabel">
                    <i class="fas fa-history text-primary me-2"></i>Lịch sử giảm giá
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="salesHistory"></div>
            </div>
        </div>
    </div>
</div>

<script>
    // Initialize DataTable
    $(document).ready(function() {
        $('#productsTable').DataTable({
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json'
            }
        });
    });

    // Search functionality
    $('#searchButton').click(function() {
        $('#productsTable').DataTable().search($('#searchInput').val()).draw();
    });

    $('#searchInput').keypress(function(e) {
        if(e.which == 13) {
            $('#searchButton').click();
        }
    });

    // View sales history
    function viewSales(productId) {
        $.get('${pageContext.request.contextPath}/dashboard/product-sales/history', { productId: productId }, function(data) {
            $('#salesHistory').html(data);
            $('#viewSalesModal').modal('show');
        });
    }

    // Edit sale
    function editSale(productId) {
        // Implement edit functionality
    }

    // Delete sale
    function deleteSale(saleId) {
        if (confirm('Bạn có chắc chắn muốn xóa giảm giá này?')) {
            fetch('${pageContext.request.contextPath}/dashboard/product-sales', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `action=delete&id=${saleId}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.reload();
                } else {
                    alert(data.message || 'Có lỗi xảy ra khi xóa giảm giá');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi xóa giảm giá');
            });
        }
    }

    // Save new sale
    function saveSale() {
        const formData = new FormData($('#addSaleForm')[0]);
        $.ajax({
            url: '${pageContext.request.contextPath}/dashboard/product-sales/add',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if(response.success) {
                    location.reload();
                } else {
                    alert('Có lỗi xảy ra: ' + response.message);
                }
            }
        });
    }
</script>

