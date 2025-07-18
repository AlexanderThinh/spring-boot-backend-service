CREATE TYPE e_currency AS ENUM (
	'CHF',
	'EUR',
	'GBP',
	'JPY',
	'USD',
	'VND');

CREATE TYPE e_gender AS ENUM (
	'MALE',
	'FEMALE',
	'OTHER');

CREATE TYPE e_user_status AS ENUM (
	'ACTIVE',
	'INACTIVE',
	'BLOCKED',
	'NONE');

CREATE TYPE e_user_type AS ENUM (
	'OWNER',
	'ADMIN',
	'USER');

CREATE TYPE e_order_status AS ENUM (
	'NEW',
	'PENDING',
	'CANCELED',
	'PAID',
	'FAILED',
	'IN_PROGRESS',
	'DELIVERED',
	'CLOSED');

CREATE TYPE e_payment_method AS ENUM (
	'BANK_TRANSFER',
	'CARD',
	'DIGITAL_WALLET',
	'MONEY');

CREATE TYPE e_transaction_status AS ENUM (
	'CREATED',
	'SUCCEEDED',
	'CANCELED',
	'FAILED');

CREATE TYPE e_transaction_type AS ENUM (
	'IN',
	'OUT');

-- tbl_permission definition

-- Drop table

-- DROP TABLE tbl_permission;

CREATE TABLE tbl_permission
(
    id          serial4      NOT NULL,
    "name"      varchar(255) NOT NULL,
    description varchar(255) NULL,
    created_at  timestamp(6) DEFAULT NOW(),
    updated_at  timestamp(6) DEFAULT NOW(),
    CONSTRAINT tbl_permission_pkey PRIMARY KEY (id)
);


-- tbl_role definition

-- Drop table

-- DROP TABLE tbl_role;

CREATE TABLE tbl_role
(
    id          serial4      NOT NULL,
    "name"      varchar(255) NOT NULL,
    description varchar(255) NULL,
    created_at  timestamp(6) DEFAULT NOW(),
    updated_at  timestamp(6) DEFAULT NOW(),
    CONSTRAINT tbl_role_pkey PRIMARY KEY (id)
);


-- tbl_user definition

-- Drop table

-- DROP TABLE tbl_user;

CREATE TABLE tbl_user
(
    id            bigserial    NOT NULL,
    first_name    varchar(255) NOT NULL,
    last_name     varchar(255) NOT NULL,
    date_of_birth date         NOT NULL,
    "gender" "e_gender" NOT NULL,
    phone         varchar(15) NULL,
    email         varchar(255) NULL,
    username      varchar(255) NOT NULL,
    "password"    varchar(255) NULL,
    status "e_user_status" NOT NULL,
    "type" "e_user_type" NOT NULL,
    created_at    timestamp(6) DEFAULT now(),
    updated_at    timestamp(6) DEFAULT now(),
    CONSTRAINT tbl_user_pkey PRIMARY KEY (id)
);


-- tbl_address definition

-- Drop table

-- DROP TABLE tbl_address;

CREATE TABLE tbl_address
(
    id               bigserial NOT NULL,
    apartment_number varchar(255) NULL,
    floor            varchar(255) NULL,
    building         varchar(255) NULL,
    street_number    varchar(255) NULL,
    street           varchar(255) NULL,
    city             varchar(255) NULL,
    country          varchar(255) NULL,
    address_type     int4 NULL,
    user_id          int8 NULL,
    created_at       timestamp(6) DEFAULT now(),
    updated_at       timestamp(6) DEFAULT now(),
    CONSTRAINT tbl_address_pkey PRIMARY KEY (id),
    CONSTRAINT fk_address_to_user FOREIGN KEY (user_id) REFERENCES tbl_user (id)
);


-- tbl_group definition

-- Drop table

-- DROP TABLE tbl_group;

CREATE TABLE tbl_group
(
    id          serial4      NOT NULL,
    "name"      varchar(255) NOT NULL,
    role_id     serial4      NOT NULL,
    created_at  timestamp(6) DEFAULT NOW(),
    updated_at  timestamp(6) DEFAULT NOW(),
    description varchar(255) NULL,
    CONSTRAINT tbl_group_pkey PRIMARY KEY (id),
    CONSTRAINT fk_group_to_role FOREIGN KEY (role_id) REFERENCES tbl_role (id)
);


-- tbl_group_has_user definition

-- Drop table

-- DROP TABLE tbl_group_has_user;

CREATE TABLE tbl_group_has_user
(
    id          serial4      NOT NULL,
    group_id   int4 NULL,
    user_id    int8 NULL,
    created_at timestamp(6) DEFAULT NOW(),
    updated_at timestamp(6) DEFAULT NOW(),
    CONSTRAINT tbl_group_has_user_pkey PRIMARY KEY (id),
    CONSTRAINT fkk23xt6t0rhoc1s185sekeayf9 FOREIGN KEY (group_id) REFERENCES tbl_group (id),
    CONSTRAINT fkqpbvdln7wyp9dnjvrx0mrrnk1 FOREIGN KEY (user_id) REFERENCES tbl_user (id)
);


-- tbl_role_has_permission definition

-- Drop table

-- DROP TABLE tbl_role_has_permission;

CREATE TABLE tbl_role_has_permission
(
    id            serial4 NOT NULL,
    role_id       serial4 NOT NULL,
    permission_id serial4 NOT NULL,
    created_at    timestamp(6) DEFAULT NOW(),
    updated_at    timestamp(6) DEFAULT NOW(),
    CONSTRAINT tbl_role_has_permission_pkey PRIMARY KEY (id),
    CONSTRAINT fk_role_has_permission_to_permission FOREIGN KEY (permission_id) REFERENCES tbl_permission (id),
    CONSTRAINT fk_role_has_permission_to_role FOREIGN KEY (role_id) REFERENCES tbl_role (id)
);


-- tbl_user_has_role definition

-- Drop table

-- DROP TABLE tbl_user_has_role;

CREATE TABLE tbl_user_has_role
(
    id         serial4   NOT NULL,
    user_id    bigserial NOT NULL,
    role_id    serial4   NOT NULL,
    created_at timestamp(6) DEFAULT NOW(),
    updated_at timestamp(6) DEFAULT NOW(),
    CONSTRAINT tbl_user_has_role_pkey PRIMARY KEY (id),
    CONSTRAINT fk_user_has_role_to_role FOREIGN KEY (role_id) REFERENCES tbl_role (id),
    CONSTRAINT fk_user_has_role_to_user FOREIGN KEY (user_id) REFERENCES tbl_user (id)
);


CREATE TABLE tbl_categories
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Bảng: Sản phẩm
CREATE TABLE tbl_products
(
    id                SERIAL PRIMARY KEY,
    name              VARCHAR(255)       NOT NULL,
    sku               VARCHAR(50) UNIQUE NOT NULL,
    description       TEXT,
    category_id       SERIAL,
    price             DECIMAL(10, 2)     NOT NULL,
    quantity_in_stock INT                NOT NULL DEFAULT 0,
    created_at        TIMESTAMPTZ                 DEFAULT NOW(),
    updated_at        TIMESTAMPTZ                 DEFAULT NOW()
);

-- Bảng: Nhà cung cấp
CREATE TABLE tbl_suppliers
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    contact_name VARCHAR(255),
    phone        VARCHAR(15),
    email        VARCHAR(100),
    address      TEXT,
    created_at   TIMESTAMPTZ DEFAULT NOW(),
    updated_at   TIMESTAMPTZ DEFAULT NOW()
);

-- Bảng: Khách hàng
CREATE TABLE tbl_customers
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(255) NOT NULL,
    phone      VARCHAR(15),
    email      VARCHAR(100),
    address    TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Bảng: Giao dịch kho (Nhập/Xuất)
CREATE TABLE tbl_inventory_transactions (
	id          serial4      NOT NULL,
	product_id int8 NULL,
	quantity int8 NULL,
	"type" e_transaction_type NULL,
	reference_id int8 NULL,
	created_at timestamp(6) DEFAULT NOW(),
	updated_at timestamp(6) DEFAULT NOW(),
	CONSTRAINT tbl_inventory_transactions_pkey PRIMARY KEY (id)
);

-- Bảng: Đơn hàng mua từ nhà cung cấp
CREATE TABLE tbl_purchase_orders
(
    id           SERIAL PRIMARY KEY,
    supplier_id  INT            NOT NULL,
    order_date   DATE           NOT NULL,
    status       TEXT           NOT NULL CHECK (status IN ('PENDING', 'COMPLETED', 'CANCELLED')),
    total_amount DECIMAL(12, 2) NOT NULL,
    created_at   TIMESTAMPTZ DEFAULT NOW(),
    updated_at   TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (supplier_id) REFERENCES tbl_suppliers (id) ON DELETE SET NULL
);

-- Bảng: Chi tiết đơn hàng nhập
CREATE TABLE tbl_purchase_order_items
(
    id          SERIAL PRIMARY KEY,
    purchase_id INT            NOT NULL,
    product_id  INT            NOT NULL,
    quantity    INT            NOT NULL,
    price       DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES tbl_purchase_orders (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES tbl_products (id) ON DELETE CASCADE
);


-- tbl_sales_order_items definition

-- Drop table

-- DROP TABLE tbl_sales_order_items;

CREATE TABLE tbl_sales_order_items (
	id          serial4      NOT NULL,
	sales_id varchar(255) NOT NULL,
	product_id int8 NOT NULL,
	quantity int4 NOT NULL,
	price int8 NOT NULL,
	CONSTRAINT tbl_sales_order_items_pkey PRIMARY KEY (id)
);


-- tbl_sales_orders definition

-- Drop table

-- DROP TABLE tbl_sales_orders;

CREATE TABLE tbl_sales_orders (
	id varchar(255) NOT NULL,
	customer_id int8 NULL,
	total_amount int8 NOT NULL,
	currency e_currency NOT NULL,
	payment_method e_payment_method NOT NULL,
	status e_order_status NOT NULL,
	created_at timestamp(6) DEFAULT NOW(),
	updated_at timestamp(6) DEFAULT NOW(),
	CONSTRAINT tbl_sales_orders_pkey PRIMARY KEY (id)
);


-- tbl_transaction definition

-- Drop table

-- DROP TABLE tbl_transaction;

CREATE TABLE tbl_transaction (
	id          serial4      NOT NULL,
	customer_id int8 NULL,
	order_id varchar(255) NULL,
	payment_id varchar(255) NULL,
	payment_method e_payment_method NOT NULL,
	amount int8 not NULL,
	currency e_currency NOT NULL,
	description varchar(255) NULL,
	status e_transaction_status NULL,
	created_at timestamp(6) DEFAULT NOW(),
	updated_at timestamp(6) DEFAULT NOW(),
	CONSTRAINT tbl_transaction_pkey PRIMARY KEY (id)
);




-- Insert data

INSERT INTO tbl_permission (id, name, created_at, updated_at, description)
VALUES (2, 'View', NULL, NULL, NULL),
       (3, 'Add', NULL, NULL, NULL),
       (4, 'Update', NULL, NULL, NULL),
       (5, 'Delete', NULL, NULL, NULL),
       (1, 'Full Access', NULL, NULL, NULL),
       (6, 'Upload', NULL, NULL, NULL),
       (7, 'Import', NULL, NULL, NULL),
       (8, 'Export', NULL, NULL, NULL),
       (9, 'Send', NULL, NULL, NULL),
       (10, 'Share', NULL, NULL, NULL);


INSERT INTO tbl_role (id, name, created_at, updated_at, description)
VALUES (2, 'admin', NULL, NULL, NULL),
       (3, 'manager', NULL, NULL, NULL),
       (4, 'product', NULL, NULL, NULL),
       (1, 'sysadmin', NULL, NULL, NULL);


INSERT INTO tbl_role_has_permission (id, role_id, permission_id, created_at, updated_at)
VALUES (1, 1, 1, NULL, NULL),
       (2, 1, 1, NULL, NULL),
       (3, 2, 3, NULL, NULL),
       (4, 2, 4, NULL, NULL),
       (5, 2, 5, NULL, NULL),
       (6, 2, 10, NULL, NULL),
       (7, 2, 10, NULL, NULL),
       (8, 3, 8, NULL, NULL),
       (9, 3, 2, NULL, NULL),
       (10, 3, 3, NULL, NULL);
INSERT INTO tbl_role_has_permission (id, role_id, permission_id, created_at, updated_at)
VALUES (11, 3, 4, NULL, NULL),
       (12, 3, 9, NULL, NULL),
       (13, 3, 10, NULL, NULL),
       (14, 4, 2, NULL, NULL),
       (15, 4, 3, NULL, NULL),
       (16, 4, 4, NULL, NULL),
       (17, 4, 6, NULL, NULL),
       (18, 4, 7, NULL, NULL);

INSERT INTO tbl_user (id, first_name, last_name, date_of_birth, gender, phone, email, username, "password", status,
                      "type", created_at, updated_at)
VALUES (10, 'Tung', 'Dang Thanh', '1989-05-06', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user8',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:29.231', '2024-04-18 09:56:29.231'),
       (11, 'Trung', 'Nguyen Khac', '1990-06-07', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user9',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:30.136', '2024-04-18 09:56:30.136'),
       (12, 'Kien', 'Truong Hai', '1991-07-09', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user10',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:30.6', '2024-04-18 09:56:30.6'),
       (13, 'Quan', 'Vu Hong', '1992-08-11', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user11',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:30.963', '2024-04-18 09:56:30.963'),
       (23, 'Nguyen', 'Nguyen Trung', '2003-03-12', 'MALE'::e_gender, '0123456789', 'someone@email.com',
        'user21', '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:22.366', '2024-04-18 09:56:22.366'),
       (24, 'Huy', 'Dang', '2001-04-23', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user23',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'INACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:23.573', '2024-04-18 09:56:23.573'),
       (25, 'Khang', 'Minh', '2002-05-25', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user24',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'NONE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:24.091', '2024-04-18 09:56:24.091'),
       (26, 'Ngan', 'Le', '2004-02-15', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user25',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:21.536', '2024-04-18 09:56:21.536'),
       (27, 'Thuy', 'Thuy', '2003-05-20', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user26',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:23.06', '2024-04-18 09:56:23.06'),
       (14, 'Tu', 'Tran Ngoc', '1993-09-12', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user12',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:31.3', '2024-04-18 09:56:31.3');
INSERT INTO tbl_user (id, first_name, last_name, date_of_birth, gender, phone, email, username, "password", status,
                      "type", created_at, updated_at)
VALUES (15, 'Tuan', 'Dang Dinh', '1992-10-13', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user13',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-15 21:54:04.258', '2024-04-15 21:54:04.258'),
       (16, 'Hung', 'Nguyen Quoc', '1994-10-14', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user14',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-15 21:57:15.934', '2024-04-15 21:57:15.934'),
       (17, 'Que', 'Mai Ngoc', '1995-11-11', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user15',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'NONE'::e_user_status,
        'USER'::e_user_type, '2024-04-15 22:02:26.532', '2024-04-16 21:14:05.098'),
       (18, 'Binh', 'Tran Tu', '1996-12-15', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user16',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-15 22:05:00.438', '2024-04-15 22:05:00.438'),
       (19, 'Thanh', 'Nguyen Hai', '1997-01-16', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user17',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:25.034', '2024-04-18 09:56:25.034'),
       (20, 'Hoa', 'Pham Ngoc', '1998-07-10', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user18',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:26.215', '2024-04-18 09:56:26.215'),
       (2, 'Admin', 'Sub', '1981-06-05', 'MALE'::e_gender, '0123456789', 'admin@email.com', 'admin',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'ADMIN'::e_user_type, '2024-04-18 09:56:24.587', '2024-04-18 09:56:24.587'),
       (3, 'Manager', 'Mai', '1982-07-24', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'manager',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:58:07.611', '2024-04-18 09:58:07.611'),
       (4, 'Nam', 'Dinh Van', '1983-06-08', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user1',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:25.435', '2024-04-18 09:56:25.435'),
       (5, 'Dinh', 'Pham Quang', '1984-02-28', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user2',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:25.804', '2024-04-18 09:56:25.804');
INSERT INTO tbl_user (id, first_name, last_name, date_of_birth, gender, phone, email, username, "password", status,
                      "type", created_at, updated_at)
VALUES (6, 'Oanh', 'Nguyen Thi Kim', '1985-01-01', 'FEMALE'::e_gender, '0123456789', 'someone@email.com',
        'user3', '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:58:08.138', '2024-04-18 09:58:08.138'),
       (21, 'Sam', 'Trinh Van', '1999-01-19', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user19',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:26.88', '2024-04-18 09:56:26.88'),
       (7, 'Dung', 'Nguyen Thi', '1986-02-02', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user5',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:26.542', '2024-04-18 09:56:26.542'),
       (8, 'Chi', 'Pham Thi', '1987-03-04', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user6',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:58:08.589', '2024-04-18 09:58:08.589'),
       (9, 'Dung', 'Tran Thuy', '1988-04-05', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user7',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:28.438', '2024-04-18 09:56:28.438'),
       (22, 'My', 'Kieu', '2000-02-22', 'FEMALE'::e_gender, '0123456789', 'someone@email.com', 'user10',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-18 09:56:31.622', '2024-04-18 09:56:31.622'),
       (28, 'Tay', 'Java', '2003-06-05', 'MALE'::e_gender, '0123456789', 'someone@email.com', 'user22',
        '$2a$10$OvJyuXkBfkzNKalExgOu8epWOv5wtUSp2HIKKsENxyjatBU9lgfKC', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-04-20 06:00:46.115', '2024-04-20 06:00:46.115'),
       (1, 'SysAdmin', 'Sys', '1980-06-05', 'MALE'::e_gender, '0123456789', 'sysadmin@email.com', 'sysadmin',
        '$2a$10$y.cFBNzeymlgGpNJpm2lk.y8xrIONOY/vZHwX9vAquF7Y3ZFPYX.q', 'ACTIVE'::e_user_status,
        'OWNER'::e_user_type, '2024-04-18 09:58:07.169', '2024-08-05 11:10:30.886'),
       (29, 'Tây', 'Java', '2003-06-05', 'MALE'::e_gender, '0123467891', 'admin222@email.com', 'tayjava1',
        '$2a$10$y.cFBNzeymlgGpNJpm2lk.y8xrIONOY/vZHwX9vAquF7Y3ZFPYX.q', 'ACTIVE'::e_user_status,
        'USER'::e_user_type, '2024-08-06 10:08:28.483', '2024-08-06 10:08:28.483'),
       (94, 'Nam', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com', 'namnguyen',
        NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-15 17:16:44.743',
        '2024-11-15 17:16:44.743');
INSERT INTO tbl_user (id, first_name, last_name, date_of_birth, gender, phone, email, username, "password", status,
                      "type", created_at, updated_at)
VALUES (96, 'Nam', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com', 'namnguyen',
        NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-15 17:19:40.244',
        '2024-11-15 17:19:40.244'),
       (105, 'ABC-TEST', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com',
        'namnguyen88888', '$2a$10$diRLQ.ZCrVnXVF7iTxfXYuK2iVb40QD73XU30DS2XOxuyI1P9Cdne',
        'INACTIVE'::e_user_status, 'OWNER'::e_user_type, '2024-11-16 10:18:30.129',
        '2024-11-16 10:28:04.028'),
       (103, 'TEST1', 'Nguyễn1', '2024-11-20', 'MALE'::e_gender, '556777', 'test@email.com', 'test',
        '$2a$10$REmI6z6zYOFZWMlVbguge.x/bftXPx7BBNx3GUlxg53hStV0e9Bdm', 'ACTIVE'::e_user_status,
        'OWNER'::e_user_type, '2024-11-16 06:29:05.425', '2024-11-16 06:55:23.335'),
       (107, 'aaa', 'string', '2024-11-27', 'MALE'::e_gender, 'string', 'someone@email.com', 'string', NULL,
        'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-27 12:33:50.587',
        '2024-11-27 12:33:50.587'),
       (93, 'Nam', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com', 'namnguyen',
        NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-15 17:13:21.132',
        '2024-11-15 17:13:21.132'),
       (95, 'Nam', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com', 'namnguyen',
        NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-15 17:19:06.275',
        '2024-11-15 17:19:06.275'),
       (97, 'Nam11111111', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com',
        'namnguyen88888', NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-15 17:21:32.892',
        '2024-11-15 17:21:32.892'),
       (102, 'ALOHA......', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'namnguyen@email.com',
        'namnguyen88888', NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-16 06:28:10.779',
        '2024-11-16 06:28:10.779'),
       (104, 'BCD-Update', 'Update', '2024-11-20', 'MALE'::e_gender, '556777', 'Update@email.com', 'Update',
        NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-16 10:06:48.963',
        '2024-11-16 10:07:50.757'),
       (106, 'Tay', 'Java', '2024-11-27', 'MALE'::e_gender, 'string', 'tay@java.vn', 'string', NULL,
        'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-11-27 11:23:25.72', '2024-11-27 11:23:25.72');
INSERT INTO tbl_user (id, first_name, last_name, date_of_birth, gender, phone, email, username, "password", status,
                      "type", created_at, updated_at)
VALUES (110, 'ABC-TEST', 'Nguyễn', '2024-11-14', 'MALE'::e_gender, '1234567890', 'luongquoctay87@gmail.com',
        'namnguyen88888', NULL, 'NONE'::e_user_status, 'OWNER'::e_user_type, '2024-12-09 23:25:03.311',
        '2024-12-09 23:25:03.311');


INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (1, '1', '5', 'B1', '101', 'Vo Nguyen Giap street', 'Hanoi', 'Vietnam', 1, 1, '2024-04-15 21:54:04.274',
        '2024-04-15 21:54:04.274'),
       (2, '2', '6', 'B2', '102', 'Pham Van Dong', 'Hue', 'Vietnam', 1, 1, '2024-04-15 21:54:04.274',
        '2024-04-15 21:54:04.274'),
       (3, '3', '7', 'B3', '103', 'Le Duan', 'Da Nang', 'Vietnam', 1, 2, '2024-04-15 22:05:00.453',
        '2024-04-15 22:05:00.453'),
       (4, '4', '8', 'B4', '104', 'Le Duc Tho', 'Sai Gon', 'Vietnam', 1, 3, '2024-04-16 21:13:28.872',
        '2024-04-16 21:13:28.872'),
       (5, '5', '9', 'B6', '105', 'Nguyen Chi Thanh', 'Can Tho', 'Vietnam', 1, 4, '2024-04-18 09:56:21.552',
        '2024-04-18 09:56:21.552'),
       (6, '6', '10', 'B7', '106', 'Le Trong Tan', 'Vung Tau', 'Vietnam', 1, 5, '2024-04-18 09:56:22.368',
        '2024-04-18 09:56:22.368'),
       (7, '7', '11', 'A1', '107', 'Truong Trinh', 'Kien Giang', 'Vietnam', 1, 6, '2024-04-18 09:56:23.061',
        '2024-04-18 09:56:23.061'),
       (8, '8', '12', 'A2', '108', 'Tran Dai Nghia', 'Soc Trang', 'Vietnam', 1, 7, '2024-04-18 09:56:23.575',
        '2024-04-18 09:56:23.575'),
       (9, '9', '13', 'A3', '109', 'Tran Khanh Du', 'Quy Nho', 'Vietnam', 1, 8, '2024-04-18 09:56:24.093',
        '2024-04-18 09:56:24.093'),
       (10, '10', '14', 'A4', '110', 'Tran Quang Khai', 'Phan Thiet', 'Vietnam', 1, 9, '2024-04-18 09:56:24.589',
        '2024-04-18 09:56:24.589');
INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (11, '11', '15', 'A5', '210', 'Tran Nhat Duat', 'Tay Ninh', 'Vietnam', 1, 10, '2024-04-18 09:56:25.037',
        '2024-04-18 09:56:25.037'),
       (12, '12', '16', 'A6', '310', 'Tran Tu Binh', 'Dak Lak', 'Vietnam', 1, 11, '2024-04-18 09:56:25.438',
        '2024-04-18 09:56:25.438'),
       (13, '13', '17', 'A7', '40', 'Tran Quoc Toan', 'Bac Giang', 'Vietnam', 1, 12, '2024-04-18 09:56:25.807',
        '2024-04-18 09:56:25.807'),
       (14, '14', '18', 'A8', '50', 'Tran Hung Dao', 'Bac Ninh', 'Vietnam', 1, 13, '2024-04-18 09:56:26.218',
        '2024-04-18 09:56:26.218'),
       (15, '15', '19', 'Z1', '60', 'Tran Nhan Tong', 'Bac Ninh', 'Vietnam', 1, 13, '2024-04-18 09:56:26.218',
        '2024-04-18 09:56:26.218'),
       (16, '16', '20', 'X2', '70', 'Ngo Quyen', 'Vinh Phuc', 'Vietnam', 1, 14, '2024-04-18 09:56:26.544',
        '2024-04-18 09:56:26.544'),
       (17, '17', '21', 'W4', '80', 'Khuc Thua Du', 'Phu Yen', 'Vietnam', 1, 15, '2024-04-18 09:56:28.442',
        '2024-04-18 09:56:28.442'),
       (18, '18', '22', 'T2', '90', 'Trieu Quang Phuc', 'Binh Dinh', 'Vietnam', 1, 16, '2024-04-18 09:56:29.232',
        '2024-04-18 09:56:29.232'),
       (19, '19', '23', 'P2', '20', 'Hai Ba Trung', 'Phan Rang', 'Vietnam', 1, 17, '2024-04-18 09:56:30.138',
        '2024-04-18 09:56:30.138'),
       (20, '20', '25', 'G1', '30', 'Le Loi', 'Dien Bien', 'Vietnam', 1, 18, '2024-04-18 09:56:30.603',
        '2024-04-18 09:56:30.603');
INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (21, '21', '26', 'U4', '111', 'Le Lai', 'Quang Ninh', 'Vietnam', 1, 19, '2024-04-18 09:56:30.965',
        '2024-04-18 09:56:30.965'),
       (22, '22', '27', 'Y1', '112', 'Ly Thai To', 'Hai Phong', 'Vietnam', 1, 20, '2024-04-18 09:56:31.303',
        '2024-04-18 09:56:31.303'),
       (23, '23', '28', 'K1', '113', 'Ly Thanh Tong', 'Tuyen Quang', 'Vietnam', 1, 21, '2024-04-18 09:56:31.624',
        '2024-04-18 09:56:31.624'),
       (24, '24', '29', 'L1', '114', 'Au Co', 'Ha Giang', 'Vietnam', 1, 22, '2024-04-18 09:58:07.172',
        '2024-04-18 09:58:07.172'),
       (25, '25', '30', 'J2', '115', 'Lac Long Quan', 'Quang Nam', 'Vietnam', 1, 23, '2024-04-18 09:58:07.613',
        '2024-04-18 09:58:07.613'),
       (26, '26', '31', 'R3', '116', 'Ly Nam De', 'Quang Ngai', 'Vietnam', 1, 24, '2024-04-18 09:58:08.139',
        '2024-04-18 09:58:08.139'),
       (27, '27', '32', 'F2', '117', 'Giai Phong', 'Binh Duong ', 'Vietnam', 1, 25, '2024-04-18 09:58:08.592',
        '2024-04-18 09:58:08.592'),
       (28, '28', '33', 'V1', '118', 'Bui Thi Xuan', 'Ben Tre', 'Vietnam', 1, 26, '2024-04-18 09:56:26.882',
        '2024-04-18 09:56:26.882'),
       (29, '10', '10', 'A', '10', 'Wall street', 'Hanoi', 'Vietnam', 1, 28, '2024-04-20 06:00:46.123',
        '2024-04-20 06:00:46.123'),
       (55, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, NULL, '2024-11-15 17:13:21.179',
        '2024-11-15 17:13:21.179');
INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (56, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, NULL, '2024-11-15 17:13:21.183',
        '2024-11-15 17:13:21.183'),
       (57, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 94, '2024-11-15 17:16:44.772',
        '2024-11-15 17:16:44.772'),
       (58, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 94, '2024-11-15 17:16:44.774',
        '2024-11-15 17:16:44.774'),
       (59, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 95, '2024-11-15 17:19:31.268',
        '2024-11-15 17:19:31.269'),
       (60, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 95, '2024-11-15 17:19:31.28',
        '2024-11-15 17:19:31.28'),
       (61, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 96, '2024-11-15 17:20:50.813',
        '2024-11-15 17:20:50.813'),
       (62, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 96, '2024-11-15 17:20:50.821',
        '2024-11-15 17:20:50.821'),
       (63, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 97, '2024-11-15 17:21:59.325',
        '2024-11-15 17:21:59.325'),
       (64, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 97, '2024-11-15 17:21:59.345',
        '2024-11-15 17:21:59.345'),
       (65, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 102, '2024-11-16 06:28:29.165',
        '2024-11-16 06:28:29.165');
INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (66, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 102, '2024-11-16 06:28:29.174',
        '2024-11-16 06:28:29.174'),
       (67, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 103, '2024-11-16 06:29:08.649',
        '2024-11-16 06:29:08.649'),
       (69, 'C', 'C', 'C', 'C', 'C', 'C', 'C', 3, 103, '2024-11-16 06:33:28.487', '2024-11-16 06:33:28.487'),
       (68, '', '', 'B', 'B', 'B', 'B', 'B', 2, 103, '2024-11-16 06:29:08.651', '2024-11-16 06:39:38.85'),
       (71, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 104, '2024-11-16 10:06:48.999',
        '2024-11-16 10:06:48.999'),
       (70, '1203', '12', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 104, '2024-11-16 10:06:48.997',
        '2024-11-16 10:07:50.763'),
       (72, 'C', 'C', 'C', 'C', 'C', 'C', 'C', 3, 104, '2024-11-16 10:07:50.768', '2024-11-16 10:07:50.768'),
       (73, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 105, '2024-11-16 10:18:30.164',
        '2024-11-16 10:18:30.164'),
       (74, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 105, '2024-11-16 10:18:30.168',
        '2024-11-16 10:18:30.168'),
       (79, '1203', '10', 'a', '123', 'Truong Trinh', 'Hanoi', 'Vietnam', 1, 110, '2024-12-09 23:25:03.324',
        '2024-12-09 23:25:03.324');
INSERT INTO tbl_address (id, apartment_number, floor, building, street_number, street, city, country, address_type,
                         user_id, created_at, updated_at)
VALUES (80, '', '', 'b', '345', 'Vo Nguyen Giap', 'Hanoi', 'Vietnam', 2, 110, '2024-12-09 23:25:03.327',
        '2024-12-09 23:25:03.327');

INSERT INTO tbl_group (id, name, role_id, created_at, updated_at, description)
VALUES (3, 'Group Fronted', 4, NULL, NULL, NULL),
       (2, 'Group Backend', 3, NULL, NULL, NULL),
       (1, 'Group DevOps', 2, NULL, NULL, NULL);

INSERT INTO tbl_user_has_role (id, user_id, role_id, created_at, updated_at)
VALUES (1, 3, 3, NULL, NULL),
       (6, 1, 1, NULL, NULL),
       (5, 2, 2, NULL, NULL),
       (2, 4, 4, NULL, NULL),
       (3, 5, 4, NULL, NULL),
       (4, 6, 4, NULL, NULL);


----------- [Query permission] -----------
--select
--	p.id, p."name", p.description
--from
--	tbl_permission p
--where
--	p.id in (
--	select
--		distinct rp.permission_id
--	from
--		tbl_role_has_permission rp
--	inner join tbl_role r1 on
--		r1.id = rp.role_id
--	where
--		r1.id = (
--		select
--			distinct r2.id
--		from
--			tbl_role r2
--		inner join tbl_user_has_role ur on
--			ur.role_id = r2.id
--		inner join tbl_user u on
--			u.id = ur.user_id
--		where
--			u.username = 'admin'))