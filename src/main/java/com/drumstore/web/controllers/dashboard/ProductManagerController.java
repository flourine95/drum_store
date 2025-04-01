package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.constants.ProductConstants;
import com.drumstore.web.dto.ProductColorDTO;
import com.drumstore.web.dto.ProductEditDTO;
import com.drumstore.web.dto.ProductImageDTO;
import com.drumstore.web.dto.ProductVariantDTO;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@MultipartConfig
@WebServlet("/dashboard/products/*")
public class ProductManagerController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final BrandService brandService = new BrandService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Nếu action null hoặc rỗng thì chuyển về trang index
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

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = getIdParameter(request, response);
        if (id == null) return;

        request.setAttribute("title", "Chỉnh sửa sản phẩm");
        request.setAttribute("content", "products/edit.jsp");
        ProductEditDTO product = productService.findProductEdit(id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Thêm sản phẩm");
        request.setAttribute("content", "products/create.jsp");
        request.setAttribute("categories", categoryService.all());
        request.setAttribute("brands", brandService.all());
        request.setAttribute("stockManagementTypes", ProductConstants.StockManagementType.values());
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("title", "Quản lí sản phẩm");
        request.setAttribute("content", "products/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đọc action từ Part thay vì getParameter
        Part actionPart = request.getPart("action");
        String action = null;
        if (actionPart != null) {
            action = new String(actionPart.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        }

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

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = getIdParameter(request, response);
        if (id == null) return;

//        productService.delete(id);
        response.sendRedirect(request.getContextPath() + "/dashboard/products");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = getIdParameter(request, response);
        if (id == null) return;

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String image = request.getParameter("image");
    }

    private void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            // Đọc thông tin cơ bản của sản phẩm
//            String name = new String(request.getPart("name").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//            String description = new String(request.getPart("description").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//            double basePrice = Double.parseDouble(new String(request.getPart("basePrice").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//            int categoryId = Integer.parseInt(new String(request.getPart("categoryId").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//            int brandId = Integer.parseInt(new String(request.getPart("brandId").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//            String stockManagementType = new String(request.getPart("stockManagementType").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//            boolean isFeatured = request.getPart("isFeatured") != null;
//
//            // Xử lý upload ảnh sản phẩm
//            List<ProductImageDTO> productImages = new ArrayList<>();
//            Collection<Part> imageParts = request.getParts();
//            for (Part part : imageParts) {
//                if (part.getName().equals("images") && part.getSize() > 0) {
//                    String fileName = UUID.randomUUID() + "_" + part.getSubmittedFileName();
//                    String uploadPath = getServletContext().getRealPath("/uploads/products/");
//                    File uploadDir = new File(uploadPath);
//                    if (!uploadDir.exists()) {
//                        if (!uploadDir.mkdirs()) {
//                            throw new IOException("Không thể tạo thư mục: " + uploadPath);
//                        }
//                    }
//
//                    part.write(uploadPath + File.separator + fileName);
//                    productImages.add(new ProductImageDTO("/uploads/products/" + fileName));
//                }
//            }
//
//            // Xử lý variants dựa trên stockManagementType
//            List<ProductVariantDTO> variants = new ArrayList<>();
//
//            switch (stockManagementType) {
//                case "0" ->{
//                    ProductVariantDTO variant = ProductVariantDTO.builder()
//                            .color(null) // không có màu sắc
//                            .addon(null) // không có phụ kiện
//                            .imageId(productImages.isEmpty() ? null : productImages.getFirst().getId())
//                            .build();
//                        variants.add(variant);
//                }
//                case "1" -> {
//                    int colorIndex = 0;
//                    while (request.getPart("colors[" + colorIndex + "].name") != null) {
//                        String colorName = new String(request.getPart("colors[" + colorIndex + "].name").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//                        double additionalPrice = Double.parseDouble(new String(request.getPart("colors[" + colorIndex + "].additionalPrice").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//                        int stock = Integer.parseInt(new String(request.getPart("colors[" + colorIndex + "].stock").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//                        String imageId = new String(request.getPart("colors[" + colorIndex + "].imageId").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//
//                        // Tạo màu sắc
//                        ProductColorDTO color = new ProductColorDTO(colorName, additionalPrice);
//
//                        // Tạo variant cho màu sắc
//                        ProductVariantDTO variant = ProductVariantDTO.builder()
//                                .color(color)
//                                .addon(null)
//                                .imageId(imageId.isEmpty() ? null : imageId)
//                                .stock(stock)
//                                .build();
//                        variants.add(variant);
//
//                        colorIndex++;
//                    }
//                }
//                case "2" -> {
//                    int addonIndex = 0;
//                    while (request.getPart("addons[" + addonIndex + "].name") != null) {
//                        String addonName = new String(request.getPart("addons[" + addonIndex + "].name").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//                        double additionalPrice = Double.parseDouble(new String(request.getPart("addons[" + addonIndex + "].additionalPrice").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//                        int stock = Integer.parseInt(new String(request.getPart("addons[" + addonIndex + "].stock").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//                        String imageId = new String(request.getPart("addons[" + addonIndex + "].imageId").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//
//                        // Tạo phụ kiện
//                        ProductAddonDTO addon = new ProductAddonDTO(addonName, additionalPrice);
//
//                        // Tạo variant cho phụ kiện
//                        variants.add(new ProductVariantDTO(
//                                null, // không có color
//                                addon, // addonId sẽ được set sau khi lưu addon
//                                imageId.isEmpty() ? null : imageId,
//                                stock
//                        ));
//
//                        addonIndex++;
//                    }
//                }
//                case "3" -> {
//                }
//                // Xử lý tương tự, kết hợp cả color và addon
//                // Tạo variant cho mỗi combination của color và addon
//            }
//
//            // Tạo DTO và lưu vào database
//            ProductCreateDTO productDTO = ProductCreateDTO.builder()
//                .name(name)
//                .description(description)
//                .basePrice(basePrice)
//                .categoryId(categoryId)
//                .brandId(brandId)
//                .stockManagementType(Integer.parseInt(stockManagementType))
//                .isFeatured(isFeatured)
//                .images(productImages)
//                .variants(variants)
//                .build();
//
//            productService.create(productDTO);
//
//            response.sendRedirect(request.getContextPath() + "/dashboard/products");
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Có lỗi xảy ra khi tạo sản phẩm: " + e.getMessage());
//        }
    }

    private Integer getIdParameter(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            return Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
            return null;
        }
    }

}
