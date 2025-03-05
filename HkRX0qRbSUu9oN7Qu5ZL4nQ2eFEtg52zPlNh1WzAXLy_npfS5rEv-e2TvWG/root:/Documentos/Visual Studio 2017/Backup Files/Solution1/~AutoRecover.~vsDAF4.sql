use siscoob

--INSERT INTO Siscoob.dbo.tblAgencia_Hoteis
SELECT hotNomeFantasia,
       hotCNPJ,
       hotCodigo,
       hotDtCadastro,
       hotLogradouro,
       hotNumero,
       '',
       hotBairro,
       hotCidade,
       hotUF,
       'Brasil',
       hotEmail,
       '',
       hotFone
FROM   Siscoob.dbo.tblHoteis 
WHERE  sitCodigo = 1
AND    hotCodigo NOT IN (SELECT DISTINCT hotCodigo FROM Siscoob.dbo.tblAgencia_Hoteis);

--SELECT * FROM Siscoob.dbo.tblAgencia_Hoteis


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'tblAgencia_Hoteis';

/*
Podem estourar: 
	- hotNomeFantasia / hotNome 
	- hotLogradouro / hotEndereco
	- hotBairro / hotBairro
	- hotCidade / hotCidade
	- hotEmail / hotEmail
	*/

SELECT
    hotNomeFantasia, LEN(hotNomeFantasia) AS TamanhoNomeFantasia,
    hotLogradouro, LEN(hotLogradouro) AS TamanhoLogradouro,
    hotBairro, LEN(hotBairro) AS TamanhoBairro,
    hotCidade, LEN(hotCidade) AS TamanhoCidade,
    hotEmail, LEN(hotEmail) AS TamanhoEmail
FROM Siscoob.dbo.tblHoteis
WHERE 
    LEN(hotNomeFantasia) > 50 OR
    LEN(hotLogradouro) > 100 OR
    LEN(hotBairro) > 50 OR
    LEN(hotCidade) > 100 OR
    LEN(hotEmail) > 150
AND  sitCodigo = 1
AND    hotCodigo NOT IN (SELECT DISTINCT hotCodigo FROM Siscoob.dbo.tblAgencia_Hoteis);
	-- Campos com suspeita de estourar o limite na tabela destino


