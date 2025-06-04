<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid px-4">
    <!-- Breadcrumb -->
    <div class="row mb-4">
        <div class="col-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/categories" class="text-decoration-none">Danh mục</a></li>
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
                        <h5 class="mb-0">${title}</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form id="categoryForm">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${category.id}">
                        <input type="hidden" name="image" id="uploadedImageField" value="${category.image}">

                        <div class="row g-4">
                            <!-- Name Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập tên danh mục" value="${category.name}" required>
                                    <label for="name">Tên danh mục <span class="text-danger">*</span></label>
                                </div>
                            </div>

                            <!-- Description Field -->
                            <div class="col-md-12">
                                <div class="form-floating mb-3">
                                    <textarea class="form-control" id="description" name="description" 
                                              placeholder="Nhập mô tả" style="height: 120px">${category.description}</textarea>
                                    <label for="description">Mô tả</label>
                                </div>
                            </div>

                            <!-- Image Upload Section -->
                            <div class="col-md-12">
                                <div class="card bg-light border-0 mb-4">
                                    <div class="card-header bg-light py-3">
                                        <h6 class="mb-0 fw-semibold">
                                            <i class="bi bi-image me-2"></i>Hình ảnh danh mục <span class="text-danger">*</span>
                                        </h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row g-4 align-items-center">
                                            <div class="col-md-8">
                                                <div class="mb-3">
                                                    <label for="fileInput" class="form-label">Chọn ảnh mới (nếu muốn thay đổi)</label>
                                                    <input type="file" class="form-control" id="fileInput" accept="image/*">
                                                </div>
                                                <div class="form-text mb-2">Khuyến nghị: ảnh vuông kích thước 300x300 pixels.</div>
                                                <div class="alert alert-success py-2 d-flex align-items-center" role="alert">
                                                    <i class="bi bi-check-circle-fill me-2"></i>
                                                    <div>
                                                        Ảnh hiện tại: 
                                                        <strong>
                                                            ${category.image != null 
                                                                ? (category.image.contains('/') 
                                                                    ? category.image.substring(category.image.lastIndexOf('/') + 1) 
                                                                    : category.image) 
                                                                : 'Không có ảnh'}
                                                        </strong>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="image-preview-wrapper">
                                                    <div class="image-preview-container">
                                                        <c:choose>
                                                            <c:when test="${not empty category.image}">
                                                                <img src="${category.image}"
                                                                     alt="${category.name}" id="previewImage" class="preview-image">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="https://placehold.co/400" alt="No Image" 
                                                                     id="previewImage" class="preview-image">
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
                                <a href="${pageContext.request.contextPath}/dashboard/categories"
                                   class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i> Quay lại
                                </a>
                                <button type="button" id="saveCategoryBtn" class="btn btn-success px-4 py-2">
                                    <i class="bi bi-save me-2"></i> Lưu thay đổi
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
                        <h5 class="mb-0">Thông tin danh mục</h5>
                    </div>
                </div>
                <div class="card-body p-4">
                    <!-- Category Details Card -->
                    <div class="card border-0 shadow-sm mb-4">
                        <div class="card-body">
                            <h6 class="card-subtitle mb-3 text-muted">Thông tin cơ bản</h6>
                            <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                <div class="rounded-circle bg-primary-subtle p-2 me-3">
                                    <i class="bi bi-hash fs-5 text-primary"></i>
                                </div>
                                <div>
                                    <div class="small text-muted">ID danh mục</div>
                                    <div class="fw-medium">${category.id}</div>
                                </div>
                            </div>
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle bg-success-subtle p-2 me-3">
                                    <i class="bi bi-calendar-check fs-5 text-success"></i>
                                </div>
                                <div>
                                    <div class="small text-muted">Ngày tạo</div>
                                    <div class="fw-medium">${category.createdAt}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Help Info -->
                    <div class="alert alert-info border-0 shadow-sm mb-0">
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-lightbulb-fill fs-4 me-2"></i>
                            <h6 class="alert-heading mb-0">Lưu ý khi chỉnh sửa</h6>
                        </div>
                        <hr>
                        <ul class="mb-0 ps-3">
                            <li class="mb-2">Tên danh mục không được để trống</li>
                            <li class="mb-2">Nếu không tải ảnh mới, hệ thống sẽ giữ lại ảnh hiện tại</li>
                            <li>Bấm nút Lưu thay đổi để cập nhật danh mục</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .image-upload-container {
        border-radius: 8px;
        background-color: #f8f9fa;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        border: 1px solid #e9ecef;
    }
    
    .image-preview-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
    }
    
    .image-preview-container {
        position: relative;
        width: 100%;
        height: 150px;
        overflow: hidden;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        transition: all 0.3s ease;
    }
    
    .image-preview-container:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    
    .preview-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: all 0.3s ease;
    }
    
    .image-overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0, 0, 0, 0.6);
        color: white;
        padding: 8px 0;
        text-align: center;
        font-size: 14px;
        opacity: 0;
        transition: opacity 0.3s ease;
    }
    
    .image-preview-container:hover .image-overlay {
        opacity: 1;
    }
    
    .overlay-text {
        font-weight: 500;
    }
    
    /* Style for successful upload */
    .upload-success {
        background-color: #d4edda;
        border-color: #c3e6cb;
        color: #155724;
        padding: 10px;
        border-radius: 5px;
        margin-top: 10px;
        display: flex;
        align-items: center;
    }
</style>

<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<script>
    async function getRealCKBoxToken() {
        const res = await fetch('/api/keys?service=ckbox-dev');
        const tokenUrl = await res.text();
        const tokenResponse = await fetch(tokenUrl);
        const token = await tokenResponse.text();
        return token.trim();
    }

    async function uploadImageToCKBox(file) {
        try {
            Swal.fire({
                title: "Đang tải ảnh...",
                text: "Vui lòng chờ trong giây lát",
                allowOutsideClick: false,
                didOpen: () => Swal.showLoading()
            });

            const formData = new FormData();
            formData.append("file", file);

            const token = await getRealCKBoxToken();

            const response = await fetch("https://api.ckbox.io/assets", {
                method: "POST",
                headers: {
                    "Authorization": token
                },
                body: formData
            });

            if (!response.ok) throw new Error("Lỗi khi upload ảnh");

            const data = await response.json();
            const imageUrl = data.url || data.urls?.default || data.imageUrls?.default;

            return imageUrl;
        } catch (err) {
            console.error(err);
            Swal.fire({
                icon: "error",
                title: "Lỗi",
                text: "Không thể tải ảnh lên: " + err.message
            });
            return null;
        } finally {
            Swal.close();
        }
    }

    // Automatically upload the image when a file is selected
    document.getElementById('fileInput').addEventListener('change', async () => {
        const fileInput = document.getElementById('fileInput');
        const file = fileInput.files[0];
        if (!file) {
            return;
        }

        const url = await uploadImageToCKBox(file);
        if (url) {
            document.getElementById("uploadedImageField").value = url;
            document.getElementById("previewImage").src = url;
            
            // Add success indicator with animation
            const successElement = document.createElement('div');
            successElement.className = 'upload-success';
            successElement.innerHTML = '<i class="bi bi-check-circle-fill me-2"></i> Đã tải lên thành công: ' + file.name;
            
            const imageNameDisplay = document.getElementById("imageNameDisplay");
            imageNameDisplay.innerHTML = ''; // Clear previous content
            imageNameDisplay.appendChild(successElement);
            
            // Optional: Add slight animation
            document.querySelector('.image-preview-container').classList.add('animate__animated', 'animate__pulse');
        }
    });

    $('#saveCategoryBtn').on('click', function (event) {
        event.preventDefault();
        const id = $('input[name="id"]').val().trim();
        const name = $('#name').val().trim();
        const description = $('#description').val().trim();
        const image = $('#uploadedImageField').val();

        if (!name || !image) {
            Swal.fire({
                icon: "warning",
                title: "Thiếu dữ liệu",
                text: "Tên và ảnh là bắt buộc",
                confirmButtonText: "Đã hiểu"
            });
            return;
        }

        // Show loading state
        Swal.fire({
            title: "Đang xử lý...",
            text: "Vui lòng chờ trong giây lát",
            allowOutsideClick: false,
            didOpen: () => Swal.showLoading()
        });

        $.ajax({
            url: '${pageContext.request.contextPath}/dashboard/categories',
            method: 'POST',
            data: {
                action: 'update',
                id: id,
                name: name,
                description: description,
                image: image
            },
            success: function (response) {
                if (response.success) {
                    Swal.fire({
                        icon: "success",
                        title: "Thành công!",
                        text: response.message,
                        confirmButtonText: "OK"
                    }).then(() => {
                        window.location.href = response.redirectUrl || '${pageContext.request.contextPath}/dashboard/categories';
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Lỗi",
                        text: response.message || "Lỗi không xác định"
                    });
                }
            },
            error: function (xhr) {
                let errorMessage = "Không thể cập nhật danh mục";
                try {
                    const response = JSON.parse(xhr.responseText);
                    if (response.message) {
                        errorMessage = response.message;
                    }
                } catch (e) {
                    console.error("Error parsing error response:", e);
                }
                Swal.fire({
                    icon: "error",
                    title: "Lỗi",
                    text: errorMessage
                });
            }
        });
    });
</script>
