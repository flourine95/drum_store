package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.CartItemDTO;
import com.drumstore.web.models.Cart;
import com.drumstore.web.models.CartItem;
import com.drumstore.web.services.ProductService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private ProductService productService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.productService = new ProductService();
        this.gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        System.out.println(cart);
        request.setAttribute("cart", cart);
        request.setAttribute("title", "Giỏ hàng");
        request.setAttribute("content", "cart.jsp");
        request.getRequestDispatcher("/pages/homepage/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            Map<String, Object> result = new HashMap<>();
            switch (action) {
                case "add" -> {
                    int productVariantId = Integer.parseInt(request.getParameter("variantId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    CartItemDTO product = productService.findProductForCartItem(productVariantId, productId);
                    if (product != null) {
                        cart.addItem(product, quantity);
                        result.put("success", true);
                        result.put("message", "Đã thêm vào giỏ hàng");
                        result.put("cartCount", cart.getItemCount());
                        result.put("total", cart.getTotal());
                    } else {
                        result.put("success", false);
                        result.put("message", "Không tìm thấy sản phẩm");
                    }
                }
                case "update" -> {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    double price = cart.updateQuantity(cartId, quantity);
                    result.put("success", true);
                    result.put("price", price);
                    result.put("cartCount", cart.getItemCount());
                    result.put("total", cart.getTotal());
                }

                case "change-variant" -> {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int addonId = Integer.parseInt(request.getParameter("addonId"));
                    int colorId = Integer.parseInt(request.getParameter("colorId"));
                    CartItemDTO  cartItemDTO = productService.findProductWithVariantForCartItem(colorId, addonId, productId);
                    if(cartItemDTO != null){
                        CartItem cartItem  = cart.changeVariant(cartId,cartItemDTO);
                        result.put("success", true);
                        result.put("item", cartItem);
                        result.put("price", cartItem.getTotal());
                        result.put("total", cart.getTotal());
                    }else {
                        result.put("success", false);
                        result.put("message", "Lỗi");
                    }

                }

                case "remove" -> {
                    int cartId = Integer.parseInt(request.getParameter("cartId"));
                    cart.removeItem(cartId);
                    result.put("success", true);
                    result.put("cartCount", cart.getItemCount());
                    result.put("total", cart.getTotal());
                }
                case null, default -> {
                    result.put("success", false);
                    result.put("message", "Invalid action");
                }
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", e.getMessage());
            System.out.println(e.getMessage());

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(error));
        }
    }
}

