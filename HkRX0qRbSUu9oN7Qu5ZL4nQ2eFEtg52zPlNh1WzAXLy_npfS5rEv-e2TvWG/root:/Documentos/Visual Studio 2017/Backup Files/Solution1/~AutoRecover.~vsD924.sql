SELECT 
    b.database_name,
    b.backup_finish_date,
    b.backup_size / 1024 / 1024 AS backup_size_MB,
    b.type AS backup_type,
    CASE 
        WHEN b.type = 'D' THEN 'Full'
        WHEN b.type = 'I' THEN 'Differential'
        WHEN b.type = 'L' THEN 'Log'
        ELSE 'Unknown'
    END AS backup_type_description,
    b.backup_set_id,
    b.recovery_model,
    bm.physical_device_name
FROM 
    msdb.dbo.backupset b
JOIN 
    msdb.dbo.backupmediafamily bm ON b.media_set_id = bm.media_set_id
WHERE 
    b.database_name = 'siscoob'  -- Substitua pelo nome do seu banco de dados
ORDER BY 
    b.backup_finish_date DESC;
