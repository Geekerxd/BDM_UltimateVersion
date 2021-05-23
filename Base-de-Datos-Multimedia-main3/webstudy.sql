-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2021 at 01:10 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webstudy`
--

DELIMITER $$


-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idCat` int(11) NOT NULL,
  `nombreCat` varchar(80) NOT NULL,
  `descripcionCat` varchar(1000) DEFAULT NULL,
  `fotoCat` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categoria`
--


-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `idChat` int(11) NOT NULL,
  `inactivo` bit(1) DEFAULT b'0',
  `idUsuario1` int(11) NOT NULL,
  `idUsuario2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chat`
--


-- --------------------------------------------------------

--
-- Table structure for table `comentariosencursos`
--

CREATE TABLE `comentariosencursos` (
  `idEstudianteComentCurso` int(11) NOT NULL,
  `idCursoComent` int(11) NOT NULL,
  `comentarioEnCurso` varchar(5000) NOT NULL,
  `fechaComentCurso` timestamp NOT NULL DEFAULT current_timestamp(),
  `valoracionComent` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `comentariosencursos`
--


--
-- Triggers `comentariosencursos`
--

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `curso`
--

CREATE TABLE IF NOT EXISTS `curso` (
  `idCurso` int(11) NOT NULL,
  `nombreCurso` varchar(80) NOT NULL,
  `descripcionCurso` varchar(1000) DEFAULT NULL,
  `descCortaCurso` varchar(200) DEFAULT NULL,
  `costo` float NOT NULL,
  `videoCurso` blob DEFAULT NULL,
  `fotoCurso` blob DEFAULT NULL,
  `valoracion` float DEFAULT 0,
  `ventasTotales` float DEFAULT 0,
  `idUsuarioCreador` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `curso`
--


-- --------------------------------------------------------

--
-- Table structure for table `estudiantescursando`
--

CREATE TABLE  IF NOT EXISTS `estudiantescursando` (
  `idEstudiante` int(11) NOT NULL,
  `idCursoCursado` int(11) NOT NULL,
  `idMaestro` int(11) NOT NULL,
  `nivelCursado` int(11) DEFAULT 1,
  `cursoFinalizado` bit(1) DEFAULT b'0',
  `fechaInicioCurso` timestamp NULL DEFAULT current_timestamp(),
  `fechaFinalCurso` timestamp NULL DEFAULT NULL,
  `ultimoNivel` bit(1) DEFAULT b'0',
  `progreso` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `estudiantescursando`
--


--
-- Triggers `estudiantescursando`
--
DELIMITER $$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mensajechat`
--

CREATE TABLE `mensajechat` (
  `numMensaje` bigint(20) NOT NULL,
  `idChatMensajes` int(11) NOT NULL,
  `esIdUsuario1` bit(1) DEFAULT b'0',
  `esIdUsuario2` bit(1) DEFAULT b'0',
  `mensaje` varchar(1000) NOT NULL,
  `fechaMensajeChat` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mensajechat`
--


-- --------------------------------------------------------

--
-- Table structure for table `nivel`
--

CREATE TABLE `nivel` (
  `idNivel` int(11) NOT NULL,
  `nombreNivel` varchar(80) NOT NULL,
  `descripcionNivel` varchar(1000) DEFAULT NULL,
  `fotoNivel` blob DEFAULT NULL,
  `videoNivel` blob DEFAULT NULL,
  `archivoNivel` blob DEFAULT NULL,
  `idCursoNivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nivel`
--

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `rol` varchar(15) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `apellidoPat` varchar(80) NOT NULL,
  `apellidoMat` varchar(80) NOT NULL,
  `contrasena` varchar(16) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `foto` blob DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuario`
--


-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_categorias`
-- (See below for the actual view)
--
CREATE TABLE `vw_categorias` (
`idCat1` int(11)
,`nombreCat1` varchar(80)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_costocursos`
-- (See below for the actual view)
--
CREATE TABLE `vw_costocursos` (
`precio` float
,`idCurso1` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_cursoscursados`
-- (See below for the actual view)
--
CREATE TABLE `vw_cursoscursados` (
`idEstudiante` int(11)
,`nombreCurso` varchar(80)
,`fechaFinalCurso` timestamp
,`nombreUsuario` varchar(80)
,`apellidoPatUser` varchar(80)
,`apellidoMatUser` varchar(80)
,`idCursoCursado` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_categorias`
--
DROP TABLE IF EXISTS `vw_categorias`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_categorias`  AS SELECT `categoria`.`idCat` AS `idCat1`, `categoria`.`nombreCat` AS `nombreCat1` FROM `categoria` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_costocursos`
--
DROP TABLE IF EXISTS `vw_costocursos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_costocursos`  AS SELECT `c`.`costo` AS `precio`, `c`.`idCurso` AS `idCurso1` FROM (`estudiantescursando` `e` join `curso` `c` on(`c`.`idCurso` = `e`.`idCursoCursado`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_cursoscursados`
--
DROP TABLE IF EXISTS `vw_cursoscursados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_cursoscursados`  AS SELECT `e`.`idEstudiante` AS `idEstudiante`, `c`.`nombreCurso` AS `nombreCurso`, `e`.`fechaFinalCurso` AS `fechaFinalCurso`, `u`.`nombre` AS `nombreUsuario`, `u`.`apellidoPat` AS `apellidoPatUser`, `u`.`apellidoMat` AS `apellidoMatUser`, `e`.`idCursoCursado` AS `idCursoCursado` FROM ((`estudiantescursando` `e` join `curso` `c` on(`c`.`idCurso` = `e`.`idCursoCursado`)) join `usuario` `u` on(`u`.`id` = `e`.`idMaestro`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCat`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`idChat`),
  ADD KEY `idUsuario1` (`idUsuario1`),
  ADD KEY `idUsuario2` (`idUsuario2`);

--
-- Indexes for table `comentariosencursos`
--
ALTER TABLE `comentariosencursos`
  ADD PRIMARY KEY (`idEstudianteComentCurso`,`idCursoComent`),
  ADD KEY `idCursoComent` (`idCursoComent`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`idCurso`),
  ADD KEY `idUsuarioCreador` (`idUsuarioCreador`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indexes for table `estudiantescursando`
--
ALTER TABLE `estudiantescursando`
  ADD PRIMARY KEY (`idEstudiante`,`idCursoCursado`),
  ADD KEY `idCursoCursado` (`idCursoCursado`),
  ADD KEY `idMaestro` (`idMaestro`);

--
-- Indexes for table `mensajechat`
--
ALTER TABLE `mensajechat`
  ADD PRIMARY KEY (`numMensaje`),
  ADD KEY `idChatMensajes` (`idChatMensajes`);

--
-- Indexes for table `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`idNivel`),
  ADD KEY `idCursoNivel` (`idCursoNivel`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `idChat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `idCurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mensajechat`
--
ALTER TABLE `mensajechat`
  MODIFY `numMensaje` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nivel`
--
ALTER TABLE `nivel`
  MODIFY `idNivel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`idUsuario1`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`idUsuario2`) REFERENCES `usuario` (`id`);

--
-- Constraints for table `comentariosencursos`
--
ALTER TABLE `comentariosencursos`
  ADD CONSTRAINT `comentariosencursos_ibfk_1` FOREIGN KEY (`idEstudianteComentCurso`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `comentariosencursos_ibfk_2` FOREIGN KEY (`idCursoComent`) REFERENCES `curso` (`idCurso`);

--
-- Constraints for table `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`idUsuarioCreador`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCat`);

--
-- Constraints for table `estudiantescursando`
--
ALTER TABLE `estudiantescursando`
  ADD CONSTRAINT `estudiantescursando_ibfk_1` FOREIGN KEY (`idEstudiante`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `estudiantescursando_ibfk_2` FOREIGN KEY (`idCursoCursado`) REFERENCES `curso` (`idCurso`),
  ADD CONSTRAINT `estudiantescursando_ibfk_3` FOREIGN KEY (`idMaestro`) REFERENCES `curso` (`idUsuarioCreador`);

--
-- Constraints for table `mensajechat`
--
ALTER TABLE `mensajechat`
  ADD CONSTRAINT `mensajechat_ibfk_1` FOREIGN KEY (`idChatMensajes`) REFERENCES `chat` (`idChat`);

--
-- Constraints for table `nivel`
--
ALTER TABLE `nivel`
  ADD CONSTRAINT `nivel_ibfk_1` FOREIGN KEY (`idCursoNivel`) REFERENCES `curso` (`idCurso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
