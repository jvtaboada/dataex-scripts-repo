SELECT 
    name AS FileName, 
    type_desc AS FileType, 
    physical_name AS PhysicalLocation, 
    (size * 8) / 1024 AS SizeMB, 
    ((size - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)) * 8) / 1024 AS FreeSpaceMB
FROM sys.master_files;

DBCC SQLPERF(LOGSPACE);

sp_whoisactive