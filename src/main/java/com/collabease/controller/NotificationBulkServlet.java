package com.collabease.controller;

import com.collabease.dao.NotificationDAO;
import com.collabease.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class NotificationBulkServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        NotificationDAO dao = new NotificationDAO();

        switch (action) {
            case "markAll":
                dao.markAllAsRead(user.getUserId());
                break;
            case "clearAll":
                dao.clearAllNotifications(user.getUserId());
                break;
        }
    }
}