package com.drumstore.web.api;

import com.drumstore.web.dto.ProductDashboardDTO;
import com.drumstore.web.dto.ProductEditDTO;
import com.drumstore.web.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/products/*")
public class ProductApiController extends BaseApiController {
    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                List<ProductDashboardDTO> products = productService.all();
                sendResponse(response, products);
            } else if (pathInfo.equals("/options")) {
                getProductOptions(request, response);
            } else {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
            }
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    private void getProductOptions(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productId = getRequiredIntParam(request, "productId");
            
            ProductEditDTO product = productService.findProductEdit(productId);
            if (product == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            
            Map<String, Object> result = new HashMap<>();
            result.put("colors", product.getColors());
            result.put("addons", product.getAddons());
            result.put("images", product.getImages());
            
            sendResponse(response, result);
        } catch (IllegalArgumentException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
