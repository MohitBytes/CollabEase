package com.collabease.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection con = null;

    private DBConnection() {

    }

    public static Connection getConnection() {
        if (con == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Use environment variables with fallback to default values
                String host = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
                String port = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
                String dbName = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "collabease_db";
                String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
                String password = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "your_password";
                
                String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + 
                    "?allowPublicKeyRetrieval=true&useSSL=false&autoReconnect=true&failOverReadOnly=false&maxReconnects=10";
                
                // Retry connection up to 10 times with 2 second delays
                for (int i = 0; i < 10; i++) {
                    try {
                        con = DriverManager.getConnection(url, user, password);
                        if (con != null) {
                            System.out.println("Database connection established successfully!");
                            break;
                        }
                    } catch (Exception e) {
                        System.out.println("Database connection attempt " + (i + 1) + " failed: " + e.getMessage());
                        if (i < 9) { // Don't sleep on the last attempt
                            try {
                                Thread.sleep(2000); // Wait 2 seconds before retry
                            } catch (InterruptedException ie) {
                                Thread.currentThread().interrupt();
                                break;
                            }
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("Database connection failed: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return con;
    }
}
