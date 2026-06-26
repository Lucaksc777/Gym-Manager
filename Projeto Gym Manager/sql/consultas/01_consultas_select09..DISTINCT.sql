-- Consulta 9: Modalidades praticadas pelos alunos sem repetição (DISTINCT)
SELECT DISTINCT
    m.nome          AS modalidade,
    m.duracao_minutos,
    m.capacidade_maxima
FROM modalidade m
INNER JOIN frequencia f ON m.id_modalidade = f.id_modalidade
ORDER BY m.nome ASC;