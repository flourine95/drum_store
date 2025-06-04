<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid px-4 py-4">
    <!-- Breadcrumb and Page Title -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-0 fw-bold">Tạo sản phẩm mới</h2>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none"><i class="bi bi-house-door"></i> Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/products" class="text-decoration-none">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Tạo mới</li>
                </ol>
            </nav>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Quay lại
            </a>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger d-flex align-items-center" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <div>${error}</div>
        </div>
    </c:if>

    <!-- Main Form -->
    <form action="${pageContext.request.contextPath}/dashboard/products" method="post" id="productForm" class="needs-validation" novalidate>
        <input type="hidden" name="action" value="store">

        <div class="row g-4">
            <!-- Left Column - Main Product Info -->
            <div class="col-lg-8">
                <!-- Basic Information -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-info-circle text-primary me-2"></i>
                            <h5 class="mb-0">Thông tin cơ bản</h5>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-4">
                            <label for="productName" class="form-label fw-medium">Tên sản phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" id="productName" name="name" placeholder="Nhập tên sản phẩm" required>
                            <div class="invalid-feedback">Vui lòng nhập tên sản phẩm</div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label for="categoryId" class="form-label fw-medium">Danh mục <span class="text-danger">*</span></label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <option value="" selected disabled>Chọn danh mục</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn danh mục</div>
                            </div>
                            <div class="col-md-6">
                                <label for="brandId" class="form-label fw-medium">Thương hiệu <span class="text-danger">*</span></label>
                                <select class="form-select" id="brandId" name="brandId" required>
                                    <option value="" selected disabled>Chọn thương hiệu</option>
                                    <c:forEach items="${brands}" var="brand">
                                        <option value="${brand.id}">${brand.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn thương hiệu</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="editor" class="form-label fw-medium">Mô tả sản phẩm</label>
                            <textarea id="editor" name="description" class="form-control"></textarea>
                            <div class="form-text">Mô tả chi tiết về sản phẩm, tính năng và đặc điểm nổi bật</div>
                        </div>
                    </div>
                </div>

                <!-- Stock Management -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-box-seam text-success me-2"></i>
                            <h5 class="mb-0">Quản lý tồn kho</h5>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-4">
                            <label for="stockManagementType" class="form-label fw-medium">Kiểu quản lý tồn kho <span class="text-danger">*</span></label>
                            <select class="form-select" id="stockManagementType" name="stockManagementType" required>
                                <c:forEach items="${stockManagementTypes}" var="type">
                                    <option value="${type.value}">
                                        <c:choose>
                                            <c:when test="${type.value == 0}">Đơn giản (không có biến thể)</c:when>
                                            <c:when test="${type.value == 1}">Chỉ màu sắc</c:when>
                                            <c:when test="${type.value == 2}">Chỉ phụ kiện</c:when>
                                            <c:when test="${type.value == 3}">Màu sắc và phụ kiện</c:when>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="form-text"><i class="bi bi-info-circle me-1"></i> Bạn sẽ có thể thêm biến thể sau khi tạo sản phẩm</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column - Price & Settings -->
            <div class="col-lg-4">
                <!-- Pricing Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-currency-dollar text-danger me-2"></i>
                            <h5 class="mb-0">Giá & Khuyến mãi</h5>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="mb-4">
                            <label for="basePrice" class="form-label fw-medium">Giá cơ bản <span class="text-danger">*</span></label>
                            <div class="input-group input-group-lg">
                                <input type="number" class="form-control" id="basePrice" name="basePrice" step="1000" min="0" placeholder="0" required>
                                <span class="input-group-text">VNĐ</span>
                                <div class="invalid-feedback">Vui lòng nhập giá hợp lệ</div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="discountPercent" class="form-label fw-medium">Giảm giá (%)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="discountPercent" name="discountPercent" min="0" max="100" value="0">
                                <span class="input-group-text">%</span>
                            </div>
                            <div id="discountedPrice" class="form-text mt-2">Giá sau giảm: <span class="fw-bold text-danger">0 VNĐ</span></div>
                        </div>
                    </div>
                </div>

                <!-- Settings Card -->
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-gear text-secondary me-2"></i>
                            <h5 class="mb-0">Cài đặt</h5>
                        </div>
                    </div>
                    <div class="card-body p-4">
                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" role="switch" id="isFeatured" name="isFeatured">
                            <label class="form-check-label" for="isFeatured">Sản phẩm nổi bật</label>
                            <div class="form-text">Hiển thị sản phẩm trong mục "Sản phẩm nổi bật" trên trang chủ</div>
                        </div>

                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" role="switch" id="isActive" name="isActive" checked>
                            <label class="form-check-label" for="isActive">Hiển thị sản phẩm</label>
                            <div class="form-text">Cho phép sản phẩm hiển thị trên website</div>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="bi bi-check-circle me-2"></i>Tạo sản phẩm
                    </button>
                </div>
            </div>
        </div>
    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.umd.js"></script>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js"></script>
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css"/>
<link rel="stylesheet" href="https://cdn.ckbox.io/ckbox/2.6.1/styles/themes/lark.css">
<script>
    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        // Enable Bootstrap validation
        const form = document.getElementById('productForm');
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
        
        // Calculate discounted price
        const basePrice = document.getElementById('basePrice');
        const discountPercent = document.getElementById('discountPercent');
        const discountedPriceEl = document.getElementById('discountedPrice');
        
        function updateDiscountedPrice() {
            const price = parseFloat(basePrice.value) || 0;
            const discount = parseFloat(discountPercent.value) || 0;
            const discountedPrice = price - (price * discount / 100);
            
            // Format as currency
            const formatter = new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND',
                maximumFractionDigits: 0
            });
            
            discountedPriceEl.innerHTML = 'Giá sau giảm: <span class="fw-bold text-danger">' + 
                (price > 0 ? formatter.format(discountedPrice) : '0 VNĐ') + '</span>';
        }
        
        basePrice.addEventListener('input', updateDiscountedPrice);
        discountPercent.addEventListener('input', updateDiscountedPrice);
    });

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

    async function initEditor() {
        try {
            const [licenseKey, ckboxToken] = await Promise.all([
                fetch('/api/keys?service=ckeditor').then(res => res.text()),
                fetch('/api/keys?service=ckbox-dev').then(res => res.text())
            ]);

            await ClassicEditor.create(document.querySelector('#editor'), {
                licenseKey: licenseKey.trim(),

                plugins: [
                    Autoformat, BlockQuote, Bold, CloudServices, Essentials, Heading,
                    Image, ImageCaption, ImageResize, ImageStyle, ImageToolbar, ImageUpload,
                    Base64UploadAdapter, Indent, IndentBlock, Italic, Link, List, MediaEmbed,
                    Mention, Paragraph, PasteFromOffice, PictureEditing, Table, TableColumnResize,
                    TableToolbar, TextTransformation, Underline, CKBox, CKBoxImageEdit,
                    ImageInsertUI, FontColor, FontBackgroundColor, FontSize, FontFamily
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
                    tokenUrl: ckboxToken.trim(),
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
            });

        } catch (error) {
            console.error('Error initializing editor:', error);
        }
    }

    initEditor();
</script>



