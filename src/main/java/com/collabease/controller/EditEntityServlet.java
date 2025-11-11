package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.dao.UserDAO;
import com.collabease.model.Project;
import com.collabease.model.Task;
import com.collabease.model.Team;
import com.collabease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

public class EditEntityServlet extends HttpServlet {

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
                Project project = new ProjectDAO().getProjectById(id);
                request.setAttribute("project", project);
                request.getRequestDispatcher("admin/editProject.jsp").forward(request, response);
                break;

            case "team":
                Team team = new TeamDAO().getTeamById(id);
                request.setAttribute("team", team);
                request.getRequestDispatcher("admin/editTeam.jsp").forward(request, response);
                break;

            case "user":
                User user = new UserDAO().getUserById(id);
                request.setAttribute("user", user);
                request.getRequestDispatcher("admin/editUser.jsp").forward(request, response);
                break;

            case "task":
                Task task = new TaskDAO().getTaskById(id);
                request.setAttribute("task", task);
                request.getRequestDispatcher("admin/editTask.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("adminDashboard.jsp");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
                String projectName = request.getParameter("name");
                if (projectName == null || projectName.trim().isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Project name cannot be empty.");
                    return;
                }
                new ProjectDAO().updateProject(id, projectName);
                response.sendRedirect("ManageSection?type=projects");
                break;

            case "team":
                String teamName = request.getParameter("name");
                if (teamName == null || teamName.trim().isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Team name cannot be empty.");
                    return;
                }
                new TeamDAO().updateTeam(id, teamName);
                response.sendRedirect("ManageSection?type=teams");
                break;

            case "user":
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String role = request.getParameter("role");
                if (fullName == null || email == null || role == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing user details.");
                    return;
                }
                new UserDAO().updateUser(id, fullName, email, role);
                response.sendRedirect("ManageSection?type=users");
                break;

            case "task":
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String status = request.getParameter("status");
                String deadlineStr = request.getParameter("deadline");

                int assignedTo;
                try {
                    assignedTo = Integer.parseInt(request.getParameter("assignedTo"));
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignedTo value.");
                    return;
                }

                Timestamp deadline;
                try {
                    // deadlineStr = yyyy-MM-dd --> convert to yyyy-MM-dd 00:00:00
                    deadline = Timestamp.valueOf(deadlineStr + " 00:00:00");
                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid deadline format.");
                    return;
                }

                new TaskDAO().updateTask(id, title, assignedTo, status, deadline, description);
                response.sendRedirect("ManageSection?type=tasks");
                break;

        }
    }
}
