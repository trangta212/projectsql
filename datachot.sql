--1/ customers
INSERT INTO customers (first_name, last_name, phone)
VALUES
    ( 'John', 'Doe', '123456789'),
    ( 'Alice', 'Smith', '987654321'),
    ( 'Bob', 'Johnson', '555234324'),
    ( 'Emma', 'Wilson', '1111222333'),
    ( 'Michael', 'Brown', '222222222'),
    ( 'Sophia', 'Davis', '333333333'),
    ( 'Daniel', 'Martinez', '444444444'),
    ('Olivia', 'Taylor', '555245455321'),
    ('Alexander', 'Anderson', '6663242466'),
    ( 'Ava', 'Lee', '7777777747'),
    ('William', 'Harris', '8828888888'),
    ( 'Mia', 'Jackson', '9999991999'),
    ('James', 'Wilson', '0000001000');
--2/ orders
INSERT INTO orders (order_ID, customer_ID)
VALUES
    ('OR0001', 'KH0001'),
    ('OR0002', 'KH0002'),
    ('OR0003', 'KH0003'),
    ('OR0004', 'KH0004'),
    ('OR0005', 'KH0005'),
    ('OR0006', 'KH0006'),
    ('OR0007', 'KH0007'),
    ('OR0008', 'KH0008'),
    ('OR0009', 'KH0009'),
    ('OR0010', 'KH0010');
-- 3/ orderlines
INSERT INTO orderlines (order_ID, food_ID, quantity)
VALUES
    ('OR0001', 'FO0001', 2),
    ('OR0001', 'FO0002', 1),
    ('OR0002', 'FO0003', 3),
    ('OR0003', 'FO0001', 2),
    ('OR0003', 'FO0004', 1),
    ('OR0004', 'FO0002', 1),
    ('OR0004', 'FO0003', 2),
    ('OR0005', 'FO0004', 1),
    ('OR0006', 'FO0005', 2),
    ('OR0006', 'FO0006', 1),
    ('OR0007', 'FO0003', 3),
    ('OR0007', 'FO0004', 2),
    ('OR0008', 'FO0002', 1),
    ('OR0008', 'F0006', 1),
    ('OR0009', 'FO0001', 2),
    ('OR0009', 'FO0004', 1),
    ('OR0010', 'FO0003', 2),
    ('OR0010', 'FO0005', 1);
-- 4/ tables
INSERT INTO "table" (table_ID, status)
VALUES
    (1, 'E'),
    (2, 'E'),
    (3, 'E'),
    (4, 'E'),
    (5, 'E'),
    (6,'E'),
    (7,'E'),
     (8,'E'),
     (9,'E');
--5/table_order
INSERT INTO table_order (order_ID, table_ID)
VALUES
    ('OR0001', 1),
    ('OR0002', 2),
    ('OR0003', 3),
    ('OR0007', 1),
    ('OR0008', 2),
    ('OR0009', 3);
--6/ Menu
INSERT INTO menu (food_ID, food_name, description, unit_price)
VALUES
    ('FO0001', 'Ga ran sot cay', 'Mot phan', 30000),
    ('FO0002', 'Ga ran sot tieu', 'mot phan',35000 ),
    ('FO0003', 'Ga quay', 'mon phan', 50000),
    ('FO0004', 'pho mai chien', 'mot phan', 25000),
    ('FO0005', 'khoai tay chien', 'mon phan', 20000),
    ('FO0006', 'My y', 'mot phan', 35000);






