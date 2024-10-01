SELECT ju.jid,mulj.estado,mulj.mid,  SUM(mulj.monto) FROM jugadores 
INNER JOIN  jugadores ju ON multas_jugadores mulj = ju.jid
WHERE mulj.estado = 'pagada'
GROUP BY ju.jid
ORDER BY SUM(mulj.importe) desc LIMIT 15;