-- ============================================================
-- HEALTH-CONNECT: BASE DE DATOS HOSPITALARIA
-- Triaje Asistido por IA + Expediente Clínico Digital
-- ============================================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS health_connect;
USE health_connect;

-- ============================================================
-- 1. TABLA: USUARIOS Y ROLES
-- ============================================================

CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(255),
    permisos JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    estado ENUM('activo', 'inactivo', 'suspendido') DEFAULT 'activo',
    telefono VARCHAR(20),
    ultimo_acceso DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    INDEX idx_email (email),
    INDEX idx_role (role_id)
) ENGINE=InnoDB;

-- ============================================================
-- 2. TABLA: PACIENTES
-- ============================================================

CREATE TABLE pacientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo ENUM('M', 'F', 'Otro') NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    ciudad VARCHAR(50),
    tipo_sangre VARCHAR(5),
    alergias TEXT,
    medicamentos_actuales TEXT,
    antecedentes_medicos TEXT,
    contacto_emergencia_nombre VARCHAR(100),
    contacto_emergencia_telefono VARCHAR(20),
    estado ENUM('activo', 'inactivo') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE INDEX idx_cedula (cedula),
    INDEX idx_nombre (nombre),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 3. TABLA: SIGNOS VITALES
-- ============================================================

CREATE TABLE signos_vitales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    sistolica INT NOT NULL,
    diastolica INT NOT NULL,
    frecuencia_cardiaca INT NOT NULL,
    frecuencia_respiratoria INT NOT NULL,
    saturacion_oxigeno DECIMAL(5, 2) NOT NULL,
    temperatura DECIMAL(5, 2) NOT NULL,
    peso DECIMAL(6, 2),
    altura DECIMAL(5, 2),
    imc DECIMAL(5, 2),
    registrado_por_id INT NOT NULL,
    observaciones TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (registrado_por_id) REFERENCES usuarios(id),
    INDEX idx_paciente (paciente_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 4. TABLA: CAPTURA CLÍNICA INICIAL
-- ============================================================

CREATE TABLE captura_clinica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    motivo_consulta TEXT NOT NULL,
    sintomas_principales TEXT NOT NULL,
    duracion_sintomas VARCHAR(50),
    severidad_sintomas ENUM('leve', 'moderada', 'severa') NOT NULL,
    medicamentos_tomados TEXT,
    alergias_reportadas TEXT,
    antecedentes_relevantes TEXT,
    registrado_por_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (registrado_por_id) REFERENCES usuarios(id),
    INDEX idx_paciente (paciente_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 5. TABLA: SUGERENCIAS DE TRIAJE (IA)
-- ============================================================

CREATE TABLE sugerencias_triaje_ia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    captura_clinica_id INT NOT NULL,
    prioridad ENUM('rojo', 'naranja', 'amarillo', 'verde', 'azul') NOT NULL,
    puntuacion DECIMAL(5, 2),
    criterios_evaluados JSON,
    recomendaciones TEXT,
    modelo_ia VARCHAR(100),
    confianza_porcentaje DECIMAL(5, 2),
    estado ENUM('pendiente', 'aceptada', 'rechazada', 'modificada') DEFAULT 'pendiente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (captura_clinica_id) REFERENCES captura_clinica(id) ON DELETE CASCADE,
    INDEX idx_estado (estado),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 6. TABLA: TRIAJE (VALIDACIÓN DEL PERSONAL)
-- ============================================================

CREATE TABLE triajes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    sugerencia_ia_id INT,
    captura_clinica_id INT NOT NULL,
    prioridad_final ENUM('rojo', 'naranja', 'amarillo', 'verde', 'azul') NOT NULL,
    justificacion_medica TEXT NOT NULL,
    validado_por_id INT NOT NULL,
    motivo_cambio TEXT,
    estado ENUM('activo', 'cancelado') DEFAULT 'activo',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (sugerencia_ia_id) REFERENCES sugerencias_triaje_ia(id),
    FOREIGN KEY (captura_clinica_id) REFERENCES captura_clinica(id) ON DELETE CASCADE,
    FOREIGN KEY (validado_por_id) REFERENCES usuarios(id),
    INDEX idx_paciente (paciente_id),
    INDEX idx_prioridad (prioridad_final),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 7. TABLA: COLA DE URGENCIAS
-- ============================================================

CREATE TABLE cola_urgencias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    triaje_id INT NOT NULL,
    prioridad ENUM('rojo', 'naranja', 'amarillo', 'verde', 'azul') NOT NULL,
    numero_posicion INT,
    hora_ingreso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hora_inicio_atencion DATETIME,
    hora_fin_atencion DATETIME,
    estado ENUM('esperando', 'en_atencion', 'completado', 'cancelado') DEFAULT 'esperando',
    medico_asignado_id INT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (triaje_id) REFERENCES triajes(id),
    FOREIGN KEY (medico_asignado_id) REFERENCES usuarios(id),
    INDEX idx_estado (estado),
    INDEX idx_prioridad (prioridad),
    INDEX idx_hora_ingreso (hora_ingreso)
) ENGINE=InnoDB;

-- ============================================================
-- 8. TABLA: EXPEDIENTE CLÍNICO
-- ============================================================

CREATE TABLE expedientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    paciente_id INT NOT NULL,
    numero_expediente VARCHAR(50) UNIQUE,
    tipo_expediente ENUM('inicial', 'seguimiento', 'completado') DEFAULT 'inicial',
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE,
    medico_responsable_id INT,
    estado ENUM('abierto', 'cerrado', 'suspendido') DEFAULT 'abierto',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    FOREIGN KEY (medico_responsable_id) REFERENCES usuarios(id),
    UNIQUE INDEX idx_expediente (numero_expediente),
    INDEX idx_paciente (paciente_id),
    INDEX idx_estado (estado)
) ENGINE=InnoDB;

-- ============================================================
-- 9. TABLA: NOTAS CLÍNICAS
-- ============================================================

CREATE TABLE notas_clinicas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expediente_id INT NOT NULL,
    triaje_id INT,
    tipo_nota ENUM('inicial', 'evolución', 'procedimiento', 'derivación', 'alta') DEFAULT 'evolución',
    contenido TEXT NOT NULL,
    medico_id INT NOT NULL,
    enfermero_id INT,
    dato_relevante JSON,
    estado ENUM('draft', 'firmada') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (expediente_id) REFERENCES expedientes(id) ON DELETE CASCADE,
    FOREIGN KEY (triaje_id) REFERENCES triajes(id),
    FOREIGN KEY (medico_id) REFERENCES usuarios(id),
    FOREIGN KEY (enfermero_id) REFERENCES usuarios(id),
    INDEX idx_expediente (expediente_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 10. TABLA: PROCEDIMIENTOS Y INTERVENCIONES
-- ============================================================

CREATE TABLE procedimientos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expediente_id INT NOT NULL,
    nombre_procedimiento VARCHAR(200) NOT NULL,
    descripcion TEXT,
    realizado_por_id INT NOT NULL,
    resultado TEXT,
    complicaciones TEXT,
    medicamentos_utilizados TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (expediente_id) REFERENCES expedientes(id) ON DELETE CASCADE,
    FOREIGN KEY (realizado_por_id) REFERENCES usuarios(id),
    INDEX idx_expediente (expediente_id)
) ENGINE=InnoDB;

-- ============================================================
-- 11. TABLA: PRESCRIPCIONES
-- ============================================================

CREATE TABLE prescripciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expediente_id INT NOT NULL,
    medicamento VARCHAR(150) NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    frecuencia VARCHAR(100) NOT NULL,
    duracion VARCHAR(100),
    indicaciones TEXT,
    contraindicaciones TEXT,
    prescrito_por_id INT NOT NULL,
    estado ENUM('activa', 'completada', 'cancelada') DEFAULT 'activa',
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (expediente_id) REFERENCES expedientes(id) ON DELETE CASCADE,
    FOREIGN KEY (prescrito_por_id) REFERENCES usuarios(id),
    INDEX idx_expediente (expediente_id),
    INDEX idx_estado (estado)
) ENGINE=InnoDB;

-- ============================================================
-- 12. TABLA: DERIVACIONES
-- ============================================================

CREATE TABLE derivaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    expediente_id INT NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    motivo_derivacion TEXT NOT NULL,
    urgencia ENUM('electiva', 'urgente', 'emergencia') DEFAULT 'electiva',
    derivado_por_id INT NOT NULL,
    especialista_id INT,
    estado ENUM('pendiente', 'aceptada', 'realizada', 'cancelada') DEFAULT 'pendiente',
    fecha_solicitada DATE NOT NULL,
    fecha_realizacion DATE,
    resultado_derivacion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (expediente_id) REFERENCES expedientes(id) ON DELETE CASCADE,
    FOREIGN KEY (derivado_por_id) REFERENCES usuarios(id),
    FOREIGN KEY (especialista_id) REFERENCES usuarios(id),
    INDEX idx_expediente (expediente_id),
    INDEX idx_estado (estado)
) ENGINE=InnoDB;

-- ============================================================
-- 13. TABLA: AUDITORÍA Y LOGS
-- ============================================================

CREATE TABLE auditoria (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    accion VARCHAR(100) NOT NULL,
    tabla_afectada VARCHAR(100),
    registro_id INT,
    datos_anteriores JSON,
    datos_nuevos JSON,
    detalles TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    INDEX idx_tabla (tabla_afectada),
    INDEX idx_created (created_at)
) ENGINE=InnoDB;

-- ============================================================
-- 14. TABLA: REPORTES Y ESTADÍSTICAS
-- ============================================================

CREATE TABLE reportes_estadisticas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_reporte VARCHAR(100) NOT NULL,
    fecha_reporte DATE NOT NULL,
    pacientes_total INT,
    triajes_rojo INT DEFAULT 0,
    triajes_naranja INT DEFAULT 0,
    triajes_amarillo INT DEFAULT 0,
    triajes_verde INT DEFAULT 0,
    triajes_azul INT DEFAULT 0,
    tiempo_promedio_espera INT,
    tiempo_promedio_atencion INT,
    pacientes_atendidos INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_fecha (fecha_reporte)
) ENGINE=InnoDB;

-- ============================================================
-- INSERTS DE DATOS INICIALES
-- ============================================================

-- Roles
INSERT INTO roles (nombre, descripcion, permisos) VALUES
('Administrador', 'Acceso total a todas las funciones del sistema', '{"dashboard": true, "usuarios": true, "triaje": true, "expedientes": true, "reportes": true}'),
('Médico', 'Triaje, atención de pacientes y expedientes clínicos', '{"dashboard": true, "triaje": true, "expedientes": true, "reportes": false}'),
('Enfermero', 'Captura de signos vitales y triaje', '{"triaje": true, "expedientes_lectura": true, "reportes": false}'),
('Recepcionista', 'Registro de pacientes y búsqueda', '{"pacientes": true, "cola": true, "expedientes_lectura": true}'),
('Triajista', 'Captura clínica y triaje asistido', '{"triaje": true, "pacientes": true, "expedientes_lectura": true}');

-- Usuarios de prueba
INSERT INTO usuarios (nombre, email, contraseña_hash, role_id, estado, telefono) VALUES
('Dr. Juan Díaz', 'juan.diaz@hospital.com', SHA2('password123', 256), 2, 'activo', '3001234567'),
('Dra. María Santos', 'maria.santos@hospital.com', SHA2('password123', 256), 2, 'activo', '3001234568'),
('Enf. Pablo Morales', 'pablo.morales@hospital.com', SHA2('password123', 256), 3, 'activo', '3001234569'),
('Recep. Carmen Ruiz', 'carmen.ruiz@hospital.com', SHA2('password123', 256), 4, 'activo', '3001234570'),
('Admin Fernando López', 'fernando.lopez@hospital.com', SHA2('password123', 256), 1, 'activo', '3001234571'),
('Triajista Ana García', 'ana.garcia@hospital.com', SHA2('password123', 256), 5, 'activo', '3001234572');

-- Pacientes de prueba
INSERT INTO pacientes (cedula, nombre, apellido, fecha_nacimiento, sexo, telefono, email, ciudad, tipo_sangre, alergias, medicamentos_actuales) VALUES
('1234567890', 'María', 'García López', '1981-06-15', 'F', '3009876543', 'maria.garcia@email.com', 'Bogotá', 'O+', 'Penicilina', 'Metformina 500mg'),
('1234567891', 'Carlos', 'Ruiz Martín', '1964-03-22', 'M', '3009876544', 'carlos.ruiz@email.com', 'Bogotá', 'A+', 'Ninguna', 'Atorvastatina 20mg'),
('1234567892', 'Ana', 'Martín Pérez', '1988-09-10', 'F', '3009876545', 'ana.martin@email.com', 'Medellín', 'B+', 'Sulfonamidas', 'Levotiroxina 75mcg'),
('1234567893', 'Roberto', 'Sánchez Gómez', '1955-11-05', 'M', '3009876546', 'roberto.sanchez@email.com', 'Cali', 'O+', 'AINE', 'Bisoprolol 5mg, Amlodipino 5mg'),
('1234567894', 'Laura', 'Fernández López', '1998-02-28', 'F', '3009876547', 'laura.fernandez@email.com', 'Bogotá', 'AB-', 'Ninguna', 'Anticonceptivos orales');

-- ============================================================
-- VISTAS ÚTILES PARA CONSULTAS
-- ============================================================

CREATE VIEW v_pacientes_en_cola AS
SELECT 
    cu.id,
    p.cedula,
    p.nombre,
    p.apellido,
    cu.prioridad,
    cu.numero_posicion,
    cu.estado,
    TIMESTAMPDIFF(MINUTE, cu.hora_ingreso, NOW()) as minutos_espera,
    u.nombre as medico_nombre
FROM cola_urgencias cu
JOIN pacientes p ON cu.paciente_id = p.id
LEFT JOIN usuarios u ON cu.medico_asignado_id = u.id
WHERE cu.estado IN ('esperando', 'en_atencion')
ORDER BY cu.prioridad, cu.numero_posicion;

CREATE VIEW v_triajes_hoy AS
SELECT 
    DATE(t.created_at) as fecha,
    t.prioridad_final,
    COUNT(*) as cantidad,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM triajes WHERE DATE(created_at) = CURDATE())) * 100, 2) as porcentaje
FROM triajes t
WHERE DATE(t.created_at) = CURDATE()
GROUP BY DATE(t.created_at), t.prioridad_final
ORDER BY 
    CASE t.prioridad_final
        WHEN 'rojo' THEN 1
        WHEN 'naranja' THEN 2
        WHEN 'amarillo' THEN 3
        WHEN 'verde' THEN 4
        WHEN 'azul' THEN 5
    END;

CREATE VIEW v_expedientes_activos AS
SELECT 
    e.id,
    e.numero_expediente,
    p.cedula,
    p.nombre,
    p.apellido,
    e.fecha_apertura,
    u.nombre as medico_responsable,
    e.estado,
    COUNT(DISTINCT nc.id) as numero_notas,
    COUNT(DISTINCT pr.id) as numero_procedimientos
FROM expedientes e
JOIN pacientes p ON e.paciente_id = p.id
LEFT JOIN usuarios u ON e.medico_responsable_id = u.id
LEFT JOIN notas_clinicas nc ON e.id = nc.expediente_id
LEFT JOIN procedimientos pr ON e.id = pr.expediente_id
WHERE e.estado = 'abierto'
GROUP BY e.id
ORDER BY e.fecha_apertura DESC;

-- ============================================================
-- ÍNDICES ADICIONALES PARA OPTIMIZACIÓN
-- ============================================================

CREATE INDEX idx_cola_urgencias_prioridad_estado ON cola_urgencias(prioridad, estado);
CREATE INDEX idx_triajes_prioridad_fecha ON triajes(prioridad_final, created_at);
CREATE INDEX idx_expedientes_paciente_estado ON expedientes(paciente_id, estado);
CREATE INDEX idx_notas_clinicas_expediente_fecha ON notas_clinicas(expediente_id, created_at);

-- ============================================================
-- PROCEDIMIENTO ALMACENADO: CREAR TRIAJE
-- ============================================================

DELIMITER //

CREATE PROCEDURE sp_crear_triaje(
    IN p_paciente_id INT,
    IN p_captura_clinica_id INT,
    IN p_sugerencia_ia_id INT,
    IN p_prioridad ENUM('rojo', 'naranja', 'amarillo', 'verde', 'azul'),
    IN p_justificacion TEXT,
    IN p_validado_por_id INT,
    IN p_motivo_cambio TEXT,
    OUT p_triaje_id INT
)
BEGIN
    DECLARE v_last_insert_id INT;
    
    -- Insertar triaje
    INSERT INTO triajes (
        paciente_id,
        sugerencia_ia_id,
        captura_clinica_id,
        prioridad_final,
        justificacion_medica,
        validado_por_id,
        motivo_cambio
    ) VALUES (
        p_paciente_id,
        p_sugerencia_ia_id,
        p_captura_clinica_id,
        p_prioridad,
        p_justificacion,
        p_validado_por_id,
        p_motivo_cambio
    );
    
    SET v_last_insert_id = LAST_INSERT_ID();
    
    -- Actualizar estado de sugerencia IA
    IF p_sugerencia_ia_id IS NOT NULL THEN
        UPDATE sugerencias_triaje_ia 
        SET estado = IF(p_prioridad = (SELECT prioridad FROM sugerencias_triaje_ia WHERE id = p_sugerencia_ia_id LIMIT 1), 'aceptada', 'modificada')
        WHERE id = p_sugerencia_ia_id;
    END IF;
    
    -- Insertar en cola urgencias
    INSERT INTO cola_urgencias (
        paciente_id,
        triaje_id,
        prioridad
    ) VALUES (
        p_paciente_id,
        v_last_insert_id,
        p_prioridad
    );
    
    SET p_triaje_id = v_last_insert_id;
END //

DELIMITER ;

-- ============================================================
-- PROCEDIMIENTO ALMACENADO: GENERAR NÚMERO DE EXPEDIENTE
-- ============================================================

DELIMITER //

CREATE FUNCTION fn_generar_numero_expediente(p_paciente_id INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_numero VARCHAR(50);
    DECLARE v_contador INT;
    
    SELECT COUNT(*) + 1 INTO v_contador
    FROM expedientes
    WHERE paciente_id = p_paciente_id;
    
    SET v_numero = CONCAT('EXP-', DATE_FORMAT(NOW(), '%Y%m%d'), '-', p_paciente_id, '-', LPAD(v_contador, 3, '0'));
    
    RETURN v_numero;
END //

DELIMITER ;
