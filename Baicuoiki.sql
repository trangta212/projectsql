CREATE TABLE customers (
    customer_ID VARCHAR(6) PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    address VARCHAR,
    point BIGINT
);
CREATE TABLE menu (
    food_ID VARCHAR(6) PRIMARY KEY,
    food_name VARCHAR,
    description VARCHAR,
    unit_price BIGINT
);
CREATE TABLE orders (
    order_ID VARCHAR(6) PRIMARY KEY,
    customer_ID VARCHAR(6),
    order_time TIME,
    pay_time TIME,
    pre_total BIGINT,
    total_price BIGINT,
    FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID)
);
CREATE TABLE orderlines (
    order_ID VARCHAR(6),
    food_ID VARCHAR(6),
    quantity INT,
    price BIGINT,
    PRIMARY KEY (order_ID, food_ID)
);

CREATE TABLE "table" (
    table_ID INT PRIMARY KEY,
    status VARCHAR(50)
);

CREATE TABLE table_order (
    order_ID VARCHAR(6),
    table_ID INT,
    start_time TIME,
    end_time TIME,
    PRIMARY KEY (order_ID, table_ID)
);
