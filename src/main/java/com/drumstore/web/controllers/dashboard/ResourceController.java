package com.drumstore.web.controllers.dashboard;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public abstract class ResourceController extends HttpServlet implements AbstractController, NestedController {
    protected String[] getPathParts(String pathInfo) {
        if (pathInfo == null) return new String[0];
        return pathInfo.substring(1).split("/");
    }

    protected boolean isNumeric(String str) {
        return str.matches("\\d+");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);

        try {
            if (parts.length == 0) {
                // GET /users
                index(request, response);
            } else if (parts.length == 1 && isNumeric(parts[0])) {
                // GET /users/5
                show(request, response, parts[0]);
            } else if (parts.length == 1 && parts[0].equals("create")) {
                // GET /users/create
                create(request, response);
            } else if (parts.length == 2 && isNumeric(parts[0]) && parts[1].equals("edit")) {
                // GET /users/5/edit
                edit(request, response, parts[0]);
            } else if (parts.length == 2 && isNumeric(parts[0])) {
                // GET /users/5/posts or /users/5/addresses etc.
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                indexNested(request, response, parts[0], resourceType);
            } else if (parts.length == 3 && isNumeric(parts[0]) && parts[2].equals("create")) {
                // GET /users/5/posts/create or /users/5/addresses/create etc.
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                createNested(request, response, parts[0], resourceType);
            } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                // GET /users/5/posts/1 or /users/5/addresses/1 etc.
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                showNested(request, response, parts[0], parts[2], resourceType);
            } else if (parts.length == 4 && isNumeric(parts[0]) && isNumeric(parts[2]) && parts[3].equals("edit")) {
                // GET /users/5/posts/1/edit or /users/5/addresses/1/edit etc.
                NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                editNested(request, response, parts[0], parts[2], resourceType);
            }
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String pathInfo = request.getPathInfo();
        String[] parts = getPathParts(pathInfo);
        String methodOverride = request.getParameter("_method");

        try {
            if (methodOverride != null && methodOverride.equalsIgnoreCase("PUT")) {
                // Xử lý như PUT request
                if (parts.length == 1 && isNumeric(parts[0])) {
                    update(request, response, parts[0]);
                } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    updateNested(request, response, parts[0], parts[2], resourceType);
                }
            } else if (methodOverride != null && methodOverride.equalsIgnoreCase("DELETE")) {
                // Xử lý như DELETE request
                if (parts.length == 1 && isNumeric(parts[0])) {
                    delete(request, response, parts[0]);
                } else if (parts.length == 3 && isNumeric(parts[0]) && isNumeric(parts[2])) {
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    deleteNested(request, response, parts[0], parts[2], resourceType);
                }
            } else {
                // Xử lý POST thông thường
                if (parts.length == 0) {
                    store(request, response);
                } else if (parts.length == 2 && isNumeric(parts[0])) {
                    NestedResourceType resourceType = NestedResourceType.fromPath(parts[1]);
                    storeNested(request, response, parts[0], resourceType);
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

}
