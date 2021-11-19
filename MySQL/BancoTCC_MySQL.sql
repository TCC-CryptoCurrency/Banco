CREATE DATABASE BancoTCC;
USE BancoTCC;
DROP DATABASE BancoTCC;
USE world;


CREATE TABLE Usuario(
	idCarteira INT AUTO_INCREMENT NOT NULL, 
	Nome VARCHAR(30),
	Email VARCHAR(30),
	DataNasc DATE,
	CPF VARCHAR(15),
	Senha VARCHAR(24),
    PRIMARY KEY(idCarteira)
);
DROP TABLE Usuario;

CREATE TABLE Tags(
	idTags INT AUTO_INCREMENT NOT NULL,
	NomeTag VARCHAR(20) NOT NULL,
	DescTag VARCHAR(50) NOT NULL,
    PRIMARY KEY(idTags)
);
DROP TABLE Tags;

CREATE TABLE Interesse(
	idUsuario INT,
	idTags INT,
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idCarteira), 
	FOREIGN KEY(idTags) REFERENCES Tags(idTags) 
);
DROP TABLE Interesse;

CREATE TABLE Noticia(
	idNoticia INT AUTO_INCREMENT NOT NULL,
	Titulo VARCHAR(20) NOT NULL,
	DescNot VARCHAR(50) NOT NULL,
	DataNot DATE NOT NULL,
	LinkNot VARCHAR(200) NOT NULL,
    PRIMARY KEY(idNoticia)
);
DROP TABLE Noticia;

CREATE TABLE DetalheTagNoticia(
	idNoticia INT,
	idTags INT,
	FOREIGN KEY(idNoticia) REFERENCES Noticia(idNoticia),
	FOREIGN KEY(idTags) REFERENCES Tags(idTags) 
);
DROP TABLE DetalheTagNoticia;

CREATE TABLE Moeda(
	idMoeda INT AUTO_INCREMENT NOT NULL,
	NomeMoeda VARCHAR(15) NOT NULL,
	ValorMoeda DOUBLE(12,2) NOT NULL,
	DataAtualizacao DATE NOT NULL,
    PRIMARY KEY(idMoeda)
);
DROP TABLE Moeda;

CREATE TABLE HistoricoMoeda(
	idHistorico INT AUTO_INCREMENT NOT NULL,
	DataRegistro DATE NOT NULL,
	ValorData DOUBLE(12,2) NOT NULL,
	idMoeda INT NOT NULL,
    PRIMARY KEY(idHistorico),
	FOREIGN KEY(idMoeda) REFERENCES Moeda(idMoeda) 
);
DROP TABLE HistoricoMoeda;

CREATE TABLE DetalheCarteira(
	Saldo NUMERIC(11,8) NOT NULL,
	idMoeda INT NOT NULL,
	idCarteira INT NOT NULL,
    FOREIGN KEY(idMoeda) REFERENCES Moeda(idMoeda),
    FOREIGN KEY(idCarteira) REFERENCES Usuario(idCarteira)
);
DROP TABLE DetalheCarteira; 

CREATE TABLE Transacao(
	idTransacao INT AUTO_INCREMENT NOT NULL,
	Valor NUMERIC(11,8) NOT NULL,
	DataTrans DATE NOT NULL,
	Origem INT,
	TipoMoeda INT NOT NULL,
	Destino INT NOT NULL,
	PRIMARY KEY(idTransacao),
    FOREIGN KEY(Origem) REFERENCES Usuario(idCarteira),
    FOREIGN KEY(TipoMoeda) REFERENCES DetalheCarteira(idMoeda),
    FOREIGN KEY(Destino) REFERENCES DetalheCarteira(idCarteira)
);
DROP TABLE Transacao; 

INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('admin', 'admin@admin.com', '2021.10.20','123.456.789-00','admin');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Joao', 'Joazinho@joan.com', '2002.08.22', '137.829.102-57', 'abc123@');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Fernando', 'FERNANDO@pedro.NAN', '2003.12.27', '109.472.594-61', 'abc123@');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Thiago', 'Thiago@harada.com', '2004.05.20', '194.379.267-19', 'abc123@');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Ricardo', 'Ricado.watson@gmail,com', '2005.08.22', '190.045.678-99', '12345*');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Guilherme', 'Like301@yahoo.com.br', '2004.11.30', '180.099.345-12', 'SENHA123');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Oscar', 'Oscar_tiago@hotmail.com', '2003.04.17', '189.265.144-92', 'Alvin007');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Aline', 'Aln.2002@outlook.com', '2002.03.18', '019.928.806-72', 'Kratos15');
INSERT Usuario(Nome, Email, DataNasc, CPF, Senha) VALUES ('Marcia', 'Marciax@gamail.com', '2001.09.05', '109.876.543-21', 'Batata123');

SELECT * FROM Usuario;

INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Cardano', 2.23, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Binance', 475.39, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Tether', 1.00, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('XRP', 1.13, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Solana', 159.50, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Bitcoin', 61340.40, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Ethereum', 3837.80, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Dogecoin', 0.20, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Polkadot', 44.15, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('USD', 1.00, NOW());

SELECT * FROM Moeda;

INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.09.25', 3.50, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.09.24', 2.20, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES ('2021.09.26', 1.10, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES ('2021.09.27', 0.50, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES ('2021.09.28', 5.15, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.09.27', 2.00, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 0.09, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 5.10, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 3000.00, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 239999.00, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 16291.26, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 1.36, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 31.25, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.10.12', 0.03, 10);

SELECT * FROM HistoricoMoeda; 

INSERT DetalheCarteira VALUES (1.00, 1, 1);

SELECT * FROM DetalheCarteira; 

INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.12345678, '2021.06.07', 2, 1, 1);

SELECT * FROM Transacao; 

INSERT Tags(NomeTag, DescTag) VALUES ('Bitcoin', 'Moeda Bitcoin');
INSERT Tags(NomeTag, DescTag) VALUES ('Queda', 'Queda de preço');
INSERT Tags(NomeTag, DescTag) VALUES ('Em alta', 'Moedas que estão em alta');
INSERT Tags(NomeTag, DescTag) VALUES ('Ethereum', 'Moeda Etherium');
INSERT Tags(NomeTag, DescTag) VALUES ('Dogecoin', 'Moeda Dogecoin');
INSERT Tags(NomeTag, DescTag) VALUES ('Brasil', 'Brasil sobre Moedas');
INSERT Tags(NomeTag, DescTag) VALUES ('Golpes', 'Golpes sobre moedas');
INSERT Tags(NomeTag, DescTag) VALUES ('Mineração', 'Mineração de moedas');
INSERT Tags(NomeTag, DescTag) VALUES ('Empresas', 'Empresas sobre moedas');
INSERT Tags(NomeTag, DescTag) VALUES ('Novidades', 'Moedas novas');
INSERT Tags(NomeTag, DescTag) VALUES ('China', 'China sobre moedas');
INSERT Tags(NomeTag, DescTag) VALUES ('Elon Musk', 'Elon Musk');

SELECt * FROM Tags;

INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Queda do Bitcoin', 'Elon Musk não aceita mais bitcoin', '2021.05.13', 'https://www.bbc.com/portuguese/internacional-57100846');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('El Salvador', 'El Salvador aceita Bitcoin', '2021.09.07','https://g1.globo.com/economia/noticia/2021/09/09/bitcoins-a-confusao-em-el-salvador-com-a-adocao-da-criptomoeda-como-moeda-oficial.ghtml');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Empiricus', 'Nova moeda de Ex-Funcionarios do Facebook', '2021.07.14','https://www.moneytimes.com.br/conteudo-de-marca/ex-funcionarios-de-google-e-facebook-criam-criptomoeda-da-nova-internet-valorizacao-explosiva-deixa-bitcoin-no-chinelo-brdfv005/');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Corinthians', 'Clube Paulista anuncia nova moeda', '2021.09.02','https://www.istoedinheiro.com.br/criptomoeda-do-corinthians-arrecada-r-87-milhoes-e-esgota-em-menos-de-2-horas/');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Flamengo', 'Time de futebol anuncia nova moeda', '2021.10.13','https://br.investing.com/news/cryptocurrency-news/flamengo-anuncia-data-de-lancamento-de-sua-criptomoeda-927936#:~:text=O%20Flamengo%2C%20time%20de%20futebol,que%20será%20chamada%20de%20%24MENGO');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Atlas Quantum', 'Empresa rouba milhões de Brasileiros', '2021.04.19','https://cointelegraph.com.br/news/r-800-thousand-loss-record-tv-denounces-atlas-quantum-for-a-r-45-billion-bitcoin-scam');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Round 6', 'Aumentam buscas por moedas Sul-Coreanas', '2021.10.15','https://exame.com/pop/efeito-round-6-buscas-por-moeda-sul-coreana-no-google-disparam-700/');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Tesla rejeita moeda', 'Tesla voltará a aceitar Bitcoin como pagamento', '2021.07.21','https://oglobo.globo.com/economia/tesla-provavelmente-voltara-aceitar-bitcoin-como-forma-de-pagamento-diz-musk-25120270');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('Mineração', 'Aprenda como funciona a mineração atualmente', '2021.10.26','https://canaltech.com.br/criptomoedas/como-funciona-a-mineracao-do-bitcoin-191213/');
INSERT Noticia(Titulo, DescNot, DataNot, LinkNot) VALUES ('China sem moedas', 'China bane criptomoedas no país','2021.09.24','https://www.istoedinheiro.com.br/china-proibe-criptomoedas-e-valor-do-bitcoin-despenca-nesta-sexta-feira-24/');

SELECT * FROM Noticia;

INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (1,1);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (1,2);

SELECT * FROM DetalheTagNoticia;

INSERT Interesse(idUsuario, idTags) VALUES (1,1);
INSERT Interesse(idUsuario, idTags) VALUES (1,2);
INSERT Interesse(idUsuario, idTags) VALUES (2,2);

SELECt * FROM Interesse; 