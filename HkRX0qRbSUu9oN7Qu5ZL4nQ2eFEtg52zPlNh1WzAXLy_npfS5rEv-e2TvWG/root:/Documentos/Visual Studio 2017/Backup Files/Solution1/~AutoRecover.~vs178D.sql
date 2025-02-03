DBCC SQLPERF(LOGSPACE);

use siscoob
DBCC Opentran()

select @@VERSION

SELECT 
    r.session_id,
    r.start_time,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.blocking_session_id,
    DB_NAME(r.database_id) AS database_name
FROM 
    sys.dm_exec_requests r
WHERE 
    r.database_id = DB_ID('siscoob')
ORDER BY 
    r.start_time ASC;
