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
    basePrice           DECIMAL(10, 2),
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
    description TEXT        NULL
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
    description TEXT        NULL
);
CREATE TABLE role_permissions
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    roleId       INT NOT NULL,
    permissionId INT NOT NULL,
    FOREIGN KEY (roleId) REFERENCES roles (id) ON DELETE CASCADE,
    FOREIGN KEY (permissionId) REFERENCES permissions (id) ON DELETE CASCADE
);
CREATE TABLE audit_logs
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    userId       INT          NOT NULL,
    activityType VARCHAR(100) NOT NULL,
    timestamp    DATETIME DEFAULT CURRENT_TIMESTAMP,
    description  TEXT         NULL
);
CREATE TABLE two_factor_auth
(
    userId           INT PRIMARY KEY,
    method           TINYINT, -- 0: SMS, 1: Email
    verificationCode VARCHAR(10) NOT NULL,
    expiryDate       DATETIME    NOT NULL
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
    totalAmount   DECIMAL(10, 2) NOT NULL,
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
    basePrice  DECIMAL(10, 2), -- Giá gốc của sản phẩm
    finalPrice DECIMAL(13, 2), -- Giá cuối sau khi tính color/addon và sale
    createdAt  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE posts
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(255),
    content    TEXT,
    userId     INT,
    image      VARCHAR(255),
    viewsCount INT,
    status     TINYINT   DEFAULT 1,
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

CREATE TABLE inventory_transactions
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    product_variant_id INT,
    quantity INT,
    type TINYINT,
    note TEXT,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inventory_receipts
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    referenceNo VARCHAR(50) COMMENT 'Số tham chiếu, mã phiếu nhập',
    receiptDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status      TINYINT   DEFAULT 1 COMMENT '0: Draft, 1: Completed, 2: Cancelled',
    note        TEXT,
    createdBy   INT NOT NULL,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (createdBy) REFERENCES users (id)
);

CREATE TABLE inventory_receipt_items
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    receiptId INT            NOT NULL,
    productId INT            NOT NULL,
    variantId INT,
    quantity  INT            NOT NULL,
    unitPrice DECIMAL(10, 2) NOT NULL,
    note      TEXT,
    FOREIGN KEY (receiptId) REFERENCES inventory_receipts (id),
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id)
);

CREATE TABLE inventory_issues
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    referenceNo VARCHAR(50) COMMENT 'Số tham chiếu, mã phiếu xuất',
    issueDate   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason      TINYINT NOT NULL COMMENT '0: Bán hàng, 1: Hủy hàng lỗi, 2: Khác',
    orderId     INT COMMENT 'Liên kết với đơn hàng nếu lý do là bán hàng',
    status      TINYINT   DEFAULT 1 COMMENT '0: Draft, 1: Completed, 2: Cancelled',
    note        TEXT,
    createdBy   INT     NOT NULL,
    createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (createdBy) REFERENCES users (id),
    FOREIGN KEY (orderId) REFERENCES orders (id)
);

CREATE TABLE inventory_issue_items
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    issueId   INT NOT NULL,
    productId INT NOT NULL,
    variantId INT,
    quantity  INT NOT NULL,
    note      TEXT,
    FOREIGN KEY (issueId) REFERENCES inventory_issues (id),
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id)
);

CREATE TABLE damaged_products
(
    id           INT AUTO_INCREMENT PRIMARY KEY,
    productId    INT          NOT NULL,
    variantId    INT,
    quantity     INT          NOT NULL,
    reason       VARCHAR(255) NOT NULL,
    status       TINYINT   DEFAULT 0 COMMENT '0: Chờ xử lý, 1: Đã xử lý',
    reportDate   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolvedDate TIMESTAMP    NULL,
    reportedBy   INT          NOT NULL,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id),
    FOREIGN KEY (reportedBy) REFERENCES users (id)
);

CREATE TABLE inventory_history
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    productId      INT         NOT NULL,
    variantId      INT,
    quantityChange INT         NOT NULL COMMENT 'Thay đổi số lượng, có thể âm hoặc dương',
    referenceType  VARCHAR(20) NOT NULL COMMENT 'receipt, issue, damaged, order, adjustment',
    referenceId    INT         NOT NULL COMMENT 'ID của bảng liên quan',
    stockBefore    INT         NOT NULL COMMENT 'Số lượng tồn trước khi thay đổi',
    stockAfter     INT         NOT NULL COMMENT 'Số lượng tồn sau khi thay đổi',
    note           TEXT,
    createdBy      INT         NOT NULL,
    createdAt      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id),
    FOREIGN KEY (createdBy) REFERENCES users (id)
);

CREATE TABLE stock_alerts
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    productId       INT NOT NULL,
    variantId       INT,
    alertType       TINYINT NOT NULL COMMENT '0: Low Stock, 1: High Stock, 2: Expiring Soon',
    threshold       INT NOT NULL,
    status          TINYINT DEFAULT 0 COMMENT '0: Active, 1: Resolved',
    createdAt       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolvedAt      TIMESTAMP NULL,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id)
);

CREATE TABLE stock_forecasts
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    productId       INT NOT NULL,
    variantId       INT,
    forecastDate    DATE NOT NULL,
    predictedStock  INT NOT NULL,
    confidence      DECIMAL(5,2) NOT NULL,
    createdAt       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id)
);

CREATE TABLE stock_movements
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    productId       INT NOT NULL,
    variantId       INT,
    movementType    TINYINT NOT NULL COMMENT '0: Receipt, 1: Issue, 2: Damage, 3: Adjustment',
    quantity        INT NOT NULL,
    referenceId     INT NOT NULL,
    referenceType   VARCHAR(20) NOT NULL,
    note            TEXT,
    createdBy       INT NOT NULL,
    createdAt       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id),
    FOREIGN KEY (createdBy) REFERENCES users (id)
);

CREATE TABLE stock_audits
(
    id              INT AUTO_INCREMENT PRIMARY KEY,
    productId       INT NOT NULL,
    variantId       INT,
    systemStock     INT NOT NULL,
    physicalStock   INT NOT NULL,
    difference      INT NOT NULL,
    auditDate       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    auditorId       INT NOT NULL,
    note            TEXT,
    FOREIGN KEY (productId) REFERENCES products (id),
    FOREIGN KEY (variantId) REFERENCES product_variants (id),
    FOREIGN KEY (auditorId) REFERENCES users (id)
);
