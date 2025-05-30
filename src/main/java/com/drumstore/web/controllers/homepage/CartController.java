package com.drumstore.web.controllers.homepage;

import com.drumstore.web.dto.CartItemDTO;
import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.models.CartContext;
import com.drumstore.web.models.CartItem;
import com.drumstore.web.services.CartService;
import com.drumstore.web.services.PaymentService;
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
import java.util.Optional;
import java.util.OptionalLong;

@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private ProductService productService;
    private Gson gson;
    private PaymentService paymentService;
    private final CartService cartService = new CartService();

    @Override
    public void init() throws ServletException {
        this.productService = new ProductService();
        this.gson = new Gson();
        this.paymentService = new PaymentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("login");
            return;
        }

        CartContext cart = (CartContext) session.getAttribute("cart");
        if (cart == null) {
            cart = cartService.getCartContext(user.getId());
            session.setAttribute("cart", cart);
        }

        // chỉ dùng khi sử dụng thanh toán
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        if (vnp_ResponseCode != null) {
            if (vnp_ResponseCode.equals("00")) {
                String transactionId = request.getParameter("vnp_TransactionNo");

                int orderId = Optional.ofNullable(request.getSession().getAttribute("orderId"))
                        .map(Object::toString)
                        .map(Integer::parseInt)
                        .orElse(0);
                if(orderId != 0){
                    // cập nhật lại payment của khách hàng
                    paymentService.updatePayment(orderId,transactionId);
                    request.setAttribute("vnp_TransactionStatus", true);
                    request.setAttribute("orderId", orderId);
                    request.setAttribute("transactionId",transactionId);
                }
            }

        }


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
            UserDTO user = (UserDTO) session.getAttribute("user");

            if(user == null){
                response.sendRedirect("login");
                return;
            }

            CartContext cart = (CartContext) session.getAttribute("cart");
            if (cart == null) {
                session.setAttribute("cart", cartService.getCartContext(user.getId()));
            }

            Map<String, Object> result = new HashMap<>();
            switch (action) {
                case "add" -> {
                    int productVariantId = Integer.parseInt(request.getParameter("variantId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
//                    int productId = Integer.parseInt(request.getParameter("productId"));
                    boolean isAdd = cartService.addItem(productVariantId ,quantity, cart.getCartId() );
                    if (isAdd) {
                        cart = cartService.getCartContext(user.getId());
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
                    int cartItemId = Integer.parseInt(request.getParameter("cartId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartService.updateQuantity(cartItemId, quantity);
                    cart = cartService.getCartContext(user.getId());
                    result.put("success", true);
                    result.put("price",cart.getPriceItem(cartItemId));
                    result.put("cartCount", cart.getItemCount());
                    result.put("discount", cart.getDiscountTotal());
                    result.put("total", cart.getTotal());
                }

                case "change-variant" -> {
                    int cartItemId = Integer.parseInt(request.getParameter("cartId"));
                    int productId = Integer.parseInt(request.getParameter("productId"));
                    int addonId = Integer.parseInt(request.getParameter("addonId"));
                    int colorId = Integer.parseInt(request.getParameter("colorId"));
                    CartItemDTO  cartItemDTO = productService.findProductWithVariantForCartItem(colorId, addonId, productId);
                    if(cartItemDTO != null){
                        cartService.changeVariant(cartItemId, cartItemDTO.getProductVariant().getId());
                        cart = cartService.getCartContext(user.getId());

                        result.put("success", true);
                        result.put("item", cart.getCartItem(cartItemId));
                        result.put("price",cart.getPriceItem(cartItemId));
                        result.put("discount", cart.getDiscountTotal());
                        result.put("total", cart.getTotal());
                        result.put("totalQuantity", cart.getItemCount());
                    }else {
                        result.put("success", false);
                        result.put("message", "Lỗi");
                    }

                }

                case "remove" -> {
                    int cartItemId = Integer.parseInt(request.getParameter("cartId"));
                    cartService.removeItem(cartItemId);
                    cart = cartService.getCartContext(user.getId());
                    result.put("success", true);
                    result.put("cartCount", cart.getItemCount());
                    result.put("discount", cart.getDiscountTotal());
                    result.put("total", cart.getTotal());
                }
                case null, default -> {
                    result.put("success", false);
                    result.put("message", "Invalid action");
                }
            }

            session.setAttribute("cart", cartService.getCartContext(user.getId()));

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

