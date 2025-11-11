package com.collabease.controller;

import com.collabease.dao.NotificationDAO;
import com.collabease.model.Notification;
import com.collabease.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AllNotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("../signin/login.jsp");
            return;
        }

        NotificationDAO dao = new NotificationDAO();
        List<Notification> notifications = dao.getAllNotifications(user.getUserId());

        request.setAttribute("notifications", notifications);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Notifications/notifications.jsp");
        dispatcher.forward(request, response);
    }
}
