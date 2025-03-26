<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Tạo sản phẩm mới</h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/dashboard/products/create" method="post" enctype="multipart/form-data">
                        <!-- Thông tin cơ bản -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Tên sản phẩm <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Giá cơ bản <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="basePrice" step="0.01" required>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Danh mục <span class="text-danger">*</span></label>
                                    <select class="form-control" name="categoryId" required>
                                        <option value="">Chọn danh mục</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Thương hiệu <span class="text-danger">*</span></label>
                                    <select class="form-control" name="brandId" required>
                                        <option value="">Chọn thương hiệu</option>
                                        <c:forEach items="${brands}" var="brand">
                                            <option value="${brand.id}">${brand.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label>Mô tả</label>
                            <textarea class="form-control" name="description" rows="4"></textarea>
                        </div>

                        <!-- Quản lý tồn kho -->
                        <div class="form-group mb-3">
                            <label>Kiểu quản lý tồn kho <span class="text-danger">*</span></label>
                            <select class="form-control" name="stockManagementType" id="stockManagementType" required>
                                <c:forEach items="${stockManagementTypes}" var="type">
                                    <option value="${type.value}">
                                        <c:choose>
                                            <c:when test="${type == 'SIMPLE'}">Đơn giản</c:when>
                                            <c:when test="${type == 'COLOR_ONLY'}">Theo màu sắc</c:when>
                                            <c:when test="${type == 'ADDON_ONLY'}">Theo phụ kiện</c:when>
                                            <c:when test="${type == 'COLOR_AND_ADDON'}">Theo màu sắc và phụ kiện</c:when>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Upload hình ảnh -->
                        <div class="form-group mb-3">
                            <label>Hình ảnh sản phẩm</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" name="images" multiple accept="image/*">
                                <label class="custom-file-label">Chọn hình ảnh</label>
                            </div>
                            <small class="form-text text-muted">Có thể chọn nhiều hình ảnh. Hình đầu tiên sẽ là hình chính.</small>
                        </div>

                        <!-- Quản lý màu sắc -->
                        <div id="colorSection" class="mb-3" style="display: none;">
                            <h5>Màu sắc</h5>
                            <div id="colorContainer">
                                <div class="row mb-2">
                                    <div class="col-md-5">
                                        <input type="text" class="form-control" name="colors[0].name" placeholder="Tên màu">
                                    </div>
                                    <div class="col-md-5">
                                        <input type="number" class="form-control" name="colors[0].additionalPrice" placeholder="Giá thêm" step="0.01">
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-info btn-sm" onclick="addColor()">Thêm màu</button>
                        </div>

                        <!-- Quản lý phụ kiện -->
                        <div id="addonSection" class="mb-3" style="display: none;">
                            <h5>Phụ kiện</h5>
                            <div id="addonContainer">
                                <div class="row mb-2">
                                    <div class="col-md-5">
                                        <input type="text" class="form-control" name="addons[0].name" placeholder="Tên phụ kiện">
                                    </div>
                                    <div class="col-md-5">
                                        <input type="number" class="form-control" name="addons[0].additionalPrice" placeholder="Giá thêm" step="0.01">
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-info btn-sm" onclick="addAddon()">Thêm phụ kiện</button>
                        </div>

                        <!-- Trạng thái -->
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="custom-control custom-switch">
                                    <input type="checkbox" class="custom-control-input" id="isFeatured" name="isFeatured">
                                    <label class="custom-control-label" for="isFeatured">Sản phẩm nổi bật</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Trạng thái</label>
                                    <select class="form-control" name="status">
                                        <c:forEach items="${statusTypes}" var="status">
                                            <option value="${status.value}" ${status == 'ACTIVE' ? 'selected' : ''}>
                                                <c:choose>
                                                    <c:when test="${status == 'ACTIVE'}">Kích hoạt</c:when>
                                                    <c:when test="${status == 'INACTIVE'}">Không kích hoạt</c:when>
                                                    <c:when test="${status == 'DELETED'}">Đã xóa</c:when>
                                                </c:choose>
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary">Tạo sản phẩm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý hiển thị section màu sắc và phụ kiện
    document.getElementById('stockManagementType').addEventListener('change', function() {
        const colorSection = document.getElementById('colorSection');
        const addonSection = document.getElementById('addonSection');
        
        switch(this.value) {
            case '0': // Simple
                colorSection.style.display = 'none';
                addonSection.style.display = 'none';
                break;
            case '1': // Color Only
                colorSection.style.display = 'block';
                addonSection.style.display = 'none';
                break;
            case '2': // Addon Only
                colorSection.style.display = 'none';
                addonSection.style.display = 'block';
                break;
            case '3': // Color and Addon
                colorSection.style.display = 'block';
                addonSection.style.display = 'block';
                break;
        }
    });

    let colorCount = 1;
    function addColor() {
        const container = document.getElementById('colorContainer');
        const div = document.createElement('div');
        div.className = 'row mb-2';
        div.innerHTML = `
            <div class="col-md-5">
                <input type="text" class="form-control" name="colors[${colorCount}].name" placeholder="Tên màu">
            </div>
            <div class="col-md-5">
                <input type="number" class="form-control" name="colors[${colorCount}].additionalPrice" placeholder="Giá thêm" step="0.01">
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger btn-sm" onclick="this.closest('.row').remove()">Xóa</button>
            </div>
        `;
        container.appendChild(div);
        colorCount++;
    }

    let addonCount = 1;
    function addAddon() {
        const container = document.getElementById('addonContainer');
        const div = document.createElement('div');
        div.className = 'row mb-2';
        div.innerHTML = `
            <div class="col-md-5">
                <input type="text" class="form-control" name="addons[${addonCount}].name" placeholder="Tên phụ kiện">
            </div>
            <div class="col-md-5">
                <input type="number" class="form-control" name="addons[${addonCount}].additionalPrice" placeholder="Giá thêm" step="0.01">
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger btn-sm" onclick="this.closest('.row').remove()">Xóa</button>
            </div>
        `;
        container.appendChild(div);
        addonCount++;
    }

    // Xử lý hiển thị tên file khi chọn hình ảnh
    document.querySelector('input[type="file"]').addEventListener('change', function(e) {
        const fileName = Array.from(this.files).map(file => file.name).join(', ');
        const label = this.nextElementSibling;
        label.textContent = fileName || 'Chọn hình ảnh';
    });
</script>
