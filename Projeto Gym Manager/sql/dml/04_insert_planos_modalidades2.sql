USE gym_manager;

INSERT INTO plano (nome, descricao, duracao_meses, valor, limite_modalidades) VALUES
('Mensal Básico',  'Acesso a 1 modalidade por mês',         1,   99.90,  1),
('Mensal Plus',    'Acesso a 3 modalidades por mês',         1,  149.90,  3),
('Trimestral',     'Acesso a 3 modalidades por trimestre',   3,  399.90,  3),
('Semestral',      'Acesso ilimitado por semestre',          6,  699.90,  5),
('Anual Premium',  'Acesso ilimitado a todas modalidades',  12,  999.90, 10);