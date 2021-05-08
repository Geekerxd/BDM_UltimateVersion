CREATE DATABASE webstudy;
USE webstudy;

CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(15) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    apellidoPat VARCHAR(80) NOT NULL,
    apellidoMat VARCHAR(80) NOT NULL,
    contrasena VARCHAR(8) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(10),
    foto BLOB,
    fecha_registro DATETIME NOT NULL
);

DROP TABLE usuario;

INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono, fecha_registro) VALUES ("escuela", "Javier", "Lopez", "Gonzalez", "123456B_", "javier@gmail.com", "8123432981", "2021-09-12 05:30:23");

SELECT* FROM usuario;

CREATE TABLE IF NOT EXISTS categoria (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(300),
    foto BLOB
);

DROP TABLE categoria;

CREATE TABLE IF NOT EXISTS curso (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(300),
    costo FLOAT NOT NULL,
    video BLOB,
    foto BLOB,
    idUsuarioCreador INT NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idUsuarioCreador) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria (id)
);

DROP TABLE curso;

CREATE TABLE IF NOT EXISTS nivel (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(300),
    foto BLOB,
    video BLOB NOT NULL,
    archivo BLOB NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idCurso) REFERENCES curso (id)
);

DROP TABLE nivel;

CREATE TABLE IF NOT EXISTS estudiantesCursando (
	idEstudiante INT NOT NULL,
    idCurso INT NOT NULL,
    idMaestro INT NOT NULL,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCurso) REFERENCES curso (id),
    FOREIGN KEY (idMaestro) REFERENCES curso (idUsuarioCreador),
    PRIMARY KEY(idEstudiante, idCurso),
    nivelCursado INT DEFAULT 1,
    cursoFinalizado BIT DEFAULT 0,
    fechaInicio DATE,
    fechaFinal DATE NOT NULL,
    ultimoNivel BIT DEFAULT 0
);

DROP TABLE estudiantesCursando;

CREATE TABLE IF NOT EXISTS comentariosEnCursos (
	idEstudiante INT NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCurso) REFERENCES curso (id),
    PRIMARY KEY(idEstudiante, idCurso),
    comentario VARCHAR(300) NOT NULL
);

DROP TABLE comentariosEnCursos;

CREATE TABLE IF NOT EXISTS chat (
	idChat INT AUTO_INCREMENT PRIMARY KEY,
	idUsuario1 INT NOT NULL,
    idUsuario2 INT NOT NULL,
    FOREIGN KEY (idUsuario1) REFERENCES usuario(id),
    FOREIGN KEY (idUsuario2) REFERENCES usuario(id)
);

DROP TABLE chat;

CREATE TABLE IF NOT EXISTS mensajeChat (
	numMensaje BIGINT AUTO_INCREMENT PRIMARY KEY,
    idChat INT NOT NULL,
    FOREIGN KEY (idChat) REFERENCES chat(idChat),
    mensaje VARCHAR(300) NOT NULL,
    fecha DATETIME
);

DROP TABLE mensajeChat;

CALL `webstudy`.`sp_loginUsuario`("javier@gmail.com", "123456B_");
