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