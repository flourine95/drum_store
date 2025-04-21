package com.drumstore.web.controllers.auth;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ckbox/token")
public class CKBoxTokenController extends HttpServlet {
    private static final String SECRET_KEY = "";
    private static final String ENVIRONMENT_ID = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId") != null ? request.getParameter("userId") : "test-user";
        String role = request.getParameter("role") != null ? request.getParameter("role") : "superadmin";

        String token = createCSToken(userId, role);
        response.setContentType("text/plain");
        response.getWriter().write(token);
    }

    public String createCSToken(String userId, String role) {
        Map<String, Object> authClaim = new HashMap<>() {{
            put("ckbox", new HashMap<>() {{
                put("role", role);
                put("workspaces", List.of(""));
            }});
        }};

        return JWT.create()
                .withAudience(ENVIRONMENT_ID)
                .withIssuedAt(Instant.now())
                .withSubject(userId)
                .withClaim("auth", authClaim)
                .sign(Algorithm.HMAC256(SECRET_KEY.getBytes(StandardCharsets.US_ASCII)));
    }
}
