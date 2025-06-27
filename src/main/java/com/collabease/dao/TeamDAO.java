package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TeamDAO {
    public boolean createTeam(Team team) {
        String query = "INSERT INTO teams (team_name, manager_id) VALUES (?,?)";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, team.getTeamName());
            pstmt.setInt(2, team.getManagerId());

            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Team> getTeamsByManager(int managerId) {
        List<Team> teams = new ArrayList<>();
        String query = "SELECT * FROM teams WHERE manager_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setInt(1, managerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Team team =new Team();
                team.setTeamId(rs.getInt("team_id"));
                team.setTeamName(rs.getString("team_name"));
                team.setManagerId(rs.getInt("manager_id"));
                teams.add(team);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return teams;
    }

    public int getTotalTeams() {
        String sql = "SELECT COUNT(*) AS total FROM teams";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");  // Fetch the "total" column
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Team> getAllTeams() {
        List<Team> teams = new ArrayList<>();
        String sql = "SELECT * FROM teams";

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Team team = new Team();
                team.setTeamId(rs.getInt("team_id"));
                team.setTeamName(rs.getString("team_name"));
                team.setManagerId(rs.getInt("manager_id"));
                teams.add(team);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return teams;
    }

    public void updateTeam(int teamId, String teamName) {
        String sql = "UPDATE teams SET teamName = ? WHERE teamId = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, teamName);
            stmt.setInt(2, teamId);
            stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Team getTeamById(int id) {
        Team team = null;
        String sql = "SELECT * FROM teams WHERE teamId = ?";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                team = new Team();
                team.setTeamId(rs.getInt("teamId"));
                team.setTeamName(rs.getString("teamName"));
                team.setManagerId(rs.getInt("manager_id")); // if createdBy is a string (e.g., user email or username)
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return team;
    }

}
