
DROP DATABASE IF EXISTS catalogo_productos_simple;
CREATE DATABASE catalogo_productos_simple;
USE catalogo_productos_simple;

CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL
);
CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  categoria_id INT NOT NULL,
  tipo_producto VARCHAR(20) NOT NULL, -- COMIDA, MUEBLES, GENERICO
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);
CREATE TABLE comidas (
  producto_id INT PRIMARY KEY,
  fecha_exp DATE NOT NULL,
  calorias INT NOT NULL,
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);
CREATE TABLE muebles (
  producto_id INT PRIMARY KEY,
  fecha_fabric DATE NOT NULL,
  material VARCHAR(80) NOT NULL,
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);
CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  fecha DATETIME NOT NULL,
  cliente VARCHAR(120) NOT NULL
);
CREATE TABLE detalle_pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unit DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

INSERT INTO categorias (nombre) VALUES
 ('Abarrotes'),
 ('Hogar');

INSERT INTO productos (nombre, precio, categoria_id, tipo_producto) VALUES
 ('Leche', 1.20, 1, 'COMIDA'),
 ('Manzana', 0.50, 1, 'COMIDA'),
 ('Silla', 35.00, 2, 'MUEBLES'),
 ('Bolígrafo', 2.00, 2, 'GENERICO');

INSERT INTO comidas (producto_id, fecha_exp, calorias) VALUES
 (1, '2025-10-20', 150),
 (2, '2025-10-17', 95);

INSERT INTO muebles (producto_id, fecha_fabric, material) VALUES
 (3, '2025-09-06', 'Pino');

INSERT INTO pedidos (fecha, cliente) VALUES
 ('2025-10-06 10:00:00', 'Hernan'),
 ('2025-10-06 11:00:00', 'Maryon');

INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unit) VALUES
 (1, 1, 2, 1.20),
 (1, 2, 6, 0.50),
 (2, 3, 1, 35.00);


SELECT p.id, p.nombre, c.nombre AS categoria, p.precio
FROM productos p
JOIN categorias c ON c.id = p.categoria_id
ORDER BY p.id;

FROM productos p
JOIN comidas c ON c.producto_id = p.id
WHERE p.tipo_producto = 'COMIDA';

SELECT pe.id, pe.cliente,
       SUM(dp.cantidad * dp.precio_unit) AS total
FROM pedidos pe
JOIN detalle_pedido dp ON dp.pedido_id = pe.id
GROUP BY pe.id, pe.cliente
ORDER BY pe.id;

SELECT p.id, p.nombre, p.precio, m.material
FROM productos p
JOIN muebles m ON m.producto_id = p.id
WHERE p.tipo_producto = 'MUEBLES';
