package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ManagerDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        ProjectDAO projectDAO = new ProjectDAO();
        TaskDAO taskDAO = new TaskDAO();

        // Manager-specific analytics
        request.setAttribute("myProjects", projectDAO.getProjectsByManager(user.getUserId()));
        request.setAttribute("teamTaskDistribution", taskDAO.getTaskDistributionByManager(user.getUserId()));
        request.setAttribute("upcomingDeadlines", taskDAO.getUpcomingDeadlines(user.getUserId(), 7));

        // Performance metrics
        request.setAttribute("teamPerformance", projectDAO.getTeamPerformanceMetrics(user.getUserId()));

        request.getRequestDispatcher("/Manager/dashboard.jsp").forward(request, response);
    }
}
