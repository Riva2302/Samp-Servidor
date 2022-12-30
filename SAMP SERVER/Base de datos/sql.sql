-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-08-2015 a las 07:48:56
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `pcu`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE IF NOT EXISTS `cuentas` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(24) NOT NULL,
  `Contra` varchar(120) NOT NULL,
  `Ropa` int(3) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Genero` int(11) NOT NULL,
  `Vida` float NOT NULL,
  `Chaleco` float NOT NULL,
  `Muertes` int(11) NOT NULL,
  `Asesinatos` int(11) NOT NULL,
  `Faccion` int(11) NOT NULL,
  `Rango` int(11) NOT NULL,
  `Trabajo` int(11) NOT NULL,
  `Dinero` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Edad` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`ID`, `Nombre`, `Contra`, `Ropa`, `X`, `Y`, `Z`, `Genero`, `Vida`, `Chaleco`, `Muertes`, `Asesinatos`, `Faccion`, `Rango`, `Trabajo`, `Dinero`, `Interior`, `VW`, `Edad`) VALUES
(1, 'demo', 'demo', 21, 0, 0, 0, 0, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Ethan_Weasel', '12345', 46, 632.484, -571.93, 16.336, 0, 100, 0, 0, 0, 0, 0, 0, 100000, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facciones`
--

CREATE TABLE IF NOT EXISTS `facciones` (
  `ID` int(11) NOT NULL,
  `Nombre` varchar(120) NOT NULL,
  `Rango1` varchar(100) NOT NULL,
  `Rango2` varchar(100) NOT NULL,
  `Rango3` varchar(100) NOT NULL,
  `Rango4` varchar(100) NOT NULL,
  `Rango5` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `facciones`
--

INSERT INTO `facciones` (`ID`, `Nombre`, `Rango1`, `Rango2`, `Rango3`, `Rango4`, `Rango5`) VALUES
(1, 'Departamento Policial', 'Cadete', 'Oficial', 'Teniente', 'Coronel', 'General');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
