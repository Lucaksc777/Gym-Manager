-- JOIN 7: Todos os instrutores incluindo os sem treinos prescritos (LEFT JOIN)
SELECT
    i.nome              AS instrutor,
    i.especialidade,
    COUNT(t.id_treino)  AS total_treinos
FROM instrutor i
LEFT JOIN treino t ON i.id_instrutor = t.id_instrutor
GROUP BY i.id_instrutor, i.nome, i.especialidade
ORDER BY total_treinos DESC;