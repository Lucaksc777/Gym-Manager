CREATE TABLE matricula (
    id_matricula           INT           NOT NULL AUTO_INCREMENT,
    id_aluno               INT           NOT NULL,
    id_plano               INT           NOT NULL,
    data_inicio            DATE          NOT NULL,
    data_fim               DATE          NOT NULL,
    valor_plano_contratado DECIMAL(10,2) NOT NULL,
    status                 ENUM('ativa','suspensa','cancelada','encerrada') NOT NULL DEFAULT 'ativa',
    observacoes            TEXT,
    created_at             DATETIME      NOT NULL DEFAULT NOW(),
    updated_at             DATETIME,
    PRIMARY KEY (id_matricula),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)   ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano)   ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE treino (
    id_treino     INT          NOT NULL AUTO_INCREMENT,
    id_aluno      INT          NOT NULL,
    id_instrutor  INT          NOT NULL,
    id_modalidade INT          NOT NULL,
    nome          VARCHAR(100),
    objetivo      VARCHAR(200),
    nivel         ENUM('iniciante','intermediario','avancado'),
    data_inicio   DATE,
    data_fim      DATE,
    ativo         TINYINT(1)   NOT NULL DEFAULT 1,
    created_at    DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_treino),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_instrutor)  REFERENCES instrutor(id_instrutor)   ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;