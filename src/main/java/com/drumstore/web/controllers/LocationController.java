package com.drumstore.web.controllers;

import com.drumstore.web.models.District;
import com.drumstore.web.models.Province;
import com.drumstore.web.models.Ward;
import com.drumstore.web.repositories.DistrictRepository;
import com.drumstore.web.repositories.ProvinceRepository;
import com.drumstore.web.repositories.WardRepository;
import com.drumstore.web.services.LocationService;
import com.drumstore.web.utils.DBConnection;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/location")
public class LocationController extends HttpServlet {

    private LocationService locationService;

    @Override
    public void init() {
        Jdbi jdbi = DBConnection.getJdbi();
        locationService = new LocationService(
                new ProvinceRepository(jdbi),
                new DistrictRepository(jdbi),
                new WardRepository(jdbi)
        );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action is required");
            return;
        }

        switch (action) {
            case "provinces" -> handleGetProvinces(response);
            case "districts" -> handleGetDistricts(request, response);
            case "wards" -> handleGetWards(request, response);
            case "full_location" -> handleGetFullLocation(request, response); // Thêm action mới
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND, "Action not found");
        }
    }

    private void handleGetFullLocation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String provinceIdParam = request.getParameter("provinceId");
            String districtIdParam = request.getParameter("districtId");

            if (provinceIdParam == null || districtIdParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "provinceId and districtId are required");
                return;
            }

            int provinceId = Integer.parseInt(provinceIdParam);
            int districtId = Integer.parseInt(districtIdParam);

            // Lấy tất cả dữ liệu cần thiết
            List<Province> provinces = locationService.getAllProvinces();
            List<District> districts = locationService.getDistrictsByProvinceId(provinceId);
            List<Ward> wards = locationService.getWardsByDistrictId(districtId);

            // Tạo object chứa tất cả dữ liệu
            Map<String, Object> fullLocation = new HashMap<>();
            fullLocation.put("provinces", provinces);
            fullLocation.put("districts", districts);
            fullLocation.put("wards", wards);

            writeResponse(response, fullLocation);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading location data");
        }
    }

    private void handleGetProvinces(HttpServletResponse response) throws IOException {
        List<Province> provinces = locationService.getAllProvinces();
        writeResponse(response, provinces);
    }

    private void handleGetDistricts(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String provinceIdParam = request.getParameter("provinceId");
        if (provinceIdParam == null || provinceIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "provinceId is required");
            return;
        }

        int provinceId = Integer.parseInt(provinceIdParam);
        List<District> districts = locationService.getDistrictsByProvinceId(provinceId);
        writeResponse(response, districts);
    }

    private void handleGetWards(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String districtIdParam = request.getParameter("districtId");
        if (districtIdParam == null || districtIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "districtId is required");
            return;
        }

        int districtId = Integer.parseInt(districtIdParam);
        List<Ward> wards = locationService.getWardsByDistrictId(districtId);
        writeResponse(response, wards);
    }

    private void writeResponse(HttpServletResponse response, Object data) throws IOException {
        String jsonResponse = new Gson().toJson(data);
        response.getWriter().write(jsonResponse);
    }
}
