-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2021 at 12:05 AM
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
-- Database: `quoschooldb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Categorias` (`p_opc` CHAR, `p_nom` VARCHAR(60))  BEGIN
	IF p_opc='a' THEN
		SELECT	Nombre
        FROM Categoria;
	ELSEIF p_opc='b' THEN
		INSERT INTO Categoria (Nombre)
        VALUES (p_nom);
	END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Comentario` (`p_opc` CHAR, `p_curso` VARCHAR(60), `p_correo` VARCHAR(60), `p_contra` VARCHAR(60), `p_cont` VARCHAR(500), `p_cal` TINYINT)  BEGIN
DECLARE p_id_c	INT;
DECLARE p_id_u	INT;

	IF p_opc='a' THEN
		SELECT ID_Curso
        INTO p_id_c
        FROM curso
        WHERE Nombre_Curso = p_curso;
        
        SELECT ID_User
        INTO p_id_u
        FROM usuario
        WHERE Correo = p_correo AND Contraseña = p_contra;
        
		UPDATE historial
		SET
		Comentario = p_cont, Calificación = p_cal
		WHERE ID_User = p_id_u AND ID_Curso = p_id_c;

        
	ELSEIF p_opc='b' THEN  
		SELECT ID_Curso
        INTO p_id_c
        FROM curso
        WHERE Nombre_Curso = p_curso;
        
        SELECT ID_User
        INTO p_id_u
        FROM usuario
        WHERE Correo = p_correo AND Contraseña = p_contra;
        
		SELECT H.Comentario, H.Calificación, U.Nombre, U.Apellidos, U.Foto_usuario
        FROM historial H
        JOIN usuario U
		ON U.ID_User = H.ID_User
        JOIN curso C
		ON C.ID_Curso = H.ID_Curso
        WHERE  H.ID_Curso = p_id_c;
        
	ELSEIF p_opc='c' THEN 
        SELECT ID_Curso
        INTO p_id_c
        FROM curso
        WHERE Nombre_Curso = p_curso;
        
        SELECT ID_User
        INTO p_id_u
        FROM usuario
        WHERE Correo = p_correo AND Contraseña = p_contra;
        INSERT INTO historial(ID_User,ID_Curso,Calificación) VALUES (p_id_u, p_id_c,0);
        
	END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Curso` (`p_opc` CHAR, `p_nom` VARCHAR(60), `p_desc` TEXT, `p_prom` TINYINT, `p_pre` DOUBLE, `p_foto` BLOB, `p_correo` VARCHAR(100), `p_contra` VARCHAR(20))  BEGIN
DECLARE p_id_u	INT;

	IF p_opc='a' THEN
		SELECT Nombre_Curso, Descripción, Promedio, Precio, Foto_curso, ID_User
        FROM Curso;
	ELSEIF p_opc='b' THEN
		SELECT*FROM curso;

    ELSEIF p_opc='c' THEN
		SELECT * FROM v_Cursos_Promedio;
        
	ELSEIF p_opc='d' THEN
		SELECT * FROM v_Cursos_Mas_Vendidos;
        
	ELSEIF p_opc='e' THEN
		SELECT * FROM v_Cursos_Fecha;
        
	ELSEIF p_opc='f' THEN
		SELECT CU.Nombre_Curso, CU.Descripción, CU.Promedio, CU.Precio, CU.Foto_curso, CU.ID_User, DATE_FORMAT(CU.Fecha_alta,'%Y-%m-%d %T') AS Fecha, CA.Nombre AS Categoria, U.Nombre, U.Apellidos, count(N.ID_Nivel) "Niveles"
		FROM curso CU
		JOIN curso_categoria CC
		ON CC.ID_Curso = CU.ID_Curso
		JOIN categoria CA
		ON CC.ID_Categoría = CA.ID_Categoría
		JOIN usuario U
		ON  U.ID_User = CU.ID_User
		JOIN nivel N
        ON N.ID_Curso = CU.ID_Curso
        WHERE CU.Nombre_Curso = p_nom
		GROUP BY CU.Nombre_Curso;
        
        ELSEIF p_opc='g' THEN
			SELECT CU.Nombre_Curso, CU.Descripción, CU.Promedio, CU.Precio, CU.Foto_curso, CU.ID_User, DATE_FORMAT(CU.Fecha_alta,'%Y-%m-%d %T') AS Fecha, CA.Nombre AS Categoria
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN categoria CA
			ON CC.ID_Categoría = CA.ID_Categoría AND CA.Nombre = p_nom
			ORDER BY CA.Nombre DESC;
            
		ELSEIF p_opc='h' THEN
			SELECT CU.Nombre_Curso, CU.Descripción, CU.Promedio, CU.Precio, CU.Foto_curso, CU.ID_User, DATE_FORMAT(CU.Fecha_alta,'%Y-%m-%d %T') AS Fecha, CA.Nombre AS Categoria, U.Nombre, U.Apellidos
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN categoria CA
			ON CC.ID_Categoría = CA.ID_Categoría
			JOIN usuario U
			ON U.ID_User = CU.ID_User
            WHERE CU.Nombre_Curso LIKE CONCAT('%',p_correo,'%') OR CONCAT(U.Nombre,' ',U.Apellidos ) LIKE CONCAT('%',p_correo,'%')
			ORDER BY  CU.Nombre_Curso asc;
            
		ELSEIF p_opc='i' THEN
            SELECT CU.Nombre_Curso, CU.Foto_curso, CU.ID_User, CA.Nombre AS Categoria, H.Progreso, H.Certificado, DATE_FORMAT(H.Fecha_Inicio,'%Y-%m-%d %T') AS Fecha_Inicio, DATE_FORMAT(H.Fecha_Fin,'%Y-%m-%d') AS Fecha_Fin
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN categoria CA
			ON CC.ID_Categoría = CA.ID_Categoría
			JOIN Historial H
			ON H.ID_Curso = CU.ID_Curso
			JOIN usuario U
			ON U.ID_User = H.ID_User
			WHERE U.Correo = p_nom
			ORDER BY H.Fecha_Inicio DESC;
            
		ELSEIF p_opc='j' THEN
			SELECT CU.Nombre_Curso, CU.Foto_curso, CU.ID_User, CA.Nombre AS Categoria, H.Progreso, H.Certificado, DATE_FORMAT(H.Fecha_Inicio,'%Y-%m-%d %T') AS Fecha_Inicio, DATE_FORMAT(H.Fecha_Fin,'%Y-%m-%d') AS Fecha_Fin, P.Nombre, P.Apellidos
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN categoria CA
			ON CC.ID_Categoría = CA.ID_Categoría
			JOIN Historial H
			ON H.ID_Curso = CU.ID_Curso
			JOIN usuario U
			ON U.ID_User = H.ID_User
            JOIN usuario P
			ON P.ID_User = CU.ID_User
			WHERE U.Correo = p_nom
            GROUP BY P.ID_User
			ORDER BY H.Fecha_Inicio DESC;
            
		ELSEIF p_opc='k' THEN
			SELECT CU.Nombre_Curso, CU.Foto_curso, CU.ID_User, CA.Nombre AS Categoria, H.Progreso, H.Certificado, DATE_FORMAT(H.Fecha_Inicio,'%Y-%m-%d %T') AS Fecha_Inicio, DATE_FORMAT(H.Fecha_Fin,'%Y-%m-%d') AS Fecha_Fin, P.Nombre, P.Apellidos
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN categoria CA
			ON CC.ID_Categoría = CA.ID_Categoría
			JOIN Historial H
			ON H.ID_Curso = CU.ID_Curso
			JOIN usuario U
			ON U.ID_User = CU.ID_User
            JOIN usuario P
			ON P.ID_User = H.ID_User
			WHERE U.Correo = p_nom
            GROUP BY P.ID_User
			ORDER BY P.ID_User DESC;
		
        ELSEIF p_opc='l' THEN
			SELECT CU.Nombre_Curso, CU.Foto_curso, CU.ID_User, CU.Fecha_alta
			FROM curso CU
			JOIN curso_categoria CC
			ON CC.ID_Curso = CU.ID_Curso
			JOIN usuario U
			ON U.ID_User = CU.ID_User
			WHERE U.Correo = p_nom;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CursoCategorias` (`p_opc` CHAR, `p_nom` VARCHAR(60), `p_desc` TEXT, `p_pre` DOUBLE, `p_foto` BLOB, `p_correo` VARCHAR(60), `p_contra` VARCHAR(60), `p_categoria` VARCHAR(60), `p_niv` TINYINT)  BEGIN
DECLARE p_id_u	INT;
DECLARE p_id_cu	INT;
DECLARE p_id_ca	INT;

	IF p_opc='a' THEN
		SELECT usuario_function(p_correo, p_contra) INTO p_id_u;
        INSERT INTO Curso(Nombre_Curso, Descripción, Precio, Foto_curso, ID_User) VALUES (p_nom, p_desc, p_pre, p_foto,p_id_u);
        SELECT curso_function(p_nom) INTO p_id_cu;
        SELECT categoria_function(p_categoria) INTO p_id_ca;
        INSERT INTO curso_categoria(ID_Curso,ID_Categoría) VALUES(p_id_cu,p_id_ca);
		SELECT nivel_function(p_id_cu, p_niv);
        
        ELSEIF p_opc='b' THEN
			SELECT usuario_function(p_correo, p_contra) INTO p_id_u;
			SELECT curso_function(p_nom) INTO p_id_cu;
			SELECT Fecha_Fin FROM historial  WHERE ID_User = p_id_u AND ID_Curso = p_id_cu;
            
		ELSEIF p_opc='c' THEN
			SELECT usuario_function(p_correo, p_contra) INTO p_id_u;
			SELECT * FROM v_Historial_Ventas WHERE ID_User = p_id_u;
		ELSEIF p_opc='d' THEN
			SELECT usuario_function(p_correo, p_contra) INTO p_id_u;
			SELECT curso_function(p_nom) INTO p_id_cu;
			UPDATE historial
			SET Nivel_Actual = p_niv
			WHERE ID_User = p_id_u AND ID_Curso = p_id_cu;
            SELECT f_Progreso(p_id_u,p_id_cu,p_niv) INTO p_id_ca;
            UPDATE historial SET Progreso = p_id_ca WHERE ID_User = p_id_u AND ID_Curso = p_id_cu;
            
	END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Mensajes` (`p_opc` CHAR, `p_con` VARCHAR(250), `p_correo` VARCHAR(100), `p_contra` VARCHAR(20), `p_nombre` VARCHAR(60), `p_apellidos` VARCHAR(60))  BEGIN
	DECLARE p_id_u	INT;
    DECLARE p_id_r	INT;
	IF p_opc='a' THEN
		SELECT ID_User
        INTO p_id_r
        FROM Usuario
        WHERE Correo=p_correo AND Contraseña=p_contra;
        
        SELECT ID_User
        INTO p_id_u
        FROM Usuario
        WHERE Nombre = p_nombre AND Apellidos = p_apellidos;
        
		INSERT INTO mensajes (Contenido, ID_User, ID_Remitente)
		VALUES(p_con,p_id_u,p_id_r);
        
	ELSEIF p_opc='b' THEN
		SELECT ID_User
        INTO p_id_r
        FROM Usuario
        WHERE Correo=p_correo AND Contraseña=p_contra;
        
        SELECT ID_User
        INTO p_id_u
        FROM Usuario
        WHERE Nombre = p_nombre AND Apellidos = p_apellidos;
        
        SELECT M.Contenido, U.Nombre, U.Apellidos, U.Foto_usuario, DATE_FORMAT(M.Fecha_envio,'%Y-%m-%d %T') AS Fecha
        FROM mensajes M 
        JOIN usuario U
        ON U.ID_User = M.ID_Remitente
        WHERE M.ID_Remitente = p_id_r AND M.ID_User = p_id_u OR M.ID_Remitente = p_id_u AND M.ID_User = p_id_r
        ORDER BY M.Fecha_envio ASC;
	
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Nivel` (`p_opc` CHAR, `p_Desc` TEXT, `p_Prueba` BIT, `p_Vid` BLOB, `p_Img` BLOB, `p_Link` VARCHAR(250), `p_Doc` BLOB, `p_Num` TINYINT, `p_Nomb_c` VARCHAR(60), `p_upd_t` CHAR, `p_upd_add` CHAR)  BEGIN
DECLARE p_id_v	INT;
DECLARE p_id_c	INT;
DECLARE p_id_n	INT;

	IF p_opc='a' THEN
		SELECT Descripción, PruebaG
        FROM Nivel;
        
	ELSEIF p_opc='b' THEN
		INSERT INTO Videos(Video)
        VALUES(p_Vid);
        
        SELECT ID_Video
        INTO p_id_v
        FROM Videos
        WHERE Video = p_Vid;
        
        SELECT ID_Curso
        INTO p_id_c
        FROM curso
        WHERE Nombre_Curso = p_Nomb_c;
		
        UPDATE nivel
		SET
		Descripción = p_Desc,
		PruebaG = p_Prueba,
		ID_Video = p_id_v
		WHERE ID_Curso = p_id_c AND Numero_Niv = p_Num;

	
        SELECT ID_Nivel
        INTO p_id_n
        FROM Nivel
        WHERE ID_Curso = p_id_c AND Numero_Niv = p_Num;
        
        INSERT INTO Imagenes(Imagen,ID_Nivel)
        VALUES(p_Img,p_id_n);
        
        INSERT INTO Links(Contenido,ID_Nivel)
        VALUES(p_Link,p_id_n);
        
        INSERT INTO Documentacion(Contenido,ID_Nivel)
        VALUES(p_Doc,p_id_n);
        
	ELSEIF p_opc='c' THEN
		SELECT ID_Curso
        INTO p_id_c
        FROM curso
        WHERE Nombre_Curso = p_Nomb_c;
        
        SELECT ID_Nivel
        INTO p_id_n
        FROM Nivel
        WHERE p_Num=Numero_Niv AND ID_Curso=p_id_c;
        
        IF p_upd_t='a' THEN
			UPDATE Nivel
            SET Descripción=p_Desc
            WHERE ID_Nivel=p_id_n;
		ELSEIF p_upd_t='b' THEN
			SELECT ID_Video
			INTO p_id_v
			FROM Nivel
			WHERE p_Num=Numero_Niv AND ID_Curso=p_id_c;
            
			UPDATE Videos
            SET Video=p_Vid
            WHERE ID_Video=p_id_v;
            
		ELSEIF p_upd_t='c' THEN
			IF p_upd_add='a' THEN
				UPDATE Imagenes
                SET Imagen=p_Img
                WHERE ID_Nivel=p_id_n;
                
			ELSEIF p_upd_add='b' THEN
				INSERT INTO Imagenes(Imagen,ID_Nivel)
                VALUES(p_Img,p_id_n);
			END IF;
            
		ELSEIF p_upd_t='d' THEN
			IF p_upd_add='a' THEN
				UPDATE Links
                SET Contenido=p_Link
                WHERE ID_Nivel=p_id_n;
                
			ELSEIF p_upd_add='b' THEN
				INSERT INTO Links(Contenido,ID_Nivel)
                VALUES(p_Link,p_id_n);
			END IF;
            
		ELSEIF p_upd_t='e' THEN
			IF p_upd_add='a' THEN
				UPDATE Documentacion
                SET Contenido=p_Doc
                WHERE ID_Nivel=p_id_n;
                
			ELSEIF p_upd_add='b' THEN
				INSERT INTO Documentacion(Contenido,ID_Nivel)
                VALUES(p_Doc,p_id_n);
			END IF;
        END IF;
        
        ELSEIF p_opc='f' THEN
			SELECT curso_function(p_Nomb_c) INTO p_id_c;
			SELECT Numero_Niv FROM nivel N JOIN curso CU ON CU.ID_Curso = N.ID_Curso WHERE N.ID_Curso = p_id_c;
            
		ELSEIF p_opc='g' THEN
			SELECT ID_Curso
			INTO p_id_c
			FROM curso
			WHERE Nombre_Curso = p_Nomb_c;
            
            SELECT N.Descripción, N.PruebaG, N.Numero_Niv, V.Video, I.Imagen, D.Contenido AS Doc, L.Contenido AS Link
			FROM nivel N
			LEFT JOIN videos V
			ON N.ID_Video = V.ID_Video
			LEFT JOIN imagenes I
			ON N.ID_Nivel = I.ID_Nivel
			LEFT JOIN documentacion D
			ON N.ID_Nivel = D.ID_Nivel
			LEFT JOIN links L
			ON N.ID_Nivel = L.ID_Nivel
			WHERE N.ID_Curso = p_id_c;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SubCategorias` (`p_opc` CHAR, `p_nom` VARCHAR(60), `p_nomC` VARCHAR(60))  BEGIN
DECLARE p_id_c	INT;

	IF p_opc='a' THEN
		SELECT	Nombre
        FROM Subcategoria;
	ELSEIF p_opc='b' THEN  
		SELECT ID_Categoría
        INTO p_id_c
        FROM Categoria
        WHERE Nombre=p_nomC;
        
		INSERT INTO Subcategoria (Nombre,ID_Categoría)
        VALUES (p_nom,p_id_c);
	END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Usuario` (`p_opc` CHAR, `p_Nombre` VARCHAR(60), `p_Apellidos` VARCHAR(120), `p_Correo` VARCHAR(100), `p_Contra` VARCHAR(20), `p_Tipo` VARCHAR(30), `p_Foto` BLOB, `p_Descripcion` TEXT, `p_Contra2` VARCHAR(20))  BEGIN
	IF p_opc='a' THEN
		INSERT INTO Usuario(Nombre,Apellidos,Correo,Contraseña,Tipo_Usuario,Foto_usuario,Descripcion)
        VALUES	(p_Nombre,p_Apellidos,p_Correo,p_Contra,p_Tipo,p_Foto,p_Descripcion);
	ELSEIF p_opc='b' THEN
		UPDATE Usuario
        SET Nombre=p_Nombre,
			Apellidos=p_Apellidos,
            Contraseña=p_Contra2,
            Tipo_Usuario=p_Tipo,
            Foto_usuario=p_Foto,
            Descripcion=p_Descripcion
		WHERE Correo=p_Correo 
			AND Contraseña=p_Contra;
	ELSEIF p_opc='c' THEN
		DELETE FROM Usuario
		WHERE Correo=p_Correo 
			AND Contraseña=p_Contra;
	ELSEIF p_opc='d' THEN
		SELECT Nombre,Apellidos,Correo,Contraseña,DATE_FORMAT(Fecha_alta,'%Y-%m-%d') AS Fecha,Tipo_Usuario,Foto_usuario,Descripcion
        FROM Usuario
        WHERE Correo=p_Correo 
			AND Contraseña=p_Contra;
	END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `categoria_function` (`p_categoria` VARCHAR(60)) RETURNS INT(11) READS SQL DATA
    DETERMINISTIC
BEGIN

	DECLARE p_id_ca INT;
	SELECT ID_Categoría INTO p_id_ca FROM categoria WHERE Nombre = p_categoria;

RETURN p_id_ca;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `curso_function` (`p_nom` VARCHAR(60)) RETURNS INT(11) READS SQL DATA
    DETERMINISTIC
BEGIN

	DECLARE p_id_cu INT;
	SELECT ID_Curso INTO p_id_cu FROM curso WHERE Nombre_curso = p_nom;

RETURN p_id_cu;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `f_Progreso` (`p_id_u` INT, `p_id_cu` INT, `p_nivel` TINYINT) RETURNS TINYINT(4) BEGIN
	DECLARE p_total			TINYINT;
    DECLARE p_max			TINYINT;
    DECLARE p_per			float;
    
    
    SELECT Nivel_Maximo INTO p_max FROM historial WHERE ID_User = p_id_u AND ID_Curso = p_id_cu;
    
    SET p_per=(100/p_max)*p_nivel;
    
    SET p_total= p_per;
    
    return p_total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nivel_function` (`p_id_cu` INT, `p_niv` TINYINT) RETURNS INT(11) READS SQL DATA
    DETERMINISTIC
BEGIN
	declare v_counter int unsigned default 0;
	while v_counter < p_niv do
		INSERT INTO nivel
		(ID_Curso, Numero_Niv)
		VALUES(p_id_cu,v_counter);
		set v_counter=v_counter+1;
	end while;
    
RETURN 1;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `usuario_function` (`p_correo` VARCHAR(100), `p_contra` VARCHAR(20)) RETURNS INT(11) READS SQL DATA
    DETERMINISTIC
BEGIN

	DECLARE p_id_u INT;
	SELECT ID_User INTO	p_id_u FROM Usuario U WHERE U.Correo = p_correo AND U.Contraseña = p_contra;

RETURN p_id_u;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `ID_Categoría` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Categoria',
  `Nombre` varchar(60) DEFAULT NULL COMMENT 'En este campo se guardara el nombre de la categoria'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`ID_Categoría`, `Nombre`) VALUES
(1, 'Software'),
(2, 'Design'),
(3, 'Marketing'),
(4, 'Business');

-- --------------------------------------------------------

--
-- Table structure for table `curso`
--

CREATE TABLE `curso` (
  `ID_Curso` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Curso',
  `Nombre_Curso` varchar(100) DEFAULT NULL COMMENT 'Este campo guardara el nombre del curso',
  `Descripción` text DEFAULT NULL COMMENT 'Este campo guardara una descripción de lo ofrece el curso',
  `Precio` double UNSIGNED DEFAULT NULL COMMENT 'Este campo guardara el precio por el cual se vendera el curso a los usuarios',
  `Foto_curso` blob DEFAULT NULL COMMENT 'Este campo guardara una foto que se mostrará en la vista previa del curso',
  `ID_User` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Curso con la tabla Usuario',
  `Promedio` tinyint(3) UNSIGNED DEFAULT 0 COMMENT 'Este campo guardara el promedio de las calificaciones de los usuarios al curso',
  `Fecha_alta` timestamp NULL DEFAULT current_timestamp() COMMENT 'En este campo se guardara automaticamente la fecha en la que el usuario dio de alta el curso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `curso`
--

INSERT INTO `curso` (`ID_Curso`, `Nombre_Curso`, `Descripción`, `Precio`, `Foto_curso`, `ID_User`, `Promedio`, `Fecha_alta`) VALUES
(1, 'C++ Para Pricipiantes', 'Lorem ipsum dolor sit amet consectetur adipiscing elit sociis quisque quis, quam dictumst bibendum ac feugiat ultricies tempus posuere dictum, habitasse dis sodales cursus facilisi urna dapibus massa eleifend. Consequat conubia proin est torquent himenaeos facilisi praesent ultrices vulputate, inceptos ligula per porta facilisis diam montes. Porttitor montes ante venenatis cras nullam morbi, ligula volutpat dui pretium risus, eu vestibulum augue fringilla nostra.', 1.699, 0x4173736574732f315f70677174313138724a6339614b495850543336484a512e706e67, 2, 4, '2021-05-18 15:08:15'),
(2, 'C++ Avanzado', 'Lorem ipsum dolor sit amet consectetur adipiscing elit sociis quisque quis, quam dictumst bibendum ac feugiat ultricies tempus posuere dictum, habitasse dis sodales cursus facilisi urna dapibus massa eleifend. Consequat conubia proin est torquent himenaeos facilisi praesent ultrices vulputate, inceptos ligula per porta facilisis diam montes. Porttitor montes ante venenatis cras nullam morbi, ligula volutpat dui pretium risus, eu vestibulum augue fringilla nostra.', 1.699, 0x4173736574732f313331393737305f316238345f352e6a7067, 2, 3, '2021-05-18 15:13:34'),
(3, 'C++ Intermedio', 'Lorem ipsum dolor sit amet consectetur adipiscing elit sociis quisque quis, quam dictumst bibendum ac feugiat ultricies tempus posuere dictum, habitasse dis sodales cursus facilisi urna dapibus massa eleifend. Consequat conubia proin est torquent himenaeos facilisi praesent ultrices vulputate, inceptos ligula per porta facilisis diam montes. Porttitor montes ante venenatis cras nullam morbi, ligula volutpat dui pretium risus, eu vestibulum augue fringilla nostra.', 1.699, 0x4173736574732f63706c75732e6a7067, 4, 5, '2021-05-18 15:14:29'),
(4, 'Bases del C++', 'Lorem ipsum dolor sit amet consectetur adipiscing elit sociis quisque quis, quam dictumst bibendum ac feugiat ultricies tempus posuere dictum, habitasse dis sodales cursus facilisi urna dapibus massa eleifend. Consequat conubia proin est torquent himenaeos facilisi praesent ultrices vulputate, inceptos ligula per porta facilisis diam montes. Porttitor montes ante venenatis cras nullam morbi, ligula volutpat dui pretium risus, eu vestibulum augue fringilla nostra.', 1.699, 0x4173736574732f637572736f206465206370702e706e67, 4, 3, '2021-05-18 15:16:00'),
(29, 'Aprende a Dibujar', 'A', 500, 0x4173736574732f323233343132325f363863355f382e6a7067, 2, 3, '2021-05-24 07:55:03');

-- --------------------------------------------------------

--
-- Table structure for table `curso_categoria`
--

CREATE TABLE `curso_categoria` (
  `ID_CC` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Curso_Categoria',
  `ID_Curso` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Curso_Categoria con la tabla Curso',
  `ID_Categoría` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Curso_Categoria con la tabla Categoria'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `curso_categoria`
--

INSERT INTO `curso_categoria` (`ID_CC`, `ID_Curso`, `ID_Categoría`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(12, 29, 2);

-- --------------------------------------------------------

--
-- Table structure for table `documentacion`
--

CREATE TABLE `documentacion` (
  `ID_Documento` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Documentacion',
  `Contenido` blob DEFAULT NULL COMMENT 'En este campo se guardara el archivo binario del documento',
  `Tipo` enum('doc','txt','pptx','pdf') DEFAULT NULL COMMENT 'Este campo guarda el tipo de archivo del documento',
  `ID_Nivel` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Documentacion con la tabla Nivel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `documentacion`
--

INSERT INTO `documentacion` (`ID_Documento`, `Contenido`, `Tipo`, `ID_Nivel`) VALUES
(2, 0x4173736574732f30202d205048502e706466, NULL, 16),
(3, NULL, NULL, NULL),
(5, 0x4173736574732f30202d205048502e706466, NULL, 17),
(6, 0x4173736574732f30202d205048502e706466, NULL, 15);

-- --------------------------------------------------------

--
-- Table structure for table `historial`
--

CREATE TABLE `historial` (
  `ID_Historial` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Historial',
  `ID_User` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Historial con la tabla Usuario',
  `ID_Curso` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Historial con la tabla Curso',
  `Comentario` text DEFAULT NULL COMMENT 'En este campo se guardara el comentario realizado al curso por parte del usuario que lo esta cursando',
  `Calificación` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'Este campo guardara la puntuacion que el usuario le dio al curso',
  `Fecha_Inicio` timestamp NULL DEFAULT current_timestamp() COMMENT 'Este campo guardara la fecha de inicio del curso, se llenara automaticamente',
  `Fecha_Fin` datetime DEFAULT NULL COMMENT 'Este campo guardara la fecha de finalización del curso',
  `Certificado` bit(1) DEFAULT NULL COMMENT 'Este campo guardara si el curso a sido completado con un 1 o si todavía no se completa con un 0',
  `Progreso` tinyint(3) UNSIGNED DEFAULT 0 COMMENT 'Este campo guardara el progreso del alumno en el curso',
  `Nivel_Actual` tinyint(3) UNSIGNED DEFAULT 0,
  `Nivel_Maximo` tinyint(3) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `historial`
--

INSERT INTO `historial` (`ID_Historial`, `ID_User`, `ID_Curso`, `Comentario`, `Calificación`, `Fecha_Inicio`, `Fecha_Fin`, `Certificado`, `Progreso`, `Nivel_Actual`, `Nivel_Maximo`) VALUES
(1, 1, 1, 'bien', 5, '2021-05-19 00:28:52', NULL, b'0', 30, 0, 0),
(2, 1, 2, 'algo', 5, '2021-05-19 01:07:46', '2021-05-25 00:00:00', b'1', 100, 0, 0),
(3, 1, 3, 'Creo que bien', 3, '2021-05-19 01:07:52', NULL, b'1', 100, 0, 0),
(4, 1, 4, 'me gusto mucho', 4, '2021-05-19 01:07:58', NULL, b'1', 100, 0, 0),
(5, 3, 4, 'muy bueno', 5, '2021-05-21 02:03:44', NULL, b'0', 50, 0, 0),
(6, 5, 1, 'Meh', 3, '2021-05-22 03:52:04', NULL, b'1', 100, 0, 0),
(7, 5, 3, NULL, NULL, '2021-05-22 03:54:23', NULL, NULL, 0, 0, 0),
(8, 5, 4, NULL, NULL, '2021-05-22 03:56:40', NULL, NULL, 0, 0, 0),
(9, 5, 4, NULL, NULL, '2021-05-22 03:57:27', NULL, NULL, 0, 0, 0),
(10, 3, 3, NULL, NULL, '2021-05-22 05:06:10', NULL, NULL, 0, 0, 0),
(11, 3, 29, 'ok', 1, '2021-05-24 17:55:45', NULL, NULL, 0, 1, 0),
(12, 1, 29, 'bien', 3, '2021-05-25 06:52:27', NULL, NULL, 0, 0, 0),
(13, 5, 29, 'Me gusto mucho', 5, '2021-05-25 15:43:50', NULL, b'1', 100, 3, 3),
(14, 8, 29, 'Excelente', 5, '2021-05-25 17:15:28', NULL, b'1', 100, 3, 3),
(15, 8, 2, 'Meh', 1, '2021-05-25 17:28:02', NULL, b'1', 100, 0, 0);

--
-- Triggers `historial`
--
DELIMITER $$
CREATE TRIGGER `t_` BEFORE UPDATE ON `historial` FOR EACH ROW BEGIN

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `t_Historial_update` BEFORE UPDATE ON `historial` FOR EACH ROW BEGIN
DECLARE p_prom TINYINT;
	IF NEW.Calificación IS NOT NULL THEN
		SELECT avg(Calificación)
        INTO p_prom
        FROM Historial
        WHERE ID_Curso=NEW.ID_Curso;
        
		UPDATE Curso
		SET Promedio=p_prom
		WHERE ID_Curso=NEW.ID_Curso;
    END IF;
    
	IF (NEW.Progreso>99) THEN
			SET NEW.Certificado=1;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `t_Nivel_Max` BEFORE INSERT ON `historial` FOR EACH ROW BEGIN
	DECLARE p_max	TINYINT;
    
    SELECT count(Numero_Niv)
    INTO p_max
    FROM Nivel
    WHERE ID_Curso=NEW.ID_Curso;
    
    SET NEW.Nivel_Maximo=p_max;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `imagenes`
--

CREATE TABLE `imagenes` (
  `ID_Imágenes` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Imagenes',
  `Imagen` blob DEFAULT NULL COMMENT 'En este campo se guardara el archivo binario de la imagen',
  `Tipo` enum('jpg','png','bmp') DEFAULT NULL COMMENT 'Este campo guarda el tipo de archivo de la imagen',
  `ID_Nivel` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Imagenes con la tabla Nivel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `imagenes`
--

INSERT INTO `imagenes` (`ID_Imágenes`, `Imagen`, `Tipo`, `ID_Nivel`) VALUES
(2, 0x4173736574732f323233343132325f363863355f382e6a7067, NULL, 16),
(3, NULL, NULL, NULL),
(5, 0x4173736574732f432e6a7067, NULL, 17),
(6, 0x4173736574732f7368616b6972612e706e67, NULL, 15);

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE `links` (
  `ID_Link` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Links',
  `Contenido` varchar(250) DEFAULT NULL COMMENT 'En este campo se guardara la liga',
  `ID_Nivel` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Links con la tabla Nivel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`ID_Link`, `Contenido`, `ID_Nivel`) VALUES
(2, 'https://www.google.com/', 16),
(3, 'https://www.google.com/', NULL),
(5, 'https://www.youtube.com/', 17),
(6, 'https://www.youtube.com/', 15);

-- --------------------------------------------------------

--
-- Table structure for table `mensajes`
--

CREATE TABLE `mensajes` (
  `ID_Mensaje` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Mensajes',
  `Contenido` text DEFAULT NULL COMMENT 'En este campo se guardara el contenido del mensaje',
  `ID_User` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Mensajes con la tabla Usuario (Destinatario)',
  `ID_Remitente` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Mensajes con la tabla Usuario (Remitente)',
  `Fecha_envio` timestamp NULL DEFAULT current_timestamp() COMMENT 'En este campo se guardara automaticamente la fecha en la que se envio el mensaje del chat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mensajes`
--

INSERT INTO `mensajes` (`ID_Mensaje`, `Contenido`, `ID_User`, `ID_Remitente`, `Fecha_envio`) VALUES
(1, 'hola', 2, 1, '2021-05-21 08:11:08'),
(2, 'hola', 2, 1, '2021-05-21 08:11:08'),
(3, 'que tal', 2, 1, '2021-05-21 08:11:08'),
(4, 'Como estas', NULL, 1, '2021-05-21 08:11:08'),
(5, 'que hubo', NULL, 1, '2021-05-21 08:11:08'),
(6, 'que tal', 2, 1, '2021-05-21 08:11:08'),
(7, 'dfdfdfd', NULL, 1, '2021-05-21 08:11:08'),
(8, '', NULL, 1, '2021-05-21 08:11:08'),
(9, 'Hola', NULL, 1, '2021-05-21 08:11:08'),
(10, 'Hola', NULL, 1, '2021-05-21 08:11:08'),
(11, 'Eyy', 4, 1, '2021-05-21 08:11:08'),
(12, 'heyyyyy', 1, 2, '2021-05-21 08:11:08'),
(13, 'que tal', 2, 1, '2021-05-21 08:11:32'),
(14, 'tuve fe', 2, 1, '2021-05-21 09:01:14'),
(15, 'hola!!!!', 4, 3, '2021-05-21 09:13:07'),
(16, 'hola :)', 3, 4, '2021-05-21 09:37:08'),
(17, 'hey que tal', 1, 4, '2021-05-21 09:37:21'),
(18, 'hola', 4, 1, '2021-05-21 09:37:51'),
(19, 'nada', 1, 4, '2021-05-21 09:38:27'),
(20, 'hola', 2, 5, '2021-05-22 04:23:25'),
(21, 'heyyyyyyyyyyy', 4, 3, '2021-05-22 05:06:49'),
(22, 'holiwi', 3, 4, '2021-05-22 05:07:23'),
(23, 'hola', 4, 5, '2021-05-22 06:36:48'),
(24, 'Hola', 4, 3, '2021-05-23 04:53:36'),
(25, 'heyyyyyyyyy', 3, 4, '2021-05-23 04:54:07'),
(26, 'Buen curso', 2, 3, '2021-05-24 17:57:22');

-- --------------------------------------------------------

--
-- Table structure for table `nivel`
--

CREATE TABLE `nivel` (
  `ID_Nivel` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Nivel',
  `Descripción` text DEFAULT NULL COMMENT 'Este campo guardara una descripción  de lo que se va a ver en el nivel del curso',
  `PruebaG` bit(1) DEFAULT NULL COMMENT 'Este indicara si el nivel del curso es gratuito',
  `ID_Curso` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Nivel con la tabla Curso',
  `ID_Video` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Nivel con la tabla Videos',
  `Numero_Niv` tinyint(4) DEFAULT NULL COMMENT 'En este campo se guardara el numero de nivel que es'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nivel`
--

INSERT INTO `nivel` (`ID_Nivel`, `Descripción`, `PruebaG`, `ID_Curso`, `ID_Video`, `Numero_Niv`) VALUES
(1, NULL, NULL, 1, NULL, NULL),
(2, NULL, NULL, 1, NULL, NULL),
(3, NULL, NULL, 1, NULL, NULL),
(4, NULL, NULL, 2, NULL, NULL),
(5, NULL, NULL, 2, NULL, NULL),
(6, NULL, NULL, 3, NULL, NULL),
(7, NULL, NULL, 3, NULL, NULL),
(8, NULL, NULL, 3, NULL, NULL),
(9, NULL, NULL, 4, NULL, NULL),
(10, NULL, NULL, 4, NULL, NULL),
(15, 'Aprende las bases', b'1', 29, 9, 1),
(16, 'Dibuja mejor', b'0', 29, 2, 2),
(17, 'Avanzado', b'0', 29, 8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `subcategoria`
--

CREATE TABLE `subcategoria` (
  `ID_Subcategoría` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Subcategoria',
  `Nombre` varchar(60) DEFAULT NULL COMMENT 'Este campo guardara el nombre de la subcategoria',
  `ID_Categoría` int(10) UNSIGNED DEFAULT NULL COMMENT 'Este campo es una Foreign Key, que relaciona la tabla Subcategoria con la tabla Categoria'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `ID_User` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Usuario',
  `Nombre` varchar(60) NOT NULL COMMENT 'En este campo se guardara el nombre del usuario',
  `Correo` varchar(100) NOT NULL COMMENT 'En este campo se guardara el correo electronico del usuario',
  `Contraseña` varchar(20) NOT NULL COMMENT 'En este campo se guardara la contraseña del usuario, necesria para ingresar a su perfil',
  `Fecha_alta` timestamp NULL DEFAULT current_timestamp() COMMENT 'En este campo se guardara automaticamente la fecha en la que el usuario se dio de alta en la pagina',
  `Tipo_Usuario` enum('Admin','Profesor','Alumno') NOT NULL DEFAULT 'Alumno' COMMENT 'En este campo se guardara que cual es el tipo de usuario que se dara de alta',
  `Foto_usuario` blob DEFAULT NULL COMMENT 'En este apartado se guardara una imagen o foto que el usuario quiera que se muestre en su perfil',
  `Descripcion` text DEFAULT _utf8mb4
) ;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`ID_User`, `Nombre`, `Correo`, `Contraseña`, `Fecha_alta`, `Tipo_Usuario`, `Foto_usuario`, `Descripcion`, `Apellidos`) VALUES
(1, 'Keanu', 'keanu@gmail.com', '123', '2021-05-17 00:23:08', 'Alumno', 0x4173736574732f6b65616e752e6a7067, 'hola', 'Reeves'),
(2, 'Vin', 'vin@gmail.com', '123', '2021-05-21 01:39:11', 'Profesor', 0x4173736574732f56696e44696573656c2e706e67, 'Tuve fe', 'Diesel'),
(3, 'Shakira', 'shakira@gmail.com', '123', '2021-05-21 01:56:20', 'Alumno', 0x4173736574732f7368616b6972612e706e67, 'hola', 'Shakira'),
(4, 'Brad', 'brad@gmail.com', '123', '2021-05-21 04:47:43', 'Profesor', 0x4173736574732f627261647069742e6a7067, 'Hello', 'Pit'),
(5, 'Diego', 'diego@gmail.com', '123', '2021-05-21 22:07:34', 'Alumno', 0x4173736574732f3132313136333239385f323039303330313137343433363832385f363235383235383537353934323334303632325f6e2e6a7067, 'Hey', 'Flores'),
(6, 'Ice', 'ice@gmail.com', '123', '2021-05-22 04:47:10', 'Profesor', 0x4173736574732f4963655f637562655f70686f746f5f62795f6d756e617761725f686f7361696e5f67657474795f696d616765735f656e7465727461696e6d656e745f67657474795f333031373233362e6a7067, 'Hey', 'Cube'),
(7, 'Hideo', 'kojima@gmail.com', '123', '2021-05-22 05:00:48', 'Profesor', 0x4173736574732f42663259696a39622e6a7067, 'Hey', 'Kojima'),
(8, 'Dwayne', 'rock@gmail.com', '123', '2021-05-25 17:14:14', 'Alumno', 0x4173736574732f6e62632d6f72646572732d636f6d6564792d62617365642d6f6e2d7468652d6c6966652d6f662d647761796e652d7468652d726f636b2d6a6f686e735f756573652e3632302e6a7067, 'Yes', 'Johnson');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `ID_Video` int(10) UNSIGNED NOT NULL COMMENT 'Este campo es la Primary Key de la tabla Videos',
  `Video` mediumblob DEFAULT NULL COMMENT 'En este campo se guardara el archivo binario del video',
  `Tipo` enum('mp4','mov','avi','qt') DEFAULT NULL COMMENT 'Este campo guarda el tipo de archivo del video'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`ID_Video`, `Video`, `Tipo`) VALUES
(2, 0x4173736574732f323032312d30322d31342032312d34392d31312e6d7034, NULL),
(6, NULL, NULL),
(7, NULL, NULL),
(8, 0x4173736574732f323032312d30332d31372032332d34382d30362e6d7034, NULL),
(9, 0x4173736574732f323032312d30342d32332031362d35362d33392e6d7034, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_cursos_fecha`
-- (See below for the actual view)
--
CREATE TABLE `v_cursos_fecha` (
`Nombre_Curso` varchar(100)
,`Descripción` text
,`Promedio` tinyint(3) unsigned
,`Precio` double unsigned
,`Foto_curso` blob
,`ID_User` int(10) unsigned
,`Fecha` varchar(19)
,`Categoria` varchar(60)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_cursos_mas_vendidos`
-- (See below for the actual view)
--
CREATE TABLE `v_cursos_mas_vendidos` (
`Nombre_Curso` varchar(100)
,`Descripción` text
,`Promedio` tinyint(3) unsigned
,`Precio` double unsigned
,`Foto_curso` blob
,`ID_User` int(10) unsigned
,`Fecha` varchar(19)
,`Categoria` varchar(60)
,`Ventas Totales` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_cursos_promedio`
-- (See below for the actual view)
--
CREATE TABLE `v_cursos_promedio` (
`Nombre_Curso` varchar(100)
,`Descripción` text
,`Promedio` tinyint(3) unsigned
,`Precio` double unsigned
,`Foto_curso` blob
,`ID_User` int(10) unsigned
,`Fecha` varchar(19)
,`Categoria` varchar(60)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_historial_ventas`
-- (See below for the actual view)
--
CREATE TABLE `v_historial_ventas` (
`Usuario` varchar(181)
,`Progreso` tinyint(3) unsigned
,`Nombre_Curso` varchar(100)
,`Precio` double unsigned
,`ID_User` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Structure for view `v_cursos_fecha`
--
DROP TABLE IF EXISTS `v_cursos_fecha`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cursos_fecha`  AS SELECT `cu`.`Nombre_Curso` AS `Nombre_Curso`, `cu`.`Descripción` AS `Descripción`, `cu`.`Promedio` AS `Promedio`, `cu`.`Precio` AS `Precio`, `cu`.`Foto_curso` AS `Foto_curso`, `cu`.`ID_User` AS `ID_User`, date_format(`cu`.`Fecha_alta`,'%Y-%m-%d %T') AS `Fecha`, `ca`.`Nombre` AS `Categoria` FROM ((`curso` `cu` join `curso_categoria` `cc` on(`cc`.`ID_Curso` = `cu`.`ID_Curso`)) join `categoria` `ca` on(`cc`.`ID_Categoría` = `ca`.`ID_Categoría`)) ORDER BY `cu`.`Fecha_alta` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_cursos_mas_vendidos`
--
DROP TABLE IF EXISTS `v_cursos_mas_vendidos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cursos_mas_vendidos`  AS SELECT `cu`.`Nombre_Curso` AS `Nombre_Curso`, `cu`.`Descripción` AS `Descripción`, `cu`.`Promedio` AS `Promedio`, `cu`.`Precio` AS `Precio`, `cu`.`Foto_curso` AS `Foto_curso`, `cu`.`ID_User` AS `ID_User`, date_format(`cu`.`Fecha_alta`,'%Y-%m-%d %T') AS `Fecha`, `ca`.`Nombre` AS `Categoria`, count(`h`.`ID_Curso`) AS `Ventas Totales` FROM (((`curso` `cu` join `curso_categoria` `cc` on(`cc`.`ID_Curso` = `cu`.`ID_Curso`)) join `categoria` `ca` on(`cc`.`ID_Categoría` = `ca`.`ID_Categoría`)) join `historial` `h` on(`h`.`ID_Curso` = `cu`.`ID_Curso`)) GROUP BY `h`.`ID_Curso` ORDER BY count(`h`.`ID_Curso`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_cursos_promedio`
--
DROP TABLE IF EXISTS `v_cursos_promedio`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cursos_promedio`  AS SELECT `cu`.`Nombre_Curso` AS `Nombre_Curso`, `cu`.`Descripción` AS `Descripción`, `cu`.`Promedio` AS `Promedio`, `cu`.`Precio` AS `Precio`, `cu`.`Foto_curso` AS `Foto_curso`, `cu`.`ID_User` AS `ID_User`, date_format(`cu`.`Fecha_alta`,'%Y-%m-%d %T') AS `Fecha`, `ca`.`Nombre` AS `Categoria` FROM ((`curso` `cu` join `curso_categoria` `cc` on(`cc`.`ID_Curso` = `cu`.`ID_Curso`)) join `categoria` `ca` on(`cc`.`ID_Categoría` = `ca`.`ID_Categoría`)) ORDER BY `cu`.`Promedio` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_historial_ventas`
--
DROP TABLE IF EXISTS `v_historial_ventas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_historial_ventas`  AS SELECT concat(`u`.`Nombre`,' ',`u`.`Apellidos`) AS `Usuario`, `h`.`Progreso` AS `Progreso`, `c`.`Nombre_Curso` AS `Nombre_Curso`, `c`.`Precio` AS `Precio`, `c`.`ID_User` AS `ID_User` FROM ((`historial` `h` join `usuario` `u` on(`h`.`ID_User` = `u`.`ID_User`)) join `curso` `c` on(`h`.`ID_Curso` = `c`.`ID_Curso`)) ORDER BY `u`.`ID_User` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`ID_Categoría`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`ID_Curso`),
  ADD KEY `FK_CUR_USER` (`ID_User`);

--
-- Indexes for table `curso_categoria`
--
ALTER TABLE `curso_categoria`
  ADD PRIMARY KEY (`ID_CC`),
  ADD KEY `FK_CC_CUR` (`ID_Curso`),
  ADD KEY `FK_CC_CAT` (`ID_Categoría`);

--
-- Indexes for table `documentacion`
--
ALTER TABLE `documentacion`
  ADD PRIMARY KEY (`ID_Documento`),
  ADD KEY `FK_DOC_NIV` (`ID_Nivel`);

--
-- Indexes for table `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`ID_Historial`),
  ADD KEY `FK_HIST_USER` (`ID_User`),
  ADD KEY `FK_HIST_CUR` (`ID_Curso`);

--
-- Indexes for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`ID_Imágenes`),
  ADD KEY `FK_IMG_NIV` (`ID_Nivel`);

--
-- Indexes for table `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`ID_Link`),
  ADD KEY `FK_LINK_NIV` (`ID_Nivel`);

--
-- Indexes for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`ID_Mensaje`),
  ADD KEY `FK_MEN_USER` (`ID_User`),
  ADD KEY `FK_MEN_REM` (`ID_Remitente`);

--
-- Indexes for table `nivel`
--
ALTER TABLE `nivel`
  ADD PRIMARY KEY (`ID_Nivel`),
  ADD KEY `FK_NIV_CUR` (`ID_Curso`),
  ADD KEY `FK_NIV_VID` (`ID_Video`);

--
-- Indexes for table `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`ID_Subcategoría`),
  ADD KEY `FK_SUB_CAT` (`ID_Categoría`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`ID_Video`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `ID_Categoría` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Categoria', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `curso`
--
ALTER TABLE `curso`
  MODIFY `ID_Curso` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Curso', AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `curso_categoria`
--
ALTER TABLE `curso_categoria`
  MODIFY `ID_CC` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Curso_Categoria', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `documentacion`
--
ALTER TABLE `documentacion`
  MODIFY `ID_Documento` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Documentacion', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `historial`
--
ALTER TABLE `historial`
  MODIFY `ID_Historial` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Historial', AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `ID_Imágenes` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Imagenes', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `links`
--
ALTER TABLE `links`
  MODIFY `ID_Link` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Links', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `ID_Mensaje` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Mensajes', AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `nivel`
--
ALTER TABLE `nivel`
  MODIFY `ID_Nivel` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Nivel', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `ID_Subcategoría` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Subcategoria';

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `ID_User` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Usuario';

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `ID_Video` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Este campo es la Primary Key de la tabla Videos', AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `FK_CUR_USER` FOREIGN KEY (`ID_User`) REFERENCES `usuario` (`ID_User`);

--
-- Constraints for table `curso_categoria`
--
ALTER TABLE `curso_categoria`
  ADD CONSTRAINT `FK_CC_CAT` FOREIGN KEY (`ID_Categoría`) REFERENCES `categoria` (`ID_Categoría`),
  ADD CONSTRAINT `FK_CC_CUR` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`);

--
-- Constraints for table `documentacion`
--
ALTER TABLE `documentacion`
  ADD CONSTRAINT `FK_DOC_NIV` FOREIGN KEY (`ID_Nivel`) REFERENCES `nivel` (`ID_Nivel`);

--
-- Constraints for table `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `FK_HIST_CUR` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`),
  ADD CONSTRAINT `FK_HIST_USER` FOREIGN KEY (`ID_User`) REFERENCES `usuario` (`ID_User`);

--
-- Constraints for table `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `FK_IMG_NIV` FOREIGN KEY (`ID_Nivel`) REFERENCES `nivel` (`ID_Nivel`);

--
-- Constraints for table `links`
--
ALTER TABLE `links`
  ADD CONSTRAINT `FK_LINK_NIV` FOREIGN KEY (`ID_Nivel`) REFERENCES `nivel` (`ID_Nivel`);

--
-- Constraints for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `FK_MEN_REM` FOREIGN KEY (`ID_Remitente`) REFERENCES `usuario` (`ID_User`),
  ADD CONSTRAINT `FK_MEN_USER` FOREIGN KEY (`ID_User`) REFERENCES `usuario` (`ID_User`);

--
-- Constraints for table `nivel`
--
ALTER TABLE `nivel`
  ADD CONSTRAINT `FK_NIV_CUR` FOREIGN KEY (`ID_Curso`) REFERENCES `curso` (`ID_Curso`),
  ADD CONSTRAINT `FK_NIV_VID` FOREIGN KEY (`ID_Video`) REFERENCES `videos` (`ID_Video`);

--
-- Constraints for table `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `FK_SUB_CAT` FOREIGN KEY (`ID_Categoría`) REFERENCES `categoria` (`ID_Categoría`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
