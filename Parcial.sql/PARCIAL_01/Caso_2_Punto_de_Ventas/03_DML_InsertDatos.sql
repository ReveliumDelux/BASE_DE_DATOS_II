-- ========================================
-- CASO 2: SISTEMA DE PUNTO DE VENTAS
-- DML - Inserción de Datos
-- ========================================

USE punto_ventas;

-- ========================================
-- INSERCIÓN EN TABLA PAISES
-- ========================================
INSERT INTO paises (nombre_pais, region, continente, codigo_iso) VALUES
('Colombia', 'Andina', 'America del Sur', 'CO'),
('Argentina', 'Cono Sur', 'America del Sur', 'AR'),
('Brasil', 'Nordeste', 'America del Sur', 'BR'),
('Mexico', 'Mesoamerica', 'America del Norte', 'MX'),
('Espana', 'Iberica', 'Europa', 'ES'),
('Estados Unidos', 'Norteamericana', 'America del Norte', 'US'),
('Chile', 'Cono Sur', 'America del Sur', 'CL'),
('Peru', 'Andina', 'America del Sur', 'PE'),
('Venezuela', 'Caribeña', 'America del Sur', 'VE'),
('Ecuador', 'Andina', 'America del Sur', 'EC'),
('Paraguay', 'Cono Sur', 'America del Sur', 'PY'),
('Uruguay', 'Cono Sur', 'America del Sur', 'UY');

-- ========================================
-- INSERCIÓN EN TABLA OFICINAS
-- ========================================
INSERT INTO oficinas (ciudad, telefono, direccion, departamento, id_pais, codigoPostal, continente, tipo_oficina, activa, codigo_unico) VALUES
('Bogotá', '(1) 5555000', 'Cra 15 No 20-10', 'Cundinamarca', 1, '110111', 'America', 'Central', TRUE, 'OF-BOG-001'),
('Medellín', '(4) 5555001', 'Cra 80 No 50-25', 'Antioquia', 1, '050010', 'America', 'Regional', TRUE, 'OF-MDE-001'),
('Cali', '(2) 5555002', 'Av. Sexta 20-80', 'Valle', 1, '760001', 'America', 'Sucursal', TRUE, 'OF-CLI-001'),
('Buenos Aires', '(11) 4555003', 'Av. Corrientes 1234', 'Buenos Aires', 2, '1043', 'America', 'Central', TRUE, 'OF-BUE-001'),
('Córdoba', '(351) 5555004', 'Av. Colón 500', 'Córdoba', 2, '5000', 'America', 'Regional', TRUE, 'OF-COR-001'),
('São Paulo', '(11) 5555005', 'Rua Paulista 1000', 'São Paulo', 3, '01310100', 'America', 'Central', TRUE, 'OF-SAO-001'),
('Belo Horizonte', '(31) 5555006', 'Av. Getúlio 500', 'Minas Gerais', 3, '30130100', 'America', 'Regional', TRUE, 'OF-BEL-001'),
('Ciudad de México', '(55) 5555007', 'Paseo Reforma 505', 'CDMX', 4, '06500', 'America', 'Central', TRUE, 'OF-MEX-001'),
('Guadalajara', '(33) 5555008', 'Av. López Mateos 888', 'Jalisco', 4, '44100', 'America', 'Regional', TRUE, 'OF-GDL-001'),
('Nueva York', '(212) 5555009', 'Fifth Avenue 123', 'NY', 6, '10022', 'America', 'Sucursal', TRUE, 'OF-NYC-001'),
('Madrid', '(91) 5555010', 'Paseo del Prado 456', 'Madrid', 5, '28014', 'Europa', 'Central', TRUE, 'OF-MAD-001'),
('Barcelona', '(93) 5555011', 'Paseo de Gracia 100', 'Cataluña', 5, '08008', 'Europa', 'Regional', TRUE, 'OF-BCN-001');

-- ========================================
-- INSERCIÓN EN TABLA EMPLEADOS
-- ========================================
INSERT INTO empleados (apellido, nombre, extension, email, id_oficina, jefe, cargo, tipo_empleado, activo, correo_unico) VALUES
('García', 'Juan', '1001', 'juan.garcia@company.com', 1, NULL, 'Gerente General', 'Gerente', TRUE, 'juan.garcia@company.com'),
('López', 'María', '1002', 'maria.lopez@company.com', 1, 1, 'Vendedora Senior', 'Ventas', TRUE, 'maria.lopez@company.com'),
('Rodríguez', 'Carlos', '1003', 'carlos.rodriguez@company.com', 1, 1, 'Vendedor', 'Ventas', TRUE, 'carlos.rodriguez@company.com'),
('Martínez', 'Ana', '1004', 'ana.martinez@company.com', 1, 1, 'Asistente', 'Administrativo', TRUE, 'ana.martinez@company.com'),
('Sánchez', 'Pedro', '2001', 'pedro.sanchez@company.com', 2, 1, 'Gerente Regional', 'Gerente', TRUE, 'pedro.sanchez@company.com'),
('González', 'Laura', '2002', 'laura.gonzalez@company.com', 2, 5, 'Vendedora', 'Ventas', TRUE, 'laura.gonzalez@company.com'),
('Fernández', 'Roberto', '2003', 'roberto.fernandez@company.com', 2, 5, 'Vendedor', 'Ventas', TRUE, 'roberto.fernandez@company.com'),
('Díaz', 'Elena', '3001', 'elena.diaz@company.com', 3, 1, 'Supervisora', 'Ventas', TRUE, 'elena.diaz@company.com'),
('Morales', 'Diego', '3002', 'diego.morales@company.com', 3, 8, 'Vendedor', 'Ventas', TRUE, 'diego.morales@company.com'),
('Pérez', 'Sandra', '4001', 'sandra.perez@company.com', 4, NULL, 'Gerente Regional', 'Gerente', TRUE, 'sandra.perez@company.com'),
('Ramos', 'Miguel', '4002', 'miguel.ramos@company.com', 4, 10, 'Vendedor', 'Ventas', TRUE, 'miguel.ramos@company.com'),
('Cortés', 'Vanessa', '5001', 'vanessa.cortes@company.com', 5, 10, 'Vendedora', 'Ventas', TRUE, 'vanessa.cortes@company.com'),
('Vargas', 'Luis', '6001', 'luis.vargas@company.com', 6, NULL, 'Gerente Regional', 'Gerente', FALSE, 'luis.vargas@company.com'),
('Silva', 'Patricia', '6002', 'patricia.silva@company.com', 6, 13, 'Asistente', 'Administrativo', TRUE, 'patricia.silva@company.com'),
('Castro', 'Andrés', '7001', 'andres.castro@company.com', 7, 13, 'Vendedor', 'Ventas', TRUE, 'andres.castro@company.com');

-- ========================================
-- INSERCIÓN EN TABLA CATEGORIAS_PRODUCTOS
-- ========================================
INSERT INTO categorias_productos (nombre_categoria, descripcion) VALUES
('Tecnologia', 'Productos electrónicos y equipos tecnológicos'),
('Oficina', 'Artículos y muebles de oficina'),
('Hogar', 'Productos para el hogar y decoración'),
('Electrónica', 'Equipos electrónicos diversos'),
('Software', 'Software y licencias'),
('Periféricos', 'Periféricos para computadoras'),
('Muebles', 'Mueblería general'),
('Accesorios', 'Accesorios varios');

-- ========================================
-- INSERCIÓN EN TABLA PRODUCTOS
-- ========================================
INSERT INTO productos (nombreProducto, id_lineaProducto, escala, cantidad, precioVenta, MSRP, id_categoria, disponible, codigo_producto) VALUES
('Laptop Dell XPS 15', 1, 'Unitario', 50, 1200.00, 1299.99, 1, TRUE, 'PROD-001'),
('Monitor LG 27 pulgadas', 2, 'Unitario', 75, 350.00, 399.99, 1, TRUE, 'PROD-002'),
('Teclado Mecánico RGB', 3, 'Unitario', 120, 89.99, 99.99, 1, TRUE, 'PROD-003'),
('Mouse Logitech Inalámbrico', 4, 'Unitario', 200, 45.00, 49.99, 1, TRUE, 'PROD-004'),
('Escritorio Ergonómico', 5, 'Unitario', 30, 450.00, 499.99, 2, TRUE, 'PROD-005'),
('Silla de Oficina Premium', 6, 'Unitario', 40, 350.00, 399.99, 2, TRUE, 'PROD-006'),
('Impresora HP LaserJet', 7, 'Unitario', 25, 250.00, 299.99, 1, TRUE, 'PROD-007'),
('Webcam Full HD', 8, 'Unitario', 85, 79.99, 89.99, 1, TRUE, 'PROD-008'),
('Lámpara LED Escritorio', 9, 'Unitario', 60, 55.00, 64.99, 2, TRUE, 'PROD-009'),
('Cortinas Blackout', 10, '2 metros', 40, 85.00, 99.99, 3, TRUE, 'PROD-010'),
('Rack Servidor 42U', 11, 'Unitario', 15, 800.00, 899.99, 1, TRUE, 'PROD-011'),
('Cable HDMI Premium', 12, '3 metros', 500, 15.00, 19.99, 6, TRUE, 'PROD-012'),
('Mochila Laptop 17 pulgadas', 13, 'Unitario', 100, 65.00, 79.99, 8, TRUE, 'PROD-013'),
('Protector de Pantalla', 14, 'Pack 5', 200, 25.00, 29.99, 8, TRUE, 'PROD-014'),
('Escritorio Gamer', 15, 'Unitario', 20, 550.00, 649.99, 2, TRUE, 'PROD-015');

-- ========================================
-- INSERCIÓN EN TABLA CLIENTES
-- ========================================
INSERT INTO clientes (empresa, apellido, nombre, telefono, direccion, ciudad, departamento, codigoPostal, id_pais, empleadoAtiende, limiteCredito, tipo_cliente, activo, email_unico) VALUES
('TechCorp SA', 'García', 'Juan', '(1) 3001001', 'Cra 15 No 20-10', 'Bogotá', 'Cundinamarca', '110111', 1, 1, 50000, 'Premium', TRUE, 'juan.empresa@techcorp.com'),
('FinanceGlobal Ltd', 'López', 'María', '(1) 3001002', 'Cra 7 No 30-15', 'Bogotá', 'Cundinamarca', '110111', 1, 2, 75000, 'VIP', TRUE, 'maria.empresa@financegl.com'),
('CloudNext Solutions', 'Rodríguez', 'Carlos', '(1) 3001003', 'Av. Paseo de los Libertadores', 'Bogotá', 'Cundinamarca', '110111', 1, 3, 30000, 'Regular', TRUE, 'carlos.empresa@cloudnext.com'),
('DataAnalytics Inc', 'Martínez', 'Ana', '(4) 3002001', 'Cra 80 No 50-25', 'Medellín', 'Antioquia', '050010', 1, 6, 60000, 'Premium', TRUE, 'ana.empresa@dataanalytics.com'),
('SecureNet Systems', 'Sánchez', 'Pedro', '(4) 3002002', 'Centro Comercial El Hueco', 'Medellín', 'Antioquia', '050010', 1, 7, 40000, 'Regular', TRUE, 'pedro.empresa@securenet.com'),
('ConsultPro Group', 'González', 'Laura', '(2) 3003001', 'Av. Sexta 20-80', 'Cali', 'Valle', '760001', 1, 8, 25000, 'Regular', TRUE, 'laura.empresa@consultpro.com'),
('BackupForce SA', 'Fernández', 'Roberto', '(11) 4002001', 'Av. Corrientes 1500', 'Buenos Aires', 'Buenos Aires', '1043', 2, 10, 55000, 'Premium', TRUE, 'roberto.empresa@backupforce.com'),
('CloudPlus Mexico', 'Díaz', 'Elena', '(55) 3101001', 'Paseo Reforma 505', 'Ciudad de México', 'CDMX', '06500', 4, 11, 70000, 'VIP', TRUE, 'elena.empresa@cloudplus.com'),
('InnovateAI Labs', 'Pérez', 'Sandra', '(11) 3102001', 'Rua Paulista 1000', 'São Paulo', 'São Paulo', '01310100', 3, 14, 85000, 'VIP', TRUE, 'sandra.empresa@aidlab.com'),
('GlobalConnect Partners', 'Ramos', 'Miguel', '(91) 4003001', 'Paseo del Prado 456', 'Madrid', 'Madrid', '28014', 5, 2, 45000, 'Premium', TRUE, 'miguel.empresa@globalconnect.es'),
('European Tech Partners', 'Cortés', 'Vanessa', '(93) 4004001', 'Paseo de Gracia 100', 'Barcelona', 'Cataluña', '08008', 5, 2, 35000, 'Regular', TRUE, 'vanessa.empresa@eurtechpartners.es'),
('Innovation Hub Mexico', 'Vargas', 'Luis', '(33) 3201001', 'Av. López Mateos 888', 'Guadalajara', 'Jalisco', '44100', 4, 1, 50000, 'Premium', TRUE, 'luis.empresa@innovhubmx.com'),
('ByteForce Argentina', 'Silva', 'Patricia', '(351) 4005001', 'Av. Colón 500', 'Córdoba', 'Córdoba', '5000', 2, 12, 48000, 'Premium', TRUE, 'patricia.empresa@byteforcearg.com'),
('Smart Solutions Brazil', 'Castro', 'Andrés', '(31) 3102003', 'Av. Getúlio 500', 'Belo Horizonte', 'Minas Gerais', '30130100', 3, 15, 62000, 'VIP', TRUE, 'andres.empresa@smartsol.br'),
('TechDev Solutions', 'García', 'Manuel', '(212) 3202001', 'Fifth Avenue 123', 'Nueva York', 'NY', '10022', 6, 1, 95000, 'VIP', TRUE, 'manuel.empresa@techdevsol.com');

-- ========================================
-- INSERCIÓN EN TABLA ORDENES
-- ========================================
INSERT INTO ordenes (fechaRecibido, fechaLimiteEntrega, fechaEntrega, estado, observacion, id_cliente, tipo_orden, completada, codigo_orden) VALUES
('2024-02-01', '2024-02-10', '2024-02-08', 'Entregada', 'Orden completada sin novedades', 1, 'Online', TRUE, 'ORD-2024-001'),
('2024-02-05', '2024-02-15', '2024-02-14', 'Entregada', 'Entrega conforme a lo esperado', 2, 'Presencial', TRUE, 'ORD-2024-002'),
('2024-02-08', '2024-02-18', NULL, 'En proceso', 'Esperando confirmación de stock', 3, 'Online', FALSE, 'ORD-2024-003'),
('2024-02-10', '2024-02-20', '2024-02-19', 'Entregada', 'Cliente satisfecho', 4, 'Online', TRUE, 'ORD-2024-004'),
('2024-02-12', '2024-02-22', '2024-02-21', 'Entregada', 'Orden expedida sin problemas', 5, 'Presencial', TRUE, 'ORD-2024-005'),
('2024-02-15', '2024-02-25', NULL, 'Pendiente', 'Aguardando pago', 6, 'Online', FALSE, 'ORD-2024-006'),
('2024-02-18', '2024-02-28', NULL, 'Cancelada', 'Cliente solicitó cancelación', 7, 'Online', FALSE, 'ORD-2024-007'),
('2024-02-20', '2024-03-01', '2024-02-28', 'Entregada', 'Entrega exitosa', 8, 'Presencial', TRUE, 'ORD-2024-008'),
('2024-02-22', '2024-03-03', NULL, 'En proceso', 'Preparando envío', 9, 'Online', FALSE, 'ORD-2024-009'),
('2024-02-24', '2024-03-05', '2024-03-04', 'Entregada', 'Orden recibida en buen estado', 10, 'Online', TRUE, 'ORD-2024-010'),
('2024-02-26', '2024-03-07', NULL, 'Pendiente', 'A la espera de confirmación', 11, 'Presencial', FALSE, 'ORD-2024-011'),
('2024-02-28', '2024-03-09', NULL, 'En proceso', 'Empaque en curso', 12, 'Online', FALSE, 'ORD-2024-012'),
('2024-02-29', '2024-03-10', '2024-03-09', 'Entregada', 'Cliente aceptó la entrega', 13, 'Online', TRUE, 'ORD-2024-013'),
('2024-03-01', '2024-03-11', NULL, 'Pendiente', 'Validando dirección', 14, 'Online', FALSE, 'ORD-2024-014'),
('2024-03-03', '2024-03-13', '2024-03-12', 'Entregada', 'Entrega conforme', 15, 'Presencial', TRUE, 'ORD-2024-015');

-- ========================================
-- INSERCIÓN EN TABLA DETALLE_ORDENES
-- ========================================
INSERT INTO detalle_ordenes (id_orden, id_producto, cantidadPedida, valorUnitario, ordenEntrega, tipo_detalle, entregado, codigo_detalle) VALUES
(1, 1, 2, 1200.00, 1, 'Normal', TRUE, 'DET-2024-001'),
(1, 3, 5, 89.99, 2, 'Normal', TRUE, 'DET-2024-002'),
(2, 2, 1, 350.00, 1, 'Normal', TRUE, 'DET-2024-003'),
(2, 4, 2, 45.00, 2, 'Promocion', TRUE, 'DET-2024-004'),
(3, 5, 1, 450.00, 1, 'Normal', FALSE, 'DET-2024-005'),
(4, 6, 3, 350.00, 1, 'Normal', TRUE, 'DET-2024-006'),
(4, 9, 2, 55.00, 2, 'Normal', TRUE, 'DET-2024-007'),
(5, 7, 1, 250.00, 1, 'Normal', TRUE, 'DET-2024-008'),
(5, 12, 10, 15.00, 2, 'Promocion', TRUE, 'DET-2024-009'),
(6, 8, 1, 79.99, 1, 'Normal', FALSE, 'DET-2024-010'),
(7, 11, 1, 800.00, 1, 'Normal', FALSE, 'DET-2024-011'),
(8, 2, 2, 350.00, 1, 'Normal', TRUE, 'DET-2024-012'),
(8, 3, 3, 89.99, 2, 'Normal', TRUE, 'DET-2024-013'),
(9, 1, 1, 1200.00, 1, 'Normal', FALSE, 'DET-2024-014'),
(10, 13, 2, 65.00, 1, 'Normal', TRUE, 'DET-2024-015'),
(10, 14, 1, 25.00, 2, 'Promocion', TRUE, 'DET-2024-016'),
(11, 5, 1, 450.00, 1, 'Normal', FALSE, 'DET-2024-017'),
(12, 4, 4, 45.00, 1, 'Normal', FALSE, 'DET-2024-018'),
(13, 10, 1, 85.00, 1, 'Normal', TRUE, 'DET-2024-019'),
(14, 6, 2, 350.00, 1, 'Normal', FALSE, 'DET-2024-020'),
(15, 2, 1, 350.00, 1, 'Normal', TRUE, 'DET-2024-021'),
(15, 8, 1, 79.99, 2, 'Normal', TRUE, 'DET-2024-022');

-- ========================================
-- INSERCIÓN EN TABLA PAGOS
-- ========================================
INSERT INTO pagos (id_cliente, id_orden, numeroFactura, fechaPago, totalPago, metodo_pago, confirmado, codigo_pago) VALUES
(1, 1, 'FAC-2024-001', '2024-02-08', 2489.95, 'Tarjeta', TRUE, 'PAG-2024-001'),
(2, 2, 'FAC-2024-002', '2024-02-14', 440.00, 'Transferencia', TRUE, 'PAG-2024-002'),
(3, 3, 'FAC-2024-003', '2024-02-18', 450.00, 'Tarjeta', FALSE, 'PAG-2024-003'),
(4, 4, 'FAC-2024-004', '2024-02-19', 1200.00, 'Efectivo', TRUE, 'PAG-2024-004'),
(5, 5, 'FAC-2024-005', '2024-02-21', 400.00, 'Transferencia', TRUE, 'PAG-2024-005'),
(6, 6, 'FAC-2024-006', '2024-02-25', 79.99, 'Tarjeta', FALSE, 'PAG-2024-006'),
(7, 7, 'FAC-2024-007', '2024-02-26', 800.00, 'Tarjeta', FALSE, 'PAG-2024-007'),
(8, 8, 'FAC-2024-008', '2024-02-28', 1179.98, 'Transferencia', TRUE, 'PAG-2024-008'),
(9, 9, 'FAC-2024-009', '2024-03-01', 1200.00, 'Tarjeta', FALSE, 'PAG-2024-009'),
(10, 10, 'FAC-2024-010', '2024-03-04', 180.00, 'Efectivo', TRUE, 'PAG-2024-010'),
(11, 11, 'FAC-2024-011', '2024-03-06', 450.00, 'Tarjeta', FALSE, 'PAG-2024-011'),
(12, 12, 'FAC-2024-012', '2024-03-08', 360.00, 'Transferencia', FALSE, 'PAG-2024-012'),
(13, 13, 'FAC-2024-013', '2024-03-09', 160.00, 'Tarjeta', TRUE, 'PAG-2024-013'),
(14, 14, 'FAC-2024-014', '2024-03-11', 700.00, 'Efectivo', FALSE, 'PAG-2024-014'),
(15, 15, 'FAC-2024-015', '2024-03-12', 809.99, 'Transferencia', TRUE, 'PAG-2024-015'),
(1, 0, 'FAC-2024-016', '2024-02-28', 1500.00, 'Tarjeta', TRUE, 'PAG-2024-016'),
(2, 0, 'FAC-2024-017', '2024-03-01', 2000.00, 'Transferencia', TRUE, 'PAG-2024-017');

-- diez registros adicionales para clientes y ordenes
INSERT INTO clientes (empresa, apellido, nombre, telefono, direccion, ciudad, departamento, codigoPostal, id_pais, empleadoAtiende, limiteCredito, tipo_cliente, activo, email_unico) VALUES
('EcoEnergy SA', 'Moreno', 'Gabriela', '(1) 3006001', 'Cra 25 No 60-10', 'Bogotá', 'Cundinamarca', '110111', 1, 2, 55000, 'Premium', TRUE, 'gabriela@ecoenergy.com'),
('UrbanMove', 'Pérez', 'Diego', '(1) 3006002', 'Av. Circunvalar 100', 'Medellín', 'Antioquia', '050010', 1, 5, 30000, 'Regular', TRUE, 'diego@urbanmove.com'),
('HealthPlus', 'Rodríguez', 'Sofia', '(1) 3006003', 'Cra 10 No 20-20', 'Bogotá', 'Cundinamarca', '110111', 1, 3, 70000, 'VIP', TRUE, 'sofia@healthplus.com'),
('AgriTec', 'Gómez', 'Andrés', '(4) 3007001', 'Av. 1 No 1-1', 'Cali', 'Valle', '760001', 1, 8, 40000, 'Regular', TRUE, 'andres@agritec.com'),
('LogistiCo', 'Martínez', 'Carla', '(11) 4007001', 'Av. 9 No 9-9', 'Buenos Aires', 'Buenos Aires', '1043', 2, 10, 65000, 'Premium', TRUE, 'carla@logistico.com'),
('MediaLink', 'Santos', 'Ricardo', '(55) 3008001', 'Av. Insurgentes 200', 'Ciudad de México', 'CDMX', '06500', 4, 11, 50000, 'Premium', TRUE, 'ricardo@medialink.com'),
('DevStudio', 'Hernández', 'María', '(11) 3009001', 'Rua X 123', 'São Paulo', 'São Paulo', '01310100', 3, 14, 80000, 'VIP', TRUE, 'maria@devstudio.com'),
('TravelGo', 'López', 'Jorge', '(91) 4009001', 'Paseo Y 456', 'Madrid', 'Madrid', '28014', 5, 2, 20000, 'Regular', TRUE, 'jorge@travelgo.com'),
('SysCloud', 'Duarte', 'Ana', '(93) 4009002', 'Calle Z 789', 'Barcelona', 'Cataluña', '08008', 5, 2, 45000, 'Premium', TRUE, 'ana@syscloud.es'),
('BioHealth', 'Mendoza', 'Luis', '(33) 3209001', 'Av. V 321', 'Guadalajara', 'Jalisco', '44100', 4, 1, 55000, 'Premium', TRUE, 'luis@biohealth.mx');
