DROP DATABASE IF EXISTS fidelizacion_xyz;
CREATE DATABASE fidelizacion_xyz;
USE fidelizacion_xyz;

CREATE TABLE perfiles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_perfil VARCHAR(50) NOT NULL,
    fecha_vigencia DATE,
    descripcion VARCHAR(200),
    encargado_id INT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    estado ENUM('Activo','Inactivo') DEFAULT 'Activo',
    contrasena VARCHAR(255) NOT NULL,
    cargo VARCHAR(60),
    salario DECIMAL(10,2),
    fecha_ingreso DATE,
    perfil_id INT NOT NULL,
    FOREIGN KEY (perfil_id) REFERENCES perfiles(id)
);

CREATE TABLE login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha_hora_login DATETIME NOT NULL,
    estado_login ENUM('Exitoso','Fallido') NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE actividades_fidelizacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    fecha_actividad DATE NOT NULL,
    tipo_actividad VARCHAR(100),
    descripcion_actividad VARCHAR(200),
    puntos_otorgados INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
INSERT INTO perfiles (nombre_perfil, fecha_vigencia, descripcion) VALUES
('Básico', '2025-12-31', 'Perfil inicial'),
('Plata', '2025-12-31', 'Perfil intermedio'),
('Oro',   '2025-12-31', 'Perfil avanzado');

INSERT INTO usuarios (nombre, apellido, contrasena, cargo, salario, fecha_ingreso, perfil_id) VALUES
('Juan','Pérez','1234','Analista',900.00,'2024-01-10',1),
('Ana','Gómez','abcd','Supervisora',1200.00,'2023-11-05',2);

INSERT INTO login (usuario_id, fecha_hora_login, estado_login) VALUES
(1,'2025-01-01 08:00:00','Exitoso'),
(1,'2025-01-02 08:00:00','Fallido'),
(2,'2025-01-01 09:10:00','Exitoso');

INSERT INTO actividades_fidelizacion (usuario_id, fecha_actividad, tipo_actividad, descripcion_actividad, puntos_otorgados) VALUES
(1,'2025-01-05','Voluntariado','Actividad de apoyo social',40),
(2,'2025-01-10','Capacitación','Curso interno',30);