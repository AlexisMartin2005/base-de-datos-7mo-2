SELECT so.sid, us.apellido, us.nombre, us.dni, sum(ds.importe) FROM socios so
INNER JOIN usuarios us ON us.id = so.uid
INNER JOIN deudas_socios ds ON ds.sid = so.sid
WHERE ds.estado = 'pagada'
GROUP BY so.sid
ORDER BY SUM(ds.importe) desc LIMIT 10;