CREATE DATABASE shopX;

CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(100) NOT NULL,
       email VARCHAR(100) NOT NULL,
       password VARCHAR(255) NOT NULL
);

CREATE TABLE vendors (
         id INT AUTO_INCREMENT PRIMARY KEY,
         store_name VARCHAR(100) NOT NULL,
         username VARCHAR(50) NOT NULL UNIQUE,
         email VARCHAR(100) NOT NULL UNIQUE,
         password VARCHAR(255) NOT NULL,
         business_id VARCHAR(50),
         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
