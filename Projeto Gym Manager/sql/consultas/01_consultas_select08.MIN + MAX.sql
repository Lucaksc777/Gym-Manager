-- Consulta 8: Menor e maior peso registrado nas avaliações (MIN + MAX)
SELECT
    MIN(peso_kg)    AS menor_peso,
    MAX(peso_kg)    AS maior_peso,
    AVG(peso_kg)    AS media_peso,
    MIN(fc_repouso) AS menor_fc,
    MAX(fc_repouso) AS maior_fc
FROM avaliacao_fisica;