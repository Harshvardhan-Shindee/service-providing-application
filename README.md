# 🧰 Service Provider Web Application (Java, JSP, JDBC, MySQL)

A scalable and modular **Service Provider Booking System** built using **Java (JSP + Servlets)**, **JDBC**, and **MySQL**, with a clean DAO architecture. Users can book services, providers can manage requests, and admins can oversee all activities.

---

## 🔍 Project Overview

This web application facilitates an  platform where:

- 🧑 Users can register, log in, browse services, and make bookings.
- 🧑‍🔧 Providers can manage their profiles, list services, and handle work requests.
- 👨‍💼 Admins can manage all users, providers, and services.

Built using **JSP/Servlets + JDBC DAO**, with parts optionally using **Hibernate ORM** for better scalability and maintainability.

---

## 🧩 Features

### 👥 Authentication
- Separate registration/login for Users and Providers
- Password-protected authentication using JDBC

### 🧑‍💻 User Dashboard
- View all available services (displayed as cards)
- Book a service and see booking status
- View past/completed bookings

### 🛠️ Provider Dashboard
- Create new service listings
- View/manage pending work requests
- Mark work as completed
- Delete services

### 🛡️ Admin Panel (optional)
- View/manage all users and providers
- Access all services and booking data

---

## 🛠️ Tech Stack

| Layer           | Technology                 |
|-----------------|----------------------------|
| Frontend        | HTML, CSS, Bootstrap, JSP  |
| Backend         | Java Servlets, JSP, JDBC   |
| Database        | MySQL 8.x                  |
| ORM (Optional)  | Hibernate (used partially) |
| IDE             | NetBeans                   |
| Server          | Apache Tomcat              |

---

## 🗂️ Project Structure

service-providing-application/

├── src/ # Java files (model, DAO, servlets)

├── web/ # JSP files (login, dashboard, etc.)

├── database/

│ └── pronest/ # MySQL dump folder (with schema & tables)

├── nbproject/ # NetBeans config

├── README.md # Documentation

---

## 📦 Installation Guide

1. 📥 Clone the Repository

2. 🔧 Import into NetBeans 

Open NetBeans

File > Open Project → Select this folder

3. 🛢️ MySQL Database Setup

Open MySQL Workbench

Go to Server > Data Import

Choose:

Import from Folder

Select: database/pronest/

Import dump with structure and data

✅ This will auto-create the schema and all tables

4. 🖥️ DB Configuration

Edit DBConnection.java (or equivalent):

5. 🚀 Run the Project

Start Apache Tomcat

Right-click project → Run

Visit: http://localhost:8080/YourProjectName/

---

## 📌 Core Functionalities

|     Module	    |                 Functionality                |
|-----------------|----------------------------------------------|
| User            | 	Register, Login, View Services, Bookings   |
| Provider        |   Register, Login, Create/Delete Services    |
| Booking	        |   Make booking, Mark as complete             |
| Request         |   Pending requests, Completed Requests       |
| Admin (opt)	    |   Manage users, providers, and all data      |
| DAO Layer	      |   Full CRUD implemented for all entities     |
| ORM Layer	      |   (Optional) Hibernate configuration ready   |

---

## 🧾 SQL Dump Info

Located in: database/pronest/

Contains schema + all table definitions

Easily restorable via MySQL Workbench

---

📬 Author

👤 Harshvardhan Shinde

🔗 GitHub: Harshvardhan-Shindee


If this project helped you or inspired your own, consider giving it a ⭐ on GitHub!

