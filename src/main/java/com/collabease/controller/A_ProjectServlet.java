package com.collabease.controller;


import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.model.Project;
import com.collabease.model.Team;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet("/projects")
public class A_ProjectServlet extends HttpServlet {  // Changed to public class and proper naming
    private ProjectDAO projectDao;
    private TeamDAO teamDao;

    @Override
    public void init() {
        projectDao = new ProjectDAO();
        teamDao = new TeamDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Project> projects = projectDao.getAllProjects();
            List<Team> teams = teamDao.getAllTeams();

            request.setAttribute("projects", projects);
            request.setAttribute("teams", teams);
            request.getRequestDispatcher("/projects.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}