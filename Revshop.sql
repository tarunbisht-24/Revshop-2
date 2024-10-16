CREATE DATABASE RevShop;
USE RevShop;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_type SMALLINT,
    email VARCHAR(255) UNIQUE NOT NULL,
    mobile VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255),
    registered_time DATETIME(6)
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    address_type SMALLINT,
    city VARCHAR(255),
    country VARCHAR(255),
    order_id INT,
    pin_code VARCHAR(255),
    state VARCHAR(255),
    street VARCHAR(255),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_image VARCHAR(255),
    product_name VARCHAR(255),
    product_price INT,
    product_ratings DOUBLE,
    product_stock INT,
    category_id INT,
    customer_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    delivery_date DATE,
    order_date DATE,
    order_status VARCHAR(255),
    total_order_price INT,
    customer_id INT,
    address_id INT,
    payments_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (payments_id) REFERENCES payments(payments_id)
);

CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    cart_item_id INT,
    order_id INT,
    FOREIGN KEY (cart_item_id) REFERENCES cart_item(cart_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE payments (
    payments_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    payment_status SMALLINT,
    payment_type SMALLINT
);

CREATE TABLE wallet (
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    wallet_balance INT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE wallet_transactions (
    wallet_transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount INT,
    description VARCHAR(255),
    transaction_status SMALLINT,
    transaction_time DATETIME(6),
    order_id INT,
    wallet_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (wallet_id) REFERENCES wallet(wallet_id)
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE cart_item (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    quantity INT,
    cart_id INT,
    product_id INT,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE seller (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(255),
    country VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    pin_code VARCHAR(255),
    seller_name VARCHAR(255),
    state VARCHAR(255),
    street VARCHAR(255)
);

CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    phone VARCHAR(255),
    shipping_company VARCHAR(255),
    shipping_type SMALLINT,
    state VARCHAR(255),
    street VARCHAR(255),
    pin_code VARCHAR(255),
    country VARCHAR(255),
    city VARCHAR(255)
);


INSERT INTO customer (customer_type, email, mobile, name, password, registered_time) VALUES
(1, 'john@example.com', '9876543210', 'John Doe', 'password123', NOW()),
(2, 'jane@example.com', '8765432109', 'Jane Roe', 'password456', NOW());

INSERT INTO address (address_type, city, country, pin_code, state, street, customer_id) VALUES
(1, 'New York', 'USA', '10001', 'NY', '5th Ave', 1),
(2, 'Los Angeles', 'USA', '90001', 'CA', 'Sunset Blvd', 2);

INSERT INTO product (product_image, product_name, product_price, product_ratings, product_stock, category_id, customer_id) VALUES
('img1.jpg', 'Laptop', 1000, 4.5, 10, 1, 1),
('img2.jpg', 'Phone', 800, 4.0, 15, 2, 2);

INSERT INTO category (category_name) VALUES
('Electronics'),
('Furniture');

INSERT INTO orders (delivery_date, order_date, order_status, total_order_price, customer_id, address_id, payments_id) VALUES
('2024-10-20', '2024-10-15', 'Pending', 1800, 1, 1, 1),
('2024-10-21', '2024-10-16', 'Shipped', 800, 2, 2, 2);

INSERT INTO payments (payment_date, payment_status, payment_type) VALUES
('2024-10-15', 1, 1),
('2024-10-16', 1, 2);

INSERT INTO wallet (wallet_balance, customer_id) VALUES
(500, 1),
(1000, 2);

INSERT INTO wallet_transactions (amount, description, transaction_status, transaction_time, order_id, wallet_id) VALUES
(100, 'Order Payment', 1, NOW(), 1, 1),
(200, 'Refund', 2, NOW(), 2, 2);

INSERT INTO cart (customer_id) VALUES
(1),
(2);

INSERT INTO cart_item (quantity, cart_id, product_id) VALUES
(1, 1, 1),
(2, 2, 2);

INSERT INTO seller (city, country, email, phone, pin_code, seller_name, state, street) VALUES
('Chicago', 'USA', 'seller1@example.com', '1234567890', '60601', 'Seller One', 'IL', 'State St'),
('Miami', 'USA', 'seller2@example.com', '0987654321', '33101', 'Seller Two', 'FL', 'Ocean Dr');

INSERT INTO shipping (phone, shipping_company, shipping_type, state, street, pin_code, country, city) VALUES
('1234567890', 'FedEx', 1, 'IL', 'State St', '60601', 'USA', 'Chicago'),
('0987654321', 'DHL', 2, 'FL', 'Ocean Dr', '33101', 'USA', 'Miami');