package com.drumstore.web.controllers.dashboard;

import com.drumstore.web.models.Order;
import com.drumstore.web.models.User;
import com.drumstore.web.repositories.OrderRepository;
import com.drumstore.web.services.OrderService;
import com.drumstore.web.services.UserAddressService;
import com.drumstore.web.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/orders/*")

public class OrderController extends ResourceController {
    private OrderService orderService;

    @Override
    public void init() {
        this.orderService = new OrderService();
    }

    @Override
    // danh sach cac don hang

    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lay ra dnah sach tat ca don hang
        List<Order> orders = orderService.all();
        request.setAttribute("orders", orders );
        request.setAttribute("pageTitle", "Quản lý đơn hàng");
        request.setAttribute("content", "orders/index.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    // chi tiet don hang
    public void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
//        System.out.println(1);
        System.out.println(new OrderRepository().findWithDetails(Integer.parseInt(id)));
        Order order = orderService.find(Integer.parseInt(id));
        request.setAttribute("order",order);
        request.setAttribute("pageTitle", "Chi tiết đơn hàng");
        request.setAttribute("content", "orders/show.jsp");  // hoặc file jsp tương ứng
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);

    }

    @Override
    //them
    public void create(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    // luu
    public void store(HttpServletRequest request, HttpServletResponse response) {

    }

    @Override
    public void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException {
        request.setAttribute("pageTitle", "Chỉnh sửa đơn hàng");
        request.setAttribute("content", "orders/edit.jsp");
        request.getRequestDispatcher("/pages/dashboard/layout.jsp").forward(request, response);
    }

    @Override
    public void update(HttpServletRequest request, HttpServletResponse response, String id) {

    }

    @Override
    public void delete(HttpServletRequest request, HttpServletResponse response, String id) {

    }

    @Override
    //
    public void indexNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void showNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) {

    }

    @Override
    public void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType) {

    }

    @Override
    public void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException {

    }

    @Override
    public void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) {

    }

}
