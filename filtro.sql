-- Active: 1701906038989@@127.0.0.1@3306

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS metrolinea;

USE metrolinea;

CREATE TABLE IF NOT EXISTS zonas (
    id_zona INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    nombre_zona VARCHAR(30) NOT NULL);

CREATE TABLE IF NOT EXISTS buses (
    id_bus INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(6) NOT NULL
);

CREATE TABLE IF NOT EXISTS conductores (
    id_conductor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_conductor VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS estaciones (
    id_estacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_estacion VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS rutas;

CREATE TABLE IF NOT EXISTS rutas (
    id_ruta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_ruta VARCHAR(30) NOT NULL,
    tiempo_ruta TIME NOT NULL
)

CREATE TABLE IF NOT EXISTS parada_ruta (
    id_ruta INT NOT NULL,
    id_parada INT NOT NULL,
    Foreign Key (id_ruta) REFERENCES rutas(id_ruta),
    Foreign Key (id_parada) REFERENCES estaciones(id_estacion)
)

CREATE TABLE IF NOT EXISTS recorrido (
    id_conductor INT NOT NULL,
    id_bus INT NOT NULL,
    dia VARCHAR(10) NOT NULL,
    id_ruta INT NOT NULL,
    Foreign Key (id_ruta) REFERENCES rutas(id_ruta)
);

CREATE TABLE IF NOT EXISTS ruta_zona (
    id_ruta INT NOT NULL,
    id_zona INT NOT NULL,
    Foreign Key (id_ruta) REFERENCES rutas(id_ruta),
    Foreign Key (id_zona) REFERENCES zonas(id_zona)
)

show TABLES;

INSERT INTO zonas (nombre_zona)
VALUES 
    ("Norte"), 
    ("Sur"), 
    ("Oriente"),
    ("Occidente"),
    ("Floridablanca"),
    ("Girón"),
    ("Piedecuesta");


INSERT INTO buses (placa)
VALUES
    ("XVH345"),
    ("XDL965"),
    ("XFG847"),
    ("XRJ452"),
    ("XDF459"),
    ("XET554"),
    ("XKL688"),
    ("XXL757");

INSERT INTO conductores(nombre_conductor)
VALUES
    ("Andrés Manuel López Obrador"),
    ("Nicolás Maduro Moros"),
    ("Alberto Fernández"),
    ("Luiz Inácio Lula da Silva"),
    ("Gabriel Boric"),
    ("Miguel Díaz-Canel"),
    ("Daniel Ortega"),
    ("Gustavo Petro Urrego"),
    ("Luis Arce"),
    ("Xiomara Castro");

INSERT INTO estaciones(nombre_estacion)
VALUES
    ("Colseguros"),
    ("Clínica Chicamocha"),
    ("Plaza Guarín"),
    ("Mega Mall"),
    ("UIS"),
    ("UDI"),
    ("Santo Tomás"),
    ("Boulevard Santander"),
    ("Búcaros"),
    ("Rosita"),
    ("Puerta del Sol"),
    ("Cacique"),
    ("Plaza Satélite"),
    ("La Sirena"),
    ("Provenza "),
    ("Fontana"),
    ("Gibraltar "),
    ("Terminal"),
    ("Mutis"),
    ("Plaza Real");

INSERT INTO rutas (nombre_ruta, tiempo_ruta)
VALUES
    ("Universidades", "2:00:00"),
    ("Café Madrid", "2:15:00"),
    ("Cacique", "1:45:00"),
    ("Diamantes", "1:50:00"),
    ("Terminal", "2:00:00"),
    ("Prado", "1:30:00"),
    ("Cabecera", "1:30:00"),
    ("Ciudadela", "2:00:00"),
    ("Punta Estrella", "2:30:00"),
    ("Niza", "2:45:00"),
    ("Autopista", "2:15:00"),
    ("Lagos", "2:15:00"),
    ("Centro Florida", "2:30:00");

INSERT INTO parada_ruta(id_ruta, id_parada)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5),
    (1, 6),
    (1, 7),
    (3, 8),
    (3, 9),
    (3, 10),
    (3, 11),
    (3, 12),
    (4, 13),
    (4, 14),
    (4, 15),
    (5, 16),
    (5, 17),
    (8, 18),
    (8, 19),
    (8, 20);
    
INSERT INTO recorrido(id_conductor, id_bus, dia, id_ruta)
VALUES 
    (5, 1, "Lunes", 1),
    (5, 1, "Martes", 1),
    (5, 3, "Miércoles", 1),
    (5, 3, "Jueves", 1),
    (5, 5, "Viernes", 2),
    (5, 5, "Sábado", 2),
    (5, 5, "Domingo", 2),
    (3, 5, "Lunes", 4),
    (3, 6, "Martes", 4),
    (3, 1, "Miércoles", 4),
    (3, 1, "Jueves", 5),
    (3, 3, "Viernes", 5),
    (3, 3, "Sábado", 5),
    (3, 3, "Domingo", 5),
    (10, 3, "Lunes", 10),
    (10, 3, "Martes", 10),
    (10, 5, "Miércoles", 10),
    (10, 5, "Jueves", 10),
    (10, 4, "Viernes", 10),
    (10, 7, "Sábado", 11),
    (10, 7, "Domingo", 11),
    (7, 7, "Lunes", 11),
    (7, 7, "Martes", 11),
    (6, 7, "Miércoles", 12),
    (6, 7, "Jueves", 12),
    (6, 7, "Viernes", 12),
    (6, 6, "Sábado", 12),
    (6, 6, "Domingo", 12);

INSERT INTO ruta_zona(id_ruta, id_zona)
VALUES
    (1, 1),
    (2, 1),
    (4, 4),
    (5, 4),
    (10, 5),
    (11, 5),
    (12, 5);


CREATE FUNCTION contar_rutas_zonas(id_zona INT) RETURNS INT DETERMINISTIC
BEGIN
SET @RES = (SELECT Count(*) FROM recorrido R
INNER JOIN rutas R2 ON R.id_ruta = R2.id_ruta
INNER JOIN ruta_zona RZ on R2.id_ruta = RZ.id_ruta
WHERE RZ.id_zona = id_zona
GROUP BY RZ.id_zona);

RETURN @RES;
END;


ALTER TABLE parada_ruta ADD COLUMN is_inicio BOOLEAN NOT NULL;
ALTER TABLE parada_ruta ADD COLUMN is_final BOOLEAN NOT NULL;

ALTER TABLE parada_ruta ADD CONSTRAINT unique_inicio UNIQUE(is_inicio, id_parada);
ALTER TABLE parada_ruta ADD CONSTRAINT unique_final UNIQUE(is_final, id_parada);




