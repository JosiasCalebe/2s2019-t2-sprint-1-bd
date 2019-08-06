CREATE DATABASE M_DPS;
USE M_DPS;

CREATE TABLE Departamentos(
IdDepartamento INT PRIMARY KEY IDENTITY
,Departamento VARCHAR(200) NOT NULL
);

INSERT INTO Departamentos(Departamento) VALUES ('Marketing'),('Desenvolvimento'),('R.H'),('Gerencia');


CREATE TABLE Habilidades(
IdHabilidade INT PRIMARY KEY IDENTITY
,Habilidade VARCHAR (200) NOT NULL
,Descricao VARCHAR(400) NOT NULL
);

INSERT INTO Habilidades(Habilidade,Descricao) VALUES ('Kamehameha','Gigantesco feixe continuo de energia que sai da palma das maos do usuario'),('Hadouken','Bola de energia'),('Rasengan','Outra bola de energia');

CREATE TABLE Funcionarios(
IdFuncionario INT PRIMARY KEY IDENTITY
,Nome VARCHAR(200) NOT NULL
,IdDepartamento INT FOREIGN KEY REFERENCES Departamentos(IdDepartamento)
,Funcao VARCHAR(400)NOT NULL
,Salario INT NOT NULL
);

INSERT INTO Funcionarios(Nome,IdDepartamento,Funcao,Salario) VALUES ('Alex',3,'Ler Curriculos',3000),('Jorge',2,'Desenvolver programas',3500),('Henrique',1,'Desenvolver propagandas',2500),('Billy',3,'Entrevistar Candidatos',3000),('Joel',3,'Gerenciar Reclamacoes',3000),('Ze',4,'Gerenciar o escritorio',10000);

CREATE TABLE FuncionariosHabilidades(
IdFuncionarios INT FOREIGN KEY REFERENCES Funcionarios(IdFuncionario)
,IdHabilidade INT FOREIGN KEY REFERENCES Habilidades(IdHabilidade)
);

INSERT INTO FuncionariosHabilidades(IdFuncionarios,IdHabilidade) VALUES (1,1),(2,2),(3,1),(4,3),(5,3),(6,2),(6,1);

UPDATE Funcionarios SET Salario = 3500 WHERE IdFuncionario = 1;

SELECT * FROM Funcionarios;
SELECT * FROM Departamentos;
SELECT * FROM Habilidades;
SELECT F.Nome,D.Departamento FROM Funcionarios F JOIN Departamentos D ON F.IdDepartamento = D.IdDepartamento;
SELECT F.Nome,H.Habilidade FROM FuncionariosHabilidades FH	JOIN Funcionarios F ON FH.IdFuncionarios = F.IdFuncionario
															JOIN Habilidades H ON FH.IdHabilidade = H.IdHabilidade;