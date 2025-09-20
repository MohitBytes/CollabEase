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
                
                String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?allowPublicKeyRetrieval=true&useSSL=false";
                con = DriverManager.getConnection(url, user, password);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return con;
    }
}
