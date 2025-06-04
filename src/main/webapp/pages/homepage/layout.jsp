<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>${title}</title>
    <link rel="icon" href="https://ckbox.cloud/vbhlwxkZHAS6tNu2Czrw/assets/yBfxxg-rRjID/file" type="image/png">
    <script src="${pageContext.request.contextPath}/assets/lib/jquery-3.7.1/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/bootstrap-5.3.3-dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/lib/sweetalert2-11.17.2/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/bootstrap-5.3.3-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/bootstrap-icons-1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/fontawesome-free-5.15.4-web/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/animate.css-4.1.1/animate.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/sweetalert2-11.17.2/sweetalert2.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/custom.css">
</head>

<body>
<jsp:include page="header.jsp"/>
<main>
    <jsp:include page="${content}"/>
</main>
<jsp:include page="footer.jsp"/>
<script src="${pageContext.request.contextPath}/assets/js/ajax-utils.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/auth.js"></script>
<script>
    function adjustMainContentPadding() {
        const fixedTop = document.querySelector('.fixed-top');
        const main = document.querySelector('main');
        
        if (fixedTop && main) {
            main.style.paddingTop = fixedTop.offsetHeight + 'px';
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        adjustMainContentPadding();
        
        const headerImages = document.querySelectorAll('header img');
        headerImages.forEach(function(img) {
            img.addEventListener('load', adjustMainContentPadding);
        });
    });
    
    window.addEventListener('resize', adjustMainContentPadding);
</script>

</body>
</html>