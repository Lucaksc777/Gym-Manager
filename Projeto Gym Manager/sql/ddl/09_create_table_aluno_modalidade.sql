USE gym_manager;

CREATE TABLE aluno_modalidade (
    id_aluno_modalidade INT      NOT NULL AUTO_INCREMENT,
    id_aluno            INT      NOT NULL,
    id_modalidade       INT      NOT NULL,
    data_inicio         DATE     NOT NULL,
    ativo               TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id_aluno_modalidade),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;