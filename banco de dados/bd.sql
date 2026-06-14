CREATE DATABASE academia;
USE academia;

-- Tabela de alunos
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    data_nascimento DATE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de planos
CREATE TABLE planos (
    id_plano INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    tipo_de_plano VARCHAR(20) NOT NULL
);

-- Tabela de personais
CREATE TABLE personais (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cref VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- Tabela de treinos
CREATE TABLE treinos (
    id_treino INT AUTO_INCREMENT PRIMARY KEY,
    nome_treino VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_personal INT,
    FOREIGN KEY (id_personal) REFERENCES personais(id_personal)
);

-- Matrícula do aluno em um plano
CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    status ENUM('Ativa','Vencida','Cancelada')
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_plano) REFERENCES planos(id_plano)
);

-- Treinos atribuídos aos alunos
CREATE TABLE aluno_treino (
    id_aluno INT,
    id_treino INT,
    data_atribuicao DATE,
    PRIMARY KEY (id_aluno, id_treino),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_treino) REFERENCES treinos(id_treino)
);

-- Pagamentos
CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    metodo_pagamento VARCHAR(30),
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula)
);
-- Usuários
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('aluno','personal','admin') NOT NULL
);
-- Administradores
CREATE TABLE administradores (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,

    FOREIGN KEY (id_usuario)
    REFERENCES usuarios(id_usuario)
);

--Avaliações
CREATE TABLE avaliacoes (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT,
    peso DECIMAL(5,2),
    altura DECIMAL(4,2),
    percentual_gordura DECIMAL(5,2),
    data_avaliacao DATE,

    FOREIGN KEY (id_aluno)
    REFERENCES alunos(id_aluno)
);