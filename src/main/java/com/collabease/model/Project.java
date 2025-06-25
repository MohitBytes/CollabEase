package com.collabease.model;

import java.sql.Date;

public class Project {
    private int projectId;
    private String projectName;
    private String description;
    private int teamId;
    private Date deadline;
    private String status;

    public Project(int projectId, String projectName, String description, int teamId, Date deadline, String status) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.description = description;
        this.teamId = teamId;
        this.deadline = deadline;
        this.status = status;
    }

    public Project() {
    }

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
