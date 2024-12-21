
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Location Selector</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        select {
            width: 200px; /* Đặt chiều dài cố định */
            padding: 5px; /* Thêm padding cho dễ nhìn */
            box-sizing: border-box; /* Giữ nguyên kích thước kể cả khi thêm padding */
        }
    </style>
</head>

<body>
<select id="province-select">
    <option value="">Chọn tỉnh</option>
</select>

<select id="district-select">
    <option value="">Chọn huyện</option>
</select>

<select id="ward-select">
    <option value="">Chọn xã</option>
</select>

<script>
    // Load provinces
    $.get('/location?action=provinces', function(data) {
        data.forEach(function(province) {
            $('#province-select').append(`<option value="\${province.id}">\${province.name}</option>`);
        });
    });

    // Load districts khi chọn tỉnh
    $('#province-select').change(function() {
        const provinceId = $(this).val();
        // Reset danh sách huyện và xã
        $('#district-select').html('<option value="">Chọn huyện</option>');
        $('#ward-select').html('<option value="">Chọn xã</option>'); // Reset xã khi đổi tỉnh

        if (provinceId) {
            $.get(`/location?action=districts&provinceId=\${provinceId}`, function(data) {
                data.forEach(function(district) {
                    $('#district-select').append(`<option value="\${district.id}">\${district.name}</option>`);
                });
            });
        }
    });


    // Load wards khi chọn huyện
    $('#district-select').change(function() {
        const districtId = $(this).val();
        if (districtId) {
            $.get(`/location?action=wards&districtId=\${districtId}`, function(data) {
                $('#ward-select').html('<option value="">Chọn xã</option>');
                data.forEach(function(ward) {
                    $('#ward-select').append(`<option value="\${ward.id}">\${ward.name}</option>`);
                });
            });
        }
    });
</script>
</body>
</html>

