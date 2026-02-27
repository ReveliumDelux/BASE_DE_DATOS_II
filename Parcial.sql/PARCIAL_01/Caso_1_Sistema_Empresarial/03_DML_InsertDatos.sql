-- ========================================
-- CASO 1: SISTEMA EMPRESARIAL
-- DML - Inserción de Datos
-- ========================================

USE sistema_empresarial_servicios;

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
('Alemania', 'Centroeuropea', 'Europa', 'DE'),
('Francia', 'Occidental', 'Europa', 'FR'),
('Japon', 'Asiatica', 'Asia', 'JP');

-- ========================================
-- INSERCIÓN EN TABLA EMPRESAS
-- ========================================
INSERT INTO empresas (nombre_empresa, nit, sector, id_pais, ciudad, direccion, telefono, email_empresa, fecha_registro, estado, plan_suscripcion, es_cliente_premium) VALUES
('TechCorp Solutions', '123456789', 'Tecnología', 1, 'Bogotá', 'Cra 15 No 20-10', '(1) 5555000', 'info@techcorp.com', '2023-01-15', 'Activa', 'Empresarial', TRUE),
('FinanceGlobal SA', '987654321', 'Servicios Financieros', 2, 'Buenos Aires', 'Av. Corrientes 1234', '(11) 4555001', 'contacto@financegl.com', '2023-02-20', 'Activa', 'Profesional', TRUE),
('CloudNext Ltd', '456789123', 'Computación en la Nube', 6, 'Nueva York', '5th Avenue 123', '(212) 5555002', 'support@cloudnext.com', '2023-03-10', 'Activa', 'Empresarial', FALSE),
('DataAnalytics Inc', '789123456', 'Análisis de Datos', 3, 'São Paulo', 'Rua Paulista 1000', '(11) 5555003', 'hello@dataanalytics.com', '2023-04-05', 'Activa', 'Profesional', TRUE),
('SecureNet Systems', '321654987', 'Ciberseguridad', 1, 'Medellín', 'Cra 80 No 50-25', '(4) 5555004', 'sales@securenet.com', '2023-05-12', 'Activa', 'Empresarial', TRUE),
('ConsultPro Group', '654987321', 'Consultoría Empresarial', 5, 'Madrid', 'Paseo del Prado 456', '(91) 5555005', 'info@consultpro.es', '2023-06-08', 'Activa', 'Basico', FALSE),
('BackupForce SA', '147258369', 'Backup y Recuperación', 4, 'Ciudad de México', 'Paseo Reforma 505', '(55) 5555006', 'contact@backupforce.com', '2023-07-20', 'Activa', 'Profesional', FALSE),
('CloudPlus Mexico', '258369147', 'Servicios en Nube', 4, 'Guadalajara', 'Av. López Mateos 888', '(33) 5555007', 'support@cloudplus.mx', '2023-08-15', 'Activa', 'Basico', FALSE),
('InnovateAI Labs', '369147258', 'Inteligencia Artificial', 6, 'San Francisco', 'Market St 1111', '(415) 5555008', 'team@innovateai.com', '2023-09-03', 'Activa', 'Empresarial', TRUE),
('GlobalConnect Partners', '741852963', 'Telecomunicaciones', 7, 'Santiago', 'Av. Costanera 999', '(2) 5555009', 'sales@globalconnect.cl', '2023-10-10', 'Activa', 'Profesional', FALSE),
('DataCloud Solutions', '852963741', 'Cloud Computing', 8, 'Lima', 'Av. Arequipa 2222', '(1) 5555010', 'info@datacloudperu.com', '2023-11-18', 'Suspendida', 'Basico', FALSE),
('European Tech Partners', '963741852', 'Outsourcing Tecnológico', 10, 'Berlín', 'Unter den Linden 77', '(30) 5555011', 'contact@eurtechpartners.de', '2023-12-05', 'Inactiva', 'Empresarial', TRUE);

-- ========================================
-- INSERCIÓN EN TABLA USUARIOS
-- ========================================
INSERT INTO usuarios (id_empresa, nombre_usuario, apellido_usuario, email, tipo_usuario, rol, fecha_creacion, activo, email_unico) VALUES
(1, 'Juan', 'García', 'juan.garcia@techcorp.com', 'Administrador', 'Admin_Sistema', '2023-01-20', TRUE, 'juan.garcia@techcorp.com'),
(1, 'María', 'López', 'maria.lopez@techcorp.com', 'Gerente', 'Gerente_Empresa', '2023-01-25', TRUE, 'maria.lopez@techcorp.com'),
(2, 'Carlos', 'Rodríguez', 'carlos.rodriguez@financegl.com', 'Usuario', 'Usuario_Final', '2023-02-25', TRUE, 'carlos.rodriguez@financegl.com'),
(2, 'Ana', 'Martínez', 'ana.martinez@financegl.com', 'Gerente', 'Gerente_Empresa', '2023-02-28', TRUE, 'ana.martinez@financegl.com'),
(3, 'Pedro', 'Sánchez', 'pedro.sanchez@cloudnext.com', 'Administrador', 'Admin_Sistema', '2023-03-15', TRUE, 'pedro.sanchez@cloudnext.com'),
(3, 'Laura', 'González', 'laura.gonzalez@cloudnext.com', 'Usuario', 'Usuario_Final', '2023-03-20', TRUE, 'laura.gonzalez@cloudnext.com'),
(4, 'Roberto', 'Fernández', 'roberto.fernandez@dataanalytics.com', 'Gerente', 'Gerente_Empresa', '2023-04-10', TRUE, 'roberto.fernandez@dataanalytics.com'),
(4, 'Elena', 'Díaz', 'elena.diaz@dataanalytics.com', 'Usuario', 'Usuario_Final', '2023-04-12', TRUE, 'elena.diaz@dataanalytics.com'),
(5, 'Diego', 'Morales', 'diego.morales@securenet.com', 'Administrador', 'Admin_Sistema', '2023-05-15', TRUE, 'diego.morales@securenet.com'),
(5, 'Sandra', 'Pérez', 'sandra.perez@securenet.com', 'Gerente', 'Gerente_Empresa', '2023-05-18', TRUE, 'sandra.perez@securenet.com'),
(6, 'Miguel', 'Ramos', 'miguel.ramos@consultpro.es', 'Usuario', 'Usuario_Final', '2023-06-12', FALSE, 'miguel.ramos@consultpro.es'),
(7, 'Vanessa', 'Cortés', 'vanessa.cortes@backupforce.com', 'Gerente', 'Gerente_Empresa', '2023-07-25', TRUE, 'vanessa.cortes@backupforce.com'),
(8, 'Luis', 'Vargas', 'luis.vargas@cloudplus.mx', 'Usuario', 'Usuario_Final', '2023-08-20', TRUE, 'luis.vargas@cloudplus.mx'),
(9, 'Patricia', 'Silva', 'patricia.silva@innovateai.com', 'Administrador', 'Admin_Sistema', '2023-09-08', TRUE, 'patricia.silva@innovateai.com'),
(10, 'Andrés', 'Castro', 'andres.castro@globalconnect.cl', 'Usuario', 'Usuario_Final', '2023-10-15', TRUE, 'andres.castro@globalconnect.cl');

-- ========================================
-- INSERCIÓN EN TABLA CREDENCIALES
-- ========================================
INSERT INTO credenciales (id_usuario, contraseña_hash, salt, ultima_actualizacion, activa) VALUES
(1, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ab', 'salt123', '2024-01-10', TRUE),
(2, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ac', 'salt124', '2024-01-15', TRUE),
(3, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ad', 'salt125', '2024-01-20', TRUE),
(4, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ae', 'salt126', '2024-01-25', TRUE),
(5, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890af', 'salt127', '2024-02-01', TRUE),
(6, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ag', 'salt128', '2024-02-05', TRUE),
(7, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ah', 'salt129', '2024-02-10', TRUE),
(8, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ai', 'salt130', '2024-02-15', TRUE),
(9, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890aj', 'salt131', '2024-02-20', TRUE),
(10, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ak', 'salt132', '2024-02-25', TRUE),
(11, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890al', 'salt133', '2024-03-01', FALSE),
(12, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890am', 'salt134', '2024-03-05', TRUE),
(13, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890an', 'salt135', '2024-03-10', TRUE),
(14, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ao', 'salt136', '2024-03-15', TRUE),
(15, '$2b$12$abcdef1234567890abcdef1234567890abcdef1234567890ap', 'salt137', '2024-03-20', TRUE);

-- ========================================
-- INSERCIÓN EN TABLA SERVICIOS
-- ========================================
INSERT INTO servicios (nombre_servicio, descripcion, precio_mensual, precio_anual, tipo_servicio, disponible, codigo_servicio, limite_usuarios) VALUES
('Cloud Storage 100GB', 'Almacenamiento en la nube seguro', 9.99, 99.99, 'Cloud', TRUE, 'CS-100', 5),
('Cloud Storage 1TB', 'Almacenamiento en la nube empresarial', 49.99, 499.99, 'Cloud', TRUE, 'CS-1TB', 10),
('Analytics Dashboard', 'Panel de análisis de datos en tiempo real', 199.99, 1999.99, 'Analytics', TRUE, 'ADM-001', 20),
('Advanced Analytics Suite', 'Suite completa de análisis de datos', 499.99, 4999.99, 'Analytics', TRUE, 'AAS-001', 50),
('Endpoint Security', 'Protección de dispositivos finales', 29.99, 299.99, 'Seguridad', TRUE, 'EPS-001', 1),
('Enterprise Security', 'Seguridad empresarial completa', 199.99, 1999.99, 'Seguridad', TRUE, 'ESC-001', 100),
('Daily Backup Service', 'Copias de seguridad diarias automáticas', 19.99, 199.99, 'Backup', TRUE, 'BKP-001', 1),
('Enterprise Backup', 'Backup empresarial con redundancia', 149.99, 1499.99, 'Backup', TRUE, 'BKP-ENT', 1),
('IT Consulting Hours', 'Paquete de 10 horas de consultoría', 500, 5000, 'Consultoria', TRUE, 'CONS-10', 1),
('Full Tech Support', 'Soporte técnico 24/7', 99.99, 999.99, 'Consultoria', TRUE, 'SUP-24x7', 10),
('API Access Service', 'Acceso a API empresariales', 79.99, 799.99, 'Cloud', TRUE, 'API-001', 5),
('Premium Support Plan', 'Plan de soporte prioritario', 299.99, 2999.99, 'Consultoria', TRUE, 'PSP-001', 1);

-- ========================================
-- INSERCIÓN EN TABLA CONTRATACIONES
-- ========================================
INSERT INTO contrataciones (id_empresa, id_servicio, fecha_inicio, fecha_fin, estado, cantidad_licencias, precio_vigente, es_automatica) VALUES
(1, 2, '2023-01-20', '2024-01-20', 'Activa', 1, 499.99, TRUE),
(1, 3, '2023-02-01', '2024-02-01', 'Activa', 3, 199.99, TRUE),
(2, 4, '2023-02-25', '2024-02-25', 'Activa', 2, 499.99, TRUE),
(2, 6, '2023-03-10', '2024-03-10', 'Activa', 1, 199.99, TRUE),
(3, 1, '2023-03-15', '2024-03-15', 'Activa', 2, 9.99, TRUE),
(3, 11, '2023-04-01', '2024-04-01', 'Activa', 1, 79.99, TRUE),
(4, 5, '2023-04-10', '2024-04-10', 'Activa', 10, 29.99, TRUE),
(5, 6, '2023-05-15', '2024-05-15', 'Activa', 1, 199.99, TRUE),
(5, 8, '2023-05-20', '2024-05-20', 'Activa', 1, 149.99, TRUE),
(6, 9, '2023-06-12', '2024-06-12', 'Cancelada', 1, 500, FALSE),
(7, 7, '2023-07-25', '2024-07-25', 'Activa', 1, 19.99, TRUE),
(8, 2, '2023-08-20', '2024-08-20', 'Activa', 2, 499.99, TRUE),
(9, 4, '2023-09-08', '2024-09-08', 'Activa', 1, 499.99, TRUE),
(10, 12, '2023-10-15', '2024-10-15', 'Suspendida', 1, 299.99, TRUE),
(11, 1, '2023-11-20', '2024-11-20', 'Activa', 5, 9.99, TRUE);

-- ========================================
-- INSERCIÓN EN TABLA PAGOS
-- ========================================
INSERT INTO pagos (id_empresa, id_contratacion, fecha_pago, monto, metodo_pago, estado_pago, numero_transaccion, confirmado, fecha_vencimiento) VALUES
(1, 1, '2023-01-20', 499.99, 'Tarjeta', 'Confirmado', 'TXN-2023-001', TRUE, '2024-01-20'),
(1, 2, '2023-02-01', 199.99, 'Transferencia', 'Confirmado', 'TXN-2023-002', TRUE, '2024-02-01'),
(2, 3, '2023-02-25', 999.98, 'Tarjeta', 'Confirmado', 'TXN-2023-003', TRUE, '2024-02-25'),
(2, 4, '2023-03-10', 199.99, 'PayPal', 'Confirmado', 'TXN-2023-004', TRUE, '2024-03-10'),
(3, 5, '2023-03-15', 19.98, 'Tarjeta', 'Confirmado', 'TXN-2023-005', TRUE, '2024-03-15'),
(3, 6, '2023-04-01', 79.99, 'Transferencia', 'Confirmado', 'TXN-2023-006', TRUE, '2024-04-01'),
(4, 7, '2023-04-10', 299.90, 'Tarjeta', 'Confirmado', 'TXN-2023-007', TRUE, '2024-04-10'),
(5, 8, '2023-05-15', 199.99, 'PayPal', 'Confirmado', 'TXN-2023-008', TRUE, '2024-05-15'),
(5, 9, '2023-05-20', 149.99, 'Transferencia', 'Confirmado', 'TXN-2023-009', TRUE, '2024-05-20'),
(6, 10, '2023-06-12', 500, 'Tarjeta', 'Rechazado', 'TXN-2023-010', FALSE, '2024-06-12'),
(7, 11, '2023-07-25', 19.99, 'Tarjeta', 'Confirmado', 'TXN-2023-011', TRUE, '2024-07-25'),
(8, 12, '2023-08-20', 999.98, 'Transferencia', 'Confirmado', 'TXN-2023-012', TRUE, '2024-08-20'),
(9, 13, '2023-09-08', 499.99, 'PayPal', 'Confirmado', 'TXN-2023-013', TRUE, '2024-09-08'),
(10, 14, '2023-10-15', 299.99, 'Tarjeta', 'Pendiente', 'TXN-2023-014', FALSE, '2024-10-15'),
(11, 15, '2023-11-20', 49.95, 'Transferencia', 'Confirmado', 'TXN-2023-015', TRUE, '2024-11-20'),
(1, 1, '2024-01-20', 499.99, 'Tarjeta', 'Confirmado', 'TXN-2024-001', TRUE, '2025-01-20');

-- ========================================
-- INSERCIÓN EN TABLA SESIONES
-- ========================================
INSERT INTO sesiones (id_usuario, id_empresa, fecha_inicio, fecha_cierre, direccion_ip, dispositivo, tipo_sesion, activa) VALUES
(1, 1, '2024-02-20 08:00:00', '2024-02-20 17:30:00', '192.168.1.100', 'Chrome/Windows 10', 'Web', FALSE),
(1, 1, '2024-02-21 08:15:00', NULL, '192.168.1.101', 'Safari/MacOS', 'Web', TRUE),
(2, 1, '2024-02-20 09:00:00', '2024-02-20 18:00:00', '10.0.0.50', 'Firefox/Linux', 'Web', FALSE),
(3, 2, '2024-02-21 08:30:00', NULL, '172.16.0.20', 'Chrome/Windows 11', 'Web', TRUE),
(4, 2, '2024-02-21 10:00:00', '2024-02-21 14:30:00', '192.168.2.105', 'Edge/Windows 10', 'Web', FALSE),
(5, 3, '2024-02-21 07:45:00', NULL, '10.1.0.100', 'Chrome/Ubuntu', 'API', TRUE),
(6, 3, '2024-02-20 16:00:00', '2024-02-20 22:00:00', '203.0.113.50', 'Safari/iOS', 'Mobile', FALSE),
(7, 4, '2024-02-21 09:15:00', '2024-02-21 17:45:00', '192.0.2.75', 'Chrome/Android', 'Mobile', FALSE),
(8, 4, '2024-02-21 08:00:00', NULL, '198.51.100.30', 'Firefox/Windows 10', 'Web', TRUE),
(9, 5, '2024-02-21 07:30:00', NULL, '192.168.3.200', 'Chrome/Windows 11', 'Web', TRUE),
(10, 5, '2024-02-20 14:00:00', '2024-02-20 23:00:00', '172.31.0.100', 'Safari/MacOS', 'Web', FALSE),
(11, 6, '2024-02-21 11:00:00', '2024-02-21 12:30:00', '192.168.4.50', 'Edge/Windows 10', 'Web', FALSE),
(12, 7, '2024-02-21 10:30:00', NULL, '10.2.0.80', 'Firefox/Linux', 'Web', TRUE),
(13, 8, '2024-02-21 09:45:00', NULL, '203.0.113.100', 'Chrome/Windows 10', 'Web', TRUE),
(14, 9, '2024-02-20 22:00:00', '2024-02-20 23:59:00', '198.51.100.60', 'Safari/iOS', 'Mobile', FALSE);

-- ========================================
-- INSERCIÓN EN TABLA AUDITORIA_ACCIONES
-- ========================================
INSERT INTO auditoria_acciones (id_usuario, id_empresa, fecha_accion, tipo_accion, tabla_afectada, descripcion, ip_origen, resultado) VALUES
(1, 1, '2024-02-21 08:15:00', 'LOGIN', 'sesiones', 'Usuario juan.garcia accedió al sistema', '192.168.1.101', 'Exitosa'),
(2, 1, '2024-02-21 09:30:00', 'CREATE', 'contrataciones', 'Creación de nueva contratación de servicio Cloud Storage 1TB', '10.0.0.50', 'Exitosa'),
(3, 2, '2024-02-21 08:45:00', 'LOGIN', 'sesiones', 'Usuario carlos.rodriguez accedió al sistema', '172.16.0.20', 'Exitosa'),
(4, 2, '2024-02-21 11:00:00', 'UPDATE', 'empresas', 'Actualización de datos de contacto de la empresa FinanceGlobal', '192.168.2.105', 'Exitosa'),
(5, 3, '2024-02-21 07:50:00', 'LOGIN', 'sesiones', 'Usuario pedro.sanchez accedió mediante API', '10.1.0.100', 'Exitosa'),
(6, 3, '2024-02-21 15:20:00', 'LOGOUT', 'sesiones', 'Usuario laura.gonzalez cerró sesión', '203.0.113.50', 'Exitosa'),
(7, 4, '2024-02-21 09:25:00', 'CREATE', 'pagos', 'Registro de nuevo pago de contratación Analytics', '192.0.2.75', 'Exitosa'),
(8, 4, '2024-02-21 08:05:00', 'LOGIN', 'sesiones', 'Usuario elena.diaz accedió al sistema', '198.51.100.30', 'Exitosa'),
(9, 5, '2024-02-21 07:35:00', 'LOGIN', 'sesiones', 'Usuario diego.morales accedió al sistema', '192.168.3.200', 'Exitosa'),
(9, 5, '2024-02-21 10:15:00', 'UPDATE', 'usuarios', 'Cambio de rol de usuario en la empresa SecureNet', '192.168.3.200', 'Exitosa'),
(10, 5, '2024-02-20 14:10:00', 'DELETE', 'sesiones', 'Cierre de sesión de usuario sandra.perez por inactividad', '172.31.0.100', 'Exitosa'),
(1, 1, '2024-02-21 12:00:00', 'PAGO', 'pagos', 'Procesamiento de pago de suscripción mensual', '192.168.1.100', 'Exitosa'),
(2, 1, '2024-02-21 13:30:00', 'UPDATE', 'contrataciones', 'Renovación automática de contratación de servicio', '10.0.0.50', 'Exitosa'),
(3, 2, '2024-02-21 14:45:00', 'CREATE', 'usuarios', 'Creación de nuevo usuario en sistema', '172.16.0.20', 'Exitosa'),
(1, 1, '2024-02-21 15:00:00', 'LOGIN', 'sesiones', 'Intento de login fallido - credenciales inválidas', '192.168.1.102', 'Fallida');

-- Agregar 10 registros adicionales en varias tablas para ampliar la base
INSERT INTO empresas (nombre_empresa, nit, sector, id_pais, ciudad, direccion, telefono, email_empresa, fecha_registro, estado, plan_suscripcion, es_cliente_premium) VALUES
('SolarTech SA', '112233445', 'Energía Solar', 1, 'Bogotá', 'Cra 10 No 20-30', '(1) 5555012', 'contact@solartech.com', '2024-01-05', 'Activa', 'Profesional', FALSE),
('HealthCorp', '556677889', 'Salud', 3, 'São Paulo', 'Rua da Saúde 500', '(11) 5555013', 'info@healthcorp.com', '2024-01-10', 'Activa', 'Basico', FALSE),
('EduGlobal', '998877665', 'Educación', 5, 'Madrid', 'Calle de la Educación 123', '(91) 5555014', 'hello@eduglobal.es', '2024-01-12', 'Activa', 'Profesional', TRUE),
('SmartCity', '223344556', 'Urbanismo', 4, 'Ciudad de México', 'Av. Central 800', '(55) 5555015', 'info@smartcity.mx', '2024-01-15', 'Activa', 'Empresarial', TRUE),
('FintechPro', '334455667', 'Finanzas', 6, 'Nueva York', 'Wall Street 200', '(212) 5555016', 'support@fintechpro.com', '2024-01-18', 'Activa', 'Profesional', TRUE),
('AutoDrive', '445566778', 'Automotriz', 10, 'Berlín', 'Unter den Linden 10', '(30) 5555017', 'contact@autodrive.de', '2024-01-20', 'Activa', 'Basico', FALSE),
('AgroFarm', '223355776', 'Agricultura', 1, 'Medellín', 'Cra 30 No 40-50', '(4) 5555018', 'ventas@agrofarm.com', '2024-01-22', 'Activa', 'Empresarial', FALSE),
('TechStart', '556644332', 'Startups', 6, 'San Francisco', 'Market St 222', '(415) 5555019', 'info@techstart.com', '2024-01-25', 'Activa', 'Basico', FALSE),
('MediaWorks', '667755443', 'Medios', 5, 'Barcelona', 'Paseo de la Media 1', '(93) 5555020', 'contact@mediaworks.es', '2024-01-28', 'Activa', 'Profesional', TRUE),
('BioLabs', '778866554', 'Biotecnología', 3, 'Rio de Janeiro', 'Av. Rio 300', '(21) 5555021', 'info@biolabs.com', '2024-01-30', 'Activa', 'Empresarial', FALSE);

