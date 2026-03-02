-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-03-2026 a las 15:14:30
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
-- Base de datos: `ventas2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `contarProductosPorEstado` (IN `nombre_estado` VARCHAR(25), OUT `numero` INT)   BEGIN
    SELECT count(id) 
    INTO numero
    FROM productos
    WHERE estado = nombre_estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerProductosPorEstado` (IN `nombre_estado` VARCHAR(255))   SELECT * 
    FROM productos
    WHERE estado = nombre_estado$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pa_sumar` (IN `V1` INT, IN `V2` INT)   BEGIN
        DECLARE suma INT;
        SET suma=V1+V2;/*para modificar una variable utilizamos la palabra set 
set suma=V1+V2; */
        SELECT suma;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `venderProducto` (INOUT `beneficio` FLOAT, IN `id_producto` INT)   BEGIN
    # SELECT @incremento_precio = precio
    SELECT precio INTO @incremento_precio
    FROM productos
    WHERE id = id_producto;
    
    SET beneficio = beneficio + @incremento_precio;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'disponible',
  `precio` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `estado`, `precio`) VALUES
(1, 'Producto A', 'disponible', 8),
(2, 'Producto B', 'disponible', 1.5),
(3, 'Producto C', 'agotado', 80);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
