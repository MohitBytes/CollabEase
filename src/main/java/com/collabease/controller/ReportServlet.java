package com.collabease.controller;

import com.collabease.dao.ProjectDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.dao.UserDAO;
import com.collabease.model.Project;
import com.collabease.model.Task;
import com.collabease.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reportType = request.getParameter("type");

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + reportType + "-report.csv\"");

        PrintWriter out = response.getWriter();

        switch (reportType) {
            case "projects":
                generateProjectReport(out);
                break;
            case "tasks":
                generateTaskReport(out);
                break;
            case "users":
                generateUserReport(out);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid report type");
        }
    }

    private void generateProjectReport(PrintWriter out) {
        ProjectDAO projectDAO = new ProjectDAO();
        List<Project> projects = projectDAO.getAllProjects();

        // CSV header
        out.println("Project ID,Project Name,Description,Team ID,Deadline,Status");

        // CSV data
        for (Project project : projects) {
            out.println(String.format("%d,\"%s\",\"%s\",%d,%s,%s",
                    project.getProjectId(),
                    project.getProjectName(),
                    project.getDescription(),
                    project.getTeamId(),
                    project.getDeadline().toString(),
                    project.getStatus()
            ));
        }
    }

    private void generateTaskReport(PrintWriter out) {
        TaskDAO taskDAO = new TaskDAO();
        List<Task> tasks = taskDAO.getAllTasks();

        // CSV header
        out.println("Task ID,Title,Description,Project ID,Assigned To,Priority,Status,Created At,Deadline");

        // CSV data
        for (Task task : tasks) {
            out.println(String.format("%d,\"%s\",\"%s\",%d,%d,%s,%s,%s,%s",
                    task.getTaskId(),
                    task.getTitle(),
                    task.getDescription(),
                    task.getProjectId(),
                    task.getAssignedTo(),
                    task.getPriority(),
                    task.getStatus(),
                    task.getCreatedAt().toString(),
                    task.getDeadline().toString()
            ));
        }
    }

    private void generateUserReport(PrintWriter out) {
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();

        // CSV header
        out.println("User ID,Full Name,Email,Role");

        // CSV data
        for (User user : users) {
            out.println(String.format("%d,\"%s\",%s,%s",
                    user.getUserId(),
                    user.getFullName(),
                    user.getEmail(),
                    user.getRole()
            ));
        }
    }
}