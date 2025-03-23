package com.drumstore.web.controllers.dashboard;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.annotation.WebServlet;

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
    protected void renderView(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);

        try {
            if (parts.length == 0) {
                // GET /users - Lấy danh sách tất cả người dùng (hiển thị trang index)
                index(request, response);
                renderView(request, response);
            } else if (parts.length == 1 && isNumeric(parts[0])) {
                // GET /users/5 - Lấy thông tin của một người dùng cụ thể (show user với ID = 5)
                show(request, response, parts[0]);
                renderView(request, response);
            } else if (parts.length == 1 && parts[0].equals("create")) {
                // GET /users/create - Hiển thị form tạo người dùng mới
                create(request, response);
                renderView(request, response);
            } else if (parts.length == 2 && isNumeric(parts[0]) && parts[1].equals("edit")) {
                // GET /users/5/edit - Hiển thị form chỉnh sửa người dùng với ID = 5
                edit(request, response, parts[0]);
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
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Trả về mã lỗi 404 nếu không tìm thấy route phù hợp
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Trả về mã lỗi 500 nếu có lỗi hệ thống
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);
        String methodOverride = request.getParameter("_method");

        try {
            if (methodOverride != null && methodOverride.equalsIgnoreCase("PUT")) {
                // Xử lý PUT request
                if (parts.length == 1 && isNumeric(parts[0])) {
                    // PUT /users/5 - Cập nhật người dùng với ID = 5
                    update(request, response, parts[0]);
                } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                    // PUT /users/5/posts/1 or /users/5/addresses/1 etc. - Cập nhật tài nguyên con với ID = 1 của người dùng với ID = 5
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    updateNested(request, response, parts[0], parts[2], resourceType);
                }
            } else if (methodOverride != null && methodOverride.equalsIgnoreCase("DELETE")) {
                // Xử lý DELETE request
                if (parts.length == 1 && isNumeric(parts[0])) {
                    // DELETE /users/5 - Xóa người dùng với ID = 5
                    delete(request, response, parts[0]);
                } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                    // DELETE /users/5/posts/1 or /users/5/addresses/1 etc. - Xóa tài nguyên con với ID = 1 của người dùng với ID = 5
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    deleteNested(request, response, parts[0], parts[2], resourceType);
                }
            } else {
                // Xử lý POST request thông thường
                if (parts.length == 0) {
                    // POST /users - Tạo mới người dùng
                    store(request, response);
                } else if (parts.length == 2 && isNumeric(parts[0])) {
                    // POST /users/5/posts or /users/5/addresses etc. - Tạo mới tài nguyên con (post hoặc address) cho người dùng với ID = 5
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    storeNested(request, response, parts[0], resourceType);
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Trả về mã lỗi 500 nếu có lỗi hệ thống
        }
    }
}
