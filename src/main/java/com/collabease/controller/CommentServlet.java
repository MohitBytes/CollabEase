package com.collabease.controller;

import com.collabease.dao.CommentDAO;
import com.collabease.model.Comment;
import com.collabease.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String content = request.getParameter("content");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Comment comment = new Comment();
        comment.setTaskId(taskId);
        comment.setUserId(user.getUserId());
        comment.setContent(content);

        new CommentDAO().addComment(comment);
        response.sendRedirect("task-details?taskId=" + taskId);
    }
}
