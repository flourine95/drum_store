<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Quyền</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Sửa Quyền</h2>

    <form method="POST" action="${pageContext.request.contextPath}/dashboard/permissions">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${permission.id}">

        <div class="mb-3">
            <label for="name" class="form-label">Tên quyền</label>
            <input type="text" class="form-control" id="name" name="name" value="${permission.name}" required>
            <small class="form-text text-muted">Ví dụ: users:create, products:edit</small>
        </div>

        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/dashboard/permissions" class="btn btn-secondary">Hủy</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>