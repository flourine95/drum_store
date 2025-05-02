<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    #sortableImageGrid {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
    }

    .image-item {
        width: 200px;
        position: relative;
        cursor: grab;
    }

    .image-item .card {
        width: 100%;
        overflow: hidden;
        border: 1px solid #ccc;
        border-radius: 6px;
    }

    .image-item img.image-preview {
        width: 100%;
        height: 150px;
        object-fit: cover;
    }

    .image-item .card-body {
        background-color: #f8f9fa;
    }
    
    .select-thumbnail {
        width: 50px;
        height: 50px;
        object-fit: cover;
        margin-right: 10px;
        border-radius: 4px;
    }
    
    .select-thumbnail-small {
        width: 20px;
        height: 20px;
        object-fit: cover;
        margin-right: 5px;
        border-radius: 2px;
        vertical-align: middle;
    }
    
    .select2-container {
        width: 100% !important;
    }
</style>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="card-title">Quản lý sản phẩm: ${product.name}</h4>
                    <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-secondary">Quay lại
                        danh sách</a>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                                ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                                ${success}
                        </div>
                    </c:if>

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" id="productTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info"
                                    type="button" role="tab" aria-controls="info" aria-selected="true">Thông tin cơ bản
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="images-tab" data-bs-toggle="tab" data-bs-target="#images"
                                    type="button" role="tab" aria-controls="images" aria-selected="false">Hình ảnh
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="colors-tab" data-bs-toggle="tab" data-bs-target="#colors"
                                    type="button" role="tab" aria-controls="colors" aria-selected="false">Màu sắc
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="addons-tab" data-bs-toggle="tab" data-bs-target="#addons"
                                    type="button" role="tab" aria-controls="addons" aria-selected="false">Phụ kiện
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="variants-tab" data-bs-toggle="tab" data-bs-target="#variants"
                                    type="button" role="tab" aria-controls="variants" aria-selected="false">Biến thể
                            </button>
                        </li>
                    </ul>

                    <!-- Tab content -->
                    <div class="tab-content p-3 border border-top-0 rounded-bottom" id="productTabContent">
                        <!-- Basic Info Tab -->
                        <div class="tab-pane fade show active" id="info" role="tabpanel" aria-labelledby="info-tab">
                            <form id="basicInfoForm" class="needs-validation" novalidate method="post"
                                  action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${product.id}">
                                <input type="hidden" name="updateType" value="basic-info">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="name" class="form-label">Tên sản phẩm</label>
                                        <input type="text" class="form-control" id="name" name="name"
                                               value="${product.name}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="basePrice" class="form-label">Giá cơ bản</label>
                                        <input type="number" class="form-control" id="basePrice" name="basePrice"
                                               value="${product.basePrice}" required>
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

                                        <select class="form-select" id="stockManagementType" name="stockManagementType"
                                                required>
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
                                            <input class="form-check-input" type="checkbox" id="isFeatured"
                                                   name="isFeatured" ${product.featured ? 'checked' : ''}>
                                            <label class="form-check-label" for="isFeatured">Sản phẩm nổi bật</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control editor" id="description" name="description"
                                              rows="5">${product.description}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Lưu thông tin cơ bản</button>
                                <div id="basicInfoUpdateStatus" class="mt-3"></div>
                            </form>
                        </div>

                        <div class="tab-pane fade" id="images" role="tabpanel" aria-labelledby="images-tab">
                            <form id="imagesForm" class="needs-validation" novalidate>

                                <div class="mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5>Danh sách hình ảnh</h5>
                                        <button type="button" class="btn btn-primary" id="addImageBtn">Thêm ảnh mới
                                        </button>
                                    </div>

                                    <p class="text-muted mb-2"><i class="fas fa-info-circle"></i> Kéo và thả để sắp xếp
                                        thứ tự hình ảnh.</p>

                                    <div class="image-grid mb-4" id="sortableImageGrid">
                                        <c:forEach items="${product.images}" var="image" varStatus="status">
                                            <div class="image-item" data-id="${image.id}">
                                                <div class="card">
                                                    <img src="${image.image}" class="card-img-top image-preview"
                                                         alt="Product image"
                                                         onError="this.onerror=null; this.src='https://placehold.co/400';">
                                                    <div class="card-body p-2">
                                                        <div class="form-check mb-2">
                                                            <input class="form-check-input main-image-radio"
                                                                   type="radio"
                                                                   name="mainImageId" value="${image.id}"
                                                                   id="mainImage_${image.id}"
                                                                ${image.main ? 'checked' : ''}>
                                                            <label class="form-check-label" for="mainImage_${image.id}">Ảnh
                                                                chính
                                                            </label>
                                                        </div>
                                                        <div class="d-grid">
                                                            <button type="button"
                                                                    class="btn btn-sm btn-danger remove-image-btn">
                                                                <i class="fas fa-trash"></i> Xóa ảnh
                                                            </button>
                                                        </div>
                                                        <input type="hidden" name="imageIds[]" value="${image.id}">
                                                        <input type="hidden" name="imageUrls[]" value="${image.image}">
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary">Lưu thay đổi ảnh</button>
                            </form>
                        </div>

                        <div class="tab-pane fade" id="colors" role="tabpanel" aria-labelledby="colors-tab">
                            <form id="colorsForm" class="needs-validation" novalidate>
                                <div id="colorsList">
                                    <c:forEach items="${product.colors}" var="color" varStatus="status">
                                        <div class="row mb-3 color-item">
                                            <input type="hidden" name="colorIds[]" value="${color.id}">

                                            <div class="col-md-5">
                                                <label for="colorName_${status.index}" class="form-label">Tên màu</label>
                                                <input type="text" class="form-control" id="colorName_${status.index}"
                                                       name="colorNames[]" value="${color.name}" placeholder="Tên màu" required>
                                            </div>

                                            <div class="col-md-5">
                                                <label for="colorPrice_${status.index}" class="form-label">Giá thêm</label>
                                                <input type="number" class="form-control" id="colorPrice_${status.index}"
                                                       step="1000" name="colorPrices[]"
                                                       value="${color.additionalPrice}" placeholder="Giá thêm" required>
                                            </div>

                                            <div class="col-md-2 d-flex align-items-end">
                                                <button type="button" class="btn btn-danger remove-color-btn">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <button type="button" class="btn btn-secondary" id="addColorBtn">Thêm màu mới</button>
                                <button type="submit" class="btn btn-primary">Lưu màu sắc</button>
                            </form>
                        </div>

                        <div class="tab-pane fade" id="addons" role="tabpanel" aria-labelledby="addons-tab">
                            <form id="addonsForm" class="needs-validation" novalidate>
                                <div id="addonsList">
                                    <c:forEach items="${product.addons}" var="addon" varStatus="status">
                                        <div class="row mb-3 addon-item">
                                            <input type="hidden" name="addonIds[]" value="${addon.id}">

                                            <div class="col-md-5">
                                                <label for="addonName_${status.index}" class="form-label">Tên phụ kiện</label>
                                                <input type="text" class="form-control" id="addonName_${status.index}"
                                                       name="addonNames[]" value="${addon.name}" placeholder="Tên phụ kiện" required>
                                            </div>

                                            <div class="col-md-5">
                                                <label for="addonPrice_${status.index}" class="form-label">Giá thêm</label>
                                                <input type="number" class="form-control" id="addonPrice_${status.index}"
                                                       step="1000" name="addonPrices[]"
                                                       value="${addon.additionalPrice}" placeholder="Giá thêm" required>
                                            </div>

                                            <div class="col-md-2 d-flex align-items-end">
                                                <button type="button" class="btn btn-danger remove-addon-btn">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <button type="button" class="btn btn-secondary" id="addAddonBtn">Thêm phụ kiện mới</button>
                                <button type="submit" class="btn btn-primary">Lưu phụ kiện</button>
                            </form>
                        </div>

                        <!-- Variants Tab -->
                        <div class="tab-pane fade" id="variants" role="tabpanel" aria-labelledby="variants-tab">
                            <form id="variantsForm" class="needs-validation" novalidate>
                                <div id="variantsList">
                                    <c:forEach items="${product.variants}" var="variant" varStatus="status">
                                        <div class="row mb-3 variant-item">
                                            <input type="hidden" name="variantIds[]" value="${variant.id}">
                                            
                                            <div class="col-md-2">
                                                <label for="variantColor_${status.index}" class="form-label">Màu sắc</label>
                                                <select class="form-select" id="variantColor_${status.index}" name="variantColorIds[]">
                                                    <option value="">Không có màu</option>
                                                    <c:forEach items="${product.colors}" var="color">
                                                        <option value="${color.id}" ${color.id == variant.colorId ? 'selected' : ''}>${color.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-2">
                                                <label for="variantAddon_${status.index}" class="form-label">Phụ kiện</label>
                                                <select class="form-select" id="variantAddon_${status.index}" name="variantAddonIds[]">
                                                    <option value="">Không có phụ kiện</option>
                                                    <c:forEach items="${product.addons}" var="addon">
                                                        <option value="${addon.id}" ${addon.id == variant.addonId ? 'selected' : ''}>${addon.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-2">
                                                <label for="variantImage_${status.index}" class="form-label">Hình ảnh</label>
                                                <select class="form-select image-select" id="variantImage_${status.index}" name="variantImageIds[]">
                                                    <option value="">Không có ảnh</option>
                                                    <c:forEach items="${product.images}" var="image">
                                                        <option value="${image.id}" data-image="${image.image}" ${image.id == variant.imageId ? 'selected' : ''}>${image.main ? 'Ảnh chính' : 'Ảnh #'.concat(image.id)}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-2">
                                                <label for="variantStock_${status.index}" class="form-label">Tồn kho</label>
                                                <input type="number" class="form-control" id="variantStock_${status.index}" 
                                                       name="variantStocks[]" value="${variant.stock}" placeholder="Tồn kho" required>
                                            </div>
                                            
                                            <div class="col-md-2">
                                                <label for="variantStatus_${status.index}" class="form-label">Trạng thái</label>
                                                <select class="form-select" id="variantStatus_${status.index}" name="variantStatuses[]">
                                                    <option value="1" ${variant.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                                    <option value="0" ${variant.status == 0 ? 'selected' : ''}>Tạm ẩn</option>
                                                </select>
                                            </div>
                                            
                                            <div class="col-md-2 d-flex align-items-end">
                                                <button type="button" class="btn btn-danger remove-variant-btn">Xóa</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <button type="button" class="btn btn-secondary" id="addVariantBtn">Thêm biến thể mới</button>
                                <button type="submit" class="btn btn-primary">Lưu biến thể</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.umd.js"></script>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js"></script>
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css"/>
<link rel="stylesheet" href="https://cdn.ckbox.io/ckbox/2.6.1/styles/themes/lark.css">
<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const hash = window.location.hash;
        if (hash) {
            const triggerTab = document.querySelector(`button[data-bs-target="\${hash}"]`);
            if (triggerTab) {
                const tab = new bootstrap.Tab(triggerTab);
                tab.show();
            }
        }

        const tabButtons = document.querySelectorAll('#productTabs button[data-bs-toggle="tab"]');
        tabButtons.forEach(btn => {
            btn.addEventListener('shown.bs.tab', function (e) {
                const target = e.target.getAttribute('data-bs-target');
                history.replaceState(null, null, target);
            });
        });
    });
</script>

<script>
    $(document).ready(() => {
        Sortable.create($('#sortableImageGrid')[0], {
            animation: 150,
            onEnd: function () {
                updateImageOrder();
            }
        });

        $("#addImageBtn").on("click", () => {
            $("<input>", {
                type: "file",
                accept: "image/*",
                multiple: true
            }).on("change", e => {
                const files = e.target.files;
                if (files && files.length > 0) {
                    handleMultipleImageUpload(files);
                }
            }).trigger("click");
        });

        const updateImageOrder = () => {
            const orderArray = $('#sortableImageGrid .image-item').map(function () {
                return $(this).data('id');
            }).get();
            $('#imageOrder').val(orderArray.join(','));
        };

        const addImageToList = (imageUrl) => {
            const tempId = 'new_' + new Date().getTime();

            const template = `
                <div class="image-item" data-id="\${tempId}">
                    <div class="card">
                        <img src="\${imageUrl}" class="card-img-top image-preview" alt="Product image" onError="this.onerror=null; this.src='https://placehold.co/400';">
                        <div class="card-body p-2">
                            <div class="form-check mb-2">
                                <input class="form-check-input main-image-radio" type="radio"
                                       name="mainImageId" value="\${tempId}" id="mainImage_\${tempId}">
                                <label class="form-check-label" for="mainImage_\${tempId}">
                                    Ảnh chính
                                </label>
                            </div>
                            <div class="d-grid">
                                <button type="button" class="btn btn-sm btn-danger remove-image-btn">
                                    <i class="fas fa-trash"></i> Xóa ảnh
                                </button>
                            </div>
                            <input type="hidden" name="imageIds[]" value="\${tempId}">
                            <input type="hidden" name="imageUrls[]" value="\${imageUrl}">
                        </div>
                    </div>
                </div>
            `;

            $('#sortableImageGrid').append(template);
            updateImageOrder();
        };

        async function getRealCKBoxToken() {
            const res = await fetch('/api/keys?service=ckbox-dev');

            const tokenUrl = await res.text();

            const tokenResponse = await fetch(tokenUrl);

            const token = await tokenResponse.text();
            return token.trim();
        }

        async function handleMultipleImageUpload(files) {
            const totalFiles = files.length;
            SwalHelper.loading(`Đang tải \${totalFiles} ảnh lên...`, `Đã xử lý: <b>0</b>/\${totalFiles}`);
            let successCount = 0;
            let errorCount = 0;

            try {
                const authToken = await getRealCKBoxToken();

                for (let i = 0; i < totalFiles; i++) {
                    const file = files[i];
                    try {
                        SwalHelper.updateHtml(`Đã xử lý: <b>\${i}</b>/\${totalFiles}`)
                        const formData = new FormData();
                        formData.append('file', file);
                        formData.append('categoryId', '5d000eac-8904-410e-9185-ca1d35cf56f3');

                        const uploadRes = await fetch('https://api.ckbox.io/assets', {
                            method: 'POST',
                            headers: {'Authorization': authToken},
                            body: formData
                        });
                        if (!uploadRes.ok) throw new Error(`Tải ảnh \${i+1} thất bại`);
                        const data = await uploadRes.json();
                        const imageUrl = [
                            data.imageUrls?.default, data.url, data.urls?.default,
                            data.url?.default, data.defaultUrl, data.image, data.imageUrl
                        ].find(Boolean) || 'https://placehold.co/400';

                        const finalUrl = imageUrl.endsWith('.webp') ? imageUrl.replace('.webp', '.jpeg') : imageUrl;

                        addImageToList(finalUrl);
                        successCount++;

                    } catch (uploadErr) {
                        console.error(`Lỗi khi tải ảnh \${i+1}:`, uploadErr);
                        errorCount++;
                    }
                }

                SwalHelper.success();
            } catch (err) {
                SwalHelper.error();
            }
        }

        $(document).on('click', '.remove-image-btn', function () {
            $(this).closest('.image-item').remove();
            updateImageOrder();
        });

        $(document).on('click', '.form-check-label, .main-image-radio', function (e) {
            const radio = $(this).is('.main-image-radio') ? $(this) : $(this).prev('.main-image-radio');
            radio.prop('checked', true);
            $('.main-image-radio').not(radio).prop('checked', false);
        });

        $('#basicInfoForm').on('submit', function (e) {
            e.preventDefault();

            SwalHelper.loading();

            const formData = $(this).serialize();

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    SwalHelper.success(response.message);
                },
                error: function (xhr, status, error) {
                    SwalHelper.error(error);
                }
            });
        });

        $('#imagesForm').on('submit', function (e) {
            e.preventDefault();

            const images = [];
            const mainImageId = $('input[name="mainImageId"]:checked').val();

            $('#sortableImageGrid .image-item').each(function (index) {
                const imageId = $(this).data('id');
                const imageUrl = $(this).find('img.image-preview').attr('src');

                images.push({
                    id: imageId,
                    image: imageUrl,
                    main: imageId == mainImageId,
                    sortOrder: index,
                });
            });

            SwalHelper.loading();

            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/products?action=update&id=${product.id}&updateType=images',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({images: images}),
                dataType: 'json',
                success: function (response) {
                    SwalHelper.success(response.message);
                },
                error: function (xhr, status, error) {
                    SwalHelper.error(error);
                }
            });
        });

        $('#colorsForm').on('submit', function (e) {
            e.preventDefault();

            // Validate form - remove empty entries
            $('.color-item').each(function() {
                const colorName = $(this).find('input[name="colorNames[]"]').val().trim();
                if (!colorName) {
                    $(this).remove();
                }
            });

            SwalHelper.loading();

            const formData = $(this).serialize();

            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/products?action=update&id=${product.id}&updateType=colors',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    SwalHelper.success(response.message);
                },
                error: function (xhr, status, error) {
                    SwalHelper.error(error);
                }
            });
        });

        $(document).on('click', '.remove-color-btn', function () {
            $(this).closest('.color-item').remove();
        });

        $('#addAddonBtn').on('click', function () {
            addNewAddonRow();
        });

        function addNewAddonRow() {
            const newRow = `
                <div class="row mb-3 addon-item">
                    <input type="hidden" name="addonIds[]" value="">

                    <div class="col-md-5">
                        <label class="form-label">Tên phụ kiện</label>
                        <input type="text" class="form-control" name="addonNames[]" placeholder="Tên phụ kiện" required>
                    </div>

                    <div class="col-md-5">
                        <label class="form-label">Giá thêm</label>
                        <input type="number" class="form-control" name="addonPrices[]" value="0" step="1000" placeholder="Giá thêm" required>
                    </div>

                    <div class="col-md-2 d-flex align-items-end">
                        <button type="button" class="btn btn-danger remove-addon-btn">Xóa</button>
                    </div>
                </div>
            `;
            $('#addonsList').append(newRow);
        }

        $(document).on('click', '.remove-addon-btn', function () {
            $(this).closest('.addon-item').remove();
        });
        $('#addColorBtn').on('click', function () {
            addNewColorRow();
        });

        function addNewColorRow() {
            const newRow = `
                <div class="row mb-3 color-item">
                    <input type="hidden" name="colorIds[]" value="">

                    <div class="col-md-5">
                        <label class="form-label">Tên màu</label>
                        <input type="text" class="form-control" name="colorNames[]" placeholder="Tên màu" required>
                    </div>

                    <div class="col-md-5">
                        <label class="form-label">Giá thêm</label>
                        <input type="number" class="form-control" name="colorPrices[]" value="0" step="1000" placeholder="Giá thêm" required>
                    </div>

                    <div class="col-md-2 d-flex align-items-end">
                        <button type="button" class="btn btn-danger remove-color-btn">Xóa</button>
                    </div>
                </div>
            `;

            $('#colorsList').append(newRow);
        }

        $(document).on('click', '.remove-color-btn', function () {
            $(this).closest('.color-item').remove();
        });

        $('#addonsForm').on('submit', function (e) {
            e.preventDefault();

            // Validate form - remove empty entries
            $('.addon-item').each(function() {
                const addonName = $(this).find('input[name="addonNames[]"]').val().trim();
                if (!addonName) {
                    $(this).remove();
                }
            });

            SwalHelper.loading();

            const formData = $(this).serialize();

            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/products?action=update&id=${product.id}&updateType=addons',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    SwalHelper.success(response.message);
                },
                error: function (xhr, status, error) {
                    SwalHelper.error(error);
                }
            });
        });

        $('#variantsForm').on('submit', function (e) {
            e.preventDefault();

            // Validate form - remove empty entries
            $('.variant-item').each(function() {
                const stock = $(this).find('input[name="variantStocks[]"]').val().trim();
                if (!stock || parseInt(stock) < 0) {
                    $(this).remove();
                }
            });

            SwalHelper.loading();

            const formData = $(this).serialize();

            $.ajax({
                url: '${pageContext.request.contextPath}/dashboard/products?action=update&id=${product.id}&updateType=variants',
                type: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    SwalHelper.success(response.message);
                },
                error: function (xhr, status, error) {
                    SwalHelper.error(error);
                }
            });
        });

        $('#addVariantBtn').on('click', function () {
            addNewVariantRow();
        });

        function addNewVariantRow() {
            // Fetch options via API
            $.ajax({
                url: '${pageContext.request.contextPath}/api/products/options?productId=${product.id}',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    let colorOptions = '<option value="">Không có màu</option>';
                    let addonOptions = '<option value="">Không có phụ kiện</option>';
                    let imageOptions = '<option value="">Không có ảnh</option>';
                    
                    // Build color options
                    if (response.colors && response.colors.length > 0) {
                        response.colors.forEach(function(color) {
                            colorOptions += `<option value="\${color.id}">\${color.name}</option>`;
                        });
                    }
                    
                    // Build addon options
                    if (response.addons && response.addons.length > 0) {
                        response.addons.forEach(function(addon) {
                            addonOptions += `<option value="\${addon.id}">\${addon.name}</option>`;
                        });
                    }
                    
                    // Build image options
                    if (response.images && response.images.length > 0) {
                        response.images.forEach(function(image) {
                            const label = image.main ? 'Ảnh chính' : 'Ảnh #' + image.id;
                            imageOptions += `<option value="\${image.id}" data-image="\${image.image}">\${label}</option>`;
                        });
                    }
                    
                    const newRow = `
                        <div class="row mb-3 variant-item">
                            <input type="hidden" name="variantIds[]" value="">

                            <div class="col-md-2">
                                <label class="form-label">Màu sắc</label>
                                <select class="form-select" name="variantColorIds[]">
                                    \${colorOptions}
                                </select>
                            </div>

                            <div class="col-md-2">
                                <label class="form-label">Phụ kiện</label>
                                <select class="form-select" name="variantAddonIds[]">
                                    \${addonOptions}
                                </select>
                            </div>

                            <div class="col-md-2">
                                <label class="form-label">Hình ảnh</label>
                                <select class="form-select image-select" name="variantImageIds[]">
                                    \${imageOptions}
                                </select>
                            </div>

                            <div class="col-md-2">
                                <label class="form-label">Tồn kho</label>
                                <input type="number" class="form-control" name="variantStocks[]" value="0" placeholder="Tồn kho" required>
                            </div>

                            <div class="col-md-2">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="variantStatuses[]">
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Tạm ẩn</option>
                                </select>
                            </div>

                            <div class="col-md-2 d-flex align-items-end">
                                <button type="button" class="btn btn-danger remove-variant-btn">Xóa</button>
                            </div>
                        </div>
                    `;
                    $('#variantsList').append(newRow);
                },
                error: function(xhr, status, error) {
                    SwalHelper.error("Lỗi khi tải dữ liệu: " + error);
                }
            });
        }

        $(document).on('click', '.remove-variant-btn', function () {
            $(this).closest('.variant-item').remove();
        });
    });

</script>

<script>
    $(document).ready(function() {
        // Khởi tạo Select2 cho các dropdown hình ảnh
        $('.image-select').select2({
            templateResult: formatImageOption,
            templateSelection: formatImageSelection
        });
        
        // Format hình ảnh trong dropdown
        function formatImageOption(state) {
            if (!state.id) {
                return state.text;
            }
            
            var imageUrl = $(state.element).data('image');
            if (!imageUrl) {
                return state.text;
            }
            
            var $option = $(
                '<span><img src="' + imageUrl + '" class="select-thumbnail" /> ' + state.text + '</span>'
            );
            
            return $option;
        }
        
        // Format lựa chọn đã chọn
        function formatImageSelection(state) {
            if (!state.id) {
                return state.text;
            }
            
            var imageUrl = $(state.element).data('image');
            if (!imageUrl) {
                return state.text;
            }
            
            var $selection = $(
                '<span><img src="' + imageUrl + '" class="select-thumbnail-small" /> ' + state.text + '</span>'
            );
            
            return $selection;
        }
    });
</script>