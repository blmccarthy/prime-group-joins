## Example question and answer

```SQL
-- 0. Get all the users
SELECT * FROM customers;
```

## Tasks
1. Get all customers and their addresses.

    SELECT * FROM customers JOIN addresses
    ON customers.id = addresses.customer_id;

    RETURN:
    1	Lisa	Bonet	2	555 Some Pl	Chicago	IL	60611	business	1
    1	Lisa	Bonet	1	1 Main St	Detroit	MI	31111	home	1
    2	Charles	Darwin	3	8900 Linova Ave	Minneapolis	MN	55444	home	2
    3	George	Foreman	4	PO Box 999	Minneapolis	MN	55334	business	3
    4	Lucy	Liu	6	934 Superstar Ave	Portland	OR	99999	business	4
    4	Lucy	Liu	5	3 Charles Dr	Los Angeles	CA	00000	home	4



2. Get all orders and their line items (orders, quantity and product).

    SELECT orders.id AS order_number, orders.order_date, line_items.quantity, products.description
    FROM orders JOIN line_items 
    ON orders.id = line_items.order_id
    JOIN products
    ON products.id = line_items.product_id;



3. Which warehouses have cheetos?

    SELECT warehouse.warehouse FROM warehouse JOIN warehouse_product
    ON warehouse.id = warehouse_product.warehouse_id
    JOIN products
    ON products.id = warehouse_product.product_id
    WHERE description = 'cheetos';

    RETURN: 
    delta



4. Which warehouses have diet pepsi?

    SELECT warehouse.warehouse FROM warehouse JOIN warehouse_product
    ON warehouse.id = warehouse_product.warehouse_id
    JOIN products
    ON products.id = warehouse_product.product_id
    WHERE description = 'diet pepsi';

    RETURN:
    alpha
    delta
    gamma


5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.

    SELECT first_name, last_name, count(orders.id) AS order_count FROM customers JOIN addresses
    ON customers.id = addresses.customer_id
    JOIN orders
    ON orders.address_id = addresses.id
    GROUP BY first_name, last_name
    ORDER BY order_count DESC;

    RETURN:
    Lisa	Bonet	5
    Lucy	Liu	3
    Charles	Darwin	1



6. How many customers do we have?

    SELECT COUNT(id) AS customer_count FROM customers;

    RETURN:
    4



7. How many products do we carry?

    SELECT COUNT(id) AS product_count FROM products;

    RETURN: 
    7



8. What is the total available on-hand quantity of diet pepsi?

    SELECT SUM(on_hand) FROM warehouse_product JOIN products
    ON warehouse_product.product_id = products.id
    WHERE products.description = 'diet pepsi';

    RETURN:
    92



## Stretch
9. How much was the total cost for each order?

    SELECT orders.id, SUM(unit_price) FROM orders JOIN line_items
    ON orders.id = line_items.order_id
    JOIN products
    ON line_items.product_id = products.id
    GROUP BY orders.id;

    RETURN: 
    2	6.99
    5	19.94
    4	25.73
    6	24.43
    3	1.2
    7	9.49
    1	9.75


10. How much has each customer spent in total?

    SELECT customers.first_name, customers.last_name, SUM(unit_price) FROM orders JOIN line_items
    ON orders.id = line_items.order_id
    JOIN products
    ON line_items.product_id = products.id
    JOIN addresses
    ON addresses.id = orders.address_id
    JOIN customers
    ON customers.id = addresses.customer_id
    GROUP BY customers.first_name, customers.last_name;

    RETURN:
    Lucy	Liu	44.37
    Charles	Darwin	25.73
    Lisa	Bonet	27.43


11. How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).




