package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.dao.UserDAO;
import com.collabease.model.Project;
import com.collabease.model.Task;
import com.collabease.model.Team;
import com.collabease.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;


public class EditEntityServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        int id = Integer.parseInt(request.getParameter("id"));

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

        switch (type) {
            case "project":
                int projectId = Integer.parseInt(request.getParameter("id"));
                String projectName = request.getParameter("name");
                new ProjectDAO().updateProject(projectId, projectName);
                response.sendRedirect("ManageSection?type=projects");
                break;

            case "team":
                int teamId = Integer.parseInt(request.getParameter("id"));
                String teamName = request.getParameter("name");
                new TeamDAO().updateTeam(teamId, teamName);
                response.sendRedirect("ManageSection?type=teams");
                break;

            case "user":
                int userId = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String role = request.getParameter("role");
                new UserDAO().updateUser(userId, fullName, email, role);
                response.sendRedirect("ManageSection?type=users");
                break;

            case "task":
                int taskId = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String assignedTo = request.getParameter("assignedTo");
                String status = request.getParameter("status");
                String deadlineStr = request.getParameter("deadline");
                java.sql.Date deadline = java.sql.Date.valueOf(deadlineStr);
                new TaskDAO().updateTask(taskId, title, assignedTo, status, deadline);
                response.sendRedirect("ManageSection?type=tasks");
                break;

            default:
                response.sendRedirect("adminDashboard.jsp");
                break;
        }
    }
}