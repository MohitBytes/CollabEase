package com.collabease.controller;

import com.collabease.dao.UserDAO;
import com.collabease.model.User;
import com.collabease.utils.PasswordUtil;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
                    response.sendRedirect("/ManagerDashboardServlet");
                    break;

                default:
                    response.sendRedirect("../Member/dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("../signin/login.jsp").forward(request, response);
        }
     }
}