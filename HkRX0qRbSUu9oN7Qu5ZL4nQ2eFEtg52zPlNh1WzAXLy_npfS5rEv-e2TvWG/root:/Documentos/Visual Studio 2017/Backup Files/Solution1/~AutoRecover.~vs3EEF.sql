SELECT TOP (1000) [disco]
      ,[free_space]
      ,[data]
  FROM [DBADataEX].[dbo].[discos]
  ORDER BY 3 DESC

  DBCC SQLPERF(LOGSPACE);