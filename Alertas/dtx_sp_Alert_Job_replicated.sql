USE [DBADataEX]
GO

/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_Job_replicated]    Script Date: 9/3/2024 10:37:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dtx_sp_Alert_Job_replicated]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Id_Alert_Parameter SMALLINT, @Fl_Enable BIT, @Fl_Type TINYINT, @Vl_Parameter SMALLINT,@Ds_Email VARCHAR(500),@Ds_Profile_Email VARCHAR(200),@Dt_Now DATETIME,@Vl_Parameter_2 INT,
	@Ds_Email_Information_1_ENG VARCHAR(200), @Ds_Email_Information_2_ENG VARCHAR(200), @Ds_Email_Information_1_PTB VARCHAR(200), @Ds_Email_Information_2_PTB VARCHAR(200),
	@Ds_Message_Alert_ENG varchar(1000),@Ds_Message_Clear_ENG varchar(1000),@Ds_Message_Alert_PTB varchar(1000),@Ds_Message_Clear_PTB varchar(1000), @Ds_Subject VARCHAR(500)
	
	DECLARE @Company_Link  VARCHAR(4000),@Line_Space VARCHAR(4000),@Header_Default VARCHAR(4000),@Header VARCHAR(4000),@Fl_Language BIT,@Final_HTML VARCHAR(MAX),@HTML VARCHAR(MAX)		
	
	declare @Ds_Alinhamento VARCHAR(10),@Ds_OrderBy VARCHAR(MAX) 	
	
								
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
	FROM dbo.dtx_tb_Alert_Parameter 
	WHERE Nm_Alert = 'Job replicated'


--Jobs
SELECT	name, date_created, date_modified, enabled = case when enabled = 1 then 'yes' Else 'no' end

		INTO #TempPrimaryJobs

		FROM msdb..sysjobs

 
SELECT name, date_created, date_modified, enabled = case when enabled = 1 then 'yes' Else 'no' end

		INTO #TempSecondaryJobs

		FROM [LKD_DATAEX].[msdb].[dbo].[sysjobs]	

		IF ( OBJECT_ID('tempdb..#Alert_Job_replicated') IS NOT NULL ) 
		DROP TABLE #Alert_Job_replicated

		SELECT AGPRIMARY.name, AGPRIMARY.date_created, AGPRIMARY.date_modified, AGPRIMARY.enabled
		INTO #Alert_Job_replicated
		FROM #TempPrimaryJobs AGPRIMARY
		WHERE NOT EXISTS(SELECT AGSECONDARY.name
		FROM #TempSecondaryJobs AGSECONDARY
		WHERE AGPRIMARY.name = AGSECONDARY.name)
		
IF EXISTS (  SELECT Top 1 name FROM #Alert_Job_replicated )
BEGIN

 IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )
		DROP TABLE ##Email_HTML
BEGIN
      		SELECT	name, date_created, date_modified, enabled
			INTO ##Email_HTML
			FROM #Alert_Job_replicated
							 
		-- Get HTML Informations
		SELECT @Company_Link = Company_Link,
			@Line_Space = Line_Space,
			@Header_Default = Header
		FROM dtx_tb_HTML_Parameter
			
		IF @Fl_Language = 1 --Portuguese
		BEGIN
				SET @Header = REPLACE(REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_PTB),'###1',@Vl_Parameter)
				SET @Ds_Subject =  REPLACE(@Ds_Message_Alert_PTB,'###1',@Vl_Parameter)+@@SERVERNAME 
		END
        ELSE 
		BEGIN
			SET @Header = REPLACE(REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_ENG),'###1',@Vl_Parameter)
			SET @Ds_Subject =  REPLACE(@Ds_Message_Alert_ENG,'###1',@Vl_Parameter)+@@SERVERNAME 
		END		   		

		EXEC dbo.dtx_sp_Export_Table_HTML_Output
			@Ds_Tabela = '##Email_HTML', -- varchar(max)
			@Ds_Alinhamento  = 'center',
			@Ds_OrderBy = '[date_created]',
			@Ds_Saida = @HTML OUT				-- varchar(max)
					
						
		-- First Result
			-- First Result
		SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space + @Company_Link	

	    EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'			


		-- Fl_Type = 1 : ALERT	
		INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )
		SELECT @Id_Alert_Parameter, @Ds_Subject, 1		
	END -- END - ALERT
END
END
GO