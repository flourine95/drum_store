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
    
    .matrix-table {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .matrix-table thead th {
        position: sticky;
        top: 0;
        background-color: #f8f9fa;
        color: #212529;
        font-weight: 600;
        z-index: 1;
        padding: 1rem;
        border-bottom: 2px solid #dee2e6;
    }
    
    .matrix-table tbody tr:hover {
        background-color: rgba(13, 110, 253, 0.04);
    }
    
    .matrix-table td, .matrix-table th {
        vertical-align: middle;
        text-align: center;
        padding: 0.75rem 1rem;
    }
    
    .text-start {
        text-align: left !important;
    }
    
    .clickable-col {
        cursor: pointer;
        user-select: none;
        transition: all 0.2s;
    }
    
    .clickable-col:hover {
        background-color: rgba(13, 110, 253, 0.1) !important;
        color: #0d6efd;
    }
    
    .permission-name {
        font-weight: 500;
        color: #212529;
    }
    
    .permission-desc {
        display: block;
        font-size: 0.85rem;
        color: #6c757d;
        margin-top: 0.25rem;
    }
    
    .form-check-input {
        width: 1.2rem;
        height: 1.2rem;
        cursor: pointer;
        border-color: #adb5bd;
    }
    
    .form-check-input:checked {
        background-color: #0d6efd;
        border-color: #0d6efd;
    }
    
    .role-column {
        min-width: 120px;
        border-left: 1px solid #dee2e6;
    }
    
    .role-name {
        font-weight: 500;
        white-space: nowrap;
    }
    
    .role-badge {
        display: block;
        font-size: 0.75rem;
        margin-top: 0.25rem;
        padding: 0.25rem 0.5rem;
        border-radius: 50rem;
        background-color: rgba(13, 110, 253, 0.1);
        color: #0d6efd;
    }
    
    .save-btn {
        border-radius: 50rem;
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        box-shadow: 0 0.125rem 0.25rem rgba(13, 110, 253, 0.2);
    }
    
    .save-btn:hover {
        transform: translateY(-1px);
    }
    
    .select-all-text {
        font-size: 0.75rem;
        color: #6c757d;
        margin-top: 0.25rem;
    }
</style>

<div class="container-fluid py-4">
    <!-- Page Header -->
    <div class="d-flex align-items-center mb-4">
        <div class="page-title-icon">
            <i class="fas fa-user-shield fs-4"></i>
        </div>
        <div>
            <h2 class="fw-bold text-primary mb-1">Quản lý Vai trò & Quyền</h2>
            <p class="text-muted mb-0">Phân quyền cho từng vai trò trong hệ thống</p>
        </div>
    </div>
    
    <div class="card shadow-sm border-0 rounded-3 mb-4">
        <div class="card-body p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <p class="mb-0"><i class="fas fa-info-circle text-primary me-2"></i> Chọn các quyền mà bạn muốn gán cho từng vai trò</p>
                </div>
                <div class="d-flex align-items-center">
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fas fa-search text-primary"></i>
                        </span>
                        <input type="text" id="permissionSearch" class="form-control" placeholder="Tìm quyền...">
                    </div>
                </div>
            </div>
            
            <form id="rolePermissionForm" method="post" action="${pageContext.request.contextPath}/dashboard/role-permissions">
                <div class="table-responsive">
                    <table class="table table-hover align-middle matrix-table">
                        <thead>
                        <tr>
                            <th class="text-start" style="min-width: 250px;">Quyền</th>
                            <c:forEach var="role" items="${roles}">
                                <th class="clickable-col role-column" data-role-id="${role.id}">
                                    <span class="role-name">${role.name}</span>
                                    <span class="role-badge">ID: ${role.id}</span>
                                    <div class="select-all-text">Chọn tất cả</div>
                                </th>
                            </c:forEach>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="row" items="${matrixList}">
                            <tr class="permission-row">
                                <td class="text-start">
                                    <span class="permission-name">${row.permissionName}</span>
                                    <c:if test="${not empty row.permissionDescription}">
                                        <small class="permission-desc">${row.permissionDescription}</small>
                                    </c:if>
                                </td>
                                <c:forEach var="role" items="${roles}">
                                    <td>
                                        <div class="form-check d-flex justify-content-center">
                                            <input type="checkbox"
                                                   class="form-check-input role-${role.id}"
                                                   name="permissions[${row.permissionId}][]"
                                                   value="${role.id}"
                                                   <c:if test="${row.roleCheckboxMap[role.id]}">checked</c:if> />
                                        </div>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="d-flex justify-content-end mt-4">
                    <button type="submit" class="btn btn-primary save-btn">
                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-body p-4">
            <h5 class="card-title fw-bold mb-3">
                <i class="fas fa-info-circle text-primary me-2"></i>Hướng dẫn
            </h5>
            <div class="row">
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Nhấp vào tiêu đề vai trò để chọn/bỏ chọn tất cả quyền cho vai trò đó</li>
                        <li class="mb-2">Nhấp vào hàng để chọn/bỏ chọn tất cả vai trò cho quyền đó</li>
                        <li>Sử dụng ô tìm kiếm để lọc quyền theo tên hoặc mô tả</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="text-muted ps-3 mb-0">
                        <li class="mb-2">Các thay đổi chỉ được lưu khi bạn nhấn nút "Lưu thay đổi"</li>
                        <li class="mb-2">Người dùng sẽ được yêu cầu đăng nhập lại khi quyền của họ thay đổi</li>
                        <li>Hãy cẩn thận khi thay đổi quyền của vai trò quản trị viên</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Handle row click to toggle all checkboxes in that row
        $(".permission-row").on("click", function (e) {
            if (!$(e.target).is("input[type='checkbox']")) {
                const $checkboxes = $(this).find("input[type='checkbox']");
                const allChecked = $checkboxes.filter(":checked").length === $checkboxes.length;
                $checkboxes.prop("checked", !allChecked);
            }
        });

        // Handle column header click to toggle all checkboxes in that column
        $("thead th.clickable-col").each(function (index) {
            $(this).on("click", function () {
                const colIndex = index + 2; // +2 because of the first column and 1-based indexing
                const $checkboxes = $(`tbody td:nth-child(\${colIndex}) input[type='checkbox']`);
                const allChecked = $checkboxes.toArray().every(cb => cb.checked);
                $checkboxes.prop("checked", !allChecked);
                
                // Update visual feedback
                const $selectAllText = $(this).find(".select-all-text");
                if (allChecked) {
                    $selectAllText.html("Bỏ chọn tất cả");
                } else {
                    $selectAllText.html("Chọn tất cả");
                }
            });
        });
        
        // Permission search functionality
        $("#permissionSearch").on("keyup", function() {
            const value = $(this).val().toLowerCase();
            $(".permission-row").filter(function() {
                const permissionText = $(this).find(".permission-name").text().toLowerCase();
                const descriptionText = $(this).find(".permission-desc").text().toLowerCase();
                const matches = permissionText.indexOf(value) > -1 || descriptionText.indexOf(value) > -1;
                $(this).toggle(matches);
            });
        });
        
        // Initialize select-all text based on current state
        $("thead th.clickable-col").each(function(index) {
            const colIndex = index + 2;
            const $checkboxes = $(`tbody td:nth-child(\${colIndex}) input[type='checkbox']`);
            const allChecked = $checkboxes.toArray().every(cb => cb.checked);
            const $selectAllText = $(this).find(".select-all-text");
            
            if (allChecked) {
                $selectAllText.html("Bỏ chọn tất cả");
            } else {
                $selectAllText.html("Chọn tất cả");
            }
        });
        
        // Add visual feedback when hovering over rows
        $(".permission-row").hover(
            function() {
                $(this).addClass("bg-light");
            },
            function() {
                $(this).removeClass("bg-light");
            }
        );
    });
</script>
