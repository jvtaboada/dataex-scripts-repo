USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Alert_Large_LDF_File]    Script Date: 17/05/2022 17:58:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[dtx_sp_Alert_Large_LDF_File]  
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
 WHERE Nm_Alert = 'Large LDF File'  
  
 IF @Fl_Enable = 0  
  RETURN  
    
 -- Look for the last time the alert was executed and find if it was a "0: CLEAR" OR "1: ALERT".  
 SELECT @Fl_Type = [Fl_Type]  
 FROM [dbo].[dtx_tb_Alert]  
 WHERE [Id_Alert] = (SELECT MAX(Id_Alert) FROM [dbo].[dtx_tb_Alert] WHERE [Id_Alert_Parameter] = @Id_Alert_Parameter )    
   
 SELECT CONVERT(VARCHAR(25), DB.name) AS [Database],  
  (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data Files],  
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data MB],  
  (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log Files],  
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log MB],  
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log')*100/  
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') [Diff Data Log (%)]  
  INTO #Database_Files  
  FROM sys.databases DB  
  WHERE      
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log')*100/  
  (SELECT SUM((cast(size as bigint) * 8)/1024)  FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') > @Vl_Parameter   
   AND (SELECT SUM((cast(size as bigint) * 8)/1024) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') > @Vl_Parameter_2 * 1024  
 ORDER BY [Diff Data Log (%)] DESC  
      
  
 IF EXISTS ( SELECT NULL  FROM    #Database_Files)    
 BEGIN   
  IF ISNULL(@Fl_Type, 0) = 0 -- Control Alert/Clear  
  BEGIN  
   IF ( OBJECT_ID('tempdb..##Email_HTML') IS NOT NULL )  
    DROP TABLE ##Email_HTML  
        
   SELECT *  
   INTO ##Email_HTML  
   FROM  #Database_Files  
         
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
   @Ds_OrderBy = '[Diff Data Log (%)] DESC',  
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
      
      SELECT CONVERT(VARCHAR(25), DB.name) AS [Database],  
     (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data Files],  
     (SELECT cast(SUM((cast(size as decimal(18,2))*8)/1024) as int) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') AS [Data MB],  
     (SELECT COUNT(1) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log Files],  
     (SELECT cast(SUM((cast(size as decimal(18,2))*8)/1024) as int) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log') AS [Log MB],  
     (SELECT cast(SUM((cast(size as decimal(18,2))*8)/1024) as int) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'log')*100/  
     (SELECT cast(SUM((cast(size as decimal(18,2))*8)/1024) as int) FROM sys.master_files WHERE DB_NAME(database_id) = DB.name AND type_desc = 'rows') [Diff Data Log (%)]  
     INTO ##Email_HTML_CLEAR  
     FROM sys.databases DB  
     ORDER BY [Diff Data Log (%)] desc  
   
  
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
    @Ds_OrderBy = '[Diff Data Log (%)] DESC',  
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