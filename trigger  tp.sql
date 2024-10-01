DELIMITER //

CREATE TRIGGER `usuarios_insert` AFTER INSERT ON usuarios
FOR EACH ROW
BEGIN 
INSERT INTO auditoria_usuarios_nueva (`id`,`direccion`, `telefono`, `email`)

VALUES (id,NEW.direccion, NEW.telefono, NEW.email);
END;
//

CREATE TRIGGER `usuarios_update` BEFORE UPDATE ON `usuarios`
FOR EACH ROW
BEGIN
INSERT INTO auditoria_usuarios_nueva (`id`, `operacion`, `direccion`,
`telefono`, `email`)
VALUES (id,NEW.operacion,NEW.direccion,NEW.telefono,NEW.email);
END;
//

DELIMITER ;
```




DELIMITER //

CREATE TRIGGER `socios_insert` AFTER INSERT ON socios
FOR EACH ROW
BEGIN
INSERT INTO auditoria_socios_nueva (`socio_id`, `operacion`, `uid_nuevo`, `fInscripcion_nuevo`)
VALUES (NEW.sid, 'INSERT', NEW.uid, NEW.fInscripcion);
END;
//


CREATE TRIGGER `socios_update` BEFORE UPDATE ON socios
FOR EACH ROW
BEGIN
INSERT INTO auditoria_socios_nueva (`socio_id`, `operacion`, `uid_anterior`, `uid_nuevo`,
`fInscripcion_anterior`, `fInscripcion_nuevo`)
VALUES (OLD.sid, 'UPDATE', OLD.uid, NEW.uid, OLD.fInscripcion, NEW.fInscripcion);
END;
//

DELIMITER ;