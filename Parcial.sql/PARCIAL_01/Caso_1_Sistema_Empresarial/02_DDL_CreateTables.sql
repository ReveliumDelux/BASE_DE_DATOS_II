-- ========================================
-- CASO 1: SISTEMA EMPRESARIAL DE SERVICIOS DIGITALES
-- DDL - Creación de Estructura de Tablas
-- ========================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sistema_empresarial_servicios;
USE sistema_empresarial_servicios;

-- ========================================
-- 1. TABLA PAISES
-- ========================================
CREATE TABLE paises (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pais VARCHAR(50) NOT NULL UNIQUE,
    region VARCHAR(50),
    continente VARCHAR(50),
    codigo_iso VARCHAR(2) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 2. TABLA EMPRESAS
-- ========================================
CREATE TABLE empresas (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empresa VARCHAR(100) NOT NULL,
    nit VARCHAR(20) NOT NULL UNIQUE,
    sector VARCHAR(50),
    id_pais INT NOT NULL,
    ciudad VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    email_empresa VARCHAR(100) UNIQUE,
    fecha_registro DATE NOT NULL,
    -- Campos adicionales según requisitos
    estado ENUM('Activa', 'Inactiva', 'Suspendida') NOT NULL DEFAULT 'Activa',
    plan_suscripcion ENUM('Basico', 'Profesional', 'Empresarial') NOT NULL DEFAULT 'Basico',
    es_cliente_premium BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- 3. TABLA USUARIOS
-- ========================================
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT,
    nombre_usuario VARCHAR(50) NOT NULL,
    apellido_usuario VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    -- Campos adicionales según requisitos
    tipo_usuario ENUM('Administrador', 'Gerente', 'Usuario') NOT NULL DEFAULT 'Usuario',
    rol ENUM('Admin_Sistema', 'Gerente_Empresa', 'Usuario_Final') NOT NULL DEFAULT 'Usuario_Final',
    fecha_creacion DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    email_unico VARCHAR(100) UNIQUE,
    
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 4. TABLA CREDENCIALES (Autenticación)
-- ========================================
CREATE TABLE credenciales (
    id_credencial INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL UNIQUE,
    contraseña_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    ultima_actualizacion DATE,
    activa BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ========================================
-- 5. TABLA SERVICIOS
-- ========================================
CREATE TABLE servicios (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    nombre_servicio VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    precio_mensual DOUBLE NOT NULL,
    precio_anual DOUBLE,
    -- Campo tipo ENUM (catálogo)
    tipo_servicio ENUM('Cloud', 'Analytics', 'Seguridad', 'Backup', 'Consultoria') NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    codigo_servicio VARCHAR(50) UNIQUE NOT NULL,
    limite_usuarios INT DEFAULT 1,
    fecha_creacion DATE,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 6. TABLA CONTRATACIONES (Entidad Asociativa N:M)
-- ========================================
CREATE TABLE contrataciones (
    id_contratacion INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    id_servicio INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    -- Campo tipo ENUM (catálogo)
    estado ENUM('Activa', 'Cancelada', 'Suspendida') NOT NULL DEFAULT 'Activa',
    cantidad_licencias INT NOT NULL DEFAULT 1,
    precio_vigente DOUBLE NOT NULL,
    es_automatica BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE CASCADE,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio) ON DELETE RESTRICT,
    UNIQUE(id_empresa, id_servicio),  -- Una empresa no puede contratar el mismo servicio dos veces
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 7. TABLA PAGOS
-- ========================================
CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_empresa INT NOT NULL,
    id_contratacion INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DOUBLE NOT NULL,
    -- Campo tipo ENUM (catálogo)
    metodo_pago ENUM('Tarjeta', 'Transferencia', 'PayPal') NOT NULL,
    estado_pago ENUM('Pendiente', 'Confirmado', 'Rechazado') NOT NULL DEFAULT 'Pendiente',
    numero_transaccion VARCHAR(100) UNIQUE,
    confirmado BOOLEAN DEFAULT FALSE,
    fecha_vencimiento DATE,
    
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE CASCADE,
    FOREIGN KEY (id_contratacion) REFERENCES contrataciones(id_contratacion) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 8. TABLA SESIONES (Auditoría de Accesos)
-- ========================================
CREATE TABLE sesiones (
    id_sesion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_empresa INT,
    fecha_inicio DATETIME NOT NULL,
    fecha_cierre DATETIME,
    direccion_ip VARCHAR(45),
    dispositivo VARCHAR(255),
    -- Campo tipo ENUM (catálogo)
    tipo_sesion ENUM('Web', 'Mobile', 'API') NOT NULL DEFAULT 'Web',
    activa BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 9. TABLA AUDITORIA_ACCIONES (Bitácora)
-- ========================================
CREATE TABLE auditoria_acciones (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_empresa INT,
    fecha_accion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    -- Campo tipo ENUM (catálogo)
    tipo_accion ENUM('LOGIN', 'LOGOUT', 'CREATE', 'UPDATE', 'DELETE', 'PAGO') NOT NULL,
    tabla_afectada VARCHAR(50),
    descripcion TEXT,
    ip_origen VARCHAR(45),
    resultado ENUM('Exitosa', 'Fallida') NOT NULL DEFAULT 'Exitosa',
    
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE SET NULL,
    FOREIGN KEY (id_empresa) REFERENCES empresas(id_empresa) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_id_usuario (id_usuario),
    INDEX idx_fecha_accion (fecha_accion),
    INDEX idx_tipo_accion (tipo_accion)
);

-- ========================================
-- DESCRIPCIÓN DE TABLAS
-- ========================================
DESCRIBE paises;
DESCRIBE empresas;
DESCRIBE usuarios;
DESCRIBE credenciales;
DESCRIBE servicios;
DESCRIBE contrataciones;
DESCRIBE pagos;
DESCRIBE sesiones;
DESCRIBE auditoria_acciones;

-- ========================================
-- INFORMACIÓN DE TABLAS
-- ========================================
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'sistema_empresarial_servicios'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
