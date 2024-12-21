<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lí nguời dùng</title>

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
                                <h4 class="page-title">Danh sách người dùng</h4>

                            </div>
                        </div>
                    </div>
                </div>

                <table id="users" class="table table-striped table-hover table-bordered" style="width:100%">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Người dùng</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
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
                        <th>Người dùng</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Thao tác</th>
                    </tr>
                    </tfoot>
                </table>
                <jsp:include page="../../../includes/dashboard-footer.html"/>
            </div>
        </main>
    </div>
</div>
<div class="modal fade" id="userDetailModal" tabindex="-1" aria-labelledby="userDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userDetailModalLabel">Chi tiết người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <img src="" alt="Avatar" id="userAvatar"
                                 style="  width: 150px;height: 150px;object-fit: cover;border-radius: 50%;"
                                 class="img-fluid rounded-circle">
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Họ tên:</label>
                                    <div id="userName"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Email:</label>
                                    <div id="userEmail"></div>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="fw-bold">Trạng thái:</label>
                                    <div id="userStatus"></div>
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
                    <div class="row">
                        <div class="col-12 mb-2">
                            <label class="fw-bold">Danh sách địa chỉ:</label>
                            <div id="userAddresses" class="mb-3">
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
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Chi tiết người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" id="editUserId">
                    <div class="container-fluid">
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <img src="" alt="Avatar" id="editUserAvatar"
                                     style="  width: 150px;height: 150px;object-fit: cover;border-radius: 50%;"
                                     class="img-fluid rounded-circle">
                            </div>
                            <div class="col-md-8">
                                <div class="row">
                                    <div class="col-md-6 mb-2">
                                        <label class="fw-bold">Họ tên:</label>
                                        <div id="editUserFullname"></div>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <label class="fw-bold">Email:</label>
                                        <div id="editUserEmail"></div>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <label class="fw-bold">Trạng thái:</label>
                                        <div id="editUserStatus"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 mb-2">
                                <label class="fw-bold">Danh sách địa chỉ:</label>
                                <div id="editAddresses" class="mb-3">
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
        $('#users').DataTable({
            pageLength: 25,
            ajax: {
                url: '/dashboard/users?action=ajaxList',
                dataSrc: ''
            },
            columns: [
                {data: 'id', title: '#'},
                {data: 'fullname', title: 'Họ tên'},
                {data: 'email', title: 'Email'},
                {data: 'role', title: 'Vai trò'},
                {data: 'status', title: 'Trạng thái'},
                {data: 'createdAt', title: 'Ngày tạo'},
                {data: 'updatedAt', title: 'Ngày cập nhật'},
                {
                    data: null,
                    title: 'Thao tác',
                    render: function (data, type, row) {
                        return `
                            <button class="btn btn-warning" onclick="viewDetails(\${row.id})">Xem</button>
                            <button class="btn btn-primary" onclick="editUser(\${row.id})">Chỉnh sửa</button>
                            <button class="btn btn-danger" onclick="deleteUser(\${row.id})">Xóa</button>
                        `;
                    }
                }
            ],
            processing: true,
        });
    });

    function editUser(userId) {
        $.ajax({
            url: `/dashboard/users?action=edit&userId=\${userId}`,
            type: 'GET',
            dataType: 'json',
            success: function (user) {
                $('#editUserId').val(user.id);
                $('#editUserFullname').val(user.fullname);
                $('#editUserEmail').val(user.email);
                $('#editUserStatus').val(user.status);
                $('#editUserAvatar').attr('src', user.avatar || 'path/to/default/avatar.jpg');
                $('#editAddresses').html('');
                const userAddressesElement = document.getElementById('editAddresses');
                userAddressesElement.innerHTML = '';

                const table = document.createElement('table');
                table.classList.add('table', 'table-bordered');
                table.innerHTML = `
    <thead>
        <tr>
            <th>#</th>
            <th>Địa chỉ</th>
            <th>Số điện thoại</th>
            <th>Mặc định</th>
            <th>Thao tác</th>
        </tr>
    </thead>
    <tbody id="editAddressTableBody"></tbody>
`;

                userAddressesElement.appendChild(table);

                const tbody = document.getElementById('editAddressTableBody');

                user.userAddresses.forEach(function (address, index) {
                    const row = document.createElement('tr');
                    row.innerHTML = `
        <td>\${index + 1}</td>
        <td>\${address.address}</td>
        <td>\${address.phone}</td>
        <td>\${address.isDefault ? 'Có' : 'Không'}</td>
        <td>
            <button class="btn btn-primary">Chỉnh sửa</button>
            <button class="btn btn-danger">Xóa</button>
        </td>
    `;
                    tbody.appendChild(row);
                });

                $('#editUserModal').modal('show');
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Đã có lỗi xảy ra khi tải thông tin chỉnh sửa. Vui lòng thử lại sau.');
            }
        });
    }

    function saveUserChanges() {
        const userId = $('#editUserId').val();
        const data = {
            fullname: $('#editUserFullname').val(),
            email: $('#editUserEmail').val(),
            status: $('#editUserStatus').val()
        };

        $.ajax({
            url: `/dashboard/users?action=update&userId=${userId}`,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                alert('Cập nhật người dùng thành công!');
                $('#editUserModal').modal('hide');
                location.reload(); // Reload lại bảng dữ liệu
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                alert('Đã có lỗi xảy ra khi cập nhật. Vui lòng thử lại sau.');
            }
        });
    }


    function viewDetails(userId) {
        $.ajax({
            url: `/dashboard/users?action=show&userId=\${userId}`,
            type: 'GET',
            dataType: 'json',
            success: function (user) {
                document.getElementById('userAvatar').src = user.avatar || 'path/to/default/avatar.jpg';
                document.getElementById('userName').textContent = user.fullname;
                document.getElementById('userEmail').textContent = user.email;

                const statusElement = document.getElementById('userStatus');
                statusElement.textContent = user.status == 1 ? 'Đang hoạt động' : 'Bị cấm';
                statusElement.className = user.status == 1 ? 'text-success' : 'text-danger';

                document.getElementById('createdAt').textContent = new Date(user.createdAt).toLocaleDateString('vi-VN');
                document.getElementById('updatedAt').textContent = new Date(user.updatedAt).toLocaleDateString('vi-VN');
                document.getElementById('deletedAt').textContent = new Date(user.deletedAt).toLocaleDateString('vi-VN');

                const userAddressesElement = document.getElementById('userAddresses');
                userAddressesElement.innerHTML = '';

                const table = document.createElement('table');
                table.classList.add('table', 'table-bordered');
                table.innerHTML = `
    <thead>
        <tr>
            <th>#</th>
            <th>Địa chỉ</th>
            <th>Số điện thoại</th>
            <th>Mặc định</th>
        </tr>
    </thead>
    <tbody id="addressTableBody"></tbody>
`;

                userAddressesElement.appendChild(table);

                const tbody = document.getElementById('addressTableBody');

                user.userAddresses.forEach(function (address, index) {
                    const row = document.createElement('tr');
                    row.innerHTML = `
        <td>\${index + 1}</td>
        <td>\${address.address}</td>
        <td>\${address.phone}</td>
        <td>\${address.isDefault ? 'Có' : 'Không'}</td>
    `;
                    tbody.appendChild(row);
                });

                $('#userDetailModal').modal('show');
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