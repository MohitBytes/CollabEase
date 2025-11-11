package com.collabease.controller;

import com.collabease.dao.TeamDAO;
import com.collabease.model.Team;
import com.collabease.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class TeamServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        TeamDAO teamDAO = new TeamDAO();
        request.setAttribute("teams", teamDAO.getTeamsByManager(user.getUserId()));
        request.getRequestDispatcher("/Manager/teams.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String teamName = request.getParameter("teamName");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Team team = new Team();
        team.setTeamName(teamName);
        team.setManagerId(user.getUserId());

        TeamDAO teamDAO = new TeamDAO();

        if (teamDAO.createTeam(team)) {
            response.sendRedirect("teams?success=Team created successfully");
        } else {
            response.sendRedirect("teams?error=Team creation failed");
        }
    }
}
