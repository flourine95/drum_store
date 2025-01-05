package com.drumstore.web.controllers.dashboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public interface AbstractController {
    void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;

    void show(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException;

    void create(HttpServletRequest request, HttpServletResponse response);

    void store(HttpServletRequest request, HttpServletResponse response);

    void edit(HttpServletRequest request, HttpServletResponse response, String id) throws ServletException, IOException;

    void update(HttpServletRequest request, HttpServletResponse response, String id);

    void delete(HttpServletRequest request, HttpServletResponse response, String id);
}
