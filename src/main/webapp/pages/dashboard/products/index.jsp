<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<table id="products" class="table table-striped table-hover table-bordered" style="width:100%">
    <thead>
    <tr>
        <th>#</th>
        <th>Sản phẩm</th>
        <th>Giá</th>
        <th>Danh mục</th>
        <th>Thương hiệu</th>
        <th>Tồn kho</th>
        <th>Lượt xem</th>
        <th>Đánh giá</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    </thead>
</table>

<script>
$(document).ready(function() {
    $('#products').DataTable({
        processing: true,
        ajax: {
            url: '${pageContext.request.contextPath}/api/products',
            dataSrc: ''
        },
        columns: [
            { data: 'id' },
            { 
                data: null,
                render: function(data) {
                    let image = data.mainImage ? 
                        `<img src="${pageContext.request.contextPath}/assets/images/data/${data.mainImage}" 
                              class="rounded me-2" style="width: 40px; height: 40px; object-fit: cover;">` : '';
                    return `
                        <div class="d-flex align-items-center">
                            ${image}
                            <div>
                                <div>${data.name}</div>
                                ${data.isFeatured ? '<span class="badge bg-warning">Nổi bật</span>' : ''}
                            </div>
                        </div>
                    `;
                }
            },
            { 
                data: 'basePrice',
                render: function(data) {
                    return new Intl.NumberFormat('vi-VN', { 
                        style: 'currency', 
                        currency: 'VND' 
                    }).format(data);
                }
            },
            { data: 'categoryName' },
            { data: 'brandName' },
            { 
                data: 'stock',
                render: function(data) {
                    return `<span class="badge bg-${data > 0 ? 'success' : 'danger'}">${data}</span>`;
                }
            },
            { data: 'totalViews' },
            { 
                data: null,
                render: function(data) {
                    const stars = '⭐'.repeat(Math.round(data.avgRating));
                    return `
                        <div>${stars}</div>
                        <small class="text-muted">${data.totalReviews} đánh giá</small>
                    `;
                }
            },
            { 
                data: 'status',
                render: function(data) {
                    switch(data) {
                        case 1: return '<span class="badge bg-success">Hoạt động</span>';
                        case 0: return '<span class="badge bg-danger">Không hoạt động</span>';
                        default: return '<span class="badge bg-secondary">Không xác định</span>';
                    }
                }
            },
            {
                data: 'id',
                orderable: false,
                render: function(data) {
                    return `
                        <div class="btn-group" role="group">
                            <a href="${pageContext.request.contextPath}/dashboard/products/${data}" 
                               class="btn btn-info btn-sm">
                                <i class="bi bi-eye"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/dashboard/products/${data}/edit" 
                               class="btn btn-primary btn-sm">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <button type="button" 
                                    class="btn btn-danger btn-sm" 
                                    onclick="deleteProduct(${data})">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    `;
                }
            }
        ],
        pageLength: 25,
        language: {
            url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json'
        },
        dom: '<"row"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
             '<"row"<"col-sm-12"tr>>' +
             '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
        buttons: [
            {
                text: '<i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm',
                className: 'btn btn-success me-2',
                action: function() {
                    window.location.href = '${pageContext.request.contextPath}/dashboard/products/create';
                }
            },
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
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'pdf',
                        text: '<i class="bi bi-file-earmark-pdf me-2"></i>PDF',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'csv',
                        text: '<i class="bi bi-file-earmark-text me-2"></i>CSV',
                        className: 'dropdown-item',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'print',
                        text: '<i class="bi bi-printer me-2"></i>In',
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
                className: 'btn btn-secondary'
            }
        ]
    });
});

function deleteProduct(productId) {
    if (confirm('Bạn có chắc muốn xóa sản phẩm này không?')) {
        fetch('${pageContext.request.contextPath}/api/products/' + productId, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Refresh DataTable
                $('#products').DataTable().ajax.reload();
                toastr.success('Xóa sản phẩm thành công');
            } else {
                toastr.error(data.message || 'Có lỗi xảy ra khi xóa sản phẩm');
            }
        })
        .catch(error => {
            toastr.error('Có lỗi xảy ra khi xóa sản phẩm');
            console.error('Error:', error);
        });
    }
}
</script>
