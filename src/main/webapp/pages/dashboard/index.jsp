<%@ page contentType="text/html;charset=UTF-8"  %>
<div class="main bg-secondary-subtle">
    <main class="content px-3 py-4">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <h4 class="page-title">Dashboard</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card widget-flat" id="customer-card">
                        <div class="card-body">
                            <div class="float-end">
                                <i class="bi bi-people-fill widget-icon bg-success-lighten text-success"></i>
                            </div>
                            <h5 class="text-muted font-weight-normal mt-0" title="Số lượng khách hàng">Khách hàng</h5>
                            <h3 class="mt-3 mb-3">36,254</h3>
                            <p class="mb-0 text-muted">
                                <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 5.27%</span>
                                <span class="text-nowrap">So với tháng trước</span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card widget-flat" id="order-card">
                        <div class="card-body">
                            <div class="float-end">
                                <i class="bi bi-cart-plus widget-icon bg-danger-lighten text-danger"></i>
                            </div>
                            <h5 class="text-muted font-weight-normal mt-0" title="Số lượng đơn hàng">Đơn hàng</h5>
                            <h3 class="mt-3 mb-3">5,543</h3>
                            <p class="mb-0 text-muted">
                                <span class="text-danger me-2"><i class="bi bi-arrow-down"></i> 1.08%</span>
                                <span class="text-nowrap">So với tháng trước</span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card widget-flat" id="revenue-card">
                        <div class="card-body">
                            <div class="float-end">
                                <i class="bi bi-currency-dollar widget-icon bg-info-lighten text-info"></i>
                            </div>
                            <h5 class="text-muted font-weight-normal mt-0" title="Doanh thu trung bình">Doanh thu</h5>
                            <h3 class="mt-3 mb-3">150.000.000đ</h3>
                            <p class="mb-0 text-muted">
                                <span class="text-danger me-2"><i class="bi bi-arrow-down"></i> 7.00%</span>
                                <span class="text-nowrap">So với tháng trước</span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card widget-flat" id="growth-card">
                        <div class="card-body">
                            <div class="float-end">
                                <i class="bi bi-graph-up widget-icon bg-warning-lighten text-warning"></i>
                            </div>
                            <h5 class="text-muted font-weight-normal mt-0" title="Tăng trưởng">Tăng trưởng</h5>
                            <h3 class="mt-3 mb-3">+ 30.56%</h3>
                            <p class="mb-0 text-muted">
                                <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 4.87%</span>
                                <span class="text-nowrap">So với tháng trước</span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-xl-7 col-lg-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="dropdown float-end">
                                <button class="btn btn-light btn-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <li><a class="dropdown-item" href="#">Báo cáo doanh thu</a></li>
                                    <li><a class="dropdown-item" href="#">Xuất báo cáo</a></li>
                                    <li><a class="dropdown-item" href="#">Phân tích lợi nhuận</a></li>
                                    <li><a class="dropdown-item" href="#">Cài đặt biểu đồ</a></li>
                                </ul>
                            </div>
                            <h4 class="card-title mb-3">Doanh thu thực tế so với dự kiến</h4>
                            <canvas id="revenueChart" class="h-100"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-xl-5 col-lg-6 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h4 class="card-title mb-3">Phân bổ doanh thu theo danh mục</h4>
                            <canvas id="revenuePieChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xl-6 col-lg-12 order-lg-2 order-xl-1 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="card-title mb-4">Sản phẩm bán chạy nhất</h4>
                                <a href="#" class="btn btn-sm btn-outline-primary">
                                    Xuất báo cáo
                                    <i class="bi bi-download ms-1"></i>
                                </a>
                            </div>

                            <div class="table-responsive ">
                                <table class="table table-hover table-striped" id="best-selling-products-table">
                                    <thead class="table-light">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Giá</th>
                                        <th>Số lượng</th>
                                        <th>Tổng tiền</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%--render--%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-lg-6 order-lg-1 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="dropdown float-end">
                                <a href="#" class="dropdown-toggle text-muted" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Xem chi tiết</a></li>
                                    <li><a class="dropdown-item" href="#">Xuất báo cáo</a></li>
                                    <li><a class="dropdown-item" href="#">Cập nhật dữ liệu</a></li>
                                </ul>
                            </div>
                            <h4 class="card-title mb-4">Phân tích doanh thu</h4>

                            <div id="revenue-chart" class="apex-charts mb-4 mt-4"></div>

                            <div class="chart-widget-list">
                            <%--render--%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-lg-6 order-lg-1">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="dropdown float-end">
                                <a href="#" class="dropdown-toggle text-muted" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#">Xem chi tiết</a></li>
                                    <li><a class="dropdown-item" href="#">Lọc hoạt động</a></li>
                                    <li><a class="dropdown-item" href="#">Xuất báo cáo</a></li>
                                </ul>
                            </div>
                            <h4 class="card-title mb-4">Hoạt động gần đây</h4>

                            <div data-simplebar style="max-height: 424px;">
                                <div class="timeline-alt pb-0">
                                    <div class="timeline-item">
                                        <i class="bi bi-cart-check bg-success-subtle text-success rounded-circle timeline-icon"></i>
                                        <div class="timeline-item-info">
                                            <a href="#" class="text-success fw-bold d-block">Đơn hàng mới</a>
                                            <small>Khách hàng Nguyễn Văn A đã đặt hàng trống jazz</small>
                                            <p class="mb-0 pb-2">
                                                <small class="text-muted">5 phút trước</small>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="timeline-item">
                                        <i class="bi bi-person-plus bg-primary-subtle text-primary rounded-circle timeline-icon"></i>
                                        <div class="timeline-item-info">
                                            <a href="#" class="text-primary fw-bold d-block">Người dùng mới đăng ký</a>
                                            <small>Trần Thị B vừa tạo tài khoản mới</small>
                                            <p class="mb-0 pb-2">
                                                <small class="text-muted">30 phút trước</small>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="timeline-item">
                                        <i class="bi bi-star bg-warning-subtle text-warning rounded-circle timeline-icon"></i>
                                        <div class="timeline-item-info">
                                            <a href="#" class="text-warning fw-bold d-block">Đánh giá sản phẩm mới</a>
                                            <small>Lê Văn C đã đánh giá 5 sao cho sản phẩm "Trống cơ bản cho người mới bắt đầu"</small>
                                            <p class="mb-0 pb-2">
                                                <small class="text-muted">2 giờ trước</small>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="timeline-item">
                                        <i class="bi bi-box-seam bg-info-subtle text-info rounded-circle timeline-icon"></i>
                                        <div class="timeline-item-info">
                                            <a href="#" class="text-info fw-bold d-block">Cập nhật kho hàng</a>
                                            <small>Đã nhập thêm 50 bộ trống điện tử vào kho</small>
                                            <p class="mb-0 pb-2">
                                                <small class="text-muted">1 ngày trước</small>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
<script>
    // Biểu đồ doanh thu
    const ctx = document.getElementById('revenueChart').getContext('2d');
    // Hàm gọi API và cập nhật biểu đồ
    function fetchRevenueData() {
        $.ajax({
            url: '/api/analytics/monthly-revenue',
            type: 'GET',
            success: function (data) {
                // Xử lý dữ liệu từ API
                const revenueData = data.map(item => item.revenue);
                const profitData = data.map(item => item.profit);

                // Cập nhật biểu đồ với dữ liệu mới
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                        datasets: [{
                            label: 'Doanh Thu (triệu đồng)',
                            data: revenueData,
                            borderColor: 'rgb(75, 192, 192)',
                            backgroundColor: 'rgba(75, 192, 192, 0.2)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.1,
                            pointBackgroundColor: 'rgb(75, 192, 192)',
                            pointBorderColor: '#fff',
                            pointHoverBackgroundColor: '#fff',
                            pointHoverBorderColor: 'rgb(75, 192, 192)'
                        }, {
                            label: 'Lợi Nhuận (triệu đồng)',
                            data: profitData,
                            borderColor: 'rgb(255, 99, 132)',
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderWidth: 2,
                            fill: true,
                            tension: 0.1,
                            pointBackgroundColor: 'rgb(255, 99, 132)',
                            pointBorderColor: '#fff',
                            pointHoverBackgroundColor: '#fff',
                            pointHoverBorderColor: 'rgb(255, 99, 132)'
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: true,
                                text: 'Biểu Đồ Doanh Thu và Lợi Nhuận Năm 2024'
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                callbacks: {
                                    label: function (context) {
                                        let label = context.dataset.label || '';
                                        if (label) {
                                            label += ': ';
                                        }
                                        if (context.parsed.y !== null) {
                                            label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y * 1000000);
                                        }
                                        return label;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: 'Giá Trị (triệu đồng)'
                                },
                                ticks: {
                                    callback: function (value, index, values) {
                                        return value + ' triệu';
                                    }
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: 'Tháng'
                                }
                            }
                        },
                        interaction: {
                            intersect: false,
                            mode: 'index',
                        },
                    }
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi tải dữ liệu: " + error);
            }
        });
    }

    function updateCustomerStats() {
        $.ajax({
            url: '/api/analytics/customer-stats',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const currentValue = data.currentMonthCustomers || 0;
                const growthRate = data.growthRate || 0;

                const card = $('#customer-card');
                card.find('h3').text(currentValue.toLocaleString());
                const growthSpan = card.find('span.text-success, span.text-danger');
                growthSpan.text((growthRate >= 0 ? '+' : '') + growthRate.toFixed(2) + '%');
                growthSpan.removeClass('text-success text-danger');
                growthSpan.addClass(growthRate >= 0 ? 'text-success' : 'text-danger');
                growthSpan.find('i').removeClass('bi-arrow-up bi-arrow-down');
                growthSpan.find('i').addClass('bi bi-arrow-' + (growthRate >= 0 ? 'up' : 'down'));
            },
            error: function(error) {
                console.error('Error fetching customer stats:', error);
            }
        });
    }

    // Hàm cập nhật số lượng đơn hàng
    function updateOrderStats() {
        $.ajax({
            url: '/api/analytics/order-stats',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const currentValue = data.currentMonthOrders || 0;
                const growthRate = data.growthRate || 0;

                const card = $('#order-card');
                card.find('h3').text(currentValue.toLocaleString());
                const growthSpan = card.find('span.text-success, span.text-danger');
                growthSpan.text((growthRate >= 0 ? '+' : '') + growthRate.toFixed(2) + '%');
                growthSpan.removeClass('text-success text-danger');
                growthSpan.addClass(growthRate >= 0 ? 'text-success' : 'text-danger');
                growthSpan.find('i').removeClass('bi-arrow-up bi-arrow-down');
                growthSpan.find('i').addClass('bi bi-arrow-' + (growthRate >= 0 ? 'up' : 'down'));
            },
            error: function(error) {
                console.error('Error fetching order stats:', error);
            }
        });
    }

    // Hàm cập nhật doanh thu
    function updateRevenueStats() {
        $.ajax({
            url: '/api/analytics/revenue-stats',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const currentValue = data.currentMonthRevenue || 0;
                const growthRate = data.growthRate || 0;

                const card = $('#revenue-card');
                card.find('h3').text(currentValue.toLocaleString() + 'đ');
                const growthSpan = card.find('span.text-success, span.text-danger');
                growthSpan.text((growthRate >= 0 ? '+' : '') + growthRate.toFixed(2) + '%');
                growthSpan.removeClass('text-success text-danger');
                growthSpan.addClass(growthRate >= 0 ? 'text-success' : 'text-danger');
                growthSpan.find('i').removeClass('bi-arrow-up bi-arrow-down');
                growthSpan.find('i').addClass('bi bi-arrow-' + (growthRate >= 0 ? 'up' : 'down'));
            },
            error: function(error) {
                console.error('Error fetching revenue stats:', error);
            }
        });
    }

    // Hàm cập nhật tăng trưởng
    function updateGrowthStats() {
        $.ajax({
            url: '/api/analytics/growth-stats',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const currentValue = data.currentMonthGrowth || 0;
                const growthRate = data.growthRate || 0;

                const card = $('#growth-card');
                card.find('h3').text('+ ' + currentValue.toFixed(2) + '%');
                const growthSpan = card.find('span.text-success, span.text-danger');
                growthSpan.text((growthRate >= 0 ? '+' : '') + growthRate.toFixed(2) + '%');
                growthSpan.removeClass('text-success text-danger');
                growthSpan.addClass(growthRate >= 0 ? 'text-success' : 'text-danger');
                growthSpan.find('i').removeClass('bi-arrow-up bi-arrow-down');
                growthSpan.find('i').addClass('bi bi-arrow-' + (growthRate >= 0 ? 'up' : 'down'));
            },
            error: function(error) {
                console.error('Error fetching growth stats:', error);
            }
        });
    }

    // sản phẩm bán chạy
    function updateBestSellingProducts() {
        $.ajax({
            url: '/api/analytics/best-selling-products',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const tbody = $('#best-selling-products-table tbody');
                tbody.empty(); // Xóa dữ liệu cũ

                data.slice(0, 5).forEach(product => {
                    const productName = product.productname || 'Không rõ';
                    const createdat = product.createdat
                        ? new Date(product.lastOrderDate).toLocaleDateString('vi-VN')
                        : 'N/A';
                    const price = formatCurrency(product.price);
                    const quantity = product.totalquantity || 0;
                    const totalAmount = formatCurrency(product.totalamount);

                    const row =
                        '<tr>' +
                        '<td>' +
                        '<h6 class="mb-0">' + productName + '</h6>' +
                        '<small class="text-muted">' + createdat + '</small>' +
                        '</td>' +
                        '<td>' + price + '</td>' +
                        '<td>' + quantity + '</td>' +
                        '<td>' + totalAmount + '</td>' +
                        '</tr>';


                    tbody.append(row);
                });
            },
            error: function(error) {
                console.error('Lỗi khi tải sản phẩm bán chạy:', error);
            }
        });
    }

    // doanh thu ban duoc theo category và brand
    function updateRevenueByCategoryAndBrand() {
        $.ajax({
            url: '/api/analytics/revenue-category-brand',
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                const chartWidgetList = $('.chart-widget-list');
                chartWidgetList.empty();

                const categories = data.categories || [];
                const brands = data.brands || [];


                if (categories.length > 0) {
                    chartWidgetList.append('<p class="text-muted mt-4 mb-2"><strong>Danh mục</strong></p>');
                    categories.forEach(item => {
                        const category = item.categoryname || 'Không rõ';
                        const amount = formatCurrency(item.revenue);

                        const row =
                            '<p class="text-muted mb-1">' +
                            '<i class="bi bi-square-fill text-primary me-2"></i> ' + category +
                            '<span class="float-end">' + amount + '</span>' +
                            '</p>';

                        chartWidgetList.append(row);
                    });
                }

                if (brands.length > 0) {
                    chartWidgetList.append('<p class="text-muted mt-4 mb-2"><strong>Thương hiệu</strong></p>');
                    brands.forEach(item => {
                        const category = item.brandname || 'Không rõ';
                        const amount = formatCurrency(item.revenue);

                        const row =
                            '<p class="text-muted mb-1">' +
                            '<i class="bi bi-square-fill text-primary me-2"></i> ' + category +
                            '<span class="float-end">' + amount + '</span>' +
                            '</p>';

                        chartWidgetList.append(row);
                    });
                }
            },
            error: function(error) {
                console.error('Lỗi khi tải doanh thu theo danh mục và thương hiệu:', error);
            }
        });
    }


    function formatCurrency(amount) {
        if (!amount || isNaN(amount)) return '0đ';
        return parseFloat(amount).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
    }


    updateCustomerStats();
    updateOrderStats();
    updateRevenueStats();
    updateGrowthStats();
    fetchRevenueData();
    updateBestSellingProducts();
    updateRevenueByCategoryAndBrand();

    // Biểu đồ phân bổ doanh thu
    const ctx2 = document.getElementById('revenuePieChart').getContext('2d');
    new Chart(ctx2, {
        type: 'doughnut',
        data: {
            labels: ['Trống Điện Tử', 'Trống Cơ', 'Phụ Kiện'],
            datasets: [{
                data: [40, 30, 30],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.8)',
                    'rgba(54, 162, 235, 0.8)',
                    'rgba(255, 206, 86, 0.8)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        font: {
                            size: 14
                        },
                        padding: 20
                    }
                },
                title: {
                    display: true,
                    text: 'Phân Bổ Doanh Thu Theo Sản Phẩm',
                    font: {
                        size: 18,
                        weight: 'bold'
                    },
                    padding: {
                        top: 10,
                        bottom: 30
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed !== null) {
                                label += new Intl.NumberFormat('vi-VN', { style: 'percent', minimumFractionDigits: 1 }).format(context.parsed / 100);
                            }
                            return label;
                        }
                    }
                }
            },
            cutout: '60%',
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }
    });
</script>
