//package com.drumstore.web.filters;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//import java.util.UUID;
//
//@WebFilter("/*")
//public class CsrfFilter implements Filter {
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpSession session = httpRequest.getSession();
//
//        if (session.getAttribute("csrfToken") == null) {
//            String csrfToken = UUID.randomUUID().toString();
//            session.setAttribute("csrfToken", csrfToken);
//        }
//
//        chain.doFilter(request, response);
//    }
//}