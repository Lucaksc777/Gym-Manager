USE gym_manager;

CREATE TABLE treino_exercicio (
    id_treino_exercicio INT           NOT NULL AUTO_INCREMENT,
    id_treino           INT           NOT NULL,
    id_exercicio        INT           NOT NULL,
    series              TINYINT,
    repeticoes          TINYINT,
    carga_kg            DECIMAL(5,2)  NOT NULL DEFAULT 0,
    descanso_seg        SMALLINT,
    ordem               TINYINT       NOT NULL,
    observacoes         TEXT,
    PRIMARY KEY (id_treino_exercicio),
    FOREIGN KEY (id_treino)    REFERENCES treino(id_treino)       ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_exercicio) REFERENCES exercicio(id_exercicio) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;