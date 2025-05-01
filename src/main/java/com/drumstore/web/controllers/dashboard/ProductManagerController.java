package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.constants.ProductConstants;
import com.drumstore.web.dto.*;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.services.ProductService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard/products/*")
public class ProductManagerController extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final BrandService brandService = new BrandService();
    private final CategoryService categoryService = new CategoryService();

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

    private void edit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = getIdParameter(request, response);

        if (id == null) return;
        ProductEditDTO product = productService.findProductEdit(id);

        request.setAttribute("title", "Chỉnh sửa sản phẩm");
        request.setAttribute("content", "products/edit.jsp");
        request.setAttribute("product", product);
        request.setAttribute("stockManagementTypes", ProductConstants.StockManagementType.values());
        request.setAttribute("categories", categoryService.all());
        request.setAttribute("brands", brandService.all());
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


    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer id = getIdParameter(request, response);
        if (id == null) return;

//        productService.delete(id);
        response.sendRedirect(request.getContextPath() + "/dashboard/products");
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            Integer id = getIdParameter(request, response);
            if (id == null) return;

            String updateType = request.getParameter("updateType");
            System.out.println("updateType: " + updateType + " id: " + id);
            switch (updateType) {
                case "basic-info" -> updateBasicInfo(request, response, id);
                case "images" -> updateImages(request, response, id);
                case "colors" -> updateColors(request, response, id);
                case "addons" -> updateAddons(request, response, id);
                case "variants" -> updateVariants(request, response, id);
                default -> throw new IllegalArgumentException("Invalid update type: " + updateType);
            }

        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    private void updateVariants(HttpServletRequest request, HttpServletResponse response, Integer id) throws IOException {
        try {
            String[] variantIds = request.getParameterValues("variantIds[]");
            String[] colorIds = request.getParameterValues("variantColorIds[]");
            String[] addonIds = request.getParameterValues("variantAddonIds[]");
            String[] imageIds = request.getParameterValues("variantImageIds[]");
            String[] stocks = request.getParameterValues("variantStocks[]");
            String[] statuses = request.getParameterValues("variantStatuses[]");

            List<ProductVariantDTO> variants = new ArrayList<>();
            List<Integer> currentVariantIds = new ArrayList<>();

            if (stocks != null) {
                for (int i = 0; i < stocks.length; i++) {
                    Integer variantId = variantIds != null && variantIds[i] != null && !variantIds[i].isEmpty()
                            ? Integer.parseInt(variantIds[i]) : null;

                    if (variantId != null) {
                        currentVariantIds.add(variantId);
                    }

                    variants.add(ProductVariantDTO.builder()
                            .id(variantId)
                            .productId(id)
                            .colorId(colorIds != null && colorIds[i] != null && !colorIds[i].isEmpty()
                                    ? Integer.parseInt(colorIds[i]) : null)
                            .addonId(addonIds != null && addonIds[i] != null && !addonIds[i].isEmpty()
                                    ? Integer.parseInt(addonIds[i]) : null)
                            .imageId(imageIds != null && imageIds[i] != null && !imageIds[i].isEmpty()
                                    ? Integer.parseInt(imageIds[i]) : null)
                            .stock(Integer.parseInt(stocks[i]))
                            .status(Integer.parseInt(statuses[i]))
                            .build());
                }
            }
            variants.forEach(System.out::println);
            productService.syncVariants(id, variants, currentVariantIds);

            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật biến thể thành công\"}");
        } catch (Exception e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }

    private void updateAddons(HttpServletRequest request, HttpServletResponse response, Integer productId) throws IOException {
        try {
            String[] addonNames = request.getParameterValues("addonNames[]");
            String[] addonPrices = request.getParameterValues("addonPrices[]");
            String[] addonIds = request.getParameterValues("addonIds[]");

            List<ProductAddonDTO> addons = new ArrayList<>();
            List<Integer> currentAddonIds = new ArrayList<>();

            if (addonNames != null) {
                for (int i = 0; i < addonNames.length; i++) {
                    Integer addonId = (addonIds != null && addonIds[i] != null && !addonIds[i].isEmpty())
                            ? Integer.parseInt(addonIds[i]) : null;

                    if (addonId != null) {
                        currentAddonIds.add(addonId);
                    }

                    addons.add(ProductAddonDTO.builder()
                            .id(addonId)
                            .productId(productId)
                            .name(addonNames[i])
                            .additionalPrice(Double.parseDouble(addonPrices[i]))
                            .build());
                }
            }

            productService.syncAddons(productId, addons, currentAddonIds);

            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật phụ kiện thành công\"}");
        } catch (Exception e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }

    private void updateColors(HttpServletRequest request, HttpServletResponse response, Integer productId) throws IOException {
        try {
            String[] colorNames = request.getParameterValues("colorNames[]");
            String[] colorPrices = request.getParameterValues("colorPrices[]");
            String[] colorIds = request.getParameterValues("colorIds[]");

            List<ProductColorDTO> colors = new ArrayList<>();
            List<Integer> currentColorIds = new ArrayList<>();

            if (colorNames != null) {
                for (int i = 0; i < colorNames.length; i++) {
                    Integer colorId = (colorIds != null && colorIds[i] != null && !colorIds[i].isEmpty())
                            ? Integer.parseInt(colorIds[i]) : null;

                    if (colorId != null) {
                        currentColorIds.add(colorId);
                    }

                    colors.add(ProductColorDTO.builder()
                            .id(colorId)
                            .productId(productId)
                            .name(colorNames[i])
                            .additionalPrice(Double.parseDouble(colorPrices[i]))
                            .build());
                }
            }

            productService.syncColors(productId, colors, currentColorIds);

            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật màu sắc thành công\"}");
        } catch (Exception e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }


    private void updateImages(HttpServletRequest request, HttpServletResponse response, Integer id) throws IOException {

        try {
            StringBuilder requestBody = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    requestBody.append(line);
                }
            }
            System.out.println(requestBody);
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(requestBody.toString());
            List<Map<String, Object>> images = mapper.convertValue(rootNode.get("images"), new TypeReference<>() {
            });

            if (images == null || images.isEmpty()) {
                throw new IllegalArgumentException("No image data provided");
            }

            List<ProductImageDTO> existingImages = productService.getProductImages(id);
            List<Integer> existingIds = existingImages.stream()
                    .map(ProductImageDTO::getId)
                    .toList();

            List<Integer> keepIds = new ArrayList<>();

            for (int i = 0; i < images.size(); i++) {
                Map<String, Object> imageData = images.get(i);
                String imageId = String.valueOf(imageData.get("id"));
                String image = String.valueOf(imageData.get("image"));
                boolean main = Boolean.TRUE.equals(imageData.get("main"));
                int sortOrder = Integer.parseInt(String.valueOf(imageData.get("sortOrder")));

                ProductImageDTO imageDTO = ProductImageDTO.builder()
                        .productId(id)
                        .image(image)
                        .sortOrder(sortOrder)
                        .main(main)
                        .build();

                if (imageId.startsWith("new_")) {
                    productService.addImage(imageDTO);
                } else {
                    try {
                        int numericId = Integer.parseInt(imageId);
                        keepIds.add(numericId);
                        imageDTO.setId(numericId);
                        productService.updateImage(imageDTO);
                    } catch (NumberFormatException ignored) {
                    }
                }
            }

            existingIds.stream()
                    .filter(existingId -> !keepIds.contains(existingId))
                    .forEach(productService::deleteImage);

            response.getWriter().write("{\"success\":true,\"message\":\"Images updated successfully\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    private void updateBasicInfo(HttpServletRequest request, HttpServletResponse response, Integer id) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int stockManagementType = Integer.parseInt(request.getParameter("stockManagementType"));
            boolean isFeatured = request.getParameter("isFeatured") != null;

            ProductEditDTO productEditDTO = ProductEditDTO.builder()
                    .id(id)
                    .name(name)
                    .description(description)
                    .basePrice(basePrice)
                    .categoryId(categoryId)
                    .brandId(brandId)
                    .stockManagementType(stockManagementType)
                    .featured(isFeatured)
                    .build();
            System.out.println(productEditDTO);
            productService.update(productEditDTO);
            response.getWriter().write("{\"success\": true, \"message\": \"Cập nhật sản phẩm thành công\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
    }


    private void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get basic product info
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int stockManagementType = Integer.parseInt(request.getParameter("stockManagementType"));
            boolean isFeatured = request.getParameter("isFeatured") != null;

            // Create product DTO
            ProductCreateDTO productCreateDTO = ProductCreateDTO.builder()
                    .name(name)
                    .description(description)
                    .basePrice(basePrice)
                    .categoryId(categoryId)
                    .brandId(brandId)
                    .stockManagementType(stockManagementType)
                    .featured(isFeatured)
                    .build();

            // Create product and get ID
            int productId = productService.create(productCreateDTO);

            // Redirect to product detail page for adding colors, addons, and variants
            response.sendRedirect(request.getContextPath() + "/dashboard/products?action=edit&id=" + productId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            create(request, response);
        }
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
