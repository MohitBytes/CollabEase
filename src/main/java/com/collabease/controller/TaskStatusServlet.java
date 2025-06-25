package com.collabease.controller;

import com.collabease.dao.TaskDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class TaskStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String status = request.getParameter("status");

        TaskDAO taskDAO = new TaskDAO();
        boolean success = taskDAO.updateTaskStatus(taskId, status);

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(success ? "success" : "error");
    }
}
