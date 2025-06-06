USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_Every_Minute]    Script Date: 05/03/2025 12:00:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[dtx_sp_Alert_Every_Minute]
AS
BEGIN

	--Alerts
	EXEC dbo.dtx_sp_WhoIsActive_Result

	-- Just on the business time
	IF ( DATEPART(HOUR, GETDATE()) >= 6 AND DATEPART(HOUR, GETDATE()) < 23 )
	BEGIN
		EXEC dbo.dtx_sp_Alert_Blocked_Process 'Blocked Process'

		EXEC dbo.dtx_sp_Alert_Blocked_Process 'Blocked Long Process'

		EXEC dbo.dtx_sp_Alert_CPU_Utilization

		EXEC [dbo].[dtx_sp_Alert_CPU_Utilization_PagerDuty]

	END

	EXEC dbo.dtx_sp_Alert_CPU_Utilization_MI

	EXEC dbo.dtx_sp_Alert_Database_Status

	EXEC dbo.dtx_sp_Alert_IO_Pending 

	EXEC dbo.dtx_sp_Alert_Large_LDF_File

	EXEC dbo.dtx_sp_Alert_Log_Full

	EXEC dbo.dtx_sp_Alert_Memory_Available

	EXEC [dbo].dtx_sp_Alert_Memory_Available_PagerDuty

	EXEC dbo.dtx_sp_Alert_Page_Corruption

	EXEC dbo.dtx_sp_Alert_SQLServer_Restarted

	EXEC dbo.dtx_sp_Alert_SQLServer_Restarted_PagerDuty
	

	-- Executado a cada 20 minutos
	--IF ( DATEPART(mi, GETDATE()) %20 = 0 )
	--BEGIN
	--	EXEC dbo.dtx_sp_Alert_SQLServer_Restarted

	--	Exec [dbo].dtx_sp_Alert_SQLServer_Restarted_PagerDuty  
	--END
	
	-- Every Five minute
	IF  DATEPART(MINUTE,GETDATE()) % 5 = 0 
	BEGIN
		EXEC dbo.dtx_sp_Alert_Disk_Space
		EXEC [dbo].[dtx_sp_Alert_Disk_Space_PagerDuty]  
		EXEC dbo.dtx_sp_Alert_Tempdb_MDF_File_Utilization
	END

	IF  DATEPART(MINUTE,GETDATE()) = 58 -- Every hour
	BEGIN 
		EXEC dbo.dtx_sp_Read_Error_log 1 -- Just if Error Log size < 5 MB (VL_Parameter_2). 
		EXEC dbo.dtx_sp_Alert_Slow_Disk 'Slow Disk Every Hour' --Disable by default. Do a update on the table Alert_Parameter
		EXEC dbo.dtx_sp_Alert_SQLServer_Connection
		EXEC dbo.dtx_sp_Alert_Database_Without_Log_Backup
		EXEC dtx_sp_Alert_MaxSize_Growth
	END

	--IF CONVERT(char(20), SERVERPROPERTY('IsClustered')) = 1	
	--BEGIN	
	--	EXEC dtx_sp_Alert_Cluster_Active_Node
	--	EXEC dtx_sp_Alert_Cluster_Node_Status
	--END

END
