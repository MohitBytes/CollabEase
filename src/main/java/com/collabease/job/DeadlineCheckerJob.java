package com.collabease.job;

import com.collabease.service.NotificationService;

import java.util.Timer;
import java.util.TimerTask;

public class DeadlineCheckerJob {
    public void start() {
        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                new NotificationService().checkDeadlines();
            }
        }, 0, 60 * 60 * 1000); // Run every hour
    }
}
