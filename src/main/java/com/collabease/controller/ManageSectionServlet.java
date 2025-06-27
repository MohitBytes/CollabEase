package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TeamDAO;
import com.collabease.dao.UserDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.model.Project;
import com.collabease.model.Team;
import com.collabease.model.User;
import com.collabease.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class ManageSectionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");

        switch (type) {
            case "projects":
                List<Project> projectList = new ProjectDAO().getAllProjects();
                request.setAttribute("projectList", projectList);
                request.getRequestDispatcher("/admin/manageProjects.jsp").forward(request, response);
                break;

            case "teams":
                List<Team> teamList = new TeamDAO().getAllTeams();
                request.setAttribute("teamList", teamList);
                request.getRequestDispatcher("/admin/manageTeams.jsp").forward(request, response);
                break;

            case "users":
                List<User> userList = new UserDAO().getAllUsers();
                request.setAttribute("userList", userList);
                request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
                break;

            case "tasks":
                List<Task> taskList = new TaskDAO().getAllTasks();
                request.setAttribute("taskList", taskList);
                request.getRequestDispatcher("/admin/manageTasks.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect("/admin/dashboard.jsp");
        }
    }
}
