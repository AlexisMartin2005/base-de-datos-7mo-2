SELECT e.eid, 
       e.nombre, 
       ce.eid AS contrib_eid, 
       ce.monto AS contrib_monto, 
       ce.cdid, 
       ce.estado AS contrib_estado, 
       fac.fid, 
       fac.estado AS fac_estado, 
       ju.jid, 
       mulj.estado AS mulj_estado, 
       SUM(ce.monto) AS total_monto 
FROM equipos e
INNER JOIN jugadores ju ON e.eid = ju.jid
INNER JOIN multas_jugadores mulj ON ju.jid = mulj.muid
INNER JOIN facturacion fac ON mulj.muid = fac.fid
INNER JOIN contribuciones_equipos ce ON fac.fid = ce.eid
WHERE ce.estado = 'pagada'
GROUP BY e.eid, 
         e.nombre, 
         ce.eid, 
         ce.monto, 
         ce.cdid, 
         ce.estado, 
         fac.fid, 
         fac.estado, 
         ju.jid, 
         mulj.estado
ORDER BY total_monto DESC 
LIMIT 15;
