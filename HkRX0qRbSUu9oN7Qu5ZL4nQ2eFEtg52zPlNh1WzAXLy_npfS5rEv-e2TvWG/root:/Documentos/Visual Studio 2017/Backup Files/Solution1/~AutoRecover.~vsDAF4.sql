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
AND    hotCodigo NOT IN (SELECT DISTINCT hotCodigo FROM Siscoob.dbo.tblAgencia_Hoteis)

SELECT * FROM Siscoob.dbo.tblAgencia_Hoteis