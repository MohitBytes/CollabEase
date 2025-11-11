package com.collabease.controller;

import com.collabease.dao.NotificationDAO;
import com.collabease.model.Notification;
import com.collabease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;

public class NotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        NotificationDAO notificationDAO = new NotificationDAO();
        List<Notification> notifications = notificationDAO.getUnreadNotifications(user.getUserId());

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(notifications));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String action = request.getParameter("action");

        try {
            NotificationDAO dao = new NotificationDAO();

            if ("markAllRead".equals(action)) {
                boolean result = dao.markAllAsRead(user.getUserId());
                response.getWriter().print(result ? "success" : "fail");
            } else {
                int notificationId = Integer.parseInt(request.getParameter("notificationId"));
                dao.markAsRead(notificationId);
                response.getWriter().print("success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
