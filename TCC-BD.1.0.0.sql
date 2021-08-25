CREATE DATABASE BancoTCC
DROP DATABASE BancoTCC
USE BancoTCC
SET DATEFORMAT DMY


---------------------TABELAS---------------------
CREATE TABLE Usuario(
	idCarteira INT IDENTITY(1,1) NOT NULL PRIMARY KEY, --discutir isso aqui--
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	DataNasc DATE NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	Senha VARCHAR(24) NOT NULL,
	ChaveTemp VARCHAR(6) NOT NULL,
	DataChave DATE NOT NULL,
)

DROP TABLE Usuario

--noticias--

CREATE TABLE Interesse(
	idUsuario INT FOREIGN KEY 
		REFERENCES Usuario(idCarteira),
	idTags INT FOREIGN KEY
		REFERENCES Tags(idTags),
)

DROP TABLE Interesse

CREATE TABLE Tags(
	idTags INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NomeTag VARCHAR(20) NOT NULL,
	DescTag VARCHAR(50) NOT NULL
)

DROP TABLE Tags

CREATE TABLE Noticia(
	idNoticia INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Titulo VARCHAR(20) NOT NULL,
	DescNot VARCHAR(50) NOT NULL,
)

DROP TABLE Noticia

CREATE TABLE DetalheTagNoticia(
	idNoticia INT FOREIGN KEY
		REFERENCES Noticia(idNoticia),
	idTags INT FOREIGN KEY
		REFERENCES Tags(idTags),
)

DROP TABLE DetalheTagNoticia

--block--
CREATE TABLE Moeda(
	idMoeda INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NomeMoeda VARCHAR(15) NOT NULL UNIQUE,
	ValorMoeda MONEY NOT NULL,
)

DROP TABLE Moeda

CREATE TABLE HistoricoMoeda(
	idHistorico INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DataRegistro DATE NOT NULL,
	ValorData MONEY NOT NULL,
	idMoeda INT FOREIGN KEY
		REFERENCES Moeda(idMoeda),
)

DROP TABLE HistoricoMoeda

CREATE TABLE DetalheCarteira(
	Saldo NUMERIC(11,8) NOT NULL,
	idMoeda INT NOT NULL,
	idCarteira INT NOT NULL,
	CONSTRAINT PK_DestinoMoeda PRIMARY KEY(idMoeda, idCarteira),
	CONSTRAINT FK_Moeda FOREIGN KEY(idMoeda) REFERENCES Moeda(idMoeda),
	CONSTRAINT FK_Carteira FOREIGN KEY(idCarteira) REFERENCES Usuario(idCarteira)
)

ALTER TABLE DetalheCarteira
ADD CONSTRAINT PK_DestinoMoeda PRIMARY KEY(idCarteira, idMoeda)
ALTER TABLE DetalheCarteira
ADD CONSTRAINT FK_idMoeda FOREIGN KEY(idMoeda) REFERENCES Moeda(idMoeda)
ALTER TABLE DetalheCarteira
ADD CONSTRAINT FK_idCarteira FOREIGN KEY(idCarteira) REFERENCES Usuario(idCarteira)

DROP TABLE DetalheCarteira

CREATE TABLE Transacao(
	idTransacao INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Valor NUMERIC(11,8) NOT NULL,
	DataTrans DATE NOT NULL,
	Origem INT,
	TipoMoeda INT NOT NULL,
	Destino INT NOT NULL
)

ALTER TABLE Transacao
ADD CONSTRAINT FK_Origem FOREIGN KEY(Origem) REFERENCES Usuario(idCarteira)
ALTER TABLE Transacao
ADD CONSTRAINT FK_MoedaDestino FOREIGN KEY(TipoMoeda, Destino) REFERENCES DetalheCarteira(idMoeda, idCarteira)

DROP TABLE Transacao
--o tipo de transação (depósito, transferencia), seria um tipo de calculado--


---------------------INDEX---------------------
CREATE INDEX XUSUARIO ON Usuario (idCarteira)
CREATE INDEX XTAGS ON Tags (idTags)
CREATE INDEX XNOTICIA ON Noticia (idNoticia)
CREATE INDEX XMOEDA ON Moeda (idMoeda)
CREATE INDEX XHISTORICO ON HistoricoMoeda (idHistorico)
CREATE INDEX XTRANSACAO ON Transacao (idTransacao)


---------------------INSERTS---------------------
INSERT Usuario VALUES ('Joao', 'Joazinho@joan.com', '22.08.2002', '13782910257', 'abc123@','ITOUET', '07.06.2021')
INSERT Usuario VALUES ('Fernando', 'FERNANDO@pedro.NAN', '27.12.2003', '10947259461', 'abc123@','ORILPS', '07.06.2021')
INSERT Usuario VALUES ('Thiago', 'Thiago@harada.com', '20.05.2004', '1947926719', 'abc123@','UNTLAS', '07.06.2021')
INSERT Usuario VALUES ('Ricardo', 'Ricado.watson@gmail,com', '22.08.2005', '19004567899', '12345*','ABBCDE', '07.06.2021')
INSERT Usuario VALUES ('Guilherme', 'Like301@yahoo.com.br', '30.11.2004', '18009934512', 'SENHA123','LEDPDC', '07.06.2021')
INSERT Usuario VALUES ('Oscar', 'Oscar_tiago@hotmail.com', '17.04.2003', '18926514492', 'Alvin007','KQYPTW', '07.06.2021')
INSERT Usuario VALUES ('Aline', 'Aln.2002@outlook.com', '18.03.2002', '1992880672', 'Kratos15','ENASKJ', '07.06.2021')
INSERT Usuario VALUES ('Marcia', 'Marciax@gamail.com', '05.09.2001', '10987654321', 'Batata123','FGNMCX', '07.06.2021')

INSERT Moeda VALUES ('CPDCoin', 5.00)
INSERT Moeda VALUES ('Quarteta', 3.00)
INSERT Moeda VALUES ('Passadina', 0.10)
INSERT Moeda VALUES ('Aeropoto', 5.00)
INSERT Moeda VALUES ('PneuQueimado', 5000.00)
INSERT Moeda VALUES ('Bitcoin', 240000.00)
INSERT Moeda VALUES ('Ethereum', 16000.00)
INSERT Moeda VALUES ('Dogecoin', 1.75)
INSERT Moeda VALUES ('Polkadot', 22.00)

INSERT DetalheCarteira VALUES (1.12345678, 1, 1)

INSERT Transacao VALUES (0.12345678, '07.06.2021', 2, 1, 1)

INSERT Tags VALUES ('Bitcoin', 'Moeda Bitcoin')
INSERT Tags VALUES ('Queda', 'Queda de preço')

INSERT Noticia VALUES ('Queda do Bitcoin', 'Elon Musk não aceita mais bitcoin')
INSERT Noticia VALUES ('Hiperinflação', 'Albania Atinge Hiperinflação')
INSERT Noticia VALUES ('Nova Moeda', 'O Google diz possibilidade de criar uma moeda')
INSERT Noticia VALUES ('Passadina cai', 'A  moeda Passadina declare falência')
INSERT Noticia VALUES ('A Volta por Cima', 'Moeda PneuQueimado da a volta por cima e consegue manter-se de pé')
INSERT Noticia VALUES ('Golpe de Empresa', 'Golpe atinge Evandro Teruel')
INSERT Noticia VALUES ('Vamos Jogar?', 'Novo jogo que mexe com Ethereum faz sucesso')
INSERT Noticia VALUES ('Precisa de Emprego?', 'Empresa procura programadores de Blockchain')
INSERT Noticia VALUES ('Crises no Mundo', 'Crise no petróleo pode influenciar no valor das moedas')
INSERT Noticia VALUES ('Banido da China', 'Presidente chines bani a moeda CDPcoin')

INSERT DetalheTagNoticia VALUES (1,1)
INSERT DetalheTagNoticia VALUES (1,2)

INSERT Interesse VALUES (1,1)
INSERT Interesse VALUES (1,2)
INSERT Interesse VALUES (2,2)

---------------------SELECTS---------------------
SELECT * FROM Usuario
SELECT * FROM Moeda
SELECT * FROM DetalheCarteira
SELECT * FROM Transacao
SELECT * FROM Tags
SELECT * FROM Noticia
SELECT * FROM DetalheTagNoticia
SELECT * FROM Interesse

SELECT n.Titulo, n.DescNot, t.NomeTag FROM Noticia AS n
	INNER JOIN DetalheTagNoticia AS d ON n.idNoticia = d.idNoticia
	INNER JOIN Tags AS t ON t.idTags = d.idTags



---------------------PROCEDURES---------------------