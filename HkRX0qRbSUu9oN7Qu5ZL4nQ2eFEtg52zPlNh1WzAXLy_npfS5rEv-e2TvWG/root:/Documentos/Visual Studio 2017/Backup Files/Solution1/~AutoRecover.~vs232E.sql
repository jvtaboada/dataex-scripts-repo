USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_Disk_Space]    Script Date: 02/02/2025 08:58:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dtx_sp_Alert_Disk_Space]
AS
BEGIN
	
	SET NOCOUNT ON

	DECLARE @Id_Alert_Parameter SMALLINT, @Fl_Enable BIT, @Fl_Type TINYINT, @Vl_Parameter SMALLINT,@Ds_Email VARCHAR(500),@Ds_Profile_Email VARCHAR(200),@Dt_Now DATETIME,@Vl_Parameter_2 INT,
		@Ds_Email_Information_1_ENG VARCHAR(200), @Ds_Email_Information_2_ENG VARCHAR(200), @Ds_Email_Information_1_PTB VARCHAR(200), @Ds_Email_Information_2_PTB VARCHAR(200),
		@Ds_Message_Alert_ENG varchar(1000),@Ds_Message_Clear_ENG varchar(1000),@Ds_Message_Alert_PTB varchar(1000),@Ds_Message_Clear_PTB varchar(1000), @Ds_Subject VARCHAR(500)
	
	DECLARE @Company_Link  VARCHAR(4000),@Line_Space VARCHAR(4000),@Header_Default VARCHAR(4000),@Header VARCHAR(4000),@Fl_Language BIT,@Final_HTML VARCHAR(MAX),@HTML VARCHAR(MAX)		
	
	DECLARE @Ds_Alinhamento VARCHAR(10),@Ds_OrderBy VARCHAR(MAX) 	
	

							
	-- Alert information
	SELECT @Id_Alert_Parameter = Id_Alert_Parameter, 
		@Fl_Enable = Fl_Enable, 
		@Vl_Parameter = Vl_Parameter,		-- Minutes,
		@Ds_Email = Ds_Email,
		@Fl_Language = Fl_Language,
		@Ds_Profile_Email = Ds_Profile_Email,
		@Vl_Parameter_2 = Vl_Parameter_2,		--minute
		@Dt_Now = GETDATE(),
		@Ds_Message_Alert_ENG = Ds_Message_Alert_ENG,
		@Ds_Message_Clear_ENG = Ds_Message_Clear_ENG,
		@Ds_Message_Alert_PTB = Ds_Message_Alert_PTB,
		@Ds_Message_Clear_PTB = Ds_Message_Clear_PTB,
		@Ds_Email_Information_1_ENG = Ds_Email_Information_1_ENG,
		@Ds_Email_Information_2_ENG = Ds_Email_Information_2_ENG,
		@Ds_Email_Information_1_PTB = Ds_Email_Information_1_PTB,
		@Ds_Email_Information_2_PTB = Ds_Email_Information_2_PTB
	FROM [dbo].dtx_tb_Alert_Parameter 
	WHERE Nm_Alert = 'Disk Space'

	IF @Fl_Enable = 0
		RETURN
		
	-- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".
	SELECT @Fl_Type = [Fl_Type]
	FROM [dbo].[dtx_tb_Alert]
	WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )		
	
	DECLARE @Ole_Automation sql_variant
	SELECT @Ole_Automation = value_in_use
	FROM sys.configurations
	WHERE name = 'Ole Automation Procedures' 
	
	IF ( OBJECT_ID('tempdb..#diskspace') IS NOT NULL )
		DROP TABLE #diskspace

	CREATE TABLE [#diskspace] (
		[Drive]				VARCHAR (10),
		[Size (MB)]		INT,
		[Used (MB)]		INT,
		[Free (MB)]		INT,
		[Free (%)]			INT,
		[Used (%)]			INT,
		[Used SQL (MB)]	INT, 
		[Date]			varchar(20)
	)

	IF ( OBJECT_ID('tempdb..#Database_Driver_Letters') IS NOT NULL )
		DROP TABLE #Database_Driver_Letters

	CREATE TABLE [dbo].#Database_Driver_Letters(
		[Disk] [VARCHAR](256) NULL,
		[Total Size in GB] [DECIMAL](15, 2) NULL,
		[Used Size in GB] [DECIMAL](15, 2) NULL,
		[Available Size in GB] [DECIMAL](15, 2) NULL,
		[Space Free %] [DECIMAL](15, 2) NULL ,
		[Space Used %] [DECIMAL](15, 2) NULL ) 

	IF @Ole_Automation = 1	
	BEGIN    

		IF ( OBJECT_ID('tempdb..#dbspace') IS NOT NULL )
			DROP TABLE #dbspace
		
		CREATE TABLE #dbspace (
			[name]		SYSNAME,
			[Path]	VARCHAR(200),
			[Size]	VARCHAR(10),
			[drive]		VARCHAR(30)
		)
		
		IF ( OBJECT_ID('tempdb..#space') IS NOT NULL ) 
			DROP TABLE #space 

		CREATE TABLE #space (
			[drive]		CHAR(1),
			[mbfree]	INT
		)
		EXEC sp_MSforeachdb 'Use [?] INSERT INTO #dbspace SELECT CONVERT(VARCHAR(25), DB_Name()) ''Database'', CONVERT(VARCHAR(60), FileName), CONVERT(VARCHAR(8), Size / 128) ''Size in MB'', CONVERT(VARCHAR(30), Name) FROM sysfiles'

		DECLARE @hr INT, @fso INT, @mbtotal INT, @TotalSpace INT, @MBFree INT, @Percentage INT,
				@SQLDriveSize INT, @size float, @drive VARCHAR(1), @fso_Method VARCHAR(255)

		SELECT	@mbtotal = 0, 
				@mbtotal = 0
			
		EXEC @hr = [master].[dbo].[sp_OACreate] 'Scripting.FilesystemObject', @fso OUTPUT
		
		INSERT INTO #space 
		EXEC [master].[dbo].[xp_fixeddrives]	

		DECLARE CheckDrives CURSOR FOR SELECT drive,mbfree FROM #space
		OPEN CheckDrives
		FETCH NEXT FROM CheckDrives INTO @drive, @MBFree
		WHILE(@@FETCH_STATUS = 0)
		BEGIN
			SET @fso_Method = 'Drives("' + @drive + ':").TotalSize'
		
			SELECT @SQLDriveSize = SUM(CONVERT(INT, [Size])) 
			FROM #dbspace 
			WHERE SUBSTRING([Path], 1, 1) = @drive
		
			EXEC @hr = [sp_OAMethod] @fso, @fso_Method, @size OUTPUT
		
			SET @mbtotal =  @size / (1024 * 1024)
		
			INSERT INTO #diskspace 
			VALUES(	@drive + ':', @mbtotal, @mbtotal - @MBFree, @MBFree, (100 * ROUND(@MBFree, 2) / ROUND(@mbtotal, 2)), 
					(100 - 100 * ROUND(@MBFree, 2) / ROUND(@mbtotal, 2)), @SQLDriveSize, CONVERT(VARCHAR(20), GETDATE(), 120))

			FETCH NEXT FROM CheckDrives INTO @drive,@MBFree
		END
		CLOSE CheckDrives
		DEALLOCATE CheckDrives
	END
	ELSE
		BEGIN
			INSERT INTO #Database_Driver_Letters
			SELECT DISTINCT 
					volume_mount_point , 
				--	file_system_type [File System Type], 
				--	logical_volume_name as [Logical Drive Name], 
					CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) AS [Total Size in GB], ---1GB = 1073741824 bytes
					(CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) - CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) ) AS [Used Size in GB],
					CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) AS [Available Size in GB], 
					CAST(CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) * 100 AS [Space Free %] ,
					100-(CAST(CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) * 100) AS [Space Used %] 		
			FROM sys.master_files 
			CROSS APPLY sys.dm_os_volume_stats(database_id, file_id)

		END
				
	/*******************************************************************************************************************************
	--	Do we have disk space problems?
	*******************************************************************************************************************************/
	IF (
			@Ole_Automation = 1 AND EXISTS	(SELECT NULL FROM #diskspace WHERE [Used (%)] > @Vl_Parameter)
		OR
			@Ole_Automation = 0 AND EXISTS (SELECT NULL FROM #Database_Driver_Letters WHERE [Space Used %]  > @Vl_Parameter)
	   )

	BEGIN	-- 
		IF ISNULL(@Fl_Type, 0) = 0	
		BEGIN				
			
				IF ( OBJECT_ID('tempdb..##Email_HTML_2') IS NOT NULL )
					DROP TABLE ##Email_HTML_2	
				 	
				SELECT TOP 50 *
				INTO ##Email_HTML_2
				FROM ##WhoIsActive_Result
				
				 
			-- Get HTML Informations
			SELECT @Company_Link = Company_Link,
				@Line_Space = Line_Space,
				@Header_Default = Header
			FROM dtx_tb_HTML_Parameter
			
			IF @Fl_Language = 1 --Portuguese
			BEGIN
				 SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_PTB)
				 SET @Ds_Subject =  REPLACE(@Ds_Message_Alert_PTB,'###1',@Vl_Parameter)+@@SERVERNAME 
			END
           ELSE 
		   BEGIN
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_ENG)
				SET @Ds_Subject =  REPLACE(@Ds_Message_Alert_ENG,'###1',@Vl_Parameter)+@@SERVERNAME 
		   END		   		


		  IF @Ole_Automation = 1
			BEGIN 		
				
			   IF ( OBJECT_ID('tempdb..##Email_HTML_Ole_Automation') IS NOT NULL )
					DROP TABLE ##Email_HTML_Ole_Automation

					select	*
					INTO ##Email_HTML_Ole_Automation
					from #diskspace					


					EXEC dbo.dtx_sp_Export_Table_HTML_Output
						@Ds_Tabela = '##Email_HTML_Ole_Automation', -- varchar(max)
						@Ds_Alinhamento  = 'center',
						@Ds_OrderBy = '[Drive]',
						@Ds_Saida = @HTML OUT				-- varchar(max)
			END
			ELSE
			BEGIN
					
				   IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )
						DROP TABLE ##Email_HTML

					select	*
					INTO ##Email_HTML
					from #Database_Driver_Letters				

					EXEC dbo.dtx_sp_Export_Table_HTML_Output
						@Ds_Tabela = '##Email_HTML', -- varchar(max)
						@Ds_Alinhamento  = 'center',
						@Ds_OrderBy = '[Disk]',
						@Ds_Saida = @HTML OUT				-- varchar(max)
			END		
				

			-- First Result
			SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space 		
				
			EXEC dbo.dtx_sp_Export_Table_HTML_Output
				@Ds_Tabela = '##Email_HTML_2', -- varchar(max)
				@Ds_Alinhamento  = 'center',
				@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',
				@Ds_Saida = @HTML OUT				-- varchar(max)			

			IF @Fl_Language = 1
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_PTB)
			ELSE 
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_ENG)				

			-- Second Result
			SET @Final_HTML = @Final_HTML + @Header + @Line_Space + @HTML + @Line_Space + @Company_Link			

			EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'								
		
			-- Fl_Type = 1 : ALERT	
			INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )
			SELECT @Id_Alert_Parameter, @Ds_Subject, 1			
		
			
		END
	END		-- FIM - ALERTA
	ELSE 
	BEGIN	-- INICIO - CLEAR				
		IF @Fl_Type = 1
		BEGIN


				IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR_2') IS NOT NULL )
					DROP TABLE ##Email_HTML_CLEAR_2	
				 	
				SELECT TOP 50 *
				INTO ##Email_HTML_CLEAR_2
				FROM ##WhoIsActive_Result
			
				 
			-- Get HTML Informations
			SELECT @Company_Link = Company_Link,
				@Line_Space = Line_Space,
				@Header_Default = Header
			FROM dtx_tb_HTML_Parameter
			

			IF @Fl_Language = 1 --Portuguese
			BEGIN
				 SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_PTB)
				 SET @Ds_Subject =  REPLACE(@Ds_Message_Clear_PTB,'###1',@Vl_Parameter)+@@SERVERNAME 
			END
           ELSE 
		   BEGIN
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_ENG)
				SET @Ds_Subject =  REPLACE(@Ds_Message_Clear_ENG,'###1',@Vl_Parameter)+@@SERVERNAME 
		   END		   		

		     IF @Ole_Automation = 1
			BEGIN 		
				
			   IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR_Ole_Automation') IS NOT NULL )
					DROP TABLE ##Email_HTML_CLEAR_Ole_Automation

					select	*
					INTO ##Email_HTML_CLEAR_Ole_Automation
					from #diskspace
					

					EXEC dbo.dtx_sp_Export_Table_HTML_Output
						@Ds_Tabela = '##Email_HTML_CLEAR_Ole_Automation', -- varchar(max)
						@Ds_Alinhamento  = 'center',
						@Ds_OrderBy = '[Drive]',
						@Ds_Saida = @HTML OUT				-- varchar(max)
			END
			ELSE
			BEGIN
					
				   IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )
						DROP TABLE ##Email_HTML_CLEAR

					select	*
					INTO ##Email_HTML_CLEAR
					from #Database_Driver_Letters
				

					EXEC dbo.dtx_sp_Export_Table_HTML_Output
						@Ds_Tabela = '##Email_HTML_CLEAR', -- varchar(max)						
						@Ds_Alinhamento  = 'center',
						@Ds_OrderBy = '[Disk]',
						@Ds_Saida = @HTML OUT				-- varchar(max)
			END		
				

			-- First Result
			SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space 		
				
			EXEC dbo.dtx_sp_Export_Table_HTML_Output
				@Ds_Tabela = '##Email_HTML_CLEAR_2', -- varchar(max)				
				@Ds_Alinhamento  = 'center',
				@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',
				@Ds_Saida = @HTML OUT				-- varchar(max)			

			IF @Fl_Language = 1
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_PTB)
			ELSE 
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_ENG)				

			-- Second Result
			SET @Final_HTML = @Final_HTML + @Header + @Line_Space + @HTML + @Line_Space + @Company_Link			

			EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'		
			
			-- Fl_Type = 0 : CLEAR
			INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )
			SELECT @Id_Alert_Parameter, @Ds_Subject, 0		

		END
	END		
END

