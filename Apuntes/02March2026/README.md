Markdown
# MySQL Procedures and Functions Guide

A comprehensive guide and repository of examples for learning **Stored Procedures** and **Functions** in MySQL. This document covers basic syntax, parameters (IN, OUT, INOUT), variable declaration, and practical use cases.

## 📋 Table of Contents
1. [Basic Procedures](#1-basic-procedures)
2. [Procedures with Parameters](#2-procedures-with-parameters)
3. [Internal Variables and Logic](#3-internal-variables-and-logic)
4. [Class Example: Sales & Inventory](#4-class-example-sales--inventory)
5. [Class Test: Library Management System](#5-class-test-library-management-system)

---

## 1. Basic Procedures <a name="1-basic-procedures"></a>

### Database Setup
First, we create a basic `cliente` (customer) table to practice the initial procedures.

```sql
CREATE TABLE cliente(
    id_cliente int NOT NULL AUTO_INCREMENT,
    nombre_cliente varchar(20) NOT NULL,
    telefono_cliente bigint NOT NULL,
    correo_cliente varchar(255) NOT NULL,
    PRIMARY KEY (id_cliente)
);

INSERT INTO cliente(nombre_cliente, telefono_cliente, correo_cliente)
VALUES 
("Ana Luna", 312566678, "lunera@hotmail.com"),
("Sol solecito", 312678978, "sole@gmail.com");
Simple Procedure Example
To list all customers and their phone numbers. We start with a basic selection and then apply corrections.

SQL
-- Initial example
CREATE PROCEDURE lista_clientes_telefono()
SELECT nombre_cliente, telefono FROM cliente;

-- Using the call option
CALL lista_clientes_telefono();

-- Drop the procedure if there is anything wrong
DROP PROCEDURE IF EXISTS lista_clientes_telefono;

-- Procedure correction
CREATE PROCEDURE lista_clientes_telefono()
SELECT nombre_cliente, telefono_cliente FROM cliente;
2. Procedures with Parameters <a name="2-procedures-with-parameters"></a>
Procedure with an IN Parameter
Input parameters allow filtering data based on external values provided during the call.

SQL
CREATE PROCEDURE get_nombre_cliente(IN nom varchar(20))
SELECT * FROM cliente WHERE nombre_cliente=nom;

-- Calling it
CALL get_nombre_cliente("Ana LUNA");
Use of OUT Parameters
The OUT parameter is mandatory when you need the procedure to return a specific value to the caller. Note that we must call the variable to see the result.

SQL
CREATE PROCEDURE get_contar_nombre(IN nom varchar(20), OUT cuenta INT)
SELECT COUNT(nombre_cliente)
INTO cuenta
FROM cliente WHERE nombre_cliente=nom;

-- Calling it
CALL get_contar_nombre("Ana Luna", @cuenta);

-- We call the variable to see the result
SELECT @cuenta;
3. Internal Variables and Logic <a name="3-internal-variables-and-logic"></a>
Internal Variable Declaration
Using DECLARE allows managing local variables within the algorithm for intermediate operations. We use SET to modify or assign values.

SQL
DROP PROCEDURE IF EXISTS pa_sumar;
DELIMITER $$
CREATE PROCEDURE pa_sumar(IN V1 INT, IN V2 INT)
BEGIN
    DECLARE suma INT;
    SET suma = V1 + V2;
    SELECT suma;
END$$
DELIMITER ;

CALL pa_sumar(5, 10);
4. Class Example: Sales & Inventory <a name="4-class-example-sales--inventory"></a>
Inventory Setup
Examples focused on inventory where INOUT data is used for accumulators that update their value depending on changes.

SQL
CREATE TABLE if NOT EXISTS productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);

INSERT INTO productos (nombre, estado, precio) 
VALUES ('Producto A','disponible', 8), ('Producto B', 'disponible', 1.5), ('Producto C', 'agotado', 80);
Filtering and Counting
SQL
CREATE PROCEDURE obtenerProductosPorEstado(IN nombre_estado VARCHAR(255))
SELECT * FROM productos WHERE estado = nombre_estado;

CALL obtenerProductosPorEstado('disponible');

DELIMITER $$
CREATE PROCEDURE contarProductosPorEstado(IN nombre_estado VARCHAR(25), OUT numero INT)
BEGIN
    SELECT count(id) INTO numero FROM productos WHERE estado = nombre_estado;
END$$
DELIMITER ;

CALL contarProductosPorEstado('disponible', @numero);
SELECT @numero AS disponibles;
Advanced INOUT: venderProducto
This procedure accumulates the total benefit by adding prices each time it is called.

SQL
DELIMITER $$
CREATE PROCEDURE venderProducto(INOUT beneficio FLOAT, IN id_producto INT)
BEGIN
    SELECT precio INTO @incremento_precio FROM productos WHERE id = id_producto;
    SET beneficio = beneficio + @incremento_precio;
END $$
DELIMITER ;

-- Cumulative execution
SET @beneficio = 0;
CALL venderProducto(@beneficio, 1); -- sum 8
CALL venderProducto(@beneficio, 2); -- sum 1.5
CALL venderProducto(@beneficio, 2); -- sum 1.5
SELECT @beneficio AS BeneficioTotal;
SELECT @incremento_precio AS UltimoPrecioSumado;
5. Class Test: Library Management System <a name="5-class-test-library-management-system"></a>
Author and Book Procedures
A collection of scripts for managing authors, books, and loans using Joins and Functions.

SQL
-- Get authors list
DROP PROCEDURE IF EXISTS get_listaAutores;
DELIMITER $$
CREATE PROCEDURE get_listaAutores()
BEGIN
    SELECT AUT_CODIGO, AUT_APELLIDO FROM tabla_autor ORDER BY AUT_APELLIDO DESC;
END$$
DELIMITER ;
SQL
-- Filter author by type
CREATE PROCEDURE get_tipoAutor(IN variable VARCHAR(20))
BEGIN
    SELECT a.AUT_APELLIDO AS 'Autor', t.TIPO_AUTOR
    FROM tabla_autor a
    INNER JOIN tabla_tipoautores t ON a.AUT_CODIGO = t.COPIA_AUTOR
    WHERE t.TIPO_AUTOR = variable;
END$$

CALL get_tipoAutor('Traductor');
SQL
-- Insert new book
CREATE PROCEDURE insert_libro(
    IN c1_isbn BIGINT(20), IN c2_titulo VARCHAR(255), IN c3_genero VARCHAR(20), 
    IN c4_paginas INT, IN c5_dias TINYINT)
BEGIN
    INSERT INTO tabla_libro (LIB_ISBN, LIB_TITULO, LIB_GENERO, LIB_NUM_PAGINAS, LIB_DIAS_PRESTAMO)
    VALUES (c1_isbn, c2_titulo, c3_genero, c4_paginas, c5_dias);
END$$

CALL insert_libro(111222333, 'Nuevo Libro', 'Aventura', 350, 7);
Administrative Functions
Functions used for data calculation like totalSocios and diasDePrestamo using DATEDIFF.

SQL
-- Count total members
CREATE FUNCTION totalSocios() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tabla_socio;
    RETURN total;
END $$

-- Calculate loan days
CREATE FUNCTION diasDePrestamo(isbn_libro BIGINT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(PRES_FECHA_DEVOLUCION, PRES_FECHA_PRESTAMO) INTO dias
    FROM tabla_prestamo WHERE LIB_COPIA_ISBN = isbn_libro LIMIT 1;
    RETURN dias;
END $$