SELECT monto FROM cobro_facturacion;
SELECT nombre FROM usuarios;
SELECT sid FROM socios;
SELECT dsid FROM deudas_socios;
SELECT fid FROM facturacion;
SELECT estado FROM facturacion;

SELECT cf.monto, cf.cobrador, u.nombre, u.id, s.sid, ds.dsid, f.fid, f.estado
FROM cobro_facturacion cf
JOIN usuarios u ON cf.cobrador = u.id
JOIN socios s ON u.id = s.uid
JOIN deudas_socios ds ON s.sid = ds.sid
JOIN facturacion f ON ds.fid = f.fid;
