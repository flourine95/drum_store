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
    
    .search-card {
        border: none;
        border-radius: 12px;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        margin-bottom: 1.5rem;
    }
    
    .search-input {
        border-radius: 50rem;
        padding-left: 2.5rem;
        height: 45px;
    }
    
    .search-icon {
        position: absolute;
        left: 1.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: #0d6efd;
        z-index: 3;
    }
    
    .filter-select {
        border-radius: 50rem;
        height: 45px;
        padding-left: 2.5rem;
        background-position: right 1rem center;
    }
    
    .filter-icon {
        position: absolute;
        left: 1.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: #0d6efd;
        z-index: 3;
    }
    
    .search-btn {
        border-radius: 50rem;
        height: 45px;
        padding-left: 1.5rem;
        padding-right: 1.5rem;
        font-weight: 500;
        box-shadow: 0 0.125rem 0.25rem rgba(13, 110, 253, 0.2);
    }
    
    .search-btn:hover {
        transform: translateY(-1px);
    }
    
    .users-table {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .users-table thead th {
        background-color: #f8f9fa;
        color: #212529;
        font-weight: 600;
        border-bottom: 2px solid #dee2e6;
        padding: 1rem;
    }
    
    .users-table tbody tr:hover {
        background-color: rgba(13, 110, 253, 0.04);
    }
    
    .users-table td {
        padding: 0.75rem 1rem;
        vertical-align: middle;
    }
    
    .role-cell {
        width: 100px;
        text-align: center;
    }
    
    .role-badge {
        display: inline-block;
        padding: 0.4rem 0.65rem;
        border-radius: 50rem;
        font-size: 0.75rem;
        font-weight: 600;
        text-align: center;
        white-space: nowrap;
    }
    
    .role-badge-light {
        background-color: #f8f9fa;
        color: #6c757d;
        border: 1px solid #dee2e6;
    }
    
    .role-check {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 28px;
        height: 28px;
        border-radius: 50%;
        background-color: rgba(25, 135, 84, 0.1);
        color: #198754;
    }
    
    .user-email {
        font-weight: 500;
        color: #212529;
    }
    
    .user-name {
        font-size: 0.875rem;
        color: #6c757d;
    }
    
    .edit-btn {
        border-radius: 50rem;
        padding: 0.4rem 1rem;
        font-weight: 500;
    }
    
    .edit-btn:hover {
        transform: translateY(-1px);
    }
    
    .alert {
        border-radius: 12px;
        border: none;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .pagination-container {
        display: flex;
        justify-content: flex-end;
        margin-top: 1rem;
    }
    
    .pagination .page-link {
        border-radius: 50%;
        margin: 0 0.2rem;
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .pagination .page-item.active .page-link {
        background-color: #0d6efd;
        border-color: #0d6efd;
    }
</style>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <div class="page-title-icon">
            <i class="fas fa-users-cog fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Quản lý vai trò người dùng</h2>
            <p class="text-muted mb-0">Phân quyền cho người dùng trong hệ thống</p>
        </div>
    </div>
    
    <!-- Flash Messages -->
    <c:if test="${not empty sessionScope.success}">
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-check-circle me-2"></i>
                <strong>${sessionScope.success}</strong>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-circle me-2"></i>
                <strong>${sessionScope.error}</strong>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <!-- Search and Filter Card -->
    <div class="card search-card mb-4">
        <div class="card-body p-4">
            <form method="GET" action="${pageContext.request.contextPath}/dashboard/user-roles" class="row g-3">
                <div class="col-md-5 position-relative">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="form-control search-input" id="search" name="search"
                           placeholder="Tìm kiếm theo email hoặc tên người dùng..." value="${search}">
                </div>
                <div class="col-md-5 position-relative">
                    <i class="fas fa-filter filter-icon"></i>
                    <select class="form-select filter-select" id="role" name="role">
                        <option value="">Tất cả vai trò</option>
                        <c:forEach items="${roles}" var="role">
                            <option value="${role.id}" ${roleFilter == role.id ? 'selected' : ''}>
                                ${role.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary search-btn w-100">
                        <i class="fas fa-search me-2"></i>Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Users Role Matrix Card -->
    <div class="card border-0 shadow-sm rounded-3 mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <div>
                <i class="fas fa-table text-primary me-2"></i>
                <span class="fw-bold">Danh sách người dùng và vai trò</span>
            </div>
            <div>
                <span class="badge bg-primary rounded-pill">${matrixList.size()} người dùng</span>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle users-table mb-0">
                    <thead>
                        <tr>
                            <th style="min-width: 250px;">Người dùng</th>
                            <c:forEach items="${roles}" var="role">
                                <th class="role-cell">
                                    <span class="role-badge role-badge-light">${role.name}</span>
                                </th>
                            </c:forEach>
                            <th class="text-end">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${matrixList}" var="matrix">
                            <tr>
                                <td>
                                    <div class="d-flex flex-column">
                                        <span class="user-email">${matrix.userEmail}</span>
                                        <span class="user-name">${matrix.userFullName}</span>
                                    </div>
                                </td>
                                <c:forEach items="${roles}" var="role">
                                    <td class="text-center">
                                        <c:if test="${matrix.roleCheckboxMap[role.id]}">
                                            <div class="role-check">
                                                <i class="fas fa-check"></i>
                                            </div>
                                        </c:if>
                                        <c:if test="${!matrix.roleCheckboxMap[role.id]}">
                                            <span class="text-muted">-</span>
                                        </c:if>
                                    </td>
                                </c:forEach>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/dashboard/user-roles?action=edit&id=${matrix.userId}"
                                       class="btn btn-primary btn-sm edit-btn">
                                        <i class="fas fa-edit me-1"></i> Sửa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer bg-white py-3">
            <div class="d-flex flex-wrap align-items-center">
                <div class="small text-muted mb-2 mb-md-0">
                    <i class="fas fa-info-circle me-1"></i> Hiển thị ${matrixList.size()} / ${totalUsers} người dùng (Trang ${currentPage}/${totalPages})
                </div>
                <div class="ms-auto">
                    <nav aria-label="Pagination">
                        <ul class="pagination pagination-sm mb-0">
                            <!-- Previous page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/dashboard/user-roles?page=${currentPage - 1}${not empty search ? '&search='.concat(search) : ''}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}" aria-label="Previous">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            
                            <!-- First page -->
                            <c:if test="${currentPage > 3}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/user-roles?page=1${not empty search ? '&search='.concat(search) : ''}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}">1</a>
                                </li>
                                <c:if test="${currentPage > 4}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>
                            
                            <!-- Page numbers -->
                            <c:set var="startPage" value="${(currentPage > 2) ? (currentPage - 2) : 1}" />
                            <c:set var="endPage" value="${(totalPages > currentPage + 2) ? (currentPage + 2) : totalPages}" />
                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/user-roles?page=${i}${not empty search ? '&search='.concat(search) : ''}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <!-- Last page -->
                            <c:if test="${currentPage < totalPages - 2}">
                                <c:if test="${currentPage < totalPages - 3}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/dashboard/user-roles?page=${totalPages}${not empty search ? '&search='.concat(search) : ''}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}">${totalPages}</a>
                                </li>
                            </c:if>
                            
                            <!-- Next page -->
                            <li class="page-item ${currentPage == totalPages || totalPages == 0 ? 'disabled' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/dashboard/user-roles?page=${currentPage + 1}${not empty search ? '&search='.concat(search) : ''}${not empty roleFilter ? '&role='.concat(roleFilter) : ''}" aria-label="Next">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Help Card -->
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4">
            <h5 class="card-title fw-bold mb-3">
                <i class="fas fa-info-circle text-primary me-2"></i>Hướng dẫn
            </h5>
            <div class="row">
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Sử dụng bộ lọc để tìm kiếm người dùng theo tên hoặc email</li>
                        <li class="mb-2">Chọn vai trò để lọc danh sách người dùng theo vai trò cụ thể</li>
                        <li>Nhấn vào nút "Sửa" để thay đổi vai trò cho người dùng</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Người dùng sẽ được yêu cầu đăng nhập lại khi vai trò của họ thay đổi</li>
                        <li class="mb-2">Dấu kiểm màu xanh lá chỉ vai trò đã được gán cho người dùng</li>
                        <li>Hãy cẩn thận khi thay đổi vai trò của các tài khoản quản trị viên</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>