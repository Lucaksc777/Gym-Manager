USE gym_manager;

INSERT INTO pagamento (id_matricula, valor, data_vencimento, data_pagamento, forma_pagamento, status, parcela_numero) VALUES
-- Matrícula 18 (encerrada)
(18, 149.90, '2024-01-01', '2024-01-05', 'pix',            'pago',     1),
-- Matrícula 19 (encerrada)
(19, 399.90, '2024-02-01', '2024-02-03', 'cartao_credito', 'pago',     1),
(19, 399.90, '2024-03-01', '2024-03-10', 'cartao_credito', 'pago',     2),
(19, 399.90, '2024-04-01', '2024-04-08', 'cartao_credito', 'pago',     3),
-- Matrícula 20 (ativa)
(20, 699.90, '2024-05-01', '2024-05-02', 'pix',            'pago',     1),
(20, 699.90, '2024-06-01', '2024-06-05', 'pix',            'pago',     2),
(20, 699.90, '2024-07-01', '2024-07-03', 'dinheiro',       'pago',     3),
(20, 699.90, '2024-08-01', '2024-08-07', 'pix',            'pago',     4),
(20, 699.90, '2024-09-01', NULL,          NULL,             'atrasado', 5),
(20, 699.90, '2024-10-01', NULL,          NULL,             'pendente', 6),
-- Matrícula 21 (encerrada)
(21,  99.90, '2024-03-01', '2024-03-02', 'dinheiro',       'pago',     1),
-- Matrícula 22 (ativa)
(22, 399.90, '2024-04-01', '2024-04-05', 'boleto',         'pago',     1),
(22, 399.90, '2024-05-01', '2024-05-10', 'boleto',         'pago',     2),
(22, 399.90, '2024-06-01', NULL,          NULL,             'atrasado', 3),
-- Matrícula 23 (ativa anual)
(23, 999.90, '2024-01-15', '2024-01-15', 'cartao_credito', 'pago',     1),
(23, 999.90, '2024-02-15', '2024-02-15', 'cartao_credito', 'pago',     2),
(23, 999.90, '2024-03-15', '2024-03-15', 'cartao_credito', 'pago',     3),
(23, 999.90, '2024-04-15', '2024-04-15', 'cartao_credito', 'pago',     4),
(23, 999.90, '2024-05-15', '2024-05-15', 'cartao_credito', 'pago',     5),
(23, 999.90, '2024-06-15', NULL,          NULL,             'atrasado', 6),
-- Matrícula 29 (ativa anual)
(29, 999.90, '2024-01-01', '2024-01-03', 'pix',            'pago',     1),
(29, 999.90, '2024-02-01', '2024-02-04', 'pix',            'pago',     2),
(29, 999.90, '2024-03-01', '2024-03-02', 'pix',            'pago',     3),
(29, 999.90, '2024-04-01', NULL,          NULL,             'atrasado', 4),
(29, 999.90, '2024-05-01', NULL,          NULL,             'pendente', 5),
-- Matrícula 34 (ativa anual)
(34, 999.90, '2024-01-01', '2024-01-10', 'cartao_debito',  'pago',     1),
(34, 999.90, '2024-02-01', '2024-02-08', 'cartao_debito',  'pago',     2),
(34, 999.90, '2024-03-01', '2024-03-05', 'cartao_debito',  'pago',     3),
(34, 999.90, '2024-04-01', NULL,          NULL,             'pendente', 4);