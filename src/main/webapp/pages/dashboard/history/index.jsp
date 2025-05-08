<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="container-fluid">
  <!-- Page Header -->
  <div class="row mb-4">
    <div class="col-12">
      <div class="d-sm-flex align-items-center justify-content-between">
        <h1 class="h3 mb-0 text-gray-800">Quản lý lịch sử hoạt động</h1>
<%--        <a href="${pageContext.request.contextPath}/dashboard/categories?action=create"--%>
<%--           class="btn btn-primary">--%>
<%--          <i class="bi bi-plus-circle me-1"></i> Thêm danh mục--%>
<%--        </a>--%>
      </div>
    </div>
  </div>

  <!-- Quick Stats -->
  <div class="row mb-4">
    <div class="col-md-4 mb-3">
      <div class="card border-left-primary shadow h-100 py-2">
        <div class="card-body">
          <div class="row no-gutters align-items-center">
            <div class="col mr-2">
              <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
               Danh sách hoạt động
              </div>
              <div class="h5 mb-0 font-weight-bold text-gray-800">${logs.size()}</div>
            </div>
            <div class="col-auto">
              <i class="bi bi-bookmark-fill fa-2x text-gray-300"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


  <div class="row mb-4">
    <div class="col-12">
      <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
          <h6 class="m-0 font-weight-bold text-primary">Danh sách hoạt động</h6>
          <div class="dropdown no-arrow">
            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button"
                    id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
              <i class="bi bi-download me-1"></i> Xuất dữ liệu
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
              <li><a class="dropdown-item" href="#" id="export-excel"><i class="bi bi-file-earmark-excel me-2"></i>Excel</a></li>
              <li><a class="dropdown-item" href="#" id="export-pdf"><i class="bi bi-file-earmark-pdf me-2"></i>PDF</a></li>
              <li><a class="dropdown-item" href="#" id="export-csv"><i class="bi bi-file-earmark-text me-2"></i>CSV</a></li>
              <li><a class="dropdown-item" href="#" id="export-print"><i class="bi bi-printer me-2"></i>In</a></li>
            </ul>
          </div>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table id="categories" class="table table-striped table-hover table-bordered" style="width:100%">
              <thead>
              <tr>
                <th>ID</th>
                <th>Tên người dùng</th>
                <th>Hành động</th>
                <th>Thời gian</th>
                <th>Thao tác</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="logs" items="${logs}">
                <tr>
                  <td>${logs.id}</td>
                  <td>
                    <span class="fw-bold"> ${logs.userId}</span>
                  </td>
                  <td>
                    <span class="fw-bold">${logs.action}</span>
                  </td>
                  <td>
                    <fmt:formatDate value="${logs.timestamp}" pattern="dd/MM/yyyy" />
                  </td>
                  <td>
                    <div class="btn-group" role="group">
                      <a href="${pageContext.request.contextPath}/dashboard/categories?action=edit&id=${logs.id}"
                         class="btn btn-sm btn-primary me-1" title="Sửa">
                        <i class="bi bi-pencil-fill"></i>
                      </a>
                      <button type="button" class="btn btn-sm btn-danger delete-btn"
                              data-id="${logs.id}" data-name="${logs.id}" title="Xóa">
                        <i class="bi bi-trash-fill"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" id="categoryId" />
        <p>Bạn có chắc chắn muốn xóa danh mục <span id="categoryName" class="fw-bold"></span>?</p>
        <p class="text-danger">Lưu ý: Hành động này không thể hoàn tác.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <button type="button" id="confirmDeleteBtn" class="btn btn-danger">Xóa</button>
      </div>
    </div>
  </div>
</div>

<style>
  .category-image {
    width: 100px;
    height: 100px;
    object-fit: contain;
  }

  .card-header .dropdown-menu a:hover {
    background-color: #f8f9fc;
  }

  .border-left-primary {
    border-left: 0.25rem solid #4e73df !important;
  }
</style>
<script src="${pageContext.request.contextPath}/assets/js/swalHelper.js"></script>
<script>
  $(document).ready(function() {
    // Initialize DataTable
    var table = $('#categories').DataTable({
      pageLength: 10,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/vi.json'
      },
      dom: 'Bfrtip',
      buttons: [
        {
          extend: 'excel',
          text: 'Excel',
          exportOptions: {
            columns: ':visible'
          },
          className: 'd-none'
        },
        {
          extend: 'pdf',
          text: 'PDF',
          exportOptions: {
            columns: ':visible'
          },
          className: 'd-none'
        },
        {
          extend: 'csv',
          text: 'CSV',
          exportOptions: {
            columns: ':visible'
          },
          className: 'd-none'
        },
        {
          extend: 'print',
          text: 'Print',
          exportOptions: {
            columns: ':visible'
          },
          className: 'd-none'
        }
      ]
    });

    // Export buttons
    $('#export-excel').click(function() {
      table.button('.buttons-excel').trigger();
    });

    $('#export-pdf').click(function() {
      table.button('.buttons-pdf').trigger();
    });

    $('#export-csv').click(function() {
      table.button('.buttons-csv').trigger();
    });

    $('#export-print').click(function() {
      table.button('.buttons-print').trigger();
    });

    // Delete confirmation
    // $('.delete-btn').click(function() {
    //   var id = $(this).data('id');
    //   var name = $(this).data('name');
    //   console.log('id: ' + id )
    //   $('#categoryId').val(id);
    //   $('#categoryName').text(name);
    //   $('#deleteModal').modal('show');
    // });

    // Handle delete confirmation with AJAX
    <%--$('#confirmDeleteBtn').click(function() {--%>
    <%--  var categoryId = $('#categoryId').val();--%>
    <%--  console.log(categoryId)--%>
    <%--  // Show loading state--%>
    <%--  $(this).prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Đang xử lý...');--%>

    <%--  $.ajax({--%>
    <%--    url: '${pageContext.request.contextPath}/dashboard/history',--%>
    <%--    method: 'POST',--%>
    <%--    data: {--%>
    <%--      action: 'delete',--%>
    <%--      id: id--%>
    <%--    },--%>
    <%--    success: function(response) {--%>
    <%--      $('#deleteModal').modal('hide');--%>

    <%--      if (response.success) {--%>
    <%--        Swal.fire({--%>
    <%--          icon: 'success',--%>
    <%--          title: 'Thành công!',--%>
    <%--          text: response.message,--%>
    <%--          confirmButtonText: 'OK'--%>
    <%--        }).then(() => {--%>
    <%--          // Reload the page to refresh the category list--%>
    <%--          location.reload();--%>
    <%--        });--%>
    <%--      } else {--%>
    <%--        Swal.fire({--%>
    <%--          icon: 'error',--%>
    <%--          title: 'Lỗi',--%>
    <%--          text: response.message || 'Không thể xóa danh mục'--%>
    <%--        });--%>
    <%--      }--%>
    <%--    },--%>
    <%--    error: function(xhr) {--%>
    <%--      $('#deleteModal').modal('hide');--%>

    <%--      let errorMessage = 'Không thể xóa danh mục';--%>
    <%--      try {--%>
    <%--        const response = JSON.parse(xhr.responseText);--%>
    <%--        if (response.message) {--%>
    <%--          errorMessage = response.message;--%>
    <%--        }--%>
    <%--      } catch (e) {--%>
    <%--        console.error('Error parsing error response:', e);--%>
    <%--      }--%>

    <%--      Swal.fire({--%>
    <%--        icon: 'error',--%>
    <%--        title: 'Lỗi',--%>
    <%--        text: errorMessage--%>
    <%--      });--%>
    <%--    },--%>
    <%--    complete: function() {--%>
    <%--      // Reset button state--%>
    <%--      $('#confirmDeleteBtn').prop('disabled', false).html('Xóa');--%>
    <%--    }--%>
    <%--  });--%>
    <%--});--%>
  });
</script>
