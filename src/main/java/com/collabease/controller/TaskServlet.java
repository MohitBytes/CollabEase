package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.UserDAO;
import com.collabease.model.Task;
import com.collabease.model.User;
import com.collabease.service.TaskAssignmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;

public class TaskServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Get projects for dropdown
        ProjectDAO projectDAO = new ProjectDAO();
        request.setAttribute("projects", projectDAO.getProjectsByManager(user.getUserId()));

        // Get users for assignment
        UserDAO userDAO = new UserDAO();
        request.setAttribute("users", userDAO.getAllMembers());

        request.getRequestDispatcher("/Manager/tasks.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String priority = request.getParameter("priority");
        Timestamp deadline = Timestamp.valueOf(request.getParameter("deadline") + " 23:59:59");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setProjectId(projectId);
        task.setCreatedBy(user.getUserId());
        task.setDeadline(deadline);
        task.setPriority(priority);

        // Handle assignment
        String assignmentType = request.getParameter("assignment");
        if ("manual".equals(assignmentType)) {
            int assignedTo = Integer.parseInt(request.getParameter("assignedTo"));
            task.setAssignedTo(assignedTo);
            new TaskDAO().createTask(task);
        } else {
            new TaskAssignmentService().assignTask(task);
        }

        response.sendRedirect("tasks?success=Task created successfully");
    }
}
