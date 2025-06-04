<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="card">
  <div class="card-body">
    <table id="feedbacks" class="table table-striped table-hover table-bordered" style="width:100%">
      <thead>
      <tr>
        <th>Người dùng</th>
        <th>Sản phẩm</th>
        <th>Hình ảnh</th>
        <th>Đánh giá (sao)</th>
        <th>Nội dung</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Thao tác</th>
      </tr>
      </thead>
    </table>
  </div>
</div>

<script>
  $(document).ready(function () {
    const table = $('#feedbacks').DataTable({
      processing: true,
      ajax: {
        url: '${pageContext.request.contextPath}/api/feedbacks',
        dataSrc: function (json) {
          if (json.success !== undefined && !json.success) {
            Swal.fire({
              icon: 'error',
              title: 'Lỗi',
              text: json.message || 'Không thể lấy dữ liệu đánh giá.'
            });
            return [];
          }
          return json;
        },
        error: function (xhr, error, thrown) {
          Swal.fire({
            icon: 'error',
            title: 'Lỗi hệ thống',
            text: 'Không thể lấy dữ liệu đánh giá. Vui lòng thử lại sau.'
          });
          console.error('AJAX Error:', xhr, error, thrown);
        }
      },
      columns: [
        // { data: 'id' },
        { data: 'userName' },
        { data: 'productName' },
        {
          data: 'imageUrl',
          render: function (data) {
            return data
                    ? `<img src="\${data}" alt="image" width="100" height="100" class="img-thumbnail">`
                    : 'Không có';
          }
        },
        {
          data: 'rating',
          render: function (data) {
            return `<span class="badge bg-warning text-dark">\${data} ★</span>`;
          }
        },
        { data: 'content' },
        {
          data: 'status',
          render: function (data, type, row) {
            return `
              <select class="form-select review-status" data-review-id="\${row.id}"  style="width: 150px;">
                <option value="0" \${data == 0 ? 'selected' : ''}>PENDING</option>
                <option value="1" \${data == 1 ? 'selected' : ''}>APPROVED</option>
                <option value="2" \${data == 2 ? 'selected' : ''}>REJECTED</option>
              </select>
            `;
          }
        },
        {
          data: 'createdAt',
          render: function (data) {
            return new Date(data).toLocaleString('vi-VN', {
              day: '2-digit',
              month: '2-digit',
              year: 'numeric',
              hour: '2-digit',
              minute: '2-digit'
            });
          }
        },
        {
          data: 'id',
          orderable: false,
          className: 'text-center',
          render: function (data) {
            return `
              <div class="btn-group" role="group">
                <button type="button" class="btn btn-danger btn-sm" onclick="deleteFeedback(\${data})" title="Xóa">
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            `;
          }
        }
      ],
      order: [[0, 'desc']],
      pageLength: 25,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json'
      },
      dom: '<"row mb-3"<"col-sm-12 col-md-6"B><"col-sm-12 col-md-6"f>>' +
              '<"row"<"col-sm-12"tr>>' +
              '<"row mt-3"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
      buttons: [
        {
          extend: 'collection',
          text: '<i class="bi bi-download me-2"></i>Xuất dữ liệu',
          className: 'btn btn-primary dropdown-toggle me-2',
          buttons: [
            {
              extend: 'excel',
              text: '<i class="bi bi-file-earmark-excel me-2"></i>Excel',
              className: 'dropdown-item',
              exportOptions: { columns: ':not(:last-child)' }
            },
            {
              extend: 'pdf',
              text: '<i class="bi bi-file-earmark-pdf me-2"></i>PDF',
              className: 'dropdown-item',
              exportOptions: { columns: ':not(:last-child)' }
            },
            {
              extend: 'csv',
              text: '<i class="bi bi-file-earmark-text me-2"></i>CSV',
              className: 'dropdown-item',
              exportOptions: { columns: ':not(:last-child)' }
            },
            {
              extend: 'print',
              text: '<i class="bi bi-printer me-2"></i>In',
              className: 'dropdown-item',
              exportOptions: { columns: ':not(:last-child)' }
            }
          ]
        },
        {
          extend: 'colvis',
          text: '<i class="bi bi-eye me-2"></i>Hiển thị cột',
          className: 'btn btn-secondary'
        }
      ]
    });

    // Cập nhật trạng thái khi thay đổi select
    $(document).on('change', '.review-status', function () {
      const $select = $(this);
      const reviewId = $select.data('review-id');
      const newStatus = $select.val();
      const originalStatus = $select.data('original-status');

      if (parseInt(newStatus) < parseInt(originalStatus)) {
        Swal.fire({
          icon: 'warning',
          title: 'Không thể quay lại trạng thái trước',
          text: 'Bạn không được phép quay lại trạng thái trước đó của đánh giá.',
        });
        $select.val(originalStatus);
        return;
      }

      $.ajax({
        url: '${pageContext.request.contextPath}/dashboard/feedbacks',
        method: 'POST',
        data: {
          action: 'updateStatus',
          feedbackId: reviewId,
          status: newStatus
        },
        success: function (response) {
          if (response.status === 'success') {
            Swal.fire({
              icon: 'success',
              title: 'Thành công',
              text: response.message || 'Trạng thái đánh giá đã được cập nhật!',
              timer: 2000,
              showConfirmButton: false
            });
            table.ajax.reload();
          } else {
            Swal.fire({
              icon: 'error',
              title: 'Thất bại',
              text: response.message || 'Lỗi khi cập nhật trạng thái.',
            });
          }
        },
        error: function () {
          Swal.fire({
            icon: 'error',
            title: 'Lỗi hệ thống',
            text: 'Không thể cập nhật trạng thái.',
          });
        }
      });
    });

    // Hàm xóa đánh giá
    window.deleteFeedback = function (id) {
      Swal.fire({
        title: 'Bạn có chắc chắn?',
        text: 'Đánh giá sẽ bị xóa và không thể khôi phục!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Xóa',
        cancelButtonText: 'Hủy',
        reverseButtons: true
      }).then((result) => {
        if (result.isConfirmed) {
          $.ajax({
            url: '${pageContext.request.contextPath}/dashboard/feedbacks',
            method: 'POST',
            data: {
              action: 'delete',
              feedbackId: id
            },
            success: function (response) {
              if (response.status === 'success') {
                Swal.fire({
                  icon: 'success',
                  title: 'Đã xóa',
                  text: 'Đánh giá đã được xóa.',
                  timer: 2000,
                  showConfirmButton: false
                });
                table.ajax.reload();
              } else {
                Swal.fire({
                  icon: 'error',
                  title: 'Lỗi',
                  text: response.message || 'Lỗi khi xóa đánh giá.',
                });
              }
            },
            error: function () {
              Swal.fire({
                icon: 'error',
                title: 'Lỗi hệ thống',
                text: 'Không thể xóa đánh giá.',
              });
            }
          });
        }
      });
    };
  });
</script>

