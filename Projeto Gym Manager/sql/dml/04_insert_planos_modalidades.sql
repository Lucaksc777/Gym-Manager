USE gym_manager;

INSERT INTO plano (nome, descricao, duracao_meses, valor, limite_modalidades) VALUES
('Mensal Básico',    'Acesso a 1 modalidade por mês',           1,  99.90, 1),
('Mensal Plus',      'Acesso a 3 modalidades por mês',          1, 149.90, 3),
('Trimestral',       'Acesso a 3 modalidades por trimestre',    3, 399.90, 3),
('Semestral',        'Acesso ilimitado por semestre',           6, 699.90, 5),
('Anual Premium',    'Acesso ilimitado a todas modalidades',   12, 999.90, 10);

INSERT INTO modalidade (nome, descricao, duracao_minutos, capacidade_maxima) VALUES
('Musculação',  'Treino com pesos e máquinas',         60, 30),
('Yoga',        'Equilíbrio corpo e mente',            60, 20),
('Pilates',     'Fortalecimento e postura',            55, 15),
('Spinning',    'Ciclismo indoor de alta intensidade', 45, 25),
('Natação',     'Treino aquático completo',            60, 20),
('Boxe',        'Treino de boxe e defesa pessoal',     60, 15),
('CrossFit',    'Treino funcional de alta intensidade',60, 20),
('Zumba',       'Dança fitness animada',               50, 30),
('Funcional',   'Treino funcional com peso corporal',  50, 25),
('Dança',       'Aulas de diversos ritmos',            60, 25);