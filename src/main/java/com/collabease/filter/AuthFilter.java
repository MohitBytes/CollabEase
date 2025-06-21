package com.collabease.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

//@WebFilter("/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if(path.startsWith("/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if(loggedIn || path.equals("/login") || path.equals("/register")) {
            chain.doFilter(request, response);
        } else {
            response.sendRedirect("/signin/login.jsp");
        }
    }
}
