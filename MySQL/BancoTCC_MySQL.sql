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

INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Cardano', 9.14, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Binance', 3281.93, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Tether', 5.59, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('XRP', 5.72, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Solana', 1163.53, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Bitcoin', 23645.07, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Ethereum', 3837.80, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Dogecoin', 1.21, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('Polkadot', 216.11, NOW());
INSERT Moeda(NomeMoeda, ValorMoeda, DataAtualizacao) VALUES ('USD', 5.60, NOW());

SELECT * FROM Moeda;

INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('2021.09.25', 3.50, 1);

INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('17.11.2021', 10.37, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('18.11.2021', 9.92, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('19.11.2021', 10.47, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('20.11.2021', 10.79, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('21.11.2021', 10.35, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('22.11.2021', 9.94, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) Values('23.11.2021', 9.74, 1);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 3241.71, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 3213.45, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 3264.42, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 3388.54, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 3340.29, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 3237.03, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 3384.26, 2);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 5.53, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 5.58, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 5.62, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 5.62, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 5.63, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 5.59, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 5.57, 3);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 6.33, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 5.68, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 6.17, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 6.16, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 5.90, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 5.78, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 5.91, 4);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 1231.48, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 1050.24, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 1235.31, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 1228.31, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 1319.14, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 1257.28, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 1268.35, 5);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 333995.88, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 316233.39, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 326239.42, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 335472.67, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 329356.65, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 315202.45, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 320767.97, 6);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 23926.19, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 22150.05, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 24153.53, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 24853.57, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 24661.12, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 23171.46, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 24272.71, 7);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 1.31, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 1.23, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 1.31, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 1.31, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 1.27, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 1.23, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 1.26, 8);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 239.15, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 210.11, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 234.83, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 236.54, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 244.36, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 222.51, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 224.73, 9);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('17.11.2021', 5.53, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('18.11.2021', 5.56, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('19.11.2021', 5.61, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('20.11.2021', 5.61, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('21.11.2021', 5.61, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('22.11.2021', 5.59, 10);
INSERT HistoricoMoeda(DataRegistro, ValorData, idMoeda) VALUES('23.11.2021', 5.57, 10);
SELECT * FROM HistoricoMoeda; 

INSERT DetalheCarteira VALUES (1.00, 1, 1);

SELECT * FROM DetalheCarteira; 

INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (3, '07.06.2021', null, 1, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (2.12294, '15.07.2021', null, 1, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.26291, '13.09.2021', 2, 2, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (46.46219, '27.09.2021', null, 3, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (17.98734, '21.10.2021', 2, 1, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (8.46378, '25.10.2021', null, 1, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (2.89345, '25.10.2021', 2, 4, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (5.32657, '09.11.2021', null, 4, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.467835, '10.11.2021', 2, 2, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (5.945738, '22.11.2021', 2, 3, 1);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.67832, '22.07.2021', null, 5, 2);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (32.3467, '11.09.2021', 1, 3, 2);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (13.346728, '31.10.2021', null, 1, 2);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.14256, '12.11.2021', null, 7, 2);
INSERT Transacao(Valor, DataTrans, Origem, TipoMoeda, Destino) VALUES (0.325587, '20.11.2021', 1, 2, 2);

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
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (1,9);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (1,12);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (2,1);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (2,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (3,10);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (3,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (4,10);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (4,6);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (4,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (5,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (5,10);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (5,6);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (6,6);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (6,7);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (6,9);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (7,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (7,10);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (8,12);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (8,3);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (8,1);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (8,9);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (9,8);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (9,10);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (10,11);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (10,2);
INSERT DetalheTagNoticia(idNoticia, idTags) VALUES (10,3);

SELECT * FROM DetalheTagNoticia;

INSERT Interesse(idUsuario, idTags) VALUES (1,1);
INSERT Interesse(idUsuario, idTags) VALUES (1,2);
INSERT Interesse(idUsuario, idTags) VALUES (2,2);

SELECt * FROM Interesse; 