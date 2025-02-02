sp_whoisactive

select @@VERSION

EXEC xp_fixeddrives;

SELECT 
    name AS NomeArquivo, 
    physical_name AS Caminho, 
    size * 8 / 1024 AS Tamanho_MB,
    size * 8 / 1024.0 - FILEPROPERTY(name, 'SpaceUsed') * 8 / 1024.0 AS Espaco_Livre_MB
FROM sys.master_files;

SELECT  
    vs.volume_mount_point AS Disco,  
    vs.total_bytes / 1024 / 1024 AS Tamanho_Total_MB,  
    vs.available_bytes / 1024 / 1024 AS Espaco_Livre_MB,  
    mf.physical_name AS CaminhoArquivo
FROM sys.master_files AS mf
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) AS vs;
