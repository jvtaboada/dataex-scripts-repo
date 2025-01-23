USE [msdb]
GO

/****** Object:  Job [DataEX - Coletas Adicionais]    Script Date: 10/2/2020 10:15:16 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/2/2020 10:15:16 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DataEX - Coletas Adicionais', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta Info Ambientes]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta Info Ambientes', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC DBADataEx.dbo.SP_GetSQLInfo PROD', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta Jobs]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta Jobs', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @previousdate DATETIME
DECLARE @year VARCHAR(4)
DECLARE @month VARCHAR(2)
DECLARE @monthpre VARCHAR(2)
DECLARE @day VARCHAR(2)
DECLARE @daypre VARCHAR(2)
DECLARE @finaldate INT

SET @previousdate = dateadd(dd, - 3, getdate()) -- Ultimos 3 days       
SET @year = datepart(yyyy, @previousdate)

SELECT @monthpre = convert(VARCHAR(2), datepart(mm, @previousdate))

SELECT @month = right(convert(VARCHAR, (@monthpre + 1000000000)), 2)

SELECT @daypre = convert(VARCHAR(2), datepart(dd, @previousdate))

SELECT @day = right(convert(VARCHAR, (@daypre + 1000000000)), 2)

SET @finaldate = cast(@year + @month + @day AS INT)

INSERT INTO DBADataEX..Status_Jobs
SELECT DISTINCT rtrim(ltrim(replace(j.NAME, NCHAR(0x001F), '' ''))) AS [NomeJob]
	,rtrim(ltrim(max(CONVERT(DATETIME, RTRIM(run_date)) + ((run_time / 10000 * 3600) + ((run_time % 10000) / 100 * 60) + (run_time % 10000) % 100 /*run_time_elapsed_seconds*/) / (23.999999 * 3600 /* seconds in a day*/)))) [DataUltimaExecução]
	,CASE h.run_status
		WHEN 0
			THEN ''Failed''
		WHEN 1
			THEN ''Successful''
		WHEN 3
			THEN ''Cancelled''
		WHEN 4
			THEN ''In Progress''
		END AS [Status]
FROM msdb..sysjobhistory h
INNER JOIN msdb..sysjobs j ON h.job_id = j.job_id
INNER JOIN (
	SELECT job_id
		,max(instance_id) AS instance_id
	FROM msdb..sysjobhistory
	GROUP BY job_id
	) q2 ON h.instance_id = q2.instance_id
WHERE j.job_id = h.job_id
	--and h.step_id = 1      
	AND h.run_date > @finaldate
--and h.run_date =       
--(select max(hi.run_date) from msdb..sysJobHistory hi where h.job_id = hi.job_id)      
GROUP BY j.NAME
	,CASE h.run_status
		WHEN 0
			THEN ''Failed''
		WHEN 1
			THEN ''Successful''
		WHEN 3
			THEN ''Cancelled''
		WHEN 4
			THEN ''In Progress''
		END
ORDER BY 1
	,3 DESC', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta Wait Types]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta Wait Types', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT [wait_type]
	,[wait_time_ms] / 1000.0 AS [WaitS]
	,([wait_time_ms] - [signal_wait_time_ms]) / 1000.0 AS [ResourceS]
	,[signal_wait_time_ms] / 1000.0 AS [SignalS]
	,[waiting_tasks_count] AS [WaitCount]
	,100.0 * [wait_time_ms] / SUM([wait_time_ms]) OVER () AS [Percentage]
	,ROW_NUMBER() OVER (
		ORDER BY [wait_time_ms] DESC
		) AS [RowNum]
INTO #Waits
FROM sys.dm_os_wait_stats
WHERE [wait_type] NOT IN (
		N''BROKER_EVENTHANDLER''
		,N''BROKER_RECEIVE_WAITFOR''
		,N''BROKER_TASK_STOP''
		,N''BROKER_TO_FLUSH''
		,N''BROKER_TRANSMITTER''
		,N''CHECKPOINT_QUEUE''
		,N''CHKPT''
		,N''CLR_AUTO_EVENT''
		,N''CLR_MANUAL_EVENT''
		,N''CLR_SEMAPHORE''
		,
		-- Maybe uncomment these four if you have mirroring issues
		N''DBMIRROR_DBM_EVENT''
		,N''DBMIRROR_EVENTS_QUEUE''
		,N''DBMIRROR_WORKER_QUEUE''
		,N''DBMIRRORING_CMD''
		,N''DIRTY_PAGE_POLL''
		,N''DISPATCHER_QUEUE_SEMAPHORE''
		,N''EXECSYNC''
		,N''FSAGENT''
		,N''FT_IFTS_SCHEDULER_IDLE_WAIT''
		,N''FT_IFTSHC_MUTEX''
		,
		-- Maybe uncomment these six if you have AG issues
		N''HADR_CLUSAPI_CALL''
		,N''HADR_FILESTREAM_IOMGR_IOCOMPLETION''
		,N''HADR_LOGCAPTURE_WAIT''
		,N''HADR_NOTIFICATION_DEQUEUE''
		,N''HADR_TIMER_TASK''
		,N''HADR_WORK_QUEUE''
		,N''KSOURCE_WAKEUP''
		,N''LAZYWRITER_SLEEP''
		,N''LOGMGR_QUEUE''
		,N''MEMORY_ALLOCATION_EXT''
		,N''ONDEMAND_TASK_QUEUE''
		,N''PREEMPTIVE_XE_GETTARGETSTATE''
		,N''PWAIT_ALL_COMPONENTS_INITIALIZED''
		,N''PWAIT_DIRECTLOGCONSUMER_GETNEXT''
		,N''QDS_PERSIST_TASK_MAIN_LOOP_SLEEP''
		,N''QDS_ASYNC_QUEUE''
		,N''QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP''
		,N''QDS_SHUTDOWN_QUEUE''
		,N''REDO_THREAD_PENDING_WORK''
		,N''REQUEST_FOR_DEADLOCK_SEARCH''
		,N''RESOURCE_QUEUE''
		,N''SERVER_IDLE_CHECK''
		,N''SLEEP_BPOOL_FLUSH''
		,N''SLEEP_DBSTARTUP''
		,N''SLEEP_DCOMSTARTUP''
		,N''SLEEP_MASTERDBREADY''
		,N''SLEEP_MASTERMDREADY''
		,N''SLEEP_MASTERUPGRADED''
		,N''SLEEP_MSDBSTARTUP''
		,N''SLEEP_SYSTEMTASK''
		,N''SLEEP_TASK''
		,N''SLEEP_TEMPDBSTARTUP''
		,N''SNI_HTTP_ACCEPT''
		,N''SP_SERVER_DIAGNOSTICS_SLEEP''
		,N''SQLTRACE_BUFFER_FLUSH''
		,N''SQLTRACE_INCREMENTAL_FLUSH_SLEEP''
		,N''SQLTRACE_WAIT_ENTRIES''
		,N''WAIT_FOR_RESULTS''
		,N''WAITFOR''
		,N''WAITFOR_TASKSHUTDOWN''
		,N''WAIT_XTP_RECOVERY''
		,N''WAIT_XTP_HOST_WAIT''
		,N''WAIT_XTP_OFFLINE_CKPT_NEW_LOG''
		,N''WAIT_XTP_CKPT_CLOSE''
		,N''XE_DISPATCHER_JOIN''
		,N''XE_DISPATCHER_WAIT''
		,N''XE_TIMER_EVENT''
		)
	AND [waiting_tasks_count] > 0

INSERT INTO WaitTypes
SELECT MAX([W1].[wait_type]) AS [WaitType]
	,CAST(MAX([W1].[WaitS]) AS DECIMAL(16, 2)) AS [Wait_S]
	,CAST(MAX([W1].[ResourceS]) AS DECIMAL(16, 2)) AS [Resource_S]
	,CAST(MAX([W1].[SignalS]) AS DECIMAL(16, 2)) AS [Signal_S]
	,MAX([W1].[WaitCount]) AS [WaitCount]
	,CAST(MAX([W1].[Percentage]) AS DECIMAL(5, 2)) AS [Percentage]
	,CAST((MAX([W1].[WaitS]) / MAX([W1].[WaitCount])) AS DECIMAL(16, 4)) AS [AvgWait_S]
	,CAST((MAX([W1].[ResourceS]) / MAX([W1].[WaitCount])) AS DECIMAL(16, 4)) AS [AvgRes_S]
	,CAST((MAX([W1].[SignalS]) / MAX([W1].[WaitCount])) AS DECIMAL(16, 4)) AS [AvgSig_S]
	,CAST(''https://www.sqlskills.com/help/waits/'' + MAX([W1].[wait_type]) AS XML) AS [Help/Info URL]
FROM #Waits AS [W1]
INNER JOIN #Waits AS [W2] ON [W2].[RowNum] <= [W1].[RowNum]
GROUP BY [W1].[RowNum]
HAVING SUM([W2].[Percentage]) - MAX([W1].[Percentage]) < 95;-- percentage threshold
GO
', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta VLFs]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta VLFs', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sp_MSforeachdb '' USE [?]
  EXEC sp_executesql N''''dbcc loginfo''''
  insert into DBADataEX..VLFs 
  SELECT @@ROWCOUNT, DB_NAME(), GETDATE()
''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta Backups]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta Backups', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
INSERT INTO DBADataEX..TB_Backups
SELECT 
	bs.database_name
	,CASE bs.type
		WHEN ''D''
			THEN ''FULL''
		WHEN ''L''
			THEN ''LOG''
		WHEN ''I''
			THEN ''DIFERENCIAL''
	 END AS [TipoBackup]
	,CONVERT(DECIMAL(18,3), ((bs.compressed_backup_size))/1024/1024) AS [TamanhoBackupEmMB]
	,bs.backup_finish_date AS ''DataBackup''
FROM msdb.dbo.backupmediafamily bmf
INNER JOIN msdb.dbo.backupset bs ON bmf.media_set_id = bs.media_set_id
WHERE bs.backup_start_date BETWEEN DATEADD(DAY, -1, GETDATE()) AND GETDATE()
ORDER BY bs.database_name, bs.backup_finish_date DESC
', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta Disk_Space]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta Disk_Space', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC DBADataEx.dbo.Sp_Collect_DISK_Info', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coleta CPUINFO]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coleta CPUINFO', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec DBADataEX.dbo.Sp_Collect_CPU_Info PROD', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Coletas Tbs Dbs DiscFree]    Script Date: 10/2/2020 10:15:16 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Coletas Tbs Dbs DiscFree', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
-- coleta dbs
DECLARE @DatabasesSize TABLE
    (
  DBName varchar(255),
  FileNme varchar(255),
  SpaceUsed INT,
  FreeSpaceMB FLOAT,
  size int 
    )
INSERT  INTO @DatabasesSize
EXEC sp_MSforeachdb 
      ''use [?]; Select ''''?'''' DBName, Name FileNme, fileproperty(Name,''''SpaceUsed'''') SpaceUsed,
    size/128.0 - CAST(FILEPROPERTY(NAME, ''''SpaceUsed'''') AS INT)/128.0 AS FreeSpaceMB, size
    from sysfiles''
    INSERT INTO DBADataEX.dbo.DBSize
SELECT 
    A.DBName,
    A.FileNme,
    CAST(A.SpaceUsed * 1.0 * 8 / 1024  AS DECIMAL (15,5)) AS TAMANHO_MB,
    CAST(A.SPACEUSED * 1.0 * 8 /1024/1024 AS DECIMAL(15,5)) AS TAMANHO_GB,
    CAST(A.FREESPACEMB  AS DECIMAL(15,5)) AS FREESPACE_MB,
    CAST(A.FreeSpaceMB / 1024 AS DECIMAL (15,5)) AS FREESPACE_GB,
    CAST(A.SpaceUsed * 1.0 * 8 /1024  AS DECIMAL (15,5)) +  CAST(A.FREESPACEMB AS DECIMAL(15,5)) AS TotalMB,
    CAST(A.SPACEUSED * 1.0 * 8 /1024/1024 AS DECIMAL(15,5)) + CAST(A.FreeSpaceMB / 1024 AS DECIMAL (15,5)) AS TotalGB,
    GETDATE() 
    FROM @DatabasesSize A INNER JOIN SYS.MASTER_FILES B ON A.FileNme = B.NAME COLLATE SQL_Latin1_General_CP850_CI_AS AND A.DBNAME = DB_NAME(B.database_id)
    --WHERE B.DATABASE_ID > 4

waitfor delay ''00:00:01''
-- coleta discos free

USE DBADataEX;
create table #discos 
(
 disco varchar(10),
 free_space int
-- data datetime
)
INSERT INTO #discos
exec(''xp_fixeddrives'')
go
INSERT INTO discos
SELECT
disco, free_space, data = getdate()
FROM #discos
drop table #discos

waitfor delay ''00:00:01''
declare @dia as int
SELECT @dia = DAY(getdate()); --AS DayOfMonth;
select @dia
If (@dia in (1,15))
begin
print ''roda''  
exec [dbo].[dtx_sp_SizeAllTables]
end
else
begin
print ''pula''
end
', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Diário', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20191001, 
		@active_end_date=99991231, 
		@active_start_time=83000, 
		@active_end_time=235959, 
		@schedule_uid=N'a5faa38f-b3a8-4283-be62-b4a5acfaff9c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


