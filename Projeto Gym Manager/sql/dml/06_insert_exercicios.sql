CREATE TABLE exercicio (
    id_exercicio  INT          NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    grupo_muscular VARCHAR(80),
    descricao     TEXT,
    equipamento   VARCHAR(100),
    PRIMARY KEY (id_exercicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;