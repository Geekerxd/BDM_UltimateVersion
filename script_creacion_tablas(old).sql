CREATE DATABASE webstudy;
USE webstudy;

CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    rol VARCHAR(15),
    nombre VARCHAR(80),
    apellidoPat VARCHAR(80),
    apellidoMat VARCHAR(80),
    contrasena VARCHAR(8),
    email VARCHAR(100),
    telefono VARCHAR(10),
    foto BLOB,
    fecha_registro DATETIME
);

CREATE TABLE IF NOT EXISTS categoria (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80),
    descripcion VARCHAR(300),
    foto BLOB
);

CREATE TABLE IF NOT EXISTS curso (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80),
    descripcion VARCHAR(300),
    costo FLOAT,
    video BLOB,
    foto BLOB,
    idUsuarioCreador INT,
    idCategoria INT,
    FOREIGN KEY (idUsuarioCreador) REFERENCES usuario(id),
    FOREIGN KEY (idCategoria) REFERENCES categoria (id)
);

CREATE TABLE IF NOT EXISTS nivel (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80),
    descripcion VARCHAR(300),
    foto BLOB,
    video BLOB,
    archivo BLOB,
    idCurso INT,
    FOREIGN KEY (idCurso) REFERENCES curso (id)
);

CREATE TABLE IF NOT EXISTS estudiantesCursando (
	idEstudiante INT,
    idCurso INT,
    idMaestro INT,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCurso) REFERENCES curso (id),
    FOREIGN KEY (idMaestro) REFERENCES curso (idUsuarioCreador),
    PRIMARY KEY(idEstudiante, idCurso),
    nivelCursado INT DEFAULT 1,
    cursoFinalizado BIT DEFAULT 0,
    fechaInicio DATE,
    fechaFinal DATE
);

CREATE TABLE IF NOT EXISTS comentariosEnCursos (
	idEstudiante INT,
    idCurso INT,
    FOREIGN KEY (idEstudiante) REFERENCES usuario (id),
    FOREIGN KEY (idCurso) REFERENCES curso (id),
    PRIMARY KEY(idEstudiante, idCurso),
    comentario VARCHAR(300)
);

CREATE TABLE IF NOT EXISTS chat (
	idUsuario1 INT,
    idUsuario2 INT,
    FOREIGN KEY (idUsuario1) REFERENCES usuario (id),
    FOREIGN KEY (idUsuario2) REFERENCES usuario (id),
    PRIMARY KEY(idUsuario1, idUsuario2),
    mensaje VARCHAR(300),
    numMensaje BIGINT AUTO_INCREMENT,
    fecha DATETIME
);