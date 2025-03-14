package com.drumstore.web.controllers;

import com.drumstore.web.dto.ProductDetailDTO2;
import com.drumstore.web.repositories.ProductRepository;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/json/*")
public class JsonController extends HttpServlet {
    private static final Gson gson = new GsonBuilder()
            .setPrettyPrinting()
            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
            .create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy ID từ URL
        String pathInfo = req.getPathInfo();
        int productId = Integer.parseInt(pathInfo.substring(1));
        ProductRepository productRepository = new ProductRepository();

        // Lấy product detail
        ProductDetailDTO2 product = productRepository.findProductDetail(productId);
        System.out.println(product);
        // Cấu hình response
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        // Convert to JSON và ghi response
        resp.getWriter().write(gson.toJson(product));
    }

    private static class LocalDateTimeAdapter extends TypeAdapter<LocalDateTime> {
        private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        @Override
        public void write(JsonWriter out, LocalDateTime value) throws IOException {
            if (value == null) {
                out.nullValue();
            } else {
                out.value(formatter.format(value));
            }
        }

        @Override
        public LocalDateTime read(JsonReader in) throws IOException {
            String dateStr = in.nextString();
            return dateStr == null ? null : LocalDateTime.parse(dateStr, formatter);
        }
    }
}
