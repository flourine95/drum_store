<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>
<h1>Edit Product</h1>
<form method="post" action="${pageContext.request.contextPath}/products?action=edit">
    <input type="hidden" name="id" value="${product.id}" />
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="${product.name}" required /><br>

    <label for="description">Description:</label>
    <textarea id="description" name="description" required>${product.description}</textarea><br>

    <label for="price">Price:</label>
    <input type="number" step="0.01" id="price" name="price" value="${product.price}" required /><br>

    <label for="stock">Stock:</label>
    <input type="number" id="stock" name="stock" value="${product.stock}" required /><br>

    <button type="submit">Update</button>
</form>
<a href="${pageContext.request.contextPath}/products">Back to Product List</a>
</body>
</html>

