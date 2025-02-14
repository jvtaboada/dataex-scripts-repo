sp_whoisactive

use siscoob;

SELECT TOP 10  
    s.[name] AS SchemaName,  
    t.[name] AS TableName,  
    i.[name] AS IndexName,  
    i.[type_desc] AS IndexType,  
    CAST(SUM(a.total_pages) * 8 / 1024.0 AS DECIMAL(18,2)) AS IndexSizeMB  
FROM sys.indexes i  
JOIN sys.tables t ON i.[object_id] = t.[object_id]  
JOIN sys.schemas s ON t.[schema_id] = s.[schema_id]  
JOIN sys.partitions p ON i.[object_id] = p.[object_id] AND i.[index_id] = p.[index_id]  
JOIN sys.allocation_units a ON p.[partition_id] = a.[container_id]  
WHERE i.[type] IN (1, 2)  -- Clustered e Non-clustered indexes  
GROUP BY s.[name], t.[name], i.[name], i.[type_desc]  
ORDER BY IndexSizeMB DESC;
