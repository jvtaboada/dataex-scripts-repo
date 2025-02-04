SELECT TOP (1000) [id]
      ,[referencia]
      ,[acao]
      ,[dataHora]
  FROM [siscoob].[dbo].[tblHoteis_Reservas_Online_Controle_VFB_Logs]
  ORDER BY dataHora desc
