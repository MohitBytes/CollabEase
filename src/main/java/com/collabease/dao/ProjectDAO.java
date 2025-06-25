package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.collabease.db.DBConnection.getConnection;

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

    public List<Project> getProjectsByManager(int managerId) {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT p.* FROM projects p JOIN teams t ON p.team_id = t.team_id WHERE t.manager_id = ?";

        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, managerId);
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

    public int getTotalProjects() {
        String sql = "SELECT COUNT(*) AS total FROM projects";
        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveProjects() {
        String sql = "SELECT COUNT(*) AS total FROM projects WHERE status IN ('PLANNING', 'IN_PROGRESS')";
        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Project> getRecentProjects(int limit) {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects ORDER BY created_at DESC LIMIT ?";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Project project = new Project();
                    project.setProjectId(rs.getInt("project_id"));
                    project.setProjectName(rs.getString("project_name"));
                    project.setStatus(rs.getString("status"));
                    project.setDescription(rs.getString("description"));
                    project.setTeamId(rs.getInt("team_id"));
                    project.setDeadline(rs.getDate("deadline"));
                    projects.add(project);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public Map<String, Map<String, Double>> getTeamPerformanceMetrics(int managerId) {
        Map<String, Map<String, Double>> metrics = new HashMap<>();
        String sql = "SELECT t.team_name, " +
                "AVG(CASE WHEN tk.status = 'COMPLETED' THEN 1 ELSE 0 END) AS completion_rate, " +
                "AVG(TIMESTAMPDIFF(DAY, tk.created_at, tk.deadline)) AS avg_duration " +
                "FROM teams t " +
                "JOIN projects p ON t.team_id = p.team_id " +
                "JOIN tasks tk ON p.project_id = tk.project_id " +
                "WHERE t.manager_id = ? " +
                "GROUP BY t.team_id";

        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, managerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String teamName = rs.getString("team_name");
                    double completionRate = rs.getDouble("completion_rate");
                    double avgDuration = rs.getDouble("avg_duration");

                    Map<String, Double> teamMetrics = new HashMap<>();
                    teamMetrics.put("completion_rate", completionRate);
                    teamMetrics.put("avg_duration_days", avgDuration);

                    metrics.put(teamName, teamMetrics);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return metrics;
    }

    public List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT project_id, project_name, description, team_id, deadline, status FROM projects";

        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
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
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return projects;
    }

}
