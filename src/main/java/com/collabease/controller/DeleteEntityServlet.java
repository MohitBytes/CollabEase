package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteEntityServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String idParam = request.getParameter("id");

        if (type == null || idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing 'type' or 'id' parameter.");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "'id' must be a valid number.");
            return;
        }

        switch (type) {
            case "project":
                new ProjectDAO().deleteProject(id);
                response.sendRedirect("ManageSection?type=projects");
                break;

            case "team":
                new TeamDAO().deleteTeam(id);
                response.sendRedirect("ManageSection?type=teams");
                break;

            case "user":
                new UserDAO().deleteUser(id);
                response.sendRedirect("ManageSection?type=users");
                break;

            case "task":
                new TaskDAO().deleteTask(id);
                response.sendRedirect("ManageSection?type=tasks");
                break;

            default:
                response.sendRedirect("adminDashboard.jsp");
                break;
        }
    }
}
