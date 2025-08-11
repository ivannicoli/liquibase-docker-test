--liquibase formatted sql

--changeset testuser:05-insert-sample-users
INSERT INTO users (username, email, password_hash, first_name, last_name)
VALUES 
('john_doe', 'john@example.com', 'hashed_password_1', 'John', 'Doe'),
('jane_smith', 'jane@example.com', 'hashed_password_2', 'Jane', 'Smith'),
('bob_johnson', 'bob@example.com', 'hashed_password_3', 'Bob', 'Johnson');
--rollback DELETE FROM users WHERE username IN ('john_doe', 'jane_smith', 'bob_johnson');

--changeset testuser:05-insert-sample-products
INSERT INTO products (name, description, price, sku, stock_quantity)
VALUES 
('Smartphone', 'Latest model smartphone with advanced features', 999.99, 'PHONE-001', 50),
('Laptop', 'High-performance laptop for professionals', 1499.99, 'LAPTOP-001', 30),
('Headphones', 'Noise-cancelling wireless headphones', 199.99, 'AUDIO-001', 100),
('Tablet', '10-inch tablet with high-resolution display', 399.99, 'TABLET-001', 45),
('Smartwatch', 'Fitness tracking smartwatch', 249.99, 'WATCH-001', 75);
--rollback DELETE FROM products WHERE sku IN ('PHONE-001', 'LAPTOP-001', 'AUDIO-001', 'TABLET-001', 'WATCH-001');

--changeset testuser:05-insert-sample-orders
INSERT INTO orders (user_id, status, total_amount, shipping_address, billing_address, payment_method)
VALUES 
(1, 'completed', 1199.98, '123 Main St, City, Country', '123 Main St, City, Country', 'credit_card'),
(2, 'processing', 399.99, '456 Oak Ave, Town, Country', '456 Oak Ave, Town, Country', 'paypal'),
(3, 'pending', 1749.98, '789 Pine Rd, Village, Country', '789 Pine Rd, Village, Country', 'bank_transfer');
--rollback DELETE FROM orders WHERE user_id IN (1, 2, 3);

--changeset testuser:05-insert-sample-order-items
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES 
(1, 1, 1, 999.99),
(1, 3, 1, 199.99),
(2, 4, 1, 399.99),
(3, 2, 1, 1499.99),
(3, 3, 1, 249.99);
--rollback DELETE FROM order_items WHERE order_id IN (1, 2, 3);
