<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid px-4">
    <!-- Dashboard Header with Stats -->
    <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
            <div class="card bg-primary text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Tổng sản phẩm</h5>
                            <h2 class="mt-2 mb-0" id="totalProducts">--</h2>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3">
                            <i class="bi bi-box-seam fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('all')">Xem tất cả sản phẩm</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-success text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Còn hàng</h5>
                            <h2 class="mt-2 mb-0" id="inStockProducts">--</h2>
                        </div>
                        <div class="rounded-circle bg-success-subtle p-3">
                            <i class="bi bi-check-circle fs-1 text-success"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('inStock')">Xem sản phẩm còn hàng</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-warning text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Sản phẩm nổi bật</h5>
                            <h2 class="mt-2 mb-0" id="featuredProducts">--</h2>
                        </div>
                        <div class="rounded-circle bg-warning-subtle p-3">
                            <i class="bi bi-star fs-1 text-warning"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('featured')">Xem sản phẩm nổi bật</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-danger text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Hết hàng</h5>
                            <h2 class="mt-2 mb-0" id="outOfStockProducts">--</h2>
                        </div>
                        <div class="rounded-circle bg-danger-subtle p-3">
                            <i class="bi bi-exclamation-triangle fs-1 text-danger"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('outOfStock')">Xem sản phẩm hết hàng</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Products Table Card -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Quản lý sản phẩm</h5>
                <a href="${pageContext.request.contextPath}/dashboard/products?action=create" class="btn btn-success">
                    <i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm
                </a>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="products" class="table table-hover align-middle" style="width:100%">
                    <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>Sản phẩm</th>
                        <th>Giá cơ bản</th>
                        <th>Danh mục</th>
                        <th>Thương hiệu</th>
                        <th>Biến thể</th>
                        <th>Tồn kho</th>
                        <th>Lượt xem</th>
                        <th>Đánh giá</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
// Function to apply filters to the product table
function applyFilter(filterType) {
    const table = $('#products').DataTable();
    
    // Clear any existing search/filter
    table.search('').columns().search('').draw();
    
    switch(filterType) {
        case 'all':
            // Show all products (no filter)
            break;
        case 'inStock':
            // Filter for in-stock products
            table.column(6).search('Còn hàng|Sắp hết', true, false).draw();
            break;
        case 'featured':
            // Filter for featured products
            table.column(3).search('Nổi bật', true, false).draw();
            break;
        case 'outOfStock':
            // Filter for out-of-stock products
            table.column(6).search('Hết hàng', true, false).draw();
            break;
    }
    
    // Scroll to the table
    $('html, body').animate({
        scrollTop: $('#products').offset().top - 100
    }, 500);
}

$(document).ready(function() {
    // Initialize DataTable with modern styling
    const dataTable = $('#products').DataTable({
        processing: true,
        serverSide: false,
        ajax: {
            url: '${pageContext.request.contextPath}/api/products',
            dataSrc: function(json) {
                // Update dashboard stats
                updateDashboardStats(json);
                return json;
            }
        },
        columns: [
            { data: 'id' },
            { 
                data: null,
                render: function(data) {
                    let image = data.mainImage ? 
                        `<img src="${pageContext.request.contextPath}/assets/images/products/\${data.mainImage}"
                              class="rounded me-2" style="width: 48px; height: 48px; object-fit: cover;">` : 
                        `<div class="rounded me-2 bg-light d-flex align-items-center justify-content-center" 
                              style="width: 48px; height: 48px;"><i class="bi bi-image text-secondary"></i></div>`;
                    
                    let featuredBadge = data.featured ? 
                        '<span class="badge bg-warning text-dark ms-1"><i class="bi bi-star-fill me-1"></i>Nổi bật</span>' : '';
                    
                    return `
                        <div class="d-flex align-items-center">
                            \${image}
                            <div>
                                <div class="fw-semibold text-truncate" style="max-width: 200px;">\${data.name}</div>
                                <div class="small text-muted">ID: \${data.id} \${featuredBadge}</div>
                            </div>
                        </div>
                    `;
                }
            },
            { 
                data: 'basePrice',
                render: function(data, type, row) {
                    if (type === 'display') {
                        const formattedPrice = new Intl.NumberFormat('vi-VN', { 
                            style: 'currency', 
                            currency: 'VND' 
                        }).format(data);
                        
                        const discountBadge = row.discountPercent > 0 ? 
                            `<div class="small mt-1"><span class="badge bg-danger">-\${row.discountPercent}%</span></div>` : '';
                            
                        return `<div>\${formattedPrice}\${discountBadge}</div>`;
                    }
                    return data;
                }
            },
            { 
                data: 'categoryName',
                render: function(data) {
                    return `<span class="badge bg-light text-dark border">\${data}</span>`;
                }
            },
            { 
                data: 'brandName',
                render: function(data) {
                    return `<span class="badge bg-light text-dark border">\${data}</span>`;
                }
            },
            {
                data: null,
                render: function(data) {
                    return `
                        <div class="d-flex flex-column gap-1">
                            <div><span class="badge bg-primary-subtle text-primary"><i class="bi bi-palette me-1"></i>\${data.totalColors}</span></div>
                            <div><span class="badge bg-info-subtle text-info"><i class="bi bi-plus-circle me-1"></i>\${data.totalAddons}</span></div>
                            <div><span class="badge bg-secondary-subtle text-secondary"><i class="bi bi-boxes me-1"></i>\${data.totalVariants}</span></div>
                        </div>
                    `;
                }
            },
            { 
                data: 'stock',
                render: function(data) {
                    let badgeClass = data > 10 ? 'success' : (data > 0 ? 'warning' : 'danger');
                    let status = data > 10 ? 'Còn hàng' : (data > 0 ? 'Sắp hết' : 'Hết hàng');
                    let icon = data > 10 ? 'bi-check-circle' : (data > 0 ? 'bi-exclamation-circle' : 'bi-x-circle');
                    
                    return `
                        <div class="text-center">
                            <div class="badge bg-\${badgeClass}-subtle text-\${badgeClass} mb-1">
                                <i class="bi \${icon} me-1"></i>\${status}
                            </div>
                            <div class="fw-semibold">\${data}</div>
                        </div>
                    `;
                }
            },
            { 
                data: 'totalViews',
                render: function(data) {
                    return `
                        <div class="text-center">
                            <div><i class="bi bi-eye text-info me-1"></i></div>
                            <div class="fw-semibold">\${data.toLocaleString('vi-VN')}</div>
                        </div>
                    `;
                }
            },
            { 
                data: null,
                render: function(data) {
                    // Create star rating with proper icons
                    const rating = data.avgRating || 0;
                    const fullStars = Math.floor(rating);
                    const halfStar = rating % 1 >= 0.5;
                    const emptyStars = 5 - fullStars - (halfStar ? 1 : 0);
                    
                    let starsHtml = '';
                    for (let i = 0; i < fullStars; i++) {
                        starsHtml += '<i class="bi bi-star-fill text-warning"></i>';
                    }
                    if (halfStar) {
                        starsHtml += '<i class="bi bi-star-half text-warning"></i>';
                    }
                    for (let i = 0; i < emptyStars; i++) {
                        starsHtml += '<i class="bi bi-star text-warning"></i>';
                    }
                    
                    return `
                        <div class="text-center">
                            <div>\${starsHtml}</div>
                            <div class="small text-muted mt-1">\${data.totalReviews} đánh giá</div>
                        </div>
                    `;
                }
            },
            { 
                data: 'status',
                render: function(data) {
                    let badge, icon;
                    switch(data) {
                        case 1:
                            badge = '<span class="badge bg-success-subtle text-success"><i class="bi bi-check-circle me-1"></i>Hoạt động</span>';
                            break;
                        case 0:
                            badge = '<span class="badge bg-danger-subtle text-danger"><i class="bi bi-x-circle me-1"></i>Không hoạt động</span>';
                            break;
                        default:
                            badge = '<span class="badge bg-secondary-subtle text-secondary"><i class="bi bi-question-circle me-1"></i>Không xác định</span>';
                    }
                    return `<div class="text-center">\${badge}</div>`;
                }
            },
            {
                data: 'id',
                orderable: false,
                className: 'text-center',
                render: function(data) {
                    return `
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard/products?action=edit&id=\${data}">
                                        <i class="bi bi-pencil me-2 text-primary"></i>Chỉnh sửa
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/product/\${data}" target="_blank">
                                        <i class="bi bi-eye me-2 text-info"></i>Xem sản phẩm
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="javascript:void(0)" onclick="deleteProduct(\${data})">
                                        <i class="bi bi-trash me-2"></i>Xóa
                                    </a>
                                </li>
                            </ul>
                        </div>
                    `;
                }
            }
        ],
        order: [[0, 'desc']], // Sắp xếp mặc định theo ID giảm dần
        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tất cả"]],
        language: {
            url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json'
        },
        dom: '<"row mb-3"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row mt-3"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
        buttons: [
            {
                extend: 'collection',
                text: '<i class="bi bi-download me-2"></i>Xuất dữ liệu',
                className: 'btn btn-light border shadow-sm me-2',
                buttons: [
                    {
                        extend: 'excel',
                        text: '<i class="bi bi-file-earmark-excel me-2 text-success"></i>Excel',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'pdf',
                        text: '<i class="bi bi-file-earmark-pdf me-2 text-danger"></i>PDF',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'csv',
                        text: '<i class="bi bi-file-earmark-text me-2 text-primary"></i>CSV',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'print',
                        text: '<i class="bi bi-printer me-2 text-secondary"></i>In',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    }
                ]
            },
            {
                extend: 'colvis',
                text: '<i class="bi bi-eye me-2"></i>Hiển thị cột',
                className: 'btn btn-light border shadow-sm'
            }
        ],
        responsive: true,
        rowId: 'id',
        drawCallback: function() {
            // Initialize tooltips after table draw
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
            tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        }
    });
    
    // Fetch initial stats
    fetchDashboardStats();
});

// Function to update dashboard stats
function updateDashboardStats(data) {
    if (!data || !Array.isArray(data)) return;
    
    const totalProducts = data.length;
    const inStockProducts = data.filter(p => p.stock > 0).length;
    const outOfStockProducts = data.filter(p => p.stock <= 0).length;
    const featuredProducts = data.filter(p => p.featured).length;
    
    $('#totalProducts').text(totalProducts);
    $('#inStockProducts').text(inStockProducts);
    $('#outOfStockProducts').text(outOfStockProducts);
    $('#featuredProducts').text(featuredProducts);
}

// Function to fetch dashboard stats separately if needed
function fetchDashboardStats() {
    fetch('${pageContext.request.contextPath}/api/products/stats')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data) {
                $('#totalProducts').text(data.totalProducts || '--');
                $('#inStockProducts').text(data.inStockProducts || '--');
                $('#outOfStockProducts').text(data.outOfStockProducts || '--');
                $('#featuredProducts').text(data.featuredProducts || '--');
            }
        })
        .catch(error => {
            console.error('Error fetching dashboard stats:', error);
            // Fallback to calculating from table data
            setTimeout(() => {
                const tableData = $('#products').DataTable().data();
                if (tableData && tableData.length) {
                    updateDashboardStats(tableData);
                }
            }, 1000);
        });
}

function deleteProduct(productId) {
    Swal.fire({
        title: 'Xác nhận xóa',
        text: 'Bạn có chắc muốn xóa sản phẩm này không?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy'
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading state
            Swal.fire({
                title: 'Đang xử lý...',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
            
            fetch('${pageContext.request.contextPath}/api/products/' + productId, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    $('#products').DataTable().ajax.reload();
                    fetchDashboardStats(); // Refresh stats
                    
                    Swal.fire({
                        title: 'Thành công!',
                        text: 'Xóa sản phẩm thành công',
                        icon: 'success',
                        timer: 2000,
                        showConfirmButton: false
                    });
                } else {
                    Swal.fire({
                        title: 'Lỗi!',
                        text: data.message || 'Có lỗi xảy ra khi xóa sản phẩm',
                        icon: 'error'
                    });
                }
            })
            .catch(error => {
                console.error('Error:', error);
                Swal.fire({
                    title: 'Lỗi!',
                    text: 'Có lỗi xảy ra khi xóa sản phẩm',
                    icon: 'error'
                });
            });
        }
    });
}
</script>
