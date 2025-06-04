<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid px-4">
    <!-- Breadcrumb -->
    <div class="row mb-4">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/brands" class="text-decoration-none">Thương hiệu</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
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
                            <i class="bi bi-plus-circle fs-4 text-primary"></i>
                        </div>
                        <h5 class="mb-0">Thêm thương hiệu mới</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form id="brandForm" action="${pageContext.request.contextPath}/dashboard/brands" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="_method" value="PUT">
                        <input type="hidden" name="csrf_token" value="${csrfToken}">
                        <input type="hidden" name="image" id="uploadedImageField">

                        <div class="row g-4">
                            <!-- Name Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên thương hiệu" required>
                                    <label for="name">Tên thương hiệu <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <!-- Description Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="description" name="description" 
                                              placeholder="Nhập mô tả" style="height: 120px"></textarea>
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
                                                    <label for="fileInput" class="form-label">Chọn ảnh</label>
                                                    <input type="file" class="form-control" id="fileInput" accept="image/*">
                                                </div>
                                                <div class="form-text mb-2">Khuyến nghị: ảnh logo thương hiệu kích thước 300x300 pixels, định dạng PNG hoặc JPG.</div>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="image-preview-wrapper">
                                                    <div class="image-preview-container">
                                                        <img src="https://placehold.co/400" alt="Preview" id="previewImage" class="preview-image">
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
                                    <i class="bi bi-plus-circle me-2"></i> Tạo thương hiệu
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
                        <h5 class="mb-0">Hướng dẫn</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <div class="alert alert-info border-0 shadow-sm mb-4">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-lightbulb-fill fs-4 me-2"></i>
                            <h6 class="alert-heading mb-0">Lưu ý khi tạo thương hiệu</h6>
                        </div>
                        <hr>
                        <ul class="mb-0 ps-3">
                            <li class="mb-2">Tên thương hiệu không được để trống và nên ngắn gọn, dễ nhớ</li>
                            <li class="mb-2">Hình ảnh nên là logo chính thức của thương hiệu</li>
                            <li class="mb-2">Mô tả nên cung cấp thông tin ngắn gọn về thương hiệu</li>
                            <li>Thương hiệu sau khi tạo có thể được liên kết với sản phẩm</li>
                        </ul>
                    </div>
                    
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h6 class="card-subtitle mb-3 text-muted">Các thương hiệu phổ biến</h6>
                            <div class="d-flex flex-wrap gap-2">
                                <span class="badge bg-light text-dark border p-2">Pearl</span>
                                <span class="badge bg-light text-dark border p-2">Tama</span>
                                <span class="badge bg-light text-dark border p-2">DW</span>
                                <span class="badge bg-light text-dark border p-2">Yamaha</span>
                                <span class="badge bg-light text-dark border p-2">Sonor</span>
                                <span class="badge bg-light text-dark border p-2">Gretsch</span>
                                <span class="badge bg-light text-dark border p-2">Zildjian</span>
                                <span class="badge bg-light text-dark border p-2">Sabian</span>
                            </div>
                        </div>
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