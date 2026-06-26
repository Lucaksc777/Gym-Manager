USE gym_manager;

CREATE TABLE plano (
    id_plano           INT           NOT NULL AUTO_INCREMENT,
    nome               VARCHAR(80)   NOT NULL,
    descricao          TEXT,
    duracao_meses      TINYINT       NOT NULL,
    valor              DECIMAL(10,2) NOT NULL,
    limite_modalidades TINYINT       NOT NULL DEFAULT 1,
    ativo              TINYINT(1)    NOT NULL DEFAULT 1,
    created_at         DATETIME      NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_plano)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;