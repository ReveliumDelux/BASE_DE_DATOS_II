DROP DATABASE IF EXISTS sistema_expedientes;
CREATE DATABASE sistema_expedientes;
USE sistema_expedientes;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(100) NOT NULL
);

CREATE TABLE aseguradoras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE juzgados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE expedientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(100) NOT NULL,
    aseguradora_id INT NOT NULL,
    juzgado_id INT NOT NULL,
    estado VARCHAR(50) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (aseguradora_id) REFERENCES aseguradoras(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (juzgado_id) REFERENCES juzgados(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO usuarios (nombre, usuario, clave) VALUES
('Administrador', 'admin', '1234'),
('Maria Lopez', 'mlopez', 'pass1'),
('Carlos Perez', 'cperez', 'pass2'),
('Ana Torres', 'atorres', 'pass3'),
('Luis Gomez', 'lgomez', 'pass4');

INSERT INTO aseguradoras (nombre) VALUES
('Seguros Nacionales'),
('Aseguradora Central'),
('Proteccion Global'),
('Seguros del Istmo'),
('VidaSegura');

INSERT INTO juzgados (nombre, ubicacion) VALUES
('Juzgado Primero Civil', 'Panama'),
('Juzgado Segundo Civil', 'San Miguelito'),
('Juzgado Tercero Civil', 'Colon'),
('Juzgado Cuarto Civil', 'Chiriqui'),
('Juzgado Quinto Civil', 'Panama Oeste');

INSERT INTO expedientes (cliente, aseguradora_id, juzgado_id, estado, fecha) VALUES
('Juan Perez', 1, 1, 'Abierto', '2026-01-10'),
('Maria Gonzalez', 2, 2, 'En Proceso', '2026-01-15'),
('Carlos Sanchez', 3, 3, 'Cerrado', '2026-01-20'),
('Ana Martinez', 4, 4, 'Abierto', '2026-02-01'),
('Luis Herrera', 5, 5, 'En Proceso', '2026-02-05');