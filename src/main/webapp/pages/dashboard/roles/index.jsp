<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-primary mb-1"><i class="fas fa-users-cog me-2"></i>Quản lý Vai trò</h2>
            <p class="text-muted">Quản lý và phân quyền người dùng trong hệ thống</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard/roles?action=create" class="btn btn-primary rounded-pill shadow-sm">
            <i class="fas fa-plus-circle me-2"></i>Thêm Vai trò mới
        </a>
    </div>
    
    <!-- Alerts -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm border-start border-success border-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-check-circle me-3 fs-4"></i>
                <div>
                    <strong>Thành công!</strong> ${success}
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-start border-danger border-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-circle me-3 fs-4"></i>
                <div>
                    <strong>Lỗi!</strong> ${error}
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errors.general}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-start border-danger border-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-circle me-3 fs-4"></i>
                <div>
                    <strong>Lỗi!</strong> ${errors.general}
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Roles Card -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold text-primary">Danh sách vai trò</h5>
            <div class="input-group" style="width: 300px;">
                <span class="input-group-text bg-light border-end-0">
                    <i class="fas fa-search text-muted"></i>
                </span>
                <input type="text" id="roleSearch" class="form-control border-start-0 ps-0" placeholder="Tìm kiếm vai trò...">
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="rolesTable">
                    <thead class="bg-light">
                        <tr>
                            <th class="py-3 ps-4">ID</th>
                            <th class="py-3">Tên vai trò</th>
                            <th class="py-3">Mô tả</th>
                            <th class="py-3 text-end pe-4">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="role" items="${roles}">
                            <tr class="role-item">
                                <td class="ps-4 fw-bold text-muted">${role.id}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="role-icon bg-light rounded-circle p-2 me-3">
                                            <i class="fas fa-user-tag text-primary"></i>
                                        </div>
                                        <span class="fw-medium">${role.name}</span>
                                    </div>
                                </td>
                                <td class="text-muted">${role.description}</td>
                                <td class="text-end pe-4">
                                    <div class="btn-group" role="group">
                                        <a href="${pageContext.request.contextPath}/dashboard/roles?action=edit&id=${role.id}"
                                           class="btn btn-outline-primary btn-sm rounded-pill me-2" title="Sửa">
                                            <i class="fas fa-edit me-1"></i> Sửa
                                        </a>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill delete-role-btn" 
                                                data-id="${role.id}" data-name="${role.name}" title="Xóa">
                                            <i class="fas fa-trash me-1"></i> Xóa
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty roles}">
                            <tr>
                                <td colspan="4" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="fas fa-info-circle me-2 fs-4"></i>
                                        <p class="mb-1">Chưa có vai trò nào được tạo</p>
                                        <a href="${pageContext.request.contextPath}/dashboard/roles?action=create" class="btn btn-sm btn-primary mt-2">
                                            <i class="fas fa-plus-circle me-1"></i> Tạo vai trò mới
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Delete Form -->
<form id="deleteForm" method="POST" style="display: none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" id="deleteId">
</form>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header border-0 bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel">
                    <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body py-4">
                <div class="text-center mb-4">
                    <div class="avatar avatar-lg bg-danger-subtle rounded-circle mb-3">
                        <i class="fas fa-trash text-danger fs-3"></i>
                    </div>
                    <h5>Bạn có chắc chắn muốn xóa vai trò này?</h5>
                    <p class="text-muted mb-0">Vai trò <strong id="roleName"></strong> sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Hủy bỏ
                </button>
                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="fas fa-trash me-1"></i> Xác nhận xóa
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Search functionality
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.getElementById('roleSearch');
        if (searchInput) {
            searchInput.addEventListener('keyup', function() {
                const searchValue = this.value.toLowerCase();
                const roleItems = document.querySelectorAll('.role-item');
                
                roleItems.forEach(item => {
                    const roleName = item.querySelector('td:nth-child(2)').textContent.toLowerCase();
                    const roleDesc = item.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    
                    if (roleName.includes(searchValue) || roleDesc.includes(searchValue)) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });
        }
    });
    
    // Delete confirmation using event delegation
    document.addEventListener('DOMContentLoaded', function() {
        // Add event listeners to all delete buttons
        document.querySelectorAll('.delete-role-btn').forEach(button => {
            button.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                const name = this.getAttribute('data-name');
                
                const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
                document.getElementById('roleName').textContent = name;
                
                document.getElementById('confirmDeleteBtn').onclick = function() {
                    document.getElementById('deleteId').value = id;
                    document.getElementById('deleteForm').submit();
                };
                
                modal.show();
            });
        });
    });
</script>

<style>
    .role-icon {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
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
