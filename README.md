# Online Shopping Cart JSP Application

A polished online shopping cart prototype implemented with Jakarta JSP, MySQL, and Apache Tomcat. This project demonstrates a full-stack e-commerce cart flow with product listing, cart management, quantity updates, and secure database persistence.

## Project Overview

This repository contains a Java-based web application built for a professional shopping cart experience. It is designed to showcase:

- Responsive shopping cart UI using JSP
- MySQL-backed cart item management
- JDBC connection pooling for scalable database access
- Deployment via Apache Tomcat or Maven plugin
- Clean modular architecture for enterprise-style web apps

## Key Features

- Display cart items from a relational database
- Add, update, and remove cart products
- Quantity handling and total pricing
- Seamless front-end interaction using JSP pages
- Transaction persistence with MySQL
- Production-ready packaging as WAR

## Technical Stack

- Java 17+
- Jakarta Servlet / JSP
- Apache Tomcat 10+
- Maven build system
- MySQL database
- JDBC / connection pooling

## Setup Instructions

### 1. Prerequisites

- Java 17 or later
- Apache Tomcat 10.x or newer
- MySQL Server
- Maven 3.8+

### 2. Initialize Database

Run the provided schema script:

```bash
mysql -u root -p < src/main/resources/schema.sql
```

Or execute manually:

```sql
CREATE DATABASE IF NOT EXISTS cart_db;
USE cart_db;

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

INSERT INTO cart_items (name, sku, image_url, price, quantity) VALUES
('Wireless Headphones', 'SKU-1001', 'https://picsum.photos/80?1', 89.99, 1),
('Mechanical Keyboard', 'SKU-1002', 'https://picsum.photos/80?2', 129.50, 2),
('Ergonomic Mouse', 'SKU-1003', 'https://picsum.photos/80?3', 49.95, 1);
```

### 3. Configure Database Connection

Update `src/main/resources/database.properties` with your credentials:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/cart_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.username=root
db.password=your_mysql_password
db.pool.size=10
```

### 4. Build the Project

```bash
mvn clean package
```

The build generates the deployable WAR file at:

```bash
target/cart-jsp.war
```

### 5. Deploy to Tomcat

Copy the WAR file to Tomcat's webapps directory:

```bash
cp target/cart-jsp.war $CATALINA_HOME/webapps/
```

Start Tomcat and access the app:

```bash
http://localhost:8080/cart-jsp/
```

## Deployment Options

- Deploy using Apache Tomcat
- Use Maven Tomcat plugin for direct deployment

## Application URLs

- Home: `http://localhost:8080/cart-jsp/`
- Cart endpoint: `http://localhost:8080/cart-jsp/cart`

## Recommended Repository Name

- `online-shopping-cart-jsp`
- `shopping-cart-webapp`
- `java-shopping-cart`

## Recommended GitHub Description

`Professional online shopping cart application built with Java JSP, MySQL, and Tomcat. Supports cart management, quantity updates, and persistent database storage.`

## Notes

- Keep database credentials out of source control.
- Use Maven to manage dependencies and packaging.
- This project is suitable for portfolio presentation and academic submission.
