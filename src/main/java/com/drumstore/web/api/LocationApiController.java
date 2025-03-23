package com.drumstore.web.api;

import com.drumstore.web.services.LocationService;
import com.drumstore.web.utils.GsonUtils;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/location")
public class LocationApiController extends HttpServlet {
    private final LocationService locationService = new LocationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        try {
            switch (action) {
                case "provinces" -> handleGetProvinces(response);
                case "districts" -> handleGetDistricts(request, response);
                case "wards" -> handleGetWards(request, response);
                case "full_location" -> handleGetFullLocation(request, response);
                default -> sendError(response, HttpServletResponse.SC_NOT_FOUND, "Action not found");
            }
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }

    private void handleGetFullLocation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int provinceId = getRequiredIntParam(request, "provinceId");
        int districtId = getRequiredIntParam(request, "districtId");

        Map<String, Object> fullLocation = new HashMap<>();
        fullLocation.put("provinces", locationService.getAllProvinces());
        fullLocation.put("districts", locationService.getDistrictsByProvinceId(provinceId));
        fullLocation.put("wards", locationService.getWardsByDistrictId(districtId));

        writeJson(response, fullLocation);
    }

    private void handleGetProvinces(HttpServletResponse response) throws IOException {
        writeJson(response, locationService.getAllProvinces());
    }

    private void handleGetDistricts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int provinceId = getRequiredIntParam(request, "provinceId");
        writeJson(response, locationService.getDistrictsByProvinceId(provinceId));
    }

    private void handleGetWards(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int districtId = getRequiredIntParam(request, "districtId");
        writeJson(response, locationService.getWardsByDistrictId(districtId));
    }

    private int getRequiredIntParam(HttpServletRequest request, String paramName) throws IOException {
        String value = request.getParameter(paramName);
        if (value == null || value.isEmpty()) {
            throw new IllegalArgumentException(paramName + " is required");
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid " + paramName + " format");
        }
    }

    private void writeJson(HttpServletResponse response, Object data) throws IOException {
        response.getWriter().write(GsonUtils.toJson(data));
    }

    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        Map<String, String> error = new HashMap<>();
        error.put("error", message);
        response.setStatus(status);
        writeJson(response, error);
    }
}
