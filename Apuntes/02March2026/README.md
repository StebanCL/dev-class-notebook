example for learning procedures and triggers in mysql 

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

example procedure

CREATE PROCEDURE lista_clientes_telefono()
SELECT nombre_cliente, telefono FROM cliente;

using the call option

CALL lista_clientes_telefono()

drop the procedure if there is anything wrong

DROP PROCEDURE IF EXISTS lista_clientes_telefono;

procedure correction

CREATE PROCEDURE lista_clientes_telefono()
SELECT nombre_cliente, telefono_cliente FROM cliente;

![alt text](/02March2026/assets/image.png)

procedure with a parameter

CREATE PROCEDURE get_nombre_cliente(IN nom varchar(20))
SELECT * FROM cliente WHERE nombre_cliente=nom;

calling it

CALL get_nombre_cliente("Ana LUNA");

![procedure with int data](/02March2026/assets/image-1.png)

use of SELF with a null parameter and exit parameter
out is mandatory in this parameter

CREATE PROCEDURE get_contar_nombre(IN nom varchar(20),OUT cuenta INT)
SELECT COUNT(nombre_cliente)
INTO cuenta
FROM cliente WHERE nombre_cliente=nom;

calling it

CALL get_contar_nombre("Ana Luna",@cuenta);

we cannot see the result because we must call the variable
so we call the variable with both of the sentences: 

CALL get_contar_nombre("Ana Luna", @cuenta);
SELECT @cuenta;

INTO in and out data most commonly used for inventory and sales
(these ones are keeping the out data in themselves and again recive a new one so they keep increasing or lowering their value depending on the amount of changes using it)


CLASS EXAMPLE
using a sales database with the table products:

CREATE TABLE if NOT EXISTS productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);
INSERT INTO productos (nombre, estado, precio) 
VALUES 
('Producto A','disponible', 8), ('Producto B', 'disponible', 1.5),('Producto C', 'agotado', 80);
CREATE PROCEDURE obtenerProductosPorEstado(IN nombre_estado VARCHAR(255))
    SELECT * 
    FROM productos
    WHERE estado = nombre_estado;
CALL obtenerProductosPorEstado('disponible');
DELIMITER $$
CREATE PROCEDURE contarProductosPorEstado(
    IN nombre_estado VARCHAR(25),
    OUT numero INT)
BEGIN
    SELECT count(id) 
    INTO numero
    FROM productos
    WHERE estado = nombre_estado;
END$$
DELIMITER ;
CALL contarProductosPorEstado('disponible',@numero);
SELECT @numero AS disponibles;

as a result we get the amount of aviable products:

![alt text](/02March2026/assets/image2.png)


and the count for the state of the products:

![alt text](/02March2026/assets/image4.png)


Creating Procedure venderProducto

DELIMITER $$

CREATE PROCEDURE venderProducto(
    INOUT beneficio FLOAT,
    IN id_producto INT)
BEGIN
    # SELECT @incremento_precio = precio
    SELECT precio INTO @incremento_precio
    FROM productos
    WHERE id = id_producto;
    
    SET beneficio = beneficio + @incremento_precio;
END $$

DELIMITER ;

calling it many times

-- Inicializamos el beneficio en 0
SET @beneficio = 0;

-- Primera venta: Producto con ID 1 (Precio 8)
CALL venderProducto(@beneficio, 1); 
# beneficio = 0 | id = 1 | beneficio sería 0 + 8 = 8

-- Segunda venta: Producto con ID 2 (Precio 1.5)
CALL venderProducto(@beneficio, 2); 
# beneficio = 8 | id = 2 | beneficio sería 8 + 1.5 = 9.5

-- Tercera venta: Producto con ID 2 de nuevo
CALL venderProducto(@beneficio, 2); 
# beneficio = 9.5 | id = 2 | beneficio sería 9.5 + 1.5 = 11

-- Ver resultados finales
SELECT @beneficio AS BeneficioTotal;
SELECT @incremento_precio AS UltimoPrecioSumado;

![class example2](/02March2026/assets/image5.png)

and the last sum of the price

![class example2.1](/02March2026/assets/image6.png)


next example with declare for the variable in the algoritm

DROP PROCEDURE IF EXISTS pa_sumar;
DELIMITER $$
CREATE PROCEDURE pa_sumar(
    IN V1 INT,
    IN V2 INT)
    BEGIN
        DECLARE suma INT;
        SET suma=V1+V2;/*para modificar una variable utilizamos la palabra set 
set suma=V1+V2; */
        SELECT suma;
    END$$
DELIMITER ;

then we call it with the operation
CALL pa_sumar(5, 10);

so if we use select in the variable we are going to be able to call the procedure without using select too in the query

![sum](/02March2026/assets/image7.png)

we also used functions like concat for rows or organizing spaces, dateformat so we can reorganize how we see our dates in the table or datediff, we used too date comparisions to check if a date is correct like the amount of days, for example its not gonna show anything if the comparison says date november 32 or something like that, also we used variables declaring them and using them for save data inside them and reuse that data like counting the amount of patients in a hospital and returning them all in the amount of patients with a number


CLASS TEST

Procedures
get autors list

DROP PROCEDURE IF EXISTS get_listaAutores;

DELIMITER $$
CREATE PROCEDURE get_listaAutores()
BEGIN
    SELECT AUT_CODIGO, AUT_APELLIDO 
    FROM tabla_autor 
    ORDER BY AUT_APELLIDO DESC;
END$$
DELIMITER ;

-- CALL get_listaAutores();

![alt text](/02March2026/assets/image8.png)


obtain autor type procedure

DROP PROCEDURE IF EXISTS get_tipoAutor;

DELIMITER $$
CREATE PROCEDURE get_tipoAutor(IN variable VARCHAR(20))
BEGIN
    SELECT a.AUT_APELLIDO AS 'Autor', t.TIPO_AUTOR
    FROM tabla_autor a
    INNER JOIN tabla_tipoautores t ON a.AUT_CODIGO = t.COPIA_AUTOR
    WHERE t.TIPO_AUTOR = variable;
END$$
DELIMITER ;

CALL get_tipoAutor('Traductor');

![Tipo de autor](/02March2026/assets/image9.png)

procedure insert libro/book

DROP PROCEDURE IF EXISTS insert_libro;

DELIMITER $$
CREATE PROCEDURE insert_libro(
    IN c1_isbn BIGINT(20), 
    IN c2_titulo VARCHAR(255), 
    IN c3_genero VARCHAR(20), 
    IN c4_paginas INT, 
    IN c5_dias TINYINT
)
BEGIN
    INSERT INTO tabla_libro (LIB_ISBN, LIB_TITULO, LIB_GENERO, LIB_NUM_PAGINAS, LIB_DIAS_PRESTAMO)
    VALUES (c1_isbn, c2_titulo, c3_genero, c4_paginas, c5_dias);
END$$
DELIMITER ;


CALL insert_libro(111222333, 'Nuevo Libro', 'Aventura', 350, 7);

![insert libro](/02March2026/assets/image10.png)


scripts procedures: DELIMITER $$
CREATE PROCEDURE listarSociosYPrestamos()
BEGIN
    SELECT s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_ID, p.PRES_FECHA_PRESTAMO
    FROM tabla_socio s
    LEFT JOIN tabla_prestamo p ON s.SOC_NUMERO = p.SOC_COPIA_NUMERO;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE librosPrestadosConSocio()
BEGIN
    SELECT l.LIB_TITULO, s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_FECHA_PRESTAMO
    FROM tabla_libro l
    INNER JOIN tabla_prestamo p ON l.LIB_ISBN = p.LIB_COPIA_ISBN
    INNER JOIN tabla_socio s ON p.SOC_COPIA_NUMERO = s.SOC_NUMERO;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE insertarSocio(
    IN num INT, IN nom VARCHAR(45), IN ape VARCHAR(45), IN dir VARCHAR(255), IN tel VARCHAR(10)
)
BEGIN
    INSERT INTO tabla_socio (SOC_NUMERO, SOC_NOMBRE, SOC_APELLIDO, SOC_DIRECCION, SOC_TELEFONO)
    VALUES (num, nom, ape, dir, tel);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE buscarLibroPorNombre(IN nombre_buscar VARCHAR(255))
BEGIN
    SELECT * FROM tabla_libro 
    WHERE LIB_TITULO LIKE CONCAT('%', nombre_buscar, '%');
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE actualizarDatosSocio(
    IN socio_id INT, IN nueva_dir VARCHAR(255), IN nuevo_tel VARCHAR(10)
)
BEGIN
    UPDATE tabla_socio 
    SET SOC_DIRECCION = nueva_dir, SOC_TELEFONO = nuevo_tel
    WHERE SOC_NUMERO = socio_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE eliminarLibro(IN isbn_borrar BIGINT)
BEGIN
    -- Primero borraríamos dependencias si fuera necesario, 
    -- o simplemente intentar borrar el libro:
    DELETE FROM tabla_libro WHERE LIB_ISBN = isbn_borrar;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION totalSocios() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tabla_socio;
    RETURN total;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION diasDePrestamo(isbn_libro BIGINT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(PRES_FECHA_DEVOLUCION, PRES_FECHA_PRESTAMO) INTO dias
    FROM tabla_prestamo
    WHERE LIB_COPIA_ISBN = isbn_libro
    LIMIT 1; -- Limitamos a 1 por si el libro se prestó varias veces
    RETURN dias;
END $$
DELIMITER ;