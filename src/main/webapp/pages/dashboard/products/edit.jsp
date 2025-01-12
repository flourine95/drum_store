<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<form id="productForm" action="${pageContext.request.contextPath}/dashboard/products?action=update" method="POST">
    <input type="hidden" name="id" value="${product.id}">
    <section class="row mb-3">
        <div class="col-md-4">
            <img src="${product.image}"
                 alt="Avatar"
                 class="img-fluid rounded-circle user-avatar">
        </div>

        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Tên sản phẩm:</label>
                    <input type="text" name="name" value="${product.name}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Chi tiết sản phẩm:</label>
                    <input type="text" name="description" value="${product.description}" class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="number" id="price" name="price" ${product.price} class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Còn trong kho:</label>
                    <input type="number" id="stock" name="stock" ${product.stock} class="form-control">
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Số lượt xem:</label>
                    <input type="number" id="total-view" name="total-view" ${product.totalView} class="form-control">
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
                    <th>Đường dẫn</th>
                    <th>Mặc định</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="image" items="${product.productImages}">
                    <tr>
                        <td>${image.id}</td>
                        <td>${image.image}</td>
                        <td>
                            <div class="form-check form-switch">
                                <input class="form-check-input isDefaultToggle"
                                       type="checkbox"
                                       id="defaultToggle${address.id}"
                                       name="addresses[${address.id}].isDefault"
                                       value="1" ${address.isDefault ? 'checked' : ''} disabled>
                                <label class="form-check-label" for="defaultToggle${address.id}">
                                        ${image.isMain ? 'Có' : 'Không'}
                                </label>
                            </div>
                        </td>
                        <td>
                            <div class="btn-group">
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/addresses/${address.id}"
                                      method="GET">
                                    <button type="submit" class="btn btn-info">Xem</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/addresses/${address.id}/edit"
                                      method="GET">
                                    <button type="submit" class="btn btn-warning">Chỉnh sửa</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/addresses/${address.id}"
                                      method="POST"
                                      onsubmit="return confirm('Bạn có chắc muốn xóa ảnh này không?');">
                                    <input type="hidden" name="imageId" value="${image.id}">
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
    .user-avatar {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 50%;
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
                {orderable: false, targets: [4]} // Vô hiệu hóa sắp xếp cho cột Thao tác
            ]
        });
    });
</script>