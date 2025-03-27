package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.AddressDTO;
import com.drumstore.web.dto.ProductDetailDTO;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.User;
import com.drumstore.web.services.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
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
    private UserAddressService userAddressService;
    private WishlistService wishlistService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.addressService = new AddressService();
        this.wishlistService = new WishlistService();
        this.orderService = new OrderService();
        this.userAddressService = new UserAddressService();
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

        ObjectMapper mapper = new ObjectMapper();
        try {
            // Đọc JSON từ request body
            JsonNode jsonNode = mapper.readTree(request.getReader());
            String action = jsonNode.get("action").asText();

            switch (action) {
                // Cập nhật thông tin tài khoản
                case "update-account" -> updateAccount(request, response, user, jsonNode);
                // quán lí address
                case "get_address" -> getAddress(request, response, user, jsonNode);
                case "add_address" -> addAddress(request, response, user, jsonNode);
                case "delete_address" -> deleteAddress(request, response, user, jsonNode);
                case "update_address" -> updateAddress(request, response, user, jsonNode);
                case "count_user_address" -> {
                    Map<String, Object> resp = new HashMap<>();
                    int count  = userAddressService.isExitsUserAddress(user.getId());
                    if(count > 0) {
                        resp.put("status", true);
                    }else {
                        resp.put("status", false);
                    }
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                     mapper.writeValue(response.getWriter(), resp);
                }
                // quản lí wishList
                case "toggle-wishList" -> toogleWishtList(request, response, user, jsonNode);

                default -> response.sendRedirect(request.getContextPath() + "/profile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void toogleWishtList(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> resp = new HashMap<>();

        try {
            int productId = jsonNode.get("data").asInt();
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

        mapper.writeValue(response.getWriter(), resp);
    }




    private void updateAccount(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        try {
            String fullName = jsonNode.get("data").get("fullName").asText();
            String phone = jsonNode.get("data").get("phone").asText();

            user.setFullname(fullName);
            user.setPhone(phone);
            // cap nhat thong tin
            boolean success = userService.update(user) != 0;

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Cập nhật tài khoản thành công" : "Cập nhật tài khoản thất bại");
            mapper.writeValue(response.getWriter(), responseMap);
        } catch (Exception e) {
            e.printStackTrace();
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void getAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();
        try {
            // Đọc addressId từ JSON data thay vì parameter
            int addressId = jsonNode.get("data").get("addressId").asInt();
            AddressDTO address = addressService.getAddressById(addressId);

            if (address != null && address.getUserId() == user.getId()) {
                mapper.writeValue(response.getWriter(), address);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                mapper.writeValue(response.getWriter(), Map.of(
                        "success", false,
                        "message", "Không tìm thấy địa chỉ"
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void updateAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode data = jsonNode.get("data");

            AddressDTO addressDTO = new AddressDTO();
            addressDTO.setId(data.get("id").asInt());
            addressDTO.setUserId(user.getId());
            addressDTO.setFullname(data.get("fullname").asText());
            addressDTO.setPhone(data.get("phone").asText());
            addressDTO.setProvinceId(data.get("provinceId").asInt());
            addressDTO.setDistrictId(data.get("districtId").asInt());
            addressDTO.setWardId(data.get("wardId").asInt());
            addressDTO.setAddress(data.get("addressDetail").asText());
            addressDTO.setIsDefault(data.get("isDefault").asBoolean());

            boolean success = addressService.updateAddress(addressDTO);

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Cập nhật địa chỉ thành công" : "Cập nhật địa chỉ thất bại");

            mapper.writeValue(response.getWriter(), responseMap);

        } catch (Exception e) {
            e.printStackTrace();
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void deleteAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        try {
            int addressId = jsonNode.get("addressId").asInt();
            boolean success = addressService.deleteAddress(addressId, user.getId());

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Xóa địa chỉ thành công" : "Xóa địa chỉ thất bại");

            mapper.writeValue(response.getWriter(), responseMap);

        } catch (Exception e) {
            e.printStackTrace();
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }

    private void addAddress(HttpServletRequest request, HttpServletResponse response, User user, JsonNode jsonNode) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode data = jsonNode.get("data");

            // Tạo AddressDTO từ JSON data
            AddressDTO addressDTO = new AddressDTO();
            addressDTO.setUserId(user.getId());
            addressDTO.setFullname(data.get("fullname").asText());
            addressDTO.setPhone(data.get("phone").asText());
            addressDTO.setProvinceId(data.get("provinceId").asInt());
            addressDTO.setDistrictId(data.get("districtId").asInt());
            addressDTO.setWardId(data.get("wardId").asInt());
            addressDTO.setAddress(data.get("addressDetail").asText());
            addressDTO.setIsDefault(data.get("isDefault").asBoolean());
            // Lưu địa chỉ mới
            boolean success = addressService.addAddress(addressDTO);

            // Trả về response
            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("success", success);
            responseMap.put("message", success ? "Thêm địa chỉ thành công" : "Thêm địa chỉ thất bại");

            mapper.writeValue(response.getWriter(), responseMap);

        } catch (Exception e) {
            e.printStackTrace();
            mapper.writeValue(response.getWriter(), Map.of(
                    "success", false,
                    "message", "Có lỗi xảy ra: " + e.getMessage()
            ));
        }
    }


    @Override
    public void destroy() {
        super.destroy();
    }

}
