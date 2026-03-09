#Events and views in MySQL Library Database

This its the first example of the class for the database: 

```sql

DELIMITER $$

CREATE EVENT anual_eliminar_prestamos 
ON SCHEDULE EVERY 1 YEAR 
STARTS '2026-01-01 00:00:00' -- Puedes ajustar la fecha de inicio
DO 
BEGIN
    -- Eliminamos registros de la tabla_prestamo
    DELETE FROM tabla_prestamo
    WHERE PRES_FECHA_DEVOLUCION <= NOW() - INTERVAL 1 YEAR;
    
    # Esto eliminará préstamos cuya devolución fue hace más de un año
END$$

DELIMITER ;

```

Events are created for use automatically process, why dont we use a procedure or a trigger then? well, because events do the procedure we want in a time interval depending of how much time we give it to happend, this relies on time and the procedure we want based of the date we choose it to start

Another example for the class


inserts
```sql

CREATE TABLE aprendiz (
    id_aprendiz INT PRIMARY KEY,
    apr_nombre VARCHAR(50) NOT NULL,
    apr_apellido VARCHAR(50) NOT NULL,
    apr_correo VARCHAR(100) UNIQUE,
    apr_ubicacion VARCHAR(100)
);

INSERT INTO aprendiz (id_aprendiz, apr_nombre, apr_apellido, apr_correo, apr_ubicacion)
VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', 'Ciudad A'),
(2, 'María', 'Gómez', 'maria.gomez@example.com', 'Ciudad B'),
(3, 'Pedro', 'López', 'pedro.lopez@example.com', 'Ciudad C'),
(4, 'Laura', 'Torres', 'laura.torres@example.com', 'Ciudad A'),
(5, 'Carlos', 'Rodríguez', 'carlos.rodriguez@example.com', 'Ciudad B’);

```

and now we create the view:

```sql

CREATE VIEW Datos_Aprendiz AS
SELECT
    Id_aprendiz,
    apr_nombre,
    apr_correo,
    apr_ubicacion
FROM aprendiz;

```

And now we call the table

```

select * from datos_aprendiz;

```

# Types of Indexes
1. Primary Key Index
The Primary Key is the main identity of a record.

Purpose: Uniquely identifies each row in a table. It automatically creates a "Clustered Index," which physically organizes the data in the order of the key.

Constraints: Cannot contain NULL values and must be unique.

Syntax:

```sql
ALTER TABLE users ADD PRIMARY KEY (id);
2. Ordinary Index (Regular Index)
```

The most common type of index used to optimize query performance.

Purpose: Speeds up SELECT queries and WHERE clauses on columns that are frequently searched but do not need to be unique (e.g., last_name, created_at).

Note: It does not impose any constraints on the data; it only improves speed.

Syntax:

```sql
CREATE INDEX idx_lastname ON users(last_name);
3. Unique Index
```

Ensures data integrity across a specific column.

Purpose: Similar to an ordinary index for performance, but it also prevents duplicate values from being entered into the column.

Use Case: Ideal for email, username, or passport_number.

Syntax:

```sql
CREATE UNIQUE INDEX idx_email ON users(email);
```

for good practices index are usually called 'idx'_NameTable

# Class Example

```sql
CREATE TABLE posiciones (
    -- Primary Key Index: Identificador único autoincremental
    id INT AUTO_INCREMENT,
    
    -- Ordinary Index: Optimiza la búsqueda por grupos (Ej: "Grupo A")
    grupo CHAR(10) NOT NULL,
    
    -- Unique Index: Evita que un país se registre dos veces en la tabla
    pais VARCHAR(45) NOT NULL,
    
    jugados INT NOT NULL DEFAULT 0,
    ganados INT NOT NULL DEFAULT 0,
    empatados INT NOT NULL DEFAULT 0,
    perdidos INT NOT NULL DEFAULT 0,
    
    -- Ordinary Index: Acelera el ordenamiento por puntos (Ranking)
    puntos INT NOT NULL DEFAULT 0,

    -- Definición de Índices
    PRIMARY KEY (id),
    UNIQUE INDEX idx_pais_unico (pais),
    INDEX idx_grupo (grupo),
    INDEX idx_puntos (puntos)
);
```

CLASS EXCERCISE LIBRARY

-- Creación de la tabla de soporte para auditoría de autores
CREATE TABLE IF NOT EXISTS `audi_autor` (
  `id_audi_aut` int(10) NOT NULL AUTO_INCREMENT,
  `autCodigo_audi` int(11) DEFAULT NULL,
  `autApellido_anterior` varchar(45) DEFAULT NULL,
  `autApellido_nuevo` varchar(45) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(45) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_audi_aut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TRIGGER IF EXISTS autor_after_update;
DELIMITER $$

CREATE TRIGGER `autor_after_update` 
AFTER UPDATE ON `tabla_autor` 
FOR EACH ROW 
BEGIN
    INSERT INTO audi_autor (
        autCodigo_audi, 
        autApellido_anterior, 
        autApellido_nuevo, 
        audi_fechaModificacion, 
        audi_usuario, 
        audi_accion
    )
    VALUES (
        OLD.AUT_CODIGO, 
        OLD.AUT_APELLIDO, 
        NEW.AUT_APELLIDO, 
        NOW(), 
        CURRENT_USER(), 
        'Actualización de datos'
    );
END$$

DROP TRIGGER IF EXISTS autor_after_delete;
CREATE TRIGGER `autor_after_delete` AFTER DELETE ON `tabla_autor` 
FOR EACH ROW 
BEGIN
    INSERT INTO audi_autor(
        autCodigo_audi, autApellido_anterior, 
        audi_fechaModificacion, audi_usuario, audi_accion
    )
    VALUES(
        OLD.AUT_CODIGO, OLD.AUT_APELLIDO, 
        NOW(), CURRENT_USER(), 'Registro eliminado'
    );
END;




-- 1. Evento para eliminar préstamos con inicio y fin
DELIMITER $$

CREATE EVENT anual_eliminar_prestamos 
ON SCHEDULE EVERY 1 YEAR 
STARTS '2026-03-09 10:00:00' 
ENDS '2031-03-09 10:00:00'
DO 
BEGIN
    DELETE FROM tabla_prestamo
    WHERE PRES_FECHA_DEVOLUCION <= NOW() - INTERVAL 1 YEAR;
END$$

DELIMITER ;




-- Vista 1: Reporte de Préstamos (Multitabla)
CREATE OR REPLACE VIEW vista_prestamos_detallados AS
SELECT 
    p.PRES_ID AS 'ID',
    l.LIB_TITULO AS 'Libro',
    CONCAT(s.SOC_NOMBRE, ' ', s.SOC_APELLIDO) AS 'Nombre Socio',
    p.PRES_FECHA_PRESTAMO AS 'Fecha Salida',
    p.PRES_FECHA_DEVOLUCION AS 'Fecha Devolución'
FROM tabla_prestamo p
JOIN tabla_libro l ON p.LIB_COPIA_ISBN = l.LIB_ISBN
JOIN tabla_socio s ON p.SOC_COPIA_NUMERO = s.SOC_NUMERO;

-- Vista 2: Reporte de Inventario y Días (De una sola tabla)
CREATE OR REPLACE VIEW vista_inventario_dias AS
SELECT 
    LIB_ISBN, 
    LIB_TITULO, 
    LIB_GENERO, 
    LIB_DIAS_PRESTAMO 
FROM tabla_libro
ORDER BY LIB_GENERO ASC;



-- 1. Crear índice para la columna LIB_TITULO
CREATE INDEX idx_lib_titulo ON tabla_libro(LIB_TITULO);