<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .page-title-icon {
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f8f9fa;
        border-radius: 50%;
        margin-right: 15px;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .role-card {
        transition: all 0.2s ease;
        border: 1px solid #e9ecef;
    }
    
    .role-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    }
    
    .role-check {
        transform: scale(1.2);
    }
    
    .user-info-card {
        background-color: #f8f9fa;
        border-left: 4px solid #0d6efd;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .user-avatar {
        width: 64px;
        height: 64px;
        background-color: #e9ecef;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        color: #6c757d;
        margin-right: 20px;
    }
    
    .btn-save {
        transition: all 0.2s;
    }
    
    .btn-save:hover {
        transform: translateY(-2px);
        box-shadow: 0 0.5rem 1rem rgba(13, 110, 253, 0.15);
    }
    
    .form-check-input:checked {
        background-color: #0d6efd;
        border-color: #0d6efd;
    }
</style>

<div class="container-fluid px-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4 mt-4">
        <div class="d-flex align-items-center">
            <div class="page-title-icon bg-primary bg-opacity-10 text-primary">
                <i class="fas fa-user-tag"></i>
            </div>
            <div>
                <h1 class="mb-0 fs-4 fw-bold">Chỉnh sửa vai trò người dùng</h1>
                <div class="text-muted small">
                    <a href="${pageContext.request.contextPath}/dashboard/user-roles" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- User Info Card -->
    <div class="card shadow-sm border-0 rounded-3 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex align-items-center">
                <i class="fas fa-user-circle text-primary me-2"></i>
                <span class="fw-bold">Thông tin người dùng</span>
            </div>
        </div>
        <div class="card-body">
            <div class="d-flex align-items-center mb-3">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div>
                    <h5 class="mb-1">${user.fullname}</h5>
                    <div class="d-flex align-items-center text-muted">
                        <i class="fas fa-envelope me-2"></i>
                        <span>${user.email}</span>
                    </div>
                    <div class="mt-2">
                        <span class="badge bg-primary rounded-pill">ID: ${user.id}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Role Assignment Form -->
    <div class="card shadow-sm border-0 rounded-3 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex align-items-center">
                <i class="fas fa-shield-alt text-primary me-2"></i>
                <span class="fw-bold">Phân quyền vai trò</span>
            </div>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/dashboard/user-roles?action=update" method="POST">
                <input type="hidden" name="userId" value="${user.id}">
                
                <div class="mb-4">
                    <p class="text-muted mb-3">
                        <i class="fas fa-info-circle me-1"></i>
                        Chọn vai trò bạn muốn gán cho người dùng này. Người dùng sẽ được yêu cầu đăng nhập lại sau khi thay đổi vai trò.
                    </p>
                    
                    <div class="row g-3">
                        <c:forEach items="${allRoles}" var="role">
                            <div class="col-md-4">
                                <div class="card role-card h-100">
                                    <div class="card-body p-3">
                                        <div class="form-check">
                                            <input class="form-check-input role-check" type="checkbox"
                                                name="roles[]" value="${role.id}" id="role${role.id}"
                                                <c:forEach var="ur" items="${userRoles}">
                                                    <c:if test="${ur.id == role.id}">checked</c:if>
                                                </c:forEach>
                                            >
                                            <label class="form-check-label fw-bold" for="role${role.id}">
                                                ${role.name}
                                            </label>
                                        </div>
                                        <c:if test="${not empty role.description}">
                                            <p class="text-muted small mt-2 mb-0">${role.description}</p>
                                        </c:if>
                                        <c:if test="${empty role.description}">
                                            <p class="text-muted small mt-2 mb-0">Vai trò người dùng trong hệ thống</p>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="d-flex justify-content-end mt-4">
                    <a href="${pageContext.request.contextPath}/dashboard/user-roles" class="btn btn-outline-secondary rounded-pill me-2">
                        <i class="fas fa-times me-1"></i> Hủy
                    </a>
                    <button type="submit" class="btn btn-primary rounded-pill btn-save px-4">
                        <i class="fas fa-save me-1"></i> Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Warning Card -->
    <div class="card bg-light border-0 shadow-sm rounded-3">
        <div class="card-body p-4">
            <div class="d-flex">
                <div class="me-3 text-warning">
                    <i class="fas fa-exclamation-triangle fa-2x"></i>
                </div>
                <div>
                    <h5 class="fw-bold">Lưu ý quan trọng</h5>
                    <p class="mb-0">Việc thay đổi vai trò của người dùng sẽ ảnh hưởng trực tiếp đến quyền truy cập của họ trong hệ thống. Hãy cẩn thận khi thay đổi vai trò của các tài khoản quản trị viên.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Highlight role cards when their checkbox is checked
        const roleCheckboxes = document.querySelectorAll('.role-check');
        
        roleCheckboxes.forEach(checkbox => {
            const updateCardStyle = (cb) => {
                const card = cb.closest('.role-card');
                if (cb.checked) {
                    card.classList.add('border-primary');
                    card.style.borderWidth = '2px';
                } else {
                    card.classList.remove('border-primary');
                    card.style.borderWidth = '1px';
                }
            };
            
            // Initialize card styles
            updateCardStyle(checkbox);
            
            // Update on change
            checkbox.addEventListener('change', function() {
                updateCardStyle(this);
            });
        });
    });
</script>