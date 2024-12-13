<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Product List</title>
    <script>
        function confirmDelete(productId) {
            if (!confirm("Are you sure you want to delete this product?")) {
                event.preventDefault(); 
            }
        }
    </script>
</head>
<body>
<h1>Product List</h1>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${products}">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.description}</td>
            <td>${product.price}</td>
            <td>
                <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Edit</a>
                <form onsubmit="confirmDelete(${product.id})" action="${pageContext.request.contextPath}/products" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${product.id}">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>

