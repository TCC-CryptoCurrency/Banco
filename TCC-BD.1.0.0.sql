CREATE DATABASE BancoTCC
USE BancoTCC
DROP DATABASE BancoTCC
USE master
SET DATEFORMAT DMY


---------------------TABELAS---------------------
CREATE TABLE Usuario(
	idCarteira INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nome VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL,
	DataNasc DATE NOT NULL,
	CPF VARCHAR(15) NOT NULL,
	Senha VARCHAR(24) NOT NULL,
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
	DataNot DATE NOT NULL,
	LinkNot VARCHAR(200) NOT NULL,
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
	DataAtualizacao DATE NOT NULL,
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

/*
ALTER TABLE DetalheCarteira
ADD CONSTRAINT PK_DestinoMoeda PRIMARY KEY(idCarteira, idMoeda)
ALTER TABLE DetalheCarteira
ADD CONSTRAINT FK_idMoeda FOREIGN KEY(idMoeda) REFERENCES Moeda(idMoeda)
ALTER TABLE DetalheCarteira
ADD CONSTRAINT FK_idCarteira FOREIGN KEY(idCarteira) REFERENCES Usuario(idCarteira)
*/

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
INSERT Usuario VALUES ('admin', 'admin@admin.com', '20.10.2021','123.456.789-00','admin')
INSERT Usuario VALUES ('Joao', 'Joazinho@joan.com', '22.08.2002', '137.829.102-57', 'abc123@')
INSERT Usuario VALUES ('Fernando', 'FERNANDO@pedro.NAN', '27.12.2003', '109.472.594-61', 'abc123@')
INSERT Usuario VALUES ('Thiago', 'Thiago@harada.com', '20.05.2004', '194.379.267-19', 'abc123@')
INSERT Usuario VALUES ('Ricardo', 'Ricado.watson@gmail,com', '22.08.2005', '190.045.678-99', '12345*')
INSERT Usuario VALUES ('Guilherme', 'Like301@yahoo.com.br', '30.11.2004', '180.099.345-12', 'SENHA123')
INSERT Usuario VALUES ('Oscar', 'Oscar_tiago@hotmail.com', '17.04.2003', '189.265.144-92', 'Alvin007')
INSERT Usuario VALUES ('Aline', 'Aln.2002@outlook.com', '18.03.2002', '019.928.806-72', 'Kratos15')
INSERT Usuario VALUES ('Marcia', 'Marciax@gamail.com', '05.09.2001', '109.876.543-21', 'Batata123')

INSERT Moeda VALUES ('Cardano', 9.14, GETDATE())
INSERT Moeda VALUES ('Binance', 3281.93, GETDATE())
INSERT Moeda VALUES ('Tether', 5.59, GETDATE())
INSERT Moeda VALUES ('XRP', 5.72, GETDATE())
INSERT Moeda VALUES ('Solana', 1163.53, GETDATE())
INSERT Moeda VALUES ('Bitcoin', 23645.07, GETDATE())
INSERT Moeda VALUES ('Ethereum', 3837.80, GETDATE())
INSERT Moeda VALUES ('Dogecoin', 1.21, GETDATE())
INSERT Moeda VALUES ('Polkadot', 216.11, GETDATE())
INSERT Moeda VALUES ('USD', 5.60, GETDATE())

INSERT HistoricoMoeda Values('17.11.2021', 10.37, 1)
INSERT HistoricoMoeda Values('18.11.2021', 9.92, 1)
INSERT HistoricoMoeda Values('19.11.2021', 10.47, 1)
INSERT HistoricoMoeda Values('20.11.2021', 10.79, 1)
INSERT HistoricoMoeda Values('21.11.2021', 10.35, 1)
INSERT HistoricoMoeda Values('22.11.2021', 9.94, 1)
INSERT HistoricoMoeda Values('23.11.2021', 9.74, 1)
INSERT HistoricoMoeda VALUES('17.11.2021', 3241.71, 2)
INSERT HistoricoMoeda VALUES('18.11.2021', 3213.45, 2)
INSERT HistoricoMoeda VALUES('19.11.2021', 3264.42, 2)
INSERT HistoricoMoeda VALUES('20.11.2021', 3388.54, 2)
INSERT HistoricoMoeda VALUES('21.11.2021', 3340.29, 2)
INSERT HistoricoMoeda VALUES('22.11.2021', 3237.03, 2)
INSERT HistoricoMoeda VALUES('23.11.2021', 3384.26, 2)
INSERT HistoricoMoeda VALUES('17.11.2021', 5.53, 3)
INSERT HistoricoMoeda VALUES('18.11.2021', 5.58, 3)
INSERT HistoricoMoeda VALUES('19.11.2021', 5.62, 3)
INSERT HistoricoMoeda VALUES('20.11.2021', 5.62, 3)
INSERT HistoricoMoeda VALUES('21.11.2021', 5.63, 3)
INSERT HistoricoMoeda VALUES('22.11.2021', 5.59, 3)
INSERT HistoricoMoeda VALUES('23.11.2021', 5.57, 3)
INSERT HistoricoMoeda VALUES('17.11.2021', 6.33, 4)
INSERT HistoricoMoeda VALUES('18.11.2021', 5.68, 4)
INSERT HistoricoMoeda VALUES('19.11.2021', 6.17, 4)
INSERT HistoricoMoeda VALUES('20.11.2021', 6.16, 4)
INSERT HistoricoMoeda VALUES('21.11.2021', 5.90, 4)
INSERT HistoricoMoeda VALUES('22.11.2021', 5.78, 4)
INSERT HistoricoMoeda VALUES('23.11.2021', 5.91, 4)
INSERT HistoricoMoeda VALUES('17.11.2021', 1231.48, 5)
INSERT HistoricoMoeda VALUES('18.11.2021', 1050.24, 5)
INSERT HistoricoMoeda VALUES('19.11.2021', 1235.31, 5)
INSERT HistoricoMoeda VALUES('20.11.2021', 1228.31, 5)
INSERT HistoricoMoeda VALUES('21.11.2021', 1319.14, 5)
INSERT HistoricoMoeda VALUES('22.11.2021', 1257.28, 5)
INSERT HistoricoMoeda VALUES('23.11.2021', 1268.35, 5)
INSERT HistoricoMoeda VALUES('17.11.2021', 333995.88, 6)
INSERT HistoricoMoeda VALUES('18.11.2021', 316233.39, 6)
INSERT HistoricoMoeda VALUES('19.11.2021', 326239.42, 6)
INSERT HistoricoMoeda VALUES('20.11.2021', 335472.67, 6)
INSERT HistoricoMoeda VALUES('21.11.2021', 329356.65, 6)
INSERT HistoricoMoeda VALUES('22.11.2021', 315202.45, 6)
INSERT HistoricoMoeda VALUES('23.11.2021', 320767.97, 6)
INSERT HistoricoMoeda VALUES('17.11.2021', 23926.19, 7)
INSERT HistoricoMoeda VALUES('18.11.2021', 22150.05, 7)
INSERT HistoricoMoeda VALUES('19.11.2021', 24153.53, 7)
INSERT HistoricoMoeda VALUES('20.11.2021', 24853.57, 7)
INSERT HistoricoMoeda VALUES('21.11.2021', 24661.12, 7)
INSERT HistoricoMoeda VALUES('22.11.2021', 23171.46, 7)
INSERT HistoricoMoeda VALUES('23.11.2021', 24272.71, 7)
INSERT HistoricoMoeda VALUES('17.11.2021', 1.31, 8)
INSERT HistoricoMoeda VALUES('18.11.2021', 1.23, 8)
INSERT HistoricoMoeda VALUES('19.11.2021', 1.31, 8)
INSERT HistoricoMoeda VALUES('20.11.2021', 1.31, 8)
INSERT HistoricoMoeda VALUES('21.11.2021', 1.27, 8)
INSERT HistoricoMoeda VALUES('22.11.2021', 1.23, 8)
INSERT HistoricoMoeda VALUES('23.11.2021', 1.26, 8)
INSERT HistoricoMoeda VALUES('17.11.2021', 239.15, 9)
INSERT HistoricoMoeda VALUES('18.11.2021', 210.11, 9)
INSERT HistoricoMoeda VALUES('19.11.2021', 234.83, 9)
INSERT HistoricoMoeda VALUES('20.11.2021', 236.54, 9)
INSERT HistoricoMoeda VALUES('21.11.2021', 244.36, 9)
INSERT HistoricoMoeda VALUES('22.11.2021', 222.51, 9)
INSERT HistoricoMoeda VALUES('23.11.2021', 224.73, 9)
INSERT HistoricoMoeda VALUES('17.11.2021', 5.53, 10)
INSERT HistoricoMoeda VALUES('18.11.2021', 5.56, 10)
INSERT HistoricoMoeda VALUES('19.11.2021', 5.61, 10)
INSERT HistoricoMoeda VALUES('20.11.2021', 5.61, 10)
INSERT HistoricoMoeda VALUES('21.11.2021', 5.61, 10)
INSERT HistoricoMoeda VALUES('22.11.2021', 5.59, 10)
INSERT HistoricoMoeda VALUES('23.11.2021', 5.57, 10)

INSERT DetalheCarteira VALUES (1.00, 1, 1)

INSERT Transacao VALUES (0.12345678, '07.06.2021', 2, 1, 1)

INSERT Tags VALUES ('Bitcoin', 'Moeda Bitcoin')
INSERT Tags VALUES ('Queda', 'Queda de preço')
INSERT Tags VALUES ('Em alta', 'Moedas que estão em alta')
INSERT Tags VALUES ('Ethereum', 'Moeda Etherium')
INSERT Tags VALUES ('Dogecoin', 'Moeda Dogecoin')
INSERT Tags VALUES ('Brasil', 'Brasil sobre Moedas')
INSERT Tags VALUES ('Golpes', 'Golpes sobre moedas')
INSERT Tags VALUES ('Mineração', 'Mineração de moedas')
INSERT Tags VALUES ('Empresas', 'Empresas sobre moedas')
INSERT Tags VALUES ('Novidades', 'Moedas novas')
INSERT Tags VALUES ('China', 'China sobre moedas')
INSERT Tags VALUES ('Elon Musk', 'Elon Musk')


INSERT Noticia VALUES ('Queda do Bitcoin', 'Elon Musk não aceita mais bitcoin', '13.05.2021', 'https://www.bbc.com/portuguese/internacional-57100846')
INSERT Noticia VALUES ('El Salvador', 'El Salvador aceita Bitcoin', '07.09.2021','https://g1.globo.com/economia/noticia/2021/09/09/bitcoins-a-confusao-em-el-salvador-com-a-adocao-da-criptomoeda-como-moeda-oficial.ghtml')
INSERT Noticia VALUES ('Empiricus', 'Nova moeda de Ex-Funcionarios do Facebook', '14.07.2021','https://www.moneytimes.com.br/conteudo-de-marca/ex-funcionarios-de-google-e-facebook-criam-criptomoeda-da-nova-internet-valorizacao-explosiva-deixa-bitcoin-no-chinelo-brdfv005/')
INSERT Noticia VALUES ('Corinthians', 'Clube Paulista anuncia nova moeda', '02.09.2021','https://www.istoedinheiro.com.br/criptomoeda-do-corinthians-arrecada-r-87-milhoes-e-esgota-em-menos-de-2-horas/')
INSERT Noticia VALUES ('Flamengo', 'Time de futebol anuncia nova moeda', '13.10.2021','https://br.investing.com/news/cryptocurrency-news/flamengo-anuncia-data-de-lancamento-de-sua-criptomoeda-927936#:~:text=O%20Flamengo%2C%20time%20de%20futebol,que%20será%20chamada%20de%20%24MENGO')
INSERT Noticia VALUES ('Atlas Quantum', 'Empresa rouba milhões de Brasileiros', '19.04.2021','https://cointelegraph.com.br/news/r-800-thousand-loss-record-tv-denounces-atlas-quantum-for-a-r-45-billion-bitcoin-scam')
INSERT Noticia VALUES ('Round 6', 'Aumentam buscas por moedas Sul-Coreanas', '15.10.2021','https://exame.com/pop/efeito-round-6-buscas-por-moeda-sul-coreana-no-google-disparam-700/')
INSERT Noticia VALUES ('Tesla rejeita moeda', 'Tesla voltará a aceitar Bitcoin como pagamento', '21.07.2021','https://oglobo.globo.com/economia/tesla-provavelmente-voltara-aceitar-bitcoin-como-forma-de-pagamento-diz-musk-25120270')
INSERT Noticia VALUES ('Mineração', 'Aprenda como funciona a mineração atualmente', '26.10.2021','https://canaltech.com.br/criptomoedas/como-funciona-a-mineracao-do-bitcoin-191213/')
INSERT Noticia VALUES ('China sem moedas', 'China bane criptomoedas no país','24.09.2021','https://www.istoedinheiro.com.br/china-proibe-criptomoedas-e-valor-do-bitcoin-despenca-nesta-sexta-feira-24/')

INSERT DetalheTagNoticia VALUES (1,1)
INSERT DetalheTagNoticia VALUES (1,2)
INSERT DetalheTagNoticia VALUES (1,9)
INSERT DetalheTagNoticia VALUES (1,12)
INSERT DetalheTagNoticia VALUES (2,1)
INSERT DetalheTagNoticia VALUES (2,3)
INSERT DetalheTagNoticia VALUES (3,10)
INSERT DetalheTagNoticia VALUES (3,3)
INSERT DetalheTagNoticia VALUES (4,10)
INSERT DetalheTagNoticia VALUES (4,6)
INSERT DetalheTagNoticia VALUES (4,3)
INSERT DetalheTagNoticia VALUES (5,3)
INSERT DetalheTagNoticia VALUES (5,10)
INSERT DetalheTagNoticia VALUES (5,6)
INSERT DetalheTagNoticia VALUES (6,6)
INSERT DetalheTagNoticia VALUES (6,7)
INSERT DetalheTagNoticia VALUES (6,9)
INSERT DetalheTagNoticia VALUES (7,3)
INSERT DetalheTagNoticia VALUES (7,10)
INSERT DetalheTagNoticia VALUES (8,12)
INSERT DetalheTagNoticia VALUES (8,3)
INSERT DetalheTagNoticia VALUES (8,1)
INSERT DetalheTagNoticia VALUES (8,9)
INSERT DetalheTagNoticia VALUES (9,8)
INSERT DetalheTagNoticia VALUES (9,10)
INSERT DetalheTagNoticia VALUES (10,11)
INSERT DetalheTagNoticia VALUES (10,2)
INSERT DetalheTagNoticia VALUES (10,3)

INSERT Interesse VALUES (1,1)
INSERT Interesse VALUES (1,2)
INSERT Interesse VALUES (2,2)

---------------------SELECTS---------------------
SELECT * FROM Usuario
SELECT * FROM Moeda
SELECT * FROM HistoricoMoeda
SELECT * FROM DetalheCarteira
SELECT * FROM Transacao
SELECT * FROM Tags
SELECT * FROM Noticia
SELECT * FROM DetalheTagNoticia
SELECT * FROM Interesse

SELECT n.Titulo, n.DescNot, t.NomeTag FROM Noticia AS n
	INNER JOIN DetalheTagNoticia AS d ON n.idNoticia = d.idNoticia
	INNER JOIN Tags AS t ON t.idTags = d.idTags

SELECT T.NomeTag FROM Tags T INNER JOIN
    Interesse I ON I.idTags = T.idTags AND I.idUsuario = 1

SELECT DataRegistro, ValorData FROM HistoricoMoeda WHERE idMoeda = 1

---------------------PROCEDURES---------------------
CREATE PROCEDURE usp_selecionar_tabelaIndex AS
    SELECT M.idMoeda, M.NomeMoeda, M.ValorMoeda, H.ValorData ,H.DataRegistro FROM Moeda AS M 
    INNER JOIN HistoricoMoeda AS H ON (M.idMoeda = H.idMoeda) AND H.DataRegistro IN(
        SELECT MAX(DataRegistro) FROM HistoricoMoeda GROUP BY idMoeda)

EXEC usp_selecionar_tabelaIndex

-------------------------------------------------
CREATE PROCEDURE usp_selecionar_moedaUsuario
@idUsu INT
AS
    SELECT M.idMoeda, M.NomeMoeda, M.ValorMoeda, H.ValorData, H.DataRegistro, D.Saldo FROM ((Moeda AS M 
    INNER JOIN HistoricoMoeda AS H ON M.idMoeda = H.idMoeda AND H.DataRegistro IN(
        SELECT MAX(DataRegistro) FROM HistoricoMoeda GROUP BY idMoeda))
    INNER JOIN DetalheCarteira AS D ON D.idMoeda = M.idMoeda) WHERE idCarteira = @idUsu

EXEC usp_selecionar_moedaUsuario 1

------------------------------------------------
CREATE PROCEDURE usp_selecionarTagsIdUsuario
@idUsu INT
AS
SELECT T.NomeTag FROM Interesse I INNER JOIN 
    Tags T ON I.idTags = T.idTags WHERE I.idUsuario = @idUsu 

EXEC usp_selecionarTagsIdUsuario 1

------------------------------------------------
CREATE PROCEDURE usp_selecionar_walletusuario --apenas de teste, não tá no ASP
@idUsu INT,
@filtro INT
AS
    SELECT M.idMoeda, M.NomeMoeda, M.ValorMoeda, H.ValorData, H.DataRegistro, D.Saldo FROM ((Moeda AS M 
    INNER JOIN HistoricoMoeda AS H ON M.idMoeda = H.idMoeda AND H.DataRegistro IN(
        SELECT MAX(DataRegistro) FROM HistoricoMoeda GROUP BY idMoeda))
    INNER JOIN DetalheCarteira AS D ON D.idMoeda = M.idMoeda) WHERE idCarteira = 1 

EXEC usp_selecionar_walletusuario 1, 1

------------------------------------------------
CREATE PROCEDURE usp_selecionar_noticiaUsuario
@idUsu INT
AS
SELECT N.idNoticia, N.Titulo, N.DescNot, N.DataNot FROM Noticia AS N
    inner join DetalheTagNoticia AS D ON D.idNoticia = N.idNoticia AND D.idTags IN (
    SELECT T.idTags FROM Tags T INNER JOIN Interesse I ON I.idTags = T.idTags AND I.idUsuario = @idUsu) 
    GROUP BY N.idNoticia, N.Titulo, N.DescNot, N.DataNot

EXEC usp_selecionar_noticiaUsuario 1

------------------------------------------------
CREATE PROCEDURE usp_selecionarnoticiaTag
@nomeTag VARCHAR(20)
AS 
SELECT N.* FROM Noticia N INNER JOIN 
    DetalheTagNoticia D ON (D.idNoticia = N.idNoticia) AND D.idTags IN(
    SELECT T.idTags FROM Tags T WHERE T.NomeTag = @nomeTag)

EXEC usp_selecionarnoticiaTag 'Queda'