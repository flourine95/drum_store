<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid px-4 py-4">
    <!-- Breadcrumb và tiêu đề trang -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none">Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard/sales" class="text-decoration-none">Chương trình khuyến mãi</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thêm mới</li>
            </ol>
        </nav>
    </div>

    <!-- Card chính -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3">
            <h5 class="card-title mb-0"><i class="bi bi-plus-circle me-2"></i>Thêm chương trình khuyến mãi mới</h5>
        </div>
        <div class="card-body">
            <form id="createSaleForm" action="${pageContext.request.contextPath}/dashboard/sales" method="POST" class="needs-validation" novalidate>
                <div class="row g-4">
                    <!-- Thông tin cơ bản -->
                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0 h-100">
                            <div class="card-header bg-white py-3">
                                <h6 class="card-title mb-0"><i class="bi bi-info-circle me-2"></i>Thông tin cơ bản</h6>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-md-12">
                                        <label for="name" class="form-label fw-medium">Tên chương trình <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                        <div class="invalid-feedback">Vui lòng nhập tên chương trình khuyến mãi</div>
                                    </div>
                                    
                                    <div class="col-md-12">
                                        <label for="description" class="form-label fw-medium">Mô tả <span class="text-danger">*</span></label>
                                        <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                                        <div class="invalid-feedback">Vui lòng nhập mô tả chương trình khuyến mãi</div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <label for="discountPercentage" class="form-label fw-medium">Phần trăm giảm giá (%) <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input type="number" class="form-control" id="discountPercentage" name="discountPercentage" min="1" max="100" required>
                                            <span class="input-group-text">%</span>
                                            <div class="invalid-feedback">Vui lòng nhập phần trăm giảm giá hợp lệ (1-100)</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Thời gian áp dụng -->
                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 h-100">
                            <div class="card-header bg-white py-3">
                                <h6 class="card-title mb-0"><i class="bi bi-calendar-event me-2"></i>Thời gian áp dụng</h6>
                            </div>
                            <div class="card-body">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label for="startDate" class="form-label fw-medium">Ngày bắt đầu <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                                        <div class="invalid-feedback">Vui lòng chọn ngày bắt đầu</div>
                                    </div>
                                    
                                    <div class="col-12">
                                        <label for="endDate" class="form-label fw-medium">Ngày kết thúc <span class="text-danger">*</span></label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                                        <div class="invalid-feedback">Vui lòng chọn ngày kết thúc</div>
                                    </div>
                                    
                                    <div class="col-12 mt-4">
                                        <div class="alert alert-info" role="alert">
                                            <i class="bi bi-info-circle-fill me-2"></i> Khuyến mãi sẽ được áp dụng từ 00:00 ngày bắt đầu đến 23:59 ngày kết thúc.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Nút thao tác -->
                <div class="d-flex justify-content-end gap-2 mt-4">
                    <a href="${pageContext.request.contextPath}/dashboard/sales" class="btn btn-secondary">
                        <i class="bi bi-x-circle me-2"></i>Hủy
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="bi bi-check-circle me-2"></i>Tạo mới
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Đặt giá trị mặc định cho ngày bắt đầu là ngày hiện tại
        const today = new Date();
        const formattedToday = today.toISOString().split('T')[0];
        document.getElementById('startDate').value = formattedToday;
        
        // Đặt giá trị mặc định cho ngày kết thúc là 7 ngày sau
        const nextWeek = new Date(today);
        nextWeek.setDate(today.getDate() + 7);
        const formattedNextWeek = nextWeek.toISOString().split('T')[0];
        document.getElementById('endDate').value = formattedNextWeek;
        
        // Validation form
        const form = document.getElementById('createSaleForm');
        
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            } else {
                // Hiển thị loading trên nút submit
                const submitBtn = document.getElementById('submitBtn');
                const originalHtml = submitBtn.innerHTML;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang xử lý...';
                submitBtn.disabled = true;
            }
            
            form.classList.add('was-validated');
        }, false);
        
        // Kiểm tra ngày kết thúc phải sau ngày bắt đầu
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        
        function validateDates() {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);
            
            if (endDate <= startDate) {
                endDateInput.setCustomValidity('Ngày kết thúc phải sau ngày bắt đầu');
            } else {
                endDateInput.setCustomValidity('');
            }
        }
        
        startDateInput.addEventListener('change', validateDates);
        endDateInput.addEventListener('change', validateDates);
    });
</script>