USE gym_manager;

-- Consulta 1: Listar todos os alunos ativos
SELECT 
    id_aluno,
    nome,
    cpf,
    email,
    status
FROM aluno
WHERE status = 'ativo'
ORDER BY nome ASC;