CREATE TABLE aluno (
    id_aluno        INT          NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(100) NOT NULL,
    cpf             CHAR(11)     NOT NULL,
    data_nascimento DATE         NOT NULL,
    sexo            ENUM('M','F','O') NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    id_endereco     INT,
    status          ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
    created_at      DATETIME     NOT NULL DEFAULT NOW(),
    updated_at      DATETIME,
    PRIMARY KEY (id_aluno),
    UNIQUE KEY uq_aluno_cpf   (cpf),
    UNIQUE KEY uq_aluno_email (email),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;