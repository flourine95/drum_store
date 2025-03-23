<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="/WEB-INF/security" %>

<div class="product-management">
    <h1>Quản lý sản phẩm</h1>

    <sec:hasPermission permission="product:create">
        <a href="${pageContext.request.contextPath}/admin/products/create" class="btn btn-primary">
            Thêm sản phẩm mới
        </a>
    </sec:hasPermission>

    <table class="table">
        <thead>
            <tr>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${products}" var="product">
                <tr>
                    <td>${product.name}</td>
                    <td>${product.price}</td>
                    <td>
                        <sec:hasPermission permission="product:update">
                            <a href="${pageContext.request.contextPath}/admin/products/edit/${product.id}"
                               class="btn btn-warning">Sửa</a>
                        </sec:hasPermission>

                        <sec:hasPermission permission="product:delete">
                            <a href="${pageContext.request.contextPath}/admin/products/delete/${product.id}"
                               class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </sec:hasPermission>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>