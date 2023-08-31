-- 1. Quản lý thông tin khách hàng
-- 1.1/ Tạo khách hàng mới:Thông tin của khách hàng sẽ bao gồm customer_ID,first_name,last_name,phone,point. Lưu ý customer_ID, point sẽ tự động được tạo.
-- Nếu người dùng cố tình tạo thì sẽ in ra thông báo lỗi
--Trigger để số thứ tự của customer_ID được tự động lưu, người dùng không có quyền chỉnh sửa
CREATE OR REPLACE FUNCTION generate_customer_id()
RETURNS TRIGGER AS $$
DECLARE
    next_id TEXT;
BEGIN
    next_id := 'KH' || to_char(nextval('customer_id_seq'), 'FM0000'); -- Định dạng customer_ID theo KHxxxx
    NEW.customer_ID := next_id; -- Gán giá trị customer_ID cho khách hàng mới
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_generate_customer_id
BEFORE INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION generate_customer_id()
-- Trigger để người dùng insert into dữ liệu vào nếu cố tình insert into customer_ID và point sẽ không thành công. TH đặc biệt nếu point =0 thì được insert into
CREATE OR REPLACE FUNCTION prevent_insert_customer_id_point()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (NEW.customer_ID IS NOT NULL OR NEW.point IS NOT NULL) THEN
            IF (NEW.point is distinct from  0) THEN
                RAISE EXCEPTION 'Không thể chèn giá trị cho customer_ID và point';
            END IF;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
	CREATE TRIGGER prevent_insert_customer_id_point_trigger
BEFORE INSERT ON customers
FOR EACH ROW
EXECUTE FUNCTION prevent_insert_customer_id_point();
-- Hàm tự động tính point bằng cách lấy total_price /100. Sau khi hóa đơn được cập nhật thành công hệ thống sẽ tự động cập nhập point vào khách hàng đó
CREATE OR REPLACE FUNCTION updatepoint()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE customers
    SET point = point + NEW.total_price / 100
    WHERE customer_ID = NEW.customer_ID;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER updatepoint_trigger
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION updatepoint();
--2 / Hiển thị thông tin của khách hàng cần tìm kiếm
-- 2.1/ Người dùng nhập số điện thoại thì hệ thống sẽ hiển thị các thông tin bao gồm customer_ID, first_name,last_name,phone, point. Nếu phone đó mà chưa
-- tồn tại thì hệ thống sẽ in ra là số điện thoại chưa có trong hệ thống
CREATE OR REPLACE FUNCTION get_customer_info(phone_number VARCHAR)
RETURNS TABLE (customer_ID VARCHAR(6), first_name VARCHAR, last_name VARCHAR, phone VARCHAR, point BIGINT) AS $$
BEGIN
    RETURN QUERY EXECUTE format('
        SELECT customer_ID, first_name, last_name, phone, point
        FROM customers
        WHERE phone = %L', phone_number);
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Số điện thoại % chưa có trong hệ thống. Vui lòng nhập lại.', phone_number;
    END IF;
END;
$$ LANGUAGE plpgsql;
-- test:SELECT *
FROM get_customer_info('00923112');
--2.2/Sửa thông tin khách hàng: Người dùng nhập số điện thoại và có thể sửa được first_name,last_name,phone và không cho phép sửa customer_ID và point
CREATE OR REPLACE FUNCTION customer_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.customer_ID is distinct from OLD.customer_ID OR NEW.point is distinct from OLD.point THEN
        RAISE EXCEPTION 'Không thể sửa đổi customer_ID và point';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER check_customer_update
BEFORE UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION customer_update();
--2.3/ Hiển thị tất cả khách hàng
select * from customers;
--2.4/ sắp xếp tên khách hàng theo thứ tự tên tăng dần
SELECT *
FROM customers
ORDER BY last_name ASC;
--2.5/ Tạo view cho xem order_ID của customers
CREATE OR REPLACE VIEW my_vieew AS
SELECT c.customer_ID, COUNT(o.order_ID) AS order_counts
FROM customers c
JOIN orders o ON c.customer_ID = o.customer_ID
GROUP BY c.customer_ID;
--- select * from my_vieew
----------------------------------------------------------------------------------------------------------------------
--3.1: Hiển thị toàn bộ hóa đơn
select * from orders;
--3.2: Chọn yes no để hủy hóa đơn
-- 3.2.1: Hủy hóa đơn khi chưa thanh toán
DELETE FROM orders
WHERE order_ID = '' AND pay_time IS NULL;
--3.2.2: Hủy hóa đơn đã sẵn có
delete from orders
where order_ID=''
--3.3:Lịch sử hóa đơn
--Tìm kiếm hóa đơn muốn xem từ order_ID
 select * from orders where order_ID='$nhapvao'; -- Lệnh select không cho phép sử dụng trigger
-- Tìm kiếm hóa đơn dựa theo ngày tháng năm đặt hàng
select * from orders where date(order_time)='nam-thang-ngay'
-- Hiển thị ra ngày mà có nhiều hóa đơn nhất
SELECT order_time::date AS order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_time::date
ORDER BY total_orders DESC
LIMIT 1;
-- Hiển thị ra ngày có total_price cao nhất
SELECT order_time::date AS order_date, SUM(total_price) AS total_price_sum
FROM orders
GROUP BY order_time::date
ORDER BY total_price_sum DESC
LIMIT 1;
-- Hóa đơn được lưu theo tự động theo thứ tự lúc đặt
-- Cái này cứ hơi không ổn kiểu gì ý
CREATE OR REPLACE FUNCTION update_order_time()
RETURNS TRIGGER AS $$
BEGIN
    IF  NEW.order_time > OLD.order_time THEN
        UPDATE orders
        SET order_time = NEW.order_time
        WHERE order_ID = NEW.order_ID;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER times
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION update_order_time();
-- Phía dưới không phải là tự động sử dụng select để sắp xếp
SELECT *
FROM orders
ORDER BY order_time;
--- Nếu sử dụng thời gian như này nó sẽ lưu luôn thời gian hiện tại và tự sắp xếp từ cũ đến mới
CREATE TABLE orders(
    order_ID VARCHAR(6) PRIMARY KEY NOT NULL,
    customer_ID VARCHAR(6) NOT NULL,
    order_time TIMESTAMP DEFAULT current_timestamp
);
