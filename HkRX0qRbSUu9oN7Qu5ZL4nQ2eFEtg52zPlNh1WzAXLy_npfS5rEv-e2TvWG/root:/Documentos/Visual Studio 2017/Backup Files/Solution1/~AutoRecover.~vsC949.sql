SELECT TOP (10) [id]
      ,[subject]
      ,[body]
      ,[sender]
      ,[email_date]
      ,[instance]
      ,[email_date1]
      ,[email_date2]
  FROM [dbo].[dtx_tb_alerts_emails]


 BEGIN TRAN 

 UPDATE [dbo].[dtx_tb_alerts_emails]
 SET sender = 'EMAILERRADO@fudeu.com.br'
 --WHERE id = 1;

 COMMIT;
 ROLLBACK;

