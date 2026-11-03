SET SESSION cte_max_recursion_depth = 2000;

CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    monto DECIMAL(10,2),
    fecha DATE
);

-- Insertar 100 clientes base
INSERT INTO clientes (nombre, email)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 100
)
SELECT 
    CONCAT('Cliente_', n),
    CONCAT('cliente_', n, '@empresa.com')
FROM seq;

-- Insertar los 1000 pedidos requeridos
INSERT INTO pedidos (cliente_id, monto, fecha)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 1000
)
SELECT 
    FLOOR(1 + (RAND() * 100)),
    ROUND(10 + (RAND() * 990), 2),
    DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND() * 300) DAY)
FROM seq;