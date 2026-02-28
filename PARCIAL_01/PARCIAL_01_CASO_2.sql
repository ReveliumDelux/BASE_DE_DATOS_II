CREATE DATABASE IF NOT EXISTS parcial_bd2;
USE parcial_bd2;

-- =========================
-- CREACION DE TABLAS
-- =========================
CREATE TABLE oficinas (
    id_oficina VARCHAR(10) PRIMARY KEY,
    ciudad VARCHAR(50),
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    departamento VARCHAR(50),
    pais VARCHAR(50),
    codigoPostal VARCHAR(15) UNIQUE,
    continente VARCHAR(10),

    tipo_oficina ENUM('principal','regional','sucursal'),
    activa BOOLEAN DEFAULT TRUE
);
CREATE TABLE empleados (
    documento INT PRIMARY KEY,
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    extension VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    id_oficina VARCHAR(10),
    jefe INT,
    cargo VARCHAR(50),

    tipo_empleado ENUM('ventas','admin','soporte'),
    activo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_oficina)
        REFERENCES oficinas(id_oficina)
);
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    empresa VARCHAR(50),
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    departamento VARCHAR(50),
    codigoPostal VARCHAR(15),
    pais VARCHAR(50),
    empleadoAtiende INT,
    limiteCredito DOUBLE,

    tipo_cliente ENUM('normal','premium'),
    activo BOOLEAN DEFAULT TRUE,

    UNIQUE(telefono),

    FOREIGN KEY (empleadoAtiende)
        REFERENCES empleados(documento)
);
CREATE TABLE lineasproductos (
    id_lineaproducto INT PRIMARY KEY,
    nombreLinea VARCHAR(50),
    textoDescripcion VARCHAR(4000),
    htmlDescripcion VARCHAR(200),
    imagen VARCHAR(200) UNIQUE,

    categoria ENUM('tecnologia','hogar','oficina'),
    activa BOOLEAN DEFAULT TRUE
);
CREATE TABLE productos (
    id_producto VARCHAR(15) PRIMARY KEY,
    nombreProducto VARCHAR(70),
    id_lineaProducto INT,
    escala VARCHAR(10),
    cantidad INT,
    precioVenta DOUBLE,
    MSRP DOUBLE,

    estado_producto ENUM('disponible','agotado'),
    activo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_lineaProducto)
        REFERENCES lineasproductos(id_lineaproducto)
);
CREATE TABLE ordenes (
    id_orden INT PRIMARY KEY,
    fechaRecibido DATE,
    fechaLimiteEntrega DATE,
    fechaEntrega DATE,
    estado VARCHAR(15),
    observacion TEXT,
    id_cliente INT,

    tipo_orden ENUM('online','presencial'),
    entregada BOOLEAN DEFAULT FALSE,

    UNIQUE(id_orden),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);
CREATE TABLE detallesordenes (
    id_orden INT,
    id_producto VARCHAR(15),
    cantidadPedida INT,
    valorUnitario DOUBLE,
    ordenEntrega INT,

    tipo_descuento ENUM('ninguno','promo'),
    aplica_impuesto BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (id_orden, id_producto),

    FOREIGN KEY (id_orden)
        REFERENCES ordenes(id_orden),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);
CREATE TABLE pagos (
    id_cliente INT,
    numeroFactura VARCHAR(50) PRIMARY KEY,
    fechaPago DATE,
    totalPago DOUBLE,

    metodo_pago ENUM('efectivo','tarjeta','transferencia'),
    confirmado BOOLEAN DEFAULT TRUE,

    UNIQUE(numeroFactura),

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

SHOW TABLES;

-- =========================
-- INSERCION DE DATOS
-- =========================


USE parcial_bd2;

-- =========================
-- 1) OFICINAS (20)
-- =========================
INSERT INTO oficinas
(id_oficina, ciudad, telefono, direccion, departamento, pais, codigoPostal, continente, tipo_oficina, activa)
VALUES
('OF001','Panamá','507-300-0001','Via España 101','Panamá','Panamá','0801-001','America','principal',TRUE),
('OF002','San Miguelito','507-300-0002','Transístmica 22','Panamá','Panamá','0801-002','America','regional',TRUE),
('OF003','Colón','507-300-0003','Calle 1','Colón','Panamá','0301-003','America','sucursal',TRUE),
('OF004','David','507-300-0004','Av Central 10','Chiriquí','Panamá','0401-004','America','sucursal',TRUE),
('OF005','Santiago','507-300-0005','Via Interamericana','Veraguas','Panamá','0601-005','America','sucursal',TRUE),
('OF006','Chitré','507-300-0006','Calle Herrera','Herrera','Panamá','0701-006','America','sucursal',TRUE),
('OF007','Las Tablas','507-300-0007','Calle Principal','Los Santos','Panamá','0711-007','America','sucursal',TRUE),
('OF008','Penonomé','507-300-0008','Av Coclé','Coclé','Panamá','0201-008','America','regional',TRUE),
('OF009','La Chorrera','507-300-0009','Av Libertador','Panamá Oeste','Panamá','1001-009','America','regional',TRUE),
('OF010','Arraiján','507-300-0010','Cerro Silvestre','Panamá Oeste','Panamá','1101-010','America','sucursal',TRUE),
('OF011','Bocas del Toro','507-300-0011','Isla Colón','Bocas del Toro','Panamá','0101-011','America','sucursal',TRUE),
('OF012','Aguadulce','507-300-0012','Calle Aguadulce','Coclé','Panamá','0205-012','America','sucursal',TRUE),
('OF013','Chepo','507-300-0013','Calle Chepo','Panamá','Panamá','0901-013','America','sucursal',TRUE),
('OF014','Metetí','507-300-0014','Via Darién','Darién','Panamá','1201-014','America','sucursal',TRUE),
('OF015','Almirante','507-300-0015','Calle Almirante','Bocas del Toro','Panamá','0112-015','America','sucursal',TRUE),
('OF016','Boquete','507-300-0016','Av Boquete','Chiriquí','Panamá','0413-016','America','sucursal',TRUE),
('OF017','Bugaba','507-300-0017','Centro Bugaba','Chiriquí','Panamá','0416-017','America','sucursal',TRUE),
('OF018','Antón','507-300-0018','Calle Antón','Coclé','Panamá','0211-018','America','sucursal',TRUE),
('OF019','Soná','507-300-0019','Calle Soná','Veraguas','Panamá','0613-019','America','sucursal',TRUE),
('OF020','Tocumen','507-300-0020','Aeropuerto','Panamá','Panamá','0819-020','America','regional',TRUE);

-- =========================
-- 2) EMPLEADOS (20)
-- =========================
INSERT INTO empleados
(documento, apellido, nombre, extension, email, id_oficina, jefe, cargo, tipo_empleado, activo)
VALUES
(1001,'Gómez','Luis','101','luis.gomez@empresa.com','OF001',NULL,'Gerente General','admin',TRUE),
(1002,'Pérez','Ana','102','ana.perez@empresa.com','OF001',1001,'Supervisora Ventas','ventas',TRUE),
(1003,'Rodríguez','Carlos','103','carlos.rodriguez@empresa.com','OF002',1002,'Vendedor','ventas',TRUE),
(1004,'López','María','104','maria.lopez@empresa.com','OF003',1002,'Vendedora','ventas',TRUE),
(1005,'Martínez','Jorge','105','jorge.martinez@empresa.com','OF004',1002,'Vendedor','ventas',TRUE),
(1006,'Sánchez','Paola','106','paola.sanchez@empresa.com','OF005',1002,'Vendedora','ventas',TRUE),
(1007,'Castillo','Diego','107','diego.castillo@empresa.com','OF006',1002,'Vendedor','ventas',TRUE),
(1008,'Hernández','Sofía','108','sofia.hernandez@empresa.com','OF007',1002,'Vendedora','ventas',TRUE),
(1009,'Torres','Kevin','109','kevin.torres@empresa.com','OF008',1002,'Vendedor','ventas',TRUE),
(1010,'Ruiz','Valeria','110','valeria.ruiz@empresa.com','OF009',1002,'Vendedora','ventas',TRUE),
(1011,'Vargas','Miguel','111','miguel.vargas@empresa.com','OF010',1002,'Vendedor','ventas',TRUE),
(1012,'Morales','Camila','112','camila.morales@empresa.com','OF011',1002,'Vendedora','ventas',TRUE),
(1013,'Ramos','Andrés','113','andres.ramos@empresa.com','OF012',1002,'Vendedor','ventas',TRUE),
(1014,'Navarro','Elena','114','elena.navarro@empresa.com','OF013',1002,'Vendedora','ventas',TRUE),
(1015,'Ortega','Roberto','115','roberto.ortega@empresa.com','OF014',1002,'Vendedor','ventas',TRUE),
(1016,'Silva','Daniela','116','daniela.silva@empresa.com','OF015',1002,'Vendedora','ventas',TRUE),
(1017,'Mendoza','Iván','117','ivan.mendoza@empresa.com','OF016',1002,'Vendedor','ventas',TRUE),
(1018,'Flores','Natalia','118','natalia.flores@empresa.com','OF017',1002,'Vendedora','ventas',TRUE),
(1019,'Jiménez','Oscar','119','oscar.jimenez@empresa.com','OF018',1002,'Soporte','soporte',TRUE),
(1020,'Diaz','Fernanda','120','fernanda.diaz@empresa.com','OF020',1001,'Soporte','soporte',TRUE);

-- =========================
-- 3) CLIENTES (20)
-- =========================
INSERT INTO clientes
(id_cliente, empresa, apellido, nombre, telefono, direccion, ciudad, departamento, codigoPostal, pais, empleadoAtiende, limiteCredito, tipo_cliente, activo)
VALUES
(2001,'TechNova','Vega','Raúl','6000-2001','Av Balboa 10','Panamá','Panamá','0801','Panamá',1003,5000,'premium',TRUE),
(2002,'InnovaSA','Ríos','Laura','6000-2002','Calle 50','Panamá','Panamá','0802','Panamá',1004,3000,'normal',TRUE),
(2003,'ComerPlus','Suárez','Mario','6000-2003','Vía España','San Miguelito','Panamá','0803','Panamá',1005,2500,'normal',TRUE),
(2004,'DistribuMax','León','Sara','6000-2004','Calle 1','Colón','Colón','0302','Panamá',1006,4000,'premium',TRUE),
(2005,'ChiriquiStore','Mora','José','6000-2005','Av Central','David','Chiriquí','0402','Panamá',1007,1500,'normal',TRUE),
(2006,'VeraguasMarket','Gil','Paula','6000-2006','Interamericana','Santiago','Veraguas','0602','Panamá',1008,1800,'normal',TRUE),
(2007,'HerreraShop','Cruz','Andrés','6000-2007','Calle Herrera','Chitré','Herrera','0702','Panamá',1009,2200,'normal',TRUE),
(2008,'SantosExpress','Reyes','Marta','6000-2008','Calle Principal','Las Tablas','Los Santos','0712','Panamá',1010,1200,'normal',TRUE),
(2009,'CocleCenter','Paz','Diego','6000-2009','Av Coclé','Penonomé','Coclé','0202','Panamá',1011,3500,'premium',TRUE),
(2010,'OesteTech','Soto','Elisa','6000-2010','Av Libertador','La Chorrera','Panamá Oeste','1002','Panamá',1012,2600,'normal',TRUE),
(2011,'ArraijanPro','Rojas','Luis','6000-2011','Cerro Silvestre','Arraiján','Panamá Oeste','1102','Panamá',1013,1700,'normal',TRUE),
(2012,'BocasImport','Salas','Ana','6000-2012','Isla Colón','Bocas del Toro','Bocas del Toro','0102','Panamá',1014,2800,'normal',TRUE),
(2013,'AguadulceFood','Campos','Nicolás','6000-2013','Calle Aguadulce','Aguadulce','Coclé','0206','Panamá',1015,1900,'normal',TRUE),
(2014,'ChepoRetail','Mejía','Carla','6000-2014','Calle Chepo','Chepo','Panamá','0902','Panamá',1016,2100,'normal',TRUE),
(2015,'DarienLog','Ibarra','Pablo','6000-2015','Via Darién','Metetí','Darién','1202','Panamá',1017,5000,'premium',TRUE),
(2016,'AlmirantePlus','Fuentes','Rosa','6000-2016','Calle Almirante','Almirante','Bocas del Toro','0113','Panamá',1018,1600,'normal',TRUE),
(2017,'BoqueteCafe','Acosta','Javier','6000-2017','Av Boquete','Boquete','Chiriquí','0414','Panamá',1003,2300,'normal',TRUE),
(2018,'BugabaHome','Bravo','Sonia','6000-2018','Centro Bugaba','Bugaba','Chiriquí','0417','Panamá',1004,1400,'normal',TRUE),
(2019,'AntonShop','Peña','Hugo','6000-2019','Calle Antón','Antón','Coclé','0212','Panamá',1005,3200,'premium',TRUE),
(2020,'TocumenSupply','Lara','Fabiola','6000-2020','Aeropuerto','Tocumen','Panamá','0820','Panamá',1006,2700,'normal',TRUE);

-- =========================
-- 4) LINEASPRODUCTOS (20)
-- =========================
INSERT INTO lineasproductos
(id_lineaproducto, nombreLinea, textoDescripcion, htmlDescripcion, imagen, categoria, activa)
VALUES
(1,'Electrónica','Dispositivos y accesorios','<p>Electrónica</p>','img_linea_01.png','tecnologia',TRUE),
(2,'Hogar','Artículos para el hogar','<p>Hogar</p>','img_linea_02.png','hogar',TRUE),
(3,'Oficina','Útiles y mobiliario','<p>Oficina</p>','img_linea_03.png','oficina',TRUE),
(4,'Audio','Equipos de audio','<p>Audio</p>','img_linea_04.png','tecnologia',TRUE),
(5,'Redes','Accesorios de red','<p>Redes</p>','img_linea_05.png','tecnologia',TRUE),
(6,'Cocina','Utensilios cocina','<p>Cocina</p>','img_linea_06.png','hogar',TRUE),
(7,'Iluminación','Lámparas y focos','<p>Iluminación</p>','img_linea_07.png','hogar',TRUE),
(8,'Papelería','Papelería general','<p>Papelería</p>','img_linea_08.png','oficina',TRUE),
(9,'Muebles','Muebles oficina/hogar','<p>Muebles</p>','img_linea_09.png','oficina',TRUE),
(10,'Accesorios','Accesorios varios','<p>Accesorios</p>','img_linea_10.png','tecnologia',TRUE),
(11,'Computación','Periféricos','<p>Computación</p>','img_linea_11.png','tecnologia',TRUE),
(12,'Limpieza','Productos limpieza','<p>Limpieza</p>','img_linea_12.png','hogar',TRUE),
(13,'Organización','Cajas y archivos','<p>Organización</p>','img_linea_13.png','oficina',TRUE),
(14,'Cables','Cables varios','<p>Cables</p>','img_linea_14.png','tecnologia',TRUE),
(15,'SmartHome','Domótica','<p>SmartHome</p>','img_linea_15.png','tecnologia',TRUE),
(16,'Herramientas','Herramientas básicas','<p>Herramientas</p>','img_linea_16.png','hogar',TRUE),
(17,'Baterías','Pilasy baterías','<p>Baterías</p>','img_linea_17.png','tecnologia',TRUE),
(18,'Escritura','Lápices y bolígrafos','<p>Escritura</p>','img_linea_18.png','oficina',TRUE),
(19,'Seguridad','Cámaras y alarmas','<p>Seguridad</p>','img_linea_19.png','tecnologia',TRUE),
(20,'Decoración','Decoración hogar','<p>Decoración</p>','img_linea_20.png','hogar',TRUE);

-- =========================
-- 5) PRODUCTOS (20)
-- =========================
INSERT INTO productos
(id_producto, nombreProducto, id_lineaProducto, escala, cantidad, precioVenta, MSRP, estado_producto, activo)
VALUES
('P0001','Mouse Inalámbrico',11,'1:10',120,12.99,19.99,'disponible',TRUE),
('P0002','Teclado Mecánico',11,'1:10',80,39.99,59.99,'disponible',TRUE),
('P0003','Audífonos Bluetooth',4,'1:10',60,29.99,49.99,'disponible',TRUE),
('P0004','Router WiFi AC',5,'1:10',45,44.99,69.99,'disponible',TRUE),
('P0005','Cable HDMI 2m',14,'1:20',200,6.50,9.99,'disponible',TRUE),
('P0006','Lámpara LED Escritorio',7,'1:10',70,18.90,24.90,'disponible',TRUE),
('P0007','Cuaderno A4',8,'1:50',300,2.25,3.00,'disponible',TRUE),
('P0008','Silla Oficina',9,'1:5',25,89.99,129.99,'disponible',TRUE),
('P0009','Organizador Archivos',13,'1:20',90,7.99,11.99,'disponible',TRUE),
('P0010','Cargador USB-C',10,'1:20',110,9.99,14.99,'disponible',TRUE),
('P0011','Bombillo LED',7,'1:20',260,1.99,2.99,'disponible',TRUE),
('P0012','Set Cocina',6,'1:10',40,24.99,34.99,'disponible',TRUE),
('P0013','Detergente Multiuso',12,'1:10',150,3.49,4.99,'disponible',TRUE),
('P0014','Cámara Seguridad',19,'1:5',20,59.99,89.99,'disponible',TRUE),
('P0015','Sensor SmartHome',15,'1:5',35,19.99,29.99,'disponible',TRUE),
('P0016','Destornillador Set',16,'1:10',55,12.50,17.50,'disponible',TRUE),
('P0017','Batería AA Pack',17,'1:20',140,5.99,8.99,'disponible',TRUE),
('P0018','Bolígrafo Azul',18,'1:100',500,0.50,0.75,'disponible',TRUE),
('P0019','Mini Parlante',4,'1:10',30,22.00,35.00,'agotado',TRUE),
('P0020','Decoración Cuadro',20,'1:10',15,14.99,19.99,'disponible',TRUE);

-- =========================
-- 6) ORDENES (20)
-- =========================
INSERT INTO ordenes
(id_orden, fechaRecibido, fechaLimiteEntrega, fechaEntrega, estado, observacion, id_cliente, tipo_orden, entregada)
VALUES
(3001,'2025-01-05','2025-01-12','2025-01-10','en_proceso','Entrega normal',2001,'online',TRUE),
(3002,'2025-01-06','2025-01-13','2025-01-13','entregada','OK',2002,'presencial',TRUE),
(3003,'2025-01-07','2025-01-14',NULL,'pendiente','En preparación',2003,'online',FALSE),
(3004,'2025-01-08','2025-01-15','2025-01-14','entregada','Cliente satisfecho',2004,'online',TRUE),
(3005,'2025-01-09','2025-01-16',NULL,'pendiente','Falta stock',2005,'presencial',FALSE),
(3006,'2025-01-10','2025-01-17','2025-01-16','entregada','OK',2006,'online',TRUE),
(3007,'2025-01-11','2025-01-18',NULL,'pendiente','Revisando pago',2007,'online',FALSE),
(3008,'2025-01-12','2025-01-19','2025-01-19','entregada','OK',2008,'presencial',TRUE),
(3009,'2025-01-13','2025-01-20',NULL,'pendiente','En ruta',2009,'online',FALSE),
(3010,'2025-01-14','2025-01-21','2025-01-20','entregada','OK',2010,'presencial',TRUE),
(3011,'2025-01-15','2025-01-22',NULL,'pendiente','En preparación',2011,'online',FALSE),
(3012,'2025-01-16','2025-01-23','2025-01-23','entregada','OK',2012,'online',TRUE),
(3013,'2025-01-17','2025-01-24',NULL,'pendiente','Pendiente confirmación',2013,'presencial',FALSE),
(3014,'2025-01-18','2025-01-25','2025-01-24','entregada','OK',2014,'online',TRUE),
(3015,'2025-01-19','2025-01-26',NULL,'pendiente','Cliente pidió cambio',2015,'online',FALSE),
(3016,'2025-01-20','2025-01-27','2025-01-27','entregada','OK',2016,'presencial',TRUE),
(3017,'2025-01-21','2025-01-28',NULL,'pendiente','En preparación',2017,'online',FALSE),
(3018,'2025-01-22','2025-01-29','2025-01-28','entregada','OK',2018,'online',TRUE),
(3019,'2025-01-23','2025-01-30',NULL,'pendiente','Pendiente pago',2019,'presencial',FALSE),
(3020,'2025-01-24','2025-01-31','2025-01-31','entregada','OK',2020,'online',TRUE);

-- =========================
-- 7) DETALLESORDENES (20)
-- =========================
INSERT INTO detallesordenes
(id_orden, id_producto, cantidadPedida, valorUnitario, ordenEntrega, tipo_descuento, aplica_impuesto)
VALUES
(3001,'P0001',2,12.99,1,'ninguno',TRUE),
(3002,'P0002',1,39.99,1,'promo',TRUE),
(3003,'P0003',1,29.99,1,'ninguno',TRUE),
(3004,'P0004',1,44.99,1,'ninguno',TRUE),
(3005,'P0005',3,6.50,1,'promo',TRUE),
(3006,'P0006',1,18.90,1,'ninguno',TRUE),
(3007,'P0007',5,2.25,1,'ninguno',TRUE),
(3008,'P0008',1,89.99,1,'ninguno',TRUE),
(3009,'P0009',2,7.99,1,'promo',TRUE),
(3010,'P0010',2,9.99,1,'ninguno',TRUE),
(3011,'P0011',10,1.99,1,'ninguno',TRUE),
(3012,'P0012',1,24.99,1,'promo',TRUE),
(3013,'P0013',4,3.49,1,'ninguno',TRUE),
(3014,'P0014',1,59.99,1,'ninguno',TRUE),
(3015,'P0015',2,19.99,1,'promo',TRUE),
(3016,'P0016',1,12.50,1,'ninguno',TRUE),
(3017,'P0017',2,5.99,1,'ninguno',TRUE),
(3018,'P0018',12,0.50,1,'ninguno',TRUE),
(3019,'P0019',1,22.00,1,'promo',TRUE),
(3020,'P0020',1,14.99,1,'ninguno',TRUE);

-- =========================
-- 8) PAGOS (20)
-- =========================
INSERT INTO pagos
(id_cliente, numeroFactura, fechaPago, totalPago, metodo_pago, confirmado)
VALUES
(2001,'F-2025-0001','2025-01-10',25.98,'tarjeta',TRUE),
(2002,'F-2025-0002','2025-01-13',39.99,'efectivo',TRUE),
(2003,'F-2025-0003','2025-01-14',29.99,'transferencia',TRUE),
(2004,'F-2025-0004','2025-01-14',44.99,'tarjeta',TRUE),
(2005,'F-2025-0005','2025-01-16',19.50,'efectivo',FALSE),
(2006,'F-2025-0006','2025-01-16',18.90,'tarjeta',TRUE),
(2007,'F-2025-0007','2025-01-18',11.25,'transferencia',TRUE),
(2008,'F-2025-0008','2025-01-19',89.99,'tarjeta',TRUE),
(2009,'F-2025-0009','2025-01-20',15.98,'efectivo',TRUE),
(2010,'F-2025-0010','2025-01-20',19.98,'tarjeta',TRUE),
(2011,'F-2025-0011','2025-01-22',19.90,'transferencia',TRUE),
(2012,'F-2025-0012','2025-01-23',24.99,'tarjeta',TRUE),
(2013,'F-2025-0013','2025-01-24',13.96,'efectivo',TRUE),
(2014,'F-2025-0014','2025-01-24',59.99,'tarjeta',TRUE),
(2015,'F-2025-0015','2025-01-26',39.98,'transferencia',TRUE),
(2016,'F-2025-0016','2025-01-27',12.50,'efectivo',TRUE),
(2017,'F-2025-0017','2025-01-28',11.98,'tarjeta',TRUE),
(2018,'F-2025-0018','2025-01-28',6.00,'efectivo',TRUE),
(2019,'F-2025-0019','2025-01-30',22.00,'tarjeta',TRUE),
(2020,'F-2025-0020','2025-01-31',14.99,'transferencia',TRUE);

SELECT COUNT(*) AS oficinas FROM oficinas;
SELECT COUNT(*) AS empleados FROM empleados;
SELECT COUNT(*) AS clientes FROM clientes;
SELECT COUNT(*) AS lineasproductos FROM lineasproductos;
SELECT COUNT(*) AS productos FROM productos;
SELECT COUNT(*) AS ordenes FROM ordenes;
SELECT COUNT(*) AS detallesordenes FROM detallesordenes;
SELECT COUNT(*) AS pagos FROM pagos;

SHOW TABLES;