<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .btn-back {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        color: #6c757d;
    }
    .btn-back:hover {
        background-color: #e9ecef;
        color: #495057;
    }
    .form-label {
        font-weight: 500;
        color: #495057;
    }
    .form-control:focus {
        border-color: #80bdff;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    }
    .alert {
        border-radius: 0.25rem;
        margin-bottom: 1rem;
    }
    .product-info {
        background-color: #f8f9fa;
        border-radius: 0.25rem;
        padding: 1rem;
        margin-bottom: 1.5rem;
    }
    .product-info h5 {
        color: #495057;
        margin-bottom: 0.5rem;
    }
    .product-info p {
        color: #6c757d;
        margin-bottom: 0.25rem;
    }
    .required-field::after {
        content: "*";
        color: #dc3545;
        margin-left: 4px;
    }
</style>

<div class="container-fluid">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">Chỉnh sửa giảm giá sản phẩm</h4>
        <a href="${pageContext.request.contextPath}/dashboard/product-sales" class="btn btn-back">
            <i class="fas fa-arrow-left me-2"></i>Quay lại
        </a>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Product Information -->
    <div class="product-info">
        <h5>Thông tin sản phẩm</h5>
        <div class="row">
            <div class="col-md-6">
                <p><strong>Tên sản phẩm:</strong> ${sale.productName}</p>
                <p><strong>Giá gốc:</strong> <fmt:formatNumber value="${sale.basePrice}" type="currency" currencySymbol="₫"/></p>
            </div>
            <div class="col-md-6">
                <p><strong>Danh mục:</strong> ${sale.categoryName}</p>
                <p><strong>Thương hiệu:</strong> ${sale.brandName}</p>
            </div>
        </div>
    </div>

    <!-- Edit Form -->
    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/dashboard/product-sales" method="POST" id="editSaleForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${sale.id}">
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="name" class="form-label required-field">Tên chương trình giảm giá</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="${sale.name}" required>
                    </div>
                    <div class="col-md-6">
                        <label for="discountPercentage" class="form-label required-field">Phần trăm giảm giá</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="discountPercentage" 
                                   name="discountPercentage" value="${sale.discountPercentage}" 
                                   min="0" max="100" step="0.01" required>
                            <span class="input-group-text">%</span>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <textarea class="form-control" id="description" name="description" 
                              rows="3">${sale.description}</textarea>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="startDate" class="form-label required-field">Ngày bắt đầu</label>
                        <input type="date" class="form-control" id="startDate" name="startDate" 
                               value="<fmt:formatDate value='${sale.startDate}' pattern='yyyy-MM-dd'/>" required>
                    </div>
                    <div class="col-md-6">
                        <label for="endDate" class="form-label required-field">Ngày kết thúc</label>
                        <input type="date" class="form-control" id="endDate" name="endDate" 
                               value="<fmt:formatDate value='${sale.endDate}' pattern='yyyy-MM-dd'/>" required>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2">
                    <a href="${pageContext.request.contextPath}/dashboard/product-sales" class="btn btn-secondary">
                        Hủy
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Initialize date pickers
    flatpickr("#startDate", {
        dateFormat: "Y-m-d",
        minDate: "today",
        onChange: function(selectedDates, dateStr) {
            endDatePicker.set("minDate", dateStr);
        }
    });

    const endDatePicker = flatpickr("#endDate", {
        dateFormat: "Y-m-d",
        minDate: "today"
    });

    // Form validation
    const form = document.getElementById('editSaleForm');
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const startDate = new Date(document.getElementById('startDate').value);
        const endDate = new Date(document.getElementById('endDate').value);
        const discountPercentage = parseFloat(document.getElementById('discountPercentage').value);
        
        if (endDate <= startDate) {
            alert('Ngày kết thúc phải sau ngày bắt đầu');
            return;
        }
        
        if (discountPercentage <= 0 || discountPercentage > 100) {
            alert('Phần trăm giảm giá phải từ 0 đến 100');
            return;
        }
        
        form.submit();
    });
});
</script> 