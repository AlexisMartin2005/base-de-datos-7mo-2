CREATE TABLE `auditoria_usuarios_nueva` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `operacion` VARCHAR(80) NOT NULL,
  `direccion` VARCHAR(80) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


CREATE TABLE `auditoria_socios_nueva` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `socio_id` INT(11) NOT NULL,
  `fInscripcion` DATE NOT NULL,
  `fRenovacion` DATE NULL DEFAULT NULL,
  `fBaja` DATE NULL DEFAULT NULL,
  `emmac` DATE NULL DEFAULT NULL,
  `activo` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) 
) ENGINE=INNODB;
