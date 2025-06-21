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
                String url = "jdbc:mysql://localhost:3306/collabease_db?useSSL=false";
                String user = "root";
                String password = "Mohit@2004";
                con = DriverManager.getConnection(url, user, password);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return con;
    }
}
