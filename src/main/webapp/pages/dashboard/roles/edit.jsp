<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Sửa Vai trò</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
  <h2>Sửa Vai trò</h2>

  <form method="POST" action="${pageContext.request.contextPath}/dashboard/roles">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${role.id}">

    <div class="mb-3">
      <label for="name" class="form-label">Tên vai trò</label>
      <input type="text" class="form-control" id="name" name="name" value="${role.name}" required>
    </div>

    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
    <a href="${pageContext.request.contextPath}/dashboard/roles" class="btn btn-secondary">Hủy</a>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>