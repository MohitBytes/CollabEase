package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProjectDAO projectDAO = new ProjectDAO();
        TaskDAO taskDAO = new TaskDAO();
        TeamDAO teamDAO = new TeamDAO();
        UserDAO userDAO = new UserDAO();

        request.setAttribute("totalProjects", projectDAO.getTotalProjects());
        request.setAttribute("activeProjects", projectDAO.getActiveProjects());
        request.setAttribute("totalTeams", teamDAO.getTotalTeams());
        request.setAttribute("totalUsers", userDAO.getTotalUsers());
        request.setAttribute("taskDistribution", taskDAO.getTaskStatusDistribution());

        request.setAttribute("recentTasks", taskDAO.getRecentTasks(5));
        request.setAttribute("recentProjects", projectDAO.getRecentProjects(5));

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
