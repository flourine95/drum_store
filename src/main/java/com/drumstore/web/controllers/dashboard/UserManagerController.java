package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.dto.BrandDTO;
import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.services.UserService;
import com.drumstore.web.utils.ParseHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/users/*")
public class UserManagerController extends HttpServlet {
    private static final String DASHBOARD_LAYOUT = "/pages/dashboard/layout.jsp";
    private static final String MODULE_PATH = "users/";
    private static final String BASE_URL = "/dashboard/users";

    private static final String TITLE_INDEX = "Danh sách người dùng";
    private static final String TITLE_CREATE = "Tạo mới người dùng";
    private static final String TITLE_EDIT = "Chỉnh sửa người dùng";

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }

        switch (action) {
            case "create" -> create(request, response);
            case "edit" -> edit(request, response);
            default -> index(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            index(request, response);
            return;
        }

        switch (action) {
            case "store" -> store(request, response);
            case "update" -> update(request, response);
            case "delete" -> delete(request, response);
            default -> index(request, response);
        }
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<UserDTO> users = userService.getAllUsers();

        request.setAttribute("users", users);
        request.setAttribute("title", TITLE_INDEX);
        request.setAttribute("content", MODULE_PATH + "index.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", TITLE_CREATE);
        request.setAttribute("content", MODULE_PATH + "create.jsp");
        request.getRequestDispatcher(DASHBOARD_LAYOUT).forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");


        try {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Tạo thương hiệu thành công\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi tạo thương hiệu: " + e.getMessage() + "\"}");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String brandId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String image = request.getParameter("image");

        if (brandId == null || brandId.isEmpty() || name == null || name.isEmpty() || image == null || image.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Thiếu thông tin cần thiết\"}");
            return;
        }

        try {
            Integer id = ParseHelper.tryParseInt(brandId);

            BrandDTO brand = BrandDTO.builder()
                    .id(id)
                    .name(name)
                    .description(description)
                    .image(image)
                    .build();

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật thương hiệu thành công\", \"redirectUrl\": \"" +
                    request.getContextPath() + BASE_URL + "\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID thương hiệu không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi cập nhật thương hiệu: " + e.getMessage() + "\"}");
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");



        try {
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"success\": true, \"message\": \"Xóa thương hiệu thành công\"}");
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"ID không hợp lệ\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi khi xóa thương hiệu: " + e.getMessage() + "\"}");
        }
    }
}
