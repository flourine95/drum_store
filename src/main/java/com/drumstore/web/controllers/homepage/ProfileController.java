package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.AddressDTO;
import com.drumstore.web.dto.ProductDetailDTO;
import com.drumstore.web.models.User;
import com.drumstore.web.services.AddressService;
import com.drumstore.web.services.OrderService;
import com.drumstore.web.services.UserService;
import com.drumstore.web.services.WishlistService;
import com.drumstore.web.utils.GsonUtils;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private UserService userService;
    private AddressService addressService;
    private WishlistService wishlistService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.addressService = new AddressService();
        this.wishlistService = new WishlistService();
        this.orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";
        int userId = user.getId();
        switch (action) {
            case "addresses" -> {
                List<AddressDTO> addresses = addressService.getAddressesByUserId(userId);
                request.setAttribute("addresses", addresses);
                request.setAttribute("title", "Địa chỉ của tôi");
                request.setAttribute("profileContent", "profile-addresses.jsp");
                request.setAttribute("activePage", "addresses");
            }
            case "orders" -> {
                request.setAttribute("title", "Đơn hàng của tôi");
                request.setAttribute("profileContent", "profile-orders.jsp");
                request.setAttribute("activePage", "orders");
            }
            case "wishlist" -> {
                List<ProductDetailDTO> products = wishlistService.getAll(user);
                request.setAttribute("products", products);
                request.setAttribute("title", "Danh sách yêu thích");
                request.setAttribute("profileContent", "profile-wishlist.jsp");
                request.setAttribute("activePage", "wishlist");
            }
            case "edit-account" -> {
                user = userService.find(userId);
                request.setAttribute("user", user);
                request.setAttribute("title", "Chỉnh sửa tài khoản");
                request.setAttribute("profileContent", "edit-account.jsp");
                request.setAttribute("activePage", "profile");
            }
            default -> {
                user = userService.find(userId);
                request.setAttribute("user", user);
                request.setAttribute("title", "Tài khoản của tôi");
                request.setAttribute("profileContent", "index.jsp");
                request.setAttribute("activePage", "profile");
            }
        }
        request.setAttribute("content", "/pages/homepage/profile/profile-layout.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Đọc JSON từ request body
            JsonObject jsonObject = GsonUtils.fromJson(request.getReader());
            String action = jsonObject.get("action").getAsString();

            switch (action) {
                case "update-account" -> updateAccount(request, response, user, jsonObject);
                case "get_address" -> getAddress(request, response, user, jsonObject);
                case "add_address" -> addAddress(request, response, user, jsonObject);
                case "delete_address" -> deleteAddress(request, response, user, jsonObject);
                case "update_address" -> updateAddress(request, response, user, jsonObject);
                case "toggle-wishList" -> toogleWishtList(request, response, user, jsonObject);
                default -> response.sendRedirect(request.getContextPath() + "/profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, Object> errorResponse = Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            );
            writeJson(response, errorResponse);
        }
    }

    private void toogleWishtList(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> resp = new HashMap<>();
        try {
            int productId = jsonObject.get("data").getAsInt();
            // Kiểm tra xem sản phẩm đã có trong danh sách yêu thích hay chưa
            boolean isWishlisted = wishlistService.toogleWishtList(productId, user.getId());
            if (!isWishlisted) {
                resp.put("inWishlist", false);
            } else {
                resp.put("inWishlist", true);
            }

            resp.put("success", true);
        } catch (Exception e) {
            resp.put("success", false);
            resp.put("message", "Lỗi server: " + e.getMessage());
        }
        writeJson(response, resp);
    }

    private void updateAccount(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            JsonObject data = jsonObject.get("data").getAsJsonObject();
            String fullName = data.get("fullName").getAsString();
            String phone = data.get("phone").getAsString();

            user.setFullname(fullName);
            user.setPhone(phone);
            boolean success = userService.update(user) != 0;

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Cập nhật tài khoản thành công" : "Cập nhật tài khoản thất bại");
            writeJson(response, responseMap);
        } catch (Exception e) {
            writeJson(response, Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void getAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            int addressId = jsonObject.get("data").getAsJsonObject().get("addressId").getAsInt();
            AddressDTO address = addressService.getAddressById(addressId);

            if (address != null && address.getUserId() == user.getId()) {
                writeJson(response, address);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                writeJson(response, Map.of(
                        "success", false,
                        "message", "Không tìm thấy địa chỉ"
                ));
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            writeJson(response, Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void updateAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            JsonObject data = jsonObject.get("data").getAsJsonObject();

            AddressDTO addressDTO = new AddressDTO();
            addressDTO.setId(data.get("id").getAsInt());
            addressDTO.setUserId(user.getId());
            addressDTO.setFullname(data.get("fullname").getAsString());
            addressDTO.setPhone(data.get("phone").getAsString());
            addressDTO.setProvinceId(data.get("provinceId").getAsInt());
            addressDTO.setDistrictId(data.get("districtId").getAsInt());
            addressDTO.setWardId(data.get("wardId").getAsInt());
            addressDTO.setAddress(data.get("addressDetail").getAsString());
            addressDTO.setIsDefault(data.get("isDefault").getAsBoolean());

            boolean success = addressService.updateAddress(addressDTO);

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Cập nhật địa chỉ thành công" : "Cập nhật địa chỉ thất bại");

            writeJson(response, responseMap);
        } catch (Exception e) {
            writeJson(response, Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void deleteAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int addressId = jsonObject.get("addressId").getAsInt();
            boolean success = addressService.deleteAddress(addressId, user.getId());

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Xóa địa chỉ thành công" : "Xóa địa chỉ thất bại");

            writeJson(response, responseMap);
        } catch (Exception e) {
            writeJson(response, Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void addAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonObject jsonObject) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            JsonObject data = jsonObject.get("data").getAsJsonObject();

            AddressDTO addressDTO = new AddressDTO();
            addressDTO.setUserId(user.getId());
            addressDTO.setFullname(data.get("fullname").getAsString());
            addressDTO.setPhone(data.get("phone").getAsString());
            addressDTO.setProvinceId(data.get("provinceId").getAsInt());
            addressDTO.setDistrictId(data.get("districtId").getAsInt());
            addressDTO.setWardId(data.get("wardId").getAsInt());
            addressDTO.setAddress(data.get("addressDetail").getAsString());
            addressDTO.setIsDefault(data.get("isDefault").getAsBoolean());

            boolean success = addressService.addAddress(addressDTO);

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Thêm địa chỉ thành công" : "Thêm địa chỉ thất bại");

            writeJson(response, responseMap);
        } catch (Exception e) {
            writeJson(response, Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    // Helper method để ghi JSON response
    private void writeJson(HttpServletResponse response, Object data) throws IOException {
        response.getWriter().write(GsonUtils.toJson(data));
    }

    @Override
    public void destroy() {
        super.destroy();
    }

}
