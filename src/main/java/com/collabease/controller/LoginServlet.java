package com.collabease.controller;

import com.collabease.dao.UserDAO;
import com.collabease.model.User;
import com.collabease.utils.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);

        if (user != null && PasswordUtil.checkPassword(password, user.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            switch (user.getRole()) {
                case "ADMIN":
                    response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
                    break;

                case "MANAGER":
                    response.sendRedirect(request.getContextPath() +"/ManagerDashboardServlet");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() +"/MemberDashboardServlet");
            }
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("../signin/login.jsp").forward(request, response);
        }
     }
}