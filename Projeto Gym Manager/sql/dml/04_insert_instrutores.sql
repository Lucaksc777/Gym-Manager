CREATE TABLE instrutor (
    id_instrutor  INT          NOT NULL AUTO_INCREMENT,
    nome          VARCHAR(100) NOT NULL,
    cpf           CHAR(11)     NOT NULL,
    cref          VARCHAR(20)  NOT NULL,
    especialidade VARCHAR(100),
    telefone      VARCHAR(20),
    email         VARCHAR(150),
    salario       DECIMAL(10,2),
    data_admissao DATE         NOT NULL,
    status        ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
    created_at    DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_instrutor),
    UNIQUE KEY uq_instrutor_cpf   (cpf),
    UNIQUE KEY uq_instrutor_cref  (cref),
    UNIQUE KEY uq_instrutor_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;