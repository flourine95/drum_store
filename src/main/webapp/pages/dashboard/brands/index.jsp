<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-4">
    <!-- Dashboard Header with Stats -->
    <div class="row g-4 mb-4">
        <div class="col-xl-4 col-md-6">
            <div class="card bg-primary text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Tổng thương hiệu</h5>
                            <h2 class="mt-2 mb-0">${brands.size()}</h2>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3">
                            <i class="bi bi-tags-fill fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)">Xem tất cả thương hiệu</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="card bg-success text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Thương hiệu có ảnh</h5>
                            <h2 class="mt-2 mb-0" id="brandsWithImage">--</h2>
                        </div>
                        <div class="rounded-circle bg-success-subtle p-3">
                            <i class="bi bi-image fs-1 text-success"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)">Xem thương hiệu có ảnh</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-6">
            <div class="card bg-info text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Thương hiệu có sản phẩm</h5>
                            <h2 class="mt-2 mb-0" id="brandsWithProducts">--</h2>
                        </div>
                        <div class="rounded-circle bg-info-subtle p-3">
                            <i class="bi bi-box-seam fs-1 text-info"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)">Xem thương hiệu có sản phẩm</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Brands Table Card -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Quản lý thương hiệu</h5>
                <div class="d-flex">
                    <div class="dropdown me-2">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" 
                               id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-download me-1"></i> Xuất dữ liệu
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                            <li><a class="dropdown-item" href="#" id="export-excel"><i class="bi bi-file-earmark-excel me-2"></i>Excel</a></li>
                            <li><a class="dropdown-item" href="#" id="export-pdf"><i class="bi bi-file-earmark-pdf me-2"></i>PDF</a></li>
                            <li><a class="dropdown-item" href="#" id="export-csv"><i class="bi bi-file-earmark-text me-2"></i>CSV</a></li>
                            <li><a class="dropdown-item" href="#" id="export-print"><i class="bi bi-printer me-2"></i>In</a></li>
                        </ul>
                    </div>
                    <a href="${pageContext.request.contextPath}/dashboard/brands?action=create" class="btn btn-success">
                        <i class="bi bi-plus-circle me-2"></i>Thêm thương hiệu
                    </a>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="brands" class="table table-hover align-middle" style="width:100%">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Thương hiệu</th>
                            <th>Mô tả</th>
                            <th>Ngày tạo</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="brand" items="${brands}">
                            <tr>
                                <td>${brand.id}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <c:choose>
                                            <c:when test="${not empty brand.image}">
                                                <img src="${pageContext.request.contextPath}/uploads/brands/${brand.image}" 
                                                     class="rounded me-2" style="width: 48px; height: 48px; object-fit: cover;"
                                                     alt="${brand.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="rounded me-2 bg-light d-flex align-items-center justify-content-center" 
                                                     style="width: 48px; height: 48px;">
                                                    <i class="bi bi-building text-secondary"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div class="fw-semibold text-truncate" style="max-width: 200px;">${brand.name}</div>
                                            <div class="small text-muted">
                                                ID: ${brand.id} 
                                                <c:if test="${brand.productCount > 0}">
                                                    <span class="badge bg-info-subtle text-info rounded-pill ms-1">
                                                        <i class="bi bi-box-seam me-1"></i>${brand.productCount} sản phẩm
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty brand.description}">
                                            <div class="text-truncate" style="max-width: 500px;">${brand.description}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">Không có mô tả</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatDate value="${brand.createdAt}" pattern="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <div class="d-flex gap-1 justify-content-center">
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/dashboard/brands?action=edit&id=${brand.id}"
                                               class="btn btn-sm btn-light" title="Sửa">
                                                <i class="bi bi-pencil text-primary"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-light delete-btn" 
                                                    data-id="${brand.id}" data-name="${brand.name}" title="Xóa">
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

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" id="brandId" />
                <div class="text-center mb-3">
                    <i class="bi bi-exclamation-triangle text-warning fs-1"></i>
                </div>
                <p class="text-center">Bạn có chắc chắn muốn xóa thương hiệu <span id="brandName" class="fw-bold"></span>?</p>
                <p class="text-danger text-center small">Lưu ý: Hành động này không thể hoàn tác.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" id="confirmDeleteBtn" class="btn btn-danger">Xóa</button>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<script>
    $(document).ready(function() {
        // Initialize DataTable with modern styling
        var table = $('#brands').DataTable({
            pageLength: 10,
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tất cả"]],
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/vi.json'
            },
            dom: '<"row mb-3"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
                '<"row"<"col-sm-12"tr>>' +
                '<"row mt-3"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
            buttons: [
                {
                    extend: 'excel',
                    text: 'Excel',
                    exportOptions: {
                        columns: ':visible'
                    },
                    className: 'd-none'
                },
                {
                    extend: 'pdf',
                    text: 'PDF',
                    exportOptions: {
                        columns: ':visible'
                    },
                    className: 'd-none'
                },
                {
                    extend: 'csv',
                    text: 'CSV',
                    exportOptions: {
                        columns: ':visible'
                    },
                    className: 'd-none'
                },
                {
                    extend: 'print',
                    text: 'Print',
                    exportOptions: {
                        columns: ':visible'
                    },
                    className: 'd-none'
                }
            ]
        });
        
        // Calculate and update stats
        function updateBrandStats() {
            // Get total brands count from JSP
            let brandsWithImage = ${brandWithImageCount};
            let brandsWithProducts = ${brandWithProductCount};
            // Update the stats in the UI
            $('#brandsWithImage').text(brandsWithImage);
            $('#brandsWithProducts').text(brandsWithProducts);
        }
        
        // Export buttons functionality
        $('#export-excel').on('click', function() {
            table.button('.buttons-excel').trigger();
        });
        
        $('#export-pdf').on('click', function() {
            table.button('.buttons-pdf').trigger();
        });
        
        $('#export-csv').on('click', function() {
            table.button('.buttons-csv').trigger();
        });
        
        $('#export-print').on('click', function() {
            table.button('.buttons-print').trigger();
        });
        
        // Delete brand functionality
        $('.delete-btn').on('click', function() {
            const brandId = $(this).data('id');
            const brandName = $(this).data('name');
            
            $('#brandId').val(brandId);
            $('#brandName').text(brandName);
            $('#deleteModal').modal('show');
        });
        
        $('#confirmDeleteBtn').on('click', function() {
            const brandId = $('#brandId').val();
            
            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/brands?aciton=delete&id=' + brandId,
                type: 'POST',
                success: function(response) {
                    $('#deleteModal').modal('hide');
                    
                    if (response.success) {
                        showSuccessAlert('Thành công', 'Thương hiệu đã được xóa thành công!', function() {
                            window.location.reload();
                        });
                    } else {
                        showErrorAlert('Lỗi', response.message || 'Không thể xóa thương hiệu này.');
                    }
                },
                error: function() {
                    $('#deleteModal').modal('hide');
                    showErrorAlert('Lỗi', 'Đã xảy ra lỗi khi xóa thương hiệu. Vui lòng thử lại sau.');
                }
            });
        });
        
        // Initialize stats
        updateBrandStats();
    });
</script>
