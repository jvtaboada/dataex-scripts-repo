

Use DBADataEX
GO
if object_id('dtx_sp_Delete_Old_Data') is not null
	drop procedure dtx_sp_Delete_Old_Data
GO


CREATE procedure [dbo].[dtx_sp_Delete_Old_Data]
AS
BEGIN
	declare @Log_Counter int, @Log_Whoisactive int, @Table_Size_History int, --@Acesso_A_Disco int,
			@Index_Utilization_History int, @Index_Fragmentation_History int, @Queries_Profile INT,
			@Waits_Stats_History int, @File_Utilization_History INT, @Log_DB_Error int,@Log_DB_Mirror int,
			@Log_IO_Pending int,@Log_DeadLock int,@Log_AlwaysOn_AG int,@Log_Rebuild_Index int

	--Parameterization	
	select 
		@Log_Counter = 60,
		@Log_Whoisactive = 7,
		@Table_Size_History = 180,
		@Index_Utilization_History = 90,
		@Index_Fragmentation_History = 60,
		@Queries_Profile = 60,
		@File_Utilization_History = 45,
		@Log_DB_Error = 7,
		@Log_DB_Mirror = 45,
		@Waits_Stats_History = 7,
		@Log_IO_Pending = 45,
		@Log_DeadLock = 45	,
		@Log_AlwaysOn_AG = 45,
		@Log_Rebuild_Index = 90
		
	if OBJECT_ID('dtx_tb_Log_Rebuild_Index') is not null
		delete from dtx_tb_Log_Rebuild_Index
		where Dt_Operation < DATEADD(dd,@Log_Rebuild_Index*-1,getdate())

	if OBJECT_ID('dtx_tb_Log_AlwaysOn_AG') is not null
		delete from dtx_tb_Log_AlwaysOn_AG
		where Dt_Log < DATEADD(dd,@Log_AlwaysOn_AG*-1,getdate())

	if OBJECT_ID('dtx_tb_Log_DeadLock') is not null
		delete from dtx_tb_Log_DeadLock
		where eventDate < DATEADD(dd,@Log_DeadLock*-1,getdate())
	
	if OBJECT_ID('dtx_tb_Log_DB_Error') is not null
		delete from dtx_tb_Log_DB_Error
		where Dt_Error < DATEADD(dd,@Log_DB_Error*-1,getdate())

	if OBJECT_ID('dtx_tb_Log_DB_Mirror') is not null
		delete from dtx_tb_Log_DB_Mirror
		where Dt_Log < DATEADD(dd,@Log_DB_Mirror*-1,getdate())
		
	if OBJECT_ID('dtx_tb_Index_Fragmentation_History') is not null
		delete from dtx_tb_Index_Fragmentation_History
		where Dt_Log <  DATEADD(dd,@Index_Fragmentation_History*-1,getdate())
	
	if OBJECT_ID('dtx_tb_Queries_Profile') is not null
		delete from dtx_tb_Queries_Profile
		where StartTime <  DATEADD(dd,@Queries_Profile*-1,getdate())

	if OBJECT_ID('dtx_tb_Waits_Stats_History') is not null
	delete from dtx_tb_Waits_Stats_History
	where Dt_Log < DATEADD(dd,@Waits_Stats_History*-1,getdate())	

	if OBJECT_ID('dtx_tb_Log_IO_Pending') is not null
	delete from dtx_tb_Log_IO_Pending
	where Dt_Log < DATEADD(dd,@Log_IO_Pending*-1,getdate())		

	if OBJECT_ID('dtx_tb_Log_Counter') is not null
	delete from dtx_tb_Log_Counter
	where Dt_Log <  DATEADD(dd,@Log_Counter*-1,getdate())
		
		if OBJECT_ID('dtx_tb_Log_Whoisactive') is not null
	delete from dtx_tb_Log_Whoisactive
	where Dt_Log <  DATEADD(dd,@Log_Whoisactive*-1,getdate())
	
	if OBJECT_ID('dtx_tb_Table_Size_History') is not null
	delete from dtx_tb_Table_Size_History
	where Dt_Log <  DATEADD(dd,@Table_Size_History*-1,getdate())

	if OBJECT_ID('dtx_tb_File_Utilization_History') is not null
	delete from dtx_tb_File_Utilization_History
	where Dt_Log <  DATEADD(dd,@File_Utilization_History*-1,getdate())	

END

GO
USE [msdb]
GO
GO
IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'DataEX - Delete OLD Data')
EXEC msdb.dbo.sp_delete_job @job_name=N'DataEX - Delete OLD Data', @delete_unused_schedule=1
GO


/****** Object:  Job [DataEX - Delete OLD Data]    Script Date: 9/9/2019 11:06:01 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 9/9/2019 11:06:01 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DataEX - Delete OLD Data', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Nenhuma descri��o dispon�vel.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DTX_DBA_Team_Operator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DataEX -  Delete OLD Data]    Script Date: 9/9/2019 11:06:02 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DataEX -  Delete OLD Data', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dtx_sp_Delete_Old_Data', 
		@database_name=N'DBADataEX', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DataEX - Old Data', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140705, 
		@active_end_date=99991231, 
		@active_start_time=235000, 
		@active_end_time=235959, 
		@schedule_uid=N'a8d38f70-b992-45f2-b3d8-16ffdc5a9166'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

