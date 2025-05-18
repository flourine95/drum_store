package com.drumstore.web.controllers.auth;

import com.drumstore.web.dto.UserDTO;
import com.drumstore.web.services.UserService;
import com.drumstore.web.utils.ConfigUtils;
import com.drumstore.web.utils.GsonUtils;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet({"/login/facebook", "/login/oauth2/code/facebook"})
public class FacebookLoginController extends HttpServlet {
    private static final String PROVIDER = "facebook";
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            String authUrl = String.format("%s?client_id=%s&redirect_uri=%s&response_type=code&scope=%s",
                    ConfigUtils.get("api.facebook.authEndpoint"),
                    ConfigUtils.get("api.facebook.appId"),
                    URLEncoder.encode(ConfigUtils.get("api.facebook.redirectUri"), StandardCharsets.UTF_8),
                    ConfigUtils.get("api.facebook.scope"));

            response.sendRedirect(authUrl);
            return;
        }

        try {
            String tokenUrl = String.format("%s?client_id=%s&client_secret=%s&code=%s&redirect_uri=%s",
                    ConfigUtils.get("api.facebook.tokenEndpoint"),
                    ConfigUtils.get("api.facebook.appId"),
                    ConfigUtils.get("api.facebook.appSecret"),
                    code,
                    URLEncoder.encode(ConfigUtils.get("api.facebook.redirectUri"), StandardCharsets.UTF_8));

            URL url = new URL(tokenUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            try {
                conn.setRequestMethod("GET");

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                    StringBuilder tokenResponseStr = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        tokenResponseStr.append(line);
                    }

                    JsonObject tokenResponse = GsonUtils.fromJson(tokenResponseStr.toString(), JsonObject.class);
                    String accessToken = tokenResponse.get("access_token").getAsString();

                    String userInfoUrl = ConfigUtils.get("api.facebook.userinfoEndpoint")
                            + "?fields=id,name,email,picture&access_token=" + accessToken;
                    conn = (HttpURLConnection) URI.create(userInfoUrl).toURL().openConnection();
                    conn.setRequestMethod("GET");

                    JsonObject userInfo = GsonUtils.fromJson(
                            new InputStreamReader(conn.getInputStream())
                    );
                }
            } finally {
                conn.disconnect();
            }

            String facebookId = userInfo.get("id").getAsString();
            String email = userInfo.has("email") ? userInfo.get("email").getAsString() : null;
            String name = userInfo.has("name") ? userInfo.get("name").getAsString() : "Facebook User";

            String avatar = null;
            if (userInfo.has("picture") && userInfo.get("picture").isJsonObject()) {
                JsonObject pictureData = userInfo.getAsJsonObject("picture").getAsJsonObject("data");
                if (pictureData.has("url")) {
                    avatar = pictureData.get("url").getAsString();
                }
            }

            UserDTO user = null;

            if (email != null) {
                user = userService.findUser("email", email);
            }

            if (user == null) {
                user = userService.findUser("providerId", facebookId);
            }

            if (user == null) {
                // Tạo mới user
                user = UserDTO.builder()
                        .email(email != null ? email : "")
                        .fullname(name)
                        .avatar(avatar)
                        .provider(PROVIDER)
                        .providerId(facebookId)
                        .status(true)
                        .build();

                userService.store(user);
            } else {
                if (user.getProviderId() == null || PROVIDER.equals(user.getProvider()) ) {
                    user.setProvider(PROVIDER);
                    user.setProviderId(facebookId);
                    userService.update(user);
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=facebook_login_failed");
        }
    }
}
