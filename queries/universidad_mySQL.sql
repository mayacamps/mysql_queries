/*1*/-- Returns a list with the first last name, second last name and first name of all the students. The list must be ordered alphabetically from lowest to highest by first last name, second last name and first name
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

/*2*/-- Returns the first and last names of students who have not registered their phone number in the database
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

/*3*/-- Returns the list of students who were born in 1999
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

/*4*/-- Returns the list of teachers who have not registered their phone number in the database and also their NIF ends in K
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

/*5*/-- Returns the list of subjects that are taught in the first semester, in the third year of the degree that has the identifier 7
SELECT nombre AS asignatura FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

/*6*/-- Returns a list of professors along with the name of the department to which they are linked. The listing should return four columns, first last name, second last name, first name and department name. The result will be sorted alphabetically from lowest to highest by last name and first name
SELECT apellido1, apellido2, p.nombre, d.nombre AS departamento FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor INNER JOIN departamento AS d ON prof.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY apellido1, apellido2, p.nombre;

/*7*/-- Returns a list with the name of the subjects, start year and end year of the student's school year with NIF 26902806M
SELECT asig.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM asignatura AS asig INNER JOIN alumno_se_matricula_asignatura AS asma ON asig.id = asma.id_asignatura INNER JOIN curso_escolar AS c ON asma.id_curso_escolar = c.id INNER JOIN persona as p ON p.id = asma.id_alumno WHERE p.nif = '26902806M';

/*8*/-- Returns a list with the name of all the departments that have professors who teach a subject in the Degree in Computer Engineering (Plan 2015)
SELECT DISTINCT d.nombre AS departamento FROM departamento AS d INNER JOIN profesor AS prof ON d.id = prof.id_departamento INNER JOIN asignatura AS asig ON prof.id_profesor = asig.id_profesor INNER JOIN grado ON asig.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

/*9*/-- Returns a list of all students who have enrolled in a subject during the 2018/2019 school year
SELECT DISTINCT apellido1, apellido2, nombre FROM persona INNER JOIN alumno_se_matricula_asignatura AS asma ON persona.id = asma.id_alumno INNER JOIN curso_escolar AS c ON asma.id_curso_escolar = c.id WHERE tipo = 'alumno' AND anyo_inicio = 2018;


-- LEFT JOIN AND RIGHT JOIN
/*1*/-- Returns a list with the names of all the professors and the departments they are linked to. Also showing professors who do not have any associated department.
-- The listing must return four columns, department name, first last name, second last name and teacher's name. The result will be sorted alphabetically from lowest to highest by department name, last name and first name
SELECT d.nombre AS departamento, apellido1, apellido2, p.nombre FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor LEFT JOIN departamento AS d ON prof.id_departamento = d.id ORDER BY d.nombre, apellido1, apellido2, p.nombre;

/*2*/-- Returns a list of professors who are not associated with a department
SELECT apellido1, apellido2, p.nombre FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor LEFT JOIN departamento AS d ON prof.id_departamento = d.id WHERE d.id IS NULL ORDER BY d.nombre;

/*3*/-- Returns a list of departments that do not have associate professors
SELECT d.nombre AS departamento FROM departamento AS d LEFT JOIN profesor AS prof ON d.id = prof.id_departamento WHERE prof.id_departamento IS NULL ORDER BY d.nombre;

/*4*/-- Returns a list of teachers who do not teach any subjects
SELECT apellido1, apellido2, p.nombre FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor LEFT JOIN asignatura AS asig ON prof.id_profesor = asig.id_profesor WHERE asig.id_profesor IS NULL ORDER BY prof.id_profesor;

/*5*/-- Returns a list of subjects that do not have an assigned teacher
SELECT asig.nombre FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor RIGHT JOIN asignatura AS asig ON prof.id_profesor = asig.id_profesor WHERE prof.id_profesor IS NULL;


-- SUMMARY
/*1*/-- Returns the total number of students there
SELECT COUNT(p.id) AS cantidad_alumnos FROM persona AS p WHERE tipo = 'alumno';

/*2*/-- Calculate how many students were born in 1999
SELECT COUNT(p.id) AS cantidad_alumnos_nacidos_1999 FROM persona AS p WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

/*3*/-- Calculate how many teachers there are in each department. The result should show two columns: name of the department and number of professors in that department.
-- The result must only include the departments that have associate professors and must be ordered from highest to lowest by the number of professors
SELECT d.nombre AS departamento, COUNT(prof.id_profesor) AS cantidad_profesores FROM departamento AS d INNER JOIN profesor AS prof ON d.id = prof.id_departamento GROUP BY d.nombre ORDER BY COUNT(prof.id_profesor) DESC;

/*4*/-- Returns a list with all the departments and the number of professors in each of them. Also show the departments that do not have associate professors.
SELECT d.nombre AS departamento, COUNT(prof.id_profesor) AS cantidad_profesores FROM departamento AS d LEFT JOIN profesor AS prof ON d.id = prof.id_departamento GROUP BY d.nombre ORDER BY COUNT(prof.id_profesor), d.nombre;

/*5*/-- Returns a list with the name of all the existing degrees in the database and the number of subjects each one has. Also show the degrees that do not have associated subjects. The result must be ordered from highest to lowest by the number of subjects
SELECT g.nombre AS grado, COUNT(asig.nombre) AS numero_asignaturas FROM grado AS g LEFT JOIN asignatura AS asig ON g.id = asig.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;

/*6*/-- Returns a list with the name of all the existing degrees in the database and the number of subjects each has, of the degrees that have more than 40 associated subjects
SELECT g.nombre AS grado, COUNT(asig.nombre) AS numero_asignaturas FROM grado AS g LEFT JOIN asignatura AS asig ON g.id = asig.id_grado GROUP BY g.nombre HAVING numero_asignaturas > 40;

/*9*/-- Returns a list with the number of subjects taught by each teacher. Also show the professors who do not teach any subjects. The result will show five columns: id, name, first last name, second last name and number of subjects. The result will be ordered from highest to lowest by the number of subjects
SELECT prof.id_profesor AS id, p.nombre, apellido1, apellido2, COUNT(asig.nombre) AS numero_asignaturas FROM persona AS p INNER JOIN profesor AS prof ON p.id = prof.id_profesor LEFT JOIN asignatura AS asig ON prof.id_profesor = asig.id_profesor GROUP BY prof.id_profesor ORDER BY numero_asignaturas DESC;