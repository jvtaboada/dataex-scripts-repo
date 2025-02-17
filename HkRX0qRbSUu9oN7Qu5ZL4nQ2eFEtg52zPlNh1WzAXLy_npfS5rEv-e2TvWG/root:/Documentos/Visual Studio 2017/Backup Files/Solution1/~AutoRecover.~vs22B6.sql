sp_whoisactive

SELECT 
    DB_NAME(database_id) AS DatabaseName,
    SUM(size * 8) / 1024 AS SizeMB -- Convertendo de páginas (8 KB) para MB
FROM sys.master_files
WHERE type = 0 -- Apenas arquivos de dados (exclui logs)
GROUP BY database_id
ORDER BY SizeMB DESC;
