# drop database drum_store;
# create database drum_store;
CREATE TABLE categories
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    image       VARCHAR(255),
    description TEXT,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE brands
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    image       VARCHAR(255),
    description TEXT,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE sales
(
    id                 INT AUTO_INCREMENT PRIMARY KEY,
    name               VARCHAR(100)  NOT NULL,
    description TEXT,
    discountPercentage DECIMAL(5, 2) NOT NULL,
    startDate          DATE          NOT NULL,
    endDate            DATE          NOT NULL
);


CREATE TABLE password_resets
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    userId     INT          NOT NULL,
    token      VARCHAR(100) NOT NULL,
    expiryTime TIMESTAMP    NOT NULL,
    used       BOOLEAN   DEFAULT FALSE,
    usedAt     TIMESTAMP    NULL,
    createdAt  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products
(
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    name                VARCHAR(100),
    description         TEXT,
    basePrice           DECIMAL(13, 2),
    totalViews          INT       DEFAULT 0,
    featured            BOOLEAN   DEFAULT FALSE,
    status              TINYINT   DEFAULT 1,
    stockManagementType TINYINT   DEFAULT 0 COMMENT '0: Simple, 1: Color Only, 2: Addon Only, 3: Color and Addon',
    categoryId          INT,
    brandId             INT,
    createdAt           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE product_images
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    productId INT          NOT NULL,
    image     VARCHAR(255) NOT NULL,
    main      BOOLEAN   DEFAULT FALSE,
    sortOrder INT       DEFAULT 0,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE product_colors
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    productId       INT         NOT NULL,
    name            VARCHAR(50) NOT NULL,
    additionalPrice DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE product_addons
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    productId       INT          NOT NULL,
    name            VARCHAR(100) NOT NULL,
    additionalPrice DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE product_reviews
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    productId INT           NOT NULL,
    userId    INT           NOT NULL,
    orderId   INT           NOT NULL,
    rating    DECIMAL(2, 1) NOT NULL, -- Thang điểm từ 1.0 đến 5.0
    content   TEXT,
    status    TINYINT   DEFAULT 1,    -- 0: Chờ duyệt, 1: Đã duyệt, 2: Từ chối
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE product_variants
(
    id                INT PRIMARY KEY AUTO_INCREMENT,
    productId         INT NOT NULL,
    colorId           INT,
    addonId           INT,
    imageId           INT,
    stock             INT       DEFAULT 0,
    currentStock      INT       DEFAULT 0,
    lowStockThreshold INT       DEFAULT 10,
    lastStockUpdate   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status            TINYINT   DEFAULT 1,
    createdAt         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE review_images
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    reviewId  INT          NOT NULL,
    image     VARCHAR(255) NOT NULL,
    sortOrder INT       DEFAULT 0,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    email     VARCHAR(100) UNIQUE,
    password  VARCHAR(255),
    fullname  VARCHAR(100),
    provider     VARCHAR(50),
    provider_id  VARCHAR(100),
    phone     VARCHAR(25),
    status    TINYINT DEFAULT 1,
    avatar    VARCHAR(255),
    createdAt TIMESTAMP
);

CREATE TABLE roles
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50) NOT NULL UNIQUE,
    description TEXT        NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    roleId INT NOT NULL,
    FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (roleId) REFERENCES roles (id) ON DELETE CASCADE
);

CREATE TABLE permissions
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50) NOT NULL UNIQUE,
    description TEXT        NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE role_permissions
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    roleId       INT NOT NULL,
    permissionId INT NOT NULL,
    FOREIGN KEY (roleId) REFERENCES roles (id) ON DELETE CASCADE,
    FOREIGN KEY (permissionId) REFERENCES permissions (id) ON DELETE CASCADE
);

CREATE TABLE user_addresses
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    userId     INT,
    fullname   VARCHAR(100),
    address    TEXT,
    phone      VARCHAR(25),
    provinceId INT,
    districtId INT,
    wardId     INT,
    main       BOOLEAN DEFAULT FALSE
);

CREATE TABLE wishlist
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userId    INT,
    productId INT,
    createdAt TIMESTAMP
);

CREATE TABLE user_vouchers
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userId    INT,
    voucherId INT,
    used      BOOLEAN   DEFAULT FALSE,
    usedAt    TIMESTAMP NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    userId        INT,
    userAddressId INT,
    totalAmount   DECIMAL(13, 2) NOT NULL,
    orderDate     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status        TINYINT,
    createdAt     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    orderId    INT,
    variantId  INT,            -- Variant bao gồm cả productId
    quantity   INT NOT NULL,
    basePrice  DECIMAL(13, 2), -- Giá gốc của sản phẩm
    finalPrice DECIMAL(13, 2), -- Giá cuối sau khi tính color/addon và sale
    createdAt  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vouchers
(
    id               INT AUTO_INCREMENT PRIMARY KEY,
    code             VARCHAR(50),
    description      TEXT,
    discountType     TINYINT,
    discountValue    DECIMAL(10, 2),
    minOrderValue    DECIMAL(10, 2),
    maxDiscountValue DECIMAL(10, 2),
    startDate        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    endDate          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usageLimit       INT,
    perUserLimit     INT,
    status           TINYINT,
    createdAt        TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE provinces
(
    id   INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE districts
(
    id         INT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    provinceId INT
);

CREATE TABLE wards
(
    id         INT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    districtId INT
);

CREATE TABLE product_sales
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    productId INT,
    saleId    INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    orderId       INT,
    paymentMethod TINYINT,
    status        TINYINT,
    transactionId VARCHAR(100),
    amount        DECIMAL(10, 2) NOT NULL,
    paymentDate   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    createdAt     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE logs
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userId    INT,
    level     INT,
    action    VARCHAR(255),
    oldData   JSON,
    newData   JSON,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE carts
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    userId    INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id)
);

CREATE TABLE cartItems
(
    id  INT AUTO_INCREMENT PRIMARY KEY,
    cartId INT NOT NULL,
    productVariantId INT NOT NULL,
    quantity INT,
    FOREIGN KEY (cartId) REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (productVariantId) REFERENCES product_variants(id) ON DELETE CASCADE
)
