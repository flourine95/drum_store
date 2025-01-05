<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lí sản phẩm</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">


    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

    <link
            href="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.1.8/b-3.2.0/b-colvis-3.2.0/b-html5-3.2.0/b-print-3.2.0/fh-4.0.1/cr-2.0.4/fc-5.0.4/kt-2.12.1/r-3.0.3/sb-1.8.1/sp-2.3.3/sl-2.1.0/sr-1.4.1/datatables.min.css"
            rel="stylesheet">

    <script
            src="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.1.8/b-3.2.0/b-colvis-3.2.0/b-html5-3.2.0/b-print-3.2.0/fh-4.0.1/cr-2.0.4/fc-5.0.4/kt-2.12.1/r-3.0.3/sb-1.8.1/sp-2.3.3/sl-2.1.0/sr-1.4.1/datatables.min.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        ::after,
        ::before {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        a {
            text-decoration: none;
        }

        li {
            list-style: none;
        }

        body {
            font-family: 'Poppins', sans-serif;
        }

        .wrapper {
            display: flex;
        }

        .main {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            width: 100%;
            overflow: hidden;
            transition: all 0.35s ease-in-out;
            background-color: #fff;
            min-width: 0;
        }

        #sidebar {
            width: 70px;
            min-width: 70px;
            z-index: 1000;
            transition: all .25s ease-in-out;
            background-color: #0e2238;
            display: flex;
            flex-direction: column;
        }

        #sidebar.expand {
            width: 260px;
            min-width: 260px;
        }

        .toggle-btn {
            background-color: transparent;
            cursor: pointer;
            border: 0;
            padding: 1rem 1.5rem;
        }

        .toggle-btn i {
            font-size: 1.5rem;
            color: #FFF;
        }

        .sidebar-logo {
            margin: auto 0;
        }

        .sidebar-logo a {
            color: #FFF;
            font-size: 1.15rem;
            font-weight: 600;
        }

        #sidebar:not(.expand) .sidebar-logo,
        #sidebar:not(.expand) a.sidebar-link span {
            display: none;
        }

        #sidebar.expand .sidebar-logo,
        #sidebar.expand a.sidebar-link span {
            animation: fadeIn .25s ease;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        .sidebar-nav {
            padding: 2rem 0;
            flex: 1 1 auto;
        }

        a.sidebar-link {
            padding: .625rem 1.625rem;
            color: #FFF;
            display: block;
            font-size: 0.9rem;
            white-space: nowrap;
            border-left: 3px solid transparent;
        }

        .sidebar-link i,
        .dropdown-item i {
            font-size: 1.1rem;
            margin-right: .75rem;
        }

        a.sidebar-link:hover {
            background-color: rgba(255, 255, 255, .075);
            border-left: 3px solid #3b7ddd;
        }

        .sidebar-item {
            position: relative;
        }

        #sidebar:not(.expand) .sidebar-item .sidebar-dropdown {
            position: absolute;
            top: 0;
            left: 70px;
            background-color: #0e2238;
            padding: 0;
            min-width: 15rem;
            display: none;
        }

        #sidebar:not(.expand) .sidebar-item:hover .has-dropdown + .sidebar-dropdown {
            display: block;
            max-height: 15em;
            width: 100%;
            opacity: 1;
        }

        #sidebar.expand .sidebar-link[data-bs-toggle="collapse"]::after {
            border: solid;
            border-width: 0 .075rem .075rem 0;
            content: "";
            display: inline-block;
            padding: 2px;
            position: absolute;
            right: 1.5rem;
            top: 1.4rem;
            transform: rotate(-135deg);
            transition: all .2s ease-out;
        }

        #sidebar.expand .sidebar-link[data-bs-toggle="collapse"].collapsed::after {
            transform: rotate(45deg);
            transition: all .2s ease-out;
        }

        .navbar {
            background-color: #f5f5f5;
            box-shadow: 0 0 2rem 0 rgba(33, 37, 41, .1);
        }

        .navbar-expand .navbar-collapse {
            min-width: 200px;
        }
    </style>
    <link rel="stylesheet" href="../../../assets/css/dashboard.css">

</head>

<body>
<div class="wrapper ">
    <jsp:include page="../../../includes/dashboard-aside.html"/>
    <div class="main">
        <main class="content px-3 py-4">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-12 d-flex justify-content-between align-items-center mb-3">
                                <h4 class="page-title">Danh sách sản phẩm</h4>

                            </div>
                        </div>
                    </div>
                </div>

                <table id="products" class="table table-striped table-hover table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Sản phẩm</th>
                        <th>Mô tả</th>
                        <th>giá</th>
                        <th>Hàng trong kho</th>
                        <th>Danh mục</th>
                        <th>Thương hiệu</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th>#</th>
                        <th>Sản phẩm</th>
                        <th>Mô tả</th>
                        <th>giá</th>
                        <th>Hàng trong kho</th>
                        <th>Danh mục</th>
                        <th>Thương hiệu</th>
                        <th>Ngày tạo</th>
                        <th>Ngày cập nhật</th>
                        <th>Thao tác</th>
                    </tr>
                    </tfoot>
                </table>
                <jsp:include page="../../../includes/dashboard-footer.html"/>
            </div>
        </main>
    </div>
</div>
<div class="modal fade" id="productDetailModal" tabindex="-1" aria-labelledby="productDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="productDetailModalLabel">Chi tiết sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <img src="" alt="img" id="productImage"
                                 style="  width: 150px;height: 150px;object-fit: cover;"
                                 class="img-fluid">
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Tên sản phẩm:</label>
                                    <div id="productName"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Mô tả:</label>
                                    <div id="productDescription"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Giá:</label>
                                    <div id="productPrice"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Hàng trong kho:</label>
                                    <div id="productStock"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Danh mục:</label>
                                    <div id="productCategory"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Thương hiệu:</label>
                                    <div id="productBrand"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Ngày tạo:</label>
                                    <div id="createdAt"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Ngày chỉnh sửa:</label>
                                    <div id="updatedAt"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Ngày xóa:</label>
                                    <div id="deletedAt"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel">Chỉnh sửa sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editProductForm">
                    <input type="hidden" id="editProductId">
                    <div class="container-fluid">
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <img src="" alt="image"
                                     style="  width: 150px;height: 150px;object-fit: cover;"
                                     class="img-fluid">
                                <label for="editProductImage" class="form-label">Hình ảnh</label>
                                <input type="image" class="form-control" id="editProductImage" required>
                            </div>
                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label for="editProductName" class="form-label">Tên sản phẩm</label>
                                    <input type="text" class="form-control" id="editProductName" required>
                                </div>
                                <div class="mb-3" style="height: 200px">
                                    <label for="editProductDescription" class="form-label">Mô tả</label>
                                    <input type="text" class="form-control" id="editProductDescription" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editProductPrice" class="form-label">Giá</label>
                                    <input type="number" class="form-control" id="editProductPrice" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editProductStock" class="form-label">Hàng trong kho</label>
                                    <input type="number" class="form-control" id="editProductStock" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editProductCategory" class="form-label">Danh mục</label>
                                    <input type="text" class="form-control" id="editProductCategory" required>
                                </div>
                                <div class="mb-3">
                                    <label for="editProductBrand" class="form-label">Thương hiệu</label>
                                    <input type="text" class="form-control" id="editProductBrand" required>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $('#products').DataTable({
            pageLength: 25,
            ajax: {
                url: '/dashboard/products?action=ajaxList',
                dataSrc: ''
            },
            columns: [
                {data: 'id', title: '#'},
                {
                    data: null, title: 'Tên sản phẩm',
                    render: (data, type, row) => {
                        const image = row.image;
                        const name = row.name;
                        return `<img src="https://dotchuoinon.com/wp-content/uploads/2015/02/champa19.jpg?w=474" class="mr-2 rounded-circle shadow" style="height: 50px; width: 50px; object-fit: cover;" />
                                <a href="#" class="text-body font-weight-semibold">\${name}</a>`;
                    }
                },
                {data: 'description', title: 'Mô tả'},
                {
                    data: 'price', title: 'Giá',
                    render: function (data) {
                        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(data);
                    }
                },
                {data: 'stock', title: 'Hàng trong kho'},
                {data: 'categoryId', title: 'Danh mục'},
                {data: 'brandId', title: 'Thương hiệu'},
                {data: 'createdAt', title: 'Ngày tạo'},
                {data: 'updatedAt', title: 'Ngày cập nhật'},
                {
                    data: null,
                    title: 'Thao tác',
                    render: function (data, type, row) {
                        return `
                            <button class="btn btn-warning" onclick="viewDetails(\${row.id})">Xem</button>
                            <button class="btn btn-primary" onclick="editProduct(\${row.id})">Chỉnh sửa</button>
                            <button class="btn btn-danger" onclick="deleteProduct(\${row.id})">Xóa</button>
                        `;
                    }
                }
            ],
            columnDefs: [
                {
                    target: 9,
                    width: '15%'
                }
            ],
            processing: true,
        });
    });

    function editProduct(productId) {
        $.ajax({
            url: `/dashboard/products?action=edit&productId=\${productId}`,
            type: 'GET',
            dataType: 'json',
            success: function (product) {
                $('#editProductId').val(product.id);
                $('#editProductImage').val(product.image);
                $('#editProductDescription').val(product.description);
                $('#editProductPrice').val(product.price);
                $('#editProductCategory').val(product.categoryId);
                $('#editProductBrand').val(product.brandId);

                $('#editProductModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Đã có lỗi xảy ra khi tải thông tin chỉnh sửa. Vui lòng thử lại sau.');
            }
        });
    }

    function saveProductChanges() {
        const prouctId = $('#editProductId').val();
        const data = {
            image: $('editProductImage').val(),
            name: $('#editProductName').val(),
            description: $('#editProductDescription').val(),
            price: $('#editProductPrice').val(),
            stock: $('#editProductStock').val(),
            category: $('#editProductCategory').val(),
            brand: $('#editProductBrand').val(),
        };

        $.ajax({
            url: `/dashboard/products?action=update&productId=\${productId}`,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                alert('Cập nhật sản phẩm thành công!');
                $('#editProductModal').modal('hide');
                location.reload(); // Reload lại bảng dữ liệu
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Đã có lỗi xảy ra khi cập nhật. Vui lòng thử lại sau.');
            }
        });
    }


    function viewDetails(productId) {
        $.ajax({
            url: `/dashboard/products?action=show&productId=\${productId}`,
            type: 'GET',
            dataType: 'json',
            success: function (product) {
                document.getElementById('productImage').src = product.image;
                document.getElementById('productName').textContent = product.name;
                document.getElementById('productDescription').textContent = product.description;
                document.getElementById('productPrice').textContent = product.price;
                document.getElementById('productStock').textContent = product.stock;
                document.getElementById('productCategory').textContent = product.category;
                document.getElementById('productBrand').textContent = product.brand;

                document.getElementById('createdAt').textContent = new Date(product.createdAt).toLocaleDateString('vi-VN');
                document.getElementById('updatedAt').textContent = new Date(product.updatedAt).toLocaleDateString('vi-VN');
                document.getElementById('deletedAt').textContent = new Date(product.deletedAt).toLocaleDateString('vi-VN');


                $('#productDetailModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Đã có lỗi xảy ra khi tải chi tiết người dùng. Vui lòng thử lại sau.');
            }
        });
    }


</script>
</body>
</html>