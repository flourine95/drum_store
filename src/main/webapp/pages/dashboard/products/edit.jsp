<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="card-title">Quản lý sản phẩm: ${product.name}</h4>
                    <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-secondary">Quay lại danh sách</a>
                </div>
                <div class="card-body">
                    <c:if test="\${not empty error}">
                        <div class="alert alert-danger" role="alert">
                                ${error}
                        </div>
                    </c:if>
                    <c:if test="\${not empty success}">
                        <div class="alert alert-success" role="alert">
                                ${success}
                        </div>
                    </c:if>

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" id="productTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab" aria-controls="info" aria-selected="true">Thông tin cơ bản</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="images-tab" data-bs-toggle="tab" data-bs-target="#images" type="button" role="tab" aria-controls="images" aria-selected="false">Hình ảnh</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="colors-tab" data-bs-toggle="tab" data-bs-target="#colors" type="button" role="tab" aria-controls="colors" aria-selected="false">Màu sắc</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="addons-tab" data-bs-toggle="tab" data-bs-target="#addons" type="button" role="tab" aria-controls="addons" aria-selected="false">Phụ kiện</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="variants-tab" data-bs-toggle="tab" data-bs-target="#variants" type="button" role="tab" aria-controls="variants" aria-selected="false">Biến thể</button>
                        </li>
                    </ul>

                    <!-- Tab content -->
                    <div class="tab-content p-3 border border-top-0 rounded-bottom" id="productTabContent">
                        <!-- Basic Info Tab -->
                        <div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
                            <form id="basicInfoForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${product.id}">
                                <input type="hidden" name="updateType" value="basic-info">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Tên sản phẩm</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="basePrice" class="form-label">Giá cơ bản</label>
                                        <input type="number" class="form-control" id="basePrice" name="basePrice" value="${product.basePrice}" required>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="categoryId" class="form-label">Danh mục</label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.id}" ${category.id == product.categoryId ? 'selected' : ''}>${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="brandId" class="form-label">Thương hiệu</label>
                                        <select class="form-select" id="brandId" name="brandId" required>
                                            <c:forEach items="${brands}" var="brand">
                                                <option value="${brand.id}" ${brand.id == product.brandId ? 'selected' : ''}>${brand.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="stockManagementType" class="form-label">Kiểu quản lý tồn kho</label>
                                        <select class="form-select" id="stockManagementType" name="stockManagementType" required>
                                            <c:forEach items="${stockManagementTypes}" var="type">
                                                <option value="${type.value}" ${type.value == product.stockManagementType ? 'selected' : ''}>
                                                    <c:choose>
                                                        <c:when test="${type.value == 0}">Đơn giản (không có biến thể)</c:when>
                                                        <c:when test="${type.value == 1}">Chỉ màu sắc</c:when>
                                                        <c:when test="${type.value == 2}">Chỉ phụ kiện</c:when>
                                                        <c:when test="${type.value == 3}">Màu sắc và phụ kiện</c:when>
                                                    </c:choose>
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-check mt-4">
                                            <input class="form-check-input" type="checkbox" id="isFeatured" name="isFeatured" ${product.featured ? 'checked' : ''}>
                                            <label class="form-check-label" for="isFeatured">Sản phẩm nổi bật</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="5">${product.description}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Lưu thông tin cơ bản</button>
                            </form>
                        </div>

                        <!-- Images Tab -->
<%--                        <div class="tab-pane fade" id="images" role="tabpanel" aria-labelledby="images-tab">--%>
<%--                            <form id="imagesForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">--%>
<%--                                <input type="hidden" name="action" value="update">--%>
<%--                                <input type="hidden" name="updateType" value="images">--%>
<%--                                <div class="mb-3">--%>
<%--                                    <label for="mainImageUrl" class="form-label">Hình ảnh chính</label>--%>
<%--                                    <div class="input-group">--%>
<%--                                        <input type="text" class="form-control" id="mainImageUrl" name="mainImageUrl" value="${product.mainImage}" readonly>--%>
<%--                                        <button class="btn btn-outline-secondary" type="button" onclick="openCKBox('mainImageUrl')">Chọn ảnh</button>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="mb-3">--%>
<%--                                    <img id="mainImagePreview" src="${product.mainImage}" class="img-thumbnail" alt="Main Image Preview" style="max-width: 200px;">--%>
<%--                                </div>--%>
<%--                                <button type="submit" class="btn btn-primary">Lưu hình ảnh</button>--%>
<%--                            </form>--%>
<%--                        </div>--%>

                        <!-- Colors Tab -->
                        <div class="tab-pane fade" id="colors" role="tabpanel" aria-labelledby="colors-tab">
                            <form id="colorsForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="updateType" value="colors">
                                <div id="colorsList">
                                    <c:forEach items="${product.colors}" var="color" varStatus="status">
                                        <div class="row mb-3 color-item">
                                            <input type="hidden" name="colorIds[]" value="${color.id}">
                                            <div class="col-md-5">
                                                <input type="text" class="form-control" name="colorNames[]" value="${color.name}" placeholder="Tên màu" required>
                                            </div>
                                            <div class="col-md-5">
                                                <input type="number" class="form-control" name="colorPrices[]" value="${color.additionalPrice}" placeholder="Giá thêm" required>
                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-danger" onclick="removeColor(this)">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" class="btn btn-secondary mb-3" onclick="addColor()">Thêm màu mới</button>
                                <button type="submit" class="btn btn-primary">Lưu màu sắc</button>
                            </form>
                        </div>

                        <!-- Addons Tab -->
                        <div class="tab-pane fade" id="addons" role="tabpanel" aria-labelledby="addons-tab">
                            <form id="addonsForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="updateType" value="addons">
                                <div id="addonsList">
                                    <c:forEach items="${product.addons}" var="addon" varStatus="status">
                                        <div class="row mb-3 addon-item">
                                            <input type="hidden" name="addonIds[]" value="${addon.id}">
                                            <div class="col-md-5">
                                                <input type="text" class="form-control" name="addonNames[]" value="${addon.name}" placeholder="Tên phụ kiện" required>
                                            </div>
                                            <div class="col-md-5">
                                                <input type="number" class="form-control" name="addonPrices[]" value="${addon.additionalPrice}" placeholder="Giá thêm" required>
                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-danger" onclick="removeAddon(this)">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" class="btn btn-secondary mb-3" onclick="addAddon()">Thêm phụ kiện mới</button>
                                <button type="submit" class="btn btn-primary">Lưu phụ kiện</button>
                            </form>
                        </div>

                        <!-- Variants Tab -->
                        <div class="tab-pane fade" id="variants" role="tabpanel" aria-labelledby="variants-tab">
                            <form id="variantsForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="updateType" value="variants">
                                <div id="variantsList">
                                    <c:forEach items="${product.variants}" var="variant" varStatus="status">
                                        <div class="row mb-3 variant-item">
                                            <input type="hidden" name="variantIds[]" value="${variant.id}">
                                            <div class="col-md-3">
                                                <select class="form-select" name="variantColorIds[]">
                                                    <option value="">Không có màu</option>
                                                    <c:forEach items="${product.colors}" var="color">
                                                        <option value="${color.id}" ${color.id == variant.colorId ? 'selected' : ''}>${color.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-3">
                                                <select class="form-select" name="variantAddonIds[]">
                                                    <option value="">Không có phụ kiện</option>
                                                    <c:forEach items="${product.addons}" var="addon">
                                                        <option value="${addon.id}" ${addon.id == variant.addonId ? 'selected' : ''}>${addon.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-2">
                                                <input type="number" class="form-control" name="variantStocks[]" value="${variant.stock}" placeholder="Tồn kho" required>
                                            </div>
                                            <div class="col-md-2">
                                                <select class="form-select" name="variantStatuses[]">
                                                    <option value="1" ${variant.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                                    <option value="0" ${variant.status == 0 ? 'selected' : ''}>Tạm ẩn</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-danger" onclick="removeVariant(this)">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" class="btn btn-secondary mb-3" onclick="addVariant()">Thêm biến thể mới</button>
                                <button type="submit" class="btn btn-primary">Lưu biến thể</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Activate Bootstrap tabs
        var triggerTabList = [].slice.call(document.querySelectorAll('#productTabs button'))
        triggerTabList.forEach(function (triggerEl) {
            var tabTrigger = new bootstrap.Tab(triggerEl)
            triggerEl.addEventListener('click', function (event) {
                event.preventDefault()
                tabTrigger.show()
            })
        })

        // Save active tab to session storage
        $('button[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            sessionStorage.setItem('activeProductTab', $(e.target).attr('id'));
        });

        // Check if there is a saved tab and activate it
        var activeTab = sessionStorage.getItem('activeProductTab');
        if(activeTab){
            $('#' + activeTab).tab('show');
        }
    });
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize CKEditor for description
        ClassicEditor
            .create(document.querySelector('#description'))
            .catch(error => {
                console.error(error);
            });

        // Form submission handlers
        const forms = ['basicInfoForm', 'imagesForm', 'colorsForm', 'addonsForm', 'variantsForm'];
        forms.forEach(formId => {
            document.getElementById(formId).addEventListener('submit', function(e) {
                e.preventDefault();
                
                if (this.checkValidity()) {
                    const formData = new FormData(this);
                    formData.append('id', '\${product.id}');

                    fetch('${pageContext.request.contextPath}/dashboard/products?action=update', {
                        method: 'POST',
                        body: JSON.stringify(Object.fromEntries(formData)),
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            showAlert('success', data.message);
                            if (formId === 'basicInfoForm') {
                                document.querySelector('.card-title').textContent = 'Quản lý sản phẩm: ' + formData.get('name');
                            }
                        } else {
                            showAlert('danger', data.message);
                        }
                    })
                    .catch(error => {
                        showAlert('danger', 'Có lỗi xảy ra: ' + error);
                    });
                }
                
                this.classList.add('was-validated');
            });
        });
    });

    function showAlert(type, message) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-\${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
            \${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        `;
        document.querySelector('.card-body').insertBefore(alertDiv, document.querySelector('.nav-tabs'));
        
        // Auto dismiss after 5 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 5000);
    }

    function addColor() {
        const template = `
            <div class="row mb-3 color-item">
                <input type="hidden" name="colorIds[]" value="">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="colorNames[]" placeholder="Tên màu" required>
                </div>
                <div class="col-md-5">
                    <input type="number" class="form-control" name="colorPrices[]" placeholder="Giá thêm" required>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger" onclick="removeColor(this)">Xóa</button>
                </div>
            </div>
        `;
        document.getElementById('colorsList').insertAdjacentHTML('beforeend', template);
    }

    function addAddon() {
        const template = `
            <div class="row mb-3 addon-item">
                <input type="hidden" name="addonIds[]" value="">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="addonNames[]" placeholder="Tên phụ kiện" required>
                </div>
                <div class="col-md-5">
                    <input type="number" class="form-control" name="addonPrices[]" placeholder="Giá thêm" required>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger" onclick="removeAddon(this)">Xóa</button>
                </div>
            </div>
        `;
        document.getElementById('addonsList').insertAdjacentHTML('beforeend', template);
    }

    function addVariant() {
        const template = `
            <div class="row mb-3 variant-item">
                <input type="hidden" name="variantIds[]" value="">
                <div class="col-md-3">
                    <select class="form-select" name="variantColorIds[]">
                        <option value="">Không có màu</option>
                        <c:forEach items="\${product.colors}" var="color">
                            <option value="\${color.id}">\${color.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="variantAddonIds[]">
                        <option value="">Không có phụ kiện</option>
                        <c:forEach items="\${product.addons}" var="addon">
                            <option value="\${addon.id}">\${addon.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="number" class="form-control" name="variantStocks[]" placeholder="Tồn kho" required>
                </div>
                <div class="col-md-2">
                    <select class="form-select" name="variantStatuses[]">
                        <option value="1">Hoạt động</option>
                        <option value="0">Tạm ẩn</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="button" class="btn btn-danger" onclick="removeVariant(this)">Xóa</button>
                </div>
            </div>
        `;
        document.getElementById('variantsList').insertAdjacentHTML('beforeend', template);
    }

    function removeColor(button) {
        button.closest('.color-item').remove();
    }

    function removeAddon(button) {
        button.closest('.addon-item').remove();
    }

    function removeVariant(button) {
        button.closest('.variant-item').remove();
    }

    function openCKBox(targetInputId) {
        CKBox.mount({
            theme: 'lark',
            onReady: ({ app }) => {
                app.on('file:choose', ({ file }) => {
                    document.getElementById(targetInputId).value = file.url;
                    document.getElementById('mainImagePreview').src = file.url;
                });
            }
        });
    }
</script>