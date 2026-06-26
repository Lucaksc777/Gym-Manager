CREATE VIEW vw_frequencia_alunos AS
SELECT
    a.nome                          AS aluno,
    mo.nome                         AS modalidade,
    COUNT(f.id_frequencia)          AS total_visitas,
    MAX(f.data_hora_entrada)        AS ultima_visita
FROM aluno a
INNER JOIN frequencia f  ON a.id_aluno      = f.id_aluno
INNER JOIN modalidade mo ON f.id_modalidade = mo.id_modalidade
GROUP BY a.id_aluno, a.nome, mo.id_modalidade, mo.nome
ORDER BY total_visitas DESC;

SELECT * FROM vw_frequencia_alunos;