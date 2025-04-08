SELECT 
    sqlserver_start_time AS [SQL Server Start Time],
    DATEDIFF(HOUR, sqlserver_start_time, SYSDATETIME()) AS [Uptime in Hours],
    DATEDIFF(MINUTE, sqlserver_start_time, SYSDATETIME()) AS [Uptime in Minutes]
FROM sys.dm_os_sys_info;

SELECT 
    name AS [Database Name],
    state_desc AS [State],
    recovery_model_desc AS [Recovery Model],
    user_access_desc AS [User Access],
    is_read_only AS [Read-Only],
    is_auto_close_on AS [Auto Close],
    is_auto_shrink_on AS [Auto Shrink],
    create_date AS [Created On]
FROM sys.databases
ORDER BY name;
