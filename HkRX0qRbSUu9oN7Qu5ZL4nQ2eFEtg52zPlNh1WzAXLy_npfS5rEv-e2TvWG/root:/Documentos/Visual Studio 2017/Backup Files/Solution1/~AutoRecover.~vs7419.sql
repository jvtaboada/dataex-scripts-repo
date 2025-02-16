use siscoob

SELECT
    o.[name] AS Table_Name,
    s.[name] AS Schema_Name,
    i.[name] AS Index_Name,
    i.type_desc AS Index_Type,
    ps.avg_fragmentation_in_percent AS Avg_Fragmentation,
    ps.page_count AS Page_Count,
    i.is_disabled AS Is_Disabled,
    i.fill_factor AS Fill_Factor,
    i.is_unique AS Is_Unique,
    i.is_primary_key AS Is_Primary_Key,
    i.is_unique_constraint AS Is_Unique_Constraint
FROM sys.dm_db_index_physical_stats (DB_ID('siscoob'), NULL, NULL, NULL, 'DETAILED') ps -- Alterar o nome da base dentro do DB_ID('nome-da-base'
INNER JOIN sys.indexes i
    ON ps.object_id = i.object_id AND ps.index_id = i.index_id
INNER JOIN sys.objects o
    ON i.object_id = o.object_id
INNER JOIN sys.schemas s
    ON o.schema_id = s.schema_id
WHERE ps.avg_fragmentation_in_percent > 30 -- Alterar para rodar mais rápido
ORDER BY ps.avg_fragmentation_in_percent DESC;