CREATE DATABASE shopX;

CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(100) NOT NULL,
       email VARCHAR(100) NOT NULL,
       password VARCHAR(255) NOT NULL
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

CREATE TABLE cart (
          id INT AUTO_INCREMENT PRIMARY KEY,
          user_id INT NOT NULL,
          product_id INT NOT NULL,
          quantity INT NOT NULL DEFAULT 1,
          price DECIMAL(10, 2) NOT NULL,
          added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

          FOREIGN KEY (product_id) REFERENCES products(product_id),
          FOREIGN KEY (user_id) REFERENCES users(id)
);


# vendor's tables

CREATE TABLE vendors (
         id INT AUTO_INCREMENT PRIMARY KEY,
         store_name VARCHAR(100) NOT NULL,
         username VARCHAR(50) NOT NULL UNIQUE,
         email VARCHAR(100) NOT NULL UNIQUE,
         password VARCHAR(255) NOT NULL,
         business_id VARCHAR(50),
         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vendorpendingverifications (
        verificationID int(11) NOT NULL,
        companyName varchar(50) NOT NULL,
        businessAddress varchar(50) NOT NULL,
        businessEmail varchar(50) NOT NULL,
        businessContactNo varchar(10) NOT NULL,
        businessRegNo varchar(10) NOT NULL,
        vendorID int(11) NOT NULL,
        type varchar(10) NOT NULL,
        requestedAt date NOT NULL DEFAULT current_timestamp(),
        cardType varchar(10) DEFAULT NULL,
        cardNo varchar(25) DEFAULT NULL,
        cardEXP date DEFAULT NULL,
        cardCVN varchar(4) DEFAULT NULL,
        verificationStatus varchar(20) DEFAULT 'none',
        CONSTRAINT fk1 FOREIGN KEY (vendorID) REFERENCES vendors(id)
);

