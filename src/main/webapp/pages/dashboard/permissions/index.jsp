<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .permission-icon {
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

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-primary mb-1"><i class="fas fa-key me-2"></i>Quản lý Quyền</h2>
            <p class="text-muted">Quản lý quyền truy cập trong hệ thống</p>
        </div>
        <a href="${pageContext.request.contextPath}/dashboard/permissions?action=create" class="btn btn-primary rounded-pill shadow-sm">
            <i class="fas fa-plus-circle me-2"></i>Thêm Quyền mới
        </a>
    </div>
    
    <!-- Alerts -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm border-start border-success border-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-check-circle me-3 fs-4"></i>
                <div>
                    ${success}
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
                    ${error}
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
                    ${errors.general}
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <!-- Search Box -->
    <div class="card shadow-sm border-0 rounded-3 mb-4">
        <div class="card-body p-3">
            <div class="input-group">
                <span class="input-group-text bg-light border-0">
                    <i class="fas fa-search text-muted"></i>
                </span>
                <input type="text" id="permissionSearch" class="form-control border-0 bg-light" placeholder="Tìm kiếm quyền...">
            </div>
        </div>
    </div>
    
    <!-- Permissions Table Card -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="permissionsTable">
                    <thead class="bg-light">
                        <tr>
                            <th class="py-3 ps-4">ID</th>
                            <th class="py-3">Tên quyền</th>
                            <th class="py-3">Mô tả</th>
                            <th class="py-3 text-end pe-4">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="permission" items="${permissions}">
                            <tr class="permission-item">
                                <td class="ps-4 fw-bold text-muted">${permission.id}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="permission-icon bg-light rounded-circle p-2 me-3">
                                            <i class="fas fa-shield-alt text-primary"></i>
                                        </div>
                                        <span class="fw-medium">${permission.name}</span>
                                    </div>
                                </td>
                                <td class="text-muted">${permission.description}</td>
                                <td class="text-end pe-4">
                                    <div class="btn-group" role="group">
                                        <a href="${pageContext.request.contextPath}/dashboard/permissions?action=edit&id=${permission.id}"
                                           class="btn btn-outline-primary btn-sm rounded-pill me-2" title="Sửa">
                                            <i class="fas fa-edit me-1"></i> Sửa
                                        </a>
                                        <button class="btn btn-outline-danger btn-sm rounded-pill delete-permission-btn" 
                                                data-id="${permission.id}" data-name="${permission.name}" title="Xóa">
                                            <i class="fas fa-trash me-1"></i> Xóa
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty permissions}">
                            <tr>
                                <td colspan="4" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="fas fa-info-circle me-2 fs-4"></i>
                                        <p class="mb-1">Chưa có quyền nào được tạo</p>
                                        <a href="${pageContext.request.contextPath}/dashboard/permissions?action=create" class="btn btn-sm btn-primary mt-2">
                                            <i class="fas fa-plus-circle me-1"></i> Tạo quyền mới
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
                    <h5>Bạn có chắc chắn muốn xóa quyền này?</h5>
                    <p class="text-muted mb-0">Quyền <strong id="permissionName"></strong> sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
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
        const searchInput = document.getElementById('permissionSearch');
        if (searchInput) {
            searchInput.addEventListener('keyup', function() {
                const searchValue = this.value.toLowerCase();
                const permissionItems = document.querySelectorAll('.permission-item');
                
                permissionItems.forEach(item => {
                    const permissionName = item.querySelector('td:nth-child(2)').textContent.toLowerCase();
                    const permissionDesc = item.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    
                    if (permissionName.includes(searchValue) || permissionDesc.includes(searchValue)) {
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
        document.querySelectorAll('.delete-permission-btn').forEach(button => {
            button.addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                const name = this.getAttribute('data-name');
                
                const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
                document.getElementById('permissionName').textContent = name;
                
                document.getElementById('confirmDeleteBtn').onclick = function() {
                    document.getElementById('deleteId').value = id;
                    document.getElementById('deleteForm').submit();
                };
                
                modal.show();
            });
        });
    });
</script>