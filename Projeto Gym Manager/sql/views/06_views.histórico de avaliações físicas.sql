CREATE VIEW vw_evolucao_fisica AS
SELECT
    a.nome              AS aluno,
    af.data_avaliacao,
    af.peso_kg,
    af.altura_cm,
    af.percentual_gordura,
    af.massa_muscular_kg,
    af.imc
FROM aluno a
INNER JOIN avaliacao_fisica af ON a.id_aluno = af.id_aluno
ORDER BY a.nome ASC, af.data_avaliacao ASC;

SELECT * FROM vw_evolucao_fisica;