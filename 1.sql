CREATE DATABASE escuela_psql;
\c escuela_psql;
CREATE TABLE estudiantes (
id SERIAL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
edad INT CHECK (edad BETWEEN 15 AND 60),
email VARCHAR(100) UNIQUE,
fecha_nacimiento DATE,
direccion VARCHAR(100)
);

CREATE TABLE cursos (
codigo VARCHAR(10) PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
creditos INT CHECK (creditos > 0),
profesor VARCHAR(50)
);

CREATE TABLE matriculas (
id SERIAL PRIMARY KEY,
estudiante_id INT REFERENCES estudiantes(id) ON DELETE CASCADE,
curso_codigo VARCHAR(10) REFERENCES cursos(codigo) ON DELETE CASCADE,
fecha DATE DEFAULT CURRENT_DATE,
calificacion DECIMAL(3,1) CHECK (calificacion BETWEEN 0 AND 10),
UNIQUE(estudiante_id, curso_codigo)
);

INSERT INTO estudiantes (nombre, edad, email) VALUES
('Ana Torres', 20, 'ana@email.com'),
('Luis Mendoza', 22, 'luis@email.com'),
('Marta Rojas', 19, 'marta@email.com'),
('Carlos Pérez', 21, 'carlos@email.com'),
('Sofia García', 23, 'sofia@email.com');

INSERT INTO cursos VALUES
('MATE101', 'Álgebra Lineal', 4, 'Prof. Ramírez'),
('PROG201', 'Programación I', 5, 'Ing. Fernández'),
('FIS150', 'Física General', 4, 'Dr. Martínez'),
('QUIM101', 'Química Básica', 3, 'Dra. López');

INSERT INTO matriculas
(estudiante_id, curso_codigo, calificacion) VALUES
(1, 'MATE101', 8.2),
(1, 'PROG201', 9.1),
(2, 'MATE101', 7.5),
(2, 'FIS150', 8.8),
(3, 'PROG201', 9.3);

SELECT 'Estudiantes' AS tabla, COUNT(*) AS registros FROM estudiantes
UNION ALL
SELECT 'Cursos', COUNT(*) FROM cursos
UNION ALL
SELECT 'Matrículas', COUNT(*) FROM matriculas;

SELECT nombre, edad
FROM estudiantes
WHERE edad > 20;

SELECT
    e.nombre AS estudiante,
    c.nombre AS curso,
    m.calificacion
FROM matriculas m
JOIN estudiantes e ON m.estudiante_id = e.id
JOIN cursos c ON m.curso_codigo = c.codigo;

SELECT AVG(edad) AS promedio_edad FROM estudiantes;
SELECT curso_codigo, COUNT(*) AS total_estudiantes
FROM matriculas
GROUP BY curso_codigo;

SELECT
AVG(calificacion) AS promedio,
MAX(calificacion) AS maxima,
MIN(calificacion) AS minima,
STDDEV(calificacion) AS desviacion_estandar,
VARIANCE(calificacion) AS varianza
FROM matriculas;

SELECT
    estudiante_id,
    curso_codigo,
    calificacion,
    AVG(calificacion) OVER (
        PARTITION BY estudiante_id
        ORDER BY fecha
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS promedio_movil
FROM matriculas
ORDER BY estudiante_id, fecha;

SELECT CORR(edad, calificacion) AS correlacion_edad_calificacion
FROM estudiantes e
JOIN matriculas m ON e.id = m.estudiante_id;

SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY calificacion) AS p25,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY calificacion) AS p50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY calificacion) AS p75
FROM matriculas;

SELECT
    e.id AS estudiante_id,
    e.edad,
    c.creditos,
    m.calificacion,
    CASE WHEN m.calificacion >= 7 THEN 'aprobado' ELSE 'reprobado' END AS resultado
FROM estudiantes e
JOIN matriculas m ON e.id = m.estudiante_id
JOIN cursos c ON m.curso_codigo = c.codigo
WHERE m.calificacion IS NOT NULL;

SELECT
DATE_TRUNC('month', fecha) AS mes,
AVG(calificacion) AS promedio_calificacion,
COUNT(*) AS total_matriculas
FROM matriculas
GROUP BY mes
ORDER BY mes;

