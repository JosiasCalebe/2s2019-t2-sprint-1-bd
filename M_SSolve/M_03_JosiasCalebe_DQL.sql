USE M_SSolve;

SELECT * FROM Servicos;
SELECT * FROM Funcionarios ORDER BY Salario DESC;
SELECT * FROM Comodos;
SELECT * FROM Aparelhos;
SELECT * FROM Clientes;
SELECT * FROM FuncionariosServicos;

SELECT S.IdServico, C.NomeFantasia, S.CNPJ, A.Aparelho, CO.Comodo, S.Descricao,F.Nome AS Funcionario, FORMAT(S.DataDeInicio, 'dd/MM/yyyy') AS DataDeInicio ,S.Preco
	FROM Servicos S
		JOIN FuncionariosServicos FS ON FS.IdServico = S.IdServico
		JOIN Funcionarios F ON FS.IdFuncionario = F.IdFuncionario
		JOIN Aparelhos A ON A.IdAparelho = S.IdAparelho
		JOIN Clientes C ON C.CNPJ = S.CNPJ
		JOIN Comodos CO ON CO.IdComodo = A.IdComodo
	WHERE S.Status = 0
	ORDER BY S.IdServico ASC;