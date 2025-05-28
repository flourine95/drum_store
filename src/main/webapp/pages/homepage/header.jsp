<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .dropdown-menu a {
        cursor: pointer;
    }

    .navbar-nav .nav-link {
        position: relative;
        padding: 0.5rem 1rem;
        margin: 0 0.2rem;
        transition: all 0.3s ease;
        color: black;
    }

    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background-color: var(--hover-color);
        transition: width 0.3s ease;
    }

    .navbar-nav .nav-link:hover::after {
        width: 100%;
    }

    .navbar-nav .nav-link:hover {
        color: whitesmoke;
    }

    .action-icon-btn {
        background: white;
        border: none;
        border-radius: 8px;
        padding: 0;
        position: relative;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        text-decoration: none;
        color: #333;
        overflow: visible;
    }

    .cart-btn {
        margin-right: 10px !important;
    }

    .action-icon-btn .icon-container {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        z-index: 2;
    }

    .action-icon-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, var(--bs-primary) 0%, #0dcaf0 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1;
        border-radius: 8px;
        pointer-events: none;
    }

    .action-icon-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        color: white;
    }

    .action-icon-btn:hover::before {
        opacity: 1;
    }

    .action-icon-btn:hover .icon-container {
        color: white;
    }

    .action-icon-btn i {
        font-size: 1.25rem;
        transition: all 0.3s ease;
    }

    .action-icon-btn:hover i {
        transform: scale(1.2);
    }

    .cart-badge {
        position: absolute;
        top: -10px;
        right: -10px;
        background-color: #dc3545;
        color: white;
        font-size: 0.75rem;
        font-weight: bold;
        min-width: 20px;
        height: 20px;
        padding: 0 5px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 2px solid white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        z-index: 10;
        pointer-events: none;
    }

    .dropdown-menu {
        margin-top: 0.5rem;
        transition: all 0.2s ease;
        animation: fadeIn 0.2s ease forwards;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .modern-dropdown {
        min-width: 280px;
        padding: 0;
        border: none;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        right: -20px !important;
        left: auto !important;
    }

    .modern-dropdown .dropdown-header {
        background-color: #f8f9fa;
    }

    .modern-dropdown .menu-item {
        display: flex;
        align-items: center;
        padding: 0.8rem 1rem;
        color: #333;
        text-decoration: none;
        transition: all 0.2s ease;
        border-radius: 8px;
        margin: 0.2rem 0.5rem;
    }

    .modern-dropdown .menu-item i {
        font-size: 1.2rem;
        margin-right: 0.8rem;
        color: var(--bs-primary);
        transition: all 0.2s ease;
    }

    .modern-dropdown .menu-item:hover {
        background-color: rgba(13, 110, 253, 0.08);
        transform: translateX(5px);
    }

    .modern-dropdown .menu-item:hover i {
        transform: scale(1.2);
    }

    .modern-dropdown .user-avatar {
        display: inline-block;
        color: var(--bs-primary);
    }

    .modern-dropdown .dropdown-footer {
        background-color: #f8f9fa;
    }
</style>
<header>
    <div class="fixed-top">
        <img src="${pageContext.request.contextPath}/assets/images/banners/banner_header.png"
             alt="Tháng Tri Ân Săn Sale"
             class="img-fluid w-100 banner-header">
        <nav class="navbar navbar-expand navbar-light bg-primary">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/assets/images/logos/logo.png" alt="Logo"
                         style="height: 60px;width: auto">
                </a>
                <div class="navbar-nav mx-auto fw-bold">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">TRANG CHỦ</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">GIỚI THIỆU</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">SẢN PHẨM</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">LIÊN HỆ</a>
                </div>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/cart"
                       class="action-icon-btn me-3 position-relative cart-btn">
                        <div class="icon-container">
                            <i class="bi bi-cart-fill"></i>
                        </div>
                        <c:if test="${sessionScope.cart.itemCount > 0}">
                            <span class="cart-badge">${sessionScope.cart.itemCount}</span>
                        </c:if>
                    </a>
                    <div class="dropdown account-dropdown">
                        <button class="action-icon-btn" type="button" id="desktopAccountDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false">
                            <span class="icon-container">
                                <i class="bi bi-person-circle"></i>
                            </span>
                        </button>
                        <div class="dropdown-menu dropdown-menu-end modern-dropdown"
                             aria-labelledby="desktopAccountDropdown">
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <div class="dropdown-header text-center py-3">
                                        <i class="bi bi-person-circle display-6 mb-2"></i>
                                        <h6 class="mb-0">Chào mừng quý khách</h6>
                                        <small>Đăng nhập để trải nghiệm tốt hơn</small>
                                    </div>
                                    <div class="dropdown-actions p-3">
                                        <a id="loginLink" class="btn btn-primary w-100 mb-2"
                                           href="${pageContext.request.contextPath}/login">
                                            <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
                                        </a>
                                        <a class="btn btn-outline-secondary w-100"
                                           href="${pageContext.request.contextPath}/register">
                                            <i class="bi bi-person-plus me-2"></i>Đăng ký
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="user-profile p-3 text-center border-bottom">
                                        <div class="user-avatar mb-2">
                                            <i class="bi bi-person-circle display-6"></i>
                                        </div>
                                        <h6 class="mb-0 fw-bold">${sessionScope.user.fullname}</h6>
                                        <small class="text-muted">${sessionScope.user.email}</small>
                                    </div>
                                    <div class="menu-items p-2">
                                        <a class="menu-item" href="${pageContext.request.contextPath}/profile">
                                            <i class="bi bi-person"></i>
                                            <span>Thông tin tài khoản</span>
                                        </a>
                                        <a class="menu-item"
                                           href="${pageContext.request.contextPath}/profile?action=wishlist">
                                            <i class="bi bi-heart"></i>
                                            <span>Sản phẩm yêu thích</span>
                                        </a>
                                        <a class="menu-item"
                                           href="${pageContext.request.contextPath}/profile?action=orders">
                                            <i class="bi bi-bag"></i>
                                            <span>Quản lý đơn hàng</span>
                                        </a>
                                        <a class="menu-item"
                                           href="${pageContext.request.contextPath}/profile?action=addresses">
                                            <i class="bi bi-geo-alt"></i>
                                            <span>Danh sách địa chỉ</span>
                                        </a>
                                    </div>
                                    <div class="dropdown-footer p-2 border-top">
                                        <form id="logoutFormUser" action="${pageContext.request.contextPath}/logout"
                                              method="POST">
                                            <button type="button" onclick="return logout()"
                                                    class="btn btn-outline-danger w-100">
                                                <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                            </button>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</header>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const dropdownMenu = document.querySelector('.modern-dropdown');

        if (dropdownMenu) {
            dropdownMenu.addEventListener('click', function (e) {
                const isLink = e.target.tagName === 'A' ||
                    e.target.closest('a') ||
                    (e.target.tagName === 'BUTTON' && e.target.type !== 'button') ||
                    e.target.closest('button[type="submit"]');

                if (!isLink) {
                    e.stopPropagation();
                }
            });
        }
    });
</script>
