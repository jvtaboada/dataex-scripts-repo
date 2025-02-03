DBCC SQLPERF(LOGSPACE);

use siscoob
DBCC Opentran()

select @@VERSION

SELECT 
    name AS file_name,
    size * 8 / 1024 AS size_mb,
    growth * 8 / 1024 AS growth_mb,
    is_percent_growth
FROM 
    sys.database_files
WHERE 
    type_desc = 'LOG';
