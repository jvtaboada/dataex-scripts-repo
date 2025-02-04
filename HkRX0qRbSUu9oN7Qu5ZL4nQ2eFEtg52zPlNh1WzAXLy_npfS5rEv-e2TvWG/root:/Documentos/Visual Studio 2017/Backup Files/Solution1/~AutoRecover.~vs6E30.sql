sp_helptext sp_Monitor_CA

DECLARE @ProcedureName NVARCHAR(128) = 'sp_Monitor_CA'
DECLARE @sql NVARCHAR(MAX)

SET @sql = ''

SELECT @sql = @sql + 
'SELECT ''' + name + ''' AS DatabaseName, 
       p.name AS ProcedureName
 FROM ' + QUOTENAME(name) + '.sys.procedures p 
 WHERE p.name = ''' + @ProcedureName + '''
 UNION ALL '
FROM sys.databases 
WHERE state_desc = 'ONLINE'

SET @sql = LEFT(@sql, LEN(@sql) - 10) -- Remove o último "UNION ALL"

EXEC sp_executesql @sql



sp_whoisactive