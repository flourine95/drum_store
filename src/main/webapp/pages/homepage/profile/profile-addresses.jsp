<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<style>
    .select2-container {
        width: 100% !important;
    }

    .select2-container .select2-selection--single {
        height: 42px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 42px;
        padding-left: 15px;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: 40px;
    }

    .select2-dropdown {
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .select2-search__field {
        border-radius: 4px !important;
        padding: 8px !important;
    }

    .select2-results__option {
        padding: 8px 15px;
    }

    .select2-results__option--highlighted[aria-selected] {
        background-color: var(--bs-primary) !important;
        color: var(--hover-color) !important;
    }

    .form-check-input {
        width: 1.2em;
        height: 1.2em;
        margin-top: 0.25em;
        border: 2px solid rgba(0, 0, 0, 0.2);
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .form-check-input:checked {
        background-color: var(--bs-primary) !important;
        border-color: var(--bs-primary) !important;
    }

    .form-check-input:focus {
        border-color: var(--bs-primary);
        box-shadow: 0 0 0 0.2rem rgba(253, 0, 0, 0.25);
    }

    .form-check-input:hover {
        border-color: var(--bs-primary);
    }

    .form-check-label {
        cursor: pointer;
        user-select: none;
        padding-left: 0.5rem;
        color: var(--text-color);
    }

    /* Custom checkbox container */
    .form-check {
        display: flex;
        align-items: center;
        padding: 0.5rem;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .form-check:hover {
        background-color: rgba(253, 0, 0, 0.05);
    }

    .address-card {
        background: var(--text-white);
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border-radius: 15px;
        overflow: hidden;
    }

    .address-item {
        background: var(--text-white);
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        height: 100%;
    }

    .address-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .address-header {
        padding: 15px;
        border-bottom: 1px solid #eee;
    }

    .address-content {
        padding: 15px;
    }

    .default-badge {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        padding: 4px 10px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
    }

    .btn-address {
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        border: none;
    }

    .btn-add {
        background-color: var(--bs-primary);
        color: var(--hover-color);
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        background-color: var(--hover-color);
        color: var(--bs-primary);
    }

    .btn-edit {
        background-color: var(--bs-primary);
        color: var(--hover-color);
        padding: 6px 12px;
    }

    .btn-delete {
        background-color: var(--bs-secondary);
        color: var(--text-white);
        padding: 6px 12px;
    }

    .address-form {
        background: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 8px;
        padding: 10px 15px;
        border: 1px solid rgba(0, 0, 0, 0.1);
    }

    .form-control:focus {
        border-color: var(--bs-primary);
        box-shadow: 0 0 0 0.2rem rgba(253, 0, 0, 0.25);
    }
</style>

<div class="col-md-9">
    <div class="address-card animate__animated animate__fadeInRight">
        <div class="card-header p-4">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="bi bi-geo-alt me-2"></i>
                    DANH SÁCH ĐỊA CHỈ
                </h5>
                <button class="btn btn-address btn-add" id="add-address-btn">
                    <i class="bi bi-plus-circle me-2"></i>Thêm địa chỉ mới
                </button>
            </div>
        </div>

        <div class="card-body p-4">

            <!-- Form thêm địa chỉ mới -->
            <div id="add-address-form" class="address-form" style="display: none;">
                <form id="addressForm">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" name="add_fullname" placeholder="Nhập họ và tên"
                                   required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="add_phone" placeholder="Nhập số điện thoại"
                                   required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <select class="form-select" id="add_provinceSelect" name="add_provinceId" required>
                                <option value="">Chọn Tỉnh/Thành phố</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Quận/Huyện</label>
                            <select class="form-select" id="add_districtSelect" name="add_districtId" required disabled>
                                <option value="">Chọn Quận/Huyện</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Phường/Xã</label>
                            <select class="form-select" id="add_wardSelect" name="add_wardId" required disabled>
                                <option value="">Chọn Phường/Xã</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Địa chỉ chi tiết</label>
                            <input type="text" class="form-control" name="add_addressDetail"
                                   placeholder="Số nhà, tên đường, khu vực" required>
                        </div>

                        <div class="col-12">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="add_defaultAddress"
                                       name="add_isDefault">
                                <label class="form-check-label" for="add_defaultAddress">
                                    Đặt làm địa chỉ mặc định
                                </label>
                            </div>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-address btn-add">
                                <i class="bi bi-check-circle me-2"></i>Lưu địa chỉ
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Form chỉnh sửa địa chỉ -->
            <div id="edit-address-form" class="address-form" style="display: none;">
                <form id="editAddressForm">
                    <input type="hidden" name="edit_addressId" id="editAddressId">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" name="edit_fullname" id="editFullname" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="edit_phone" id="editPhone" required>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <select class="form-select" id="edit_provinceSelect" name="edit_provinceId" required>
                                <option value="">Chọn Tỉnh/Thành phố</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Quận/Huyện</label>
                            <select class="form-select" id="edit_districtSelect" name="edit_districtId" required>
                                <option value="">Chọn Quận/Huyện</option>
                            </select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Phường/Xã</label>
                            <select class="form-select" id="edit_wardSelect" name="edit_wardId" required>
                                <option value="">Chọn Phường/Xã</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Địa chỉ chi tiết</label>
                            <input type="text" class="form-control" name="edit_addressDetail" id="editAddressDetail"
                                   required>
                        </div>

                        <div class="col-12">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="edit_defaultAddress"
                                       name="edit_isDefault">
                                <label class="form-check-label" for="edit_defaultAddress">
                                    Đặt làm địa chỉ mặc định
                                </label>
                            </div>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-address btn-add">
                                <i class="bi bi-check-circle me-2"></i>Cập nhật địa chỉ
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="closeEditForm()">
                                <i class="bi bi-x-circle me-2"></i>Hủy
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Danh sách địa chỉ -->
            <div class="row g-4">
                <c:forEach var="address" items="${addresses}">
                    <div class="col-md-6">
                        <div class="address-item" data-address-id="${address.id}">
                            <div class="address-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="fw-bold">${address.fullname}</span>
                                    <c:if test="${address.isDefault}">
                                        <span class="default-badge ms-2">Mặc định</span>
                                    </c:if>
                                </div>
                                <div>
                                    <button class="btn btn-address btn-edit me-2" data-address-id="${address.id}">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-address btn-delete" data-address-id="${address.id}">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="address-content">
                                <p class="mb-2">
                                    <i class="bi bi-geo-alt me-2"></i>
                                        ${address.address}
                                </p>
                                <p class="mb-0">
                                    <i class="bi bi-telephone me-2"></i>
                                        ${address.phone}
                                </p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Toggle form thêm địa chỉ
        $('#add-address-btn').click(function () {
            $('#add-address-form').slideToggle(300);
        });

        // Hiệu ứng hover cho address items
        $('.address-item').hover(
            function () {
                $(this).addClass('shadow-lg');
            },
            function () {
                $(this).removeClass('shadow-lg');
            }
        );

        // Animation khi xóa địa chỉ
        $('.btn-delete').click(function () {
            $(this).closest('.col-md-6').addClass('animate__animated animate__fadeOutRight');
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('#add_provinceSelect, #add_districtSelect, #add_wardSelect, #edit_provinceSelect, #edit_districtSelect, #edit_wardSelect').select2({
            placeholder: 'Chọn...',
            allowClear: true,
            width: '100%'
        });

        // Load provinces cho cả 2 form
        function loadProvinces(selector) {
            $.get('${pageContext.request.contextPath}/location?action=provinces', function (data) {
                $(selector).empty().append('<option value="">Chọn Tỉnh/Thành phố</option>');
                data.forEach(function (province) {
                    $(selector).append(new Option(province.name, province.id));
                });
            });
        }

        // Load districts
        function loadDistricts(provinceId, selector) {
            if (!provinceId) {
                $(selector).empty()
                    .append('<option value="">Chọn Quận/Huyện</option>')
                    .prop('disabled', true)
                    .trigger('change.select2');
                return;
            }

            $.get('${pageContext.request.contextPath}/location', {
                action: 'districts',
                provinceId: provinceId
            })
                .done(function(districts) {
                    const $select = $(selector);
                    $select.empty().append('<option value="">Chọn Quận/Huyện</option>');
                    districts.forEach(function(district) {
                        $select.append(new Option(district.name, district.id));
                    });
                    $select.prop('disabled', false).trigger('change.select2');
                });
        }

// Hàm load wards
        function loadWards(districtId, selector) {
            if (!districtId) {
                $(selector).empty()
                    .append('<option value="">Chọn Phường/Xã</option>')
                    .prop('disabled', true)
                    .trigger('change.select2');
                return;
            }

            $.get('${pageContext.request.contextPath}/location', {
                action: 'wards',
                districtId: districtId
            })
                .done(function(wards) {
                    const $select = $(selector);
                    $select.empty().append('<option value="">Chọn Phường/Xã</option>');
                    wards.forEach(function(ward) {
                        $select.append(new Option(ward.name, ward.id));
                    });
                    $select.prop('disabled', false).trigger('change.select2');
                });
        }

        // Load initial provinces
        loadProvinces('#add_provinceSelect');
        loadProvinces('#edit_provinceSelect');

        // Event handlers for add form
        $('#add_provinceSelect').on('change', function () {
            loadDistricts($(this).val(), '#add_districtSelect');
            $('#add_wardSelect').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);
        });

        $('#add_districtSelect').on('change', function () {
            loadWards($(this).val(), '#add_wardSelect');
        });

        // Event handlers for edit form
        $('#edit_provinceSelect').on('change', function() {
            const provinceId = $(this).val();
            loadDistricts(provinceId, '#edit_districtSelect');
            $('#edit_wardSelect').empty()
                .append('<option value="">Chọn Phường/Xã</option>')
                .prop('disabled', true)
                .trigger('change.select2');
        });

        $('#edit_districtSelect').on('change', function() {
            const districtId = $(this).val();
            loadWards(districtId, '#edit_wardSelect');
        });

        // Sửa lại phần xử lý click edit button
        $('.btn-edit').click(function() {
            const addressId = $(this).closest('.address-item').data('address-id');

            // Hiển thị loading
            $('#edit-address-form').slideDown(300);
            $('#add-address-form').slideUp(300);

            // Load thông tin địa chỉ
            $.ajax({
                url: '${pageContext.request.contextPath}/profile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    action: 'get_address',
                    data: { addressId: addressId }
                }),
                success: function(data) {
                    // Fill thông tin cơ bản ngay lập tức
                    $('#editAddressId').val(data.id);
                    $('input[name="edit_fullname"]').val(data.fullname);
                    $('input[name="edit_phone"]').val(data.address);
                    $('input[name="edit_addressDetail"]').val(data.address);
                    $('#edit_defaultAddress').prop('checked', data.isDefault);

                    // Tạm thời off các event handlers
                    $('#edit_provinceSelect').off('change');
                    $('#edit_districtSelect').off('change');
                    $('#edit_wardSelect').off('change');

                    // Load tất cả dữ liệu địa chỉ trong một request
                    $.get('${pageContext.request.contextPath}/location', {
                        action: 'full_location',
                        provinceId: data.provinceId,
                        districtId: data.districtId
                    })
                        .done(function(locationData) {
                            // Fill provinces
                            $('#edit_provinceSelect').empty()
                                .append('<option value="">Chọn Tỉnh/Thành phố</option>');
                            locationData.provinces.forEach(province => {
                                $('#edit_provinceSelect').append(new Option(province.name, province.id));
                            });

                            // Fill districts
                            $('#edit_districtSelect').empty()
                                .append('<option value="">Chọn Quận/Huyện</option>')
                                .prop('disabled', false);
                            locationData.districts.forEach(district => {
                                $('#edit_districtSelect').append(new Option(district.name, district.id));
                            });

                            // Fill wards
                            $('#edit_wardSelect').empty()
                                .append('<option value="">Chọn Phường/Xã</option>')
                                .prop('disabled', false);
                            locationData.wards.forEach(ward => {
                                $('#edit_wardSelect').append(new Option(ward.name, ward.id));
                            });

                            // Set selected values
                            $('#edit_provinceSelect').val(data.provinceId).trigger('change.select2');

                            // Đợi districts load xong
                            setTimeout(() => {
                                $('#edit_districtSelect').val(data.districtId).trigger('change.select2');

                                // Đợi wards load xong
                                setTimeout(() => {
                                    $('#edit_wardSelect').val(data.wardId).trigger('change.select2');
                                }, 300);
                            }, 300);

                            // Gắn lại event handlers
                            $('#edit_provinceSelect').off('change').on('change', function() {
                                const provinceId = $(this).val();
                                loadDistricts(provinceId, '#edit_districtSelect');
                                $('#edit_wardSelect').empty()
                                    .append('<option value="">Chọn Phường/Xã</option>')
                                    .prop('disabled', true)
                                    .trigger('change.select2');
                            });

                            $('#edit_districtSelect').off('change').on('change', function() {
                                const districtId = $(this).val();
                                loadWards(districtId, '#edit_wardSelect');
                            });
                        })
                        .fail(function(xhr, status, error) {
                            console.error('Error loading location data:', error);
                            alert('Có lỗi xảy ra khi tải dữ liệu địa chỉ');
                        });
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    alert('Không thể tải thông tin địa chỉ');
                }
            });
        });

        // Xử lý thêm địa chỉ mới
        $('#addressForm').submit(function (e) {
            e.preventDefault();

            const formData = {
                fullname: $('input[name="add_fullname"]').val(),
                phone: $('input[name="add_phone"]').val(),
                provinceId: $('#add_provinceSelect').val(),
                districtId: $('#add_districtSelect').val(),
                wardId: $('#add_wardSelect').val(),
                addressDetail: $('input[name="add_addressDetail"]').val(),
                isDefault: $('#add_defaultAddress').is(':checked')
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/profile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    action: 'add_address',
                    data: formData
                }),
                success: function (response) {
                    if (response.success) {
                        location.reload();
                    } else {
                        alert(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi thêm địa chỉ');
                }
            });
        });

        // Xử lý chỉnh sửa địa chỉ
        $('#editAddressForm').submit(function (e) {
            e.preventDefault();

            const formData = {
                id: $('#editAddressId').val(),
                fullname: $('input[name="edit_fullname"]').val(),
                phone: $('input[name="edit_phone"]').val(),
                provinceId: $('#edit_provinceSelect').val(),
                districtId: $('#edit_districtSelect').val(),
                wardId: $('#edit_wardSelect').val(),
                addressDetail: $('input[name="edit_addressDetail"]').val(),
                isDefault: $('#edit_defaultAddress').is(':checked')
            };

            $.ajax({
                url: '${pageContext.request.contextPath}/profile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    action: 'update_address',
                    data: formData
                }),
                success: function (response) {
                    if (response.success) {
                        location.reload();
                    } else {
                        alert(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi cập nhật địa chỉ');
                }
            });
        });

        // Xử lý xóa địa chỉ
        $('.btn-delete').click(function () {
            if (!confirm('Bạn có chắc chắn muốn xóa địa chỉ này?')) {
                return;
            }

            const addressItem = $(this).closest('.address-item');
            const addressId = addressItem.data('address-id');
            console.log('Deleting address:', addressId);

            $.ajax({
                url: '${pageContext.request.contextPath}/profile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    action: 'delete_address',
                    addressId: addressId
                }),
                success: function (response) {
                    if (response.success) {
                        addressItem.closest('.col-md-6').fadeOut(300, function () {
                            $(this).remove();
                        });
                    } else {
                        alert(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('Có lỗi xảy ra khi xóa địa chỉ');
                }
            });
        });
    });

    function closeEditForm() {
        $('#edit-address-form').slideUp(300);
    }
</script>