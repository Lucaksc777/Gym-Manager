USE gym_manager;

CREATE TABLE frequencia (
    id_frequencia      INT      NOT NULL AUTO_INCREMENT,
    id_aluno           INT      NOT NULL,
    id_modalidade      INT      NOT NULL,
    data_hora_entrada  DATETIME NOT NULL,
    data_hora_saida    DATETIME,
    observacoes        TEXT,
    PRIMARY KEY (id_frequencia),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;