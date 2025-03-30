package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.annotations.RequirePermission;
import com.drumstore.web.constants.ProductConstants;
import com.drumstore.web.dto.ProductCreateDTO;
import com.drumstore.web.dto.ProductDashboardDetailDTO;
import com.drumstore.web.dto.ProductDashboardDTO;
import com.drumstore.web.dto.ProductImageDTO;
import com.drumstore.web.models.Product;
import com.drumstore.web.models.ProductImage;
import com.drumstore.web.services.BrandService;
import com.drumstore.web.services.CategoryService;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard/products/*")
public class ProductManagerController extends ResourceController {
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();
    private final BrandService brandService = new BrandService();


    @RequirePermission
    @Override
    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProductDashboardDTO> products = productService.all();
        setPageTitle("Quản lý sản phẩm");
        setViewData(products);
    }

    @Override
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        ProductDashboardDetailDTO product = productService.find(Integer.parseInt(id));
        setPageTitle("Chi tiết sản phẩm");
        setViewPath("products/show.jsp");
        addViewAttribute("product", product);
    }

    @Override
    public void create(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        setPageTitle("Thêm sản phẩm");
        setViewPath("products/create.jsp");
        addViewAttribute("stockManagementTypes", ProductConstants.StockManagementType.values());
        addViewAttribute("categories", categoryService.all());
        addViewAttribute("brands", brandService.all());
    }

    @Override
    public void store(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String[]> parameters = request.getParameterMap();
        for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
            String paramName = entry.getKey();
            String[] paramValues = entry.getValue();
            System.out.println("Parameter Name: " + paramName);
            System.out.println("Parameter Values: " + Arrays.toString(paramValues));
        }
//        try {
//            // 1. Lấy thông tin cơ bản của sản phẩm
//            String name = request.getParameter("name");
//            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
//            String description = request.getParameter("description");
//            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
//            int brandId = Integer.parseInt(request.getParameter("brandId"));
//            int stockManagementType = Integer.parseInt(request.getParameter("stockManagementType"));
//            boolean isFeatured = request.getParameter("isFeatured") != null;
//
//            // 2. Tạo đối tượng Product
//            ProductCreateDTO productCreateDTO = new ProductCreateDTO();
//            productCreateDTO.setName(name);
//            productCreateDTO.setBasePrice(basePrice);
//            productCreateDTO.setDescription(description);
//            productCreateDTO.setCategoryId(categoryId);
//            productCreateDTO.setBrandId(brandId);
//            productCreateDTO.setStockManagementType(stockManagementType);
//            productCreateDTO.setIsFeatured(isFeatured);
//
//            // 3. Lưu sản phẩm và lấy ID
//            int productId = productService.create(productCreateDTO);
//
//            // 4. Xử lý upload ảnh
//            Part[] imageParts = request.getParts().stream()
//                    .filter(part -> "images".equals(part.getName()))
//                    .toArray(Part[]::new);
//
//            String[] imageOrder = request.getParameterValues("imageOrder[]");
//            if (imageParts != null && imageParts.length > 0) {
//                for (int i = 0; i < imageParts.length; i++) {
//                    Part imagePart = imageParts[i];
//                    if (imagePart.getSize() > 0) {
//                        // Lưu file và lấy đường dẫn
//                        String fileName = saveImage(imagePart);
//
//                        // Tạo bản ghi product_images
//                        ProductImageDTO productImage = new ProductImageDTO();
//                        productImage.setProductId(productId);
//                        productImage.setImage(fileName);
//                        productImage.setMain(i == 0); // Ảnh đầu tiên là ảnh chính
//                        productImage.setSortOrder(i);
//                        productImageService.create(productImage);
//                    }
//                }
//            }
//
//            // 5. Xử lý màu sắc (nếu có)
//            if (stockManagementType == 1 || stockManagementType == 3) { // COLOR_ONLY hoặc COLOR_AND_ADDON
//                String[] colorNames = request.getParameterValues("colors[].name");
//                String[] colorPrices = request.getParameterValues("colors[].additionalPrice");
//                String[] colorImageIds = request.getParameterValues("colors[].imageId");
//
//                if (colorNames != null) {
//                    for (int i = 0; i < colorNames.length; i++) {
//                        if (!colorNames[i].isEmpty()) {
//                            ProductColor color = new ProductColor();
//                            color.setProductId(productId);
//                            color.setName(colorNames[i]);
//                            color.setAdditionalPrice(new BigDecimal(colorPrices[i]));
//                            // Xử lý imageId nếu có
//                            if (colorImageIds != null && colorImageIds[i] != null && !colorImageIds[i].isEmpty()) {
//                                color.setImageId(Integer.parseInt(colorImageIds[i]));
//                            }
//                            productColorService.create(color);
//                        }
//                    }
//                }
//            }
//
//            // 6. Xử lý phụ kiện (nếu có)
//            if (stockManagementType == 2 || stockManagementType == 3) { // ADDON_ONLY hoặc COLOR_AND_ADDON
//                String[] addonNames = request.getParameterValues("addons[].name");
//                String[] addonPrices = request.getParameterValues("addons[].additionalPrice");
//                String[] addonImageIds = request.getParameterValues("addons[].imageId");
//
//                if (addonNames != null) {
//                    for (int i = 0; i < addonNames.length; i++) {
//                        if (!addonNames[i].isEmpty()) {
//                            ProductAddon addon = new ProductAddon();
//                            addon.setProductId(productId);
//                            addon.setName(addonNames[i]);
//                            addon.setAdditionalPrice(new BigDecimal(addonPrices[i]));
//                            // Xử lý imageId nếu có
//                            if (addonImageIds != null && addonImageIds[i] != null && !addonImageIds[i].isEmpty()) {
//                                addon.setImageId(Integer.parseInt(addonImageIds[i]));
//                            }
//                            productAddonService.create(addon);
//                        }
//                    }
//                }
//            }
//
//            // 7. Chuyển hướng sau khi lưu thành công
//            response.sendRedirect(request.getContextPath() + "/dashboard/products?message=created");
//
//        } catch (Exception e) {
//            request.setAttribute("error", "Có lỗi xảy ra khi tạo sản phẩm: " + e.getMessage());
//            request.getRequestDispatcher("/pages/dashboard/products/create.jsp").forward(request, response);
//        }
    }

    // Hàm hỗ trợ lưu file ảnh
    private String saveImage(Part part) throws IOException {
        String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/uploads/products");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        part.write(uploadPath + File.separator + fileName);
        return "uploads/products/" + fileName;
    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {

    }

    @Override
    public void indexNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void showNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }
}