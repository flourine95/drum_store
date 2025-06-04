<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

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
    
    .user-status {
        width: 10px;
        height: 10px;
        border-radius: 50%;
        display: inline-block;
        margin-right: 5px;
    }
    
    .status-active {
        background-color: #10b981;
    }
    
    .status-inactive {
        background-color: #ef4444;
    }
    
    .user-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background-color: #e9ecef;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        color: #6c757d;
        margin-right: 10px;
    }
    
    .role-badge {
        font-size: 0.7rem;
        padding: 0.25em 0.6em;
        font-weight: 500;
    }
    
    .action-btn {
        width: 32px;
        height: 32px;
        padding: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 6px;
        margin-right: 5px;
        transition: all 0.2s;
    }
    
    .action-btn:hover {
        transform: translateY(-2px);
    }
    
    .dataTables_wrapper .dataTables_length, 
    .dataTables_wrapper .dataTables_filter {
        margin-bottom: 1rem;
    }
    
    .dataTables_wrapper .dataTables_filter input {
        border-radius: 20px;
        padding-left: 15px;
        border: 1px solid #dee2e6;
    }
    
    .dataTables_wrapper .dataTables_filter input:focus {
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        border-color: #86b7fe;
    }
    
    .dataTables_wrapper .dataTables_paginate .paginate_button.current {
        background: #0d6efd !important;
        color: white !important;
        border: 1px solid #0d6efd !important;
        border-radius: 50%;
    }
    
    .dataTables_wrapper .dataTables_paginate .paginate_button:not(.current):hover {
        background: #e9ecef !important;
        color: #212529 !important;
        border: 1px solid #dee2e6 !important;
    }
    
    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 50%;
    }
    
    .user-table-container {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
</style>

<div class="container-fluid px-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center justify-content-between mb-4 mt-4">
        <div class="d-flex align-items-center">
            <div class="page-title-icon bg-primary bg-opacity-10 text-primary">
                <i class="fas fa-users"></i>
            </div>
            <div>
                <h1 class="mb-0 fs-4 fw-bold">Quản lý người dùng</h1>
                <div class="text-muted small">
                    Quản lý tất cả tài khoản người dùng trong hệ thống
                </div>
            </div>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/dashboard/users/new" class="btn btn-primary rounded-pill">
                <i class="fas fa-user-plus me-1"></i> Thêm người dùng
            </a>
            <a href="${pageContext.request.contextPath}/dashboard/user-roles" class="btn btn-outline-primary rounded-pill ms-2">
                <i class="fas fa-user-tag me-1"></i> Quản lý vai trò
            </a>
        </div>
    </div>
    
    <!-- Flash Messages -->
    <c:if test="${not empty flashMessage}">
        <div class="alert alert-${flashType} alert-dismissible fade show" role="alert">
            <i class="fas fa-${flashType == 'success' ? 'check-circle' : flashType == 'danger' ? 'exclamation-circle' : 'info-circle'} me-2"></i>
            ${flashMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <!-- User Stats Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3 bg-primary bg-opacity-10 p-3 rounded">
                            <i class="fas fa-users text-primary fa-2x"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1">Tổng người dùng</h6>
                            <h2 class="mb-0 fw-bold">${users.size()}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3 bg-success bg-opacity-10 p-3 rounded">
                            <i class="fas fa-user-check text-success fa-2x"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1">Người dùng hoạt động</h6>
                            <h2 class="mb-0 fw-bold">
                                <c:set var="activeUsers" value="0" />
                                <c:forEach var="user" items="${users}">
                                    <c:if test="${user.status == true}"><c:set var="activeUsers" value="${activeUsers + 1}" /></c:if>
                                </c:forEach>
                                ${activeUsers}
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3 bg-warning bg-opacity-10 p-3 rounded">
                            <i class="fas fa-user-shield text-warning fa-2x"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1">Quản trị viên</h6>
                            <h2 class="mb-0 fw-bold">
                                <c:set var="adminUsers" value="0" />
                                <c:forEach var="user" items="${users}">
                                    <c:if test="${user.role == 'ADMIN'}"><c:set var="adminUsers" value="${adminUsers + 1}" /></c:if>
                                </c:forEach>
                                ${adminUsers}
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3 bg-danger bg-opacity-10 p-3 rounded">
                            <i class="fas fa-user-times text-danger fa-2x"></i>
                        </div>
                        <div>
                            <h6 class="text-muted mb-1">Người dùng không hoạt động</h6>
                            <h2 class="mb-0 fw-bold">
                                <c:set var="inactiveUsers" value="0" />
                                <c:forEach var="user" items="${users}">
                                    <c:if test="${user.status == false}"><c:set var="inactiveUsers" value="${inactiveUsers + 1}" /></c:if>
                                </c:forEach>
                                ${inactiveUsers}
                            </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Users Table -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex align-items-center">
                <i class="fas fa-table text-primary me-2"></i>
                <span class="fw-bold">Danh sách người dùng</span>
            </div>
        </div>
        <div class="card-body">
            <div class="user-table-container">
                <table id="users" class="table table-hover border-top-0 mb-0" style="width:100%">
                    <thead class="table-light">
                        <tr>
                            <th class="border-0">#</th>
                            <th class="border-0">Người dùng</th>
                            <th class="border-0">Email</th>
                            <th class="border-0">Vai trò</th>
                            <th class="border-0">Trạng thái</th>
                            <th class="border-0">Ngày tạo</th>
                            <th class="border-0 text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar">
                                            <c:choose>
                                                <c:when test="${not empty user.avatar}">
                                                    <img src="${user.avatar}" alt="${user.fullname}" class="img-fluid rounded-circle">
                                                </c:when>
                                                <c:otherwise>
                                                    ${fn:substring(user.fullname, 0, 1).toUpperCase()}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="fw-medium">${user.fullname}</div>
                                            <c:if test="${not empty user.phone}">
                                                <div class="text-muted small">${user.phone}</div>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                                <td>${user.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.role == 'ADMIN'}">                                            
                                            <span class="badge bg-danger role-badge">Quản trị viên</span>
                                        </c:when>
                                        <c:when test="${user.role == 'STAFF'}">                                            
                                            <span class="badge bg-info role-badge">Nhân viên</span>
                                        </c:when>
                                        <c:when test="${user.role == 'CUSTOMER'}">                                            
                                            <span class="badge bg-success role-badge">Khách hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary role-badge">${user.role}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <span class="user-status ${user.status ? 'status-active' : 'status-inactive'}"></span>
                                        <span>${user.status ? 'Hoạt động' : 'Không hoạt động'}</span>
                                    </div>
                                </td>
                                <td>${user.createdAt}</td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center">
                                        <a href="${pageContext.request.contextPath}/dashboard/users/${user.id}" class="btn btn-sm btn-outline-info action-btn" data-bs-toggle="tooltip" data-bs-title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/dashboard/users/${user.id}/edit" class="btn btn-sm btn-outline-primary action-btn" data-bs-toggle="tooltip" data-bs-title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/dashboard/user-roles/edit?userId=${user.id}" class="btn btn-sm btn-outline-warning action-btn" data-bs-toggle="tooltip" data-bs-title="Phân quyền">
                                            <i class="fas fa-user-tag"></i>
                                        </a>
                                        <form action="${pageContext.request.contextPath}/dashboard/users/${user.id}" method="POST" class="d-inline">
                                            <input type="hidden" name="csrf_token" value="${csrfToken}">
                                            <input type="hidden" name="_method" value="DELETE">
                                            <button type="submit" class="btn btn-sm btn-outline-danger action-btn" data-bs-toggle="tooltip" data-bs-title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa người dùng này không?');">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Include DataTables -->
<script src="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.1.8/b-3.2.0/b-colvis-3.2.0/b-html5-3.2.0/b-print-3.2.0/fh-4.0.1/cr-2.0.4/fc-5.0.4/kt-2.12.1/r-3.0.3/sb-1.8.1/sp-2.3.3/sl-2.1.0/sr-1.4.1/datatables.min.js"></script>

<script>
    $(document).ready(function () {
        // Initialize tooltips
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
        
        // Initialize DataTable
        $('#users').DataTable({
            pageLength: 10,
            responsive: true,
            language: {
                search: "<i class='fas fa-search'></i> Tìm kiếm:",
                lengthMenu: "Hiển thị _MENU_ mục",
                info: "Hiển thị _START_ đến _END_ trong _TOTAL_ mục",
                paginate: {
                    first: "<i class='fas fa-angle-double-left'></i>",
                    last: "<i class='fas fa-angle-double-right'></i>",
                    next: "<i class='fas fa-angle-right'></i>",
                    previous: "<i class='fas fa-angle-left'></i>"
                },
                emptyTable: "Không có dữ liệu",
                infoEmpty: "Hiển thị 0 đến 0 trong 0 mục",
                infoFiltered: "(lọc từ _MAX_ mục)",
                zeroRecords: "Không tìm thấy kết quả phù hợp"
            },
            dom: '<"row"<"col-sm-6"l><"col-sm-6"f>>rtip'
        });
    });
</script>

