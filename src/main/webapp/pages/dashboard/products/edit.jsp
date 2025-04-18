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
                                    <textarea class="form-control editor" id="description" name="description" rows="5">${product.description}</textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Lưu thông tin cơ bản</button>
                            </form>
                        </div>

                        <!-- Images Tab -->
                        <div class="tab-pane fade" id="images" role="tabpanel" aria-labelledby="images-tab">
                            <form id="imagesForm" class="needs-validation" novalidate method="post" action="${pageContext.request.contextPath}/dashboard/products">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="updateType" value="images">
                                <input type="hidden" name="imageOrder" id="imageOrder" value="">
                                
                                <!-- Images List Section -->
                                <div class="mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5>Danh sách hình ảnh</h5>
                                        <button type="button" class="btn btn-primary" onclick="openCKBoxForImage()">Thêm ảnh mới</button>
                                    </div>
                                    
                                    <p class="text-muted mb-2"><i class="fas fa-info-circle"></i> Kéo và thả để sắp xếp thứ tự hình ảnh.</p>
                                    
                                    <div class="image-grid mb-4" id="sortableImageGrid">
                                        <c:forEach items="${product.images}" var="image" varStatus="status">
                                            <div class="image-item" data-id="${image.id}">
                                                <div class="card">
                                                    <img src="${image.image}" class="card-img-top image-preview" alt="Product image">
                                                    <div class="card-body p-2">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="form-check">
                                                                <input class="form-check-input main-image-radio" type="radio" 
                                                                    name="mainImageId" value="${image.id}"
                                                                    ${image.main ? 'checked' : ''}>
                                                                <label class="form-check-label">Ảnh chính</label>
                                                            </div>
                                                            <button type="button" class="btn btn-sm btn-danger" 
                                                                    onclick="removeImage(this)">
                                                                <i class="fas fa-trash"></i>
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

                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </form>
                        </div>

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
                    formData.append('id', '${product.id}');

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
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
            ${message}
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
                        <c:forEach items="${product.colors}" var="color">
                            <option value="${color.id}">${color.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="variantAddonIds[]">
                        <option value="">Không có phụ kiện</option>
                        <c:forEach items="${product.addons}" var="addon">
                            <option value="${addon.id}">${addon.name}</option>
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

    function openCKBoxForImage() {
        // Sử dụng input file thường thường để chọn file
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/*';
        input.onchange = async (e) => {
            const file = e.target.files[0];
            if (file) {
                // Hiện thông báo loading
                const loadingEl = document.createElement('div');
                loadingEl.className = 'alert alert-info';
                loadingEl.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tải ảnh lên CKBox...';
                document.querySelector('#sortableImageGrid').before(loadingEl);
                
                try {
                    // Lấy token API từ CKBox
                    const tokenResponse = await fetch('https://0b3fzh0zey0a.cke-cs.com/token/dev/741526849e2bf96724c0892afe4ffbb7b23cf23733b2a74cc5d845d3af16?limit=10');
                    
                    if (!tokenResponse.ok) throw new Error('Không thể lấy token');
                    
                    // Lấy token dưới dạng text thay vì JSON
                    const authHeader = await tokenResponse.text();
                    
                    // Tạo FormData để tải file
                    const formData = new FormData();
                    formData.append('file', file);
                    formData.append('categoryId', '9ab973c3-9976-405f-8982-25618fb862a7'); // Thay thế ID thư mục của bạn
                    
                    // Cấu hình request
                    const uploadResponse = await fetch('https://api.ckbox.io/assets', {
                        method: 'POST',
                        headers: {
                            'Authorization': authHeader
                        },
                        body: formData
                    });
                    
                    if (!uploadResponse.ok) throw new Error('Tải ảnh thất bại');
                    
                    const uploadData = await uploadResponse.json();
                    console.log('Upload data:', JSON.stringify(uploadData, null, 2));
                    
                    // Thu thập tất cả các cách lấy URL
                    const possibleUrls = [
                        uploadData.imageUrls?.default, // Đặt imageUrls.default làm ưu tiên
                        uploadData.url,
                        uploadData.urls?.default,
                        uploadData.url?.default,
                        uploadData.defaultUrl,
                        uploadData.image,
                        uploadData.imageUrl
                    ];
                    
                    console.log('Possible URLs:', possibleUrls);
                    
                    // Lấy URL đầu tiên có giá trị
                    let imageUrl = possibleUrls.find(url => url) || 'https://via.placeholder.com/150';
                    
                    // Nếu URL có đuôi .webp, thay thế bằng .jpeg
                    if (imageUrl.endsWith('.webp')) {
                        imageUrl = imageUrl.replace('.webp', '.jpeg');
                    }
                    
                    console.log('Selected URL:', imageUrl);
                    
                    // Thêm ảnh vào danh sách
                    console.log('sortableImageGrid exists:', !!document.getElementById('sortableImageGrid'));
                    addImageToList(imageUrl);
                    console.log('sortableImageGrid exists:', !!document.getElementById('sortableImageGrid'));
                    // Xóa loading
                    loadingEl.remove();
                    
                    // Hiện thông báo thành công
                    const successEl = document.createElement('div');
                    successEl.className = 'alert alert-success';
                    successEl.innerHTML = 'Tải ảnh thành công!';
                    document.querySelector('#sortableImageGrid').before(successEl);
                    
                    // Xóa thông báo sau 3 giây
                    setTimeout(() => {
                        successEl.remove();
                    }, 3000);
                    
                } catch (error) {
                    console.error('Lỗi khi tải ảnh:', error);
                    
                    // Xóa loading
                    loadingEl.remove();
                    
                    // Hiện thông báo lỗi
                    const errorEl = document.createElement('div');
                    errorEl.className = 'alert alert-danger';
                    errorEl.innerHTML = `Lỗi khi tải ảnh: ${error.message || 'Không thể kết nối đến server'}`;
                    document.querySelector('#sortableImageGrid').before(errorEl);
                    
                    // Tạo bản sao lưu URL tạm thời
                    setTimeout(() => {
                        const fallbackConfirm = confirm('Không thể tải ảnh lên qua API. Bạn có muốn sử dụng URL tạm thởi không? (Lưu ý: ảnh sẽ không được lưu trữ)')
                        if (fallbackConfirm) {
                            const tempUrl = URL.createObjectURL(file);
                            addImageToList(tempUrl);
                        }
                        
                        // Xóa thông báo lỗi
                        errorEl.remove();
                    }, 3000);
                }
            }
        };
        input.click();
    }
    function addImageToList(imageUrl) {
    console.log('Entering addImageToList', imageUrl);
    const tempId = 'new_' + new Date().getTime();
    const template = `...`;
    document.getElementById('sortableImageGrid').insertAdjacentHTML('beforeend', template);
    console.log('Template added');
    // Tạm thời comment updateImageOrder();
    console.log('Leaving addImageToList');
}
    // function addImageToList(imageUrl) {
        
    //     console.log('test', imageUrl);
    //     console.log('addImageToList1',`${imageUrl}`);
    //     console.log('addImageToList2',`${imageUrl}`);
    //     const tempId = 'new_' + new Date().getTime();
    //     const template = `
    //         <div class="image-item" data-id="${tempId}">
    //             <div class="card">
    //                 <img src="${imageUrl}" class="card-img-top image-preview" alt="Product image">
    //                 <div class="card-body p-2">
    //                     <div class="d-flex justify-content-between">
    //                         <div class="form-check">
    //                             <input class="form-check-input main-image-radio" type="radio" 
    //                                 name="mainImageId" value="${tempId}">
    //                             <label class="form-check-label">Ảnh chính</label>
    //                         </div>
    //                         <button type="button" class="btn btn-sm btn-danger" 
    //                                 onclick="removeImage(this)">
    //                             <i class="fas fa-trash"></i>
    //                         </button>
    //                     </div>
    //                     <input type="hidden" name="imageIds[]" value="${tempId}">
    //                     <input type="hidden" name="imageUrls[]" value="${imageUrl}">
    //                 </div>
    //             </div>
    //         </div>
    //     `;
    //     document.getElementById('sortableImageGrid').insertAdjacentHTML('beforeend', template);
    //     updateImageOrder();
    // }

    function removeImage(button) {
        const imageItem = button.closest('.image-item');
        imageItem.remove();
        updateImageOrder();
    }
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
                    formData.append('id', '${product.id}');

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
        alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
        alertDiv.innerHTML = `
            ${message}
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
                        <c:forEach items="${product.colors}" var="color">
                            <option value="${color.id}">${color.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" name="variantAddonIds[]">
                        <option value="">Không có phụ kiện</option>
                        <c:forEach items="${product.addons}" var="addon">
                            <option value="${addon.id}">${addon.name}</option>
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

    function openCKBoxForImage() {
        // Sử dụng input file thường thường để chọn file
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/*';
        input.onchange = async (e) => {
            const file = e.target.files[0];
            if (file) {
                // Hiện thông báo loading
                const loadingEl = document.createElement('div');
                loadingEl.className = 'alert alert-info';
                loadingEl.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang tải ảnh lên CKBox...';
                document.querySelector('#sortableImageGrid').before(loadingEl);
                
                try {
                    // Lấy token API từ CKBox
                    const tokenResponse = await fetch('https://0b3fzh0zey0a.cke-cs.com/token/dev/741526849e2bf96724c0892afe4ffbb7b23cf23733b2a74cc5d845d3af16?limit=10');
                    
                    if (!tokenResponse.ok) throw new Error('Không thể lấy token');
                    
                    // Lấy token dưới dạng text thay vì JSON
                    const authHeader = await tokenResponse.text();
                    
                    // Tạo FormData để tải file
                    const formData = new FormData();
                    formData.append('file', file);
                    formData.append('categoryId', '9ab973c3-9976-405f-8982-25618fb862a7'); // Thay thế ID thư mục của bạn
                    
                    // Cấu hình request
                    const uploadResponse = await fetch('https://api.ckbox.io/assets', {
                        method: 'POST',
                        headers: {
                            'Authorization': authHeader
                        },
                        body: formData
                    });
                    
                    if (!uploadResponse.ok) throw new Error('Tải ảnh thất bại');
                    
                    const uploadData = await uploadResponse.json();
                    console.log('Upload data:', JSON.stringify(uploadData, null, 2));
                    
                    // Thu thập tất cả các cách lấy URL
                    const possibleUrls = [
                        uploadData.imageUrls?.default, // Đặt imageUrls.default làm ưu tiên
                        uploadData.url,
                        uploadData.urls?.default,
                        uploadData.url?.default,
                        uploadData.defaultUrl,
                        uploadData.image,
                        uploadData.imageUrl
                    ];
                    
                    console.log('Possible URLs:', possibleUrls);
                    
                    // Lấy URL đầu tiên có giá trị
                    let imageUrl = possibleUrls.find(url => url) || 'https://via.placeholder.com/150';
                    
                    // Nếu URL có đuôi .webp, thay thế bằng .jpeg
                    if (imageUrl.endsWith('.webp')) {
                        imageUrl = imageUrl.replace('.webp', '.jpeg');
                    }
                    
                    console.log('Selected URL:', imageUrl);
                    
                    // Thêm ảnh vào danh sách
                    addImageToList(imageUrl);
                    
                    // Xóa loading
                    loadingEl.remove();
                    
                    // Hiện thông báo thành công
                    const successEl = document.createElement('div');
                    successEl.className = 'alert alert-success';
                    successEl.innerHTML = 'Tải ảnh thành công!';
                    document.querySelector('#sortableImageGrid').before(successEl);
                    
                    // Xóa thông báo sau 3 giây
                    setTimeout(() => {
                        successEl.remove();
                    }, 3000);
                    
                } catch (error) {
                    console.error('Lỗi khi tải ảnh:', error);
                    
                    // Xóa loading
                    loadingEl.remove();
                    
                    // Hiện thông báo lỗi
                    const errorEl = document.createElement('div');
                    errorEl.className = 'alert alert-danger';
                    errorEl.innerHTML = `Lỗi khi tải ảnh: ${error.message || 'Không thể kết nối đến server'}`;
                    document.querySelector('#sortableImageGrid').before(errorEl);
                    
                    // Tạo bản sao lưu URL tạm thởi
                    setTimeout(() => {
                        const fallbackConfirm = confirm('Không thể tải ảnh lên qua API. Bạn có muốn sử dụng URL tạm thởi không? (Lưu ý: ảnh sẽ không được lưu trữ)')
                        if (fallbackConfirm) {
                            const tempUrl = URL.createObjectURL(file);
                            addImageToList(tempUrl);
                        }
                        
                        // Xóa thông báo lỗi
                        errorEl.remove();
                    }, 3000);
                }
            }
        };
        input.click();
    }

    function addImageToList(imageUrl) {
        const tempId = 'new_' + new Date().getTime();
        const template = `
            <div class="image-item" data-id="${tempId}">
                <div class="card">
                    <img src="${imageUrl}" class="card-img-top image-preview" alt="Product image">
                    <div class="card-body p-2">
                        <div class="d-flex justify-content-between">
                            <div class="form-check">
                                <input class="form-check-input main-image-radio" type="radio" 
                                    name="mainImageId" value="${tempId}">
                                <label class="form-check-label">Ảnh chính</label>
                            </div>
                            <button type="button" class="btn btn-sm btn-danger" 
                                    onclick="removeImage(this)">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                        <input type="hidden" name="imageIds[]" value="${tempId}">
                        <input type="hidden" name="imageUrls[]" value="${imageUrl}">
                    </div>
                </div>
            </div>
        `;
        document.getElementById('sortableImageGrid').insertAdjacentHTML('beforeend', template);
        updateImageOrder();
    }

    function removeImage(button) {
        const imageItem = button.closest('.image-item');
        imageItem.remove();
        updateImageOrder();
    }
</script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var sortableGrid = document.getElementById('sortableImageGrid');
        if (sortableGrid) {
            new Sortable(sortableGrid, {
                animation: 150,
                ghostClass: 'sortable-ghost',
                onSort: updateImageOrder
            });
            // Initialize the order on page load
            updateImageOrder();
        }
    });
    
    function updateImageOrder() {
        const imageItems = document.querySelectorAll('#sortableImageGrid .image-item');
        const orderArray = Array.from(imageItems).map(item => item.dataset.id);
        document.getElementById('imageOrder').value = orderArray.join(',');
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.umd.js"></script>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js"></script>
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css"/>
<link rel="stylesheet" href="https://cdn.ckbox.io/ckbox/2.6.1/styles/themes/lark.css">
<script>
    const {
        ClassicEditor,
        Autoformat,
        BlockQuote,
        Bold,
        CloudServices,
        Essentials,
        Heading,
        Image,
        ImageCaption,
        ImageResize,
        ImageStyle,
        ImageToolbar,
        ImageUpload,
        Base64UploadAdapter,
        Indent,
        IndentBlock,
        Italic,
        Link,
        List,
        MediaEmbed,
        Mention,
        Paragraph,
        PasteFromOffice,
        PictureEditing,
        Table,
        TableColumnResize,
        TableToolbar,
        TextTransformation,
        Underline,
        CKBox,
        CKBoxImageEdit,
        ImageInsertUI,
        FontColor,
        FontBackgroundColor,
        FontSize,
        FontFamily
    } = CKEDITOR;

    ClassicEditor
        .create(document.querySelector('.editor'), {
            licenseKey: 'eyJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3NDU1MzkxOTksImp0aSI6IjRkODNiZGUwLWE5ODQtNDU0NS1hNmNkLTRkMTNmMzUzZDkzMiIsInVzYWdlRW5kcG9pbnQiOiJodHRwczovL3Byb3h5LWV2ZW50LmNrZWRpdG9yLmNvbSIsImRpc3RyaWJ1dGlvbkNoYW5uZWwiOlsiY2xvdWQiLCJkcnVwYWwiLCJzaCJdLCJ3aGl0ZUxhYmVsIjp0cnVlLCJsaWNlbnNlVHlwZSI6InRyaWFsIiwiZmVhdHVyZXMiOlsiKiJdLCJ2YyI6IjE3OWYwNjAyIn0.0HgAOPduVKPRmCPI92FJ4q5pKtHhrYnfAdc39ioLrJBemxSr7XCa6jozWQlkVag2zb_k-OHAu6gmKbvYjVVmPg',

            plugins: [
                Autoformat,
                BlockQuote,
                Bold,
                CloudServices,
                Essentials,
                Heading,
                Image,
                ImageCaption,
                ImageResize,
                ImageStyle,
                ImageToolbar,
                ImageUpload,
                Base64UploadAdapter,
                Indent,
                IndentBlock,
                Italic,
                Link,
                List,
                MediaEmbed,
                Mention,
                Paragraph,
                PasteFromOffice,
                PictureEditing,
                Table,
                TableColumnResize,
                TableToolbar,
                TextTransformation,
                Underline,
                CKBox,
                CKBoxImageEdit,
                ImageInsertUI,
                FontColor,
                FontBackgroundColor,
                FontSize,
                FontFamily
            ],

            toolbar: [
                'undo', 'redo', '|',
                'heading', '|',
                'bold', 'italic', 'underline', '|',
                'fontColor', 'fontBackgroundColor', 'fontSize', 'fontFamily', '|',
                'link', 'uploadImage', 'ckbox', '|',
                'insertTable', 'blockQuote', 'mediaEmbed', '|',
                'bulletedList', 'numberedList', '|',
                'outdent', 'indent'
            ],

            ckbox: {
                tokenUrl: 'https://0b3fzh0zey0a.cke-cs.com/token/dev/741526849e2bf96724c0892afe4ffbb7b23cf23733b2a74cc5d845d3af16?limit=10',
                theme: 'lark'
            },

            image: {
                resizeOptions: [
                    {
                        name: 'resizeImage:original',
                        label: 'Default image width',
                        value: null
                    },
                    {
                        name: 'resizeImage:50',
                        label: '50% page width',
                        value: '50'
                    },
                    {
                        name: 'resizeImage:75',
                        label: '75% page width',
                        value: '75'
                    }
                ],
                toolbar: [
                    'imageTextAlternative',
                    'toggleImageCaption',
                    '|',
                    'imageStyle:inline',
                    'imageStyle:wrapText',
                    'imageStyle:breakText',
                    '|',
                    'resizeImage'
                ]
            },

            link: {
                addTargetToExternalLinks: true,
                defaultProtocol: 'https://'
            },

            table: {
                contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells']
            },

            heading: {
                options: [
                    {model: 'paragraph', title: 'Paragraph', class: 'ck-heading_paragraph'},
                    {model: 'heading1', view: 'h1', title: 'Heading 1', class: 'ck-heading_heading1'},
                    {model: 'heading2', view: 'h2', title: 'Heading 2', class: 'ck-heading_heading2'},
                    {model: 'heading3', view: 'h3', title: 'Heading 3', class: 'ck-heading_heading3'},
                    {model: 'heading4', view: 'h4', title: 'Heading 4', class: 'ck-heading_heading4'}
                ]
            }
        })
        .catch(error => {
            console.error(error);
        });
</script>