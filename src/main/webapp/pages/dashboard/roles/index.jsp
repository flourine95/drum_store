<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container mt-4">
    <h2>Quản lý Vai trò</h2>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
                ${success}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>
    <c:if test="${not empty errors.general}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i>
                ${errors.general}
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
                <td>${role.description}</td>
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
