USE gym_manager;

CREATE TABLE pagamento (
    id_pagamento    INT           NOT NULL AUTO_INCREMENT,
    id_matricula    INT           NOT NULL,
    valor           DECIMAL(10,2) NOT NULL,
    data_vencimento DATE          NOT NULL,
    data_pagamento  DATE,
    forma_pagamento ENUM('pix','cartao_credito','cartao_debito','dinheiro','boleto'),
    status          ENUM('pendente','pago','atrasado','cancelado') NOT NULL DEFAULT 'pendente',
    parcela_numero  TINYINT       NOT NULL,
    created_at      DATETIME      NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_pagamento),
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;