<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-4 py-4">
    <!-- Breadcrumb và tiêu đề trang -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Dashboard</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chương trình khuyến mãi</li>
            </ol>
        </nav>
        <a href="${pageContext.request.contextPath}/dashboard/sales?action=create" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i>Thêm khuyến mãi mới
        </a>
    </div>

    <!-- Thẻ thống kê -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Tổng khuyến mãi</h5>
                            <h2 class="mt-2 mb-0">${salesCount}</h2>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3">
                            <i class="bi bi-tags fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Đang hoạt động</h5>
                            <h2 class="mt-2 mb-0">${activeCount}</h2>
                        </div>
                        <div class="rounded-circle bg-success-subtle p-3">
                            <i class="bi bi-check-circle fs-1 text-success"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Sắp kết thúc</h5>
                            <h2 class="mt-2 mb-0">${endingSoonCount}</h2>
                        </div>
                        <div class="rounded-circle bg-warning-subtle p-3">
                            <i class="bi bi-clock-history fs-1 text-warning"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Đã kết thúc</h5>
                            <h2 class="mt-2 mb-0">${expiredCount}</h2>
                        </div>
                        <div class="rounded-circle bg-danger-subtle p-3">
                            <i class="bi bi-x-circle fs-1 text-danger"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bộ lọc nhanh -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body py-3">
            <div class="d-flex flex-wrap gap-2">
                <a href="${pageContext.request.contextPath}/dashboard/sales?filter=all" class="btn btn-outline-secondary ${param.filter == 'all' || param.filter == null ? 'active' : ''}">
                    <i class="bi bi-grid me-1"></i>Tất cả
                </a>
                <a href="${pageContext.request.contextPath}/dashboard/sales?filter=active" class="btn btn-outline-success ${param.filter == 'active' ? 'active' : ''}">
                    <i class="bi bi-check-circle me-1"></i>Đang hoạt động
                </a>
                <a href="${pageContext.request.contextPath}/dashboard/sales?filter=upcoming" class="btn btn-outline-primary ${param.filter == 'upcoming' ? 'active' : ''}">
                    <i class="bi bi-calendar-plus me-1"></i>Sắp diễn ra
                </a>
                <a href="${pageContext.request.contextPath}/dashboard/sales?filter=ending" class="btn btn-outline-warning ${param.filter == 'ending' ? 'active' : ''}">
                    <i class="bi bi-clock-history me-1"></i>Sắp kết thúc
                </a>
                <a href="${pageContext.request.contextPath}/dashboard/sales?filter=expired" class="btn btn-outline-danger ${param.filter == 'expired' ? 'active' : ''}">
                    <i class="bi bi-x-circle me-1"></i>Đã kết thúc
                </a>
            </div>
        </div>
    </div>

    <!-- Bảng dữ liệu -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <h5 class="card-title mb-0"><i class="bi bi-tags me-2"></i>Danh sách chương trình khuyến mãi</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="sales" class="table table-hover align-middle border" style="width:100%">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 60px">#</th>
                            <th>Tên chương trình</th>
                            <th>Mô tả</th>
                            <th class="text-center" style="width: 120px">Giảm giá</th>
                            <th class="text-center" style="width: 150px">Ngày bắt đầu</th>
                            <th class="text-center" style="width: 150px">Ngày kết thúc</th>
                            <th class="text-center" style="width: 120px">Trạng thái</th>
                            <th class="text-center" style="width: 150px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="sale" items="${sales}">
                            <tr>
                                <td class="text-center">${sale.id}</td>
                                <td>
                                    <h6 class="mb-0 text-truncate" style="max-width: 200px;">${sale.name}</h6>
                                </td>
                                <td>
                                    <p class="mb-0 text-truncate" style="max-width: 250px;">${sale.description}</p>
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-primary">${sale.discountPercentage}%</span>
                                </td>
                                <td class="text-center">
                                    <fmt:parseDate value="${sale.startDate}" pattern="yyyy-MM-dd" var="parsedStartDate" />
                                    <fmt:formatDate value="${parsedStartDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td class="text-center">
                                    <fmt:parseDate value="${sale.endDate}" pattern="yyyy-MM-dd" var="parsedEndDate" />
                                    <fmt:formatDate value="${parsedEndDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td class="text-center">
                                    <c:set var="now" value="<%= new java.util.Date() %>" />
                                    <c:choose>
                                        <c:when test="${parsedStartDate.time > now.time}">
                                            <span class="badge bg-info">Sắp diễn ra</span>
                                        </c:when>
                                        <c:when test="${parsedEndDate.time < now.time}">
                                            <span class="badge bg-danger">Đã kết thúc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success">Đang hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center gap-2">
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/dashboard/sales?action=edit&id=${sale.id}"
                                               class="btn btn-sm btn-light" title="Sửa">
                                                <i class="bi bi-pencil text-primary"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-light delete-btn"
                                                    data-id="${sale.id}" data-name="${sale.name}" title="Xóa">
                                                <i class="bi bi-trash text-danger"></i>
                                            </button>
                                        </div>
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

<!-- Modal xác nhận xóa -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteModalLabel"><i class="bi bi-exclamation-triangle me-2"></i>Xác nhận xóa</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn xóa chương trình khuyến mãi <strong id="saleName"></strong>?</p>
                <p class="text-danger mb-0"><i class="bi bi-exclamation-circle me-1"></i>Lưu ý: Hành động này không thể hoàn tác!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <form id="deleteForm" method="POST" style="display:inline;">
                    <input type="hidden" name="csrf_token" value="${csrfToken}">
                    <input type="hidden" name="_method" value="DELETE">
                    <button type="submit" class="btn btn-danger" id="confirmDeleteBtn">
                        <i class="bi bi-trash me-1"></i>Xác nhận xóa
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Khởi tạo DataTable
        $('#sales').DataTable({
            pageLength: 10,
            language: {
                url: 'https://cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json'
            },
            dom: '<"row mb-3"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
                '<"row"<"col-sm-12"tr>>' +
                '<"row mt-3"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
            buttons: [
                {
                    extend: 'collection',
                    text: '<i class="bi bi-download me-2"></i>Xuất dữ liệu',
                    className: 'btn btn-primary dropdown-toggle me-2',
                    buttons: [
                        {
                            extend: 'excel',
                            text: '<i class="bi bi-file-earmark-excel me-2"></i>Excel',
                            className: 'dropdown-item',
                            exportOptions: {
                                columns: ':visible:not(:last-child)'
                            }
                        },
                        {
                            extend: 'pdf',
                            text: '<i class="bi bi-file-earmark-pdf me-2"></i>PDF',
                            className: 'dropdown-item',
                            exportOptions: {
                                columns: ':visible:not(:last-child)'
                            }
                        },
                        {
                            extend: 'csv',
                            text: '<i class="bi bi-file-earmark-text me-2"></i>CSV',
                            className: 'dropdown-item',
                            exportOptions: {
                                columns: ':visible:not(:last-child)'
                            }
                        },
                        {
                            extend: 'print',
                            text: '<i class="bi bi-printer me-2"></i>In',
                            className: 'dropdown-item',
                            exportOptions: {
                                columns: ':visible:not(:last-child)'
                            }
                        }
                    ]
                },
                {
                    extend: 'colvis',
                    text: '<i class="bi bi-eye me-2"></i>Hiển thị cột',
                    className: 'btn btn-secondary'
                }
            ],
            order: [[0, 'desc']],
            columnDefs: [
                { targets: [3, 4, 5, 6, 7], orderable: false }
            ]
        });

        // Cấu hình toastr
        toastr.options = {
            "closeButton": true,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "timeOut": "3000"
        };

        // Hiển thị thông báo nếu có
        if ('${message}' !== '') {
            toastr.success('${message}');
        }
        if ('${error}' !== '') {
            toastr.error('${error}');
        }
    });

    // Hàm xác nhận xóa
    function confirmDelete(id, name) {
        $('#saleName').text(name);
        $('#deleteForm').attr('action', '${pageContext.request.contextPath}/dashboard/sales/' + id);
        
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.show();
        
        // Thêm hiệu ứng loading khi xác nhận xóa
        $('#confirmDeleteBtn').on('click', function() {
            const originalHtml = $(this).html();
            $(this).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang xóa...');
            $(this).prop('disabled', true);
            $('#deleteForm').submit();
        });
    }
</script>
