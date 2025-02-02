SELECT TOP (1000) [drive]
      ,[FreeSpace]
      ,[TotalSize]
      ,[DataHora]
  FROM [DBADataEX].[dbo].[Disk_Space]
  ORDER BY 4 DESC
