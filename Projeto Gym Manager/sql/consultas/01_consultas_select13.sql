-- Consulta 13: Instrutores com mais treinos prescritos (GROUP BY + COUNT + ORDER BY)
SELECT
    i.nome                      AS instrutor,
    i.especialidade,
    COUNT(t.id_treino)          AS total_treinos
FROM instrutor i
INNER JOIN treino t ON i.id_instrutor = t.id_instrutor
GROUP BY i.id_instrutor, i.nome, i.especialidade
ORDER BY total_treinos DESC;