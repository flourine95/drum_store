<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Vai trò</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Quản lý Vai trò</h2>

    <c:if test="${param.success != null}">
        <div class="alert alert-success">
            <c:choose>
                <c:when test="${param.success == 'created'}">Vai trò đã được tạo thành công.</c:when>
                <c:when test="${param.success == 'updated'}">Vai trò đã được cập nhật thành công.</c:when>
                <c:when test="${param.success == 'deleted'}">Vai trò đã được xóa thành công.</c:when>
            </c:choose>
        </div>
    </c:if>

    <c:if test="${param.error != null}">
        <div class="alert alert-danger">
            <c:choose>
                <c:when test="${param.error == 'create_failed'}">Không thể tạo vai trò.</c:when>
                <c:when test="${param.error == 'update_failed'}">Không thể cập nhật vai trò.</c:when>
                <c:when test="${param.error == 'delete_failed'}">Không thể xóa vai trò.</c:when>
            </c:choose>
        </div>
    </c:if>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/dashboard/roles?action=create" class="btn btn-primary">Thêm Vai trò mới</a>
    </div>

    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="role" items="${roles}">
            <tr>
                <td>${role.id}</td>
                <td>${role.name}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/dashboard/roles?action=edit&id=${role.id}"
                       class="btn btn-sm btn-primary">Sửa</a>
                    <button onclick="deleteRole(${role.id})" class="btn btn-sm btn-danger">Xóa</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<form id="deleteForm" method="POST" style="display: none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" name="id" id="deleteId">
</form>

<script>
    function deleteRole(id) {
        if (confirm('Bạn có chắc chắn muốn xóa vai trò này?')) {
            document.getElementById('deleteId').value = id;
            document.getElementById('deleteForm').submit();
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>