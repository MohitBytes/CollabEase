package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.User;
import com.collabease.utils.PasswordUtil;

import javax.servlet.annotation.MultipartConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
}
