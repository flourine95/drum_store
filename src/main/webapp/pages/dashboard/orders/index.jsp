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
                            <h5 class="fw-normal mb-0">Tổng đơn hàng</h5>
                            <h2 class="mt-2 mb-0" id="totalOrders">--</h2>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3">
                            <i class="bi bi-cart-fill fs-1 text-primary"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('all')">Xem tất cả đơn hàng</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-success text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Đã giao hàng</h5>
                            <h2 class="mt-2 mb-0" id="deliveredOrders">--</h2>
                        </div>
                        <div class="rounded-circle bg-success-subtle p-3">
                            <i class="bi bi-check-circle fs-1 text-success"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('delivered')">Xem đơn đã giao</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-info text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Đang xử lý</h5>
                            <h2 class="mt-2 mb-0" id="processingOrders">--</h2>
                        </div>
                        <div class="rounded-circle bg-info-subtle p-3">
                            <i class="bi bi-hourglass-split fs-1 text-info"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('processing')">Xem đơn đang xử lý</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-danger text-white h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="fw-normal mb-0">Đã hủy</h5>
                            <h2 class="mt-2 mb-0" id="cancelledOrders">--</h2>
                        </div>
                        <div class="rounded-circle bg-danger-subtle p-3">
                            <i class="bi bi-x-circle fs-1 text-danger"></i>
                        </div>
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between small">
                    <a class="text-white stretched-link" href="javascript:void(0)" onclick="applyFilter('cancelled')">Xem đơn đã hủy</a>
                    <div class="text-white"><i class="bi bi-chevron-right"></i></div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Orders Table Card -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Quản lý đơn hàng</h5>
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
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table id="orders" class="table table-hover align-middle" style="width:100%">
                    <thead class="table-light">
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt hàng</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Trạng thái thanh toán</th>
                        <th>Trạng thái đơn hàng</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Số lượng sản phẩm</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#orders').DataTable({
            processing: true,
            ajax: {
                url: '${pageContext.request.contextPath}/api/orders',
                dataSrc: function (json) {
                    if (json.success !== undefined && !json.success) {
                        toastr.error(json.message || 'Có lỗi xảy ra khi lấy dữ liệu đơn hàng');
                        return [];
                    }
                    // Update dashboard stats
                    updateOrderStats(json);
                    return json;
                },
                error: function (xhr, error, thrown) {
                    toastr.error('Không thể lấy dữ liệu đơn hàng. Vui lòng thử lại sau.');
                    console.error('AJAX Error:', xhr, error, thrown);
                }
            },
            columns: [
                // { data: 'orderId' },
                {data: 'orderId'},
                {
                    data: 'orderDate',
                    render: function (data) {
                        return new Date(data).toLocaleString('vi-VN', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                    }
                },
                {
                    data: 'totalAmount',
                    render: function (data) {
                        return new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND'
                        }).format(data);
                    }
                },
                {
                    data: 'paymentMethodText',
                    render: function (data) {
                        let badgeClass = '';
                        let displayText = data;
                        
                        switch (data) {
                            case 'COD':
                                badgeClass = 'danger'; 
                                displayText = 'Tiền mặt';
                                break;
                            case 'BANK_TRANSFER':
                                badgeClass = 'info';        
                                displayText = 'Chuyển khoản';
                                break;
                            case 'E_WALLET':
                                badgeClass = 'success';    
                                displayText = 'Ví điện tử';
                                break;
                            case undefined:
                            case null:
                                badgeClass = 'secondary';  
                                displayText = 'Không xác định';
                                break;
                            default:
                                badgeClass = 'secondary';  
                        }
                        return `<span class="badge bg-\${badgeClass}">\${displayText}</span>`;
                    }
                },
                {
                    data: 'paymentStatusText',
                    render: function (data) {
                        let badgeClass = '';
                        let displayText = data;
                        
                        switch (data) {
                            case 'PENDING':
                                badgeClass = 'warning';
                                displayText = 'Chờ thanh toán';
                                break;
                            case 'COMPLETED':
                                badgeClass = 'success';
                                displayText = 'Đã thanh toán';
                                break;
                            case 'FAILED':
                                badgeClass = 'danger';
                                displayText = 'Thanh toán thất bại';
                                break;
                            case 'CANCELLED':
                                badgeClass = 'danger';
                                displayText = '';
                                break;

                            case undefined:
                            case null:
                                badgeClass = 'secondary';
                                displayText = 'Không xác định';
                                break;
                            default:
                                badgeClass = 'secondary';
                        }
                        return `<span class="badge bg-\${badgeClass}">\${displayText}</span>`;
                    }
                },
                {
                    data: 'orderStatus',
                    render: function (data, type, row) {
                        return `
                       <select class="form-select order-status" data-order-id="\${row.orderId}"  data-original-status="\${data}"  style="width: 150px;">
                            <option value="0" \${data == 0 ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="1" \${data == 1 ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="2" \${data == 2 ? 'selected' : ''}>Đang giao hàng</option>
                            <option value="3" \${data == 3 ? 'selected' : ''}>Đã giao hàng</option>
                            <option value="4" \${data == 4 ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    `;
                    }
                },
                {
                    data: 'shippingAddress',
                    render: function (data) {
                        return `
                        <div>\${data.fullname}</div>
                        <div>SDT: \${data.phone}</div>
                    `;
                    }
                },
                {
                    data: 'items',
                    render: function (data) {
                        return `<span class="badge bg-info">\${data.length}</span>`;
                    }
                },
                {
                    data: 'orderId',
                    orderable: false,
                    className: 'text-center',
                    render: function (data) {
                        return `
                        <div class="btn-group" role="group">
                            <a href="${pageContext.request.contextPath}/dashboard/orders?action=show&orderId=\${data}"
                               class="btn btn-info btn-sm" title="Xem chi tiết">
                                <i class="bi bi-eye"></i>
                            </a>
                            <%--<a href="${pageContext.request.contextPath}/dashboard/orders/\${data}/edit"--%>
                            <%--   class="btn btn-primary btn-sm" title="Chỉnh sửa">--%>
                            <%--    <i class="bi bi-pencil"></i>--%>
                            <%--</a>--%>
                            <button type="button"
                                    class="btn btn-danger btn-sm"
                                    onclick="deleteOrder(\${data})"
                                    title="Xóa">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    `;
                    }
                }
            ],
            order: [[0, 'desc']],
            pageLength: 25,
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

        // Handle order status change
        $('#orders').on('change', '.order-status', function () {
            let orderId = $(this).data('order-id');
            let newStatus = $(this).val();
            let originalStatus =  $(this).data('original-status')

            if (originalStatus === 4) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Không thể thay đổi',
                    text: 'Đơn hàng này đã được hủy, không được thay đổi trạng thái đơn hàng.',
                }).then(() => {
                    $select.val(originalStatus);
                });
                return;
            }

            if (newStatus < originalStatus) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Không thể quay lại trạng thái trước',
                    text: 'Bạn không được phép quay lại trạng thái trước đó của đơn hàng.',
                }).then(() => {
                    $select.val(originalStatus);
                });
                return;
            }


            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/orders',
                type: 'POST',
                data: {
                    action: "modify-orderStatus",
                    orderId: orderId,
                    statusId: newStatus
                },
                success: function (response) {
                    if (response.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Thành công',
                            text: 'Cập nhật trạng thái đơn hàng thành công!',
                            timer: 1500,
                            showConfirmButton: false
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi',
                            text: response.message || 'Có lỗi xảy ra khi cập nhật trạng thái!'
                        });

                    }
                    $('#orders').DataTable().ajax.reload();
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi kết nối',
                        text: 'Không thể cập nhật trạng thái đơn hàng!'
                    });
                    $('#orders').DataTable().ajax.reload();
                }
            });
        });
    });

    function deleteOrder(orderId) {
        const row = $('tr[data-order-id="' + orderId + '"]');
        const orderStatus = parseInt(row.find('.order-status option:selected').val());

        if ([1, 2, 3].includes(orderStatus)) {
            Swal.fire({
                icon: 'warning',
                title: 'Không thể xóa',
                text: 'Đơn hàng đã được xử lý và không thể bị xóa.',
            });
            return;
        }

        Swal.fire({
            title: 'Bạn có chắc?',
            text: "Bạn có chắc muốn xóa đơn hàng này không?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/dashboard/orders',
                    method: 'POST',
                    data: {
                        action:'remove-order',
                        orderId: orderId
                    },
                    success: function (data) {
                        if (data.status === 'success') {
                            $('#orders').DataTable().ajax.reload();
                            Swal.fire({
                                icon: 'success',
                                title: 'Đã xóa',
                                text: 'Xóa đơn hàng thành công.'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi',
                                text: data.message || 'Có lỗi xảy ra khi xóa đơn hàng.'
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi',
                            text: 'Có lỗi xảy ra khi xóa đơn hàng.'
                        });
                    }
                });
            }
        });
    }

    // Connect export buttons to DataTable export functions
    $('#export-excel').on('click', function() {
        $('.buttons-excel').click();
    });
    
    $('#export-pdf').on('click', function() {
        $('.buttons-pdf').click();
    });
    
    $('#export-csv').on('click', function() {
        $('.buttons-csv').click();
    });
    
    $('#export-print').on('click', function() {
        $('.buttons-print').click();
    });
    
    // Function to update order stats
    function updateOrderStats(orders) {
        if (!Array.isArray(orders)) return;
        
        const totalOrders = orders.length;
        let deliveredOrders = 0;
        let processingOrders = 0;
        let cancelledOrders = 0;
        
        orders.forEach(order => {
            // Order status: 0=PENDING, 1=CONFIRMED, 2=SHIPPING, 3=DELIVERED, 4=CANCELLED
            if (order.orderStatus === 3) {
                deliveredOrders++;
            } else if (order.orderStatus === 4) {
                cancelledOrders++;
            } else {
                processingOrders++; // PENDING, CONFIRMED, SHIPPING are all considered processing
            }
        });
        
        // Update stats in the UI
        $('#totalOrders').text(totalOrders);
        $('#deliveredOrders').text(deliveredOrders);
        $('#processingOrders').text(processingOrders);
        $('#cancelledOrders').text(cancelledOrders);
    }
    
    // Function to apply filters to the DataTable
    function applyFilter(filterType) {
        const table = $('#orders').DataTable();
        console.log(filterType);
        
        // Clear any existing search
        table.search('').columns().search('');
        
        switch(filterType) {
            case 'all':
                // Show all orders
                table.search('').draw();
                break;
            case 'delivered':
                // Filter for delivered orders (status 3)
                table.column(5).search('Đã giao hàng').draw();
                break;
            case 'processing':
                // Filter for orders in processing (status 0, 1, 2)
                table.column(5).search('Chờ xác nhận|Đã xác nhận|Đang giao hàng', true, false).draw();
                break;
            case 'cancelled':
                // Filter for cancelled orders (status 4)
                table.column(5).search('Đã hủy').draw();
                break;
        }
    }
</script>