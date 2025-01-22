 
 USE DBADataEX
 GO
 
Update dbo.dtx_tb_alert_parameter set
Nm_alert = 'CPU Utilization PagerDuty'
where id_alert_parameter = 44 -- CPU

update dbo.dtx_tb_alert_parameter set
Nm_alert = 'Disk Space PagerDuty'
where id_alert_parameter = 45 -- Disk space

update dbo.dtx_tb_alert_parameter set
Nm_alert = 'Memory Available PagerDuty'
where id_alert_parameter = 46 -- Memory Available

update dbo.dtx_tb_alert_parameter set
Nm_alert = 'SQL Server Restarted PagerDuty'
where id_alert_parameter = 47 -- SQL Server Restarted

update dbo.dtx_tb_Alert_Parameter set 
Vl_Parameter = 1
where Nm_Alert like 'SQL Server Restarted%'

Update dbo.dtx_tb_Alert_Parameter set
Nm_Procedure = 'dtx_sp_Alert_CPU_Utilization_PagerDuty'
where Id_Alert_Parameter in (44)


Update dbo.dtx_tb_Alert_Parameter set
Nm_Procedure = 'dtx_sp_Alert_Disk_Space_PagerDuty'
where Id_Alert_Parameter in (45)


Update dbo.dtx_tb_Alert_Parameter set
Nm_Procedure = 'dtx_sp_Alert_Memory_Available_PagerDuty'
where Id_Alert_Parameter in (46)


Update dbo.dtx_tb_Alert_Parameter set
Nm_Procedure = 'dtx_sp_Alert_SQLServer_Restarted_PagerDuty'
where Id_Alert_Parameter in (47)
go


-- Procedures

CREATE PROCEDURE [dbo].[dtx_sp_Alert_CPU_Utilization_PagerDuty]  
AS  
BEGIN  
 SET NOCOUNT ON  
  
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
go


CREATE PROCEDURE [dbo].[dtx_sp_Alert_Disk_Space_PagerDuty]  
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
 WHERE Nm_Alert = 'Disk Space PagerDuty'  
  
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
  [Drive]    VARCHAR (10),  
  [Size (MB)]  INT,  
  [Used (MB)]  INT,  
  [Free (MB)]  INT,  
  [Free (%)]   INT,  
  [Used (%)]   INT,  
  [Used SQL (MB)] INT,   
  [Date]   varchar(20)  
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
   [name]  SYSNAME,  
   [Path] VARCHAR(200),  
   [Size] VARCHAR(10),  
   [drive]  VARCHAR(30)  
  )  
    
  IF ( OBJECT_ID('tempdb..#space') IS NOT NULL )   
   DROP TABLE #space   
  
  CREATE TABLE #space (  
   [drive]  CHAR(1),  
   [mbfree] INT  
  )  
  EXEC sp_MSforeachdb 'Use [?] INSERT INTO #dbspace SELECT CONVERT(VARCHAR(25), DB_Name()) ''Database'', CONVERT(VARCHAR(60), FileName), CONVERT(VARCHAR(8), Size / 128) ''Size in MB'', CONVERT(VARCHAR(30), Name) FROM sysfiles'  
  
  DECLARE @hr INT, @fso INT, @mbtotal INT, @TotalSpace INT, @MBFree INT, @Percentage INT,  
    @SQLDriveSize INT, @size float, @drive VARCHAR(1), @fso_Method VARCHAR(255)  
  
  SELECT @mbtotal = 0,   
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
   VALUES( @drive + ':', @mbtotal, @mbtotal - @MBFree, @MBFree, (100 * ROUND(@MBFree, 2) / ROUND(@mbtotal, 2)),   
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
    -- file_system_type [File System Type],   
    -- logical_volume_name as [Logical Drive Name],   
     CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) AS [Total Size in GB], ---1GB = 1073741824 bytes  
     (CONVERT(DECIMAL(18,2),total_bytes/1073741824.0) - CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) ) AS [Used Size in GB],  
     CONVERT(DECIMAL(18,2),available_bytes/1073741824.0) AS [Available Size in GB],   
     CAST(CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) * 100 AS [Space Free %] ,  
     100-(CAST(CAST(available_bytes AS FLOAT)/ CAST(total_bytes AS FLOAT) AS DECIMAL(18,2)) * 100) AS [Space Used %]     
   FROM sys.master_files   
   CROSS APPLY sys.dm_os_volume_stats(database_id, file_id)  
  
  END  
      
 /*******************************************************************************************************************************  
 -- Do we have disk space problems?  
 *******************************************************************************************************************************/  
 IF (  
   @Ole_Automation = 1 AND EXISTS (SELECT NULL FROM #diskspace WHERE [Used (%)] > @Vl_Parameter)  
  OR  
   @Ole_Automation = 0 AND EXISTS (SELECT NULL FROM #Database_Driver_Letters WHERE [Space Used %]  > @Vl_Parameter)  
    )  
  
 BEGIN --   
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
  
     select *  
     INTO ##Email_HTML_Ole_Automation  
     from #diskspace       
  
  
     EXEC dbo.dtx_sp_Export_Table_HTML_Output  
      @Ds_Tabela = '##Email_HTML_Ole_Automation', -- varchar(max)  
      @Ds_Alinhamento  = 'center',  
      @Ds_OrderBy = '[Drive]',  
      @Ds_Saida = @HTML OUT    -- varchar(max)  
   END  
   ELSE  
   BEGIN  
       
       IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
      DROP TABLE ##Email_HTML  
  
     select *  
     INTO ##Email_HTML  
     from #Database_Driver_Letters      
  
     EXEC dbo.dtx_sp_Export_Table_HTML_Output  
      @Ds_Tabela = '##Email_HTML', -- varchar(max)  
      @Ds_Alinhamento  = 'center',  
      @Ds_OrderBy = '[Disk]',  
      @Ds_Saida = @HTML OUT    -- varchar(max)  
   END    
      
  
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
 END  -- FIM - ALERTA  
 ELSE   
 BEGIN -- INICIO - CLEAR      
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
  
     select *  
     INTO ##Email_HTML_CLEAR_Ole_Automation  
     from #diskspace  
       
  
     EXEC dbo.dtx_sp_Export_Table_HTML_Output  
      @Ds_Tabela = '##Email_HTML_CLEAR_Ole_Automation', -- varchar(max)  
      @Ds_Alinhamento  = 'center',  
      @Ds_OrderBy = '[Drive]',  
      @Ds_Saida = @HTML OUT    -- varchar(max)  
   END  
   ELSE  
   BEGIN  
       
       IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )  
      DROP TABLE ##Email_HTML_CLEAR  
  
     select *  
     INTO ##Email_HTML_CLEAR  
     from #Database_Driver_Letters  
      
  
     EXEC dbo.dtx_sp_Export_Table_HTML_Output  
      @Ds_Tabela = '##Email_HTML_CLEAR', -- varchar(max)        
      @Ds_Alinhamento  = 'center',  
      @Ds_OrderBy = '[Disk]',  
      @Ds_Saida = @HTML OUT    -- varchar(max)  
   END    
      
  
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
 END    
END  
 go



 CREATE PROCEDURE [dbo].dtx_sp_Alert_Memory_Available_PagerDuty
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
 WHERE Nm_Alert = 'Memory Available PagerDuty'  
  
 IF @Fl_Enable = 0  
  RETURN  
    
 -- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".  
 SELECT @Fl_Type = [Fl_Type]  
 FROM [dbo].[dtx_tb_Alert]  
 WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )    
   
   
 -- Do we have Memory problem?   
 IF EXISTS ( SELECT null    
    FROM    sys.dm_os_sys_memory m  
     WHERE   CAST((m.available_physical_memory_kb/1024) AS BIGINT) < @Vl_Parameter*1024 )    
 BEGIN   
  IF ISNULL(@Fl_Type, 0) = 0 -- Control Alert/Clear  
  BEGIN  
   IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
    DROP TABLE ##Email_HTML  
        
   SELECT CAST((m.total_physical_memory_kb/1024) AS BIGINT)  [Total Memory (MB)],  
    CAST((m.available_physical_memory_kb/1024) AS BIGINT) [Available Memory (MB)],  
    CAST(CAST((m.available_physical_memory_kb/1024) AS BIGINT)*100.00/CAST((m.total_physical_memory_kb/1024) AS BIGINT) AS NUMERIC(9,2))  [Available Memory (%)]  
   INTO ##Email_HTML  
   FROM    sys.dm_os_sys_memory m       
     
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
   @Ds_Saida = @HTML OUT    -- varchar(max)  
  
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
    
 END  -- END - ALERT  
 END  
 ELSE   
 BEGIN -- BEGIN - CLEAR      
  IF @Fl_Type = 1  
  BEGIN     
     
   IF ( OBJECT_ID('tempdb..##Email_HTML_CLEAR') IS NOT NULL )  
     DROP TABLE ##Email_HTML_CLEAR  
      
   SELECT CAST((m.total_physical_memory_kb/1024) AS BIGINT)  [Total Memory (MB)],  
   CAST((m.available_physical_memory_kb/1024) AS BIGINT) [Available Memory (MB)],  
   CAST(CAST((m.available_physical_memory_kb/1024) AS BIGINT)*100.00/CAST((m.total_physical_memory_kb/1024) AS BIGINT) AS NUMERIC(9,2))  [Available Memory (%)]  
   INTO ##Email_HTML_CLEAR  
   FROM    sys.dm_os_sys_memory m    
  
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
  GO


CREATE PROCEDURE [dbo].dtx_sp_Alert_SQLServer_Restarted_PagerDuty  
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
 WHERE Nm_Alert = 'SQL Server Restarted PagerDuty'  
  
 IF @Fl_Enable = 0  
  RETURN  
    
 -- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".  
 SELECT @Fl_Type = [Fl_Type]  
 FROM [dbo].[dtx_tb_Alert]  
 WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )    
   
  
 -- Last SQL Server Restart date  
 IF ( OBJECT_ID('tempdb..#Alerta_SQL_Reiniciado') IS NOT NULL )   
  DROP TABLE #Alerta_SQL_Reiniciado  
   
 SELECT [create_date]   
 INTO #Alerta_SQL_Reiniciado  
 FROM [sys].[databases] WITH(NOLOCK)  
 WHERE [database_id] = 2 --  Database "TempDb"  
   AND [create_date] >= DATEADD(MINUTE, -@Vl_Parameter, GETDATE())  
   
 -- Was SQL Server Restarted?  
 IF EXISTS( SELECT * FROM #Alerta_SQL_Reiniciado )  
 BEGIN -- BEGIN - ALERT  
   
  IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
   DROP TABLE ##Email_HTML  
  
   
  SELECT CONVERT(VARCHAR(20), [create_date], 120) AS [Restart Date]  
  INTO ##Email_HTML  
  FROM #Alerta_SQL_Reiniciado  
     
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
   @Ds_Saida = @HTML OUT    -- varchar(max)  
  
   
  -- First Result  
  SET @Final_HTML = @Header + @Line_Space + @HTML + @Line_Space + @Company_Link   
  
   EXEC dtx_sp_Send_Dbmail @Ds_Profile_Email,@Ds_Email,@Ds_Subject,@Final_HTML,'HTML','High'          
    
  -- Fl_Type = 1 : ALERT   
  INSERT INTO [dbo].[dtx_tb_Alert] ( [Id_Alert_Parameter], [Ds_Message], [Fl_Type] )  
  SELECT @Id_Alert_Parameter, @Ds_Subject, 1     
    
 END  -- END - ALERT  
   
END  
GO


USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_Every_Minute]    Script Date: 25/11/2020 18:04:45 ******/
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
GO