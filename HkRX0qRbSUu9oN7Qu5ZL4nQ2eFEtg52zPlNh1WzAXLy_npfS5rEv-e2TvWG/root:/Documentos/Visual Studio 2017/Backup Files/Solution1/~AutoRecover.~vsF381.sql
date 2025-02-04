SELECT TOP (1000) [id]
      ,[referencia]
      ,[acao]
      ,[dataHora]
  FROM [siscoob].[dbo].[tblHoteis_Reservas_Online_Controle_VFB_Logs]
  ORDER BY dataHora desc

USE DBADataEX
SELECT * FROM dtx_tb_Queries_Profile
with (nolock)
WHERE StartTime >= '2025-04-02 00:00:00'
AND DataBaseName = 'siscoob'
ORDER BY Writes DESC