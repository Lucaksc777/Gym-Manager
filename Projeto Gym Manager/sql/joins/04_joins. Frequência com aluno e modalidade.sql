-- JOIN 4: Frequência com nome do aluno e modalidade praticada (INNER JOIN)
SELECT
    a.nome                      AS aluno,
    mo.nome                     AS modalidade,
    f.data_hora_entrada,
    f.data_hora_saida
FROM frequencia f
INNER JOIN aluno a       ON f.id_aluno      = a.id_aluno
INNER JOIN modalidade mo ON f.id_modalidade = mo.id_modalidade
ORDER BY f.data_hora_entrada DESC
LIMIT 10;