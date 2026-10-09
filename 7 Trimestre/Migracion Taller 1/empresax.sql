-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-10-2026 a las 18:27:20
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
-- Base de datos: `empresax`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL,
  `cliente` varchar(60) DEFAULT NULL,
  `docCliente` varchar(20) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idCliente`, `cliente`, `docCliente`, `telefono`, `direccion`) VALUES
(1, 'Pedro Ruiz', '83125634', '3105629878', 'Calle 129 # 96-45\r'),
(2, 'Carlos Fonseca', '83145741', '3214569874', 'Calle 95 # 123 - 47\r'),
(3, 'Juan Gala', '92475896', '3134789563', 'Carrera 95 # 45-87\r'),
(4, 'Sofia Triana', '52748658', '3104568974', 'Transversa 98 # 45-65\r'),
(5, 'Andrea Claro', '25978254', '3124785965', 'Diagonal 93 # 95-47\r'),
(6, 'Julian Venegas', '27865412', '3014789562', 'Calle 93 # 47-58\r'),
(7, 'Humberto Fonseca', '42156478', '3024859678', 'Calle 127 # 47-65\r'),
(8, 'Catalina Huertas', '25412695', '3051236578', 'Carrera 52 # 125-41\r'),
(9, 'Pablo Ruiz', '28698452', '3014569852', 'Carrera 52 # 54-62\r'),
(10, 'Andres Castro', '80157062', '3125478962', 'Diagonal 12 # 41-65\r'),
(11, 'Luciana Fernandez', '52654789', '3052149687', 'Carrera 12 # 125-32\r'),
(12, 'Johanna Lozano', '25684963', '3105263478', 'Calle 93 # 145-21\r'),
(13, 'Benjamin Perez', '80145967', '3125268547', 'Carrera 49 # 123-12\r'),
(14, 'Mario Mejia', '102354745', '3014567895', 'Carera 50 # 41-62\r'),
(15, 'Blanca Pedraza', '23478523', '3125478251', 'Carrera 53 # 7 -12\r'),
(16, 'Rodrigo Blanco', '52365892', '3105248569', 'Carrera 98 # 14-54\r'),
(17, 'Carlos Castro', '52412365', '3052148569', 'Carrera 94 # 125-63\r'),
(18, 'Cecilia Lara', '102547865', '3112145761', 'Calle 14 # 125-63\r'),
(19, 'Juan Carlos Benavides', '103524563', '3154236987', 'Diagona 14 # 145-32\r'),
(20, 'Rodrigo Diaz', '83256841', '3215698574', 'Calle 125 # 14-52\r'),
(21, 'Pedro Perez', '96245875', '3125236985', 'Carrera 128 # 14-25\r'),
(22, 'Monica Alvarado', '96258741', '3012567489', 'Carrera 12 #123-62\r'),
(23, 'Paola Naranjo', '3214542', '3112857496', 'Diagonal 32 # 14-52\r'),
(24, 'Uriel Padilla', '52145328', '3155213698', 'Carrera 39 # 12-63\r'),
(25, 'Oscar Vino', '109654753', '3051478542', 'Calle 78 # 12-52\r'),
(26, 'Marcos Granada', '79582145', '3062145263', 'Calle 1 # 52-41\r'),
(27, 'Juliana Pardo', '4125689', '3012536854', 'Transversa 94 # 123-52\r'),
(28, 'Andres Aldana', '108245369', '3014521412', 'Carrera 41 # 21-63\r'),
(29, 'Jhonatan Salinas', '74214563', '3052145211', 'Avenida 68 # 52-32\r'),
(30, 'Camila Lozada', '108524122', '3062124563', 'Carrera 45 # 63-21\r');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`idPedido`, `idCliente`, `idproducto`, `cantidad`, `fecha`) VALUES
(1, 3, 5, 1, '2020-03-04'),
(2, 3, 3, 2, '2020-05-04'),
(3, 3, 1, 5, '2020-05-04'),
(4, 3, 2, 1, '2020-05-04'),
(5, 6, 10, 10, '2020-04-08'),
(6, 6, 6, 2, '2020-04-08'),
(7, 6, 7, 2, '2020-04-08'),
(8, 6, 8, 1, '2020-04-08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idProducto` int(11) NOT NULL,
  `producto` varchar(30) DEFAULT NULL,
  `marca` varchar(15) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idProducto`, `producto`, `marca`, `precio`) VALUES
(1, 'Cuaderno 100 hojas', 'norma', 6500),
(2, 'Cuaderno 80 hojas', 'norma', 5000),
(3, 'Cuaderno 50 hojas', 'norma', 4000),
(4, 'Regla 30 cm', 'scribe', 500),
(5, 'Borrador Nata', 'scribe', 300),
(6, 'Lapiz No 2 Negro', 'norma', 350),
(7, 'Lapiz Rojo', 'norma', 350),
(8, 'Colores x 12', 'scribe', 12500),
(9, 'Plastilina', 'norma', 3000),
(10, 'Temperas x 6', 'colorcitos', 8000),
(11, 'Vinilo Rojo', 'colorcitos', 1200),
(12, 'Vinilo Azul', 'colorcitos', 1200),
(13, 'Vinilo Verde', 'colorcitos', 1200),
(14, 'Vinilo Blanco', 'colorcitos', 1200),
(15, 'Vinilo Negro', 'colorcitos', 1200),
(16, 'Papel Iris x joja', 'kyoto', 100),
(17, 'Papel bond x hoja', 'kyoto', 100);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `fk_cliente` (`idCliente`),
  ADD KEY `fk_producto` (`idproducto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idProducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`),
  ADD CONSTRAINT `fk_producto` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idProducto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
