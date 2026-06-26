-- Consulta 2: Buscar alunos pelo nome (LIKE)
SELECT 
    id_aluno,
    nome,
    telefone,
    email
FROM aluno
WHERE nome LIKE '%Silva%'
   OR nome LIKE '%Santos%'
ORDER BY nome ASC;