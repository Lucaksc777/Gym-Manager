USE gym_manager;

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
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;