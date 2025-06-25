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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        TaskDAO taskDAO = new TaskDAO();
        ProjectDAO projectDAO = new ProjectDAO();

        request.setAttribute("tasks", taskDAO.getTasksByUser(user.getUserId()));
        request.setAttribute("projectProgress", projectDAO.getUserProjectProgress(user.getUserId()));

        request.getRequestDispatcher("/member/dashboard.jsp").forward(request, response);
    }
}
