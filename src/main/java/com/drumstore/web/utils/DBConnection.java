package com.drumstore.web.utils;

import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConnection {
    private static Jdbi jdbi;

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Properties prop = new Properties();
                InputStream inputStream = DBConnection.class.getClassLoader().getResourceAsStream("db.properties");
                prop.load(inputStream);

                String url = prop.getProperty("db.url");
                String user = prop.getProperty("db.username");
                String password = prop.getProperty("db.password");

                jdbi = Jdbi.create(url, user, password);
            } catch (IOException | ClassNotFoundException e) {
                throw new RuntimeException("Could not load DB properties", e);
            }
        }
        return jdbi;
    }
}
