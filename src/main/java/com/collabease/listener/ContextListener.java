package com.collabease.listener;

import com.collabease.job.DeadlineCheckerJob;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class ContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        new DeadlineCheckerJob().start();
    }
}
