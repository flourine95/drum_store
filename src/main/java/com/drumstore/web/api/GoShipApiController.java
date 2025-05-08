package com.drumstore.web.api;

import com.drumstore.web.utils.GoShipUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@WebServlet(urlPatterns = {"/api/location"})
public class GoShipApiController extends BaseApiController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> response = new HashMap<>();
        req.setCharacterEncoding("UTF-8");
        try {
            String cityName = req.getParameter( "city");
            String districtName = req.getParameter( "district");


            // Tìm cityId
            Optional<String> cityId = GoShipUtils.findCityIdByName(cityName);
            if (!cityId.isPresent()) {
                sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thành phố");
                return;
            }

            // Tìm districtId
            Optional<String> districtId = GoShipUtils.findDistrictIdByName(cityId.get(), districtName);
            if (!districtId.isPresent()) {
                sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy quận");
                return;
            }

            response.put("cityId", cityId.get());
            response.put("districtId", districtId.get());
            sendResponse(resp, response);

        } catch (IllegalArgumentException e) {
            sendError(resp, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> response = new HashMap<>();
        try {
          String cityId = req.getParameter( "cityId");
          String districtId = req.getParameter( "districtId");

            List<Map<String, Object>> rates = GoShipUtils.getShippingRates(cityId, districtId);

            if (rates.isEmpty()) {
                sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy biểu phí vận chuyển (có thể do thành phố hoặc quận không hợp lệ)");
                return;
            }
            response.put("rates", rates);
            sendResponse(resp, response);

        } catch (IllegalArgumentException e) {
            sendError(resp, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + e.getMessage());
        }
    }
}