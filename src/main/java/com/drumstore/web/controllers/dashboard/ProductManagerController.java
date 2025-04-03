package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.constants.ProductConstants;
import com.drumstore.web.dto.*;
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
import java.util.Map;
import java.util.HashMap;

@WebServlet("/dashboard/products/*")
@MultipartConfig(
        fileSizeThreshold   = 1024 * 1024,
        maxFileSize         = 1024 * 1024 * 10,
        maxRequestSize      = 1024 * 1024 * 15
)
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
//        for (Part part : request.getParts()) {
//            System.out.println("Part Name: " + part.getName()); // Tên field trong form
//
//            // Nếu là file
//            if (part.getSubmittedFileName() != null) {
//                System.out.println("File Name: " + part.getSubmittedFileName());
//                System.out.println("File Size: " + part.getSize() + " bytes");
//            } else {
//                // Nếu là input text
//                String value = new String(part.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//                System.out.println("Value: " + value);
//            }
//        }
//        // Get basic product info
//        String name = new String(request.getPart("name").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//        String description = new String(request.getPart("description").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//        double basePrice = Double.parseDouble(new String(request.getPart("basePrice").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//        int categoryId = Integer.parseInt(new String(request.getPart("categoryId").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//        int brandId = Integer.parseInt(new String(request.getPart("brandId").getInputStream().readAllBytes(), StandardCharsets.UTF_8));
//        String stockManagementType = new String(request.getPart("stockManagementType").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//        boolean isFeatured = request.getPart("isFeatured") != null;
//        String mainImageId = new String(request.getPart("mainImageId").getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//
//        // Create product DTO
//        ProductCreateDTO productCreateDTO = ProductCreateDTO.builder()
//                .name(name)
//                .description(description)
//                .basePrice(basePrice)
//                .categoryId(categoryId)
//                .brandId(brandId)
//                .stockManagementType(Integer.parseInt(stockManagementType))
//                .featured(isFeatured)
//                .build();
//
//        // Create product and get ID
//        int productId = productService.create(productCreateDTO);
//
//        // Handle image uploads
//        String uploadPath = getServletContext().getRealPath("/uploads/products/");
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            if (!uploadDir.mkdirs()) {
//                throw new IOException("Không thể tạo thư mục: " + uploadPath);
//            }
//        }
//
//        // Get image order from form
//        List<String> imageOrder = new ArrayList<>();
//        for (Part part : request.getParts()) {
//            if (part.getName().equals("imageOrder[]")) {
//                String value = new String(part.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
//                imageOrder.add(value);
//            }
//        }
//
//        System.out.println("Image Order: " + imageOrder);
//        // Process each image
//        Map<String, String> imageFileMap = new HashMap<>();
//        for (Part part : request.getParts()) {
//            if (part.getName().equals("images") && part.getSize() > 0) {
//                String fileName = part.getSubmittedFileName();
//                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
//                part.write(uploadPath + File.separator + uniqueFileName);
//                imageFileMap.put(fileName, uniqueFileName);
//            }
//        }
//        System.out.println("Image File Map: " + imageFileMap);
//        // Create product images with correct order
//        for (int i = 0; i < imageOrder.size(); i++) {
//            String imageId = imageOrder.get(i);
//            String fileName = imageFileMap.get(imageId);
//            if (fileName != null) {
//                ProductImageDTO productImageDTO = ProductImageDTO.builder()
//                        .image(fileName)
//                        .main(mainImageId.equals(imageId))
//                        .sortOrder(i)
//                        .build();
//                productService.createImage(productId, productImageDTO);
//            }
//        }
//
//        // Handle variants based on stock management type
//        List<ProductVariantDTO> variants = new ArrayList<>();
//        response.sendRedirect(request.getContextPath() + "/dashboard/products");
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
