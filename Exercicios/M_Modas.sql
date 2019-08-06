CREATE DATABASE M_Modas;
USE M_Modas;

CREATE TABLE Cores(
IdCor INT PRIMARY KEY IDENTITY
,Cor VARCHAR(100) NOT NULL
);

INSERT INTO Cores(Cor) VALUES ('Azul'), ('Verde'), ('Vermelho'), ('Amarelo'), ('Branco'), ('Preto');

CREATE TABLE Tamanhos(
IdTamanho INT PRIMARY KEY IDENTITY
,Tamanho VARCHAR(10) NOT NULL
,Medida VARCHAR(30)NOT NULL
);

INSERT INTO Tamanhos(Tamanho, Medida) VALUES ('P','30x30'),('M','40x40'),('G','50x50'),('GG','60x60');

CREATE TABLE Marcas(
IdMarca INT PRIMARY KEY IDENTITY
,Marca VARCHAR(100) NOT NULL
,QntLojas INT NOT NULL
,DataDeCriacao DATE NOT NULL
);

INSERT INTO Marcas(Marca, QntLojas, DataDeCriacao) VALUES ('Supreme',2,'2005-05-11'),('Gucci',6,'1980-09-07'),('C&A',147,'1975-12-20');

CREATE TABLE Camisetas(
IdCamiseta INT PRIMARY KEY IDENTITY
,Camiseta VARCHAR(200) NOT NULL
,IdMarca INT FOREIGN KEY REFERENCES Marcas(IdMarca)
,LavagemNaMaquina BIT NOT NULL DEFAULT(1)
);

INSERT INTO Camisetas(Camiseta, IdMarca) VALUES('Mickey Mouse',3),('B.I.G',3),('Gucci Logo',3),('Simples',3),('Manga Longa',3),('Brick',1);

CREATE TABLE CamisetasCores(
IdCamisetaCor INT PRIMARY KEY IDENTITY
,IdCamiseta INT FOREIGN KEY REFERENCES Camisetas(IdCamiseta)
,IdCor INT FOREIGN KEY REFERENCES Cores(IdCor)
);

INSERT INTO CamisetasCores(IdCamiseta, IdCor) VALUES (1,3),(2,5),(3,6),(4,1),(4,2),(4,3),(5,3);

CREATE TABLE CamisetasTamanhos(
IdCamisetaCor INT FOREIGN KEY REFERENCES CamisetasCores(IdCamisetaCor)
,IdTamanho INT FOREIGN KEY REFERENCES Tamanhos(IdTamanho)
);

INSERT INTO CamisetasTamanhos(IdCamisetaCor,IdTamanho) VALUES (1,1),(2,2),(3,3),(4,4),(5,2),(6,3),(7,1),(4,2),(5,4),(6,3);

UPDATE Camisetas SET IdMarca = 1 WHERE IdCamiseta = 2;
UPDATE Camisetas SET IdMarca = 2 WHERE IdCamiseta = 3;

DELETE FROM Camisetas WHERE IdCamiseta = 6;

SELECT * FROM Camisetas;
SELECT * FROM Tamanhos;
SELECT * FROM Marcas;
SELECT * FROM Cores;
SELECT C.IdCamiseta,C.Camiseta, M.Marca FROM Camisetas C JOIN Marcas M ON C.IdMarca = M.IdMarca;

SELECT C.Camiseta, Cores.Cor FROM CamisetasCores CC	JOIN Camisetas C ON CC.IdCamiseta = C.IdCamiseta
														JOIN Cores ON CC.IdCor = Cores.IdCor;

SELECT C.Camiseta, T.Tamanho FROM CamisetasTamanhos CT	JOIN CamisetasCores CC ON CT.IdCamisetaCor = CC.IdCamisetaCor
														JOIN Camisetas C ON CC.IdCamiseta = C.IdCamiseta 
														JOIN Tamanhos T ON CT.IdTamanho = T.IdTamanho;

