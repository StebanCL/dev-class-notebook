# Triggers in MySQL

Triggers are automatic procedures most commonly used on logs of changes in many tables so it can become handy when some action its done on a table and you want to do something at that exact moment
acting like ghost procedures they dont need to be called but they do their duty when the action you register its done, it could be an update, delete, insert or any single action depending on what you desire to do and its purpose

## here's an example

```sql

CREATE TABLE Producto(
    productoID INT PRIMARY KEY,
    nombrePro VARCHAR(30) NOT NULL,
    precioPro INT NOT NULL,
    cantidadTotalPro INT NOT NULL);
    
CREATE TABLE Entrada(
    entradaID INT PRIMARY KEY,
    fechaEntrada DATE NOT NULL,
    cantidadEntrada INT NOT NULL,
    productoID INT NOT NULL,
    FOREIGN KEY (productoID) REFERENCES Producto(productoID));
    
INSERT INTO Producto(productoID,nombrePro, precioPro, cantidadTotalPro)
VALUES (1,'Panela',200,0),(2,'Pastas doria familiar',3500,0);

DROP TRIGGER IF EXISTS entrada_producto;
DELIMITER $$
CREATE TRIGGER entrada_producto BEFORE INSERT
ON Entrada FOR EACH ROW
BEGIN
    UPDATE Producto 
    SET cantidadTotalPro=Producto.cantidadTotalPro+new.cantidadEntrada
    WHERE new.productoID=Producto.productoID;
END$$
DELIMITER ;

INSERT INTO entrada(entradaID, fechaEntrada, cantidadEntrada, productoID) 
VALUES (001,'2020-10-06',10,1);
SELECT * FROM Producto;

#detalle los cambios en la tabla producto
INSERT INTO entrada(entradaID, fechaEntrada, cantidadEntrada, productoID) 
VALUES (002,'2020-10-06',13,1);

INSERT INTO entrada(entradaID, fechaEntrada, cantidadEntrada, productoID) 
VALUES (003,'2020-10-06',50,2);

SELECT * FROM Producto;

```

# Ejemplo aplicado a base de datos Biblioteca

```sql

-- New Log Table

CREATE TABLE audi_socio(
    id_audi INT(10) AUTO_INCREMENT,
    socNumero_audi INT(11),
    socNombre_anterior VARCHAR(45),
    socApellido_anterior VARCHAR(45),
    socDireccion_anterior VARCHAR(255),
    socTelefono_anterior VARCHAR(10),
    socNombre_nuevo VARCHAR(45),
    socApellido_nuevo VARCHAR(45),
    socDireccion_nuevo VARCHAR(255),
    socTelefono_nuevo VARCHAR(10),
    audi_fechaModificacion DATETIME,
    audi_usuario VARCHAR(45), -- Aumenté la longitud por si el nombre de usuario es largo
    audi_accion VARCHAR(45),
    PRIMARY KEY(id_audi)
);

-- Trigger

DROP TRIGGER IF EXISTS socios_before_update;

DELIMITER //

CREATE TRIGGER socios_before_update 
BEFORE UPDATE ON tabla_socio 
FOR EACH ROW
BEGIN
    INSERT INTO audi_socio(
        socNumero_audi,
        socNombre_anterior,
        socApellido_anterior,
        socDireccion_anterior,
        socTelefono_anterior,
        socNombre_nuevo,
        socApellido_nuevo,
        socDireccion_nuevo,
        socTelefono_nuevo,
        audi_fechaModificacion,
        audi_usuario,
        audi_accion
    )
    VALUES(
        NEW.SOC_NUMERO,   
        OLD.SOC_NOMBRE,   
        OLD.SOC_APELLIDO,  
        OLD.SOC_DIRECCION, 
        OLD.SOC_TELEFONO,  
        NEW.SOC_NOMBRE,
        NEW.SOC_APELLIDO,
        NEW.SOC_DIRECCION,
        NEW.SOC_TELEFONO,
        NOW(),
        CURRENT_USER(),
        'Actualización'
    );
END//

DELIMITER ;

-- update section to try the code:

UPDATE tabla_socio 
SET SOC_DIRECCION = 'Calle 72 # 2', 
    SOC_TELEFONO = '2928088' 
WHERE SOC_NUMERO = 13;

```

```sql

-- Trigger for delete log
DELIMITER //

DROP TRIGGER IF EXISTS socios_after_delete//

CREATE TRIGGER socios_after_delete 
AFTER DELETE ON tabla_socio 
FOR EACH ROW
BEGIN
    INSERT INTO audi_socio(
        socNumero_audi,
        socNombre_anterior,
        socApellido_anterior,
        socDireccion_anterior,
        socTelefono_anterior,
        audi_fechaModificacion,
        audi_usuario,
        audi_accion
    )
    VALUES(
        OLD.SOC_NUMERO,
        OLD.SOC_NOMBRE,
        OLD.SOC_APELLIDO,
        OLD.SOC_DIRECCION,
        OLD.SOC_TELEFONO,
        NOW(),
        CURRENT_USER(),
        'Registro eliminado'
    );
END//

DELIMITER ;

-- test the trigger and look the delete
DELETE FROM tabla_socio WHERE SOC_NUMERO = 13;

SELECT * FROM audi_socio WHERE audi_accion = 'Registro eliminado';
```