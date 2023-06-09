mysql -u root -p
create database modelofisicofinal;
use modelofisicofinal;

CREATE TABLE Administrador (
  id_administrador INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  id_usuario INT NOT NULL UNIQUE,
  PRIMARY KEY (id_administrador),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Estudiante (
  id_estudiante INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  id_usuario INT NOT NULL,
  matricula VARCHAR(10) NOT NULL,
  DNI VARCHAR(20) NOT NULL,
  carrera VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_estudiante),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  UNIQUE KEY (id_usuario)
);
CREATE TABLE Profesor (
  id_profesor INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  id_usuario INT NOT NULL,
  DNI VARCHAR(20) NOT NULL,
  email VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_profesor),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Info_Profesor (
  id_profesor INT NOT NULL PRIMARY KEY,
  telefono VARCHAR(20),
  FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Area_Profesor (
  id_profesor INT NOT NULL,
  area_alt VARCHAR(50),
  area_pp VARCHAR(50),
  PRIMARY KEY (id_profesor, area_alt),
  FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);
CREATE TABLE Tarea (
  id_tarea INT NOT NULL AUTO_INCREMENT,
  id_curso INT NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(255),
  fecha_cr DATE NOT NULL,
  fecha_ent DATE NOT NULL,
  archivo VARCHAR(100),
  puntaje INT NOT NULL,
  PRIMARY KEY (id_tarea)
);

CREATE TABLE Tarea_Curso (
  id_tarea INT,
  id_curso INT,
  PRIMARY KEY (id_tarea, id_curso),
  FOREIGN KEY (id_tarea) REFERENCES Tarea(id_tarea),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);
CREATE TABLE Material (
  id_material INT NOT NULL AUTO_INCREMENT,
  id_curso INT NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  descripcion VARCHAR(255),
  url VARCHAR(255),
  PRIMARY KEY (id_material)
);

CREATE TABLE Material_Curso (
  id_material INT NOT NULL,
  id_curso INT NOT NULL,
  PRIMARY KEY (id_material, id_curso),
  FOREIGN KEY (id_material) REFERENCES Material(id_material),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);
CREATE TABLE Foro (
  id_foro INT NOT NULL AUTO_INCREMENT,
  id_curso INT NOT NULL,
  descripcion VARCHAR(255),
  nombre VARCHAR(50),
  fecha_cr DATE,
  fecha_tr DATE,
  PRIMARY KEY (id_foro)
);
CREATE TABLE Curso_Foro (
  id_curso INT NOT NULL,
  id_foro INT NOT NULL,
  PRIMARY KEY (id_curso, id_foro),
  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
  FOREIGN KEY (id_foro) REFERENCES Foro(id_foro)
);
CREATE TABLE Mensaje (
  id_mensaje INT NOT NULL AUTO_INCREMENT,
  id_foro INT NOT NULL,
  descripcion TEXT NOT NULL,
  fecha_tr DATETIME NOT NULL,
  id_mensaje_padre INT,
  PRIMARY KEY (id_mensaje)
);
CREATE TABLE Foro_Mensaje (
  id_foro INT NOT NULL,
  id_mensaje INT NOT NULL,
  PRIMARY KEY (id_foro, id_mensaje),
  FOREIGN KEY (id_foro) REFERENCES Foro(id_foro),
  FOREIGN KEY (id_mensaje) REFERENCES Mensaje(id_mensaje)
);
CREATE TABLE Mensaje_Mensaje (
  id_mensaje_padre INT NOT NULL,
  id_mensaje_hijo INT NOT NULL,
  PRIMARY KEY (id_mensaje_padre, id_mensaje_hijo),
  FOREIGN KEY (id_mensaje_padre) REFERENCES Mensaje(id_mensaje),
  FOREIGN KEY (id_mensaje_hijo) REFERENCES Mensaje(id_mensaje)
);

CREATE TABLE Usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  DNI VARCHAR(20) NOT NULL,
  referencia_banc VARCHAR(50) NOT NULL,
  nombre_usuario VARCHAR(50) NOT NULL,
  contraseña VARCHAR(255) NOT NULL,
  id_administrador INT UNIQUE,
  PRIMARY KEY (id_usuario)
);
CREATE TABLE Curso (
    id_curso INT PRIMARY KEY,
    id_profesor INT,
    id_usuario INT,
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    fecha_inicio DATE,
    fecha_fin DATE,
    semestre VARCHAR(255),
    año INT,
    categoria VARCHAR(255),
    ruta VARCHAR(255),
    precio FLOAT
);

CREATE TABLE Estudiante_Curso (
    id_estudiante INT,
    id_curso INT,
    PRIMARY KEY (id_estudiante, id_curso),
    FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Profesor_interesado (
    id_profesor INT,
    id_curso INT,
    PRIMARY KEY (id_profesor, id_curso),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

CREATE TABLE Usuario_Curso (
    id_usuario INT,
    id_curso INT,
    PRIMARY KEY (id_usuario, id_curso),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);

// No requiere crear el usuario en AWS RDS, cuando crea el servicio se crea el usuario:
create user "dbuser"@"%" identified with mysql_native_password BY "Eafit2023.";

grant all privileges on tienda.* to "dbuser"@"%";
flush privileges;

INSERT INTO Usuario (id_usuario, nombre, email, DNI, referencia_banc, nombre_usuario, contraseña)
VALUES 
(1, 'Juan Pérez', 'juanperez@gmail.com', '12345678A', 'ES12345678901234567890', 'juanperez', 'contraseña123'),
(2, 'María Gómez', 'mariagomez@hotmail.com', '87654321B', 'ES09876543210987654321', 'mariagomez', 'contraseña456'),
(3, 'Pedro López', 'pedrolopez@hotmail.com', '23456789C', 'ES23456789012345678901', 'pedrolopez', 'contraseña789'),
(4, 'Sara Martínez', 'saramartinez@gmail.com', '34567890D', 'ES34567890123456789012', 'saramartinez', 'contraseña012'),
(5, 'Alejandro Ruiz', 'alejandroruiz@gmail.com', '45678901E', 'ES45678901234567890123', 'alejandroruiz', 'contraseña345'),
(6, 'Ana García', 'anagarcia@gmail.com', '56789012F', 'ES56789012345678901234', 'anagarcia', 'contraseña678'),
(7, 'David Fernández', 'davidfernandez@hotmail.com', '67890123G', 'ES67890123456789012345', 'davidfernandez', 'contraseña901'),
(8, 'Laura Sánchez', 'laurasanchez@hotmail.com', '78901234H', 'ES78901234567890123456', 'laurasanchez', 'contraseña234');

INSERT INTO Administrador (nombre, id_usuario) 
VALUES 
('Juan Pérez', 1),
('Ana García', 6);

INSERT INTO Usuario (id_usuario, nombre, email, DNI, referencia_banc, nombre_usuario, contraseña)
VALUES 
(9, 'Roberto Rodríguez', 'robertorodriguez@gmail.com', '98765432I', 'ES09876543219876543219', 'robertorodriguez', 'contraseña567'),
(10, 'María Pérez', 'mariaperez@hotmail.com', '76543210J', 'ES76543210987654321098', 'mariaperez', 'contraseña890');

INSERT INTO Usuario (id_usuario, nombre, email, DNI, referencia_banc, nombre_usuario, contraseña)
VALUES 
(11, 'Carmen López', 'carmenlopez@gmail.com', '90123456I', 'ES89012345678901234567', 'carmenlopez', 'contraseña567'),
(12, 'Manuel Sánchez', 'manuelsanchez@hotmail.com', '01234567J', 'ES90123456789012345678', 'manuelsanchez', 'contraseña890'),
(13, 'Lucía Martínez', 'luciamartinez@gmail.com', '12345678K', 'ES89012345678901234567', 'luciamartinez', 'contraseña123'),
(14, 'Jorge Pérez', 'jorgeperez@hotmail.com', '23456789L', 'ES90123456789012345678', 'jorgeperez', 'contraseña456'),
(15, 'Marina García', 'marinagarcia@hotmail.com', '34567890M', 'ES89012345678901234567', 'marinagarcia', 'contraseña789'),
(16, 'Raúl Rodríguez', 'raulrodriguez@gmail.com', '45678901N', 'ES90123456789012345678', 'raulrodriguez', 'contraseña012'),
(17, 'Elena Fernández', 'elenafdez@hotmail.com', '56789012O', 'ES89012345678901234567', 'elenafdez', 'contraseña345'),
(18, 'Pablo Gómez', 'pablogomez@gmail.com', '67890123P', 'ES90123456789012345678', 'pablogomez', 'contraseña678'),
(19, 'Sofía Ruiz', 'sofiaruiz@hotmail.com', '78901234Q', 'ES89012345678901234567', 'sofiaruiz', 'contraseña901'),
(20, 'Alberto Martín', 'albertomartin@gmail.com', '89012345R', 'ES90123456789012345678', 'albertomartin', 'contraseña234');

INSERT INTO Usuario (id_usuario, nombre, email, DNI, referencia_banc, nombre_usuario, contraseña)
VALUES 
(21, 'Ana Pérez', 'anaperez@gmail.com', '90123456I', 'ES89012345678901234567', 'anaperez', 'contraseña567'),
(22, 'José García', 'josegarcia@hotmail.com', '01234567J', 'ES90123456789012345678', 'josegarcia', 'contraseña890'),
(23, 'María José López', 'mariajoselopez@gmail.com', '12345678K', 'ES89012345678901234567', 'mariajoselopez', 'contraseña123'),
(24, 'Juan Fernández', 'juanfernandez@hotmail.com', '23456789L', 'ES90123456789012345678', 'juanfernandez', 'contraseña456'),
(25, 'Sara Martínez', 'saramartinez@hotmail.com', '34567890M', 'ES89012345678901234567', 'saramartinez', 'contraseña789'),
(26, 'Pablo García', 'pablogarcia@gmail.com', '45678901N', 'ES90123456789012345678', 'pablogarcia', 'contraseña012'),
(27, 'Luisa Ruiz', 'luisaruiz@hotmail.com', '56789012O', 'ES89012345678901234567', 'luisaruiz', 'contraseña345'),
(28, 'Carlos Sánchez', 'carlossanchez@gmail.com', '67890123P', 'ES90123456789012345678', 'carlossanchez', 'contraseña678'),
(29, 'Marta Pérez', 'martaperez@hotmail.com', '78901234Q', 'ES89012345678901234567', 'martaperez', 'contraseña901'),
(30, 'Pedro Ruiz', 'pedroruiz@gmail.com', '89012345R', 'ES90123456789012345678', 'pedroruiz', 'contraseña234');

INSERT INTO Administrador (nombre, id_usuario)
VALUES ('Laura Gómez', 8);

INSERT INTO Estudiante (id_estudiante, nombre, id_usuario, matricula, DNI, carrera)
VALUES 
(50, 'David Fernández', 7, '123456', '67890123G', 'Ingeniería Civil'),
(55, 'Roberto Rodríguez', 9, '234567', '98765432I', 'Derecho'),
(57, 'María Pérez', 10, '345678', '76543210J', 'Enfermería'),
(56, 'Carmen López', 11, '456789', '90123456I', 'Arquitectura'),
(53, 'Manuel Sánchez', 12, '567890', '01234567J', 'Medicina'),
(62, 'Lucía Martínez', 13, '678901', '12345678K', 'Ingeniería Eléctrica'),
(60, 'Jorge Pérez', 14, '789012', '23456789L', 'Psicología'),
(66, 'Marina García', 15, '890123', '34567890M', 'Biología'),
(68, 'Raúl Rodríguez', 16, '901234', '45678901N', 'Ciencias Políticas'),
(70, 'Elena Fernández', 17, '234567', '56789012O', 'Historia'),
(45, 'Pablo Gómez', 18, '345678', '367890123P', 'Ingeniería Mecánica'),
(80, 'Sofía Ruiz', 19, '456789', '78901234Q', 'Matemáticas'),
(88, 'Alberto Martín', 20, '567890', '89012345R', 'Periodismo'),
(85, 'Ana Pérez', 21, '678901', '90123456I', 'Ingeniería Química'),
(83, 'José García', 22, '789012', '01234567J', 'Ingeniería Industrial'),
(90, 'María José López', 23, '890123', '12345678K', 'Economía'),
(92, 'Juan Fernández', 24, '901234', '23456789L', 'Publicidad'),
(100, 'Sara Martínez', 25, '012345', '34567890M', 'Turismo'),
(105, 'Pablo García', 26, '123456', '45678901N', 'Filosofía'),
(110, 'Luisa Ruiz', 27, '234567', '56789012O', 'Enología'),
(120, 'Carlos Sánchez', 28, '345678', '67890123P', 'Ingeniería Informática'),
(125, 'Marta Pérez', 29, '456789', '78901234Q', 'Geografía');

INSERT INTO Profesor (id_profesor, nombre, id_usuario, DNI, email) VALUES
  (200, 'Alejandro Ruiz', 5, '45678901E', 'alejandroruiz@gmail.com'),
  (220, 'Sara Martínez', 4, '34567890D', 'saramartinez@gmail.com'),
  (240, 'Pedro Ruiz', 30, '89012345R', 'pedroruiz@gmail.com'),
  (270, 'María Gómez', 2, '87654321B', 'mariagomez@hotmail.com'),
  (170, 'Pedro López', 3, '23456789C', 'pedrolopez@hotmail.com');


INSERT INTO Info_Profesor (id_profesor, telefono)
VALUES
  (200, '123456789'),
  (220, '987654321'),
  (240, '111222333'),
  (270, '444555666'),
  (170, '777888999');

INSERT INTO Area_Profesor (id_profesor, area_alt, area_pp) VALUES
  (200, 'Matemáticas', 'Calculo'),
  (220, 'Comunicacion', 'Estrategia'),
  (240, 'Química', 'Orgánica'),
  (270, 'Informática', 'Programación Orientada a Objetos'),
  (170, 'Etica', 'Salud');



INSERT INTO Curso (id_curso, nombre, descripcion, fecha_inicio, fecha_fin, semestre, año, categoria, ruta, precio) VALUES
(850,'Programación Básica', 'Curso introductorio de programación', '2023-01-15', '2023-06-15', 'Semestre 1', 2023, 'Informática', '/cursos/programacion-basica', 99.99),
(800,'Redes de Computadoras', 'Curso avanzado sobre redes de computadoras', '2023-03-01', '2023-08-01', 'Semestre 1', 2023, 'Informática', '/cursos/redes-computadoras', 149.99),
(900,'Introducción a la Fotografía', 'Curso básico de fotografía', '2023-07-01', '2023-12-01', 'Semestre 2', 2023, 'Fotografía', '/cursos/fotografia', 79.99),
(1000,'Diseño Gráfico Avanzado', 'Curso avanzado de diseño gráfico', '2023-09-15', '2024-02-15', 'Semestre 2', 2023, 'Diseño', '/cursos/disenio-grafico', 199.99),
(700, 'Inglés Intermedio', 'Curso de inglés para estudiantes intermedios', '2023-06-01', '2023-11-01', 'Semestre 1', 2023, 'Idiomas', '/cursos/ingles-intermedio', 129.99);

INSERT INTO Profesor_interesado (id_profesor, id_curso) 
VALUES (200, 850);

INSERT INTO Profesor_interesado (id_profesor, id_curso) 
VALUES (220, 800);

INSERT INTO Profesor_interesado (id_profesor, id_curso) 
VALUES (240, 900);

INSERT INTO Profesor_interesado (id_profesor, id_curso) 
VALUES (270, 1000);

INSERT INTO Profesor_interesado (id_profesor, id_curso) 
VALUES (170, 700);


INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (50, 850);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (55, 800);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (57, 900);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (56, 1000);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (53, 700);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (62, 700);
INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (60, 850);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (66, 800);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (68, 900);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (70, 1000);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (45, 700);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (80, 850);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (88, 1000);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (85, 900);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (83, 700);


INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (90, 800);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (92, 850);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (100, 1000);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (105, 850);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (110, 900);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (120, 1000);

INSERT INTO Estudiante_Curso (id_estudiante, id_curso) 
VALUES (125, 700);


INSERT INTO Tarea (id_tarea, id_curso, nombre, descripcion, fecha_cr, fecha_ent, archivo, puntaje)
VALUES (500,850, 'Tarea 1', 'Diseñar un sitio web para una empresa ficticia, utilizando HTML, CSS y JavaScript', '2023-05-10', '2023-05-15', 'archivo1.doc', 10),
       (520,800, 'Tarea 2', 'Realizar una investigación sobre los protocolos de red TCP/IP y presentar un informe escrito de 5 páginas', '2023-05-11', '2023-05-17', 'archivo2.doc', 15),
       (540,900, 'Tarea 3', 'Realizar un ensayo sobre la evolución de la fotografía en la última década', '2023-05-12', '2023-05-18', 'archivo3.doc', 20),
       (560,1000, 'Tarea 4', 'Crear un video tutorial de 10 minutos sobre cómo utilizar una herramienta de edición de imágenes', '2023-05-13', '2023-05-19', 'archivo4.doc', 25),
       (570,700, 'Tarea 5', 'Resolver los ejercicios del capítulo 4 del libro de texto y entregar las soluciones en formato PDF.', '2023-05-14', '2023-05-20', 'archivo5.doc', 30);

INSERT INTO Tarea_Curso (id_tarea, id_curso) VALUES (500, 850);
INSERT INTO Tarea_Curso (id_tarea, id_curso) VALUES (520, 800);
INSERT INTO Tarea_Curso (id_tarea, id_curso) VALUES (540, 900);
INSERT INTO Tarea_Curso (id_tarea, id_curso) VALUES (560, 1000);
INSERT INTO Tarea_Curso (id_tarea, id_curso) VALUES (570, 700);

INSERT INTO Material (id_material, id_curso, nombre, descripcion, url)
VALUES (2000, 850, 'Introducción a la programación', 'Material introductorio sobre programación', 'http://ejemplo.com/programacion'),
       (2500, 800, 'Presentación del curso', 'Introducción y objetivos del curso', 'http://ejemplo.com/marketing'),
       (3500, 900, 'Guía de técnicas de iluminación', 'Esta guía presenta diferentes técnicas de iluminación para la fotografía, con explicaciones detalladas y ejemplos prácticos', 'http://ejemplo.com/ejemplos'),
       (4700, 1000,'Tutorial de Photoshop avanzado', 'Este tutorial enseña técnicas avanzadas de edición de imágenes en Photoshop, como la eliminación de objetos no deseados y la manipulación de capas.', 'https://www.ejemplo.com/tuto-photoshop-avanzado'),
       (5600, 700, 'Listening exercises', 'Un conjunto de ejercicios de escucha para ayudar a los estudiantes a mejorar sus habilidades de comprensión','https://www.example.com/listeningexercises');

INSERT INTO Material_Curso (id_material, id_curso)
VALUES (2000, 850),
       (2500, 800),
       (3500, 900),
       (4700, 1000),
       (5600, 700);

INSERT INTO Foro (id_foro, id_curso, descripcion, nombre, fecha_cr, fecha_tr)
VALUES 
  (7000,700, 'Foro para discutir temas relacionados con el curso de inglés intermedio', 'Foro de Inglés', '2022-02-01', '2022-06-30'),
  (7500,800, 'Foro para compartir ideas y dudas sobre el curso de diseño gráfico avanzado', 'Foro de Diseño', '2022-01-15', '2022-05-15'),
  (7700,850, 'Foro para discutir temas relacionados con el curso de introducción a la programación', 'Foro de Programación', '2022-03-01', '2022-07-01'),
  (7900,900, 'Foro para discutir temas relacionados con el curso de fotografía', 'Foro de Fotografía', '2022-02-15', '2022-06-15'),
  (7300,1000, 'Foro para compartir información y dudas sobre el curso de Photoshop', 'Foro de Photoshop', '2022-01-30', '2022-05-30');

INSERT INTO Curso_Foro (id_curso, id_foro)
VALUES 
  (700,7000),
  (800,7500),
  (850,7700),
  (900,7900);
  
INSERT INTO Curso_Foro (id_curso, id_foro)
VALUES (1000,7300);
  
INSERT INTO Mensaje (id_mensaje,id_foro, descripcion, fecha_tr, id_mensaje_padre)
VALUES
  (65000,7000, 'Este es el primer mensaje del foro de inglés intermedio', '2022-02-01 10:00:00', 11000),
  (85000,7000, 'Hola a todos, ¿cómo van las clases?', '2022-02-05 14:30:00', 12000),
  (99000,7000, 'A mí me está costando un poco la gramática', '2022-02-07 09:15:00', 14000),
  (100000,7000, '¿Alguien tiene algún consejo para estudiar mejor?', '2022-02-09 16:45:00', 15000),
  (99500,7000, 'Yo recomiendo hacer ejercicios prácticos todos los días', '2022-02-10 11:00:00', 15500),
  (77500,7500, 'Bienvenidos al foro de diseño gráfico avanzado', '2022-01-15 09:00:00', 15300),
  (98000,7500, 'Hola, quisiera saber cuál es el mejor programa para diseño de logos', '2022-01-20 13:45:00', 15700),
  (48000,7500, 'Yo recomiendo Adobe Illustrator', '2022-01-22 10:30:00', 15400),
  (50000,7500, 'Sí, estoy de acuerdo, Illustrator es muy bueno', '2022-01-23 08:15:00', 18000),
  (70000,7700, 'Este es el foro para el curso de programación', '2022-03-01 12:00:00', 20000),
  (60000,7700, '¿Cómo van las prácticas?', '2022-03-05 15:30:00', 20500),
  (150000,7700, 'Estoy un poco perdido con el lenguaje Java', '2022-03-08 10:45:00', 20700),
  (170000,7700, '¿Alguien me puede recomendar algún tutorial para aprender Java?', '2022-03-10 16:30:00', 20800),
  (180000,7900, 'Foro para discutir temas sobre fotografía', '2022-02-15 11:00:00', 20100),
  (200000,7300, 'Foro para discutir temas sobre Photoshop', '2022-01-30 09:00:00', 20900),
  (300000,7300, '¿Cómo puedo crear un efecto de texto en 3D?', '2022-02-05 14:15:00', 21000),
  (500000,7300, 'En Photoshop se pueden crear varios efectos de texto en 3D, pero requiere práctica y habilidad', '2022-02-07 09:30:00', 20200);

  
  

INSERT INTO Foro_Mensaje (id_foro, id_mensaje)
VALUES
  (7000,65000 ),
  (7000, 85000),
  (7000, 99000),
  (7000, 100000),
  (7000, 99500),
  (7500, 77500),
  (7500, 98000),
  (7500, 48000),
  (7500, 50000),
  (7700, 70000),
  (7700, 60000),
  (7700, 150000),
  (7700, 170000),
  (7900, 180000),
  (7300, 200000),
  (7300, 300000),
  (7300, 500000);
  

INSERT INTO Mensaje_Mensaje (id_mensaje_padre, id_mensaje_hijo)
VALUES
(65000, 65000),
(85000, 85000),
(99000, 99000),
(100000, 100000),
(99500, 99500),
(77500, 77500),
(98000, 98000),
(48000, 48000),
(50000, 50000),
(70000, 70000),
(60000, 60000),
(150000, 150000),
(170000, 170000),
(180000, 180000),
(200000, 200000),
(300000, 300000);

