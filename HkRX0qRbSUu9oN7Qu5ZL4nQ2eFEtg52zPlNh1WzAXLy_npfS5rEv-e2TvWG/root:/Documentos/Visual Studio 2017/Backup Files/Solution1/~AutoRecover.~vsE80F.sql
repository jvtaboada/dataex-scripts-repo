SELECT 
    sqlserver_start_time AS [SQL Server Start Time],
    DATEDIFF(HOUR, sqlserver_start_time, SYSDATETIME()) AS [Uptime in Hours],
    DATEDIFF(MINUTE, sqlserver_start_time, SYSDATETIME()) AS [Uptime in Minutes]
FROM sys.dm_os_sys_info;
