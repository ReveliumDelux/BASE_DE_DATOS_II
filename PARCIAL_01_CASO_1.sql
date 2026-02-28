CREATE DATABASE sistema_servicios;
USE sistema_servicios;

-- =========================
-- CREACION DE TABLAS
-- =========================
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(150),

    nivel ENUM('admin','cliente','soporte') NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    estado ENUM('activo','inactivo','suspendido') NOT NULL,
    verificado BOOLEAN DEFAULT FALSE,

    id_rol INT NOT NULL,

    FOREIGN KEY (id_rol)
        REFERENCES roles(id_rol)
);
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) CHECK (precio > 0),

    tipo_servicio ENUM('streaming','hosting','cloud','software'),
    activo BOOLEAN DEFAULT TRUE
);
CREATE TABLE suscripciones (
    id_suscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_servicio INT NOT NULL,

    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,

    estado ENUM('activa','cancelada','vencida'),
    renovacion_automatica BOOLEAN DEFAULT TRUE,

    UNIQUE(id_usuario, id_servicio),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_servicio)
        REFERENCES servicios(id_servicio)
);
CREATE TABLE metodos_pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_metodo VARCHAR(50) UNIQUE,

    tipo ENUM('tarjeta','transferencia','paypal','yappy'),
    activo BOOLEAN DEFAULT TRUE
);
CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_suscripcion INT NOT NULL,
    id_metodo INT NOT NULL,

    monto DECIMAL(10,2) CHECK (monto > 0),
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,

    estado_pago ENUM('pagado','pendiente','rechazado'),
    confirmado BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_suscripcion)
        REFERENCES suscripciones(id_suscripcion),

    FOREIGN KEY (id_metodo)
        REFERENCES metodos_pago(id_metodo)
);
CREATE TABLE auditoria_accesos (
    id_acceso INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,

    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    direccion_ip VARCHAR(50),

    resultado ENUM('exitoso','fallido'),
    es_seguro BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
);

SHOW TABLES;
DESCRIBE usuarios;
DESCRIBE servicios;
DESCRIBE pagos;

USE sistema_servicios;

-- =========================
-- INSERCION DE DATOS
-- =========================


-- =========================
-- 1) ROLES (20)
-- =========================
INSERT INTO roles (nombre, descripcion, nivel, activo) VALUES
('ROL_01_ADMIN','Rol administrativo 01','admin',TRUE),
('ROL_02_ADMIN','Rol administrativo 02','admin',TRUE),
('ROL_03_ADMIN','Rol administrativo 03','admin',TRUE),
('ROL_04_SOPORTE','Rol soporte 04','soporte',TRUE),
('ROL_05_SOPORTE','Rol soporte 05','soporte',TRUE),
('ROL_06_SOPORTE','Rol soporte 06','soporte',TRUE),
('ROL_07_CLIENTE','Rol cliente 07','cliente',TRUE),
('ROL_08_CLIENTE','Rol cliente 08','cliente',TRUE),
('ROL_09_CLIENTE','Rol cliente 09','cliente',TRUE),
('ROL_10_CLIENTE','Rol cliente 10','cliente',TRUE),
('ROL_11_CLIENTE','Rol cliente 11','cliente',TRUE),
('ROL_12_CLIENTE','Rol cliente 12','cliente',TRUE),
('ROL_13_CLIENTE','Rol cliente 13','cliente',TRUE),
('ROL_14_CLIENTE','Rol cliente 14','cliente',TRUE),
('ROL_15_CLIENTE','Rol cliente 15','cliente',TRUE),
('ROL_16_CLIENTE','Rol cliente 16','cliente',TRUE),
('ROL_17_CLIENTE','Rol cliente 17','cliente',TRUE),
('ROL_18_CLIENTE','Rol cliente 18','cliente',TRUE),
('ROL_19_CLIENTE','Rol cliente 19','cliente',TRUE),
('ROL_20_CLIENTE','Rol cliente 20','cliente',TRUE);

-- =========================
-- 2) USUARIOS (20)  (id_rol 1..20)
-- =========================
INSERT INTO usuarios
(nombre, email, password_hash, estado, verificado, id_rol)
VALUES
('Luis Gomez','luis.gomez@demo.com','hash_001','activo',TRUE,1),
('Ana Perez','ana.perez@demo.com','hash_002','activo',TRUE,2),
('Carlos Ruiz','carlos.ruiz@demo.com','hash_003','activo',FALSE,3),
('Maria Lopez','maria.lopez@demo.com','hash_004','activo',TRUE,4),
('Jorge Martinez','jorge.martinez@demo.com','hash_005','inactivo',FALSE,5),
('Paola Sanchez','paola.sanchez@demo.com','hash_006','activo',TRUE,6),
('Diego Castillo','diego.castillo@demo.com','hash_007','suspendido',FALSE,7),
('Sofia Hernandez','sofia.hernandez@demo.com','hash_008','activo',TRUE,8),
('Kevin Torres','kevin.torres@demo.com','hash_009','activo',FALSE,9),
('Valeria Ruiz','valeria.ruiz@demo.com','hash_010','activo',TRUE,10),
('Miguel Vargas','miguel.vargas@demo.com','hash_011','activo',TRUE,11),
('Camila Morales','camila.morales@demo.com','hash_012','activo',FALSE,12),
('Andres Ramos','andres.ramos@demo.com','hash_013','inactivo',FALSE,13),
('Elena Navarro','elena.navarro@demo.com','hash_014','activo',TRUE,14),
('Roberto Ortega','roberto.ortega@demo.com','hash_015','activo',TRUE,15),
('Daniela Silva','daniela.silva@demo.com','hash_016','activo',FALSE,16),
('Ivan Mendoza','ivan.mendoza@demo.com','hash_017','activo',TRUE,17),
('Natalia Flores','natalia.flores@demo.com','hash_018','suspendido',FALSE,18),
('Oscar Jimenez','oscar.jimenez@demo.com','hash_019','activo',TRUE,19),
('Fernanda Diaz','fernanda.diaz@demo.com','hash_020','activo',TRUE,20);

-- =========================
-- 3) SERVICIOS (20)
-- =========================
INSERT INTO servicios (nombre, descripcion, precio, tipo_servicio, activo) VALUES
('StreamPlus','Streaming premium',9.99,'streaming',TRUE),
('HostBasic','Hosting básico',5.99,'hosting',TRUE),
('CloudBox','Almacenamiento cloud',7.49,'cloud',TRUE),
('SoftDesk','Software oficina',12.99,'software',TRUE),
('StreamMax','Streaming familiar',14.99,'streaming',TRUE),
('HostPro','Hosting profesional',19.99,'hosting',TRUE),
('CloudDrive','Cloud empresarial',24.99,'cloud',TRUE),
('SoftCRM','CRM para ventas',29.99,'software',TRUE),
('StreamKids','Streaming niños',6.99,'streaming',TRUE),
('HostShop','Hosting e-commerce',22.50,'hosting',TRUE),
('CloudSecure','Cloud con seguridad',27.00,'cloud',TRUE),
('SoftPM','Gestión de proyectos',18.75,'software',TRUE),
('StreamSports','Streaming deportes',11.25,'streaming',TRUE),
('HostMail','Correo corporativo',8.50,'hosting',TRUE),
('CloudAI','Cloud para IA',34.99,'cloud',TRUE),
('SoftERP','ERP empresarial',49.99,'software',TRUE),
('StreamMusic','Streaming música',4.99,'streaming',TRUE),
('HostUltra','Hosting alta carga',39.99,'hosting',TRUE),
('CloudBackup','Backup cloud',13.49,'cloud',TRUE),
('SoftHelpdesk','Mesa de ayuda',16.00,'software',TRUE);

-- =========================
-- 4) METODOS_PAGO (20)
-- =========================
INSERT INTO metodos_pago (nombre_metodo, tipo, activo) VALUES
('Visa_01','tarjeta',TRUE),
('Mastercard_02','tarjeta',TRUE),
('Transfer_Banco_03','transferencia',TRUE),
('PayPal_04','paypal',TRUE),
('Yappy_05','yappy',TRUE),
('Visa_06','tarjeta',TRUE),
('Mastercard_07','tarjeta',TRUE),
('Transfer_Banco_08','transferencia',TRUE),
('PayPal_09','paypal',TRUE),
('Yappy_10','yappy',TRUE),
('Visa_11','tarjeta',TRUE),
('Mastercard_12','tarjeta',TRUE),
('Transfer_Banco_13','transferencia',TRUE),
('PayPal_14','paypal',TRUE),
('Yappy_15','yappy',TRUE),
('Visa_16','tarjeta',TRUE),
('Mastercard_17','tarjeta',TRUE),
('Transfer_Banco_18','transferencia',TRUE),
('PayPal_19','paypal',TRUE),
('Yappy_20','yappy',TRUE);

-- =========================
-- 5) SUSCRIPCIONES (20)
-- =========================
INSERT INTO suscripciones
(id_usuario, id_servicio, fecha_inicio, fecha_fin, estado, renovacion_automatica)
VALUES
(1,1,'2025-01-01',NULL,'activa',TRUE),
(2,2,'2025-01-02',NULL,'activa',TRUE),
(3,3,'2025-01-03',NULL,'activa',TRUE),
(4,4,'2025-01-04',NULL,'activa',TRUE),
(5,5,'2025-01-05','2025-02-05','cancelada',FALSE),
(6,6,'2025-01-06',NULL,'activa',TRUE),
(7,7,'2025-01-07',NULL,'activa',TRUE),
(8,8,'2025-01-08',NULL,'activa',TRUE),
(9,9,'2025-01-09',NULL,'activa',TRUE),
(10,10,'2025-01-10',NULL,'activa',TRUE),
(11,11,'2025-01-11',NULL,'activa',TRUE),
(12,12,'2025-01-12',NULL,'activa',TRUE),
(13,13,'2025-01-13','2025-02-13','vencida',FALSE),
(14,14,'2025-01-14',NULL,'activa',TRUE),
(15,15,'2025-01-15',NULL,'activa',TRUE),
(16,16,'2025-01-16',NULL,'activa',TRUE),
(17,17,'2025-01-17',NULL,'activa',TRUE),
(18,18,'2025-01-18',NULL,'activa',TRUE),
(19,19,'2025-01-19',NULL,'activa',TRUE),
(20,20,'2025-01-20',NULL,'activa',TRUE);

-- =========================
-- 6) PAGOS (20)
-- =========================
INSERT INTO pagos
(id_suscripcion, id_metodo, monto, fecha_pago, estado_pago, confirmado)
VALUES
(1,1,9.99,'2025-01-25 10:10:00','pagado',TRUE),
(2,2,5.99,'2025-01-25 10:20:00','pagado',TRUE),
(3,3,7.49,'2025-01-25 10:30:00','pagado',TRUE),
(4,4,12.99,'2025-01-25 10:40:00','pagado',TRUE),
(5,5,14.99,'2025-01-25 10:50:00','rechazado',FALSE),
(6,6,19.99,'2025-01-26 09:10:00','pagado',TRUE),
(7,7,24.99,'2025-01-26 09:20:00','pagado',TRUE),
(8,8,29.99,'2025-01-26 09:30:00','pagado',TRUE),
(9,9,6.99,'2025-01-26 09:40:00','pagado',TRUE),
(10,10,22.50,'2025-01-26 09:50:00','pagado',TRUE),
(11,11,27.00,'2025-01-27 11:00:00','pagado',TRUE),
(12,12,18.75,'2025-01-27 11:10:00','pagado',TRUE),
(13,13,11.25,'2025-01-27 11:20:00','pendiente',FALSE),
(14,14,8.50,'2025-01-27 11:30:00','pagado',TRUE),
(15,15,34.99,'2025-01-28 15:00:00','pagado',TRUE),
(16,16,49.99,'2025-01-28 15:10:00','pagado',TRUE),
(17,17,4.99,'2025-01-28 15:20:00','pagado',TRUE),
(18,18,39.99,'2025-01-28 15:30:00','rechazado',FALSE),
(19,19,13.49,'2025-01-29 08:00:00','pagado',TRUE),
(20,20,16.00,'2025-01-29 08:10:00','pagado',TRUE);

-- =========================
-- 7) AUDITORIA_ACCESOS (20)
-- =========================
INSERT INTO auditoria_accesos
(id_usuario, fecha_hora, direccion_ip, resultado, es_seguro)
VALUES
(1,'2025-02-01 08:00:00','192.168.1.10','exitoso',TRUE),
(2,'2025-02-01 08:05:00','192.168.1.11','exitoso',TRUE),
(3,'2025-02-01 08:10:00','192.168.1.12','fallido',FALSE),
(4,'2025-02-01 08:15:00','192.168.1.13','exitoso',TRUE),
(5,'2025-02-01 08:20:00','192.168.1.14','fallido',FALSE),
(6,'2025-02-01 08:25:00','192.168.1.15','exitoso',TRUE),
(7,'2025-02-01 08:30:00','192.168.1.16','fallido',FALSE),
(8,'2025-02-01 08:35:00','192.168.1.17','exitoso',TRUE),
(9,'2025-02-01 08:40:00','192.168.1.18','exitoso',TRUE),
(10,'2025-02-01 08:45:00','192.168.1.19','exitoso',TRUE),
(11,'2025-02-01 08:50:00','192.168.1.20','exitoso',TRUE),
(12,'2025-02-01 08:55:00','192.168.1.21','fallido',FALSE),
(13,'2025-02-01 09:00:00','192.168.1.22','exitoso',TRUE),
(14,'2025-02-01 09:05:00','192.168.1.23','exitoso',TRUE),
(15,'2025-02-01 09:10:00','192.168.1.24','exitoso',TRUE),
(16,'2025-02-01 09:15:00','192.168.1.25','fallido',FALSE),
(17,'2025-02-01 09:20:00','192.168.1.26','exitoso',TRUE),
(18,'2025-02-01 09:25:00','192.168.1.27','fallido',FALSE),
(19,'2025-02-01 09:30:00','192.168.1.28','exitoso',TRUE),
(20,'2025-02-01 09:35:00','192.168.1.29','exitoso',TRUE);

SELECT
 (SELECT COUNT(*) FROM roles) AS roles,
 (SELECT COUNT(*) FROM usuarios) AS usuarios,
 (SELECT COUNT(*) FROM servicios) AS servicios,
 (SELECT COUNT(*) FROM metodos_pago) AS metodos_pago,
 (SELECT COUNT(*) FROM suscripciones) AS suscripciones,
 (SELECT COUNT(*) FROM pagos) AS pagos,
 (SELECT COUNT(*) FROM auditoria_accesos) AS auditoria_accesos;

-- =========================
-- CRUD
-- =========================

 INSERT INTO usuarios
(nombre, email, password_hash, estado, verificado, id_rol)
VALUES
('Gabriel Batista', 'gabriel.batista@demo.com', 'hash_new_021', 'activo', TRUE, 7);

SELECT
  u.id_usuario,
  u.nombre,
  u.email,
  u.estado,
  u.verificado,
  r.nombre AS rol
FROM usuarios u
JOIN roles r ON r.id_rol = u.id_rol
WHERE u.estado = 'activo'
ORDER BY u.id_usuario;

UPDATE usuarios
SET estado = 'suspendido',
    verificado = FALSE
WHERE id_usuario = 10
  AND estado = 'activo';

-- ========================= delete logico =========================
UPDATE usuarios
SET estado = 'inactivo'
WHERE id_usuario = 11;

-- =========================
-- VISTAS
-- =========================

CREATE OR REPLACE VIEW vw_negocio_resumen AS
SELECT
  u.id_usuario,
  u.nombre AS usuario,
  u.email,
  u.estado AS estado_usuario,
  r.nombre AS rol,

  su.id_suscripcion,
  su.estado AS estado_suscripcion,
  su.fecha_inicio,
  su.fecha_fin,

  s.id_servicio,
  s.nombre AS servicio,
  s.precio AS precio_servicio,

  p.id_pago,
  p.monto,
  p.fecha_pago,
  p.estado_pago,

  mp.nombre_metodo,
  mp.tipo AS tipo_metodo
FROM usuarios u
JOIN roles r ON r.id_rol = u.id_rol
LEFT JOIN suscripciones su ON su.id_usuario = u.id_usuario
LEFT JOIN servicios s ON s.id_servicio = su.id_servicio
LEFT JOIN pagos p ON p.id_suscripcion = su.id_suscripcion
LEFT JOIN metodos_pago mp ON mp.id_metodo = p.id_metodo;

CREATE VIEW vw_seguridad_usuarios AS
SELECT
 id_usuario,
 nombre,
 email,
 estado
FROM usuarios;

CREATE OR REPLACE VIEW vw_auditoria_accesos AS
SELECT
  a.id_acceso,
  a.fecha_hora,
  a.direccion_ip,
  a.resultado,
  a.es_seguro,
  u.id_usuario,
  u.nombre AS usuario,
  u.email,
  u.estado AS estado_usuario
FROM auditoria_accesos a
JOIN usuarios u ON u.id_usuario = a.id_usuario;

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

SELECT * 
FROM vw_negocio_resumen
LIMIT 10;

SELECT * 
FROM vw_seguridad_usuarios
LIMIT 10;

SELECT *
FROM auditoria_accesos
ORDER BY fecha_hora DESC;

