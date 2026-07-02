-- ============================================================
-- GYM MANAGER — SCRIPT MESTRE
-- Sistema de Gestão de Academia
-- MySQL 8.0+
-- Equipe: Lucas Kelvim, Leonardo Badauê, Deivson Pires,
--         Yan Mota, Micael Melo, Wendel
-- Professor: Anildo Mattos — Disciplina: Banco de Dados
-- ============================================================
-- ORDEM DE EXECUÇÃO:
-- 1. DROP (limpa tudo)
-- 2. CREATE DATABASE + tabelas
-- 3. INDEXES + CONSTRAINTS
-- 4. TRIGGERS
-- 5. FUNCTIONS
-- 6. PROCEDURES
-- 7. INSERT (dados de teste)
-- 8. VIEWS
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET NAMES utf8mb4;

-- ============================================================
-- BLOCO 1 — DROP
-- ============================================================

DROP DATABASE IF EXISTS gym_manager;

-- ============================================================
-- BLOCO 2 — CREATE DATABASE
-- ============================================================

CREATE DATABASE gym_manager
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE gym_manager;

-- ============================================================
-- BLOCO 3 — DDL: CREATE TABLE (ordem respeitando FKs)
-- ============================================================

-- 1ª: endereco (sem FK)
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

-- 2ª: aluno (FK → endereco)
CREATE TABLE aluno (
    id_aluno        INT               NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(100)      NOT NULL,
    cpf             CHAR(11)          NOT NULL,
    data_nascimento DATE              NOT NULL,
    sexo            ENUM('M','F','O') NOT NULL,
    telefone        VARCHAR(20),
    email           VARCHAR(150),
    id_endereco     INT,
    status          ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
    created_at      DATETIME         NOT NULL DEFAULT NOW(),
    updated_at      DATETIME,
    PRIMARY KEY (id_aluno),
    UNIQUE KEY uq_aluno_cpf   (cpf),
    UNIQUE KEY uq_aluno_email (email),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3ª: instrutor (sem FK)
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

-- 4ª: plano (sem FK)
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

-- 5ª: modalidade (sem FK)
CREATE TABLE modalidade (
    id_modalidade     INT          NOT NULL AUTO_INCREMENT,
    nome              VARCHAR(80)  NOT NULL,
    descricao         TEXT,
    duracao_minutos   SMALLINT     NOT NULL,
    capacidade_maxima SMALLINT     NOT NULL,
    ativo             TINYINT(1)   NOT NULL DEFAULT 1,
    created_at        DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_modalidade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6ª: exercicio (sem FK)
CREATE TABLE exercicio (
    id_exercicio   INT          NOT NULL AUTO_INCREMENT,
    nome           VARCHAR(100) NOT NULL,
    grupo_muscular VARCHAR(80),
    descricao      TEXT,
    equipamento    VARCHAR(100),
    PRIMARY KEY (id_exercicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7ª: matricula (FK → aluno, plano)
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
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)   ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano)   ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8ª: pagamento (FK → matricula)
CREATE TABLE pagamento (
    id_pagamento    INT           NOT NULL AUTO_INCREMENT,
    id_matricula    INT           NOT NULL,
    valor           DECIMAL(10,2) NOT NULL,
    data_vencimento DATE          NOT NULL,
    data_pagamento  DATE,
    forma_pagamento ENUM('pix','cartao_credito','cartao_debito','dinheiro','boleto'),
    status          ENUM('pendente','pago','atrasado','cancelado') NOT NULL DEFAULT 'pendente',
    parcela_numero  TINYINT       NOT NULL,
    created_at      DATETIME      NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_pagamento),
    -- CORREÇÃO: impede parcela duplicada para a mesma matrícula
    UNIQUE KEY uq_pagamento_parcela (id_matricula, parcela_numero),
    FOREIGN KEY (id_matricula) REFERENCES matricula(id_matricula) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9ª: treino (FK → aluno, instrutor, modalidade)
CREATE TABLE treino (
    id_treino     INT          NOT NULL AUTO_INCREMENT,
    id_aluno      INT          NOT NULL,
    id_instrutor  INT          NOT NULL,
    id_modalidade INT          NOT NULL,
    nome          VARCHAR(100),
    objetivo      VARCHAR(200),
    nivel         ENUM('iniciante','intermediario','avancado'),
    data_inicio   DATE,
    data_fim      DATE,
    ativo         TINYINT(1)   NOT NULL DEFAULT 1,
    created_at    DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_treino),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_instrutor)  REFERENCES instrutor(id_instrutor)   ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10ª: treino_exercicio (FK → treino, exercicio)
CREATE TABLE treino_exercicio (
    id_treino_exercicio INT          NOT NULL AUTO_INCREMENT,
    id_treino           INT          NOT NULL,
    id_exercicio        INT          NOT NULL,
    series              TINYINT,
    repeticoes          TINYINT,
    carga_kg            DECIMAL(5,2) NOT NULL DEFAULT 0,
    descanso_seg        SMALLINT,
    ordem               TINYINT      NOT NULL,
    observacoes         TEXT,
    PRIMARY KEY (id_treino_exercicio),
    FOREIGN KEY (id_treino)    REFERENCES treino(id_treino)       ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_exercicio) REFERENCES exercicio(id_exercicio) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11ª: frequencia (FK → aluno, modalidade)
CREATE TABLE frequencia (
    id_frequencia     INT      NOT NULL AUTO_INCREMENT,
    id_aluno          INT      NOT NULL,
    id_modalidade     INT      NOT NULL,
    data_hora_entrada DATETIME NOT NULL,
    data_hora_saida   DATETIME,
    observacoes       TEXT,
    PRIMARY KEY (id_frequencia),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12ª: avaliacao_fisica (FK → aluno, instrutor)
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

-- 13ª: aluno_modalidade (FK → aluno, modalidade)
CREATE TABLE aluno_modalidade (
    id_aluno_modalidade INT      NOT NULL AUTO_INCREMENT,
    id_aluno            INT      NOT NULL,
    id_modalidade       INT      NOT NULL,
    data_inicio         DATE     NOT NULL,
    ativo               TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id_aluno_modalidade),
    -- CORREÇÃO: impede vínculo duplicado ativo entre aluno e modalidade
    UNIQUE KEY uq_aluno_modalidade (id_aluno, id_modalidade),
    FOREIGN KEY (id_aluno)      REFERENCES aluno(id_aluno)           ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 14ª: pagamento_log (FK → pagamento)
CREATE TABLE pagamento_log (
    id_log          INT      NOT NULL AUTO_INCREMENT,
    id_pagamento    INT      NOT NULL,
    status_anterior VARCHAR(20),
    status_novo     VARCHAR(20),
    alterado_em     DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id_log),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- BLOCO 4 — INDEXES COMPOSTOS
-- ============================================================

ALTER TABLE matricula
    ADD INDEX idx_matricula_aluno_status (id_aluno, status);

ALTER TABLE frequencia
    ADD INDEX idx_frequencia_aluno_entrada (id_aluno, data_hora_entrada);

ALTER TABLE pagamento
    ADD INDEX idx_pagamento_matricula_status (id_matricula, status);

-- ============================================================
-- BLOCO 5 — TRIGGERS
-- ============================================================

DELIMITER $$

-- TRIGGER 1: Calcula IMC automaticamente antes de inserir avaliação
CREATE TRIGGER trg_calcular_imc
BEFORE INSERT ON avaliacao_fisica
FOR EACH ROW
BEGIN
    IF NEW.altura_cm > 0 THEN
        SET NEW.imc = ROUND(NEW.peso_kg / POWER(NEW.altura_cm / 100, 2), 2);
    END IF;
END$$

-- TRIGGER 2: Atualiza updated_at do aluno automaticamente
CREATE TRIGGER trg_updated_at_aluno
BEFORE UPDATE ON aluno
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END$$

-- TRIGGER 3: Atualiza updated_at da matrícula automaticamente
-- CORREÇÃO: trigger estava com conteúdo trocado — corrigido
CREATE TRIGGER trg_updated_at_matricula
BEFORE UPDATE ON matricula
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END$$

-- TRIGGER 4: Encerra matrícula quando TODAS as parcelas não canceladas são pagas
-- CORREÇÃO: contagem agora ignora parcelas canceladas para fechar corretamente
CREATE TRIGGER trg_status_apos_pagamento
AFTER UPDATE ON pagamento
FOR EACH ROW
BEGIN
    DECLARE v_total INT;
    DECLARE v_pagos INT;

    IF NEW.status = 'pago' AND OLD.status != 'pago' THEN
        SELECT COUNT(*) INTO v_total
        FROM pagamento
        WHERE id_matricula = NEW.id_matricula
          AND status != 'cancelado';

        SELECT COUNT(*) INTO v_pagos
        FROM pagamento
        WHERE id_matricula = NEW.id_matricula
          AND status = 'pago';

        IF v_total > 0 AND v_total = v_pagos THEN
            UPDATE matricula
            SET status = 'encerrada', updated_at = NOW()
            WHERE id_matricula = NEW.id_matricula
              AND status = 'ativa';
        END IF;
    END IF;
END$$

-- TRIGGER 5: Registra log de mudança de status do pagamento
CREATE TRIGGER trg_log_pagamento
AFTER UPDATE ON pagamento
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO pagamento_log (id_pagamento, status_anterior, status_novo)
        VALUES (NEW.id_pagamento, OLD.status, NEW.status);
    END IF;
END$$

-- TRIGGER 6: Bloqueia reversão de pagamento já pago
CREATE TRIGGER trg_bloquear_reversao_pagamento
BEFORE UPDATE ON pagamento
FOR EACH ROW
BEGIN
    IF OLD.status = 'pago' AND NEW.status != 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento já efetuado não pode ser revertido.';
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- BLOCO 6 — FUNCTIONS
-- ============================================================

DELIMITER $$

-- FUNCTION 1: Calcula IMC (DETERMINISTIC — só depende dos parâmetros)
CREATE FUNCTION fn_calcular_imc(
    peso      DECIMAL(5,2),
    altura_cm DECIMAL(5,2)
) RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    RETURN ROUND(peso / POWER(altura_cm / 100, 2), 2);
END$$

-- FUNCTION 2: Retorna idade atual do aluno
-- CORREÇÃO: removido DETERMINISTIC pois depende de CURDATE()
CREATE FUNCTION fn_idade_aluno(
    p_id_aluno INT
) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_idade INT;
    SELECT TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())
    INTO v_idade
    FROM aluno
    WHERE id_aluno = p_id_aluno;
    RETURN v_idade;
END$$

-- FUNCTION 3: Retorna receita total de pagamentos pagos em um mês
-- CORREÇÃO: removido DETERMINISTIC pois depende de dados da tabela
CREATE FUNCTION fn_receita_mes(
    p_ano INT,
    p_mes INT
) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_receita DECIMAL(10,2);
    SELECT COALESCE(SUM(valor), 0)
    INTO v_receita
    FROM pagamento
    WHERE status = 'pago'
      AND YEAR(data_pagamento)  = p_ano
      AND MONTH(data_pagamento) = p_mes;
    RETURN v_receita;
END$$

-- FUNCTION 4: Retorna dias até (ou desde) o vencimento de um pagamento
-- CORREÇÃO: removido DETERMINISTIC pois depende de CURDATE()
CREATE FUNCTION fn_dias_ate_vencimento(
    p_id_pagamento INT
) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_dias INT;
    SELECT DATEDIFF(data_vencimento, CURDATE())
    INTO v_dias
    FROM pagamento
    WHERE id_pagamento = p_id_pagamento;
    RETURN v_dias;
END$$

-- FUNCTION 5: Retorna status da matrícula ativa do aluno
-- CORREÇÃO: removido DETERMINISTIC pois depende de dados da tabela
CREATE FUNCTION fn_status_matricula(
    p_id_aluno INT
) RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_status VARCHAR(20);
    SELECT status INTO v_status
    FROM matricula
    WHERE id_aluno = p_id_aluno
      AND status = 'ativa'
    LIMIT 1;
    IF v_status IS NULL THEN
        SET v_status = 'sem matricula ativa';
    END IF;
    RETURN v_status;
END$$

-- FUNCTION 6: Retorna valor da mensalidade de um plano
-- CORREÇÃO: removido DETERMINISTIC pois depende de dados da tabela
CREATE FUNCTION fn_calcular_mensalidade(
    p_id_plano INT
) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_valor DECIMAL(10,2);
    SELECT valor INTO v_valor
    FROM plano
    WHERE id_plano = p_id_plano;
    RETURN v_valor;
END$$

DELIMITER ;

-- ============================================================
-- BLOCO 7 — STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- PROCEDURE 1: Gera parcelas de uma matrícula
CREATE PROCEDURE sp_gerar_parcelas(
    IN p_id_matricula INT,
    IN p_duracao      INT,
    IN p_valor        DECIMAL(10,2),
    IN p_data_inicio  DATE
)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= p_duracao DO
        INSERT INTO pagamento (id_matricula, valor, data_vencimento, status, parcela_numero)
        VALUES (p_id_matricula, p_valor,
                DATE_ADD(p_data_inicio, INTERVAL i MONTH),
                'pendente', i);
        SET i = i + 1;
    END WHILE;
END$$

-- PROCEDURE 2: Ativa matrícula e gera parcelas automaticamente
-- CORREÇÃO: agora valida se o plano existe antes de prosseguir
CREATE PROCEDURE sp_ativar_matricula(
    IN p_id_aluno    INT,
    IN p_id_plano    INT,
    IN p_data_inicio DATE
)
BEGIN
    DECLARE v_duracao      INT;
    DECLARE v_valor        DECIMAL(10,2);
    DECLARE v_id_matricula INT;
    DECLARE v_data_fim     DATE;
    DECLARE v_plano_existe INT;

    -- CORREÇÃO: valida se o plano existe e está ativo
    SELECT COUNT(*) INTO v_plano_existe
    FROM plano WHERE id_plano = p_id_plano AND ativo = 1;

    IF v_plano_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano não encontrado ou inativo.';
    END IF;

    START TRANSACTION;

    SELECT duracao_meses, valor
    INTO v_duracao, v_valor
    FROM plano WHERE id_plano = p_id_plano;

    SET v_data_fim = DATE_ADD(p_data_inicio, INTERVAL v_duracao MONTH);

    INSERT INTO matricula (id_aluno, id_plano, data_inicio, data_fim, valor_plano_contratado, status)
    VALUES (p_id_aluno, p_id_plano, p_data_inicio, v_data_fim, v_valor, 'ativa');

    SET v_id_matricula = LAST_INSERT_ID();

    CALL sp_gerar_parcelas(v_id_matricula, v_duracao, v_valor, p_data_inicio);

    COMMIT;
END$$

-- PROCEDURE 3: Cancela matrícula e parcelas pendentes
CREATE PROCEDURE sp_cancelar_matricula(
    IN  p_id_matricula INT,
    OUT p_mensagem     VARCHAR(100)
)
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT status INTO v_status
    FROM matricula WHERE id_matricula = p_id_matricula;

    IF v_status IS NULL THEN
        SET p_mensagem = 'Matrícula não encontrada.';
    ELSEIF v_status = 'cancelada' THEN
        SET p_mensagem = 'Matrícula já está cancelada.';
    ELSE
        START TRANSACTION;

        UPDATE matricula
        SET status = 'cancelada', updated_at = NOW()
        WHERE id_matricula = p_id_matricula;

        UPDATE pagamento
        SET status = 'cancelado'
        WHERE id_matricula = p_id_matricula
          AND status = 'pendente';

        COMMIT;
        SET p_mensagem = 'Matrícula cancelada com sucesso.';
    END IF;
END$$

-- PROCEDURE 4: Renova matrícula
CREATE PROCEDURE sp_renovar_matricula(
    IN p_id_matricula  INT,
    IN p_id_plano_novo INT
)
BEGIN
    DECLARE v_id_aluno     INT;
    DECLARE v_data_fim     DATE;
    DECLARE v_duracao      INT;
    DECLARE v_valor        DECIMAL(10,2);
    DECLARE v_id_nova      INT;

    START TRANSACTION;

    SELECT id_aluno, data_fim INTO v_id_aluno, v_data_fim
    FROM matricula WHERE id_matricula = p_id_matricula;

    SELECT duracao_meses, valor INTO v_duracao, v_valor
    FROM plano WHERE id_plano = p_id_plano_novo;

    UPDATE matricula
    SET status = 'encerrada', updated_at = NOW()
    WHERE id_matricula = p_id_matricula;

    INSERT INTO matricula (id_aluno, id_plano, data_inicio, data_fim, valor_plano_contratado, status)
    VALUES (v_id_aluno, p_id_plano_novo, v_data_fim,
            DATE_ADD(v_data_fim, INTERVAL v_duracao MONTH), v_valor, 'ativa');

    SET v_id_nova = LAST_INSERT_ID();

    CALL sp_gerar_parcelas(v_id_nova, v_duracao, v_valor, v_data_fim);

    COMMIT;
END$$

-- PROCEDURE 5: Registra pagamento de uma parcela
CREATE PROCEDURE sp_registrar_pagamento(
    IN p_id_pagamento   INT,
    IN p_forma          VARCHAR(20)
)
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT status INTO v_status
    FROM pagamento WHERE id_pagamento = p_id_pagamento;

    IF v_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento não encontrado.';
    ELSEIF v_status = 'pago' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento já foi efetuado.';
    ELSEIF v_status = 'cancelado' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento cancelado não pode ser efetivado.';
    ELSE
        UPDATE pagamento
        SET status          = 'pago',
            data_pagamento  = CURDATE(),
            forma_pagamento = p_forma
        WHERE id_pagamento = p_id_pagamento;
    END IF;
END$$

DELIMITER ;

-- ============================================================
-- BLOCO 8 — DML: INSERT (dados de teste)
-- ============================================================

-- Endereços
INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
('Rua das Flores',     '123', 'Apto 12', 'Centro',              'Salvador', 'BA', '40010000'),
('Av. Paralela',       '456', NULL,       'Pituba',              'Salvador', 'BA', '41730000'),
('Rua da Paz',         '789', 'Casa 2',  'Barra',               'Salvador', 'BA', '40140000'),
('Rua São João',       '321', NULL,       'Ondina',              'Salvador', 'BA', '40170000'),
('Av. Oceânica',       '654', 'Bloco B', 'Ondina',              'Salvador', 'BA', '40170010'),
('Rua do Comércio',    '987', NULL,       'Comércio',            'Salvador', 'BA', '40010100'),
('Rua Nova',           '111', 'Apto 5',  'Itaigara',            'Salvador', 'BA', '41815000'),
('Av. Tancredo Neves', '222', NULL,       'Caminho das Árvores', 'Salvador', 'BA', '41820000'),
('Rua das Acácias',    '333', 'Casa 1',  'Federação',           'Salvador', 'BA', '40230000'),
('Av. Garibaldi',      '444', NULL,       'Graça',               'Salvador', 'BA', '40150000');

-- Alunos
INSERT INTO aluno (nome, cpf, data_nascimento, sexo, telefone, email, id_endereco, status) VALUES
('Ana Carolina Silva',    '12345678901', '1995-03-15', 'F', '71991110001', 'ana.silva@email.com',       1, 'ativo'),
('Bruno Oliveira Santos', '23456789012', '1990-07-22', 'M', '71991110002', 'bruno.santos@email.com',    2, 'ativo'),
('Carla Mendes Lima',     '34567890123', '1998-11-08', 'F', '71991110003', 'carla.lima@email.com',      3, 'ativo'),
('Diego Ferreira Costa',  '45678901234', '1988-05-30', 'M', '71991110004', 'diego.costa@email.com',     4, 'ativo'),
('Elaine Rocha Pereira',  '56789012345', '2000-01-20', 'F', '71991110005', 'elaine.pereira@email.com',  5, 'ativo'),
('Felipe Souza Alves',    '67890123456', '1993-09-14', 'M', '71991110006', 'felipe.alves@email.com',    6, 'ativo'),
('Gabriela Lima Torres',  '78901234567', '1997-04-25', 'F', '71991110007', 'gabriela.torres@email.com', 7, 'ativo'),
('Henrique Nunes Castro', '89012345678', '1985-12-03', 'M', '71991110008', 'henrique.castro@email.com', 8, 'ativo'),
('Isabela Cruz Martins',  '90123456789', '2001-06-18', 'F', '71991110009', 'isabela.martins@email.com', 9, 'ativo'),
('João Pedro Ramos',      '01234567890', '1992-08-07', 'M', '71991110010', 'joao.ramos@email.com',     10, 'ativo');

-- Instrutores
INSERT INTO instrutor (nome, cpf, cref, especialidade, telefone, email, salario, data_admissao, status) VALUES
('Ricardo Almeida',    '11122233344', 'CREF001/BA', 'Musculação e Hipertrofia',  '71992220001', 'ricardo.almeida@gym.com',   3500.00, '2020-01-10', 'ativo'),
('Patrícia Borges',    '22233344455', 'CREF002/BA', 'Yoga e Pilates',            '71992220002', 'patricia.borges@gym.com',   3200.00, '2020-03-15', 'ativo'),
('Marcos Vinicius',    '33344455566', 'CREF003/BA', 'Spinning e Cardio',         '71992220003', 'marcos.vinicius@gym.com',   3000.00, '2021-02-01', 'ativo'),
('Fernanda Cardoso',   '44455566677', 'CREF004/BA', 'Funcional e CrossFit',      '71992220004', 'fernanda.cardoso@gym.com',  3800.00, '2019-08-20', 'ativo'),
('Lucas Mendonça',     '55566677788', 'CREF005/BA', 'Natação e Aqua Fitness',    '71992220005', 'lucas.mendonca@gym.com',    3300.00, '2021-06-10', 'ativo'),
('Tatiane Souza',      '66677788899', 'CREF006/BA', 'Dança e Zumba',             '71992220006', 'tatiane.souza@gym.com',     2900.00, '2022-01-05', 'ativo'),
('Rafael Gomes',       '77788899900', 'CREF007/BA', 'Musculação e Powerlifting', '71992220007', 'rafael.gomes@gym.com',      4000.00, '2018-11-12', 'ativo'),
('Camila Freitas',     '88899900011', 'CREF008/BA', 'Pilates e Alongamento',     '71992220008', 'camila.freitas@gym.com',    3100.00, '2022-05-20', 'ativo'),
('Anderson Lima',      '99900011122', 'CREF009/BA', 'Boxe e Artes Marciais',     '71992220009', 'anderson.lima@gym.com',     3600.00, '2020-09-15', 'ativo'),
('Juliana Nascimento', '00011122233', 'CREF010/BA', 'Nutrição Esportiva',        '71992220010', 'juliana.nascimento@gym.com',3400.00, '2021-11-01', 'ativo');

-- Planos
INSERT INTO plano (nome, descricao, duracao_meses, valor, limite_modalidades) VALUES
('Mensal Básico',  'Acesso a 1 modalidade por mês',        1,   99.90,  1),
('Mensal Plus',    'Acesso a 3 modalidades por mês',        1,  149.90,  3),
('Trimestral',     'Acesso a 3 modalidades por trimestre',  3,  399.90,  3),
('Semestral',      'Acesso ilimitado por semestre',         6,  699.90,  5),
('Anual Premium',  'Acesso ilimitado a todas modalidades', 12,  999.90, 10);

-- Modalidades
INSERT INTO modalidade (nome, descricao, duracao_minutos, capacidade_maxima) VALUES
('Musculação', 'Treino com pesos e máquinas',          60, 30),
('Yoga',       'Equilíbrio corpo e mente',             60, 20),
('Pilates',    'Fortalecimento e postura',             55, 15),
('Spinning',   'Ciclismo indoor de alta intensidade',  45, 25),
('Natação',    'Treino aquático completo',             60, 20),
('Boxe',       'Treino de boxe e defesa pessoal',      60, 15),
('CrossFit',   'Treino funcional de alta intensidade', 60, 20),
('Zumba',      'Dança fitness animada',                50, 30),
('Funcional',  'Treino funcional com peso corporal',   50, 25),
('Dança',      'Aulas de diversos ritmos',             60, 25);

-- Exercícios
INSERT INTO exercicio (nome, grupo_muscular, descricao, equipamento) VALUES
('Supino Reto',       'Peitoral',    'Exercício para peitoral com barra',        'Barra e banco'),
('Agachamento Livre', 'Pernas',      'Agachamento com barra nas costas',         'Barra e rack'),
('Rosca Direta',      'Bíceps',      'Curl com barra para bíceps',               'Barra'),
('Tríceps Pulley',    'Tríceps',     'Extensão de tríceps no cabo',              'Pulley'),
('Puxada Frontal',    'Costas',      'Puxada na máquina para costas',            'Pulley'),
('Leg Press',         'Pernas',      'Prensa para quadríceps e glúteos',         'Máquina'),
('Desenvolvimento',   'Ombros',      'Pressão para ombros com halteres',         'Halteres'),
('Cadeira Extensora', 'Pernas',      'Extensão de joelhos para quadríceps',      'Máquina'),
('Stiff',             'Posterior',   'Exercício para posterior de coxa',         'Barra'),
('Prancha',           'Core',        'Isometria para abdômen e core',            'Nenhum'),
('Barra Fixa',        'Costas',      'Puxada no peso corporal',                  'Barra fixa'),
('Flexão de Braço',   'Peitoral',    'Exercício no peso corporal',               'Nenhum'),
('Abdominais',        'Core',        'Exercício para abdômen',                   'Colchonete'),
('Remada Curvada',    'Costas',      'Remada com barra para costas',             'Barra'),
('Elevação Lateral',  'Ombros',      'Elevação com halteres para ombros',        'Halteres'),
('Panturrilha',       'Panturrilha', 'Elevação de panturrilha em pé',            'Máquina'),
('Crucifixo',         'Peitoral',    'Abertura com halteres para peitoral',      'Halteres e banco'),
('Hack Squat',        'Pernas',      'Agachamento na máquina hack',              'Máquina'),
('Hiperextensão',     'Lombar',      'Exercício para lombar',                    'Banco romano'),
('Burpee',            'Corpo todo',  'Exercício funcional completo',             'Nenhum');

-- Matrículas
INSERT INTO matricula (id_aluno, id_plano, data_inicio, data_fim, valor_plano_contratado, status) VALUES
(1,  2, '2024-01-01', '2024-02-01',  149.90, 'encerrada'),
(1,  3, '2024-02-01', '2024-05-01',  399.90, 'encerrada'),
(1,  4, '2024-05-01', '2024-11-01',  699.90, 'ativa'),
(2,  1, '2024-03-01', '2024-04-01',   99.90, 'encerrada'),
(2,  3, '2024-04-01', '2024-07-01',  399.90, 'ativa'),
(3,  5, '2024-01-15', '2025-01-15',  999.90, 'ativa'),
(4,  2, '2024-02-10', '2024-03-10',  149.90, 'cancelada'),
(4,  3, '2024-06-01', '2024-09-01',  399.90, 'ativa'),
(5,  1, '2024-04-01', '2024-05-01',   99.90, 'encerrada'),
(5,  4, '2024-05-01', '2024-11-01',  699.90, 'ativa'),
(6,  2, '2024-03-15', '2024-04-15',  149.90, 'suspensa'),
(7,  5, '2024-01-01', '2025-01-01',  999.90, 'ativa'),
(8,  1, '2024-05-01', '2024-06-01',   99.90, 'encerrada'),
(8,  2, '2024-06-01', '2024-07-01',  149.90, 'ativa'),
(9,  3, '2024-02-01', '2024-05-01',  399.90, 'encerrada'),
(9,  4, '2024-05-01', '2024-11-01',  699.90, 'ativa'),
(10, 5, '2024-01-01', '2025-01-01',  999.90, 'ativa');

-- Pagamentos
INSERT INTO pagamento (id_matricula, valor, data_vencimento, data_pagamento, forma_pagamento, status, parcela_numero) VALUES
(1,  149.90, '2024-01-01', '2024-01-05', 'pix',            'pago',     1),
(2,  399.90, '2024-02-01', '2024-02-03', 'cartao_credito', 'pago',     1),
(2,  399.90, '2024-03-01', '2024-03-10', 'cartao_credito', 'pago',     2),
(2,  399.90, '2024-04-01', '2024-04-08', 'cartao_credito', 'pago',     3),
(3,  699.90, '2024-05-01', '2024-05-02', 'pix',            'pago',     1),
(3,  699.90, '2024-06-01', '2024-06-05', 'pix',            'pago',     2),
(3,  699.90, '2024-07-01', '2024-07-03', 'dinheiro',       'pago',     3),
(3,  699.90, '2024-08-01', '2024-08-07', 'pix',            'pago',     4),
(3,  699.90, '2024-09-01', NULL,          NULL,             'atrasado', 5),
(3,  699.90, '2024-10-01', NULL,          NULL,             'pendente', 6),
(4,   99.90, '2024-03-01', '2024-03-02', 'dinheiro',       'pago',     1),
(5,  399.90, '2024-04-01', '2024-04-05', 'boleto',         'pago',     1),
(5,  399.90, '2024-05-01', '2024-05-10', 'boleto',         'pago',     2),
(5,  399.90, '2024-06-01', NULL,          NULL,             'atrasado', 3),
(6,  999.90, '2024-01-15', '2024-01-15', 'cartao_credito', 'pago',     1),
(6,  999.90, '2024-02-15', '2024-02-15', 'cartao_credito', 'pago',     2),
(6,  999.90, '2024-03-15', '2024-03-15', 'cartao_credito', 'pago',     3),
(6,  999.90, '2024-04-15', '2024-04-15', 'cartao_credito', 'pago',     4),
(6,  999.90, '2024-05-15', '2024-05-15', 'cartao_credito', 'pago',     5),
(6,  999.90, '2024-06-15', NULL,          NULL,             'atrasado', 6),
(12, 999.90, '2024-01-01', '2024-01-03', 'pix',            'pago',     1),
(12, 999.90, '2024-02-01', '2024-02-04', 'pix',            'pago',     2),
(12, 999.90, '2024-03-01', '2024-03-02', 'pix',            'pago',     3),
(12, 999.90, '2024-04-01', NULL,          NULL,             'atrasado', 4),
(12, 999.90, '2024-05-01', NULL,          NULL,             'pendente', 5),
(17, 999.90, '2024-01-01', '2024-01-10', 'cartao_debito',  'pago',     1),
(17, 999.90, '2024-02-01', '2024-02-08', 'cartao_debito',  'pago',     2),
(17, 999.90, '2024-03-01', '2024-03-05', 'cartao_debito',  'pago',     3),
(17, 999.90, '2024-04-01', NULL,          NULL,             'pendente', 4);

-- Treinos
INSERT INTO treino (id_aluno, id_instrutor, id_modalidade, nome, objetivo, nivel, data_inicio, data_fim) VALUES
(1,  1, 1, 'Treino A - Peito e Tríceps', 'Hipertrofia',     'intermediario', '2024-05-01', '2024-08-01'),
(1,  1, 1, 'Treino B - Costas e Bíceps', 'Hipertrofia',     'intermediario', '2024-05-01', '2024-08-01'),
(2,  1, 1, 'Treino Full Body',            'Emagrecimento',  'iniciante',     '2024-04-01', '2024-07-01'),
(3,  2, 2, 'Yoga Relaxamento',            'Flexibilidade',  'iniciante',     '2024-01-15', '2024-07-15'),
(3,  4, 7, 'CrossFit Iniciante',          'Condicionamento','iniciante',     '2024-03-01', '2024-06-01'),
(4,  1, 1, 'Treino Força',               'Força máxima',   'avancado',      '2024-06-01', '2024-09-01'),
(5,  3, 4, 'Spinning HIIT',              'Cardio',         'intermediario', '2024-05-01', '2024-08-01'),
(6,  2, 3, 'Pilates Postura',            'Postura',        'iniciante',     '2024-03-15', '2024-06-15'),
(7,  4, 7, 'CrossFit Avançado',          'Performance',    'avancado',      '2024-01-01', '2024-07-01'),
(8,  1, 1, 'Treino Hipertrofia',         'Hipertrofia',    'intermediario', '2024-06-01', '2024-09-01'),
(9,  3, 4, 'Spinning Resistência',       'Resistência',    'intermediario', '2024-05-01', '2024-08-01'),
(10, 4, 9, 'Funcional Completo',         'Condicionamento','avancado',       '2024-01-01', '2024-07-01');

-- Treino x Exercício
INSERT INTO treino_exercicio (id_treino, id_exercicio, series, repeticoes, carga_kg, descanso_seg, ordem) VALUES
(1,  1, 4, 10, 60.0, 90, 1), (1, 17, 3, 12, 14.0, 60, 2),
(1,  4, 3, 15, 20.0, 60, 3), (1, 12, 3, 20,  0.0, 45, 4),
(2,  5, 4, 10, 50.0, 90, 1), (2, 14, 3, 12, 40.0, 60, 2),
(2, 11, 3,  8,  0.0, 90, 3), (2,  3, 3, 12, 20.0, 60, 4),
(3,  2, 3, 15, 40.0, 60, 1), (3,  1, 3, 12, 40.0, 60, 2),
(3, 13, 3, 20,  0.0, 45, 3), (3, 10, 3, 30,  0.0, 45, 4),
(6,  2, 5,  5,100.0,120, 1), (6,  1, 5,  5, 80.0,120, 2),
(6, 14, 4,  6, 60.0, 90, 3),
(9, 20, 5, 10,  0.0, 30, 1), (9, 12, 5, 15,  0.0, 30, 2),
(9, 13, 5, 20,  0.0, 30, 3), (9, 10, 3, 60,  0.0, 45, 4),
(10, 1, 4, 10, 70.0, 90, 1), (10, 6, 4, 10, 80.0, 90, 2),
(10, 8, 3, 12, 50.0, 60, 3), (10, 9, 3, 12, 50.0, 60, 4),
(10,16, 4, 20, 30.0, 45, 5);

-- Frequência
INSERT INTO frequencia (id_aluno, id_modalidade, data_hora_entrada, data_hora_saida) VALUES
(1, 1,'2024-05-06 07:00:00','2024-05-06 08:05:00'),
(1, 1,'2024-05-08 07:00:00','2024-05-08 08:10:00'),
(1, 1,'2024-05-10 07:00:00','2024-05-10 08:00:00'),
(1, 1,'2024-05-13 07:00:00','2024-05-13 08:15:00'),
(1, 1,'2024-05-15 07:00:00','2024-05-15 08:05:00'),
(2, 1,'2024-04-02 08:00:00','2024-04-02 09:00:00'),
(2, 1,'2024-04-05 08:00:00','2024-04-05 09:10:00'),
(2, 1,'2024-04-08 08:00:00','2024-04-08 09:00:00'),
(3, 2,'2024-02-01 09:00:00','2024-02-01 10:00:00'),
(3, 2,'2024-02-05 09:00:00','2024-02-05 10:05:00'),
(3, 7,'2024-03-04 10:00:00','2024-03-04 11:00:00'),
(3, 7,'2024-03-06 10:00:00','2024-03-06 11:05:00'),
(4, 1,'2024-06-03 06:00:00','2024-06-03 07:10:00'),
(4, 1,'2024-06-05 06:00:00','2024-06-05 07:05:00'),
(5, 4,'2024-05-02 18:00:00','2024-05-02 18:50:00'),
(5, 4,'2024-05-04 18:00:00','2024-05-04 18:45:00'),
(5, 4,'2024-05-06 18:00:00','2024-05-06 18:50:00'),
(6, 3,'2024-03-16 10:00:00','2024-03-16 10:55:00'),
(6, 3,'2024-03-19 10:00:00','2024-03-19 10:50:00'),
(7, 7,'2024-01-03 07:00:00','2024-01-03 08:00:00'),
(7, 7,'2024-01-05 07:00:00','2024-01-05 08:05:00'),
(7, 7,'2024-01-08 07:00:00','2024-01-08 08:00:00'),
(7, 7,'2024-01-10 07:00:00','2024-01-10 08:10:00'),
(8, 1,'2024-06-02 17:00:00','2024-06-02 18:05:00'),
(8, 1,'2024-06-04 17:00:00','2024-06-04 18:00:00'),
(9, 4,'2024-05-03 19:00:00','2024-05-03 19:50:00'),
(9, 4,'2024-05-07 19:00:00','2024-05-07 19:45:00'),
(10,9,'2024-01-02 06:00:00','2024-01-02 06:55:00'),
(10,9,'2024-01-04 06:00:00','2024-01-04 06:50:00'),
(10,9,'2024-01-06 06:00:00','2024-01-06 06:55:00');

-- Avaliações físicas (IMC calculado automaticamente pelo trigger)
INSERT INTO avaliacao_fisica (id_aluno, id_instrutor, data_avaliacao, peso_kg, altura_cm, percentual_gordura, massa_muscular_kg, circunferencia_abdominal, pressao_arterial, fc_repouso) VALUES
(1,  1, '2024-05-01', 65.0, 165.0, 22.0, 45.0, 72.0, '120/80', 68),
(1,  1, '2024-08-01', 63.0, 165.0, 20.0, 46.5, 70.0, '118/78', 65),
(2,  1, '2024-04-01', 80.0, 178.0, 25.0, 58.0, 88.0, '125/82', 72),
(2,  1, '2024-07-01', 77.0, 178.0, 22.0, 60.0, 85.0, '122/80', 70),
(3,  2, '2024-01-15', 55.0, 160.0, 18.0, 42.0, 65.0, '110/70', 60),
(3,  2, '2024-07-15', 54.0, 160.0, 17.0, 43.0, 63.0, '108/70', 58),
(4,  1, '2024-06-01', 90.0, 182.0, 18.0, 72.0, 90.0, '130/85', 65),
(5,  3, '2024-05-01', 70.0, 170.0, 24.0, 50.0, 80.0, '120/78', 75),
(5,  3, '2024-08-01', 67.0, 170.0, 21.0, 52.0, 77.0, '118/76', 72),
(6,  2, '2024-03-15', 58.0, 162.0, 20.0, 43.0, 68.0, '115/75', 64),
(7,  4, '2024-01-01', 75.0, 175.0, 12.0, 65.0, 78.0, '118/76', 58),
(7,  4, '2024-06-01', 74.0, 175.0, 11.0, 66.0, 77.0, '116/74', 55),
(8,  1, '2024-06-01', 82.0, 180.0, 20.0, 64.0, 86.0, '122/80', 68),
(9,  3, '2024-05-01', 68.0, 168.0, 23.0, 48.0, 78.0, '119/77', 70),
(10, 4, '2024-01-01', 78.0, 176.0, 15.0, 63.0, 82.0, '120/78', 62);

-- ============================================================
-- BLOCO 9 — VIEWS
-- ============================================================

CREATE VIEW vw_alunos_ativos AS
SELECT a.id_aluno, a.nome, a.email, a.telefone,
       p.nome AS plano, m.data_inicio, m.data_fim,
       m.valor_plano_contratado
FROM aluno a
INNER JOIN matricula m ON a.id_aluno = m.id_aluno
INNER JOIN plano p     ON m.id_plano = p.id_plano
WHERE m.status = 'ativa'
ORDER BY a.nome;

CREATE VIEW vw_pagamentos_pendentes AS
SELECT a.nome AS aluno, a.telefone, p.nome AS plano,
       pg.valor, pg.data_vencimento, pg.parcela_numero, pg.status,
       DATEDIFF(CURDATE(), pg.data_vencimento) AS dias_atraso
FROM pagamento pg
INNER JOIN matricula m ON pg.id_matricula = m.id_matricula
INNER JOIN aluno a     ON m.id_aluno      = a.id_aluno
INNER JOIN plano p     ON m.id_plano      = p.id_plano
WHERE pg.status IN ('pendente','atrasado')
ORDER BY pg.data_vencimento;

CREATE VIEW vw_inadimplentes AS
SELECT a.nome AS aluno, a.email, a.telefone,
       COUNT(pg.id_pagamento) AS pagamentos_atrasados,
       SUM(pg.valor)          AS valor_em_atraso
FROM aluno a
INNER JOIN matricula m  ON a.id_aluno     = m.id_aluno
INNER JOIN pagamento pg ON m.id_matricula = pg.id_matricula
WHERE pg.status = 'atrasado'
GROUP BY a.id_aluno, a.nome, a.email, a.telefone
ORDER BY valor_em_atraso DESC;

CREATE VIEW vw_resumo_financeiro AS
SELECT MONTH(pg.data_vencimento) AS mes,
       YEAR(pg.data_vencimento)  AS ano,
       SUM(CASE WHEN pg.status='pago'     THEN pg.valor ELSE 0 END) AS total_recebido,
       SUM(CASE WHEN pg.status='pendente' THEN pg.valor ELSE 0 END) AS total_pendente,
       SUM(CASE WHEN pg.status='atrasado' THEN pg.valor ELSE 0 END) AS total_atrasado
FROM pagamento pg
GROUP BY YEAR(pg.data_vencimento), MONTH(pg.data_vencimento)
ORDER BY ano, mes;

CREATE VIEW vw_frequencia_alunos AS
SELECT a.nome AS aluno, mo.nome AS modalidade,
       COUNT(f.id_frequencia)   AS total_visitas,
       MAX(f.data_hora_entrada) AS ultima_visita
FROM aluno a
INNER JOIN frequencia f  ON a.id_aluno      = f.id_aluno
INNER JOIN modalidade mo ON f.id_modalidade = mo.id_modalidade
GROUP BY a.id_aluno, a.nome, mo.id_modalidade, mo.nome
ORDER BY total_visitas DESC;

CREATE VIEW vw_evolucao_fisica AS
SELECT a.nome AS aluno, af.data_avaliacao,
       af.peso_kg, af.altura_cm, af.imc,
       af.percentual_gordura, af.massa_muscular_kg
FROM aluno a
INNER JOIN avaliacao_fisica af ON a.id_aluno = af.id_aluno
ORDER BY a.nome, af.data_avaliacao;

-- ============================================================
-- FIM DO SCRIPT — GYM MANAGER
-- ============================================================

SET FOREIGN_KEY_CHECKS = 1;

SELECT 'Gym Manager instalado com sucesso!' AS status;
