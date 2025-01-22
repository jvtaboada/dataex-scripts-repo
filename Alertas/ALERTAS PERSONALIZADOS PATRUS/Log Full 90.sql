USE [DBADataEX]
GO

insert into dbo.dtx_tb_Alert_Parameter ( [Nm_Alert]
,[Nm_Procedure]
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,[Vl_Parameter]
,[Ds_Metric]
,[Vl_Parameter_2]
,[Ds_Metric_2]
,[Ds_Profile_Email]
,[Ds_Email]
,[Ds_Message_Alert_ENG]
,[Ds_Message_Clear_ENG]
,[Ds_Message_Alert_PTB]
,[Ds_Message_Clear_PTB]
,[Ds_Email_Information_1_ENG]
,[Ds_Email_Information_2_ENG]
,[Ds_Email_Information_1_PTB]
,[Ds_Email_Information_2_PTB])
select 
 'Log Full 90'
,'dtx_sp_Alert_Log_Full_90'
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,[Vl_Parameter]
,[Ds_Metric]
,[Vl_Parameter_2]
,[Ds_Metric_2]
,[Ds_Profile_Email]
,Ds_Email
,[Ds_Message_Alert_ENG]
,[Ds_Message_Clear_ENG]
,[Ds_Message_Alert_PTB]
,[Ds_Message_Clear_PTB]
,[Ds_Email_Information_1_ENG]
,[Ds_Email_Information_2_ENG]
,[Ds_Email_Information_1_PTB]
,[Ds_Email_Information_2_PTB]
FROM [dbo].dtx_tb_Alert_Parameter 
where Nm_Alert like '%Log Full%'
GO


CREATE PROCEDURE [dbo].[dtx_sp_Alert_Log_Full_90] 
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
	FROM [dbo].dtx_tb_Alert_Parameter 
	WHERE Nm_Alert = 'Log Full 90'


	IF @Fl_Enable = 0
		RETURN
		
	-- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".
	SELECT @Fl_Type = [Fl_Type]
	FROM [dbo].[dtx_tb_Alert]
	WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )		


	SELECT
    db.[name] AS [Database] ,
    CAST(ls.[cntr_value] / 1024.00 AS DECIMAL(18,2)) AS [Log Size],
    CAST(    CAST(lu.[cntr_value] AS FLOAT) /
                    CASE WHEN CAST(ls.[cntr_value] AS FLOAT) = 0
                            THEN 1
                            ELSE CAST(ls.[cntr_value] AS FLOAT)
                    END AS DECIMAL(18,2)) * 100    AS [Percent Log Used],
    CAST(ds.[cntr_value] / 1024.00 AS DECIMAL(18,2)) AS [Data Size],
   CAST( (CAST(ls.[cntr_value] / 1024.00 AS DECIMAL(18,2))/ CAST(ds.[cntr_value] / 1024.00 AS DECIMAL(18,2)))*100.00 AS NUMERIC(15,2) )AS [Size Proportion (Log/Data)]
    INTO #Alert_File_Log_Full
    FROM [sys].[databases] AS db
    JOIN [sys].[dm_os_performance_counters] AS lu  ON db.[name] = lu.[instance_name]
    JOIN [sys].[dm_os_performance_counters] AS ls  ON db.[name] = ls.[instance_name]
    JOIN [sys].[dm_os_performance_counters] AS ds  ON db.[name] = ds.[instance_name]
    WHERE    lu.[counter_name] LIKE 'Log File(s) Used Size (KB)%'
            AND ls.[counter_name] LIKE 'Log File(s) Size (KB)%'
            AND ds.[counter_name] LIKE 'Data File(s) Size (KB)%'
			AND db.state_desc = 'ONLINE'
			and CAST(ls.[cntr_value] / 1024.00 AS DECIMAL(18,2))  > @Vl_Parameter_2 
			
	--	Do we have log Full?
	IF EXISTS	(
				SELECT	null
				FROM #Alert_File_Log_Full
				WHERE	[Percent Log Used] > @Vl_Parameter
				AND [Log Size] * 1024 > @Vl_Parameter_2 
				)
	BEGIN	-- BEGIN - ALERT


		IF ISNULL(@Fl_Type, 0) = 0	-- Control Alert/Clear
		BEGIN
			IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )
				DROP TABLE ##Email_HTML

			-- Databases with Log FULL
			SELECT	*
			INTO ##Email_HTML
			FROM #Alert_File_Log_Full
			WHERE	[Percent Log Used] > @Vl_Parameter
			
				
								
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

			EXEC dbo.dtx_sp_Export_Table_HTML_Output
				@Ds_Tabela = '##Email_HTML', -- varchar(max)
				@Ds_Alinhamento  = 'center',
				@Ds_OrderBy = '[Percent Log Used],[Database]',
				@Ds_Saida = @HTML OUT				-- varchar(max)

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
	END		-- END - ALERT
	ELSE 
	BEGIN	-- BEGIN - CLEAR				
		IF @Fl_Type = 1
		BEGIN			
			
			IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )
				DROP TABLE ##Email_HTML_CLEAR					
						
			SELECT TOP 50 *
			INTO ##Email_HTML_CLEAR
			FROM #Alert_File_Log_Full			
			
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
		
			EXEC dbo.dtx_sp_Export_Table_HTML_Output
				@Ds_Tabela = '##Email_HTML_CLEAR', -- varchar(max)
				@Ds_Alinhamento  = 'center',
				@Ds_OrderBy = '[Percent Log Used],[Database]',
				@Ds_Saida = @HTML OUT				-- varchar(max)

				   -- First Result
			SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space 	

			IF @Fl_Language = 1
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_PTB)
			ELSE 
				SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_2_ENG)			
				

			EXEC dbo.dtx_sp_Export_Table_HTML_Output
				@Ds_Tabela = '##Email_HTML_CLEAR_2', -- varchar(max)
				@Ds_Alinhamento  = 'center',
				@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',
				@Ds_Saida = @HTML OUT				-- varchar(max)
		
		-- Second Result
			SET @Final_HTML = @Final_HTML + @Header + @Line_Space + @HTML + @Line_Space + @Company_Link		

			EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'	
			
			-- Fl_Type = 0 : CLEAR
			INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )
			SELECT @Id_Alert_Parameter, @Ds_Subject, 0		
		END		
	END		-- END - CLEAR
END
GO


select 
*
FROM [dbo].dtx_tb_Alert_Parameter 
where Id_Alert_Parameter = 52
GO




update dbo.dtx_tb_Alert_Parameter set
Vl_Parameter = 90,
Vl_Parameter_2 = NULL,
Ds_Metric_2 = 'NULL'
where Id_Alert_Parameter = 52
go
