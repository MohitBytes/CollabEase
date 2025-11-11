package com.collabease.controller;

import com.collabease.dao.UserDAO;
import com.collabease.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullname");
        String role = "MEMBER";

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        UserDAO userDAO = new UserDAO();
        if (userDAO.createUser(user)) {
            response.sendRedirect("../signin/login.jsp?success=Register successful");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("../signin/register.jsp").forward(request, response);
        }
    }

}
