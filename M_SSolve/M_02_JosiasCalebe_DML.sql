USE M_SSolve;

INSERT INTO Funcionarios(Nome,Salario) VALUES ('Alex',1400),('Jorge',2100),('Matheus',2500),('Gustavo',2500),('Ze',1900);
INSERT INTO Comodos(Comodo) VALUES ('Quarto'),('Sala'),('Banheiro'),('Cozinha');
INSERT INTO Aparelhos(IdComodo,Aparelho) VALUES (3,'Chuveiro'),(4,'Torneira'),(1,'Lampada'),(1,'Computador'),(3,'Privada');
INSERT INTO Clientes(CNPJ,NomeFantasia,RazaoSocial,Endereco) VALUES  ('48300420000110','SESI','Serviço Social Da Industria','Rua Bom Pastor 654')
																	,('12569879000176','Matheusons','Matthew Co.','Rua Itauna 312')
																	,('24397329000104','Subway','BR Comercios','Alameda Barao De Limeira 459')
																	,('92830152000130','Aj Desenvolvimento','Albert Co.','Avenida Aquario 658');
INSERT INTO Servicos(CNPJ,IdAparelho,Descricao,DataDeInicio,Preco) VALUES('24397329000104',5,'Manutenção da privada','2019-10-21',200)
																		,('92830152000130',4,'Manutenção do computador','2019-10-22',500)
																		,('12569879000176',3,'Reparo da lampada','2019-10-23',600)
																		,('24397329000104',2,'Reparo da torneira','2019-10-24',400)
																		,('48300420000110',1,'Manutenção do chuveiro','2019-10-25',150);
INSERT INTO FuncionariosServicos(IdFuncionario, IdServico) VALUES(1,5),(2,3),(3,5),(4,2),(5,1),(1,4);

UPDATE Servicos SET DataDeConclusao = '2019-10-21' WHERE IdServico = 1;
UPDATE Servicos SET Status = 1 WHERE DataDeConclusao != NULL;
DELETE FROM Servicos WHERE Status = 1;