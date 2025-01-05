package com.drumstore.web.controllers.dashboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public interface NestedController {
    void indexNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType);

    void showNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType);

    void createNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType);

    void storeNested(HttpServletRequest request, HttpServletResponse response, String parentId, NestedResourceType resourceType);

    void editNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException;

    void updateNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType) throws ServletException, IOException;

    void deleteNested(HttpServletRequest request, HttpServletResponse response, String parentId, String id, NestedResourceType resourceType);
}
