# Indexes
	## Indexes to Improve Query Performance
		## Improve the performance of frequent queries on the sales table.
        
-- Creating an index on the order_date column to optimize date-based queries
CREATE INDEX idx_order_date ON sales(order_date);

-- Creating a composite index on product_id and order_date to optimize queries involving both columns
CREATE INDEX idx_product_order_date ON sales(product_id, order_date);

-- These indexes are created to improve the performance of queries that filter or sort by order_date and product_id.
-- The idx_order_date index optimizes queries that filter by order date.
-- The idx_product_order_date index optimizes queries that filter by both product_id and order_date.
