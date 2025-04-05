<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Quản lý Quyền</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h2>Quản lý Quyền</h2>

  <c:if test="${param.success != null}">
    <div class="alert alert-success">
      <c:choose>
        <c:when test="${param.success == 'created'}">Quyền đã được tạo thành công.</c:when>
        <c:when test="${param.success == 'updated'}">Quyền đã được cập nhật thành công.</c:when>
        <c:when test="${param.success == 'deleted'}">Quyền đã được xóa thành công.</c:when>
      </c:choose>
    </div>
  </c:if>

  <c:if test="${param.error != null}">
    <div class="alert alert-danger">
      <c:choose>
        <c:when test="${param.error == 'create_failed'}">Không thể tạo quyền.</c:when>
        <c:when test="${param.error == 'update_failed'}">Không thể cập nhật quyền.</c:when>
        <c:when test="${param.error == 'delete_failed'}">Không thể xóa quyền.</c:when>
      </c:choose>
    </div>
  </c:if>

  <div class="mb-3">
    <a href="${pageContext.request.contextPath}/dashboard/permissions?action=create" class="btn btn-primary">Thêm Quyền mới</a>
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
    <c:forEach var="permission" items="${permissions}">
      <tr>
        <td>${permission.id}</td>
        <td>${permission.name}</td>
        <td>
          <a href="${pageContext.request.contextPath}/dashboard/permissions?action=edit&id=${permission.id}"
             class="btn btn-sm btn-primary">Sửa</a>
          <button onclick="deletePermission(${permission.id})" class="btn btn-sm btn-danger">Xóa</button>
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
  function deletePermission(id) {
    if (confirm('Bạn có chắc chắn muốn xóa quyền này?')) {
      document.getElementById('deleteId').value = id;
      document.getElementById('deleteForm').submit();
    }
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>