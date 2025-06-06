USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_CPU_Utilization_PagerDuty]    Script Date: 5/5/2022 11:31:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Procedures
ALTER    PROCEDURE [dbo].[dtx_sp_Alert_CPU_Utilization_PagerDuty]  
AS  
BEGIN  
 SET NOCOUNT ON  



			 --média cpu nos ultimos 3 minutos
			DECLARE @ts_now bigint = (SELECT cpu_ticks/(cpu_ticks/ms_ticks) 
										FROM sys.dm_os_sys_info WITH (NOLOCK)
									);
			IF(	select avg(CPU_Utilization) as CPU_Utilization from
			(
				SELECT TOP(3) (100-SystemIdle) AS [CPU_Utilization]
			FROM (SELECT record.value('(./Record/@id)[1]', 'int') AS record_id,
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')
			AS [SystemIdle],
			record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int')
			AS [SQLProcessUtilization], [timestamp]
			FROM (SELECT [timestamp], CONVERT(xml, record) AS [record]
			FROM sys.dm_os_ring_buffers WITH (NOLOCK)
			WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
			AND record LIKE N'%<SystemHealth>%') AS x) AS y
			ORDER BY record_id DESC
			) as subTable ) > 90
			BEGIN



  
			 DECLARE @Id_Alert_Parameter SMALLINT, @Fl_Enable BIT, @Fl_Type TINYINT, @Vl_Parameter SMALLINT,@Ds_Email VARCHAR(500),@Ds_Profile_Email VARCHAR(200),@Dt_Now DATETIME,@Vl_Parameter_2 INT,  
			  @Ds_Email_Information_1_ENG VARCHAR(200), @Ds_Email_Information_2_ENG VARCHAR(200), @Ds_Email_Information_1_PTB VARCHAR(200), @Ds_Email_Information_2_PTB VARCHAR(200),  
			  @Ds_Message_Alert_ENG varchar(1000),@Ds_Message_Clear_ENG varchar(1000),@Ds_Message_Alert_PTB varchar(1000),@Ds_Message_Clear_PTB varchar(1000), @Ds_Subject VARCHAR(500)  
   
			 DECLARE @Company_Link  VARCHAR(4000),@Line_Space VARCHAR(4000),@Header_Default VARCHAR(4000),@Header VARCHAR(4000),@Fl_Language BIT,@Final_HTML VARCHAR(MAX),@HTML VARCHAR(MAX)    
  
			 declare @Ds_Alinhamento VARCHAR(10),@Ds_OrderBy VARCHAR(MAX)   
  
   
			 --IF  OBJECT_ID('tempdb..##WhoIsActive_Result') IS NULL  
			 -- return  
       
			 -- Alert information  
			 SELECT @Id_Alert_Parameter = Id_Alert_Parameter,   
			  @Fl_Enable = Fl_Enable,   
			  @Vl_Parameter = Vl_Parameter,  -- Minutes,  
			  @Ds_Email = Ds_Email,  
			  @Fl_Language = Fl_Language,  
			  @Ds_Profile_Email = Ds_Profile_Email,  
			  @Vl_Parameter_2 = Vl_Parameter_2,  --minute  
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
			 WHERE Nm_Alert = 'CPU Utilization PagerDuty'  
   
     
			 IF @Fl_Enable = 0  
			  RETURN  
  
			 -- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".  
			 SELECT @Fl_Type = [Fl_Type]  
			 FROM [dbo].[dtx_tb_Alert]  
			 WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )    
  
			 --------------------------------------------------------------------------------------------------------------------------------  
			 -- CPU Utilization  
			 --------------------------------------------------------------------------------------------------------------------------------   
			 IF ( OBJECT_ID('tempdb..#CPU_Utilization') IS NOT NULL )  
			  DROP TABLE #CPU_Utilization  
   
			 SELECT TOP(2)  
			  record_id,  
			  [SQLProcessUtilization],  
			  100 - SystemIdle - SQLProcessUtilization as OtherProcessUtilization,  
			  [SystemIdle],  
			  100 - SystemIdle AS CPU_Utilization  
			 INTO #CPU_Utilization  
			 FROM (   
				SELECT record.value('(./Record/@id)[1]', 'int')             AS [record_id],   
				  record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')   AS [SystemIdle],  
				  record.value('(./Record/SchedulerMonitorEvent/SystemHealth/ProcessUtilization)[1]', 'int') AS [SQLProcessUtilization],   
				  [timestamp]   
				FROM (   
				  SELECT [timestamp], CONVERT(XML, [record]) AS [record]   
				  FROM [sys].[dm_os_ring_buffers]   
				  WHERE [ring_buffer_type] = N'RING_BUFFER_SCHEDULER_MONITOR'   
					AND [record] LIKE '%<SystemHealth>%'  
				 ) AS X          
			   ) AS Y  
			 ORDER BY record_id DESC  
  
   
			 -- Do we have CPU problem?   
			 IF (  
			   select CPU_Utilization from #CPU_Utilization  
			   where record_id = (select max(record_id) from #CPU_Utilization)  
			  ) > @Vl_Parameter  
			 BEGIN   
			  IF (  
			   select CPU_Utilization from #CPU_Utilization  
			   where record_id = (select min(record_id) from #CPU_Utilization)  
			  ) > @Vl_Parameter  
			  BEGIN  
			   IF ISNULL(@Fl_Type, 0) = 0 -- Control Alert/Clear  
			   BEGIN  
				IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
				 DROP TABLE ##Email_HTML  
        
				-- CPU Information  
				select TOP 1  
				  CAST([SQLProcessUtilization] AS VARCHAR) [SQL Process (%)],  
				  CAST((100 - SystemIdle - SQLProcessUtilization) AS VARCHAR) as [Other Process (%)],  
				  CAST([SystemIdle] AS VARCHAR) AS [System Idle (%)],  
				  CAST(100 - SystemIdle AS VARCHAR) AS [CPU Utilization (%)]  
				INTO ##Email_HTML  
				from #CPU_Utilization  
				order by record_id DESC         
     
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
				@Ds_Tabela = '##Email_HTML',   
				@Ds_Alinhamento  = 'center',  
				--@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',  
				@Ds_Saida = @HTML OUT   
  
			   -- First Result  
			   SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space     
      
			   EXEC dbo.dtx_sp_Export_Table_HTML_Output  
				@Ds_Tabela = '##Email_HTML_2', -- varchar(max)  
				@Ds_Alinhamento  = 'center',  
				@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',  
				@Ds_Saida = @HTML OUT    -- varchar(max)     
  
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
			 END  -- END - ALERT  
			 END  
			 ELSE   
			 BEGIN -- BEGIN - CLEAR      
			  IF @Fl_Type = 1  
			  BEGIN     
     
			   IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )  
				 DROP TABLE ##Email_HTML_CLEAR  
        
				-- CPU Information  
				select TOP 1  
				  CAST([SQLProcessUtilization] AS VARCHAR) [SQL Process (%)],  
				  CAST((100 - SystemIdle - SQLProcessUtilization) AS VARCHAR) as [Other Process (%)],  
				  CAST([SystemIdle] AS VARCHAR) AS [System Idle (%)],  
				  CAST(100 - SystemIdle AS VARCHAR) AS [CPU Utilization (%)]  
				INTO ##Email_HTML_CLEAR  
				from #CPU_Utilization  
				order by record_id DESC         
     
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
				@Ds_Saida = @HTML OUT    -- varchar(max)  
  
			   -- First Result  
			   SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space     
      
			   EXEC dbo.dtx_sp_Export_Table_HTML_Output  
				@Ds_Tabela = '##Email_HTML_CLEAR_2', -- varchar(max)  
				@Ds_Alinhamento  = 'center',  
				@Ds_OrderBy = '[dd hh:mm:ss.mss] desc',  
				@Ds_Saida = @HTML OUT    -- varchar(max)     
  
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
			 END  -- END - CLEAR   
END
ELSE
RETURN
END  
