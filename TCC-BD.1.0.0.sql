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
--o tipo de transa��o (dep�sito, transferencia), seria um tipo de calculado--


---------------------INDEX---------------------
CREATE INDEX XUSUARIO ON Usuario (idCarteira)
CREATE INDEX XTAGS ON Tags (idTags)
CREATE INDEX XNOTICIA ON Noticia (idNoticia)
CREATE INDEX XMOEDA ON Moeda (idMoeda)
CREATE INDEX XHISTORICO ON HistoricoMoeda (idHistorico)
CREATE INDEX XTRANSACAO ON Transacao (idTransacao)

---------------------SELECTS---------------------

---------------------INSERTS---------------------

---------------------PROCEDURES---------------------



/* A partir daqui, s�o s� testes
O que for colocar mesmo como fixo, coloca em cima */


----------INSERTS----------
INSERT Usuario VALUES ('Carlos', 'HaradaCarlos@carlos.com', '02.05.2000', '12345678910', '123@abc', 'ABCDEF', '07.06.2021')
INSERT Usuario VALUES ('Pedro', 'FERNANDOPEDRO@PEDRO.NAN', '31.03.2001', '10987654321', 'abc123@','FEDCBA', '07.06.2021')
INSERT Usuario VALUES ('Admin', 'admin@admin', '01.01.2003', '50313265810', 'admin', 'XYZABC', '21.07.2021')

INSERT Moeda VALUES ('CPDCoin', 5.00)
INSERT Moeda VALUES ('Quarteta', 3.00)
INSERT Moeda VALUES ('Bitcoin', 166820.38)

INSERT HistoricoMoeda VALUES ('21.07.2021', 166820.38, 3)
INSERT HistoricoMoeda VALUES ('20.07.2021', 5.00, 1)
INSERT HistoricoMoeda VALUES ('21.07.2021', 5.50, 1)

INSERT DetalheCarteira VALUES (1.12345678, 1, 1)
INSERT DetalheCarteira VALUES (21.54874458, 2, 1)

INSERT Transacao VALUES (0.12345678, '07.06.2021', 2, 1, 1)

INSERT Tags VALUES ('Bitcoin', 'Moeda Bitcoin')
INSERT Tags VALUES ('Queda', 'Queda de pre�o')
INSERT Tags VALUES ('Dogcoin', 'Moeda Dogcoin')
INSERT Tags VALUES ('Aumento', 'Aumento de pre�o')

INSERT Noticia VALUES ('Queda do Bitcoin', 'Elon Musk n�o aceita mais bitcoin')
INSERT Noticia VALUES ('Aumento na DogCoin', 'Nova moeda vem crescendo muito')

INSERT DetalheTagNoticia VALUES (1, 1)
INSERT DetalheTagNoticia VALUES (1, 2)
INSERT DetalheTagNoticia VALUES (3, 3)
INSERT DetalheTagNoticia VALUES (3, 4)

INSERT Interesse VALUES (1, 1)
INSERT Interesse VALUES (1, 2)
INSERT Interesse VALUES (2, 2)

----------SELECTS----------
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

SELECT u.idCarteira, u.Nome, c.Saldo, m.NomeMoeda FROM Usuario AS u
	INNER JOIN DetalheCarteira AS c ON u.idCarteira = c.idCarteira
	INNER JOIN Moeda AS m ON c.idMoeda = m.idMoeda

SELECT m.NomeMoeda, h.DataRegistro, h.ValorData FROM Moeda AS m
	INNER JOIN HistoricoMoeda AS h ON m.idMoeda = h.idMoeda

----------PROCEDURES----------
CREATE PROCEDURE usp_ChaveAleatoria
AS
	DECLARE @Chave VARCHAR(max) = 'ABCDFGHIJKLMNOPQRSTUVWXYZ0123456789'
	DECLARE @Tamanho INT = 6
	;with cte as(
		SELECT 1 AS cont,
			substring(@Chave, 1 + (abs(checksum(newid())) % len(@Chave)), 1) AS chave
		UNION ALL
		SELECT cont + 1,
			substring(@Chave, 1 + (abs(checksum(newid())) % len(@Chave)), 1)
		FROM cte WHERE cont < @tamanho)
	SELECT(
		SELECT '' + chave FROM cte
		for xml path(''), type, root('txt')
		).value('/txt[1]', 'varchar(max)')
	OPTION (maxrecursion 0)
	 

EXEC usp_ChaveAleatoria
DROP PROC usp_ChaveAleatoria




