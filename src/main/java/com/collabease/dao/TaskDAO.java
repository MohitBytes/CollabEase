package com.collabease.dao;

import com.collabease.db.DBConnection;
import com.collabease.model.Task;

import java.sql.*;
import java.util.*;

public class TaskDAO {
    public boolean createTask(Task task) {
        String sql = "INSERT INTO tasks (title, description, project_id, assigned_to, created_by, deadline, priority, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, task.getTitle());
            pstmt.setString(2, task.getDescription());
            pstmt.setInt(3, task.getProjectId());
            pstmt.setInt(4, task.getAssignedTo());
            pstmt.setInt(5, task.getCreatedBy());
            pstmt.setTimestamp(6, task.getDeadline());
            pstmt.setString(7, task.getPriority());
            pstmt.setString(8, task.getStatus());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Task> getTasksByProject(int projectId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE project_id = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, projectId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_id"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setDeadline(rs.getTimestamp("deadline"));
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public boolean updateTaskStatus(int taskId, String status) {
        String sql = "UPDATE tasks SET status = ? WHERE task_id = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, taskId);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTaskCount(int userId, String status) {
        String sql = "SELECT COUNT(*) AS count FROM tasks WHERE assigned_to = ? AND status = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, status);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Task> getTaskByUser(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE assigned_to = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_id"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setDeadline(rs.getTimestamp("deadline"));
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                task.setLastUpdated(rs.getTimestamp("last_updated"));
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public List<Task> getTasksWithDeadlinesBefore(Timestamp beforeTime) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE deadline <= ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setTimestamp(1, beforeTime);
            try {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    Task task = new Task();
                    task.setTaskId(rs.getInt("task_id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setProjectId(rs.getInt("project_id"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setCreatedBy(rs.getInt("created_by"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));
                    task.setDeadline(rs.getTimestamp("deadline"));
                    task.setPriority(rs.getString("priority"));
                    task.setStatus(rs.getString("status"));
                    tasks.add(task);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public Map<String, Integer> getTaskStatusDistribution() {
        Map<String, Integer> distribution = new LinkedHashMap<>();
        String sql = "SELECT status, COUNT(*) AS count FROM tasks GROUP BY status";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                distribution.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return distribution;
    }

    public List<Task> getRecentTasks(int limit) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, p.project_name FROM tasks t " +
                "JOIN projects p ON t.project_id = p.project_id " +
                "ORDER BY t.created_at DESC LIMIT ?";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);

            try {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Task task = new Task();
                    task.setTaskId(rs.getInt("task_id"));
                    task.setTitle(rs.getString("title"));
                    task.setStatus(rs.getString("status"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));
                    task.setDeadline(rs.getTimestamp("deadline"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setProjectId(rs.getInt("project_id"));
                    task.setCreatedBy(rs.getInt("created_by"));
                    task.setPriority(rs.getString("priority"));
                    task.setDescription(rs.getString("description"));
                    task.setLastUpdated(rs.getTimestamp("last_updated"));

                    tasks.add(task);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public List<Task> getUpcomingDeadlines(int managerId, int days) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, p.project_name FROM tasks t " +
                "JOIN projects p ON t.project_id = p.project_id " +
                "JOIN teams tm ON p.team_id = tm.team_id " +
                "WHERE tm.manager_id = ? " +
                "AND t.deadline BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL ? DAY) " +
                "ORDER BY t.deadline";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, managerId);
            stmt.setInt(2, days);

            try {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Task task = new Task();
                    task.setTaskId(rs.getInt("task_id"));
                    task.setTitle(rs.getString("title"));
                    task.setStatus(rs.getString("status"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));
                    task.setDeadline(rs.getTimestamp("deadline"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setProjectId(rs.getInt("project_id"));
                    task.setCreatedBy(rs.getInt("created_by"));
                    task.setPriority(rs.getString("priority"));
                    task.setDescription(rs.getString("description"));
                    task.setLastUpdated(rs.getTimestamp("last_updated"));

                    tasks.add(task);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public Map<String, Integer> getTaskDistributionByManager(int managerId) {
        Map<String, Integer> distribution = new HashMap<>();
        String sql = "SELECT u.full_name, COUNT(t.task_id) AS task_count " +
                "FROM users u " +
                "JOIN tasks t ON u.user_id = t.assigned_to " +
                "JOIN projects p ON t.project_id = p.project_id " +
                "JOIN teams tm ON p.team_id = tm.team_id " +
                "WHERE tm.manager_id = ? " +
                "GROUP BY u.user_id";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, managerId);

            try {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    distribution.put(rs.getString("full_name"), rs.getInt("task_count"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return distribution;
    }

    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT task_id, title, description, project_id, assigned_to, priority, status, created_at, deadline FROM tasks";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_id"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setDeadline(rs.getTimestamp("deadline"));

                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public void updateTask(int taskId, String title, int assignedTo, String status, Timestamp deadline, String description) {
        String sql = "UPDATE tasks SET title = ?, description = ?, assigned_to = ?, status = ?, deadline = ? WHERE task_id = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, description);
            stmt.setInt(3, assignedTo);
            stmt.setString(4, status);
            stmt.setTimestamp(5, deadline);
            stmt.setInt(6, taskId);
            stmt.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Task getTaskById(int id) {
        Task task = null;
        String sql = "SELECT * FROM tasks WHERE task_id = ?";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_id"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setStatus(rs.getString("status"));
                task.setPriority(rs.getString("priority"));
                task.setDeadline(rs.getTimestamp("deadline"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return task;
    }

    public int getCompletedCount(int userId) {
        int count = 0;
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM tasks WHERE assigned_to = ? AND status = 'COMPLETED'");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getInProgressCount(int userId) {
        int count = 0;
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM tasks WHERE assigned_to = ? AND status = 'IN_PROGRESS'");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getOverdueCount(int userId) {
        int count = 0;
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM tasks WHERE assigned_to = ? AND deadline < CURRENT_DATE AND status != 'COMPLETED'");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Task> getTasksByUser(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE assigned_to = ?";

        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("task_id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_id"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setCreatedBy(rs.getInt("created_by"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setDeadline(rs.getTimestamp("deadline"));
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                task.setLastUpdated(rs.getTimestamp("last_updated"));
                tasks.add(task);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }

    public void deleteTask(int taskId) {
        String sql = "DELETE FROM tasks WHERE task_id = ?";
        try {

            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}
