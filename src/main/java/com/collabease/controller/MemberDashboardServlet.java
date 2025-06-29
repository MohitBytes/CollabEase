package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class MemberDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // use false to avoid creating a new session
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        TaskDAO taskDAO = new TaskDAO();
        ProjectDAO projectDAO = new ProjectDAO();

        try {
            int userId = user.getUserId();
            request.setAttribute("tasks", taskDAO.getTasksByUser(userId));
            request.setAttribute("projectProgress", projectDAO.getUserProjectProgress(userId));
            request.setAttribute("overdueCount", taskDAO.getOverdueCount(userId));

            request.getRequestDispatcher("/Member/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong!");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

}
