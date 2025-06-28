package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.model.Project;
import com.collabease.model.Team;
import com.collabease.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

public class ProjectServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        TeamDAO teamDAO = new TeamDAO();

        request.setAttribute("teams", teamDAO.getTeamsByManager(user.getUserId()));
        request.getRequestDispatcher("/Manager/projects.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String projectName = request.getParameter("projectName");
        String description = request.getParameter("description");
        int teamId = Integer.parseInt(request.getParameter("teamId"));
        Date deadline = Date.valueOf(request.getParameter("deadline"));
        String status = "PLANNING";

        Project project = new Project();
        project.setProjectName(projectName);
        project.setDescription(description);
        project.setTeamId(teamId);
        project.setDeadline(deadline);
        project.setStatus(status);


        ProjectDAO projectDAO = new ProjectDAO();
        if (projectDAO.createProject(project)) {
            response.sendRedirect("projects?success=Project created successfully");
        } else {
            response.sendRedirect("projects?error=Project creation failed");
        }

    }
}
