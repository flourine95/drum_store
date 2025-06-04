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
    
    .avatar {
        width: 80px;
        height: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto;
    }
    
    .bg-danger-subtle {
        background-color: rgba(220, 53, 69, 0.1);
    }
</style>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <div class="page-title-icon">
            <i class="fas fa-edit fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Sửa Vai trò</h2>
            <p class="text-muted mb-0">Cập nhật thông tin vai trò trong hệ thống</p>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-8">
            <!-- Form Card -->
            <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
                <div class="card-body p-4">
                    <!-- Role ID Badge -->
                    <div class="mb-4">
                        <span class="badge bg-light text-primary fs-6 fw-normal px-3 py-2 rounded-pill">
                            <i class="fas fa-fingerprint me-2"></i>ID: ${role.id}
                        </span>
                    </div>
                    
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
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${role.id}">

                        <div class="mb-4">
                            <label for="name" class="form-label">Tên vai trò <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text border-end-0 bg-light">
                                    <i class="fas fa-user-tag text-primary"></i>
                                </span>
                                <input type="text" class="form-control border-start-0 ps-0 ${not empty errors.name ? 'is-invalid' : ''}" 
                                       id="name" name="name" value="${role.name}" placeholder="Nhập tên vai trò" required>
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
                                          placeholder="Nhập mô tả chi tiết về vai trò này">${role.description}</textarea>
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
                                <i class="fas fa-save me-2"></i>Lưu thay đổi
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
                    <p class="card-text">Chỉnh sửa thông tin vai trò để cập nhật mục đích hoặc quyền hạn của vai trò này.</p>
                    <ul class="ps-3 mb-0">
                        <li class="mb-2">Việc đổi tên vai trò sẽ ảnh hưởng đến tất cả người dùng được gán vai trò này</li>
                        <li class="mb-2">Mô tả chi tiết giúp người dùng hiểu rõ hơn về vai trò</li>
                        <li>Sau khi cập nhật, các thay đổi sẽ được áp dụng ngay lập tức</li>
                    </ul>
                </div>
            </div>
            
            <!-- Related Actions Card -->
            <div class="card shadow-sm border-0 rounded-3 mt-3">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="fas fa-cogs me-2 text-primary"></i>Thao tác liên quan
                    </h5>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/dashboard/roles" class="btn btn-outline-primary">
                            <i class="fas fa-list me-2"></i>Danh sách vai trò
                        </a>
                        <a href="${pageContext.request.contextPath}/dashboard/users" class="btn btn-outline-secondary">
                            <i class="fas fa-users me-2"></i>Quản lý người dùng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>