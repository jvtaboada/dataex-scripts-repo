use siscoob
sp_helptext sp_API_VFB_Reservas_Notificar_U


-- =============================================  
-- Author:  Ricardo Brusch  
-- Create date: 07/08/2024  
-- Description: Atualizar reservas já notificadas  
-- =============================================  
CREATE PROCEDURE [dbo].[sp_API_VFB_Reservas_Notificar_U]  
 @in_vfbIdentifier VARCHAR(6),  
 @in_notificar_vfb  INT = 0,  
 @in_notificar_coob INT = 0,  
 @in_status         INT = 0,  
 @in_erro_msg       NVARCHAR(MAX) = NULL  
AS  
BEGIN  
 SET LANGUAGE BRAZILIAN  
  
 DECLARE @localizador VARCHAR(20)  
 DECLARE @sitCodigo INT  
 DECLARE @mensagem_log NVARCHAR(200)  
  
 SELECT @localizador = localizador, @sitCodigo = sitCodigo FROM tblHoteis_Reservas_Online_Controle_VFB  WHERE vfbIdentifier = @in_vfbIdentifier  
 SET @mensagem_log = '[NOTIFICACAO] sitCodigo anterior: '+CAST(@sitCodigo AS VARCHAR)+'; sitCodigo atualizado: '+CAST(@in_status AS VARCHAR)  
  
 EXEC sp_API_VFB_Logs_C @localizador, @mensagem_log  
  
 IF @in_notificar_vfb > 0  
  UPDATE tblHoteis_Reservas_Online_Controle_VFB SET vfbNotificacao = 1 WHERE vfbIdentifier = @in_vfbIdentifier  
  
 IF @in_notificar_coob > 0  
  UPDATE tblHoteis_Reservas_Online_Controle_VFB SET sitCodigo = @in_status WHERE vfbIdentifier = @in_vfbIdentifier  
  
 IF @in_erro_msg IS NOT NULL  
 BEGIN  
  DECLARE @texto_log NVARCHAR(MAX)  
  
  EXEC sp_API_VFB_Logs_C @localizador, @in_erro_msg  
  
  SET @texto_log =  '[' + CONVERT(nvarchar, GETDATE(), 120) + '] ' + @in_erro_msg + ' ;;'  
  UPDATE tblHoteis_Reservas_Online_Controle_VFB SET logs = @texto_log + ISNULL(logs, '')  WHERE vfbIdentifier = @in_vfbIdentifier  
 END   
  
 --UPDATE tblHoteis_Reservas_Online_Controle_VFB SET sitCodigo = @sitCodigo, vfbNotificacao = @in_notificar_vfb, logs = @in_erro_msg WHERE vfbIdentifier = @in_vfbIdentifier  
   
 SELECT 1 AS sucesso, 0 AS erro, 'Registro atualizado com sucesso' AS mensagem  
   
 RETURN  
  
END;

exec sp_API_VFB_Reservas_Notificar_U @in_vfbIdentifier=N'TCR001',@in_notificar_vfb=0,@in_notificar_coob=1,@in_status=8,@in_erro_msg=N' <!doctype html> <html lang="en"> <head>   <title>Not Found</title> </head> <body>   <h1>Not Found</h1><p>The requested resource was not found on this server.</p> </body> </html>'