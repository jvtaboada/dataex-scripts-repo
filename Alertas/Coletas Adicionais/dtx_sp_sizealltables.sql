USE [DBADataEX]
GO

/****** Object:  StoredProcedure [dbo].[dtx_sp_SizeAllTables]    Script Date: 10/2/2020 10:15:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[dtx_sp_SizeAllTables]
with encryption
as
EXECUTE sp_MSforeachdb 'USE [?]; INSERT
    DBADataEX..dtx_tb_tbsize
SELECT  
''?'' as db,    
t.NAME AS TableName,    
s.Name AS SchemaName,    
p.rows AS RowCounts,    
SUM(a.total_pages) * 8 AS reserved_KB,   
CAST(SUM(a.total_pages) * 8 /1024.00 as NUMERIC(36, 4)) AS reserved_MB,  
CAST(SUM(a.total_pages) *(8 /1024.00)/1024.00 as NUMERIC(36, 4)) AS reserved_GB,     
SUM(a.used_pages) * 8 AS used_KB, -- soma de data + index_size 
CAST(SUM(a.used_pages) * 8 /1024.00 as NUMERIC(36, 4)) AS used_MB, -- soma de data + index_size 
CAST(SUM(a.used_pages) *(8 /1024.00)/1024.00 as NUMERIC(36, 4)) AS used_GB, -- soma de data + index_size 
(SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS unused_KB,
CAST((SUM(a.total_pages) - SUM(a.used_pages)) * 8 /1024.00 as NUMERIC(36, 4)) AS unused_MB,
CAST((SUM(a.total_pages) - SUM(a.used_pages)) *(8 /1024.00)/1024.00 as NUMERIC(36, 4)) AS unused_GB,
GETDATE() as [date] 
FROM     sys.tables t 
INNER JOIN      sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id 
INNER JOIN     sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN     sys.schemas s ON t.schema_id = s.schema_id 
WHERE    p.rows > 0 AND t.is_ms_shipped = 0    AND i.OBJECT_ID > 255 
GROUP BY     t.Name, s.Name, p.Rows';
-- ORDER BY t.NAME ASC' ;
GO


