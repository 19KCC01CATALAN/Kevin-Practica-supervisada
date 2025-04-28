-- Crear la base de datos peliculas si no existe
CREATE DATABASE IF NOT EXISTS peliculas;

-- Usar la base de datos FixoDB
USE peliculas;

-- Crear la tabla direccion que almacena las direcciones de los clientes
CREATE TABLE direccion (
  idDireccion INT PRIMARY KEY,  -- ID único para cada dirección
  Direccion VARCHAR(45),         -- Calle o avenida
  Ciudad VARCHAR(45),            -- Ciudad donde está ubicada
  Pais VARCHAR(45)               -- País
);

-- Crear la tabla cliente que almacena los datos de los clientes
CREATE TABLE cliente (
  idCliente INT PRIMARY KEY,             -- ID único para cada cliente
  Nombre VARCHAR(45),                    -- Nombre del cliente
  Apellido VARCHAR(45),                  -- Apellido del cliente
  Edad INT,                               -- Edad del cliente
  Direccion_idDireccion INT,              -- Referencia a la dirección del cliente
  FOREIGN KEY (Direccion_idDireccion) REFERENCES direccion(idDireccion) -- Llave foránea a direccion
);

-- Crear la tabla categoria que almacena los géneros o tipos de películas
CREATE TABLE categoria (
  idCategoria INT PRIMARY KEY, -- ID único para cada categoría
  Nombre VARCHAR(45)           -- Nombre de la categoría
);

-- Crear la tabla peliculas que almacena las películas
CREATE TABLE peliculas (
  idPeliculas INT PRIMARY KEY,           -- ID único para cada película
  Nombre VARCHAR(45),                    -- Nombre de la película
  Duracion INT,                          -- Duración en minutos
  Año INT,                               -- Año de estreno
  Categoria_idCategoria INT,             -- Referencia a la categoría
  FOREIGN KEY (Categoria_idCategoria) REFERENCES categoria(idCategoria) -- Llave foránea a categoria
);

-- Crear la tabla inventario que guarda las copias físicas de las películas
CREATE TABLE inventario (
  idCopiaPeliculas INT PRIMARY KEY,         -- ID único para cada copia de película
  Peliculas_idPeliculas INT,                -- Referencia a la película
  Disponible TINYINT,                       -- 1 disponible, 0 no disponible
  FOREIGN KEY (Peliculas_idPeliculas) REFERENCES peliculas(idPeliculas) -- Llave foránea a peliculas
);

-- Crear la tabla renta que registra las rentas de películas
CREATE TABLE renta (
  idRenta INT PRIMARY KEY,                   -- ID único para cada renta
  Fecha_Renta DATE,                          -- Fecha en que se rentó
  Fecha_Entrega DATE,                        -- Fecha en que debe devolverse
  Inventario_idCopiaPeliculas INT,            -- Referencia a la copia alquilada
  Cliente_idCliente INT,                     -- Referencia al cliente que rentó
  FOREIGN KEY (Inventario_idCopiaPeliculas) REFERENCES inventario(idCopiaPeliculas), -- Llave foránea a inventario
  FOREIGN KEY (Cliente_idCliente) REFERENCES cliente(idCliente) -- Llave foránea a cliente
);

-- Insertar datos de ejemplo en la tabla direccion
INSERT INTO direccion VALUES 
(1, 'Av. Siempre Viva 123', 'Springfield', 'USA'),
(2, 'Calle Falsa 742', 'Ciudad Gótica', 'USA'),
(3, 'Av. Central 100', 'Metropolis', 'USA'),
(4, 'Calle Luna 45', 'Springfield', 'USA'),
(5, 'Av. Del Sol 101', 'Miami', 'USA');

-- Insertar datos de ejemplo en la tabla cliente
INSERT INTO cliente VALUES
(1, 'Juliana', 'Gomez', 25, 1),
(2, 'Carlos', 'Perez', 30, 2),
(3, 'Ana', 'Martinez', 22, 3),
(4, 'Juliana', 'Diaz', 28, 4),
(5, 'Luis', 'Lopez', 35, 5);

-- Insertar datos de ejemplo en la tabla categoria
INSERT INTO categoria VALUES
(1, 'Acción'),
(2, 'Drama'),
(3, 'Comedia'),
(4, 'Terror'),
(5, 'Animación');

-- Insertar datos de ejemplo en la tabla peliculas
INSERT INTO peliculas VALUES
(1, 'Pokemon1', 90, 2000, 5),
(2, 'Avengers', 120, 2012, 1),
(3, 'Titanic', 180, 1997, 2),
(4, 'Toy Story', 100, 1995, 5),
(5, 'The Conjuring', 112, 2013, 4);

-- Insertar datos de ejemplo en la tabla inventario
INSERT INTO inventario VALUES
(1, 1, 1), -- Copia 1 de Pokemon1 disponible
(2, 2, 1), -- Copia 2 de Avengers disponible
(3, 3, 1), -- Copia 3 de Titanic disponible
(4, 4, 1), -- Copia 4 de Toy Story disponible
(5, 5, 0); -- Copia 5 de The Conjuring no disponible

-- Insertar datos de ejemplo en la tabla renta
INSERT INTO renta VALUES
(1, '2025-04-01', '2025-04-05', 1, 1),
(2, '2025-04-02', '2025-04-06', 2, 2),
(3, '2025-04-03', '2025-04-07', 3, 3),
(4, '2025-04-04', '2025-04-08', 4, 4),
(5, '2025-04-05', '2025-04-09', 5, 5);

-- CONSULTAS SOLICITADAS

-- Mostrar todos los clientes cuyo nombre sea 'Juliana'
SELECT * FROM cliente WHERE Nombre = 'Juliana';

-- Eliminar todas las películas cuyo nombre sea 'Pokemon1'
DELETE FROM peliculas WHERE Nombre = 'Pokemon1';

-- Mostrar todas las categorías ordenadas de manera ascendente (A a Z)
SELECT * FROM categoria ORDER BY Nombre ASC;

-- Mostrar todas las películas ordenadas por año de forma descendente (más nuevas primero)
SELECT * FROM peliculas ORDER BY Año DESC;

-- Relacionar clientes con sus ciudades
SELECT cliente.Nombre, direccion.Ciudad
FROM cliente
INNER JOIN direccion ON cliente.Direccion_idDireccion = direccion.idDireccion;
