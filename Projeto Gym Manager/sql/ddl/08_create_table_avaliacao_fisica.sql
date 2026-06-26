USE gym_manager;

CREATE TABLE avaliacao_fisica (
    id_avaliacao             INT          NOT NULL AUTO_INCREMENT,
    id_aluno                 INT          NOT NULL,
    id_instrutor             INT          NOT NULL,
    data_avaliacao           DATE         NOT NULL,
    peso_kg                  DECIMAL(5,2),
    altura_cm                DECIMAL(5,2),
    imc                      DECIMAL(5,2),
    percentual_gordura       DECIMAL(5,2),
    massa_muscular_kg        DECIMAL(5,2),
    circunferencia_abdominal DECIMAL(5,2),
    pressao_arterial         VARCHAR(10),
    fc_repouso               SMALLINT,
    observacoes              TEXT,
    created_at               DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_avaliacao),
    FOREIGN KEY (id_aluno)     REFERENCES aluno(id_aluno)         ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;