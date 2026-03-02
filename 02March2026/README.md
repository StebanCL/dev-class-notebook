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

![alt text](image.png)