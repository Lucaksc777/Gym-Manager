CREATE TABLE endereco (
    id_endereco  INT          NOT NULL AUTO_INCREMENT,
    logradouro   VARCHAR(200) NOT NULL,
    numero       VARCHAR(10)  NOT NULL,
    complemento  VARCHAR(50),
    bairro       VARCHAR(100) NOT NULL,
    cidade       VARCHAR(100) NOT NULL,
    estado       CHAR(2)      NOT NULL,
    cep          CHAR(8)      NOT NULL,
    PRIMARY KEY (id_endereco)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;