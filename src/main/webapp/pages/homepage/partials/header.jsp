<c:if test="${not empty sessionScope.user}">
    <div class="dropdown">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            ${sessionScope.user.fullName}
        </button>
        <ul class="dropdown-menu" aria-labelledby="userDropdown">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Tài khoản của tôi</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">Đơn hàng</a></li>
            <li><hr class="dropdown-divider"></li>
            <li>
                <form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="POST" class="dropdown-item p-0">
                    <button type="button" class="btn btn-link text-danger text-decoration-none w-100 text-start px-3" 
                            onclick="logout(); return false;">
                        <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                    </button>
                </form>
            </li>
        </ul>
    </div>
</c:if> 