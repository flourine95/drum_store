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
CREATE TABLE sales
(
    id                 INT PRIMARY KEY,
    name               VARCHAR(100)  NOT NULL,
    description        TEXT,
    discountPercentage DECIMAL(5, 2) NOT NULL,
    startDate          DATE          NOT NULL,
    endDate            DATE          NOT NULL,
    createdAt          TIMESTAMP,
    updatedAt          TIMESTAMP
);
CREATE TABLE password_resets
(
    id        INT PRIMARY KEY,
    email     VARCHAR(100),
    token     VARCHAR(100),
    createdAt TIMESTAMP,
    expiresAt TIMESTAMP
);


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
    deletedAt     TIMESTAMP      DEFAULT NULL
);
CREATE TABLE users
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    email         VARCHAR(100) UNIQUE,
    password      VARCHAR(255),
    fullname      VARCHAR(100),
    role          TINYINT,
    phone       VARCHAR(20),
    status        TINYINT,
    avatar        VARCHAR(255),
    oauthProvider VARCHAR(50),
    oauthId       VARCHAR(255),
    emailVerified TINYINT(1),
    createdAt     TIMESTAMP,
    updatedAt     TIMESTAMP,
    deletedAt     TIMESTAMP
);
CREATE TABLE product_images
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    image     VARCHAR(255) DEFAULT NULL,
    isMain    TINYINT(1)   DEFAULT 0,
    productId INT
);

CREATE TABLE product_colors
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    colorCode VARCHAR(7)   DEFAULT NULL,
    colorName VARCHAR(100) DEFAULT NULL,
    productId INT
);

CREATE TABLE user_addresses
(
    id         INT,
    userId     INT,
    address    TEXT,
    phone      VARCHAR(20),
    provinceId INT,
    districtId INT,
    wardId     INT,
    isDefault  TINYINT
);
CREATE TABLE wishlist
(
    id        INT,
    userId    INT,
    productId INT,
    addedAt   TIMESTAMP,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP
);
CREATE TABLE user_vouchers
(
    id        INT,
    userId    INT,
    voucherId INT,
    used      TINYINT,
    usedAt    TIMESTAMP NULL,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP
);
CREATE TABLE orders
(
    id            INT,
    userId        INT,
    userAddressId INT,
    totalAmount   DECIMAL(10, 2) NOT NULL,
    orderDate     TIMESTAMP,
    status        TINYINT,
    createdAt     TIMESTAMP,
    updatedAt     TIMESTAMP,
    deletedAt     TIMESTAMP
);
CREATE TABLE product_reviews
(
    id           INT,
    productId    INT,
    userId       INT,
    rating       TINYINT,
    reviewText   TEXT,
    isVerified   TINYINT,
    helpfulVotes INT,
    createdAt    TIMESTAMP,
    updatedAt    TIMESTAMP,
    deletedAt    TIMESTAMP NULL
);
CREATE TABLE posts
(
    id          INT,
    title       VARCHAR(255) NOT NULL,
    slug        VARCHAR(255),
    content     TEXT         NOT NULL,
    userId      INT,
    isPublished TINYINT,
    publishedAt TIMESTAMP    NULL,
    viewsCount  INT,
    tags        VARCHAR(255),
    createdAt   TIMESTAMP,
    updatedAt   TIMESTAMP,
    deletedAt   TIMESTAMP    NULL
);


-- Bảng vouchers
CREATE TABLE vouchers
(
    id               INT PRIMARY KEY,
    code             VARCHAR(50),
    description      TEXT,
    discountType     TINYINT,
    discountValue    DECIMAL(10, 2),
    minOrderValue    DECIMAL(10, 2),
    maxDiscountValue DECIMAL(10, 2),
    startDate        TIMESTAMP,
    endDate          TIMESTAMP,
    usageLimit       INT,
    perUserLimit     INT,
    status           TINYINT,
    createdAt        TIMESTAMP,
    updatedAt        TIMESTAMP,
    deletedAt        TIMESTAMP
);

-- Bảng post_images
CREATE TABLE post_images
(
    id           INT PRIMARY KEY,
    blogPostId   INT,
    imageUrl     VARCHAR(255),
    isFeatured   TINYINT(1),
    description  VARCHAR(255),
    displayOrder INT,
    createdAt    TIMESTAMP,
    updatedAt    TIMESTAMP
);

-- Bảng order_items
CREATE TABLE order_items
(
    id        INT PRIMARY KEY,
    orderId   INT,
    productId INT,
    quantity  INT NOT NULL,
    price     DECIMAL(10, 2),
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP
);

-- Bảng provinces
CREATE TABLE provinces
(
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Bảng districts
CREATE TABLE districts
(
    id         INT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    provinceId INT
);

-- Bảng wards
CREATE TABLE wards
(
    id         INT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    districtId INT
);



CREATE TABLE product_sales
(
    id        INT PRIMARY KEY,
    productId INT,
    saleId    INT,
    createdAt TIMESTAMP,
    updatedAt TIMESTAMP
);

CREATE TABLE payments
(
    id            INT PRIMARY KEY,
    orderId       INT,
    paymentMethod TINYINT,
    status        TINYINT,
    transactionId VARCHAR(100),
    amount        DECIMAL(10, 2) NOT NULL,
    paymentDate   TIMESTAMP,
    createdAt     TIMESTAMP,
    updatedAt     TIMESTAMP
);

