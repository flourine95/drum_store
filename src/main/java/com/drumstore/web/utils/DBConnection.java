package com.drumstore.web.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DBConnection {
    private static final Logger logger = LoggerFactory.getLogger(DBConnection.class);
    private static volatile Jdbi jdbi;
    private static HikariDataSource dataSource;

    private DBConnection() {
    }

    static {
        Runtime.getRuntime().addShutdownHook(new Thread(DBConnection::closeDataSource));
    }

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            synchronized (DBConnection.class) {
                if (jdbi == null) {
                    initializeJdbi();
                }
            }
        }
        return jdbi;
    }

    private static void initializeJdbi() {
        HikariConfig config = createHikariConfig();
        setupDataSource(config);
    }

    private static HikariConfig createHikariConfig() {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(ConfigUtils.get("database.url"));
        config.setUsername(ConfigUtils.get("database.username"));
        config.setPassword(ConfigUtils.get("database.password"));
        config.setDriverClassName(ConfigUtils.get("database.driverClassName"));

        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setIdleTimeout(300000);
        config.setMaxLifetime(1800000);
        config.setConnectionTimeout(30000);
        config.setValidationTimeout(5000);

        config.setConnectionTestQuery("SELECT 1");
        config.setPoolName("DrumStorePool");

        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        config.addDataSourceProperty("useServerPrepStmts", "true");

        return config;
    }

    private static void setupDataSource(HikariConfig config) {
        try {
            dataSource = new HikariDataSource(config);
            jdbi = Jdbi.create(dataSource);
            logger.info("Database connection pool initialized successfully");
        } catch (Exception e) {
            logger.error("Failed to initialize database connection pool", e);
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    public static void closeDataSource() {
        if (dataSource != null && !dataSource.isClosed()) {
            try {
                dataSource.getHikariPoolMXBean().softEvictConnections();
                Thread.sleep(100);
                dataSource.close();
                logger.info("Database connection pool closed successfully");
            } catch (Exception e) {
                logger.error("Error closing database connection pool", e);
            }
        }
    }
}