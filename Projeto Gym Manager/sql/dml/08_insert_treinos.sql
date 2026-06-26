USE gym_manager;

INSERT INTO treino (id_aluno, id_instrutor, id_modalidade, nome, objetivo, nivel, data_inicio, data_fim) VALUES
(1, 1, 1, 'Treino A - Peito e Tríceps',  'Hipertrofia',    'intermediario', '2024-05-01', '2024-08-01'),
(1, 1, 1, 'Treino B - Costas e Bíceps',  'Hipertrofia',    'intermediario', '2024-05-01', '2024-08-01'),
(2, 1, 1, 'Treino Full Body',            'Emagrecimento',  'iniciante',     '2024-04-01', '2024-07-01'),
(3, 2, 2, 'Yoga Relaxamento',            'Flexibilidade',  'iniciante',     '2024-01-15', '2024-07-15'),
(3, 4, 7, 'CrossFit Iniciante',          'Condicionamento','iniciante',     '2024-03-01', '2024-06-01'),
(4, 1, 1, 'Treino Força',               'Força máxima',   'avancado',      '2024-06-01', '2024-09-01'),
(5, 3, 4, 'Spinning HIIT',              'Cardio',         'intermediario', '2024-05-01', '2024-08-01'),
(6, 2, 3, 'Pilates Postura',            'Postura',        'iniciante',     '2024-03-15', '2024-06-15'),
(7, 4, 7, 'CrossFit Avançado',          'Performance',    'avancado',      '2024-01-01', '2024-07-01'),
(8, 1, 1, 'Treino Hipertrofia',         'Hipertrofia',    'intermediario', '2024-06-01', '2024-09-01'),
(9, 3, 4, 'Spinning Resistência',       'Resistência',    'intermediario', '2024-05-01', '2024-08-01'),
(10, 4, 9, 'Funcional Completo',        'Condicionamento','avancado',      '2024-01-01', '2024-07-01');