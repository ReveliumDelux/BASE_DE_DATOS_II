-- Base de datos 2
-- Profesor: Maryon Torres
-- Parcial (Pixel-Security-360)
-- Autores: Kurtley Kelly, Jose Antonio Alvariño, Eric Murillo

-- Crear base de datos
CREATE DATABASE pixel_sec_360;
SHOW databases;
USE pixel_sec_360;

-- Crear tabla de tipos de usuario
CREATE TABLE tipos_de_usuario (
    id INT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL
);



-- Insertar tipos de usuario fijos
INSERT INTO tipos_de_usuario (id, nombre_tipo) VALUES
(1, 'Cliente'),
(2, 'Administrador'),
(3, 'Vendedor'),
(4, 'Ejecutivo'),
(5, 'Otros');

-- Crear tabla de usuarios
CREATE TABLE usuarios (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    nombre_de_usuario VARCHAR(16),
    pass VARCHAR(255),
    token VARCHAR(100),
    ciudad VARCHAR(255),
    sexo VARCHAR(16),
    estado_civil VARCHAR(16),
    tipo_de_empresa ENUM('Pública','Privada'),
    direccion VARCHAR(255),
	id_tipo_usuario INT,
    FOREIGN KEY (id_tipo_usuario) REFERENCES tipos_de_usuario(id)
);

-- Crear tabla de autenticación
CREATE TABLE autenticacion (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_usuario INT NOT NULL,
    nombre_de_usuario VARCHAR(16),
    pass VARCHAR(255),
    token VARCHAR(100),
	agente VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Crear tabla de tipos de prueba
CREATE TABLE tipos_de_prueba (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    referencia VARCHAR(50),
    nombre VARCHAR(100),
    descripcion TEXT,
    fecha_ingreso DATETIME,
    estado ENUM('Activo','Desactivado')
);

-- Crear tabla de métodos de pago
CREATE TABLE metodo_pago (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_usuario INT,
    numero_de_tarjeta VARCHAR(20),
    nombre_de_tarjeta VARCHAR(100),
    cvc CHAR(3),
    exp DATE,
    numero_referencia VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);



 -- CREAR USUARIOS
 
 INSERT INTO usuarios VALUES
(Null, 'Luis', 'Pérez', 'lperez', 'clave123', 'tk001abc', 'Ciudad de Panamá', 'Masculino', 'Soltero', 'Privada', 'Av. Central #123', 1),
(Null,'María', 'Gómez', 'mgomez', 'clave124', 'tk002bcd', 'Colón', 'Femenino', 'Casada', 'Pública', 'Calle 5 Este #22', 2),
(Null,'Carlos', 'Ruiz', 'cruiz', 'clave125', 'tk003cde', 'David', 'Masculino', 'Soltero', 'Privada', 'Residencial Los Olivos', 3),
(Null,'Ana', 'Torres', 'atorres', 'clave126', 'tk004def', 'Santiago', 'Femenino', 'Soltera', 'Pública', 'Barrio El Carmen', 4),
(Null,'Lucía', 'Moreno', 'lmoreno', 'clave127', 'tk005efg', 'Chitré', 'Femenino', 'Viuda', 'Privada', 'Urbanización El Prado', 5),
(Null,'Pedro', 'López', 'plopez', 'clave128', 'tk006fgh', 'Panamá Oeste', 'Masculino', 'Casado', 'Pública', 'Altos del Oeste #45', 1),
(Null,'Elena', 'Santos', 'esantos', 'clave129', 'tk007ghi', 'Veraguas', 'Femenino', 'Divorciada', 'Privada', 'Los Pinos Calle 8', 2),
(Null,'Miguel', 'Fernández', 'mfernandez', 'clave130', 'tk008hij', 'Boquete', 'Masculino', 'Soltero', 'Privada', 'Via Boquete Centro', 3),
(Null,'Daniela', 'Cordero', 'dcord', 'clave131', 'tk009ijk', 'Panamá', 'Femenino', 'Casada', 'Pública', 'Calle 50 Torre 1', 4),
(Null,'Jorge', 'Mendoza', 'jmend', 'clave132', 'tk010jkl', 'Penonomé', 'Masculino', 'Soltero', 'Privada', 'Altos del Prado #11', 5),
(Null,'Andrea', 'Vargas', 'avargas', 'clave133', 'tk011klm', 'Aguadulce', 'Femenino', 'Soltera', 'Pública', 'Calle Real #9', 1),
(Null,'Ricardo', 'Reyes', 'rreyes', 'clave134', 'tk012lmn', 'Chiriquí', 'Masculino', 'Casado', 'Privada', 'El Valle Verde #23', 2),
(Null,'Patricia', 'Jiménez', 'pjimenez', 'clave135', 'tk013mno', 'Santiago', 'Femenino', 'Divorciada', 'Privada', 'San Antonio Calle 12', 3),
(Null,'Héctor', 'Salazar', 'hsalazar', 'clave136', 'tk014nop', 'Colón', 'Masculino', 'Viudo', 'Pública', 'Costa Abajo Sector 3', 4),
(Null,'Laura', 'Ramos', 'lramos', 'clave137', 'tk015opq', 'David', 'Femenino', 'Casada', 'Privada', 'Av. Central Oeste', 5),
(Null,'Diego', 'Martínez', 'dmartinez', 'clave138', 'tk016pqr', 'Panamá', 'Masculino', 'Soltero', 'Pública', 'Calle Uruguay', 1),
(Null,'Sofía', 'Herrera', 'sherrera', 'clave139', 'tk017qrs', 'Boquete', 'Femenino', 'Casada', 'Privada', 'Av. Los Fundadores', 2),
(Null,'Gabriel', 'Cruz', 'gcruz', 'clave140', 'tk018rst', 'Veraguas', 'Masculino', 'Soltero', 'Pública', 'Colinas del Norte #44', 3),
(Null,'Valentina', 'Mora', 'vmora', 'clave141', 'tk019stu', 'Colón', 'Femenino', 'Soltera', 'Privada', 'Residencial Mar Azul', 4),
(Null,'Raúl', 'Castillo', 'rcastillo', 'clave142', 'tk020tuv', 'Chitré', 'Masculino', 'Casado', 'Pública', 'Zona Industrial 2', 5),
(Null,'Tatiana', 'Vega', 'tvega', 'clave143', 'tk021uvw', 'Santiago', 'Femenino', 'Soltera', 'Privada', 'Altos de San Pedro', 1),
(Null,'Felipe', 'Ríos', 'frios', 'clave144', 'tk022vwx', 'David', 'Masculino', 'Divorciado', 'Privada', 'Barrio Los Andes', 2),
(Null,'Isabella', 'Campos', 'icampos', 'clave145', 'tk023wxy', 'Panamá', 'Femenino', 'Casada', 'Pública', 'Via España Ed. Sol', 3),
(Null,'Juan', 'Ortega', 'jortega', 'clave146', 'tk024xyz', 'Penonomé', 'Masculino', 'Soltero', 'Privada', 'Residencial Los Tulipanes', 4),
(Null,'Camila', 'Muñoz', 'cmunoz', 'clave147', 'tk025yza', 'Colón', 'Femenino', 'Soltera', 'Pública', 'Calle 12 Final', 5),
(Null,'Nicolás', 'Paredes', 'nparedes', 'clave148', 'tk026zab', 'Santiago', 'Masculino', 'Casado', 'Privada', 'Villa Florencia', 1),
(Null,'Rosa', 'Delgado', 'rdelgado', 'clave149', 'tk027abc', 'Panamá', 'Femenino', 'Viuda', 'Privada', 'Urbanización Condado', 2),
(Null,'Oscar', 'Navarro', 'onavarro', 'clave150', 'tk028bcd', 'Boquete', 'Masculino', 'Casado', 'Pública', 'Los Lagos #55', 3),
(Null,'Mónica', 'Suárez', 'msuarez', 'clave151', 'tk029cde', 'David', 'Femenino', 'Soltera', 'Privada', 'Altos del Oeste', 4),
(Null,'Ernesto', 'Pérez', 'eperez', 'clave152', 'tk030def', 'Chiriquí', 'Masculino', 'Casado', 'Pública', 'Avenida Libertad #77', 5),
(Null,'Alejandro', 'Gil', 'agil', 'clave153', 'tk031efg', 'Panamá', 'Masculino', 'Soltero', 'Privada', 'Calle 65 Oeste', 1),
(Null,'Carmen', 'Luna', 'cluna', 'clave154', 'tk032fgh', 'Veraguas', 'Femenino', 'Casada', 'Pública', 'Av. Los Robles', 2),
(Null,'Rodrigo', 'Santos', 'rsantos', 'clave155', 'tk033ghi', 'Santiago', 'Masculino', 'Divorciado', 'Privada', 'Residencial Santa Elena', 3),
(Null,'Diana', 'Carrillo', 'dcarrillo', 'clave156', 'tk034hij', 'Panamá', 'Femenino', 'Soltera', 'Pública', 'Calle 50 Torre Sur', 4),
(Null,'Fernando', 'Morales', 'fmorales', 'clave157', 'tk035ijk', 'David', 'Masculino', 'Casado', 'Privada', 'Calle San Martín #12', 5),
(Null,'Rafael', 'Jiménez', 'rjimenez', 'clave158', 'tk036jkl', 'Colón', 'Masculino', 'Soltero', 'Pública', 'Av. Central #88', 1),
(Null,'Paula', 'Rico', 'prico', 'clave159', 'tk037klm', 'Boquete', 'Femenino', 'Casada', 'Privada', 'Calle Flores #17', 2),
(Null,'Iván', 'Nieto', 'inieto', 'clave160', 'tk038lmn', 'Santiago', 'Masculino', 'Divorciado', 'Privada', 'Altos del Carmen', 3),
(Null,'Beatriz', 'Solis', 'bsolis', 'clave161', 'tk039mno', 'David', 'Femenino', 'Casada', 'Pública', 'Villa Esperanza', 4),
(Null,'Hugo', 'Arroyo', 'harroyo', 'clave162', 'tk040nop', 'Panamá', 'Masculino', 'Soltero', 'Privada', 'Calle 72 Este #4', 5),
(Null,'Jimena', 'Valdés', 'jvaldes', 'clave163', 'tk041opq', 'Colón', 'Femenino', 'Casada', 'Pública', 'Zona Libre Torre 2', 1),
(Null,'Samuel', 'Martín', 'smartin', 'clave164', 'tk042pqr', 'Penonomé', 'Masculino', 'Viudo', 'Privada', 'Residencial Vista Bella', 2),
(Null,'Victoria', 'Salas', 'vsalas', 'clave165', 'tk043qrs', 'Santiago', 'Femenino', 'Casada', 'Pública', 'Calle La Estrella', 3),
(Null,'David', 'Cornejo', 'dcornejo', 'clave166', 'tk044rst', 'Boquete', 'Masculino', 'Soltero', 'Privada', 'Av. Central Norte', 4),
(Null,'Natalia', 'Chávez', 'nchavez', 'clave167', 'tk045stu', 'Panamá', 'Femenino', 'Soltera', 'Pública', 'Calle 50 Este #9', 5),
(Null,'Manuel', 'Espino', 'mespino', 'clave168', 'tk046tuv', 'Colón', 'Masculino', 'Divorciado', 'Privada', 'Barrio Nuevo', 1),
(Null,'Adriana', 'Reina', 'areina', 'clave169', 'tk047uvw', 'David', 'Femenino', 'Casada', 'Privada', 'Residencial Los Jardines', 2),
(Null,'José', 'Córdoba', 'jcordoba', 'clave170', 'tk048vwx', 'Panamá', 'Masculino', 'Casado', 'Pública', 'Vía España #333', 3),
(Null,'Verónica', 'Silva', 'vsilva', 'clave171', 'tk049wxy', 'Boquete', 'Femenino', 'Soltera', 'Privada', 'Av. Principal', 4),
(Null,'Francisco', 'León', 'fleon', 'clave172', 'tk050xyz', 'Santiago', 'Masculino', 'Casado', 'Pública', 'Los Almendros #5', 5),
(Null,'Carolina', 'Quintero', 'cquintero', 'clave173', 'tk051yza', 'Panamá', 'Femenino', 'Soltera', 'Privada', 'Calle 10 Oeste', 1),
(Null,'Esteban', 'Miranda', 'emiranda', 'clave174', 'tk052zab', 'Veraguas', 'Masculino', 'Casado', 'Privada', 'El Bosque Sur', 2),
(Null,'Luz', 'Fuentes', 'lfuentes', 'clave175', 'tk053abc', 'Colón', 'Femenino', 'Casada', 'Pública', 'Costa Norte 8', 3),
(Null,'Martín', 'Peña', 'mpena', 'clave176', 'tk054bcd', 'Boquete', 'Masculino', 'Soltero', 'Privada', 'Calle Norte 6', 4),
(Null,'Elisa', 'Torrealba', 'etorrealba', 'clave177', 'tk055cde', 'David', 'Femenino', 'Casada', 'Pública', 'Residencial Central', 5),
(Null,'Gustavo', 'Méndez', 'gmendez', 'clave178', 'tk056def', 'Panamá', 'Masculino', 'Casado', 'Privada', 'Via España #888', 1),
(Null,'Rebeca', 'Acosta', 'racosta', 'clave179', 'tk057efg', 'Chiriquí', 'Femenino', 'Divorciada', 'Pública', 'Av. Pacífico', 2),
(Null,'Julián', 'Bravo', 'jbravo', 'clave180', 'tk058fgh', 'Santiago', 'Masculino', 'Soltero', 'Privada', 'Calle Los Ángeles', 3),
(Null,'Eva', 'González', 'egonzalez', 'clave181', 'tk059ghi', 'Colón', 'Femenino', 'Casada', 'Pública', 'Urbanización Central', 4),
(Null,'Álvaro', 'Nieves', 'anieves', 'clave182', 'tk060hij', 'Panamá', 'Masculino', 'Soltero', 'Privada', 'Calle 75 Este #17', 5);

-- Despliegue de tabla de usuarios
SELECT * FROM pixel_sec_360.usuarios;


 -- CREAR AUTENTICACIONES
 
INSERT INTO autenticacion VALUES
(Null, 1, 'lperez', 'clave123', 'tk001abc', 'Laptop Windows', '2025-01-12 08:30:00'),
(Null, 2, 'mgomez', 'clave124', 'tk002bcd', 'Smartphone Android', '2025-01-13 09:15:00'),
(Null, 3, 'cruiz', 'clave125', 'tk003cde', 'Laptop Mac', '2025-01-14 10:20:00'),
(Null, 4, 'atorres', 'clave126', 'tk004def', 'Tablet iOS', '2025-01-15 11:05:00'),
(Null, 5, 'lmoreno', 'clave127', 'tk005efg', 'Laptop Windows', '2025-01-16 14:10:00'),
(Null, 6, 'plopez', 'clave128', 'tk006fgh', 'Smartphone Android', '2025-01-17 16:30:00'),
(Null, 7, 'esantos', 'clave129', 'tk007ghi', 'Laptop Mac', '2025-01-18 08:50:00'),
(Null, 8, 'mfernandez', 'clave130', 'tk008hij', 'Tablet iOS', '2025-01-19 13:15:00'),
(Null, 9, 'dcord', 'clave131', 'tk009ijk', 'Laptop Windows', '2025-01-20 09:40:00'),
(Null, 10, 'jmend', 'clave132', 'tk010jkl', 'Smartphone Android', '2025-01-21 15:20:00'),
(Null, 11, 'avargas', 'clave133', 'tk011klm', 'Laptop Mac', '2025-01-22 08:10:00'),
(Null, 12, 'rreyes', 'clave134', 'tk012lmn', 'Tablet iOS', '2025-01-23 10:45:00'),
(Null, 13, 'pjimenez', 'clave135', 'tk013mno', 'Laptop Windows', '2025-01-24 12:00:00'),
(Null, 14, 'hsalazar', 'clave136', 'tk014nop', 'Smartphone Android', '2025-01-25 14:30:00'),
(Null, 15, 'lramos', 'clave137', 'tk015opq', 'Laptop Mac', '2025-01-26 09:50:00'),
(Null, 16, 'dmartinez', 'clave138', 'tk016pqr', 'Tablet iOS', '2025-01-27 11:15:00'),
(Null, 17, 'sherrera', 'clave139', 'tk017qrs', 'Laptop Windows', '2025-01-28 10:05:00'),
(Null, 18, 'gcruz', 'clave140', 'tk018rst', 'Smartphone Android', '2025-01-29 13:40:00'),
(Null, 19, 'vmora', 'clave141', 'tk019stu', 'Laptop Mac', '2025-01-30 15:00:00'),
(Null, 20, 'rcastillo', 'clave142', 'tk020tuv', 'Tablet iOS', '2025-01-31 09:25:00'),
(Null, 21, 'tvega', 'clave143', 'tk021uvw', 'Laptop Windows', '2025-02-01 11:50:00'),
(Null, 22, 'frios', 'clave144', 'tk022vwx', 'Smartphone Android', '2025-02-02 14:10:00'),
(Null, 23, 'icampos', 'clave145', 'tk023wxy', 'Laptop Mac', '2025-02-03 10:20:00'),
(Null, 24, 'jortega', 'clave146', 'tk024xyz', 'Tablet iOS', '2025-02-04 16:15:00'),
(Null, 25, 'cmunoz', 'clave147', 'tk025yza', 'Laptop Windows', '2025-02-05 08:30:00'),
(Null, 26, 'nparedes', 'clave148', 'tk026zab', 'Smartphone Android', '2025-02-06 09:45:00'),
(Null, 27, 'rdelgado', 'clave149', 'tk027abc', 'Laptop Mac', '2025-02-07 12:20:00'),
(Null, 28, 'onavarro', 'clave150', 'tk028bcd', 'Tablet iOS', '2025-02-08 14:05:00'),
(Null, 29, 'msuarez', 'clave151', 'tk029cde', 'Laptop Windows', '2025-02-09 08:40:00'),
(Null, 30, 'eperez', 'clave152', 'tk030def', 'Smartphone Android', '2025-02-10 10:30:00'),
(Null, 31, 'agil', 'clave153', 'tk031efg', 'Laptop Mac', '2025-02-11 11:55:00'),
(Null, 32, 'cluna', 'clave154', 'tk032fgh', 'Tablet iOS', '2025-02-12 13:15:00'),
(Null, 33, 'rsantos', 'clave155', 'tk033ghi', 'Laptop Windows', '2025-02-13 09:05:00'),
(Null, 34, 'dcarrillo', 'clave156', 'tk034hij', 'Smartphone Android', '2025-02-14 15:40:00'),
(Null, 35, 'fmorales', 'clave157', 'tk035ijk', 'Laptop Mac', '2025-02-15 08:20:00'),
(Null, 36, 'rjimenez', 'clave158', 'tk036jkl', 'Tablet iOS', '2025-02-16 12:35:00'),
(Null, 37, 'prico', 'clave159', 'tk037klm', 'Laptop Windows', '2025-02-17 14:50:00'),
(Null, 38, 'inieto', 'clave160', 'tk038lmn', 'Smartphone Android', '2025-02-18 09:10:00'),
(Null, 39, 'bsolis', 'clave161', 'tk039mno', 'Laptop Mac', '2025-02-19 11:25:00'),
(Null, 40, 'harroyo', 'clave162', 'tk040nop', 'Tablet iOS', '2025-02-20 13:45:00'),
(Null, 41, 'jvaldes', 'clave163', 'tk041opq', 'Laptop Windows', '2025-02-21 08:35:00'),
(Null, 42, 'smartin', 'clave164', 'tk042pqr', 'Smartphone Android', '2025-02-22 10:50:00'),
(Null, 43, 'vsalas', 'clave165', 'tk043qrs', 'Laptop Mac', '2025-02-23 12:15:00'),
(Null, 44, 'dcornejo', 'clave166', 'tk044rst', 'Tablet iOS', '2025-02-24 14:05:00'),
(Null, 45, 'nchavez', 'clave167', 'tk045stu', 'Laptop Windows', '2025-02-25 08:40:00'),
(Null, 46, 'mespino', 'clave168', 'tk046tuv', 'Smartphone Android', '2025-02-26 09:55:00'),
(Null, 47, 'areina', 'clave169', 'tk047uvw', 'Laptop Mac', '2025-02-27 11:30:00'),
(Null, 48, 'jcordoba', 'clave170', 'tk048vwx', 'Tablet iOS', '2025-02-28 13:50:00'),
(Null, 49, 'vsilva', 'clave171', 'tk049wxy', 'Laptop Windows', '2025-03-01 10:05:00'),
(Null, 50, 'fleon', 'clave172', 'tk050xyz', 'Smartphone Android', '2025-03-02 12:20:00'),
(Null, 51, 'cquintero', 'clave173', 'tk051yza', 'Laptop Mac', '2025-03-03 08:30:00'),
(Null, 52, 'emiranda', 'clave174', 'tk052zab', 'Tablet iOS', '2025-03-04 09:45:00'),
(Null, 53, 'lfuentes', 'clave175', 'tk053abc', 'Laptop Windows', '2025-03-05 11:15:00'),
(Null, 54, 'mpena', 'clave176', 'tk054bcd', 'Smartphone Android', '2025-03-06 14:05:00'),
(Null, 55, 'etorrealba', 'clave177', 'tk055cde', 'Laptop Mac', '2025-03-07 09:25:00'),
(Null, 56, 'gmendez', 'clave178', 'tk056def', 'Tablet iOS', '2025-03-08 10:40:00'),
(Null, 57, 'racosta', 'clave179', 'tk057efg', 'Laptop Windows', '2025-03-09 13:10:00'),
(Null, 58, 'jbravo', 'clave180', 'tk058fgh', 'Smartphone Android', '2025-03-10 15:20:00'),
(Null, 59, 'egonzalez', 'clave181', 'tk059ghi', 'Laptop Mac', '2025-03-11 11:50:00'),
(Null, 60, 'anieves', 'clave182', 'tk060hij', 'Tablet iOS', '2025-03-12 12:35:00');

-- Despliegue de tabla de autenticacion
SELECT * FROM pixel_sec_360.autenticacion;

 -- CREAR TIPOS DE PRUEBA
 
INSERT INTO tipos_de_prueba VALUES
(NULL, 'SQL001', 'Prueba de Inyección SQL', 'Verifica vulnerabilidades de inyección SQL', '2025-01-01 09:00:00', 'Activo'),
(NULL, 'XSS002', 'Prueba de Cross-Site Scripting', 'Evalúa vulnerabilidades XSS', '2025-01-02 10:00:00', 'Activo'),
(NULL, 'FB003', 'Prueba de Fuerza Bruta', 'Simula ataques de fuerza bruta a contraseñas', '2025-01-03 11:00:00', 'Activo'),
(NULL, 'PORT004', 'Prueba de Escaneo de Puertos', 'Detecta puertos abiertos en la red', '2025-01-04 12:00:00', 'Activo'),
(NULL, 'LDAP005', 'Prueba de Inyección LDAP', 'Evalúa vulnerabilidades LDAP', '2025-01-05 13:00:00', 'Activo'),
(NULL, 'XML006', 'Prueba de Inyección XML', 'Evalúa vulnerabilidades XML', '2025-01-06 14:00:00', 'Activo'),
(NULL, 'VULN007', 'Prueba de Escaneo de Vulnerabilidades', 'Identifica fallos en la seguridad del sistema', '2025-01-07 15:00:00', 'Activo'),
(NULL, 'AUTH008', 'Prueba de Autenticación Débil', 'Verifica credenciales débiles', '2025-01-08 16:00:00', 'Activo'),
(NULL, 'CFG009', 'Prueba de Configuración Incorrecta', 'Detecta configuraciones inseguras', '2025-01-09 09:30:00', 'Activo'),
(NULL, 'OS010', 'Prueba de Inyección OS', 'Evalúa vulnerabilidades de ejecución de comandos', '2025-01-10 10:30:00', 'Activo'),
(NULL, 'SQL011', 'Prueba de SQL Ciego', 'Evalúa inyecciones SQL sin retroalimentación', '2025-01-11 11:00:00', 'Activo'),
(NULL, 'XSS012', 'Prueba de DOM XSS', 'Detecta vulnerabilidades XSS en DOM', '2025-01-12 12:00:00', 'Activo'),
(NULL, 'FB013', 'Prueba de Diccionario', 'Ataque de fuerza bruta con diccionarios', '2025-01-13 13:00:00', 'Activo'),
(NULL, 'PORT014', 'Prueba de Escaneo TCP', 'Verifica puertos TCP abiertos', '2025-01-14 14:00:00', 'Activo'),
(NULL, 'LDAP015', 'Prueba de LDAP Injection Avanzada', 'Evalúa LDAP avanzado', '2025-01-15 15:00:00', 'Activo'),
(NULL, 'XML016', 'Prueba de XXE', 'Evalúa vulnerabilidades de XML External Entity', '2025-01-16 16:00:00', 'Activo'),
(NULL, 'VULN017', 'Prueba de CVE Comunes', 'Verifica vulnerabilidades conocidas', '2025-01-17 09:00:00', 'Activo'),
(NULL, 'AUTH018', 'Prueba de Tokens Inseguros', 'Detecta tokens inseguros en el sistema', '2025-01-18 10:00:00', 'Activo'),
(NULL, 'CFG019', 'Prueba de Archivos de Configuración', 'Detecta archivos sensibles expuestos', '2025-01-19 11:00:00', 'Activo'),
(NULL, 'OS020', 'Prueba de Comandos Remotos', 'Evalúa ejecución remota de comandos', '2025-01-20 12:00:00', 'Activo'),
(NULL, 'SQL021', 'Prueba de UNION SQL', 'Detecta vulnerabilidades UNION SQL', '2025-01-21 13:00:00', 'Activo'),
(NULL, 'XSS022', 'Prueba de Reflected XSS', 'Evalúa vulnerabilidades XSS reflejadas', '2025-01-22 14:00:00', 'Activo'),
(NULL, 'FB023', 'Prueba de Credenciales Predeterminadas', 'Prueba acceso con credenciales por defecto', '2025-01-23 15:00:00', 'Activo'),
(NULL, 'PORT024', 'Prueba de Escaneo UDP', 'Detecta puertos UDP abiertos', '2025-01-24 16:00:00', 'Activo'),
(NULL, 'LDAP025', 'Prueba de LDAP Básica', 'Evalúa LDAP simple', '2025-01-25 09:00:00', 'Activo'),
(NULL, 'XML026', 'Prueba de XML Injection', 'Evalúa inyecciones XML simples', '2025-01-26 10:00:00', 'Activo'),
(NULL, 'VULN027', 'Prueba de Seguridad Web', 'Evalúa vulnerabilidades web comunes', '2025-01-27 11:00:00', 'Activo'),
(NULL, 'AUTH028', 'Prueba de Sesión Débil', 'Evalúa manejo de sesiones inseguras', '2025-01-28 12:00:00', 'Activo'),
(NULL, 'CFG029', 'Prueba de Permisos Incorrectos', 'Detecta permisos inseguros en archivos', '2025-01-29 13:00:00', 'Activo'),
(NULL, 'OS030', 'Prueba de OS Command Injection', 'Evalúa inyecciones de comandos', '2025-01-30 14:00:00', 'Activo'),
(NULL, 'SQL031', 'Prueba de SQL Lógico', 'Evalúa lógica de consultas SQL', '2025-01-31 15:00:00', 'Activo'),
(NULL, 'XSS032', 'Prueba de Stored XSS', 'Evalúa vulnerabilidades XSS almacenadas', '2025-02-01 09:00:00', 'Activo'),
(NULL, 'FB033', 'Prueba de Contraseñas Débiles', 'Detecta contraseñas inseguras', '2025-02-02 10:00:00', 'Activo'),
(NULL, 'PORT034', 'Prueba de Puertos Filtrados', 'Detecta puertos filtrados', '2025-02-03 11:00:00', 'Activo'),
(NULL, 'LDAP035', 'Prueba de LDAP Avanzada', 'Evalúa ataques LDAP complejos', '2025-02-04 12:00:00', 'Activo'),
(NULL, 'XML036', 'Prueba de XML Avanzada', 'Evalúa vulnerabilidades XML avanzadas', '2025-02-05 13:00:00', 'Activo'),
(NULL, 'VULN037', 'Prueba de Seguridad del Servidor', 'Detecta vulnerabilidades del servidor', '2025-02-06 14:00:00', 'Activo'),
(NULL, 'AUTH038', 'Prueba de MFA', 'Evalúa autenticación multifactor', '2025-02-07 15:00:00', 'Activo'),
(NULL, 'CFG039', 'Prueba de Backup Inseguro', 'Detecta backups inseguros', '2025-02-08 16:00:00', 'Activo'),
(NULL, 'OS040', 'Prueba de Comandos Remotos Avanzados', 'Evalúa comandos avanzados remotos', '2025-02-09 09:00:00', 'Activo'),
(NULL, 'SQL041', 'Prueba de SQL Compleja', 'Evalúa consultas SQL complejas', '2025-02-10 10:00:00', 'Activo'),
(NULL, 'XSS042', 'Prueba de XSS Persistente', 'Detecta XSS persistente', '2025-02-11 11:00:00', 'Activo'),
(NULL, 'FB043', 'Prueba de Ataques Coordinados', 'Simula ataques coordinados', '2025-02-12 12:00:00', 'Activo'),
(NULL, 'PORT044', 'Prueba de Escaneo de Red', 'Evalúa vulnerabilidades en la red', '2025-02-13 13:00:00', 'Activo'),
(NULL, 'LDAP045', 'Prueba LDAP de Seguridad', 'Evalúa seguridad LDAP', '2025-02-14 14:00:00', 'Activo'),
(NULL, 'XML046', 'Prueba de XML Crítico', 'Evalúa vulnerabilidades críticas de XML', '2025-02-15 15:00:00', 'Activo'),
(NULL, 'VULN047', 'Prueba de Seguridad Interna', 'Evalúa vulnerabilidades internas', '2025-02-16 16:00:00', 'Activo'),
(NULL, 'AUTH048', 'Prueba de Tokens Expirados', 'Evalúa manejo de tokens expirados', '2025-02-17 09:00:00', 'Activo'),
(NULL, 'CFG049', 'Prueba de Configuración Segura', 'Verifica configuraciones seguras', '2025-02-18 10:00:00', 'Activo'),
(NULL, 'OS050', 'Prueba de OS Avanzada', 'Evalúa inyecciones de OS avanzadas', '2025-02-19 11:00:00', 'Activo'),
(NULL, 'SQL051', 'Prueba de SQL Dinámica', 'Evalúa consultas SQL dinámicas', '2025-02-20 12:00:00', 'Activo'),
(NULL, 'XSS052', 'Prueba de XSS Reflejado', 'Evalúa XSS reflejado dinámico', '2025-02-21 13:00:00', 'Activo'),
(NULL, 'FB053', 'Prueba de Rutas de Contraseña', 'Evalúa rutas inseguras de contraseñas', '2025-02-22 14:00:00', 'Activo'),
(NULL, 'PORT054', 'Prueba de Puertos Seguros', 'Verifica puertos seguros', '2025-02-23 15:00:00', 'Activo'),
(NULL, 'LDAP055', 'Prueba de LDAP Dinámico', 'Evalúa LDAP dinámico', '2025-02-24 16:00:00', 'Activo'),
(NULL, 'XML056', 'Prueba de XML Persistente', 'Detecta vulnerabilidades persistentes XML', '2025-02-25 09:00:00', 'Activo'),
(NULL, 'VULN057', 'Prueba de Seguridad Móvil', 'Evalúa vulnerabilidades en apps móviles', '2025-02-26 10:00:00', 'Activo'),
(NULL, 'AUTH058', 'Prueba de Autenticación Insegura', 'Evalúa autenticación insegura', '2025-02-27 11:00:00', 'Activo'),
(NULL, 'CFG059', 'Prueba de Logs Expuestos', 'Detecta logs expuestos', '2025-02-28 12:00:00', 'Activo'),
(NULL, 'OS060', 'Prueba de OS Persistente', 'Evalúa OS persistente', '2025-03-01 13:00:00', 'Activo');

-- Despliegue de tabla de tipos de prueba
SELECT * FROM pixel_sec_360.tipos_de_prueba;


 -- CREAR MÉTODOS DE PAGO
 
INSERT INTO metodo_pago VALUES
(NULL, 1, 4111111111111111, 'Visa', 123, '2026-01-31', 'REF001'),
(NULL, 2, 5500000000000004, 'MasterCard', 456, '2026-02-28', 'REF002'),
(NULL, 3, 340000000000009, 'American Express', 789, '2025-12-31', 'REF003'),
(NULL, 4, 6011000000000004, 'Discover', 321, '2026-03-31', 'REF004'),
(NULL, 5, 3530111333300000, 'JCB', 654, '2026-04-30', 'REF005'),
(NULL, 6, 4111111111111112, 'Visa', 987, '2026-05-31', 'REF006'),
(NULL, 7, 5500000000000005, 'MasterCard', 147, '2026-06-30', 'REF007'),
(NULL, 8, 340000000000010, 'American Express', 258, '2026-07-31', 'REF008'),
(NULL, 9, 6011000000000005, 'Discover', 369, '2026-08-31', 'REF009'),
(NULL, 10, 3530111333300001, 'JCB', 159, '2026-09-30', 'REF010'),
(NULL, 11, 4111111111111113, 'Visa', 753, '2026-10-31', 'REF011'),
(NULL, 12, 5500000000000006, 'MasterCard', 852, '2026-11-30', 'REF012'),
(NULL, 13, 340000000000011, 'American Express', 951, '2026-12-31', 'REF013'),
(NULL, 14, 6011000000000006, 'Discover', 357, '2027-01-31', 'REF014'),
(NULL, 15, 3530111333300002, 'JCB', 456, '2027-02-28', 'REF015'),
(NULL, 16, 4111111111111114, 'Visa', 654, '2027-03-31', 'REF016'),
(NULL, 17, 5500000000000007, 'MasterCard', 852, '2027-04-30', 'REF017'),
(NULL, 18, 340000000000012, 'American Express', 963, '2027-05-31', 'REF018'),
(NULL, 19, 6011000000000007, 'Discover', 147, '2027-06-30', 'REF019'),
(NULL, 20, 3530111333300003, 'JCB', 258, '2027-07-31', 'REF020'),
(NULL, 21, 4111111111111115, 'Visa', 369, '2027-08-31', 'REF021'),
(NULL, 22, 5500000000000008, 'MasterCard', 741, '2027-09-30', 'REF022'),
(NULL, 23, 340000000000013, 'American Express', 852, '2027-10-31', 'REF023'),
(NULL, 24, 6011000000000008, 'Discover', 963, '2027-11-30', 'REF024'),
(NULL, 25, 3530111333300004, 'JCB', 159, '2027-12-31', 'REF025'),
(NULL, 26, 4111111111111116, 'Visa', 357, '2028-01-31', 'REF026'),
(NULL, 27, 5500000000000009, 'MasterCard', 456, '2028-02-29', 'REF027'),
(NULL, 28, 340000000000014, 'American Express', 654, '2028-03-31', 'REF028'),
(NULL, 29, 6011000000000009, 'Discover', 852, '2028-04-30', 'REF029'),
(NULL, 30, 3530111333300005, 'JCB', 963, '2028-05-31', 'REF030'),
(NULL, 31, 4111111111111117, 'Visa', 147, '2028-06-30', 'REF031'),
(NULL, 32, 5500000000000010, 'MasterCard', 258, '2028-07-31', 'REF032'),
(NULL, 33, 340000000000015, 'American Express', 369, '2028-08-31', 'REF033'),
(NULL, 34, 6011000000000010, 'Discover', 741, '2028-09-30', 'REF034'),
(NULL, 35, 3530111333300006, 'JCB', 852, '2028-10-31', 'REF035'),
(NULL, 36, 4111111111111118, 'Visa', 963, '2028-11-30', 'REF036'),
(NULL, 37, 5500000000000011, 'MasterCard', 159, '2028-12-31', 'REF037'),
(NULL, 38, 340000000000016, 'American Express', 357, '2029-01-31', 'REF038'),
(NULL, 39, 6011000000000011, 'Discover', 456, '2029-02-28', 'REF039'),
(NULL, 40, 3530111333300007, 'JCB', 654, '2029-03-31', 'REF040'),
(NULL, 41, 4111111111111119, 'Visa', 852, '2029-04-30', 'REF041'),
(NULL, 42, 5500000000000012, 'MasterCard', 963, '2029-05-31', 'REF042'),
(NULL, 43, 340000000000017, 'American Express', 147, '2029-06-30', 'REF043'),
(NULL, 44, 6011000000000012, 'Discover', 258, '2029-07-31', 'REF044'),
(NULL, 45, 3530111333300008, 'JCB', 369, '2029-08-31', 'REF045'),
(NULL, 46, 4111111111111120, 'Visa', 741, '2029-09-30', 'REF046'),
(NULL, 47, 5500000000000013, 'MasterCard', 852, '2029-10-31', 'REF047'),
(NULL, 48, 340000000000018, 'American Express', 963, '2029-11-30', 'REF048'),
(NULL, 49, 6011000000000013, 'Discover', 159, '2029-12-31', 'REF049'),
(NULL, 50, 3530111333300009, 'JCB', 357, '2030-01-31', 'REF050'),
(NULL, 51, 4111111111111121, 'Visa', 456, '2030-02-28', 'REF051'),
(NULL, 52, 5500000000000014, 'MasterCard', 654, '2030-03-31', 'REF052'),
(NULL, 53, 340000000000019, 'American Express', 852, '2030-04-30', 'REF053'),
(NULL, 54, 6011000000000014, 'Discover', 963, '2030-05-31', 'REF054'),
(NULL, 55, 3530111333300010, 'JCB', 147, '2030-06-30', 'REF055'),
(NULL, 56, 4111111111111122, 'Visa', 258, '2030-07-31', 'REF056'),
(NULL, 57, 5500000000000015, 'MasterCard', 369, '2030-08-31', 'REF057'),
(NULL, 58, 340000000000020, 'American Express', 741, '2030-09-30', 'REF058'),
(NULL, 59, 6011000000000015, 'Discover', 852, '2030-10-31', 'REF059'),
(NULL, 60, 3530111333300011, 'JCB', 963, '2030-11-30', 'REF060');

-- Despliegue de tabla de métodos de pago
SELECT * FROM pixel_sec_360.metodo_pago;


-- VISTAS

-- Vista Usuario del sistema
CREATE VIEW vista_usuarios AS
SELECT 
    u.id,
    CONCAT(u.nombre, ' ', u.apellido) AS "Nombre completo",
    u.nombre_de_usuario AS "Nombre de usuario",
    u.ciudad AS "Ciudad",
    u.sexo AS "Género",
    u.estado_civil AS "Estado civil",
    u.tipo_de_empresa AS "Tipo de empresa",
    u.direccion AS "Dirección",
    tu.nombre_tipo AS "Tipo de usuario"
FROM usuarios u
JOIN tipos_de_usuario tu ON u.id_tipo_usuario = tu.id;

-- Vista Clasificación de los tipos de empresa
CREATE VIEW vista_clasificacion_tipo_empresa AS
SELECT 
CONCAT(u.nombre, ' ', u.apellido) AS "Nombre completo",
    u.tipo_de_empresa AS "Tipo de empresa"
FROM usuarios u;

-- Vista Medios de pagos
CREATE VIEW vista_metodos_pago AS
SELECT 
CONCAT(u.nombre, ' ', u.apellido) AS "Nombre completo",
    u.estado_civil AS "Estado civil",
    u.direccion AS "Dirección",
    m.numero_de_tarjeta AS "Número de tarjeta",
    m.nombre_de_tarjeta AS "Nombre de tarjeta",
    m.cvc AS "CVC",
    m.exp AS "Fecha de expiración",
    m.numero_referencia AS "Número de referencia"
FROM metodo_pago m
JOIN usuarios u ON m.id_usuario = u.id;

-- Vista Autenticación
CREATE VIEW vista_autenticacion AS
SELECT 
    a.nombre_de_usuario AS "Nombre de usuario",
    a.fecha AS "Fecha",
    a.pass AS "Contraseña",
    a.token AS "Token",
    a.agente AS "Nombre de dispositivo",
    u.apellido AS "Apellido",
    u.ciudad AS "Ciudad",
    u.tipo_de_empresa AS "Tipo de empresa"
FROM autenticacion a
JOIN usuarios u ON a.id_usuario = u.id;

-- Vista  Reporte de los tipos de pruebas con estado activo
CREATE VIEW vista_tipos_prueba_activos AS
SELECT 
    referencia AS "Referencia",
    nombre AS "Nombre de la prueba",
    descripcion"Descripción",
    fecha_ingreso AS "Fecha de ingreso",
    estado AS "Estado"
FROM tipos_de_prueba
WHERE estado = 'Activo';


-- Despliegue de vistas

SELECT * FROM pixel_sec_360.vista_usuarios;
SELECT * FROM pixel_sec_360.vista_clasificacion_tipo_empresa;
SELECT * FROM pixel_sec_360.vista_metodos_pago;
SELECT * FROM pixel_sec_360.vista_autenticacion;
SELECT * FROM pixel_sec_360.vista_tipos_prueba_activos;







