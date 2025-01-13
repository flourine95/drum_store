package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.User;
import com.drumstore.web.models.UserAddress;
import com.drumstore.web.services.UserAddressService;
import com.drumstore.web.services.UserService;
import com.drumstore.web.utils.Utils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/users/*")
public class UserManagerController extends ResourceController {
    private UserService userService;
    private UserAddressService userAddressService;

    @Override
    public void init() {
        this.userService = new UserService();
        this.userAddressService = new UserAddressService();
    }

    @Override
    public void indexNested(HttpServletRequest request, HttpServletResponse response, String userId, NestedResourceType resourceType) {
        switch (resourceType) {
            case POSTS:
                // Xử lý hiển thị danh sách bài posts
                break;
            case ADDRESSES:
                System.out.println("day la addresses");
                break;
            case ORDERS:
                // Xử lý hiển thị danh sách đơn hàng
                break;
            case WISHLISTS:
                // Xử lý hiển thị danh sách wishlist
                break;
        }
    }

    @Override
    public void showNested(HttpServletRequest request, HttpServletResponse response, String userId, String id, NestedResourceType resourceType) {
        switch (resourceType) {
            case POSTS:
                // Hiển thị chi tiết một bài post
                break;
            case ADDRESSES:
                System.out.println("day la addresses voi id la: " + id);
                break;
            case ORDERS:
                // Hiển thị chi tiết một đơn hàng
                break;
            case WISHLISTS:
                // Hiển thị chi tiết một wishlist
                break;
        }
    }

    @Override
    public void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {
        System.out.println("day la editNested");
        switch (resourceType) {
            case POSTS:
                // Hiển thị chi tiết một bài post
                break;
            case ADDRESSES:
                UserAddress address = userAddressService.find(Integer.parseInt(id));
                request.setAttribute("address", address);
                request.setAttribute("pageTitle", "Chỉnh sửa địa chỉ");
                request.setAttribute("content", "users/addresses/edit.jsp");
                request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
                break;
            case ORDERS:
                // Hiển thị chi tiết một đơn hàng
                break;
            case WISHLISTS:
                // Hiển thị chi tiết một wishlist
                break;
        }
    }

    @Override
    public void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {
        if (!Utils.validateCsrfToken(request, response)) return;
        switch (resourceType) {
            case POSTS:
                // Hiển thị chi tiết một bài post
                break;
            case ADDRESSES:
                try {
                    String address = request.getParameter("address");
                    String phone = request.getParameter("phone");
                    int provinceId = Integer.parseInt(request.getParameter("provinceId"));
                    int districtId = Integer.parseInt(request.getParameter("districtId"));
                    int wardId = Integer.parseInt(request.getParameter("wardId"));
                    System.out.println("isdefault: " + request.getParameter("isDefault"));
                    boolean isDefault = Boolean.parseBoolean(request.getParameter("isDefault"));

                    // Tạo đối tượng UserAddress
                    UserAddress userAddress = new UserAddress();
                    userAddress.setId(Integer.parseInt(id));
                    userAddress.setUserId(Integer.parseInt(parentId));
                    userAddress.setAddress(address);
                    userAddress.setPhone(phone);
                    userAddress.setProvinceId(provinceId);
                    userAddress.setDistrictId(districtId);
                    userAddress.setWardId(wardId);
                    userAddress.setIsDefault(isDefault);

                    userAddressService.update(userAddress);

                    // Redirect
                    response.sendRedirect(request.getContextPath() + "/dashboard/users/" + parentId + "/edit");
                } catch (NumberFormatException | NullPointerException e) {
                    request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ.");
                    editNested(request, response, parentId, id, resourceType);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
                    editNested(request, response, parentId, id, resourceType);
                }
                break;
            case ORDERS:
                // Hiển thị chi tiết một đơn hàng
                break;
            case WISHLISTS:
                // Hiển thị chi tiết một wishlist
                break;
        }
    }

    @Override
    public void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws IOException, ServletException {
        System.out.println("day la deleteNested");
        if (!Utils.validateCsrfToken(request, response)) return;
        switch (resourceType) {
            case POSTS:
                // Hiển thị chi tiết một bài post
                break;
            case ADDRESSES:
                try {
                    userAddressService.delete(Integer.parseInt(id));
                    response.sendRedirect(request.getContextPath() + "/dashboard/users/" + parentId + "/edit");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Xóa địa chỉ thất bại: " + e.getMessage());
                    editNested(request, response, parentId, id, resourceType);
                }
                break;
            case ORDERS:
                // Hiển thị chi tiết một đơn hàng
                break;
            case WISHLISTS:
                // Hiển thị chi tiết một wishlist
                break;
        }
    }

    @Override
    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userService.all();
        request.setAttribute("users", users);
        request.setAttribute("pageTitle", "Quản lý người dùng");
        request.setAttribute("content", "users/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        User user = userService.detail(Integer.parseInt(id));
        request.setAttribute("user", user);
        request.setAttribute("pageTitle", "Chi tiết người dùng");
        request.setAttribute("content", "users/show.jsp");  // hoặc file jsp tương ứng
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Thêm người dùng");
        request.setAttribute("content", "users/create.jsp");  // hoặc file jsp tương ứng
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void store(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        User user = userService.detail(Integer.parseInt(id));
        request.setAttribute("user", user);
        request.setAttribute("pageTitle", "Chỉnh sửa người dùng");
        request.setAttribute("content", "users/edit.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) throws IOException, ServletException {
        if (!Utils.validateCsrfToken(request, response)) return;

        try {
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");

            User user = userService.detail(Integer.parseInt(id));
            user.setFullname(fullname);
            user.setEmail(email);

            userService.update(user);

            // Redirect về trang danh sách người dùng
            response.sendRedirect(request.getContextPath() + "/dashboard/users");
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("error", "Dữ liệu đầu vào không hợp lệ.");
            edit(request, response, id);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            edit(request, response, id);
        }
    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) throws IOException, ServletException {
        if (!Utils.validateCsrfToken(request, response)) return;

        try {
            userService.delete(Integer.parseInt(id));

            response.sendRedirect(request.getContextPath() + "/dashboard/users");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Xóa người dùng thất bại: " + e.getMessage());
            index(request, response);
        }
    }

}
