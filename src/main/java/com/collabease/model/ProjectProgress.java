package com.collabease.model;

public class ProjectProgress {
    private String projectName;
    private int completedTasks;
    private int totalTasks;

    public ProjectProgress(String projectName, int completedTasks, int totalTasks) {
        this.projectName = projectName;
        this.completedTasks = completedTasks;
        this.totalTasks = totalTasks;
    }

    public String getProjectName() {
        return projectName;
    }

    public int getCompletedTasks() {
        return completedTasks;
    }

    public int getTotalTasks() {
        return totalTasks;
    }

    public int getPercentage() {
        return (totalTasks == 0) ? 0 : (completedTasks * 100 / totalTasks);
    }
}
