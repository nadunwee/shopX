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
         profilePhoto LONGBLOB
);

CREATE TABLE products (
          product_id INT AUTO_INCREMENT PRIMARY KEY,
          name VARCHAR(255) NOT NULL,
          price DECIMAL(10, 2) NOT NULL,
          image VARCHAR(512),
          stock INT DEFAULT 0,
          additional_details TEXT,
          category VARCHAR(100),
          rating DECIMAL(2,1) DEFAULT 0.0,
          vendor VARCHAR(255),
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
