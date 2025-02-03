use siscoob;

SELECT f.name AS [File Name] , f.physical_name AS [Physical Name], 
CAST((f.size/128.0/1024) AS DECIMAL(15,2)) AS [Total Size in GB],
CAST(f.size/128.0/1024 - CAST(FILEPROPERTY(f.name, 'SpaceUsed') AS int)/128.0/1024 AS DECIMAL(15,2)) AS [Available Space In GB],
f.[file_id], fg.name AS [Filegroup Name],
f.is_percent_growth, f.growth/128 as growth_MB, fg.is_default, fg.is_read_only
FROM sys.database_files AS f WITH (NOLOCK) 
LEFT OUTER JOIN sys.filegroups AS fg WITH (NOLOCK)
ON f.data_space_id = fg.data_space_id
ORDER BY f.[file_id] OPTION (RECOMPILE)


select top 50 DBName,FileNme,tam_gb,freespace_gb,total_gb,data from DBADataEX.dbo.DBSize 
where DBName = 'siscoob' and FileNme = 'siscoob_log'
order by data desc
 
 

select * from DBADataEX.