-- ========================================
-- CASO 2: SISTEMA DE PUNTO DE VENTAS
-- DDL - Creación de Estructura de Tablas (Mejora de 3FN)
-- ========================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS punto_ventas;
USE punto_ventas;

-- ========================================
-- 1. TABLA PAISES (Para normalización 3FN)
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
-- 2. TABLA OFICINAS
-- ========================================
CREATE TABLE oficinas (
    id_oficina INT AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    departamento VARCHAR(50),
    id_pais INT,
    codigoPostal VARCHAR(15),
    continente VARCHAR(10),
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    tipo_oficina ENUM('Regional','Central','Sucursal') NOT NULL,
    activa BOOLEAN DEFAULT TRUE,
    codigo_unico VARCHAR(20) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tipo_oficina (tipo_oficina),
    INDEX idx_ciudad (ciudad)
);

-- ========================================
-- 3. TABLA EMPLEADOS
-- ========================================
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    extension VARCHAR(10),
    email VARCHAR(100),
    id_oficina INT NOT NULL,
    jefe INT,
    cargo VARCHAR(50),
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    tipo_empleado ENUM('Administrativo','Ventas','Gerente') NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    correo_unico VARCHAR(100) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_oficina) REFERENCES oficinas(id_oficina) ON DELETE RESTRICT,
    FOREIGN KEY (jefe) REFERENCES empleados(id_empleado) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_id_oficina (id_oficina),
    INDEX idx_tipo_empleado (tipo_empleado),
    UNIQUE INDEX idx_email (email)
);

-- ========================================
-- 4. TABLA CLIENTES
-- ========================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(50),
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(50),
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    departamento VARCHAR(50),
    codigoPostal VARCHAR(15),
    id_pais INT,
    empleadoAtiende INT NOT NULL,
    limiteCredito DOUBLE,
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    tipo_cliente ENUM('Regular','Premium','VIP') NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    email_unico VARCHAR(100) UNIQUE,
    
    FOREIGN KEY (id_pais) REFERENCES paises(id_pais),
    FOREIGN KEY (empleadoAtiende) REFERENCES empleados(id_empleado) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_empleado_atiende (empleadoAtiende),
    INDEX idx_tipo_cliente (tipo_cliente)
);

-- ========================================
-- 5. TABLA CATEGORIAS_PRODUCTOS (Para 3FN)
-- ========================================
CREATE TABLE categorias_productos (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- 6. TABLA PRODUCTOS
-- ========================================
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombreProducto VARCHAR(70) NOT NULL,
    id_lineaProducto INT,
    escala VARCHAR(10),
    cantidad INT NOT NULL DEFAULT 0,
    precioVenta DOUBLE NOT NULL,
    MSRP DOUBLE,
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    id_categoria INT NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    codigo_producto VARCHAR(50) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_categoria) REFERENCES categorias_productos(id_categoria),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_id_categoria (id_categoria),
    INDEX idx_disponible (disponible)
);

-- ========================================
-- 7. TABLA ORDENES
-- ========================================
CREATE TABLE ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    fechaRecibido DATE NOT NULL,
    fechaLimiteEntrega DATE NOT NULL,
    fechaEntrega DATE,
    estado VARCHAR(15) NOT NULL,
    observacion TEXT,
    id_cliente INT NOT NULL,
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    tipo_orden ENUM('Online','Presencial') NOT NULL,
    completada BOOLEAN DEFAULT FALSE,
    codigo_orden VARCHAR(50) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_id_cliente (id_cliente),
    INDEX idx_estado (estado),
    INDEX idx_tipo_orden (tipo_orden)
);

-- ========================================
-- 8. TABLA DETALLE_ORDENES
-- ========================================
CREATE TABLE detalle_ordenes (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidadPedida INT NOT NULL,
    valorUnitario DOUBLE NOT NULL,
    ordenEntrega INT,
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    tipo_detalle ENUM('Normal','Promocion') NOT NULL,
    entregado BOOLEAN DEFAULT FALSE,
    codigo_detalle VARCHAR(50) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_id_orden (id_orden),
    INDEX idx_id_producto (id_producto)
);

-- ========================================
-- 9. TABLA PAGOS
-- ========================================
CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_orden INT,
    numeroFactura VARCHAR(50),
    fechaPago DATE NOT NULL,
    totalPago DOUBLE NOT NULL,
    
    -- Campos adicionales (tipo catálogo, booleano, unique)
    metodo_pago ENUM('Tarjeta','Transferencia','Efectivo') NOT NULL,
    confirmado BOOLEAN DEFAULT TRUE,
    codigo_pago VARCHAR(50) UNIQUE NOT NULL,
    
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE RESTRICT,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_id_cliente (id_cliente),
    INDEX idx_metodo_pago (metodo_pago)
);

-- ========================================
-- DESCRIPCIÓN DE TABLAS
-- ========================================
DESCRIBE paises;
DESCRIBE oficinas;
DESCRIBE empleados;
DESCRIBE clientes;
DESCRIBE categorias_productos;
DESCRIBE productos;
DESCRIBE ordenes;
DESCRIBE detalle_ordenes;
DESCRIBE pagos;

-- ========================================
-- INFORMACIÓN DETALLADA DE COLUMNAS
-- ========================================
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'punto_ventas'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
