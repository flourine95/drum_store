<%@ page contentType="text/html;charset=UTF-8" %>
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
            <i class="fas fa-edit fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Sửa Quyền</h2>
            <p class="text-muted mb-0">Cập nhật thông tin quyền trong hệ thống</p>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-8">
            <!-- Form Card -->
            <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
                <div class="card-body p-4">
                    <c:if test="${not empty errors}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-start border-danger border-4" role="alert">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-exclamation-circle me-3 fs-4"></i>
                                <div>
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

                    <form method="POST" action="${pageContext.request.contextPath}/dashboard/permissions">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${permission.id}">

                        <div class="mb-4">
                            <label for="name" class="form-label fw-medium">Tên quyền <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-shield-alt text-primary"></i>
                                </span>
                                <input type="text" class="form-control ${not empty errors.name ? 'is-invalid' : ''}" 
                                       id="name" name="name" value="${permission.name}" placeholder="Nhập tên quyền" required>
                                <c:if test="${not empty errors.name}">
                                    <div class="invalid-feedback">${errors.name}</div>
                                </c:if>
                            </div>
                            <div class="form-text text-muted">Tên quyền nên ngắn gọn và mô tả chính xác quyền hạn</div>
                        </div>

                        <div class="mb-4">
                            <label for="description" class="form-label fw-medium">Mô tả</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light">
                                    <i class="fas fa-align-left text-primary"></i>
                                </span>
                                <textarea class="form-control ${not empty errors.description ? 'is-invalid' : ''}" 
                                          id="description" name="description" rows="3" placeholder="Nhập mô tả chi tiết về quyền">${permission.description}</textarea>
                                <c:if test="${not empty errors.description}">
                                    <div class="invalid-feedback">${errors.description}</div>
                                </c:if>
                            </div>
                            <div class="form-text text-muted">Mô tả chi tiết giúp người dùng hiểu rõ hơn về quyền này</div>
                        </div>

                        <div class="d-flex justify-content-between pt-3">
                            <a href="${pageContext.request.contextPath}/dashboard/permissions" class="btn btn-light rounded-pill px-4">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                            <button type="submit" class="btn btn-primary rounded-pill px-4">
                                <i class="fas fa-save me-2"></i>Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <!-- Info Card -->
            <div class="card shadow-sm border-0 rounded-3 mb-4">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="fas fa-info-circle text-primary me-2"></i>Thông tin quyền
                    </h5>
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-light rounded-circle p-2 me-3">
                            <i class="fas fa-hashtag text-primary"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">ID Quyền</p>
                            <p class="fw-medium mb-0">${permission.id}</p>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <div class="bg-light rounded-circle p-2 me-3">
                            <i class="fas fa-calendar-alt text-primary"></i>
                        </div>
                        <div>
                            <p class="text-muted mb-0 small">Ngày tạo</p>
                            <p class="fw-medium mb-0">${permission.createdAt}</p>
                        </div>
                    </div>
                    <hr>
                    <p class="text-muted mb-0 small">Cập nhật thông tin quyền sẽ ảnh hưởng đến tất cả các vai trò được gán quyền này.</p>
                </div>
            </div>
            
            <!-- Related Actions Card -->
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-3">
                        <i class="fas fa-link text-primary me-2"></i>Liên kết
                    </h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="${pageContext.request.contextPath}/dashboard/permissions" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-list-ul text-primary me-2"></i>
                                Danh sách quyền
                            </a>
                        </li>
                        <li class="list-group-item px-0 py-2 border-0">
                            <a href="${pageContext.request.contextPath}/dashboard/roles" class="text-decoration-none d-flex align-items-center">
                                <i class="fas fa-user-tag text-primary me-2"></i>
                                Quản lý vai trò
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
