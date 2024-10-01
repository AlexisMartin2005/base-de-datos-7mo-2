
SELECT nombre,apellido, dni, direccion, fNacimiento
FROM usuarios;

SELECT sid, fInscripcion 
FROM socios;

SELECT nombre,eid 
FROM equipos;

SELECT socios.sid, socios.fInscripcion, usuarios.apellido,  usuarios.nombre, usuarios.dni, usuarios.fNacimiento, usuarios.direccion, equipos.nombre AS nombre_equipo
FROM socios
INNER JOIN usuarios ON socios.sid = usuarios.id
INNER JOIN equipos ON socios.sid = equipos.eid;

