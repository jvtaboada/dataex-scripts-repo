EXEC sp_configure 'backup compression default';

SELECT value, value_in_use 
FROM sys.configurations 
WHERE name = 'backup compression default';

sp_whoisactive