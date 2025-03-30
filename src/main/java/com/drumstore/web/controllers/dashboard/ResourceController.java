package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.annotations.RequirePermission;
import com.drumstore.web.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public abstract class ResourceController extends HttpServlet implements AbstractController, NestedController {
    // Các thuộc tính để xử lý view
    protected String moduleName;          // Tên module (products, orders,...)
    protected String pageTitle;           // Tiêu đề trang
    protected String viewPath;            // Đường dẫn đến view
    protected Object viewData;            // Dữ liệu truyền vào view
    protected Map<String, Object> viewAttributes; // Các attribute khác

    public ResourceController() {
        this.moduleName = extractModuleNameFromAnnotation();
        this.viewAttributes = new HashMap<>();
    }

    // Tự động lấy module name từ WebServlet annotation
    private String extractModuleNameFromAnnotation() {
        WebServlet annotation = getClass().getAnnotation(WebServlet.class);
        if (annotation != null) {
            String[] urlPatterns = annotation.value();
            if (urlPatterns.length > 0) {
                String pattern = urlPatterns[0];
                // Tách "/dashboard/products/*" thành ["", "dashboard", "products", "*"]
                String[] parts = pattern.split("/");
                // Lấy phần tử thứ 3 (index 2) là "products"
                if (parts.length >= 3) {
                    return parts[2];
                }
            }
        }
        // Fallback to getModuleName() if annotation parsing fails
        return getModuleName();
    }

    // Method này giờ có thể là optional, chỉ dùng làm fallback
    protected String getModuleName() {
        return null; // Có thể override nếu cần
    }

    // Helper methods để set các thuộc tính
    protected void setPageTitle(String pageTitle) {
        this.pageTitle = pageTitle;
    }

    protected void setViewPath(String viewPath) {
        this.viewPath = viewPath;
    }

    protected void setViewData(Object data) {
        this.viewData = data;
    }

    protected void addViewAttribute(String key, Object value) {
        this.viewAttributes.put(key, value);
    }

    // Method để render view
    protected void renderView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set default view path nếu chưa được set
        if (viewPath == null) {
            viewPath = moduleName + "/index.jsp";
        }

        // Set các attributes vào request
        if (pageTitle != null) {
            request.setAttribute("pageTitle", pageTitle);
        }
        request.setAttribute("content", viewPath);

        if (viewData != null) {
            request.setAttribute(moduleName, viewData);
        }

        // Set các attribute khác
        for (Map.Entry<String, Object> entry : viewAttributes.entrySet()) {
            request.setAttribute(entry.getKey(), entry.getValue());
        }

        // Forward to layout
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);

        // Reset các thuộc tính sau khi render
        resetViewAttributes();
    }

    private void resetViewAttributes() {
        pageTitle = null;
        viewPath = null;
        viewData = null;
        viewAttributes.clear();
    }

    protected String[] getPathParts(String pathInfo) {
        if (pathInfo == null) return new String[0];
        return pathInfo.substring(1).split("/");
    }

    protected boolean isNumeric(String str) {
        return str.matches("\\d+");
    }

    protected boolean checkPermission(HttpServletRequest request, String permission) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        // Lấy user từ session
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) return false;

        // Kiểm tra quyền
        return user.hasPermission(permission);
    }

    protected void requirePermission(HttpServletRequest request, HttpServletResponse response, String permission) throws IOException {
        if (!checkPermission(request, permission)) {
            if (request.getSession(false) == null || request.getSession().getAttribute("user") == null) {
                // Chưa đăng nhập, chuyển đến trang login
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                // Đã đăng nhập nhưng không có quyền
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền truy cập");
            }
            throw new SecurityException("Không có quyền truy cập");
        }
    }

    protected void invokeAction(String methodName, HttpServletRequest request, HttpServletResponse response, Object... additionalArgs) 
            throws Exception {
        // Tạo mảng tham số với request và response là 2 tham số đầu tiên
        Object[] args = new Object[additionalArgs.length + 2];
        args[0] = request;
        args[1] = response;
        // Copy các tham số bổ sung nếu có
        if (additionalArgs.length > 0) {
            System.arraycopy(additionalArgs, 0, args, 2, additionalArgs.length);
        }

        // Tìm method cần gọi
        Method method = findMethod(methodName, args);
        if (method == null) {
            throw new IllegalArgumentException("Method not found: " + methodName);
        }

        // Kiểm tra permission từ annotation
        RequirePermission annotation = method.getAnnotation(RequirePermission.class);
        String action = "";

        if (annotation != null) {
            action = annotation.action().isEmpty() ? methodName : annotation.action();
        } else {
            action = methodName;
        }

        // Kiểm tra quyền
        String permission = String.format("%s:%s", moduleName, action);
        requirePermission(request, response, permission);

        // Gọi method với các tham số đã chuẩn bị
        method.invoke(this, args);
    }

    private Method findMethod(String methodName, Object[] args) {
        Method[] methods = getClass().getDeclaredMethods();
        for (Method method : methods) {
            if (method.getName().equals(methodName)) {
                Class<?>[] paramTypes = method.getParameterTypes();
                // Kiểm tra số lượng tham số
                if (paramTypes.length != args.length) {
                    continue;
                }
                // Kiểm tra kiểu tham số
                boolean match = true;
                for (int i = 0; i < paramTypes.length; i++) {
                    if (args[i] != null && !paramTypes[i].isAssignableFrom(args[i].getClass())) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    return method;
                }
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);
        System.out.println(Arrays.toString(parts));
        try {
            if (parts.length == 0) {
                invokeAction("index", request, response);
                renderView(request, response);
            } else if (parts.length == 1 && isNumeric(parts[0])) {
                invokeAction("show", request, response, parts[0]);
                renderView(request, response);
            } else if (parts.length == 1 && parts[0].equals("create")) {
                invokeAction("create", request, response);
                renderView(request, response);
            } else if (parts.length == 2 && isNumeric(parts[0]) && parts[1].equals("edit")) {
                invokeAction("edit", request, response, parts[0]);
                renderView(request, response);
            } else if (parts.length == 2 && isNumeric(parts[0])) {
                // GET /users/5/posts or /users/5/addresses etc. - Lấy thông tin các tài nguyên con của người dùng (posts hoặc addresses)
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                indexNested(request, response, parts[0], resourceType);
                renderView(request, response);
            } else if (parts.length == 3 && isNumeric(parts[0]) && parts[2].equals("create")) {
                // GET /users/5/posts/create or /users/5/addresses/create etc. - Hiển thị form tạo tài nguyên con (posts hoặc addresses) cho người dùng với ID = 5
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                createNested(request, response, parts[0], resourceType);
                renderView(request, response);
            } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                // GET /users/5/posts/1 or /users/5/addresses/1 etc. - Lấy thông tin tài nguyên con cụ thể (post hoặc address) với ID = 1 của người dùng với ID = 5
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                showNested(request, response, parts[0], parts[2], resourceType);
                renderView(request, response);
            } else if (parts.length == 4 && isNumeric(parts[0]) && isNumeric(parts[2]) && parts[3].equals("edit")) {
                // GET /users/5/posts/1/edit or /users/5/addresses/1/edit etc. - Hiển thị form chỉnh sửa tài nguyên con (post hoặc address) với ID = 1 của người dùng với ID = 5
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                editNested(request, response, parts[0], parts[2], resourceType);
                renderView(request, response);
            }
        } catch (Exception e) {
            handleException(response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);
        String action = request.getParameter("_action"); // Thêm parameter _action để xác định hành động

        try {
            if (action == null) {
                // POST mặc định - tạo mới
                invokeAction("store", request, response);
            } else {
                switch (action.toLowerCase()) {
                    case "update":
                        invokeAction("update", request, response, parts[0]);
                        break;

                    case "delete":
                        invokeAction("delete", request, response, parts[0]);
                        break;

                    default:
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                        break;
                }
            }
        } catch (Exception e) {
            handleException(response, e);
        }
    }

    private void handleException(HttpServletResponse response, Exception e) {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        e.printStackTrace();
    }
}
