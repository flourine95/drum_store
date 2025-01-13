<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form id="productForm" action="${pageContext.request.contextPath}/dashboard/products/${product.id}" method="POST">
    <input type="hidden" name="_method" value="PUT">
    <input type="hidden" name="csrf_token" value="${csrfToken}">
    <input type="hidden" name="id" value="${product.id}">
    <section class="row mb-3">
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Tên sản phẩm:</label>
                    <input type="text" id="name" name="name" value="${product.name}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Chi tiết sản phẩm:</label>
                    <textarea class="form-control" rows="5" id="description" name="description">${product.description}</textarea>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="text" id="price" name="price" value="${product.price}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Còn trong kho:</label>
                    <input type="text" id="stock" name="stock" value="${product.stock}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Số lượt xem:</label>
                    <input type="text" id="total-view" name="totalViews" value="${product.totalViews}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Sản phẩm nổi bật:</label>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="isFeaturedToggle"
                               name="status" value="1" ${product.isFeatured == true ? 'checked' : ''}>
                        <label class="form-check-label" for="statusToggle">
                            ${product.isFeatured == true ? 'Có' : 'Không'}
                        </label>
                    </div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Trạng thái:</label>
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" id="statusToggle"
                               name="status" value="1" ${product.status == 1 ? 'checked' : ''}>
                        <label class="form-check-label" for="statusToggle">
                            ${product.status == 1 ? 'Hoạt động' : 'Bị cấm'}
                        </label>
                    </div>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Trung bình đánh giá:</label>
                    <input type="text" id="averageRating" name="averageRating" value="${product.averageRating}" class="form-control" readonly>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Slug:</label>
                    <input type="text" value="${product.slug}" class="form-control" name="slug" id="slug">
                </div>

            </div>
        </div>
    </section>

    <section class="row mb-4">
        <div class="col-12">
            <h5>Danh sách hình ảnh</h5>
            <table id="imageTable" class="table table-bordered">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Ảnh</th>
                    <th>Mặc định</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="productImage" items="${product.images}">
                    <tr>
                        <td>${productImage.id}</td>
                        <td><img class="product-image" src="${productImage.image}" alt="${productImage.image}"></td>
                        <td>
                            <div class="form-check form-switch">
                                <input class="form-check-input isDefaultToggle"
                                       type="checkbox"
                                       id="defaultToggle${productImage.id}"
                                       name="productImages[${productImage.id}].isDefault"
                                       value="true" ${productImage.isMain ? 'checked' : ''}>
                                <label class="form-check-label" for="defaultToggle${productImage.id}">
                                        ${productImage.isMain ? 'Có' : 'Không'}
                                </label>
                            </div>
                        </td>
                        <td>
                            <div class="btn-group">
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productImage/${productImage.id}"
                                      method="GET">
                                    <button type="submit" class="btn btn-info">Xem</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productImage/${productImage.id}/edit"
                                      method="GET">
                                    <button type="submit" class="btn btn-warning">Chỉnh sửa</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productImage/${productImage.id}"
                                      method="POST"
                                      onsubmit="return confirm('Bạn có chắc muốn xóa ảnh này không?');">
                                    <input type="hidden" name="productImageId" value="${productImage.id}">
                                    <button type="submit" class="btn btn-danger">Xóa</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <section class="row mb-4">
        <div class="col-12">
            <h5>Danh sách màu</h5>
            <table id="colorTable" class="table table-bordered">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Mã màu</th>
                    <th>Tên màu</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="productColor" items="${product.colors}">
                    <tr>
                        <td>${productColor.id}</td>
                        <td><p class="color-code">${productColor.colorCode}</p></td>
                        <td>${productColor.colorName}</td>
                        <td>
                            <div class="btn-group">
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productColor/${productColor.id}"
                                      method="GET">
                                    <button type="submit" class="btn btn-info">Xem</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productColor/${productColor.id}/edit"
                                      method="GET">
                                    <button type="submit" class="btn btn-warning">Chỉnh sửa</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/productColor/${productColor.id}"
                                      method="POST"
                                      onsubmit="return confirm('Bạn có chắc muốn xóa màu này không?');">
                                    <input type="hidden" name="productColorId" value="${productColor.id}">
                                    <button type="submit" class="btn btn-danger">Xóa</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <div class="form-actions">
        <button type="submit" class="btn btn-success">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-secondary">Quay lại</a>
    </div>
</form>

<style>
    .product-image {
        width: 400px;
        height: 400px;
        object-fit: cover;
        justify-content: center;
    }

    .color-code {
        font-weight: bold;
        /*mix-blend-mode: difference;*/
    }

    .form-actions {
        margin-top: 20px;
    }

    .btn-group {
        gap: 5px;
    }
</style>
<script>
    $(document).ready(function () {
        $('#imageTable').DataTable({
            responsive: true, // Bảng responsive
            paging: true,      // Bật phân trang
            searching: true,   // Bật tìm kiếm
            ordering: true,    // Cho phép sắp xếp
            lengthMenu: [5, 10, 20, 100], // Tùy chọn số hàng hiển thị
            columnDefs: [
                {orderable: false, targets: [3]} // Vô hiệu hóa sắp xếp cho cột Thao tác
            ]
        });
    });
</script>