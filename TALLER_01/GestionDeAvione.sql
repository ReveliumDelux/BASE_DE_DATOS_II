CREATE TABLE Aviones (
    id INT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE Aerolineas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais_origen VARCHAR(100)
);

CREATE TABLE Vuelos (
    id INT PRIMARY KEY,
    avion_id INT NOT NULL,
    aerolinea_id INT NOT NULL,
    fecha DATETIME NOT NULL,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,

    FOREIGN KEY (avion_id) REFERENCES Aviones(id),
    FOREIGN KEY (aerolinea_id) REFERENCES Aerolineas(id)
);
CREATE TABLE Sillas (
    id INT PRIMARY KEY,
    vuelo_id INT NOT NULL,
    numero_silla VARCHAR(10) NOT NULL,
    clase VARCHAR(20) NOT NULL,   
    estado VARCHAR(20) DEFAULT 'Disponible',

    FOREIGN KEY (vuelo_id) REFERENCES Vuelos(id)
);