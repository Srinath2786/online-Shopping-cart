-- Create the database
CREATE DATABASE IF NOT EXISTS cart_db;
USE cart_db;

-- Create cart_items table
CREATE TABLE IF NOT EXISTS cart_items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(50) NOT NULL,
    image_url VARCHAR(500),
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sku VARCHAR(50) NOT NULL,
    image_url VARCHAR(500),
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(500),
    badge VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO cart_items (name, sku, image_url, price, quantity) VALUES
('Wireless Headphones', 'SKU-1001', 'https://picsum.photos/80?1', 89.99, 1),
('Mechanical Keyboard', 'SKU-1002', 'https://picsum.photos/80?2', 129.50, 2),
('Ergonomic Mouse', 'SKU-1003', 'https://picsum.photos/80?3', 49.95, 1);

-- Insert sample products
INSERT INTO products (name, sku, image_url, price, description, badge) VALUES
('Wireless Headphones', 'SKU-1001', 'https://picsum.photos/640/480?random=11', 89.99, '40-hour battery, studio-tuned sound', 'Top pick'),
('Mechanical Keyboard', 'SKU-1002', 'https://picsum.photos/640/480?random=12', 129.50, 'Hot-swap switches, aluminum frame', 'New'),
('Ergonomic Mouse', 'SKU-1003', 'https://picsum.photos/640/480?random=13', 49.95, 'Comfort grip with precision tracking', NULL),
('USB-C Cable', 'SKU-1004', 'https://picsum.photos/640/480?random=14', 12.99, 'Braided 2m cable, fast charging', 'Bundle'),
('Portable SSD 1TB', 'SKU-1005', 'https://picsum.photos/640/480?random=15', 149.00, 'High-speed transfers for creators', 'Sale'),
('Desk Lamp', 'SKU-1006', 'https://picsum.photos/640/480?random=16', 34.75, 'Warm light with touch dimmer', NULL);
