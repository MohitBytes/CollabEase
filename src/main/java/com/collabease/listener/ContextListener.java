package com.collabease.listener;

import com.collabease.job.DeadlineCheckerJob;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        new DeadlineCheckerJob().start();
    }
}
