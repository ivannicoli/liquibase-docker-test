--liquibase formatted sql

--changeset testuser:04-add-orders-foreign-keys
ALTER TABLE orders
ADD CONSTRAINT fk_orders_user_id
FOREIGN KEY (user_id) REFERENCES users(id)
ON DELETE SET NULL;
--rollback ALTER TABLE orders DROP CONSTRAINT fk_orders_user_id;

--changeset testuser:04-add-order-items-foreign-keys
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order_id
FOREIGN KEY (order_id) REFERENCES orders(id)
ON DELETE CASCADE;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_product_id
FOREIGN KEY (product_id) REFERENCES products(id)
ON DELETE RESTRICT;
--rollback ALTER TABLE order_items DROP CONSTRAINT fk_order_items_order_id; ALTER TABLE order_items DROP CONSTRAINT fk_order_items_product_id;
