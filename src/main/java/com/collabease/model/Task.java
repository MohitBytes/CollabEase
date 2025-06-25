package com.collabease.model;

import java.sql.Timestamp;

public class Task {
    private int taskId;
    private String title;
    private String description;
    private int projectId;
    private int assignedTo;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp deadline;
    private String priority;
    private String status;
    private Timestamp lastUpdated;

    public Task(int taskId, String title, String description, int projectId, int assignedTo, int createdBy, Timestamp createdAt, Timestamp deadline, String priority, String status, Timestamp lastUpdated) {
        this.taskId = taskId;
        this.title = title;
        this.description = description;
        this.projectId = projectId;
        this.assignedTo = assignedTo;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.deadline = deadline;
        this.priority = priority;
        this.status = status;
        this.lastUpdated = lastUpdated;
    }

    public Task() {
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}
