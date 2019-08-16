USE M_OpFlix;
SELECT * FROM Lancamentos;
-- Sele��o - trazer todas as categorias, inclusive as que n�o possuem lan�amentos vinculados;
SELECT * FROM Categorias;
-- Sele��o - trazer todas as plataformas, inclusive as que n�o possuem lan�amentos vinculados.
SELECT * FROM Plataformas;
SELECT * FROM Usuarios;
SELECT * FROM ClassificacoesIndicativas;
SELECT * FROM Favoritos;



/*Criar uma view que traga todas as plataformas e que mostre quais os g�neros que passem na plataforma;
	(Netflix que passa o filme Sing, que � da categoria Anima��o. Logo, o resultado esperado da view, ser� da seguinte manteira:
	Plataforma G�nero/Categoria
	Netflix Anima��o)*/
CREATE VIEW vmCategoriasPlataformas AS
SELECT P.Plataforma, C.Categoria
FROM Lancamentos L
JOIN Plataformas P ON L.IdPlataforma = P.IdPlataforma
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
;
SELECT * FROM vmCategoriasPlataformas ORDER BY Plataforma ASC;


-- Desafio: listar somente filmes �nicos. Quando trouxer a sele��o, dever� aparecer somente um Guardi�es da Gal�xia.
SELECT DISTINCT L.Titulo, C.Categoria, CI.CI AS ClassificacaoIndicativa, FORMAT(DataDeLancamento,'dd/MM/yyyy') AS DataDeLancamento,L.TipoDeMidia, CONVERT(VARCHAR(5),L.TempoDeDuracao) AS TempoDeDuracao 
FROM Lancamentos L
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
JOIN Plataformas P ON P.IdPlataforma = L.IdPlataforma
JOIN ClassificacoesIndicativas CI ON CI.IdClassificacaoIndicativa = L.IdClassificacaoIndicativa;


CREATE PROCEDURE FavoritosPorNomeDeUsuario @NomeDeUsuario VARCHAR(255)
AS
SELECT DISTINCT U.Nome, DATEDIFF(year, U.DataDeNascimento, GETDATE()) AS Idade, L.Titulo, C.Categoria, CI.CI AS ClassificacaoIndicativa, FORMAT(DataDeLancamento,'dd/MM/yyyy') AS DataDeLancamento,L.TipoDeMidia, CONVERT(VARCHAR(5),L.TempoDeDuracao) AS TempoDeDuracao,L.Episodios 
FROM Favoritos F
JOIN Lancamentos L ON L.IdLancamento = F.IdLancamento
JOIN Usuarios U ON U.IdUsuario = F.IdUsusario
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
JOIN Plataformas P ON P.IdPlataforma = L.IdPlataforma
JOIN ClassificacoesIndicativas CI ON CI.IdClassificacaoIndicativa = L.IdClassificacaoIndicativa
WHERE U.NomeDeUsuario = @NomeDeUsuario AND DATEDIFF(year, U.DataDeNascimento, GETDATE()) >= CI.ClassificacaoIndicativa;

EXEC FavoritosPorNomeDeUsuario @NomeDeUsuario = 'Erik'

-- Criar uma view, que dado uma entrada do usu�rio, por exemplo, 3, mostrar os pr�ximos 3 lan�amentos breves. Mostrando tamb�m a categoria e a plataforma.
CREATE VIEW vmProximosLancamentos AS 
SELECT TOP 3 L.Titulo, C.Categoria, CI.CI AS ClassificacaoIndicativa, FORMAT(DataDeLancamento,'dd/MM/yyyy') AS DataDeLancamento,L.TipoDeMidia, CONVERT(VARCHAR(5),L.TempoDeDuracao) AS TempoDeDuracao 
FROM Lancamentos L
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
JOIN Plataformas P ON P.IdPlataforma = L.IdPlataforma
JOIN ClassificacoesIndicativas CI ON CI.IdClassificacaoIndicativa = L.IdClassificacaoIndicativa
WHERE L.DataDeLancamento > GETDATE()
ORDER BY DATEDIFF(year, L.DataDeLancamento, GETDATE()); 

SELECT * FROM vmProximosLancamentos;



-- Criar um procedimento para listar os filmes dado uma categoria em String do usu�rio;(Listar os filmes da categoria A��o)
CREATE PROCEDURE LancamentosPorCategoria @Categoria VARCHAR(255)
AS
SELECT DISTINCT  L.Titulo, C.Categoria, CI.CI AS ClassificacaoIndicativa, FORMAT(DataDeLancamento,'dd/MM/yyyy') AS DataDeLancamento,L.TipoDeMidia, CONVERT(VARCHAR(5),L.TempoDeDuracao) AS TempoDeDuracao,L.Episodios 
FROM Lancamentos L
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
JOIN Plataformas P ON P.IdPlataforma = L.IdPlataforma
JOIN ClassificacoesIndicativas CI ON CI.IdClassificacaoIndicativa = L.IdClassificacaoIndicativa
WHERE C.Categoria = @Categoria;

EXEC LancamentosPorCategoria @Categoria = 'A��o';

-- Criar um procedimento para listar a quantidades de filmes, dada uma categoria por Id;(Listar os filmes da categoria 1 ou o id correspondente da sua tabela).
CREATE PROCEDURE LancamentosPorIdCategoria @IdCategoria INT
AS
SELECT DISTINCT  L.Titulo, C.Categoria, CI.CI AS ClassificacaoIndicativa, FORMAT(DataDeLancamento,'dd/MM/yyyy') AS DataDeLancamento,L.TipoDeMidia, CONVERT(VARCHAR(5),L.TempoDeDuracao) AS TempoDeDuracao,L.Episodios 
FROM Lancamentos L
JOIN Categorias C ON L.IdCategoria = C.IdCategoria
JOIN Plataformas P ON P.IdPlataforma = L.IdPlataforma
JOIN ClassificacoesIndicativas CI ON CI.IdClassificacaoIndicativa = L.IdClassificacaoIndicativa
WHERE C.IdCategoria = @IdCategoria;

EXEC LancamentosPorIdCategoria @IdCategoria = 6;