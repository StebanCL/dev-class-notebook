-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-03-2026 a las 17:04:27
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDatosSocio` (IN `socio_id` INT, IN `nueva_dir` VARCHAR(255), IN `nuevo_tel` VARCHAR(10))   BEGIN
    UPDATE tabla_socio 
    SET SOC_DIRECCION = nueva_dir, SOC_TELEFONO = nuevo_tel
    WHERE SOC_NUMERO = socio_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscarLibroPorNombre` (IN `nombre_buscar` VARCHAR(255))   BEGIN
    SELECT * FROM tabla_libro 
    WHERE LIB_TITULO LIKE CONCAT('%', nombre_buscar, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarLibro` (IN `isbn_borrar` BIGINT)   BEGIN
    -- Primero borraríamos dependencias si fuera necesario, 
    -- o simplemente intentar borrar el libro:
    DELETE FROM tabla_libro WHERE LIB_ISBN = isbn_borrar;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listaAutores` ()   BEGIN
    SELECT AUT_CODIGO, AUT_APELLIDO 
    FROM tabla_autor 
    ORDER BY AUT_APELLIDO DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipoAutor` (IN `variable` VARCHAR(20))   BEGIN
    SELECT a.AUT_APELLIDO AS 'Autor', t.TIPO_AUTOR
    FROM tabla_autor a
    INNER JOIN tabla_tipoautores t ON a.AUT_CODIGO = t.COPIA_AUTOR
    WHERE t.TIPO_AUTOR = variable;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarSocio` (IN `num` INT, IN `nom` VARCHAR(45), IN `ape` VARCHAR(45), IN `dir` VARCHAR(255), IN `tel` VARCHAR(10))   BEGIN
    INSERT INTO tabla_socio (SOC_NUMERO, SOC_NOMBRE, SOC_APELLIDO, SOC_DIRECCION, SOC_TELEFONO)
    VALUES (num, nom, ape, dir, tel);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_libro` (IN `c1_isbn` BIGINT(20), IN `c2_titulo` VARCHAR(255), IN `c3_genero` VARCHAR(20), IN `c4_paginas` INT, IN `c5_dias` TINYINT)   BEGIN
    INSERT INTO tabla_libro (LIB_ISBN, LIB_TITULO, LIB_GENERO, LIB_NUM_PAGINAS, LIB_DIAS_PRESTAMO)
    VALUES (c1_isbn, c2_titulo, c3_genero, c4_paginas, c5_dias);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `librosPrestadosConSocio` ()   BEGIN
    SELECT l.LIB_TITULO, s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_FECHA_PRESTAMO
    FROM tabla_libro l
    INNER JOIN tabla_prestamo p ON l.LIB_ISBN = p.LIB_COPIA_ISBN
    INNER JOIN tabla_socio s ON p.SOC_COPIA_NUMERO = s.SOC_NUMERO;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarSociosYPrestamos` ()   BEGIN
    SELECT s.SOC_NOMBRE, s.SOC_APELLIDO, p.PRES_ID, p.PRES_FECHA_PRESTAMO
    FROM tabla_socio s
    LEFT JOIN tabla_prestamo p ON s.SOC_NUMERO = p.SOC_COPIA_NUMERO;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `diasDePrestamo` (`isbn_libro` BIGINT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(PRES_FECHA_DEVOLUCION, PRES_FECHA_PRESTAMO) INTO dias
    FROM tabla_prestamo
    WHERE LIB_COPIA_ISBN = isbn_libro
    LIMIT 1; -- Limitamos a 1 por si el libro se prestó varias veces
    RETURN dias;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalSocios` () RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM tabla_socio;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_autor`
--

CREATE TABLE `tabla_autor` (
  `AUT_CODIGO` int(11) NOT NULL,
  `AUT_APELLIDO` varchar(45) NOT NULL,
  `AUT_NACIMIENTO` date NOT NULL,
  `AUT_MUERTE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tabla_autor`
--

INSERT INTO `tabla_autor` (`AUT_CODIGO`, `AUT_APELLIDO`, `AUT_NACIMIENTO`, `AUT_MUERTE`) VALUES
(98, 'Smith', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'Wilson', '1975-08-29', '0000-00-00'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'García', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '2020-05-10'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_libro`
--

CREATE TABLE `tabla_libro` (
  `LIB_ISBN` bigint(20) NOT NULL,
  `LIB_TITULO` varchar(255) NOT NULL,
  `LIB_GENERO` varchar(20) NOT NULL,
  `LIB_NUM_PAGINAS` int(11) NOT NULL,
  `LIB_DIAS_PRESTAMO` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tabla_libro`
--

INSERT INTO `tabla_libro` (`LIB_ISBN`, `LIB_TITULO`, `LIB_GENERO`, `LIB_NUM_PAGINAS`, `LIB_DIAS_PRESTAMO`) VALUES
(111222333, 'Nuevo Libro', 'Aventura', 350, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', 156, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_prestamo`
--

CREATE TABLE `tabla_prestamo` (
  `PRES_ID` varchar(20) NOT NULL,
  `PRES_FECHA_PRESTAMO` date NOT NULL,
  `PRES_FECHA_DEVOLUCION` date NOT NULL,
  `SOC_COPIA_NUMERO` int(11) NOT NULL,
  `LIB_COPIA_ISBN` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tabla_prestamo`
--

INSERT INTO `tabla_prestamo` (`PRES_ID`, `PRES_FECHA_PRESTAMO`, `PRES_FECHA_DEVOLUCION`, `SOC_COPIA_NUMERO`, `LIB_COPIA_ISBN`) VALUES
('pres1', '2023-01-15', '2023-01-20', 1, NULL),
('pres2', '2023-02-03', '2023-02-04', 2, 9999999999),
('pres3', '2023-04-09', '2023-04-11', 6, 2718281828),
('pres4', '2023-06-14', '2023-06-15', 9, 8888888888),
('pres5', '2023-07-02', '2023-07-09', 10, 5555555555),
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2023-10-27', 3, 1357924680),
('pres8', '2023-11-11', '2023-11-12', 4, 9999999999);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_socio`
--

CREATE TABLE `tabla_socio` (
  `SOC_NUMERO` int(11) NOT NULL,
  `SOC_NOMBRE` varchar(45) NOT NULL,
  `SOC_APELLIDO` varchar(45) NOT NULL,
  `SOC_DIRECCION` varchar(255) NOT NULL,
  `SOC_TELEFONO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tabla_socio`
--

INSERT INTO `tabla_socio` (`SOC_NUMERO`, `SOC_NOMBRE`, `SOC_APELLIDO`, `SOC_DIRECCION`, `SOC_TELEFONO`) VALUES
(1, 'Ana', 'Ruiz', 'Nueva Avenida 456', '999888777'),
(2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, 'Juan', 'González', 'Calle Principal 789, Villa Flores, Valencia', '2012345678'),
(4, 'María', 'Rodríguez', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(5, 'Pedro', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812'),
(6, 'Ana', 'López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456781'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781'),
(8, 'Laura', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofía', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678'),
(13, 'Pedro', 'Páramo', 'Calle Falsa 123', '5551234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tabla_tipoautores`
--

CREATE TABLE `tabla_tipoautores` (
  `COPIA_ISBN` bigint(20) DEFAULT NULL,
  `COPIA_AUTOR` int(11) NOT NULL,
  `TIPO_AUTOR` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tabla_tipoautores`
--

INSERT INTO `tabla_tipoautores` (`COPIA_ISBN`, `COPIA_AUTOR`, `TIPO_AUTOR`) VALUES
(1357924680, 123, 'Traductor'),
(NULL, 123, 'Autor'),
(NULL, 456, 'Coautor'),
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(NULL, 890, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tabla_autor`
--
ALTER TABLE `tabla_autor`
  ADD PRIMARY KEY (`AUT_CODIGO`);

--
-- Indices de la tabla `tabla_libro`
--
ALTER TABLE `tabla_libro`
  ADD PRIMARY KEY (`LIB_ISBN`);

--
-- Indices de la tabla `tabla_prestamo`
--
ALTER TABLE `tabla_prestamo`
  ADD PRIMARY KEY (`PRES_ID`),
  ADD KEY `SOC_COPIA_NUMERO` (`SOC_COPIA_NUMERO`),
  ADD KEY `LIB_COPIA_ISBN` (`LIB_COPIA_ISBN`);

--
-- Indices de la tabla `tabla_socio`
--
ALTER TABLE `tabla_socio`
  ADD PRIMARY KEY (`SOC_NUMERO`);

--
-- Indices de la tabla `tabla_tipoautores`
--
ALTER TABLE `tabla_tipoautores`
  ADD KEY `COPIA_ISBN` (`COPIA_ISBN`),
  ADD KEY `COPIA_AUTOR` (`COPIA_AUTOR`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tabla_prestamo`
--
ALTER TABLE `tabla_prestamo`
  ADD CONSTRAINT `tabla_prestamo_ibfk_1` FOREIGN KEY (`SOC_COPIA_NUMERO`) REFERENCES `tabla_socio` (`SOC_NUMERO`),
  ADD CONSTRAINT `tabla_prestamo_ibfk_2` FOREIGN KEY (`LIB_COPIA_ISBN`) REFERENCES `tabla_libro` (`LIB_ISBN`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `tabla_tipoautores`
--
ALTER TABLE `tabla_tipoautores`
  ADD CONSTRAINT `tabla_tipoautores_ibfk_1` FOREIGN KEY (`COPIA_ISBN`) REFERENCES `tabla_libro` (`LIB_ISBN`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `tabla_tipoautores_ibfk_2` FOREIGN KEY (`COPIA_AUTOR`) REFERENCES `tabla_autor` (`AUT_CODIGO`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
