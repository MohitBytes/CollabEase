package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Team;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}
