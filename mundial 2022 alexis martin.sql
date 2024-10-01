-- Crear la tabla para los partidos del Mundial 2022 si no existe
CREATE TABLE IF NOT EXISTS Partido (
  nro INT NOT NULL AUTO_INCREMENT,
  cod_local VARCHAR(3),
  gol_local INT,
  cod_visitante VARCHAR(3),
  gol_visitante INT,
  PRIMARY KEY (nro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Crear la tabla para los equipos y países si no existe
CREATE TABLE IF NOT EXISTS EquipoPais (
  id_equipo VARCHAR(3) PRIMARY KEY,
  nombre_pais VARCHAR(50)
);

-- Vaciar las tablas si ya existen registros (solo si es necesario)
TRUNCATE TABLE Partido;
TRUNCATE TABLE EquipoPais;

-- Insertar los datos de los partidos
INSERT INTO Partido (cod_local, gol_local, cod_visitante, gol_visitante)
VALUES 
-- Fase de Grupos
('QA', 0, 'EC', 2), -- Qatar vs Ecuador
('SN', 0, 'NL', 2), -- Senegal vs Países Bajos
('EN', 6, 'IR', 2), -- Inglaterra vs Irán
('AR', 1, 'SA', 2), -- Argentina vs Arabia Saudita
('FR', 4, 'AU', 1), -- Francia vs Australia
('BR', 2, 'SR', 0), -- Brasil vs Serbia
('DE', 1, 'JP', 2), -- Alemania vs Japón
('ES', 7, 'CR', 0), -- España vs Costa Rica

('QA', 1, 'SN', 3), -- Qatar vs Senegal
('NL', 1, 'EC', 1), -- Países Bajos vs Ecuador
('EN', 0, 'US', 0), -- Inglaterra vs Estados Unidos
('IR', 0, 'AR', 1), -- Irán vs Argentina
('SA', 0, 'FR', 2), -- Arabia Saudita vs Francia
('AU', 1, 'BR', 2), -- Australia vs Brasil
('JP', 0, 'DE', 1), -- Japón vs Alemania
('CR', 1, 'ES', 1), -- Costa Rica vs España

('AR', 2, 'MX', 0), -- Argentina vs México
('PL', 2, 'SA', 0), -- Polonia vs Arabia Saudita
('FR', 1, 'DE', 2), -- Francia vs Alemania
('AU', 1, 'TN', 0), -- Australia vs Túnez
('CR', 1, 'JP', 0), -- Costa Rica vs Japón
('US', 1, 'IR', 0), -- Estados Unidos vs Irán
('EC', 1, 'SN', 2), -- Ecuador vs Senegal
('NL', 2, 'QA', 0), -- Países Bajos vs Qatar

-- Rondas de Eliminación Directa
('AR', 2, 'AU', 1), -- Argentina vs Australia (Octavos)
('FR', 3, 'PL', 1), -- Francia vs Polonia (Octavos)
('EN', 3, 'SN', 0), -- Inglaterra vs Senegal (Octavos)
('NL', 3, 'US', 1), -- Países Bajos vs Estados Unidos (Octavos)

('AR', 2, 'NL', 2), -- Argentina vs Países Bajos (Cuartos) [Argentina ganó 4-3 en penales]
('FR', 2, 'EN', 1), -- Francia vs Inglaterra (Cuartos)

('AR', 3, 'FR', 3), -- Argentina vs Francia (Final) [Argentina ganó 4-2 en penales]
('MAR', 0, 'CRO', 2); -- Marruecos vs Croacia (Tercer Lugar)

-- Insertar los datos de los equipos y países
INSERT IGNORE INTO EquipoPais (id_equipo, nombre_pais)
VALUES 
('QA', 'Qatar'),
('EC', 'Ecuador'),
('SN', 'Senegal'),
('NL', 'Países Bajos'),
('EN', 'Inglaterra'),
('IR', 'Irán'),
('AR', 'Argentina'),
('SA', 'Arabia Saudita'),
('FR', 'Francia'),
('AU', 'Australia'),
('BR', 'Brasil'),
('SR', 'Serbia'),
('DE', 'Alemania'),
('JP', 'Japón'),
('ES', 'España'),
('CR', 'Costa Rica'),
('US', 'Estados Unidos'),
('MX', 'México'),
('PL', 'Polonia'),
('TN', 'Túnez'),
('CM', 'Camerún'),
('GH', 'Ghana'),
('UY', 'Uruguay'),
('PT', 'Portugal'),
('MAR', 'Marruecos'),
('HR', 'Croacia');

-- Consulta del total de goles por país, ordenado de mayor a menor
SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC;

-- Mostrar los 3 países con mayor cantidad de goles
SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC
LIMIT 3;

-- Mostrar el nombre completo del país en lugar del código, ordenado de mayor a menor
SELECT ep.nombre_pais, SUM(tot.goles) AS goltot
FROM (
  SELECT cod_local AS codigo_pais, gol_local AS goles FROM Partido
  UNION ALL
  SELECT cod_visitante AS codigo_pais, gol_visitante AS goles FROM Partido
) AS tot
JOIN EquipoPais ep ON tot.codigo_pais = ep.id_equipo
GROUP BY ep.nombre_pais
ORDER BY goltot DESC;

-- Obtener el promedio de goles por partido para cada equipo, ordenado de mayor a menor cantidad de goles
SELECT ep.nombre_pais, 
       COUNT(CASE WHEN cod_local = ep.id_equipo THEN 1 END) +
       COUNT(CASE WHEN cod_visitante = ep.id_equipo THEN 1 END) AS partidos_jugados,
       SUM(CASE WHEN cod_local = ep.id_equipo THEN gol_local ELSE 0 END) +
       SUM(CASE WHEN cod_visitante = ep.id_equipo THEN gol_visitante ELSE 0 END) AS goles_totales,
       AVG(CASE WHEN cod_local = ep.id_equipo THEN gol_local ELSE 0 END +
           CASE WHEN cod_visitante = ep.id_equipo THEN gol_visitante ELSE 0 END) AS promedio_goles
FROM Partido
JOIN EquipoPais ep ON cod_local = ep.id_equipo OR cod_visitante = ep.id_equipo
GROUP BY ep.id_equipo
ORDER BY goles_totales DESC;