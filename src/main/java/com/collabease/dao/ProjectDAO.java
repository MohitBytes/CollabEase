package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {
    public boolean createProject(Project project) {
        String query = "INSERT INTO projects (project_name, description, team_id, deadline, status) VALUES (?, ?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, project.getProjectName());
            pstmt.setString(2, project.getDescription());
            pstmt.setInt(3, project.getTeamId());
            pstmt.setDate(4, project.getDeadline());
            pstmt.setString(5, project.getStatus());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Project> getProjectsByTeam(int teamId) {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects WHERE team_id";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, teamId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                project.setDescription(rs.getString("description"));
                project.setTeamId(rs.getInt("team_id"));
                project.setDeadline(rs.getDate("deadline"));
                project.setStatus(rs.getString("status"));

                projects.add(project);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return projects;
    }
}
