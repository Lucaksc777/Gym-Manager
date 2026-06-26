-- Consulta 7: Média de peso, altura e IMC por aluno (AVG)
SELECT
    a.nome                        AS aluno,
    AVG(af.peso_kg)               AS media_peso,
    AVG(af.altura_cm)             AS media_altura,
    AVG(af.percentual_gordura)    AS media_gordura
FROM aluno a
INNER JOIN avaliacao_fisica af ON a.id_aluno = af.id_aluno
GROUP BY a.id_aluno, a.nome
ORDER BY media_gordura DESC;