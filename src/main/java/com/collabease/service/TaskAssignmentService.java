package com.collabease.service;

import com.collabease.dao.TaskDAO;
import com.collabease.dao.UserDAO;
import com.collabease.model.Task;
import com.collabease.model.User;

import java.util.List;

public class TaskAssignmentService {
    private UserDAO userDAO = new UserDAO();
    private TaskDAO taskDAO = new TaskDAO();

    public void assignTask(Task task) {
        // Priority-based assignment logic
        if ("URGENT".equals(task.getPriority())) {
            assignToLeastBusySeniorMember(task);
        } else {
            assignRoundRobin(task);
        }
    }

    private void assignToLeastBusySeniorMember(Task task) {
        // Get all members in the team (simplified - needs team context)
        List<User> members = userDAO.getAllMembers();
        User bestCandidate = null;
        int minTaskCount = Integer.MAX_VALUE;

        for (User member : members) {
            int taskCount = taskDAO.getTaskCount(member.getUserId(), "TODO");
            if (taskCount < minTaskCount) {
                minTaskCount = taskCount;
                bestCandidate = member;
            }
        }

        if (bestCandidate != null) {
            task.setAssignedTo(bestCandidate.getUserId());
            taskDAO.createTask(task);
        }
    }

    private void assignRoundRobin(Task task) {
        // Simplified round-robin assignment
        List<User> members = userDAO.getAllMembers();
        if (!members.isEmpty()) {
            // Get next user in sequence (needs persistent tracking in real system)
            int nextUserIndex = (int) (System.currentTimeMillis() % members.size());
            task.setAssignedTo(members.get(nextUserIndex).getUserId());
            taskDAO.createTask(task);
        }
    }
}
