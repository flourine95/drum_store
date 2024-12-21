package com.drumstore.web.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConnection {
    private static volatile Jdbi jdbi;
    private static HikariDataSource dataSource;

    private DBConnection() {
    }

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            synchronized (DBConnection.class) {
                if (jdbi == null) {
                    try {
                        Properties prop = new Properties();
                        InputStream inputStream = DBConnection.class.getClassLoader().getResourceAsStream("db.properties");
                        prop.load(inputStream);

                        String url = prop.getProperty("db.url");
                        String user = prop.getProperty("db.username");
                        String password = prop.getProperty("db.password");

                        HikariConfig config = getHikariConfig(url, user, password);

                        dataSource = new HikariDataSource(config);

                        jdbi = Jdbi.create(dataSource);
                    } catch (IOException e) {
                        throw new RuntimeException("Could not load DB properties", e);
                    }
                }
            }
        }
        return jdbi;
    }

    private static HikariConfig getHikariConfig(String url, String user, String password) {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(url);
        config.setUsername(user);
        config.setPassword(password);
        config.setDriverClassName("com.mysql.cj.jdbc.Driver");
        config.setMaximumPoolSize(10); //(CPU cores * 2) + number of disks
        config.setMinimumIdle(2);
        config.setIdleTimeout(30000);
        config.setMaxLifetime(1800000);
        return config;
    }

    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}