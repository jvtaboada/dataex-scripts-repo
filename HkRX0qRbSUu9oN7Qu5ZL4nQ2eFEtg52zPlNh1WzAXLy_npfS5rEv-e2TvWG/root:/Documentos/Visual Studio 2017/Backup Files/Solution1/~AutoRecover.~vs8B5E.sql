USE bdcrm

SELECT 
    DB_NAME(ps.database_id) AS DatabaseName,
    OBJECT_NAME(ps.object_id, ps.database_id) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    ps.index_type_desc,
    ps.avg_fragmentation_in_percent,
    ps.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS ps
JOIN sys.indexes AS i 
    ON ps.object_id = i.object_id 
    AND ps.index_id = i.index_id
WHERE ps.index_id > 0  -- Exclui heaps (tabelas sem índice clustered)
AND ps.avg_fragmentation_in_percent > 30
AND ps.page_count > 999
ORDER BY ps.avg_fragmentation_in_percent DESC;

