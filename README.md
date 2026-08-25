# 🛒 Online Shopping Cart

A Java-based Online Shopping Cart web application developed using **Java, JSP, Jakarta Servlets, JDBC, MySQL, HTML, CSS, and JavaScript**. The project demonstrates the core concepts of Java web development by implementing product browsing, shopping cart management, and database integration using the MVC architecture.

----

# 📖 Project Overview

The Online Shopping Cart application allows users to browse products, add them to a shopping cart, update quantities, remove items, and view the total amount. The application uses JSP for the user interface, Jakarta Servlets for business logic, JDBC for database connectivity, and MySQL for storing product and cart information.

---

# ✨ Features

* Browse available products
* Add products to the shopping cart
* Update product quantity
* Remove products from the cart
* Calculate total price automatically
* Session-based shopping cart
* MySQL database integration
* MVC architecture

---

# 🛠️ Tech Stack

| Technology         | Description           |
| ------------------ | --------------------- |
| Java 17            | Backend               |
| JSP                | View Layer            |
| Jakarta Servlets   | Controller            |
| JDBC               | Database Connectivity |
| MySQL              | Database              |
| HTML5              | Structure             |
| CSS3               | Styling               |
| JavaScript         | Client-side           |
| Apache Tomcat 10   | Web Server            |
| Maven              | Build Tool            |
| Visual Studio Code | IDE                   |

---

# 📂 Project Structure

```text
online-shopping-cart/
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── dao/
│       │   ├── model/
│       │   ├── servlet/
│       │   └── util/
│       │
│       └── webapp/
│           ├── css/
│           ├── images/
│           ├── js/
│           ├── WEB-INF/
│           └── *.jsp
│
├── database/
│   └── shopping_cart.sql
│
├── pom.xml
└── README.md
```

---

# 💾 Database Setup

## Step 1: Install MySQL

Download and install MySQL Server.

---

## Step 2: Create Database

```sql
CREATE DATABASE shopping_cart;
USE shopping_cart;
```

---

## Step 3: Import Database

If the repository contains the SQL file:

```
database/shopping_cart.sql
```

Import it using **MySQL Workbench**.

**OR**

Open **phpMyAdmin**

* Create a database named **shopping_cart**
* Click **Import**
* Select **shopping_cart.sql**
* Click **Go**

---

## Step 4: Configure Database Connection

Update your database credentials in the JDBC connection class.

```java
String url = "jdbc:mysql://localhost:3306/shopping_cart";
String username = "root";
String password = "your_password";
```

---

# 🚀 Run the Project

## Method 1 – Download ZIP

1. Download the ZIP from GitHub.
2. Extract the ZIP file.
3. Open the project in **Visual Studio Code**.
4. Install:

   * Java JDK 17+
   * Extension Pack for Java
   * Maven
   * Apache Tomcat 10
   * MySQL Server
5. Import the database.
6. Update the database username and password.
7. Build the project.

```bash
mvn clean install
```

8. Deploy the project to Apache Tomcat.
9. Start Tomcat.
10. Open your browser.

```
http://localhost:8080/online-shopping-cart/
```

---

## Method 2 – Clone from GitHub

```bash
git clone https://github.com/Srinath2786/online-Shopping-cart.git
```

Open the project in Visual Studio Code and follow the same steps above.

---

# 📦 Build Project

```bash
mvn clean install
```

Generated WAR file:

```
target/online-shopping-cart.war
```

---

# 🌐 Application URL

```
http://localhost:8080/online-shopping-cart/
```

---

# 📚 Learning Outcomes

* Java Web Development
* JSP
* Jakarta Servlets
* JDBC
* CRUD Operations
* Session Management
* MVC Architecture
* MySQL Integration
* Maven Project Structure
* Apache Tomcat Deployment

---

# 🚀 Future Enhancements

* User Login & Registration
* Admin Dashboard
* Product Search
* Product Categories
* Wishlist
* Order History
* Online Payment Gateway
* Responsive Design

---

# 👨‍💻 Author

**Srinath M**

B.E. Computer Science and Engineering

GitHub: https://github.com/Srinath2786

---

⭐ If you found this project helpful, please consider giving it a Star.
