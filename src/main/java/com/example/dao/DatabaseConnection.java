package com.example.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.dbcp2.BasicDataSource;

public class DatabaseConnection {
    private static final Logger LOGGER = Logger.getLogger(DatabaseConnection.class.getName());
    private static BasicDataSource dataSource;
    private static boolean initialized = false;

    private static synchronized void initDataSource() {
        if (initialized && dataSource != null) {
            return;
        }

        try {
            Properties props = new Properties();
            try (InputStream input = DatabaseConnection.class.getClassLoader()
                    .getResourceAsStream("database.properties")) {
                if (input == null) {
                    LOGGER.warning("database.properties not found, using defaults");
                } else {
                    props.load(input);
                }
            }

            int poolSize = Integer.parseInt(props.getProperty("db.pool.size", "5"));
            try {
                BasicDataSource mysqlDataSource = createMySqlDataSource(props, poolSize);
                try (Connection conn = mysqlDataSource.getConnection()) {
                    initializeSchema(conn);
                }
                dataSource = mysqlDataSource;
                initialized = true;
                LOGGER.info("Database connection pool initialized successfully (MySQL)");
                return;
            } catch (SQLException mysqlError) {
                LOGGER.log(Level.WARNING,
                        "MySQL unavailable, switching to embedded H2 database: {0}",
                        mysqlError.getMessage());
            }

            BasicDataSource h2DataSource = createH2DataSource(poolSize);
            try (Connection conn = h2DataSource.getConnection()) {
                initializeSchema(conn);
            }
            dataSource = h2DataSource;
            initialized = true;
            LOGGER.info("Database connection pool initialized successfully (H2 fallback)");
        } catch (IOException e) {
            LOGGER.severe(String.format("Failed to load database.properties: %s", e.getMessage()));
            dataSource = null;
            initialized = false;
        } catch (NumberFormatException e) {
            LOGGER.severe(String.format("Failed to initialize database connection pool: %s", e.getMessage()));
            dataSource = null;
            initialized = false;
        } catch (SQLException e) {
            LOGGER.severe(String.format("Failed to initialize database schema: %s", e.getMessage()));
            dataSource = null;
            initialized = false;
        }
    }

    private static BasicDataSource createMySqlDataSource(Properties props, int poolSize) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName(props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver"));
        ds.setUrl(props.getProperty("db.url",
                "jdbc:mysql://localhost:3306/cart_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"));
        ds.setUsername(props.getProperty("db.username", "root"));
        ds.setPassword(props.getProperty("db.password", ""));
        ds.setInitialSize(poolSize);
        ds.setMaxTotal(poolSize);
        return ds;
    }

    private static BasicDataSource createH2DataSource(int poolSize) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("org.h2.Driver");
        ds.setUrl("jdbc:h2:file:./target/h2/cart_db;MODE=MySQL;DATABASE_TO_LOWER=TRUE;AUTO_SERVER=TRUE");
        ds.setUsername("sa");
        ds.setPassword("");
        ds.setInitialSize(poolSize);
        ds.setMaxTotal(poolSize);
        return ds;
    }

    public static Connection getConnection() throws SQLException {
        if (!initialized) {
            initDataSource();
        }
        if (dataSource == null) {
            throw new SQLException("Database connection pool not initialized");
        }
        return dataSource.getConnection();
    }

    public static void closeDataSource() throws SQLException {
        if (dataSource != null) {
            dataSource.close();
            dataSource = null;
            initialized = false;
        }
    }

    private static void initializeSchema(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS cart_items ("
                    + "id BIGINT AUTO_INCREMENT PRIMARY KEY,"
                    + "name VARCHAR(255) NOT NULL,"
                    + "sku VARCHAR(50) NOT NULL,"
                    + "image_url VARCHAR(500),"
                    + "price DECIMAL(10, 2) NOT NULL,"
                    + "quantity INT NOT NULL DEFAULT 1,"
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                    + ")");

            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS products ("
                    + "id BIGINT AUTO_INCREMENT PRIMARY KEY,"
                    + "name VARCHAR(255) NOT NULL,"
                    + "sku VARCHAR(50) NOT NULL,"
                    + "image_url VARCHAR(500),"
                    + "price DECIMAL(10, 2) NOT NULL,"
                    + "description VARCHAR(500),"
                    + "badge VARCHAR(50),"
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
                    + "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                    + ")");
        }

        if (!tableHasRows(conn, "products")) {
            String insertProducts = "INSERT INTO products (name, sku, image_url, price, description, badge) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertProducts)) {
                addProduct(stmt, "Wireless Headphones", "SKU-1001",
                        "https://picsum.photos/640/480?random=11", 89.99,
                        "40-hour battery, studio-tuned sound", "Top pick");
                addProduct(stmt, "Mechanical Keyboard", "SKU-1002",
                        "https://picsum.photos/640/480?random=12", 129.50,
                        "Hot-swap switches, aluminum frame", "New");
                addProduct(stmt, "Ergonomic Mouse", "SKU-1003",
                        "https://picsum.photos/640/480?random=13", 49.95,
                        "Comfort grip with precision tracking", null);
                addProduct(stmt, "USB-C Cable", "SKU-1004",
                        "https://picsum.photos/640/480?random=14", 12.99,
                        "Braided 2m cable, fast charging", "Bundle");
                addProduct(stmt, "Portable SSD 1TB", "SKU-1005",
                        "https://picsum.photos/640/480?random=15", 149.00,
                        "High-speed transfers for creators", "Sale");
                addProduct(stmt, "Desk Lamp", "SKU-1006",
                        "https://picsum.photos/640/480?random=16", 34.75,
                        "Warm light with touch dimmer", null);
            }
        }
    }

    private static boolean tableHasRows(Connection conn, String tableName) throws SQLException {
        String query = "SELECT COUNT(*) FROM " + tableName;
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    private static void addProduct(PreparedStatement stmt, String name, String sku,
            String imageUrl, double price, String description, String badge) throws SQLException {
        stmt.setString(1, name);
        stmt.setString(2, sku);
        stmt.setString(3, imageUrl);
        stmt.setDouble(4, price);
        stmt.setString(5, description);
        stmt.setString(6, badge);
        stmt.executeUpdate();
    }
}
