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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/categories" class="text-decoration-none">Danh mục</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chi tiết danh mục</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row g-4">
        <!-- Category Detail Card -->
        <div class="col-lg-8 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary-subtle p-2 me-3">
                            <i class="bi bi-bookmark-fill fs-4 text-primary"></i>
                        </div>
                        <h5 class="mb-0">Thông tin danh mục</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="row g-4">
                        <div class="col-md-5">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body p-0 d-flex align-items-center justify-content-center">
                                    <c:choose>
                                        <c:when test="${not empty category.image}">
                                            <img src="${pageContext.request.contextPath}/uploads/categories/${category.image}"
                                                 alt="${category.name}"
                                                 class="img-fluid rounded category-image">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center p-5">
                                                <i class="bi bi-image text-secondary" style="font-size: 5rem;"></i>
                                                <p class="mt-3 text-muted">Không có hình ảnh</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-7">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <h6 class="card-subtitle mb-4 text-muted">Thông tin chi tiết</h6>
                                    
                                    <div class="mb-4">
                                        <label class="form-label small text-muted">Tên danh mục</label>
                                        <div class="form-control-plaintext border-bottom fw-medium fs-5">
                                            ${category.name}
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label class="form-label small text-muted">Mã danh mục</label>
                                        <div class="form-control-plaintext border-bottom">
                                            #${category.id}
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <label class="form-label small text-muted">Ngày tạo</label>
                                        <div class="form-control-plaintext border-bottom">
                                            <fmt:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                                        </div>
                                    </div>
                                    
                                    <div>
                                        <label class="form-label small text-muted">Mô tả</label>
                                        <div class="form-control-plaintext border-bottom">
                                            <c:choose>
                                                <c:when test="${not empty category.description}">
                                                    ${category.description}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted fst-italic">Không có mô tả</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white py-3">
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/dashboard/categories" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i> Quay lại
                        </a>
                        <div>
                            <a href="${pageContext.request.contextPath}/dashboard/categories?action=edit&id=${category.id}" class="btn btn-outline-primary me-2">
                                <i class="bi bi-pencil me-2"></i> Chỉnh sửa
                            </a>
                            <button type="button" class="btn btn-outline-danger delete-btn" data-id="${category.id}" data-name="${category.name}">
                                <i class="bi bi-trash me-2"></i> Xóa
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Info Card -->
        <div class="col-lg-4 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-info-subtle p-2 me-3">
                            <i class="bi bi-box-seam fs-4 text-info"></i>
                        </div>
                        <h5 class="mb-0">Sản phẩm liên quan</h5>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="list-group list-group-flush" id="relatedProducts">
                        <!-- Related products will be loaded here via AJAX -->
                        <div class="text-center py-5">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Đang tải...</span>
                            </div>
                            <p class="mt-3 text-muted">Đang tải sản phẩm liên quan...</p>
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
                <input type="hidden" id="categoryId" />
                <div class="text-center mb-3">
                    <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                </div>
                <p class="text-center">Bạn có chắc chắn muốn xóa danh mục <span id="categoryName" class="fw-bold"></span>?</p>
                <p class="text-danger text-center small">Lưu ý: Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">Xóa</button>
            </div>
        </div>
    </div>
</div>

<style>
    .category-image {
        max-width: 100%;
        height: auto;
        max-height: 300px;
        object-fit: contain;
    }
</style>

<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<script>
    $(document).ready(function() {
        // Load related products
        loadRelatedProducts();
        
        // Delete category functionality
        $('.delete-btn').on('click', function() {
            const categoryId = $(this).data('id');
            const categoryName = $(this).data('name');
            
            $('#categoryId').val(categoryId);
            $('#categoryName').text(categoryName);
            $('#deleteModal').modal('show');
        });
        
        $('#confirmDeleteBtn').on('click', function() {
            const categoryId = $('#categoryId').val();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/api/categories/' + categoryId,
                type: 'DELETE',
                success: function(response) {
                    $('#deleteModal').modal('hide');
                    
                    if (response.success) {
                        showSuccessAlert('Thành công', 'Danh mục đã được xóa thành công!', function() {
                            window.location.href = '${pageContext.request.contextPath}/dashboard/categories';
                        });
                    } else {
                        showErrorAlert('Lỗi', response.message || 'Không thể xóa danh mục này.');
                    }
                },
                error: function() {
                    $('#deleteModal').modal('hide');
                    showErrorAlert('Lỗi', 'Đã xảy ra lỗi khi xóa danh mục. Vui lòng thử lại sau.');
                }
            });
        });
        
        // Function to load related products
        function loadRelatedProducts() {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/products/by-category/' + ${category.id},
                type: 'GET',
                success: function(data) {
                    const container = $('#relatedProducts');
                    container.empty();
                    
                    if (data && data.length > 0) {
                        data.forEach(function(product) {
                            let imageUrl = '${pageContext.request.contextPath}/assets/images/products/';
                            const image = product.mainImage ? 
                                '<img src="' + imageUrl + product.mainImage + '" class="rounded" style="width: 48px; height: 48px; object-fit: cover;">' : 
                                '<div class="rounded bg-light d-flex align-items-center justify-content-center" style="width: 48px; height: 48px;"><i class="bi bi-image text-secondary"></i></div>';
                                
                            let productUrl = '${pageContext.request.contextPath}/dashboard/products?action=view&id=' + product.id;
                            let formattedPrice = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(product.basePrice);
                            
                            container.append(
                                '<a href="' + productUrl + '" class="list-group-item list-group-item-action">' +
                                    '<div class="d-flex align-items-center">' +
                                        '<div class="me-3">' + image + '</div>' +
                                        '<div>' +
                                            '<div class="fw-medium">' + product.name + '</div>' +
                                            '<div class="small text-muted">' + formattedPrice + '</div>' +
                                        '</div>' +
                                    '</div>' +
                                '</a>'
                            );
                        });
                    } else {
                        container.append(
                            '<div class="text-center py-5">' +
                                '<i class="bi bi-box2 text-secondary" style="font-size: 3rem;"></i>' +
                                '<p class="mt-3 text-muted">Không có sản phẩm nào thuộc danh mục này</p>' +
                            '</div>'
                        );
                    }
                },
                error: function() {
                    const container = $('#relatedProducts');
                    container.empty();
                    container.append(
                        '<div class="text-center py-5">' +
                            '<i class="bi bi-exclamation-circle text-danger" style="font-size: 3rem;"></i>' +
                            '<p class="mt-3 text-muted">Đã xảy ra lỗi khi tải sản phẩm liên quan</p>' +
                        '</div>'
                    );
                }
            });
        }
    });
</script>
