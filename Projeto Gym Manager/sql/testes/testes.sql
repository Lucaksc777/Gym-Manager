INSERT INTO aluno (nome, cpf, data_nascimento, sexo, telefone, email, status)
VALUES ('Teste Duplicado', '12345678901', '2000-01-01', 'M', '71900000000', 'teste@teste.com', 'ativo');

DELETE FROM aluno WHERE id_aluno = 1;

UPDATE pagamento SET status = 'invalido' WHERE id_pagamento = 39;

DELETE FROM plano WHERE id_plano = 1;