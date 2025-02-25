<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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
                            <input type="text" class="form-control" name="fullname" placeholder="Nhập họ và tên" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phone" placeholder="Nhập số điện thoại" required>
                        </div>

                        <!-- Thêm select tỉnh/thành -->
                        <div class="col-md-4">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <select class="form-select" id="provinceSelect" name="provinceId" required>
                                <option value="">Chọn Tỉnh/Thành phố</option>
                            </select>
                        </div>

                        <!-- Thêm select quận/huyện -->
                        <div class="col-md-4">
                            <label class="form-label">Quận/Huyện</label>
                            <select class="form-select" id="districtSelect" name="districtId" required disabled>
                                <option value="">Chọn Quận/Huyện</option>
                            </select>
                        </div>

                        <!-- Thêm select phường/xã -->
                        <div class="col-md-4">
                            <label class="form-label">Phường/Xã</label>
                            <select class="form-select" id="wardSelect" name="wardId" required disabled>
                                <option value="">Chọn Phường/Xã</option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Địa chỉ chi tiết</label>
                            <input type="text" class="form-control" name="addressDetail"
                                   placeholder="Số nhà, tên đường, khu vực" required>
                        </div>

                        <div class="col-12">
                            <div class="form-check">
                                <input type="checkbox"
                                       class="form-check-input"
                                       id="defaultAddress"
                                       name="isDefault">
                                <label class="form-check-label" for="defaultAddress">
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


            <!-- Danh sách địa chỉ -->
            <div class="row g-4">
                <c:forEach var="address" items="${addresses}">
                    <div class="col-md-6">
                        <div class="address-item">
                            <div class="address-header d-flex justify-content-between align-items-center">
                                <div>
                                    <span class="fw-bold">${address.fullname}</span>
                                    <c:if test="${address.isDefault}">
                                        <span class="default-badge ms-2">Mặc định</span>
                                    </c:if>
                                </div>
                                <div>
                                    <button class="btn btn-address btn-edit me-2">
                                        <i class="bi bi-pencil"></i>
                                    </button>
                                    <button class="btn btn-address btn-delete">
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
    $(document).ready(function() {
        // Khởi tạo select2
        $('#provinceSelect, #districtSelect, #wardSelect').select2({
            placeholder: 'Chọn...',
            allowClear: true,
            width: '100%'
        });

        // Load tỉnh/thành phố
        function loadProvinces() {
            $.get('${pageContext.request.contextPath}/location?action=provinces', function(data) {
                $('#provinceSelect').empty().append('<option value="">Chọn Tỉnh/Thành phố</option>');
                data.forEach(function(province) {
                    $('#provinceSelect').append(new Option(province.name, province.id));
                });
            });
        }

        // Load quận/huyện theo tỉnh
        function loadDistricts(provinceId) {
            if (!provinceId) {
                $('#districtSelect').empty().append('<option value="">Chọn Quận/Huyện</option>').prop('disabled', true);
                $('#wardSelect').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);
                return;
            }

            $.get('${pageContext.request.contextPath}/location', {
                action: 'districts',
                provinceId: provinceId
            }, function(data) {
                $('#districtSelect').empty().append('<option value="">Chọn Quận/Huyện</option>').prop('disabled', false);
                data.forEach(function(district) {
                    $('#districtSelect').append(new Option(district.name, district.id));
                });
            });
        }

        // Load phường/xã theo quận/huyện
        function loadWards(districtId) {
            if (!districtId) {
                $('#wardSelect').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);
                return;
            }

            $.get('${pageContext.request.contextPath}/location', {
                action: 'wards',
                districtId: districtId
            }, function(data) {
                $('#wardSelect').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', false);
                data.forEach(function(ward) {
                    $('#wardSelect').append(new Option(ward.name, ward.id));
                });
            });
        }

        // Event handlers
        $('#provinceSelect').on('change', function() {
            loadDistricts($(this).val());
            $('#wardSelect').empty().append('<option value="">Chọn Phường/Xã</option>').prop('disabled', true);
        });

        $('#districtSelect').on('change', function() {
            loadWards($(this).val());
        });

        // Form submit handler
        $('#addressForm').on('submit', function(e) {
            e.preventDefault();

            // Tạo địa chỉ đầy đủ
            const province = $('#provinceSelect option:selected').text();
            const district = $('#districtSelect option:selected').text();
            const ward = $('#wardSelect option:selected').text();
            const addressDetail = $('input[name="addressDetail"]').val();

            const fullAddress = `${addressDetail}, ${ward}, ${district}, ${province}`;

            // Tạo object data để gửi lên server
            const formData = {
                fullname: $('input[name="fullname"]').val(),
                phone: $('input[name="phone"]').val(),
                provinceId: $('#provinceSelect').val(),
                districtId: $('#districtSelect').val(),
                wardId: $('#wardSelect').val(),
                addressDetail: addressDetail,
                fullAddress: fullAddress,
                isDefault: $('#defaultAddress').is(':checked')
            };

            // Gửi request tạo địa chỉ mới
            $.ajax({
                url: '${pageContext.request.contextPath}/profile',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    action: 'add_address',
                    data: formData
                }),
                success: function(response) {
                    if (response.success) {
                        // Reload trang hoặc thêm địa chỉ mới vào danh sách
                        location.reload();
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert('Có lỗi xảy ra. Vui lòng thử lại.');
                }
            });
        });

        // Load provinces khi trang được load
        loadProvinces();
    });
</script>