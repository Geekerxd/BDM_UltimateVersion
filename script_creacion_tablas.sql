CREATE DATABASE webstudy;
USE webstudy;

CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(15) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    apellidoPat VARCHAR(80) NOT NULL,
    apellidoMat VARCHAR(80) NOT NULL,
    contrasena VARCHAR(16) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(10),
    foto BLOB,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE usuario;

INSERT INTO usuario(rol, nombre, apellidoPat, apellidoMat, contrasena, email, telefono) VALUES ("escuela", "Javier", "Lopez", "Gonzalez", "123456B_", "javier@gmail.com", "8123432981");

SELECT* FROM usuario;

CREATE TABLE IF NOT EXISTS categoria (
	idCat INT AUTO_INCREMENT PRIMARY KEY,
    nombreCat VARCHAR(80) NOT NULL,
    descripcionCat VARCHAR(1000),
    fotoCat VARCHAR(2000)
);

DROP TABLE categoria;

SELECT* FROM categoria;

CREATE TABLE IF NOT EXISTS curso (
	idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nombreCurso VARCHAR(80) NOT NULL,
    descripcionCurso VARCHAR(1000),
    descCortaCurso VARCHAR(200),
    costo FLOAT NOT NULL,
    videoCurso VARCHAR(2000),
    fotoCurso VARCHAR(2000),
    valoracion FLOAT DEFAULT 0.0,
    idUsuarioCreador INT NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idUsuarioCreador) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria (idCat)
);

DROP TABLE curso;

DELETE FROM curso WHERE curso.id = 14;

SELECT* FROM curso;

CREATE TABLE IF NOT EXISTS nivel (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(1000),
    foto VARCHAR(2000),
    video VARCHAR(2000) NOT NULL,
    archivo VARCHAR(2000) NOT NULL,
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
    fechaInicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fechaFinal TIMESTAMP DEFAULT NULL,
    ultimoNivel BIT DEFAULT 0,
    progreso FLOAT DEFAULT 0
);

DROP TABLE estudiantesCursando;

CREATE TABLE IF NOT EXISTS comentariosEnCursos (
	idEstudiante INT NOT NULL,
    idCurso INT NOT NULL,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCurso) REFERENCES curso (id),
    PRIMARY KEY(idEstudiante, idCurso),
    comentario VARCHAR(300) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE mensajeChat;

CALL `webstudy`.`sp_signupUsuario`("escuela", "Omar", "Alvarado", "Rodriguez", "123456O_", "Omar@gmail.com", "8123432981");
CALL `webstudy`.`sp_loginUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");
CALL `webstudy`.`sp_createCategory`("base de datos","muchas cosas");
CALL `webstudy`.`sp_getCategorias`();

CALL `webstudy`.`sp_createCurso`("css", "estilos", "lalalalalallalalalala", "2000", 1, "escuela", "123456B_", "javier@gmail.com");

CALL `webstudy`.`sp_getCursos`();

CALL `webstudy`.`sp_traeInfoUsuario`("estudiante", "dani_g.mazatan@hotmail.com", "123456A_");

CALL `webstudy`.`sp_modificarUsuario`("Luis", "Lopez", "Montemayor", "123456L_", "Luis@gmail.com", "8126854889", "escuela", "Omar@gmail.com", "123456O_");
