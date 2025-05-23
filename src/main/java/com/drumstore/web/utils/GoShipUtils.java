package com.drumstore.web.utils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import java.util.stream.Collectors;

public class GoShipUtils {
    private static final String BASE_URL = ConfigUtils.get("api.goship.url");
    private static final String AUTH_TOKEN = ConfigUtils.get("api.goship.token");
    private static final Gson gson = new Gson();

    // Địa chỉ người gửi (cố định)
    private static final String CITY_FROM = "100000"; // hà nội
    private static final String DISTRICT_FROM = "100100";

    // Giá trị mặc định cho parcel
    private static final int DEFAULT_COD = 500000;
    private static final int DEFAULT_AMOUNT = 500000;
    private static final int DEFAULT_WIDTH = 50; // cm
    private static final int DEFAULT_HEIGHT = 50; // cm
    private static final int DEFAULT_LENGTH = 50; // cm
    private static final int DEFAULT_WEIGHT = 15000; // gram

    private static List<Map<String, String>> fetchData(String endpoint) throws IOException {
        URL url = new URL(BASE_URL + endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", AUTH_TOKEN);
        conn.setRequestProperty("Accept", "application/json");

        int responseCode = conn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                Map<String, Object> response = gson.fromJson(br, new TypeToken<Map<String, Object>>(){}.getType());
                if (response != null && response.containsKey("data")) {
                    return (List<Map<String, String>>) response.get("data");
                }
            }
        }
        return Collections.emptyList();
    }

    public static List<Map<String, String>> getCities() {
        try {
            return fetchData("/cities");
        } catch (IOException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public static List<Map<String, String>> getDistrictsByCityId(String cityId) {
        try {
            return fetchData("/cities/" + cityId + "/districts");
        } catch (IOException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public static Optional<String> findCityIdByName(String cityName) {
        List<Map<String, String>> cities = getCities();
        String normalizedCityName = cityName.toLowerCase().replaceAll("(tỉnh|thành phố)", "").trim();
            return cities.stream()
                .filter(city -> city.get("name").toLowerCase().contains(normalizedCityName.toLowerCase()))
                .map(city -> city.get("id"))
                .findFirst();
    }

    public static Optional<String> findDistrictIdByName(String cityId, String districtName) {
        List<Map<String, String>> districts = getDistrictsByCityId(cityId);
        return districts.stream()
                .filter(district -> district.get("name").toLowerCase().contains(districtName.toLowerCase()))
                .map(district -> district.get("id"))
                .findFirst();
    }


    public static List<Map<String, Object>> getShippingRates(String cityTo, String districtTo) {
        try {
            // Tạo request body
            Map<String, Object> shipment = new HashMap<>();
            Map<String, String> addressFrom = new HashMap<>();
            addressFrom.put("district", DISTRICT_FROM);
            addressFrom.put("city", CITY_FROM);
            Map<String, String> addressTo = new HashMap<>();
            addressTo.put("district", districtTo);
            addressTo.put("city",cityTo);
            Map<String, Object> parcel = new HashMap<>();
            parcel.put("cod", DEFAULT_COD);
            parcel.put("amount", DEFAULT_AMOUNT);
            parcel.put("width", DEFAULT_WIDTH);
            parcel.put("height", DEFAULT_HEIGHT);
            parcel.put("length", DEFAULT_LENGTH);
            parcel.put("weight", DEFAULT_WEIGHT);

            shipment.put("address_from", addressFrom);
            shipment.put("address_to", addressTo);
            shipment.put("parcel", parcel);

            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("shipment", shipment);

            URL url = new URL(BASE_URL + "/rates");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", AUTH_TOKEN);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = gson.toJson(requestBody).getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    Map<String, Object> response = gson.fromJson(br, new TypeToken<Map<String, Object>>(){}.getType());
                    if (response != null && response.containsKey("data")) {
                        return (List<Map<String, Object>>) response.get("data");
                    }
                }
            } else {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream()))) {
                    System.err.println("Error response: " + br.lines().collect(Collectors.joining()));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return Collections.emptyList();
    }
}