<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<section id="productForm">
    <input type="hidden" name="id" value="${product.id}">
    <section class="row mb-3">
        <div class="col-md-4">
            <img src="${empty product.image ? '/images/default-avatar.jpg' : product.image}"
                 alt="Avatar"
                 class="img-fluid rounded-circle product-avatar">
        </div>

        <div class="col-md-8">
            <div class="row">
                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Tên:</label>
                    <input type="text" value="${product.name}" class="form-control" readonly>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Chi tiết:</label>
                    <input type="email" value="${product.description}" class="form-control" readonly>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Giá:</label>
                    <input type="text" value="${product.price}" class="form-control" readonly>
                </div>

                <div class="col-md-6 mb-2">
                    <label class="form-label fw-bold">Trạng thái:</label>
                    <input type="text" value="${product.status == 1 ? 'Hoạt động' : 'Bị cấm'}" class="form-control" readonly>
                </div>
            </div>
        </div>
    </section>

    <section class="row mb-4">
        <div class="col-12">
            <h5>Danh sách hình ảnh</h5>
            <table id="addressTable" class="table table-bordered">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Đường dẫn</th>
                    <th>Mặc định</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="address" items="${product.productImages}">
                    <tr>
                        <td>${productImages.image}</td>
                        <td>${productImages.isMain ? 'Có' : 'Không'}</td>
                        <td>
                            <div class="btn-group">
                                <form action="${pageContext.request.contextPath}/dashboard/products/${product.id}/addresses/${productImages.id}" method="GET">
                                    <button type="submit" class="btn btn-info">Xem</button>
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
        <a href="${pageContext.request.contextPath}/dashboard/products" class="btn btn-secondary">Quay lại</a>
    </div>
</section>

<style>
    .product-avatar {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 50%;
    }

    .form-actions {
        margin-top: 20px;
    }
</style>
<script>
    $(document).ready(function () {
        $('#imageTable').DataTable({
            responsive: true, // Bảng responsive
            paging: true,      // Bật phân trang
            searching: true,   // Bật tìm kiếm
            ordering: true,    // Cho phép sắp xếp
            lengthMenu: [5, 10, 20, 100] // Tùy chọn số hàng hiển thị
        });

        $('#colorTable').DataTable({
            responsive: true, // Bảng responsive
            paging: true,      // Bật phân trang
            searching: true,   // Bật tìm kiếm
            ordering: true,    // Cho phép sắp xếp
            lengthMenu: [5, 10, 20, 100] // Tùy chọn số hàng hiển thị
        });
    });
</script>

