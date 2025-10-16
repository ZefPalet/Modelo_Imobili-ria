/* Modelo Físico - Imobiliária */

CREATE TABLE Proprietario (
    id_proprietario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Inquilino (
    id_inquilino INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Imovel (
    id_imovel INT PRIMARY KEY AUTO_INCREMENT,
    endereco VARCHAR(150) NOT NULL,
    area DECIMAL(10,2),
    valor_aluguel DECIMAL(12,2),
    status VARCHAR(50),
    id_proprietario INT,
    FOREIGN KEY (id_proprietario) REFERENCES Proprietario(id_proprietario)
);

CREATE TABLE Casa (
    id_casa INT PRIMARY KEY AUTO_INCREMENT,
    fk_imovel INT UNIQUE,
    quartos INT,
    suites INT,
    garagem BOOLEAN,
    FOREIGN KEY (fk_imovel) REFERENCES Imovel(id_imovel) ON DELETE CASCADE
);

CREATE TABLE Apartamento (
    id_apartamento INT PRIMARY KEY AUTO_INCREMENT,
    fk_imovel INT UNIQUE,
    andar INT,
    numero INT,
    FOREIGN KEY (fk_imovel) REFERENCES Imovel(id_imovel) ON DELETE CASCADE
);

CREATE TABLE Comercial (
    id_comercial INT PRIMARY KEY AUTO_INCREMENT,
    fk_imovel INT UNIQUE,
    tipo_negocio VARCHAR(50),
    FOREIGN KEY (fk_imovel) REFERENCES Imovel(id_imovel) ON DELETE CASCADE
);

CREATE TABLE Contrato_de_Locacao (
    id_contrato INT PRIMARY KEY AUTO_INCREMENT,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    valor DECIMAL(12,2),
    id_imovel INT,
    id_inquilino INT,
    FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel),
    FOREIGN KEY (id_inquilino) REFERENCES Inquilino(id_inquilino)
);

-- Tabela associativa: Proprietário possui Imóvel
CREATE TABLE Possui (
    id_proprietario INT,
    id_imovel INT,
    PRIMARY KEY (id_proprietario, id_imovel),
    FOREIGN KEY (id_proprietario) REFERENCES Proprietario(id_proprietario) ON DELETE CASCADE,
    FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel) ON DELETE CASCADE
);

-- Associação entre apartamento e contrato
CREATE TABLE Tem_Contrato (
    id_apartamento INT,
    id_contrato INT,
    PRIMARY KEY (id_apartamento, id_contrato),
    FOREIGN KEY (id_apartamento) REFERENCES Apartamento(id_apartamento) ON DELETE CASCADE,
    FOREIGN KEY (id_contrato) REFERENCES Contrato_de_Locacao(id_contrato) ON DELETE CASCADE
);

-- Associação entre inquilino e contrato (quem assina)
CREATE TABLE Assina (
    id_inquilino INT,
    id_contrato INT,
    PRIMARY KEY (id_inquilino, id_contrato),
    FOREIGN KEY (id_inquilino) REFERENCES Inquilino(id_inquilino) ON DELETE CASCADE,
    FOREIGN KEY (id_contrato) REFERENCES Contrato_de_Locacao(id_contrato) ON DELETE CASCADE
);
