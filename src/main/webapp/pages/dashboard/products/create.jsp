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
                    <form action="${pageContext.request.contextPath}/dashboard/products" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="store">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="productName">Tên sản phẩm <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="productName" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="basePrice">Giá cơ bản <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="basePrice" name="basePrice" step="1000" required>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="categoryId">Danh mục <span class="text-danger">*</span></label>
                                    <select class="form-control" id="categoryId" name="categoryId" required>
                                        <option value="">Chọn danh mục</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="brandId">Thương hiệu <span class="text-danger">*</span></label>
                                    <select class="form-control" id="brandId" name="brandId" required>
                                        <option value="">Chọn thương hiệu</option>
                                        <c:forEach items="${brands}" var="brand">
                                            <option value="${brand.id}">${brand.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label for="description">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="4"></textarea>
                        </div>

                        <!-- Quản lý tồn kho -->
                        <div class="form-group mb-3">
                            <label for="stockManagementType">Kiểu quản lý tồn kho <span class="text-danger">*</span></label>
                            <select class="form-control" id="stockManagementType" name="stockManagementType" required>
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

                        <!-- Stock cho simple type -->
                        <div id="simpleStockSection" class="mb-3">
                            <div class="form-group">
                                <label for="stock">Số lượng tồn kho <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="stock" name="stock" min="0" value="0">
                            </div>
                        </div>

                        <!-- Upload hình ảnh -->
                        <div class="form-group mb-3">
                            <label for="images">Hình ảnh sản phẩm</label>
                            <div class="custom-file mb-2">
                                <input type="file" class="custom-file-input" id="images" name="images" multiple accept="image/*">
                                <label class="custom-file-label" for="images">Chọn hình ảnh</label>
                            </div>
                            <small class="form-text text-muted mb-2">Có thể chọn nhiều hình ảnh. Kéo thả để sắp xếp thứ tự.</small>
                            
                            <!-- Thêm select box để chọn ảnh chính -->
                            <div class="form-group mt-2">
                                <label for="mainImage">Ảnh chính</label>
                                <select class="form-control" id="mainImage" name="mainImageId" required>
                                    <option value="">Chọn ảnh chính</option>
                                </select>
                                <small class="form-text text-muted">Ảnh chính sẽ được hiển thị đầu tiên trong trang sản phẩm</small>
                            </div>
                            
                            <div id="imagePreviewContainer" class="d-flex flex-wrap gap-2 border rounded p-2" style="min-height: 100px;">
                                <!-- Ảnh sẽ được hiển thị ở đây -->
                            </div>
                        </div>

                        <!-- Quản lý màu sắc -->
                        <div id="colorSection" class="mb-3" style="display: none;">
                            <h5>Màu sắc</h5>
                            <div id="colorContainer">
                                <div class="row mb-2">
                                    <div class="col-md-3">
                                        <label for="colorName0">Tên màu</label>
                                        <input type="text" class="form-control" id="colorName0" name="colors[0].name" placeholder="Tên màu">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="colorPrice0">Giá thêm</label>
                                        <input type="number" class="form-control" id="colorPrice0" name="colors[0].additionalPrice" placeholder="Giá thêm" step="1000">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="colorStock0">Tồn kho</label>
                                        <input type="number" class="form-control" id="colorStock0" name="colors[0].stock" placeholder="Số lượng" min="0">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="colorImage0">Ảnh màu</label>
                                        <select class="form-control" id="colorImage0" name="colors[0].imageId">
                                            <option value="">Chọn ảnh</option>
                                        </select>
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
                                    <div class="col-md-3">
                                        <label for="addonName0">Tên phụ kiện</label>
                                        <input type="text" class="form-control" id="addonName0" name="addons[0].name" placeholder="Tên phụ kiện">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="addonPrice0">Giá thêm</label>
                                        <input type="number" class="form-control" id="addonPrice0" name="addons[0].additionalPrice" placeholder="Giá thêm" step="1000">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="addonStock0">Tồn kho</label>
                                        <input type="number" class="form-control" id="addonStock0" name="addons[0].stock" placeholder="Số lượng" min="0">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="addonImage0">Ảnh phụ kiện</label>
                                        <select class="form-control" id="addonImage0" name="addons[0].imageId">
                                            <option value="">Chọn ảnh</option>
                                        </select>
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
                        </div>

                        <button type="submit" class="btn btn-primary">Tạo sản phẩm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal xem ảnh -->
<div class="modal fade" id="imagePreviewModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xem ảnh</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Preview" style="max-width: 100%; max-height: 80vh;">
            </div>
        </div>
    </div>
</div>

<script>
    // Xử lý hiển thị section màu sắc và phụ kiện
    document.getElementById('stockManagementType').addEventListener('change', function() {
        const colorSection = document.getElementById('colorSection');
        const addonSection = document.getElementById('addonSection');
        const simpleStockSection = document.getElementById('simpleStockSection');
        
        switch(this.value) {
            case '0': // Simple
                colorSection.style.display = 'none';
                addonSection.style.display = 'none';
                simpleStockSection.style.display = 'block';
                break;
            case '1': // Color Only
                colorSection.style.display = 'block';
                addonSection.style.display = 'none';
                simpleStockSection.style.display = 'none';
                break;
            case '2': // Addon Only
                colorSection.style.display = 'none';
                addonSection.style.display = 'block';
                simpleStockSection.style.display = 'none';
                break;
            case '3': // Color and Addon
                colorSection.style.display = 'block';
                addonSection.style.display = 'block';
                simpleStockSection.style.display = 'none';
                break;
        }
    });

    // Trigger change event on page load to set initial state
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('stockManagementType').dispatchEvent(new Event('change'));
    });

    let colorCount = 1;
    function addColor() {
        const container = document.getElementById('colorContainer');
        const div = document.createElement('div');
        div.className = 'row mb-2';
        div.innerHTML = `
            <div class="col-md-3">
                <label for="colorName\${colorCount}">Tên màu</label>
                <input type="text" class="form-control" id="colorName\${colorCount}" name="colors[\${colorCount}].name" placeholder="Tên màu">
            </div>
            <div class="col-md-2">
                <label for="colorPrice\${colorCount}">Giá thêm</label>
                <input type="number" class="form-control" id="colorPrice\${colorCount}" name="colors[\${colorCount}].additionalPrice" placeholder="Giá thêm" step="1000">
            </div>
            <div class="col-md-2">
                <label for="colorStock\${colorCount}">Tồn kho</label>
                <input type="number" class="form-control" id="colorStock\${colorCount}" name="colors[\${colorCount}].stock" placeholder="Số lượng" min="0">
            </div>
            <div class="col-md-3">
                <label for="colorImage\${colorCount}">Ảnh màu</label>
                <select class="form-control" id="colorImage\${colorCount}" name="colors[\${colorCount}].imageId">
                    <option value="">Chọn ảnh</option>
                </select>
            </div>
            <div class="col-md-2">
                <label>&nbsp;</label>
                <button type="button" class="btn btn-danger btn-sm d-block" onclick="this.closest('.row').remove()">Xóa</button>
            </div>
        `;
        container.appendChild(div);
        updateImageOptions();
        colorCount++;
    }

    let addonCount = 1;
    function addAddon() {
        const container = document.getElementById('addonContainer');
        const div = document.createElement('div');
        div.className = 'row mb-2';
        div.innerHTML = `
            <div class="col-md-3">
                <label for="addonName\${addonCount}">Tên phụ kiện</label>
                <input type="text" class="form-control" id="addonName\${addonCount}" name="addons[\${addonCount}].name" placeholder="Tên phụ kiện">
            </div>
            <div class="col-md-2">
                <label for="addonPrice\${addonCount}">Giá thêm</label>
                <input type="number" class="form-control" id="addonPrice\${addonCount}" name="addons[\${addonCount}].additionalPrice" placeholder="Giá thêm" step="1000">
            </div>
            <div class="col-md-2">
                <label for="addonStock\${addonCount}">Tồn kho</label>
                <input type="number" class="form-control" id="addonStock\${addonCount}" name="addons[\${addonCount}].stock" placeholder="Số lượng" min="0">
            </div>
            <div class="col-md-3">
                <label for="addonImage\${addonCount}">Ảnh phụ kiện</label>
                <select class="form-control" id="addonImage\${addonCount}" name="addons[\${addonCount}].imageId">
                    <option value="">Chọn ảnh</option>
                </select>
            </div>
            <div class="col-md-2">
                <label>&nbsp;</label>
                <button type="button" class="btn btn-danger btn-sm d-block" onclick="this.closest('.row').remove()">Xóa</button>
            </div>
        `;
        container.appendChild(div);
        updateImageOptions();
        addonCount++;
    }

    // Xử lý preview và sắp xếp ảnh
    let uploadedImages = [];
    
    // Hàm tạo ảnh preview với khả năng click để xem
    function createImagePreview(src, imageId) {
        const img = document.createElement('img');
        img.src = src;
        img.className = 'img-thumbnail';
        img.style.width = '100px';
        img.style.height = '100px';
        img.style.objectFit = 'cover';
        img.style.cursor = 'pointer';
        img.onclick = function() {
            showImagePreview(src);
        };
        return img;
    }

    // Hàm hiển thị modal xem ảnh
    function showImagePreview(src) {
        const modalImage = document.getElementById('modalImage');
        modalImage.src = src;
        $('#imagePreviewModal').modal('show');
    }

    // Cập nhật lại đoạn code xử lý tạo preview ảnh
    document.getElementById('images').addEventListener('change', function(e) {
        const files = Array.from(e.target.files);
        const container = document.getElementById('imagePreviewContainer');
        
        files.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const imageId = 'img_' + Date.now() + '_' + index;
                const div = document.createElement('div');
                div.className = 'position-relative mr-2 mb-2';
                
                // Tạo phần tử img với khả năng click
                const img = createImagePreview(e.target.result, imageId);
                
                // Tạo input hidden
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'imageOrder[]';
                input.value = imageId;
                
                // Tạo nút xóa
                const button = document.createElement('button');
                button.type = 'button';
                button.className = 'btn btn-danger btn-sm position-absolute';
                button.style.top = '0';
                button.style.right = '0';
                button.innerHTML = '×';
                button.onclick = function() {
                    removeImage(imageId);
                    this.parentElement.remove();
                };
                
                // Thêm các phần tử vào div container
                div.appendChild(img);
                div.appendChild(input);
                div.appendChild(button);
                container.appendChild(div);
                
                // Thêm ảnh vào danh sách để select
                uploadedImages.push({
                    id: imageId,
                    src: e.target.result
                });
                
                updateImageCount();
                updateImageOptions();
            };
            reader.readAsDataURL(file);
        });
    });

    function updateImageCount() {
        const imageCount = uploadedImages.length;
        const label = document.querySelector('.custom-file-label');
        label.textContent = imageCount > 0 ? imageCount + ' ảnh đã chọn' : 'Chọn hình ảnh';
    }

    // Thêm xử lý xem ảnh cho các select
    function updateImageOptions() {
        // Cập nhật select box ảnh chính
        const mainImageSelect = document.getElementById('mainImage');
        const currentMainValue = mainImageSelect.value;
        mainImageSelect.innerHTML = '<option value="">Chọn ảnh chính</option>';
        uploadedImages.forEach((img, index) => {
            const option = document.createElement('option');
            option.value = img.id;
            option.text = 'Ảnh ' + (index + 1);
            option.dataset.preview = img.src;
            mainImageSelect.add(option);
        });
        if (uploadedImages.find(img => img.id === currentMainValue)) {
            mainImageSelect.value = currentMainValue;
        } else if (uploadedImages.length > 0) {
            // Tự động chọn ảnh đầu tiên làm ảnh chính nếu chưa có ảnh nào được chọn
            mainImageSelect.value = uploadedImages[0].id;
        }

        // Thêm sự kiện double click để xem ảnh cho select box ảnh chính
        mainImageSelect.ondblclick = function() {
            const selectedOption = this.options[this.selectedIndex];
            if (selectedOption.dataset.preview) {
                showImagePreview(selectedOption.dataset.preview);
            }
        };

        // Cập nhật các select box khác cho màu sắc và phụ kiện
        const selects = document.querySelectorAll('select[name$=".imageId"]');
        selects.forEach(select => {
            const currentValue = select.value;
            select.innerHTML = '<option value="">Chọn ảnh</option>';
            uploadedImages.forEach((img, index) => {
                const option = document.createElement('option');
                option.value = img.id;
                option.text = 'Ảnh ' + (index + 1);
                option.dataset.preview = img.src;
                select.add(option);
            });
            if (uploadedImages.find(img => img.id === currentValue)) {
                select.value = currentValue;
            }

            select.ondblclick = function() {
                const selectedOption = this.options[this.selectedIndex];
                if (selectedOption.dataset.preview) {
                    showImagePreview(selectedOption.dataset.preview);
                }
            };
        });
    }

    function removeImage(imageId) {
        // Xóa ảnh khỏi mảng uploadedImages
        uploadedImages = uploadedImages.filter(img => img.id !== imageId);
        
        // Kiểm tra nếu ảnh bị xóa là ảnh chính
        const mainImageSelect = document.getElementById('mainImage');
        if (mainImageSelect.value === imageId) {
            mainImageSelect.value = uploadedImages.length > 0 ? uploadedImages[0].id : '';
        }
        
        // Cập nhật số lượng ảnh hiển thị
        updateImageCount();
        // Cập nhật các option trong select
        updateImageOptions();
    }

    // Khởi tạo Sortable cho container ảnh
    new Sortable(document.getElementById('imagePreviewContainer'), {
        animation: 150,
        onEnd: function() {
            updateImageOrder();
            updateImageOptions();
        }
    });

    // Cập nhật thứ tự ảnh
    function updateImageOrder() {
        const images = document.querySelectorAll('#imagePreviewContainer input[name="imageOrder[]"]');
        const newOrder = [];
        images.forEach((input, index) => {
            const imageId = input.value;
            const image = uploadedImages.find(img => img.id === imageId);
            if (image) {
                newOrder.push(image);
            }
        });
        uploadedImages = newOrder;
    }
</script>

<style>
    #imagePreviewContainer img {
        transition: transform 0.2s;
    }
    
    #imagePreviewContainer img:hover {
        transform: scale(1.05);
    }
    
    .modal-body {
        padding: 0;
        background-color: #000;
    }
    
    #modalImage {
        display: block;
        margin: auto;
        max-height: 80vh;
        object-fit: contain;
    }
    
    select[name$=".imageId"] {
        cursor: pointer;
    }
</style>
