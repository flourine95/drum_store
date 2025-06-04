<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

    ::after,
    ::before {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    a {
        text-decoration: none;
    }

    li {
        list-style: none;
    }

    body {
        font-family: 'Poppins', sans-serif;
    }

    .wrapper {
        display: flex;
    }

    .main {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        width: 100%;
        overflow: hidden;
        transition: all 0.35s ease-in-out;
        background-color: #fff;
        min-width: 0;
    }

    #sidebar {
        width: 70px;
        min-width: 70px;
        z-index: 1000;
        transition: all .25s ease-in-out;
        background-color: #0e2238;
        display: flex;
        flex-direction: column;
    }

    #sidebar.expand {
        width: 260px;
        min-width: 260px;
    }

    .toggle-btn {
        background-color: transparent;
        cursor: pointer;
        border: 0;
        padding: 1rem 1.5rem;
    }

    .toggle-btn i {
        font-size: 1.5rem;
        color: #FFF;
    }

    .sidebar-logo {
        margin: auto 0;
    }

    .sidebar-logo a {
        color: #FFF;
        font-size: 1.15rem;
        font-weight: 600;
    }

    #sidebar:not(.expand) .sidebar-logo,
    #sidebar:not(.expand) a.sidebar-link span {
        display: none;
    }

    #sidebar.expand .sidebar-logo,
    #sidebar.expand a.sidebar-link span {
        animation: fadeIn .25s ease;
    }

    @keyframes fadeIn {
        0% {
            opacity: 0;
        }

        100% {
            opacity: 1;
        }
    }

    .sidebar-nav {
        padding: 2rem 0;
        flex: 1 1 auto;
    }

    a.sidebar-link {
        padding: .625rem 1.625rem;
        color: #FFF;
        display: block;
        font-size: 0.9rem;
        white-space: nowrap;
        border-left: 3px solid transparent;
    }

    .sidebar-link i,
    .dropdown-item i {
        font-size: 1.1rem;
        margin-right: .75rem;
    }

    a.sidebar-link:hover {
        background-color: rgba(255, 255, 255, .075);
        border-left: 3px solid #3b7ddd;
    }

    .sidebar-item {
        position: relative;
    }

    #sidebar:not(.expand) .sidebar-item .sidebar-dropdown {
        position: absolute;
        top: 0;
        left: 70px;
        background-color: #0e2238;
        padding: 0;
        min-width: 15rem;
        display: none;
    }

    #sidebar:not(.expand) .sidebar-item:hover .has-dropdown + .sidebar-dropdown {
        display: block;
        max-height: 15em;
        width: 100%;
        opacity: 1;
    }

    #sidebar.expand .sidebar-link[data-bs-toggle="collapse"]::after {
        border: solid;
        border-width: 0 .075rem .075rem 0;
        content: "";
        display: inline-block;
        padding: 2px;
        position: absolute;
        right: 1.5rem;
        top: 1.4rem;
        transform: rotate(-135deg);
        transition: all .2s ease-out;
    }

    #sidebar.expand .sidebar-link[data-bs-toggle="collapse"].collapsed::after {
        transform: rotate(45deg);
        transition: all .2s ease-out;
    }

    .navbar {
        background-color: #f5f5f5;
        box-shadow: 0 0 2rem 0 rgba(33, 37, 41, .1);
    }

    .navbar-expand .navbar-collapse {
        min-width: 200px;
    }
</style>
<aside id="sidebar">
    <div class="d-flex">
        <button class="toggle-btn" type="button">
            <i class="bi bi-grid"></i>
        </button>
        <div class="sidebar-logo">
            <a href="${pageContext.request.contextPath}/dashboard">Drum Store</a>
        </div>
    </div>
    <ul class="sidebar-nav">
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link" title="Trang Chủ">
                <i class="bi bi-speedometer2"></i>
                <span>Trang Chủ</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/products" class="sidebar-link" title="Quản lý Sản Phẩm">
                <i class="bi bi-box-seam"></i>
                <span>Q.L Sản Phẩm</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/product-sales" class="sidebar-link" title="Quản lý Giảm Giá Sản Phẩm">
                <i class="bi bi-currency-dollar"></i>
                <span>Q.L Giảm Giá Sản Phẩm</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/categories" class="sidebar-link" title="Quản lý Danh Mục">
                <i class="bi bi-bookmark"></i>
                <span>Q.L Danh Mục</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/brands" class="sidebar-link" title="Quản lý Thương Hiệu">
                <i class="bi bi-tags"></i>
                <span>Q.L Thương Hiệu</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/orders" class="sidebar-link" title="Quản lý Đơn Hàng">
                <i class="bi bi-cart3"></i>
                <span>Q.L Đơn Hàng</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/users" class="sidebar-link" title="Quản lý Khách Hàng">
                <i class="bi bi-people"></i>
                <span>Q.L Khách Hàng</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/sales" class="sidebar-link" title="Quản lý Chương Trình Khuyến Mãi">
                <i class="bi bi-gift"></i>
                <span>Q.L Khuyến Mãi</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/vouchers" class="sidebar-link" title="Quản lý Mã Giảm Giá">
                <i class="bi bi-ticket-perforated"></i>
                <span>Q.L Mã Giảm Giá</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/feedbacks" class="sidebar-link" title="Phản Hồi Khách Hàng">
                <i class="bi bi-chat-dots"></i>
                <span>Q.L Phản Hồi</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/histories" class="sidebar-link" title="Lịch Sử Hệ Thống">
                <i class="bi bi-clock-history"></i>
                <span>Q.L Lịch Sử</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/permissions" class="sidebar-link" title="Quản lý Quyền">
                <i class="bi bi-shield-lock"></i>
                <span>Q.L Quyền</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/roles" class="sidebar-link" title="Quản lý Vai Trò">
                <i class="bi bi-person-badge"></i>
                <span>Q.L Vai Trò</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/role-permissions" class="sidebar-link" title="Quản lý Quyền - Vai Trò">
                <i class="bi bi-link-45deg"></i>
                <span>Q.L Quyền - Vai Trò</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/user-roles" class="sidebar-link" title="Quản lý Người Dùng - Vai Trò">
                <i class="bi bi-person-lines-fill"></i>
                <span>Q.L Người Dùng - Vai Trò</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/inventory" class="sidebar-link" title="Quản lý Kho Hàng">
                <i class="bi bi-clipboard-data"></i>
                <span>Q.L Kho Hàng</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/reports" class="sidebar-link" title="Báo Cáo">
                <i class="bi bi-bar-chart"></i>
                <span>Báo Cáo</span>
            </a>
        </li>
        <li class="sidebar-item">
            <a href="${pageContext.request.contextPath}/dashboard/settings" class="sidebar-link" title="Cài Đặt">
                <i class="bi bi-gear"></i>
                <span>Cài Đặt</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link" title="Đăng Xuất">
            <i class="bi bi-box-arrow-right"></i>
            <span>Đăng Xuất</span>
        </a>
    </div>
</aside>
<script>
    const hamBurger = document.querySelector(".toggle-btn");
    hamBurger.addEventListener("click", function () {
        document.querySelector("#sidebar").classList.toggle("expand");
    });
</script>