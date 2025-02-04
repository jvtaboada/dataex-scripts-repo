SELECT TOP (1000) [id]
      ,[referencia]
      ,[acao]
      ,[dataHora]
  FROM [siscoob].[dbo].[tblHoteis_Reservas_Online_Controle_VFB_Logs]
  ORDER BY dataHora desc

  SELECT TOP 5 * FROM TPtblHoteis_Reservas_Online_Controle_VFB with(nolock)
  WHERE vfbIdentifier = @in_vfbIdentifier