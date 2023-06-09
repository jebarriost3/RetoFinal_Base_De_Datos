const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
const port = 3000;

// Configuración de la conexión a la base de datos
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Luis1972*',
  database: 'modelofisicofinal',
});

// Conexión a la base de datos
connection.connect((err) => {
  if (err) throw err;
  console.log('Conectado a la base de datos MySQL');
});

// Middleware para analizar el cuerpo de las solicitudes como JSON
app.use(bodyParser.json());

// Obtener todos los cursos
app.get('/cursos', (req, res) => {
  connection.query('SELECT * FROM Curso', (err, rows) => {
    if (err) throw err;
    res.render('index', { cursos: rows });
  });
});

// Obtener un curso por ID y mostrar los detalles
app.get('/cursos/:id', (req, res) => {
  const { id } = req.params;
  const cursoSql = `SELECT * FROM Curso WHERE id_curso = '${id}'`;
  connection.query(cursoSql, (err, rowsCurso) => {
    if (err) throw err;
    if (rowsCurso.length === 0) {
      res.status(404).json({ message: 'Curso no encontrado' });
    } else {
      const curso = rowsCurso[0];
      const profesorSql = `
        SELECT Profesor.*, Curso.nombre AS nombre_curso
        FROM Profesor
        JOIN Profesor_interesado ON Profesor_interesado.id_profesor = Profesor.id_profesor
        JOIN Curso ON Curso.id_curso = Profesor_interesado.id_curso
        WHERE Profesor_interesado.id_curso = '${curso.id_curso}'
      `;
      connection.query(profesorSql, (err, rowsProfesor) => {
        if (err) throw err;
        const profesor = rowsProfesor[0];
        const estudiantesSql = `
        SELECT Estudiante.*
        FROM Estudiante
        JOIN Estudiante_curso ON Estudiante_curso.id_estudiante = Estudiante.id_estudiante
        JOIN Curso ON Estudiante_curso.id_curso = Curso.id_curso
        WHERE Curso.id_curso = '${curso.id_curso}'
        `;
        connection.query(estudiantesSql, (err, rowsEstudiantes) => {
          if (err) throw err;
          const estudiantes = rowsEstudiantes;
          const materialesSql = `SELECT Material.*
          FROM Material
          JOIN Curso ON Material.id_curso = '${curso.id_curso}'`;
          connection.query(materialesSql, (err, rowsMateriales) => {
            if (err) throw err;
            const materiales = rowsMateriales;
            const tareasSql = `SELECT Tarea.*
            FROM Tarea
            JOIN Curso ON Tarea.id_curso = '${curso.id_curso}'`;
            connection.query(tareasSql, (err, rowsTareas) => {
              if (err) throw err;
              const tareas = rowsTareas;
              const forosSql = `SELECT Foro.*
              FROM Foro
              JOIN Curso ON Foro.id_curso = '${curso.id_curso}'`;
              connection.query(forosSql, (err, rowsForos) => {
                if (err) throw err;
                const foros = rowsForos;
                const actividades = { tareas, foros };

                // Renderizar la vista
                res.render('curso', { curso, profesor, estudiantes, materiales, actividades });
              });
            });
          });
        });
      });
    }
  });
});

// Crear un curso
app.post('/cursos', (req, res) => {
  const { nombre, id_profesor } = req.body;
  const insertCursoSql = `INSERT INTO Curso (nombre, id_profesor) VALUES ('${nombre}', '${id_profesor}')`;
  connection.query(insertCursoSql, (err, result) => {
    if (err) throw err;
    res.status(201).json({ message: 'Curso creado', id: result.insertId });
  });
});

// Actualizar un curso
app.put('/cursos/:id', (req, res) => {
  const { id } = req.params;
  const { nombre, id_profesor } = req.body;
  const updateCursoSql = `UPDATE Curso SET nombre = '${nombre}', id_profesor = '${id_profesor}' WHERE id_curso = '${id}'`;
  connection.query(updateCursoSql, (err) => {
    if (err) throw err;
    res.json({ message: 'Curso actualizado' });
  });
});

// Eliminar un curso
app.delete('/cursos/:id', (req, res) => {
  const { id } = req.params;
  const deleteCursoSql = `DELETE FROM Curso WHERE id_curso = '${id}'`;
  connection.query(deleteCursoSql, (err) => {
    if (err) throw err;
    res.json({ message: 'Curso eliminado' });
  });
});


// Obtener todos los profesores
app.get('/profesores', (req, res) => {
  connection.query('SELECT * FROM Profesor', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

// Obtener un profesor por ID
app.get('/profesores/:id', (req, res) => {
  const { id } = req.params;
  const sql = `SELECT * FROM Profesor WHERE id_profesor = '${id}'`;
  connection.query(sql, (err, rows) => {
    if (err) throw err;
    if (rows.length === 0) {
      res.status(404).json({ message: 'Profesor no encontrado' });
    } else {
      res.json(rows[0]);
    }
  });
});

// Crear un profesor
app.post('/profesores', (req, res) => {
  const { nombre } = req.body;
  const sql = `INSERT INTO Profesor (nombre) VALUES ('${nombre}')`;
  connection.query(sql, (err, result) => {
    if (err) throw err;
    res.status(201).json({ message: 'Profesor creado', id: result.insertId });
  });
});

// Actualizar un profesor
app.put('/profesores/:id', (req, res) => {
  const { id } = req.params;
  const { nombre } = req.body;
  const sql = `UPDATE Profesor SET nombre = '${nombre}' WHERE id_profesor = '${id}'`;
  connection.query(sql, (err) => {
    if (err) throw err;
    res.json({ message: 'Profesor actualizado' });
  });
});

// Eliminar un profesor
app.delete('/profesores/:id', (req, res) => {
  const { id } = req.params;
  const sql = `DELETE FROM Profesor WHERE id_profesor = '${id}'`;
  connection.query(sql, (err) => {
    if (err) throw err;
    res.json({ message: 'Profesor eliminado' });
  });
});


// Iniciar el servidor
app.listen(port, () => {
  console.log(`Servidor iniciado en el puerto ${port}`);
});
