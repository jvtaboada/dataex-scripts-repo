USE [DBADataEX]
GO


USE [DBADataEX]
GO

-- MaxSize Growth

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
 'MaxSize Growth PagerDuty'
,'dtx_sp_Alert_MaxSize_Growth_PagerDuty'
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,[Vl_Parameter]
,[Ds_Metric]
,[Vl_Parameter_2]
,[Ds_Metric_2]
,[Ds_Profile_Email]
,'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com'
,[Ds_Message_Alert_ENG]
,[Ds_Message_Clear_ENG]
,[Ds_Message_Alert_PTB]
,[Ds_Message_Clear_PTB]
,[Ds_Email_Information_1_ENG]
,[Ds_Email_Information_2_ENG]
,[Ds_Email_Information_1_PTB]
,[Ds_Email_Information_2_PTB]
FROM [dbo].dtx_tb_Alert_Parameter 
where Nm_Alert like '%MaxSize Growth%'
GO




CREATE PROCEDURE [dbo].[dtx_sp_Alert_MaxSize_Growth_PagerDuty] 
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
	WHERE Nm_Alert = 'MaxSize Growth PagerDuty'


	IF @Fl_Enable = 0
		RETURN
		
	-- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".
	SELECT @Fl_Type = [Fl_Type]
	FROM [dbo].[dtx_tb_Alert]
	WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )		


	IF (OBJECT_ID('tempdb..##Alert_MDFs_Sizes') IS NOT NULL)
		DROP TABLE ##Alert_MDFs_Sizes
			
	CREATE TABLE ##Alert_MDFs_Sizes (
		[Server]			VARCHAR(500),
		[Nm_Database]		VARCHAR(500),
		[Logical_Name]		VARCHAR(500),
		[Type]		VARCHAR(500),
		[Max_Size]			NUMERIC(15,2),
		[Size]				NUMERIC(15,2),
		[Total_Used]	NUMERIC(15,2),
		[Free_Space (MB)] NUMERIC(15,2),
		[Percent_Free] NUMERIC(15,2)
	)

	EXEC sp_MSforeachdb '
		Use [?]

			;WITH cte_datafiles AS 
			(
			  SELECT name, size = size/128.0,max_size,type_desc FROM sys.database_files
			),
			cte_datainfo AS
			(
			  SELECT	name,type_desc, max_size,CAST(size as numeric(15,2)) as size, 
						CAST( (CONVERT(INT,FILEPROPERTY(name,''SpaceUsed''))/128.0) as numeric(15,2)) as used, 
						free = CAST( (size - (CONVERT(INT,FILEPROPERTY(name,''SpaceUsed''))/128.0)) as numeric(15,2))
			  FROM cte_datafiles
			)

			INSERT INTO ##Alert_MDFs_Sizes
			SELECT	@@SERVERNAME, DB_NAME(), name as [Logical_Name],type_desc, (max_size * 8)/1024.00 max_size,size, used, free,
					percent_free = case when size <> 0 then cast((free * 100.0 / size) as numeric(15,2)) else 0 end
			FROM cte_datainfo	
			where max_size <> -1 AND max_size < 268435456
	'	

	--select Nm_Database, Logical_Name, [Type], Size,Total_Used,[Free_Space (MB)],Percent_Free, Max_Size
	--from ##Alert_MDFs_Sizes
	--WHERE  Size > Max_Size * (@Vl_Parameter/100.00)

			
	--	Do we have maxsize problem?
	IF EXISTS	(
				select Nm_Database, Logical_Name, [Type], Size,Total_Used,[Free_Space (MB)],Percent_Free, Max_Size
				from ##Alert_MDFs_Sizes
				WHERE  Size > Max_Size * (@Vl_Parameter/100.00)
				)
	BEGIN	-- BEGIN - ALERT


		IF ISNULL(@Fl_Type, 0) = 0	-- Control Alert/Clear
		BEGIN
			IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )
				DROP TABLE ##Email_HTML

			-- Databases with Log FULL
			
			select Nm_Database [Database], Logical_Name [Logical Name], [Type], Size,Total_Used [Total Used (MB)],[Free_Space (MB)] [Free Space (MB)],Percent_Free [Free Space (%)], Max_Size [Max Size (MB)]
			INTO ##Email_HTML
			from ##Alert_MDFs_Sizes
			WHERE  Size > Max_Size * (@Vl_Parameter/100.00)			
				
								
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
				@Ds_OrderBy = '[Total Used (MB)]',
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
			
			select Nm_Database [Database], Logical_Name [Logical Name], [Type], Size,Total_Used [Total Used (MB)],[Free_Space (MB)] [Free Space (MB)],Percent_Free [Free Space (%)], Max_Size [Max Size (MB)]
			INTO ##Email_HTML_CLEAR
			from ##Alert_MDFs_Sizes	
			
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
				@Ds_OrderBy = '[Total Used (MB)]',
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
where Nm_Alert like '%MaxSize Growth PagerDuty%'
GO


update dbo.dtx_tb_Alert_Parameter set
Vl_Parameter = 50,
Vl_Parameter_2 = 80,
Ds_Metric_2 = 'Percent'
where Id_Alert_Parameter = 50
go

