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
                    <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="row g-4">
        <!-- Main Form Card -->
        <div class="col-lg-8 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-primary-subtle p-2 me-3">
                            <i class="bi bi-pencil-square fs-4 text-primary"></i>
                        </div>
                        <h5 class="mb-0">Chỉnh sửa thương hiệu</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form id="brandForm" action="${pageContext.request.contextPath}/dashboard/brands/${brand.id}" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="_method" value="PUT">
                        <input type="hidden" name="csrf_token" value="${csrfToken}">
                        <input type="hidden" name="id" value="${brand.id}">
                        <input type="hidden" name="image" id="uploadedImageField" value="${brand.image}">

                        <div class="row g-4">
                            <!-- Name Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${brand.name}" placeholder="Nhập tên thương hiệu" required>
                                    <label for="name">Tên thương hiệu <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <!-- Description Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="description" name="description" 
                                              placeholder="Nhập mô tả" style="height: 120px">${brand.description}</textarea>
                                    <label for="description">Mô tả</label>
                                </div>
                            </div>

                            <!-- Image Upload Section -->
                            <div class="col-md-12">
                                <div class="card bg-light border-0 mb-4">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold">
                                            <i class="bi bi-image me-2"></i>Hình ảnh thương hiệu <span class="text-danger">*</span>
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-4 align-items-center">
                                            <div class="col-md-8">
                                                <div class="mb-3">
                                                    <label for="fileInput" class="form-label">Chọn ảnh mới (nếu muốn thay đổi)</label>
                                                    <input type="file" class="form-control" id="fileInput" accept="image/*">
                                                </div>
                                                <div class="form-text mb-2">Khuyến nghị: ảnh logo thương hiệu kích thước 300x300 pixels, định dạng PNG hoặc JPG.</div>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="image-preview-wrapper">
                                                    <div class="image-preview-container">
                                                        <c:choose>
                                                            <c:when test="${not empty brand.image}">
                                                                <img src="${pageContext.request.contextPath}/uploads/brands/${brand.image}" 
                                                                     alt="${brand.name}" id="previewImage" class="preview-image">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://placehold.co/400" alt="Preview" id="previewImage" class="preview-image">
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div class="image-overlay">
                                                            <span class="overlay-text">Xem trước</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="col-12 d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/dashboard/brands"
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i> Quay lại
                                </a>
                                <button type="submit" id="saveBrandBtn" class="btn btn-success px-4 py-2">
                                    <i class="bi bi-check-circle me-2"></i> Lưu thay đổi
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Info Card -->
        <div class="col-lg-4 col-md-12">
            <div class="card shadow-sm border-0 rounded-lg mb-4">
                <div class="card-header bg-white py-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-info-subtle p-2 me-3">
                            <i class="bi bi-info-circle fs-4 text-info"></i>
                        </div>
                        <h5 class="mb-0">Thông tin thương hiệu</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="rounded-circle bg-light p-2 me-3">
                                <i class="bi bi-hash text-secondary"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Mã thương hiệu</div>
                                <div class="fw-medium">#${brand.id}</div>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center mb-3">
                            <div class="rounded-circle bg-light p-2 me-3">
                                <i class="bi bi-calendar-check text-secondary"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Ngày tạo</div>
                                <div class="fw-medium">
                                    <fmt:formatDate value="${brand.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-light p-2 me-3">
                                <i class="bi bi-box-seam text-secondary"></i>
                            </div>
                            <div>
                                <div class="text-muted small">Số sản phẩm</div>
                                <div class="fw-medium">${productCount} sản phẩm</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="alert alert-warning border-0 shadow-sm">
                        <div class="d-flex align-items-center mb-2">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <h6 class="alert-heading mb-0">Lưu ý</h6>
                        </div>
                        <p class="mb-0 small">Thay đổi thông tin thương hiệu sẽ ảnh hưởng đến tất cả sản phẩm liên kết với thương hiệu này.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .image-preview-wrapper {
        width: 100%;
        height: 100%;
    }
    
    .image-preview-container {
        position: relative;
        width: 100%;
        height: 150px;
        overflow: hidden;
        border-radius: 8px;
        border: 2px dashed #dee2e6;
        background-color: #f8f9fa;
    }
    
    .preview-image {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }
    
    .image-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .image-preview-container:hover .image-overlay {
        opacity: 1;
    }
</style>

<script>
    $(document).ready(function() {
        // Image preview functionality
        $('#fileInput').change(function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#previewImage').attr('src', e.target.result);
                }
                reader.readAsDataURL(file);
                
                // Store filename or path in hidden field
                $('#uploadedImageField').val(file.name);
            }
        });
    });
</script>