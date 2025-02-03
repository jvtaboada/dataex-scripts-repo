SELECT
	s.name [DB_Name], 
	f.[name] [File_Name],
	f.physical_name,
	--((f.size*8)/1024/1024) as [size(GB)]
	(CAST(size as BIGINT)*8)/1024/1024 as [size(GB)]
	FROM sys.master_files f inner join sys.databases s 
	on f.database_id=s.database_id
	where f.physical_name like 'H:%'
	order by 4 desc