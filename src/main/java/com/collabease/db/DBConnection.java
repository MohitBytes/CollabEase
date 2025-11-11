package com.collabease.db;

import java.sql.Connection;
import java.sql.DriverManager;
import io.github.cdimascio.dotenv.Dotenv;

public class DBConnection {
    private static Connection con = null;

    private DBConnection() {}

    public static Connection getConnection() {
        if (con == null) {
            try {
                Class.forName("org.postgresql.Driver");

                Dotenv dotenv = Dotenv.configure().directory("D:\\Mohit\\Clg\\CollabEase").load();

                String url = dotenv.get("DB_URL");
                String user = dotenv.get("DB_USER");
                String password = dotenv.get("DB_PASS");

                con = DriverManager.getConnection(url, user, password);
                System.out.println("SupaBase Connected successfully!");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return con;
    }
}
