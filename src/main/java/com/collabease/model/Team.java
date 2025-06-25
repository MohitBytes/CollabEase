package com.collabease.model;

public class Team {
    private int teamId;
    private String teamName;
    private int managerId;

    public Team(int teamId, String teamName, int managerId) {
        this.teamId = teamId;
        this.teamName = teamName;
        this.managerId = managerId;
    }

    public Team() {
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }
}
