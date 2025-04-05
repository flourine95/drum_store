<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Vai trò mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Thêm Vai trò mới</h2>

    <form method="POST" action="${pageContext.request.contextPath}/dashboard/roles">
        <input type="hidden" name="action" value="store">

        <div class="mb-3">
            <label for="name" class="form-label">Tên vai trò</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="${pageContext.request.contextPath}/dashboard/roles" class="btn btn-secondary">Hủy</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>