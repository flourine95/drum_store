<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-4">
    <!-- Breadcrumb -->
    <div class="row mb-4">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/brands" class="text-decoration-none">Thương hiệu</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${brand.name}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row g-4">
        <!-- Main Content Card -->
        <div class="col-lg-8 col-md-12">
            <!-- Brand Details Card -->
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-primary-subtle p-2 me-3">
                                <i class="bi bi-tag-fill fs-4 text-primary"></i>
                            </div>
                            <h5 class="mb-0">Thông tin thương hiệu</h5>
                        </div>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/dashboard/brands?action=edit&id=${brand.id}" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-pencil me-1"></i> Chỉnh sửa
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                <i class="bi bi-trash me-1"></i> Xóa
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="row g-4">
                        <!-- Brand Image -->
                        <div class="col-md-4 text-center">
                            <div class="brand-image-container mb-3">
                                <c:choose>
                                    <c:when test="${not empty brand.image}">
                                        <img src="${pageContext.request.contextPath}/uploads/brands/${brand.image}" 
                                             alt="${brand.name}" class="img-fluid rounded shadow-sm brand-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="placeholder-image d-flex align-items-center justify-content-center bg-light rounded shadow-sm">
                                            <i class="bi bi-building fs-1 text-secondary"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <!-- Brand Details -->
                        <div class="col-md-8">
                            <div class="mb-4">
                                <h4 class="fw-bold mb-3">${brand.name}</h4>
                                <div class="mb-3">
                                    <div class="text-muted small mb-1">Mô tả</div>
                                    <p class="mb-0">${empty brand.description ? 'Không có mô tả' : brand.description}</p>
                                </div>
                            </div>
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="card border-0 bg-light">
                                        <div class="card-body py-2">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-white p-2 me-3">
                                                    <i class="bi bi-hash text-secondary"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Mã thương hiệu</div>
                                                    <div class="fw-medium">#${brand.id}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border-0 bg-light">
                                        <div class="card-body py-2">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-white p-2 me-3">
                                                    <i class="bi bi-calendar-check text-secondary"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Ngày tạo</div>
                                                    <div class="fw-medium">
                                                        <fmt:formatDate value="${brand.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border-0 bg-light">
                                        <div class="card-body py-2">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-white p-2 me-3">
                                                    <i class="bi bi-box-seam text-secondary"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Số sản phẩm</div>
                                                    <div class="fw-medium">${productCount} sản phẩm</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="card border-0 bg-light">
                                        <div class="card-body py-2">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-white p-2 me-3">
                                                    <i class="bi bi-person text-secondary"></i>
                                                </div>
                                                <div>
                                                    <div class="text-muted small">Người tạo</div>
                                                    <div class="fw-medium">${brand.createdBy}</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white py-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/dashboard/brands" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i> Quay lại danh sách
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard/products?brandId=${brand.id}" class="btn btn-primary">
                            <i class="bi bi-box-seam me-2"></i> Xem sản phẩm
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Related Products Card -->
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-success-subtle p-2 me-3">
                                <i class="bi bi-box-seam fs-4 text-success"></i>
                            </div>
                            <h5 class="mb-0">Sản phẩm thuộc thương hiệu này</h5>
                        </div>
                        <span class="badge bg-success rounded-pill">${productCount}</span>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div id="relatedProductsContainer" class="p-4">
                        <div class="text-center py-5" id="loadingProducts">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Đang tải...</span>
                            </div>
                            <p class="mt-2 text-muted">Đang tải danh sách sản phẩm...</p>
                        </div>
                        <div id="productsList" class="row g-4" style="display: none;"></div>
                        <div id="noProducts" class="text-center py-5" style="display: none;">
                            <i class="bi bi-inbox fs-1 text-muted"></i>
                            <p class="mt-2 text-muted">Không có sản phẩm nào thuộc thương hiệu này.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="col-lg-4 col-md-12">
            <!-- Actions Card -->
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-warning-subtle p-2 me-3">
                            <i class="bi bi-gear-fill fs-4 text-warning"></i>
                        </div>
                        <h5 class="mb-0">Thao tác</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="d-grid gap-3">
                        <a href="${pageContext.request.contextPath}/dashboard/brands?action=edit&id=${brand.id}" class="btn btn-outline-primary">
                            <i class="bi bi-pencil me-2"></i> Chỉnh sửa thương hiệu
                        </a>
                        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            <i class="bi bi-trash me-2"></i> Xóa thương hiệu
                        </button>
                        <a href="${pageContext.request.contextPath}/dashboard/products/create?brandId=${brand.id}" class="btn btn-outline-success">
                            <i class="bi bi-plus-circle me-2"></i> Thêm sản phẩm mới
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Stats Card -->
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-info-subtle p-2 me-3">
                            <i class="bi bi-graph-up fs-4 text-info"></i>
                        </div>
                        <h5 class="mb-0">Thống kê</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="list-group list-group-flush">
                        <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-primary-subtle p-2 me-3">
                                    <i class="bi bi-box-seam text-primary"></i>
                                </div>
                                <span>Tổng sản phẩm</span>
                            </div>
                            <span class="badge bg-primary rounded-pill">${productCount}</span>
                        </div>
                        <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-success-subtle p-2 me-3">
                                    <i class="bi bi-check-circle text-success"></i>
                                </div>
                                <span>Sản phẩm đang kinh doanh</span>
                            </div>
                            <span class="badge bg-success rounded-pill">${activeProductCount}</span>
                        </div>
                        <div class="list-group-item border-0 px-0 d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-danger-subtle p-2 me-3">
                                    <i class="bi bi-x-circle text-danger"></i>
                                </div>
                                <span>Sản phẩm ngừng kinh doanh</span>
                            </div>
                            <span class="badge bg-danger rounded-pill">${inactiveProductCount}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-3">
                    <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                </div>
                <p class="text-center">Bạn có chắc chắn muốn xóa thương hiệu <span class="fw-bold">${brand.name}</span>?</p>
                <p class="text-danger text-center small">Lưu ý: Hành động này không thể hoàn tác và sẽ ảnh hưởng đến các sản phẩm liên kết.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form action="${pageContext.request.contextPath}/dashboard/brands/${brand.id}" method="POST" style="display:inline;">
                    <input type="hidden" name="_method" value="DELETE">
                    <input type="hidden" name="csrf_token" value="${csrfToken}">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .brand-image-container {
        width: 100%;
        max-width: 250px;
        margin: 0 auto;
    }
    
    .brand-image {
        width: 100%;
        height: auto;
        object-fit: contain;
    }
    
    .placeholder-image {
        width: 100%;
        height: 250px;
    }
    
    .product-card {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    }
    
    .product-image {
        height: 150px;
        object-fit: contain;
    }
</style>

<script>
    $(document).ready(function() {
        // Load related products
        loadRelatedProducts();
        
        function loadRelatedProducts() {
            setTimeout(function() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/api/brands/${brand.id}/products',
                    type: 'GET',
                    success: function(response) {
                        $('#loadingProducts').hide();
                        
                        if (response && response.length > 0) {
                            renderProducts(response);
                            $('#productsList').show();
                        } else {
                            $('#noProducts').show();
                        }
                    },
                    error: function() {
                        $('#loadingProducts').hide();
                        $('#noProducts').show();
                        $('#noProducts p').text('Lỗi khi tải dữ liệu sản phẩm. Vui lòng thử lại sau.');
                    }
                });
            }, 1000); // Simulate loading for demo purposes
        }
        
        function renderProducts(products) {
            const container = $('#productsList');
            container.empty();
            
            // Limit to first 6 products
            const displayProducts = products.slice(0, 6);
            
            displayProducts.forEach(function(product) {
                const productCard = `
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 border-0 shadow-sm product-card">
                            <div class="card-body p-3 text-center">
                                <img src="${pageContext.request.contextPath}/uploads/products/${product.image || 'placeholder.png'}" 
                                     alt="${product.name}" class="mb-3 product-image">
                                <h6 class="card-title mb-1">${product.name}</h6>
                                <p class="text-muted small mb-2">${product.sku || ''}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="fw-bold text-primary">${formatCurrency(product.price)}</span>
                                    <span class="badge ${product.active ? 'bg-success' : 'bg-danger'} rounded-pill">
                                        ${product.active ? 'Đang bán' : 'Ngừng bán'}
                                    </span>
                                </div>
                            </div>
                            <div class="card-footer bg-white border-0 p-3">
                                <a href="${pageContext.request.contextPath}/dashboard/products?action=view&id=${product.id}" 
                                   class="btn btn-outline-primary btn-sm w-100">
                                    <i class="bi bi-eye me-1"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                `;
                container.append(productCard);
            });
            
            // Add 'View All' card if there are more than 6 products
            if (products.length > 6) {
                const viewAllCard = `
                    <div class="col-md-6 col-lg-4">
                        <div class="card h-100 border-0 shadow-sm product-card bg-light">
                            <div class="card-body d-flex flex-column align-items-center justify-content-center p-3">
                                <i class="bi bi-grid-3x3-gap fs-1 text-primary mb-3"></i>
                                <h6 class="card-title mb-1">Xem tất cả sản phẩm</h6>
                                <p class="text-muted small mb-3">Còn ${products.length - 6} sản phẩm khác</p>
                                <a href="${pageContext.request.contextPath}/dashboard/products?brandId=${brand.id}" 
                                   class="btn btn-primary">
                                    <i class="bi bi-arrow-right me-1"></i> Xem tất cả
                                </a>
                            </div>
                        </div>
                    </div>
                `;
                container.append(viewAllCard);
            }
        }
        
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
        }
    });
</script>
