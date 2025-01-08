<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form id="createUserForm" action="${pageContext.request.contextPath}/dashboard/users" method="POST" enctype="multipart/form-data">
    <section class="row mb-3">
        <div class="col-md-4">
            <div class="text-center">
                <img id="avatarPreview" src="/images/default-avatar.jpg"
                     alt="Avatar Preview"
                     class="img-fluid rounded-circle user-avatar mb-2">
                <div class="mb-3">
                    <label for="avatarInput" class="form-label fw-bold">Ảnh đại diện:</label>
                    <input type="file" class="form-control" id="avatarInput" name="avatar"
                           accept="image/*" onchange="previewImage(this)">
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Họ tên:</label>
                    <input type="text" name="fullname" class="form-control" required>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Mật khẩu:</label>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Xác nhận mật khẩu:</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Trạng thái:</label>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="statusToggle"
                               name="status" value="1" checked>
                        <label class="form-check-label" for="statusToggle">Hoạt động</label>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="row mb-4">
        <div class="col-12">
            <h5>Quản lý địa chỉ</h5>

            <!-- Form nhập địa chỉ mới -->
            <div class="address-input-form border p-3 mb-3">
                <div class="row">
                    <div class="col-md-5 mb-2">
                        <label class="form-label">Địa chỉ:</label>
                        <input type="text" id="newAddress" class="form-control">
                    </div>
                    <div class="col-md-4 mb-2">
                        <label class="form-label">Số điện thoại:</label>
                        <input type="tel" id="newPhone" class="form-control">
                    </div>
                    <div class="col-md-2 mb-2">
                        <label class="form-label">Mặc định:</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="newIsDefault">
                        </div>
                    </div>
                    <div class="col-md-1 mb-2 d-flex align-items-end">
                        <button type="button" class="btn btn-primary" onclick="addNewAddress()">
                            Thêm
                        </button>
                    </div>
                </div>
            </div>

            <!-- Danh sách địa chỉ đã thêm -->
            <div class="addresses-list mb-3">
                <h6>Danh sách địa chỉ đã thêm:</h6>
                <div id="addressesContainer" class="list-group">
                    <!-- Địa chỉ sẽ được thêm vào đây động -->
                </div>
            </div>

            <!-- Hidden input để lưu danh sách địa chỉ dạng JSON -->
            <input type="hidden" name="addressesJson" id="addressesJson">
        </div>
    </section>

    <div class="form-actions">
        <button type="submit" class="btn btn-primary">Tạo mới</button>
        <a href="${pageContext.request.contextPath}/dashboard/users" class="btn btn-secondary">Hủy</a>
    </div>
</form>

<style>
    .user-avatar {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 50%;
    }

    .form-actions {
        margin-top: 20px;
    }

    .address-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 15px;
        margin-bottom: 5px;
    }

    .address-info {
        flex-grow: 1;
    }

    .address-actions {
        display: flex;
        gap: 5px;
    }

    .default-badge {
        background-color: #198754;
        color: white;
        padding: 2px 8px;
        border-radius: 4px;
        font-size: 0.8em;
        margin-left: 10px;
    }
</style>

<script>
    // Mảng lưu trữ danh sách địa chỉ
    let addresses = [];

    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    function addNewAddress() {
        const addressInput = document.getElementById('newAddress');
        const phoneInput = document.getElementById('newPhone');
        const isDefaultInput = document.getElementById('newIsDefault');

        // Validation
        if (!addressInput.value.trim() || !phoneInput.value.trim()) {
            alert('Vui lòng nhập đầy đủ địa chỉ và số điện thoại');
            return;
        }

        // Nếu đánh dấu là địa chỉ mặc định, bỏ đánh dấu các địa chỉ khác
        if (isDefaultInput.checked) {
            addresses.forEach(addr => addr.isDefault = false);
        }

        // Thêm địa chỉ mới vào mảng
        const newAddress = {
            address: addressInput.value.trim(),
            phone: phoneInput.value.trim(),
            isDefault: isDefaultInput.checked
        };
        addresses.push(newAddress);

        // Cập nhật giao diện
        renderAddresses();

        // Reset form
        addressInput.value = '';
        phoneInput.value = '';
        isDefaultInput.checked = false;
    }

    function renderAddresses() {
        const container = document.getElementById('addressesContainer');
        container.innerHTML = '';

        addresses.forEach((addr, index) => {
            const addressElement = document.createElement('div');
            addressElement.className = 'list-group-item address-item';
            addressElement.innerHTML = `
                <div class="address-info">
                    <strong>${addr.address}</strong> - ${addr.phone}
                    ${addr.isDefault ? '<span class="default-badge">Mặc định</span>' : ''}
                </div>
                <div class="address-actions">
                    ${!addr.isDefault ? `
                        <button type="button" class="btn btn-sm btn-success"
                                onclick="setDefaultAddress(${index})">
                            Đặt mặc định
                        </button>
                    ` : ''}
                    <button type="button" class="btn btn-sm btn-danger"
                            onclick="removeAddress(${index})">
                        Xóa
                    </button>
                </div>
            `;
            container.appendChild(addressElement);
        });

        // Cập nhật hidden input với dữ liệu JSON
        document.getElementById('addressesJson').value = JSON.stringify(addresses);
    }

    function setDefaultAddress(index) {
        addresses.forEach(addr => addr.isDefault = false);
        addresses[index].isDefault = true;
        renderAddresses();
    }

    function removeAddress(index) {
        addresses.splice(index, 1);
        renderAddresses();
    }

    // Xử lý submit form
    document.getElementById('createUserForm').addEventListener('submit', function(e) {
        if (addresses.length === 0) {
            e.preventDefault();
            alert('Vui lòng thêm ít nhất một địa chỉ');
            return;
        }

        // Kiểm tra có ít nhất một địa chỉ mặc định
        if (!addresses.some(addr => addr.isDefault)) {
            e.preventDefault();
            alert('Vui lòng chọn một địa chỉ mặc định');
            return;
        }
    });
</script>