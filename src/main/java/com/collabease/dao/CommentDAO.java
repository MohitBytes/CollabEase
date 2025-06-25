package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments (task_id, user_id, content) VALUES (?, ?, ?)";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comment.getTaskId());
            pstmt.setInt(2, comment.getUserId());
            pstmt.setString(3, comment.getContent());
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Comment> getCommentsByTask(int taskId) {

        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name FROM comments c " +
                "JOIN users u ON c.user_id = u.user_id " +
                "WHERE task_id = ? ORDER BY created_at DESC";

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, taskId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setCommentId(rs.getInt("comment_id"));
                comment.setTaskId(rs.getInt("task_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setContent(rs.getString("content"));
                comment.setCreatedAt(rs.getTimestamp("created_at"));
                comment.setUserFullName(rs.getString("full_name"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }
}
