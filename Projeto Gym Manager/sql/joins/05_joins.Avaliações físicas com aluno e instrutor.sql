-- JOIN 5: Avaliações físicas com aluno e instrutor (INNER JOIN)
SELECT
    a.nome              AS aluno,
    i.nome              AS instrutor,
    af.data_avaliacao,
    af.peso_kg,
    af.altura_cm,
    af.percentual_gordura,
    af.massa_muscular_kg
FROM avaliacao_fisica af
INNER JOIN aluno a     ON af.id_aluno     = a.id_aluno
INNER JOIN instrutor i ON af.id_instrutor = i.id_instrutor
ORDER BY a.nome ASC, af.data_avaliacao ASC;