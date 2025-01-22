USE [DBADataEX]
GO

-- Status Database

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
 'Database Status PagerDuty'
,'dtx_sp_Alert_Database_Status_PagerDuty'
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
where Nm_Alert like '%Database Status%'
GO


-- Procedure PagerDuty

CREATE PROCEDURE [dbo].[dtx_sp_Alert_Database_Status_PagerDuty]   
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
 WHERE Nm_Alert = 'Database Status PagerDuty'  
   
    
 IF @Fl_Enable = 0  
  RETURN  
    
 -- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".  
 SELECT @Fl_Type = [Fl_Type]  
 FROM [dbo].[dtx_tb_Alert]  
 WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )    
   
  
 IF(OBJECT_ID('tempdb..#Temp_Database_Status') IS NOT NULL)   
  DROP TABLE #Temp_Database_Status  
  
 SELECT [name], [state_desc]  
 INTO #Temp_Database_Status  
 FROM [sys].[databases]  
 WHERE [state_desc] NOT IN ('ONLINE','RESTORING')  
  
  
 -- Do we have log Full?  
 IF EXISTS (  
    SELECT TOP 1 [name]  
    FROM #Temp_Database_Status  
    )  
 BEGIN -- BEGIN - ALERT  
  
  
  IF ISNULL(@Fl_Type, 0) = 0 -- Control Alert/Clear  
  BEGIN  
   IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
    DROP TABLE ##Email_HTML  
  
        
   SELECT [name] [Database Name], [state_desc] [Status]  
   INTO ##Email_HTML  
   FROM #Temp_Database_Status        
        
   CREATE CLUSTERED INDEX SK01_##Email_HTML ON ##Email_HTML([Database Name])  
     
   EXEC dbo.dtx_sp_Export_Table_HTML_Output  
    @Ds_Tabela = '##Email_HTML', -- varchar(max)  
    @Ds_Alinhamento  = 'center',  
    @Ds_Saida = @HTML OUT    -- varchar(max)     
        
   -- Get HTML Informations  
   SELECT @Company_Link = Company_Link,  
    @Line_Space = Line_Space,  
    @Header_Default = Header  
   FROM dtx_tb_HTML_Parameter  
     
   IF @Fl_Language = 1 --Portuguese  
   BEGIN  
     SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_PTB)  
     SET @Ds_Subject =  @Ds_Message_Alert_PTB + @@SERVERNAME   
   END  
           ELSE   
     BEGIN  
    SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_ENG)  
    SET @Ds_Subject =  @Ds_Message_Alert_ENG + @@SERVERNAME   
     END        
       
   -- First Result  
   SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space + @Company_Link        
  
   EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'          
    
     
   -- Fl_Type = 1 : ALERT   
   INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )  
   SELECT @Id_Alert_Parameter, @Ds_Subject, 1     
  END  
 END  -- END - ALERT  
 ELSE   
 BEGIN -- BEGIN - CLEAR      
  IF @Fl_Type = 1  
  BEGIN    
  
   IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )  
    DROP TABLE ##Email_HTML_CLEAR       
      
   SELECT [name] [Database Name], [state_desc] [Status]  
   INTO ##Email_HTML_CLEAR  
   FROM [sys].[databases]  
           
   CREATE CLUSTERED INDEX SK01_##Email_HTML_CLEAR ON ##Email_HTML_CLEAR([Database Name])  
       
   -- Get HTML Informations  
   SELECT @Company_Link = Company_Link,  
    @Line_Space = Line_Space,  
    @Header_Default = Header  
   FROM dtx_tb_HTML_Parameter     
  
   IF @Fl_Language = 1 --Portuguese  
   BEGIN  
     SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_PTB)  
      SET @Ds_Subject =  @Ds_Message_Clear_PTB + @@SERVERNAME   
   END  
           ELSE   
     BEGIN  
    SET @Header = REPLACE(@Header_Default,'HEADERTEXT',@Ds_Email_Information_1_ENG)  
    SET @Ds_Subject =  @Ds_Message_Clear_ENG + @@SERVERNAME   
     END         
  
     
   EXEC dbo.dtx_sp_Export_Table_HTML_Output  
    @Ds_Tabela = '##Email_HTML_CLEAR', -- varchar(max)  
    @Ds_Alinhamento  = 'center',  
    @Ds_Saida = @HTML OUT    -- varchar(max)  
  
   -- First Result  
   SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space + @Company_Link               
  
   EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'          
    
       
   -- Fl_Type = 0 : CLEAR  
   INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )  
   SELECT @Id_Alert_Parameter, @Ds_Subject, 0    
  END    
 END  -- END - CLEAR  
  
END  
GO


-- procedure Alert_Every_Minute
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

	EXEC dbo.dtx_sp_Alert_Database_Status_PagerDuty

	EXEC dbo.dtx_sp_Alert_IO_Pending 

	EXEC dbo.dtx_sp_Alert_Large_LDF_File

	EXEC dbo.dtx_sp_Alert_Log_Full

	EXEC dbo.dtx_sp_Alert_Memory_Available

	EXEC [dbo].dtx_sp_Alert_Memory_Available_PagerDuty

	EXEC dbo.dtx_sp_Alert_Page_Corruption

	EXEC dbo.dtx_sp_Alert_SQLServer_Restarted

	Exec [dbo].dtx_sp_Alert_SQLServer_Restarted_PagerDuty
	

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
