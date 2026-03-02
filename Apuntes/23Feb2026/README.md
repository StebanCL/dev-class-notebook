# Apuntes de SQL y MySQL para Taller

## 1. Creación e inserción de registros en tablas

- Para registrar datos manualmente en MySQL:
```sql
INSERT INTO tbl_socio (SOC_NUMERO, SOC_NOMBRE, SOC_APELLIDO, SOC_DIRECCION, SOC_TELEFONO)
VALUES (101, 'Juan', 'Pérez', 'Calle 123', '3001234567');

Actualizar registros:

UPDATE tbl_autor
SET AUT_MUERTE = '2020-08-15'
WHERE AUT_CODIGO = 765;

Eliminar registros:

DELETE FROM tbl_prestamo
WHERE PRES_ID = 'pres9';
2. Consultas básicas y filtros

Autores fallecidos:

SELECT *
FROM tbl_autor
WHERE AUT_MUERTE IS NOT NULL;

Buscar libros con una palabra en el título:

SELECT *
FROM tbl_libro
WHERE LIB_TITULO LIKE '%susurros%';

Autores nacidos entre fechas:

SELECT *
FROM tbl_autor
WHERE AUT_NACIMIENTO BETWEEN '1970-01-01' AND '1979-01-01';
3. Consultas usando JOIN y sin JOIN

Socios con préstamos sin JOIN:

SELECT s.SOC_NUMERO, s.SOC_NOMBRE, s.SOC_APELLIDO
FROM tbl_socio s, tbl_prestamo p
WHERE s.SOC_NUMERO = p.SOC_COPIANUMERO;

Autores que son traductores sin JOIN:

SELECT a.AUT_CODIGO, a.AUT_APELLIDO
FROM tbl_autor a, tbl_tipoautores t
WHERE a.AUT_CODIGO = t.COPIAUTOR
  AND t.TIPOAUTOR = 'traductor';

Socios con préstamos ordenados por apellido descendente (con JOIN):

SELECT s.SOC_NUMERO, s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_ID
FROM tbl_socio s
INNER JOIN tbl_prestamo p
  ON s.SOC_NUMERO = p.SOC_COPIANUMERO
ORDER BY s.SOC_APELLIDO DESC;

LEFT JOIN entre socio y préstamo:

SELECT s.SOC_NUMERO, s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_ID
FROM tbl_socio s
LEFT JOIN tbl_prestamo p
  ON s.SOC_NUMERO = p.SOC_COPIANUMERO;
4. Insertar registros desde Excel (forma gráfica)

Preparar los datos en Excel con los nombres exactos de columnas.

Guardar como CSV (delimitado por comas).

En phpMyAdmin o MySQL Workbench, ir a Importar → Elegir archivo CSV → Ejecutar.

Configurar delimitador (coma) y fila de encabezado si aplica.

Los datos se insertan automáticamente en la tabla.

💡 Esto permite manejar muchos registros de prueba sin escribir INSERTs manualmente.

5. Tips importantes

MySQL es sensible a mayúsculas en nombres de columnas/tablas según el sistema operativo.

Siempre verificar los nombres exactos usando:

DESCRIBE nombre_tabla;

Usar LIMIT para probar consultas con pocos resultados:

SELECT * FROM tbl_libro LIMIT 0, 25;