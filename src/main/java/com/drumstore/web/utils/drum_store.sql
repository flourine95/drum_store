-- Tạo bảng categories
drop database drum_store;
create database drum_store;

CREATE TABLE categories
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    image       VARCHAR(255),
    description TEXT,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletedAt   TIMESTAMP DEFAULT NULL
);

-- Tạo bảng brands
CREATE TABLE brands
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    image       VARCHAR(255),
    description TEXT,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletedAt   TIMESTAMP DEFAULT NULL
);

-- Tạo bảng products
CREATE TABLE products
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100),
    description   TEXT,
    price         DECIMAL(10, 2),
    stock         INT,
    totalViews    INT            DEFAULT 0,
    isFeatured    TINYINT(1)     DEFAULT 0,
    status        TINYINT        DEFAULT 1,
    averageRating DECIMAL(10, 2) DEFAULT NULL,
    slug          VARCHAR(191) NOT NULL UNIQUE,
    categoryId    INT,
    brandId       INT,
    createdAt     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updatedAt     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletedAt     TIMESTAMP      DEFAULT NULL,
    FOREIGN KEY (categoryId) REFERENCES categories (id),
    FOREIGN KEY (brandId) REFERENCES brands (id)
);

-- Tạo bảng product_images
CREATE TABLE product_images
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    image     VARCHAR(255) DEFAULT NULL,
    isMain    TINYINT(1)   DEFAULT 0,
    productId INT,
    FOREIGN KEY (productId) REFERENCES products (id)
);

-- Tạo bảng product_colors
CREATE TABLE product_colors
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    colorCode VARCHAR(7)   DEFAULT NULL,
    colorName VARCHAR(100) DEFAULT NULL,
    productId INT,
    FOREIGN KEY (productId) REFERENCES products (id)
);
