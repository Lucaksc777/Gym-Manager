# Gym-Manager
Sistema de Gestão de Academia — Projeto de Banco de Dados MySQL

# 🏋️ Gym Manager — Sistema de Gestão de Academia

> Projeto acadêmico desenvolvido para a disciplina de **Banco de Dados** sob orientação do Prof. **Anildo Mattos**.

---

## 👥 Equipe

| Integrante | Responsabilidade |
|---|---|
| Lucas Kelvim | Arquiteto do banco — Modelagem, DDL e Normalização |
| Leonardo Badauê | Engenheiro de dados — DML e Dados de teste |
| Deivson Pires | Analista de consultas — SELECT e JOINs |
| Yan Mota | Engenheiro de views — Views e Functions |
| Micael Melo | Engenheiro de automação — Procedures, Triggers e Testes |
| Wendel | Documentador e Integrador — Relatório e Apresentação |

---

## 📋 Sobre o projeto

O **Gym Manager** é um sistema de gerenciamento de academia desenvolvido em **MySQL 8+**, capaz de controlar:

- 🧑 Alunos e Instrutores
- 📄 Planos e Matrículas
- 💰 Pagamentos e Inadimplência
- 🏃 Modalidades e Treinos
- 📅 Frequência dos alunos
- 📊 Avaliações Físicas

---

## 🗂️ Estrutura do projeto

sql/

├── ddl/         → CREATE TABLE, ALTER TABLE, DROP TABLE

├── dml/         → INSERT, UPDATE, DELETE

├── consultas/   → 15 consultas SELECT

├── joins/       → 10 JOINs (INNER e LEFT)

├── views/       → 6 Views gerenciais

├── functions/   → 6 Functions de negócio

├── procedures/  → 5 Stored Procedures

├── triggers/    → 6 Triggers automáticos

└── testes/      → Testes de integridade
docs/

├── diagrama_ER.png

└── GymManager_Relatorio_Final.docx


---

## 🛠️ Tecnologias

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![Workbench](https://img.shields.io/badge/MySQL_Workbench-8.0-orange)
![Git](https://img.shields.io/badge/Git-2.53-red?logo=git)

---

## 📊 Estatísticas do banco

| Item | Quantidade |
|---|---|
| Tabelas | 13 |
| Relacionamentos | 17 |
| Regras de negócio | 40 |
| Views | 6 |
| Functions | 6 |
| Stored Procedures | 5 |
| Triggers | 6 |
| Consultas SQL | 15 |
| JOINs | 10 |

---

## 🚀 Como executar

1. Instale o **MySQL 8+** e o **MySQL Workbench**
2. Clone o repositório:
```bash
   git clone https://github.com/Lucaksc777/Gym-Manager.git
```
3. Abra o Workbench e execute os scripts na ordem:
   - `sql/ddl/` → cria as tabelas
   - `sql/dml/` → insere os dados
   - `sql/views/`, `sql/functions/`, `sql/procedures/`, `sql/triggers/`
   - `sql/consultas/` e `sql/joins/` → executa as consultas

---

*Disciplina de Banco de Dados — 2026*
