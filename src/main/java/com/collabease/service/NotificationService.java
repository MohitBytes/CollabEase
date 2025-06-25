package com.collabease.service;

import com.collabease.dao.NotificationDAO;
import com.collabease.dao.TaskDAO;
import com.collabease.model.Notification;
import com.collabease.model.Task;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

public class NotificationService {
    private TaskDAO taskDAO = new TaskDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();

    public void checkDeadlines() {
        try {
            // Get tasks with deadlines in the next 48 hours
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.HOUR, 48);
            Timestamp future = new Timestamp(cal.getTimeInMillis());

            List<Task> tasks = taskDAO.getTasksWithDeadlinesBefore(future);

            for (Task task : tasks) {
                // Check if notification already exists
                if (!notificationDAO.notificationExists(task.getTaskId(), "DEADLINE_REMINDER", task.getAssignedTo())) {
                    Notification notification = new Notification();
                    notification.setUserId(task.getAssignedTo());
                    notification.setMessage("Task '" + task.getTitle() + "' deadline is approaching");
                    notification.setType("DEADLINE_REMINDER");
                    notification.setRelatedId(task.getTaskId());

                    notificationDAO.createNotification(notification);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void createAssignmentNotification(Task task) {
        Notification notification = new Notification();
        notification.setUserId(task.getAssignedTo());
        notification.setMessage("You've been assigned a new task: " + task.getTitle());
        notification.setType("TASK_ASSIGNED");
        notification.setRelatedId(task.getTaskId());

        notificationDAO.createNotification(notification);
    }
}
