USE gym_manager;

-- Acelera verificação de matrícula ativa por aluno
ALTER TABLE matricula
ADD INDEX idx_matricula_aluno_status (id_aluno, status);

-- Acelera relatórios de frequência por aluno e data
ALTER TABLE frequencia
ADD INDEX idx_frequencia_aluno_entrada (id_aluno, data_hora_entrada);

-- Acelera consultas financeiras por matrícula e status
ALTER TABLE pagamento
ADD INDEX idx_pagamento_matricula_status (id_matricula, status);