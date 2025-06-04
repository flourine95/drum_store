<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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
</style>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <div class="page-title-icon">
            <i class="fas fa-plus-circle fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Thêm Vai trò mới</h2>
            <p class="text-muted mb-0">Tạo vai trò mới trong hệ thống</p>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-8">
            <!-- Form Card -->
            <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
                <div class="card-body p-4">
                    <!-- Error Messages -->
                    <c:if test="${not empty errors}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-start border-danger border-4" role="alert">
                            <div class="d-flex">
                                <div class="me-3">
                                    <i class="fas fa-exclamation-circle fs-4"></i>
                                </div>
                                <div>
                                    <h5 class="alert-heading">Có lỗi xảy ra</h5>
                                    <ul class="mb-0 ps-3">
                                        <c:forEach var="error" items="${errors}">
                                            <li>${error.value}</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <!-- Form -->
                    <form method="POST" action="${pageContext.request.contextPath}/dashboard/roles" class="needs-validation">
                        <input type="hidden" name="action" value="store">

                        <div class="mb-4">
                            <label for="name" class="form-label">Tên vai trò <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text border-end-0 bg-light">
                                    <i class="fas fa-user-tag text-primary"></i>
                                </span>
                                <input type="text" class="form-control border-start-0 ps-0 ${not empty errors.name ? 'is-invalid' : ''}" 
                                       id="name" name="name" value="${oldInput.name}" placeholder="Nhập tên vai trò" required>
                                <c:if test="${not empty errors.name}">
                                    <div class="invalid-feedback">${errors.name}</div>
                                </c:if>
                            </div>
                            <div class="form-text">Tên vai trò nên ngắn gọn và mô tả đúng chức năng</div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label">Mô tả</label>
                            <div class="input-group">
                                <span class="input-group-text border-end-0 bg-light">
                                    <i class="fas fa-align-left text-primary"></i>
                                </span>
                                <textarea class="form-control border-start-0 ps-0 ${not empty errors.description ? 'is-invalid' : ''}" 
                                          id="description" name="description" rows="4" 
                                          placeholder="Nhập mô tả chi tiết về vai trò này">${oldInput.description}</textarea>
                                <c:if test="${not empty errors.description}">
                                    <div class="invalid-feedback">${errors.description}</div>
                                </c:if>
                            </div>
                            <div class="form-text">Mô tả chi tiết giúp người dùng hiểu rõ hơn về vai trò</div>
                        </div>

                        <hr class="my-4">

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/dashboard/roles" class="btn btn-light rounded-pill px-4">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-4 py-2 shadow-sm">
                                <i class="fas fa-save me-2"></i>Lưu vai trò
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <!-- Help Card -->
            <div class="card shadow-sm border-0 rounded-3 bg-light">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="fas fa-info-circle me-2 text-primary"></i>Hướng dẫn
                    </h5>
                    <p class="card-text">Vai trò giúp phân quyền người dùng trong hệ thống. Mỗi vai trò sẽ có những quyền hạn khác nhau.</p>
                    <ul class="ps-3 mb-0">
                        <li class="mb-2">Đặt tên vai trò ngắn gọn và dễ hiểu</li>
                        <li class="mb-2">Mô tả chi tiết quyền hạn của vai trò</li>
                        <li>Sau khi tạo vai trò, bạn có thể gán vai trò cho người dùng</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>