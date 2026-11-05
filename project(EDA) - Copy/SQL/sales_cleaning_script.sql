USE sales_pr;
DROP TABLE IF EXISTS cleaned_sales;
CREATE TABLE cleaned_sales AS
WITH normalized AS (
  SELECT
    NULLIF(UPPER(TRIM(SalesOrderNumber)), '') AS sales_order_number,
    STR_TO_DATE(NULLIF(TRIM(OrderDate), ''), '%W, %M %e, %Y') AS order_date,
    CASE WHEN CAST(NULLIF(TRIM(ProductKey), '') AS DECIMAL(12,2)) > 0 THEN CAST(CAST(TRIM(ProductKey) AS DECIMAL(12,2)) AS UNSIGNED) END AS product_key,
    CASE WHEN CAST(NULLIF(TRIM(ResellerKey), '') AS DECIMAL(12,2)) > 0 THEN CAST(CAST(TRIM(ResellerKey) AS DECIMAL(12,2)) AS UNSIGNED) END AS reseller_key,
    CASE WHEN CAST(NULLIF(TRIM(EmployeeKey), '') AS DECIMAL(12,2)) > 0 THEN CAST(CAST(TRIM(EmployeeKey) AS DECIMAL(12,2)) AS UNSIGNED) END AS employee_key,
    CASE WHEN CAST(NULLIF(TRIM(SalesTerritoryKey), '') AS DECIMAL(12,2)) > 0 THEN CAST(CAST(TRIM(SalesTerritoryKey) AS DECIMAL(12,2)) AS UNSIGNED) END AS sales_territory_key,
    CASE WHEN CAST(NULLIF(TRIM(Quantity), '') AS DECIMAL(14,2)) > 0 THEN CAST(TRIM(Quantity) AS DECIMAL(14,2)) END AS quantity,
    CASE WHEN CAST(NULLIF(REPLACE(REPLACE(TRIM(`Unit Price`), '$', ''), ',', ''), '') AS DECIMAL(14,2)) > 0 THEN CAST(REPLACE(REPLACE(TRIM(`Unit Price`), '$', ''), ',', '') AS DECIMAL(14,2)) END AS unit_price,
    CASE WHEN CAST(NULLIF(REPLACE(REPLACE(TRIM(Sales), '$', ''), ',', ''), '') AS DECIMAL(16,2)) > 0 THEN CAST(REPLACE(REPLACE(TRIM(Sales), '$', ''), ',', '') AS DECIMAL(16,2)) END AS reported_sales,
    CASE WHEN CAST(NULLIF(REPLACE(REPLACE(TRIM(Cost), '$', ''), ',', ''), '') AS DECIMAL(16,2)) > 0 THEN CAST(REPLACE(REPLACE(TRIM(Cost), '$', ''), ',', '') AS DECIMAL(16,2)) END AS cost_amount
  FROM messed_sales
), order_consensus AS (
  SELECT sales_order_number, MAX(order_date) AS order_date, MAX(reseller_key) AS reseller_key, MAX(employee_key) AS employee_key, MAX(sales_territory_key) AS sales_territory_key
  FROM normalized WHERE sales_order_number IS NOT NULL GROUP BY sales_order_number
), product_cost_frequency AS (
  SELECT product_key, cost_amount, COUNT(*) AS frequency
  FROM normalized
  WHERE product_key IS NOT NULL AND cost_amount IS NOT NULL
  GROUP BY product_key, cost_amount
), product_cost AS (
  SELECT product_key, cost_amount FROM (
    SELECT product_key, cost_amount,
      ROW_NUMBER() OVER (PARTITION BY product_key ORDER BY frequency DESC, cost_amount) AS rn
    FROM product_cost_frequency
  ) ranked WHERE rn = 1
), repaired AS (
  SELECT n.sales_order_number, COALESCE(n.order_date,o.order_date) order_date, n.product_key, COALESCE(n.reseller_key,o.reseller_key) reseller_key, COALESCE(n.employee_key,o.employee_key) employee_key, COALESCE(n.sales_territory_key,o.sales_territory_key) sales_territory_key,
    COALESCE(n.quantity, n.reported_sales / NULLIF(n.unit_price,0)) quantity,
    COALESCE(n.unit_price, n.reported_sales / NULLIF(n.quantity,0)) unit_price,
    COALESCE(n.cost_amount,p.cost_amount) cost_amount
  FROM normalized n LEFT JOIN order_consensus o USING (sales_order_number) LEFT JOIN product_cost p USING (product_key)
)
SELECT sales_order_number, order_date, product_key, reseller_key, employee_key, sales_territory_key,
  ROUND(quantity,2) quantity, ROUND(unit_price,2) unit_price, ROUND(quantity*unit_price,2) sales_amount, ROUND(cost_amount,2) cost_amount
FROM repaired
WHERE sales_order_number IS NOT NULL AND order_date IS NOT NULL AND product_key IS NOT NULL
  AND reseller_key IS NOT NULL AND employee_key IS NOT NULL AND sales_territory_key IS NOT NULL
  AND quantity > 0 AND unit_price > 0 AND cost_amount > 0;

ALTER TABLE cleaned_sales
  MODIFY sales_order_number VARCHAR(20) NOT NULL,
  MODIFY order_date DATE NOT NULL,
  MODIFY product_key INT NOT NULL,
  MODIFY reseller_key INT NOT NULL,
  MODIFY employee_key INT NOT NULL,
  MODIFY sales_territory_key INT NOT NULL,
  MODIFY quantity DECIMAL(12,2) NOT NULL,
  MODIFY unit_price DECIMAL(14,2) NOT NULL,
  MODIFY sales_amount DECIMAL(16,2) NOT NULL,
  MODIFY cost_amount DECIMAL(16,2) NOT NULL,
  ADD INDEX ix_order_date (order_date), ADD INDEX ix_product_key (product_key);
  
SELECT 
    * FROM
    cleaned_sales; 
    
SELECT 
    COUNT(*) AS clean_rows, SUM(sales_amount) AS total_sales
FROM
    cleaned_sales;
SELECT 
    COUNT(*) AS invalid_sales_rows
FROM
    cleaned_sales
WHERE
    ABS(sales_amount - ROUND(quantity * unit_price, 2)) > 0.01;
