package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.User;
import com.collabease.utils.PasswordUtil;

import javax.servlet.annotation.MultipartConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
public class UserDAO {
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try {

            Connection con = DBConnection.getConnection();
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean createUser(User user) {
        String query = "INSERT INTO users (email, password, full_name, role) VALUES (?, ?, ?, ?)";

        try {
             Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(query);

             pstmt.setString(1, user.getEmail());
             pstmt.setString(2, PasswordUtil.hashPassword(user.getPassword()));
             pstmt.setString(3, user.getFullName());
             pstmt.setString(4, user.getRole());

             return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<User> getAllMembers() {
        List<User> members = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = 'MEMBER'";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                members.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return members;
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) AS total FROM users";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");  // Fetch the total number of users
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0; // Default return if an error occurs
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email, role FROM users";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

}
