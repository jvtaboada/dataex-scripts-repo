/****** Script for SelectTopNRows command from SSMS  ******/




/*


********************************************************************************************************
********************ATENCAO SCRIPT PERSONALIZADO PARA O CLIENTE PATRUS**********************************
********************************************************************************************************

*/
SELECT TOP (1000) [Id_Alert_Parameter]
      ,[Nm_Alert]
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
      ,[Ds_Email_Information_2_PTB]
  FROM [DBADataEX].[dbo].[dtx_tb_Alert_Parameter]

  /*

  SELECT Ds_Profile_Email,Ds_Email,[Id_Alert_Parameter] FROM [dtx_tb_Alert_Parameter]



    SELECT Ds_Profile_Email,Ds_Email,[Id_Alert_Parameter] FROM [dtx_tb_Alert_Parameter]

  'DataEX'
  'suporte@dataex.com.br;davidson.bprime@patrus.com.br;tulio@patrus.com.br'

  --ATÉ O 43


  BEGIN TRAN
  UPDATE [dtx_tb_Alert_Parameter]
  SET Ds_Profile_Email = 'DataEX',Ds_Email =  'suporte@dataex.com.br;davidson.bprime@patrus.com.br;tulio@patrus.com.br'
  WHERE [Id_Alert_Parameter] BETWEEN 1 AND 43

SELECT Ds_Profile_Email,Ds_Email,[Id_Alert_Parameter] FROM [dtx_tb_Alert_Parameter]

COMMIT



  -------------
  BEGIN TRAN
  UPDATE [dtx_tb_Alert_Parameter]
  SET Ds_Profile_Email = 'DataEX'
  ,Ds_Email =  'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com'
  WHERE [Id_Alert_Parameter] BETWEEN 44 AND 48


    BEGIN TRAN
  UPDATE [dtx_tb_Alert_Parameter]
  SET Ds_Profile_Email = 'DataEX'
  ,Ds_Email =  'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com;davidson.bprime@patrus.com.br;tulio@patrus.com.br'
  WHERE [Id_Alert_Parameter] = 49



  DO 44 AO 49
  DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com	44
DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com	45
DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com	46
DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com	47
DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com	48
DataEX	cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com;davidson.bprime@patrus.com.br;tulio@patrus.com.br	49

*/



SELECT TOP (1000) [Id_Alert_Parameter]
      ,[Nm_Alert]
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
      ,[Ds_Email_Information_2_PTB]
  FROM [DBADataEX].[dbo].[dtx_tb_Alert_Parameter]
  WHERE [Id_Alert_Parameter] > 48




--SELECT @@TRANCOUNT


ROLLBACK


  BEGIN TRAN
  INSERT INTO [DBADataEX].[dbo].[dtx_tb_Alert_Parameter]
  ( [Nm_Alert]
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
  
 SELECT
 'Log Full 90'
, 'dtx_sp_Alert_Log_Full_90'
, 1	
, 1	
, 1	
, 90	
, 'Percent'
, NULL	
, NULL	
, 'DataEX'
, 'suporte@dataex.com.br;davidson.bprime@patrus.com.br;tulio@patrus.com.br'
 , 'ALERT: There is a Log File with more than ###1% used on Server:	'
 , 'CLEAR: There is not a Log File with more than ###1 % used on Server:  	'
 , 'ALERTA: Existe um Arquivo de Log com mais de ###1% de utilização no Servidor:  	'
 , 'CLEAR: Não existe mais um Arquivo de Log com mais de ###1 % de utilização no Servidor: 	'
 , 'Transaction Log Informations 	'
 , 'TOP 50 - Process Executing on Database 	'
 , 'Informações dos Arquivos de Log	'
 , 'TOP 50 - Processos executando no Banco de Dados'

 /*
 'MaxSize Growth PagerDuty'
 ,'dtx_sp_Alert_MaxSize_Growth_PagerDuty'
 ,1	
 ,1
 ,1	
 ,80	
 ,'Percent'	
 ,90	
 ,'Percent'	
 ,'DataEX'	
 ,'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com;davidson.bprime@patrus.com.br;tulio@patrus.com.br'
 ,'ALERT: There is a file with more than ###1% of the Maxsize used on Server: 	'
 ,'CLEAR: There is not a file with more than ###1% of the Maxsize used on Server: 	'
 ,'ALERTA: Existe um arquivo com mais de ###1% de utilização do Maxsize no servidor: 	'
 ,'CLEAR: Não existe um arquivo com mais de ###1% de utilização do Maxsize no servidor: 	'
 ,'SQL Server File(s) 	'
 ,'TOP 50 - Process Executing on Database	'
 ,'Arquivo(s) do SQL Server	'
 ,'TOP 50 - Processos executando no Banco de Dados'
 */

 COMMIT


   /*
   
   SELECT
  'Log Full PagerDuty	'
 , 'dtx_sp_Alert_Log_Full_PagerDuty	'
 , 1	
 , 1	
 , 1	
 , 50	
 , 'Percent	'
 , 80
 , 'Percent	'
 , 'DataEX'
 , 'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com;davidson.bprime@patrus.com.br;tulio@patrus.com.br'
 , 'ALERT: There is a Log File with more than ###1% used on Server:	'
 , 'CLEAR: There is not a Log File with more than ###1 % used on Server:  	'
 , 'ALERTA: Existe um Arquivo de Log com mais de ###1% de utilização no Servidor:  	'
 , 'CLEAR: Não existe mais um Arquivo de Log com mais de ###1 % de utilização no Servidor: 	'
 , 'Transaction Log Informations 	'
 , 'TOP 50 - Process Executing on Database 	'
 , 'Informações dos Arquivos de Log	'
 , 'TOP 50 - Processos executando no Banco de Dados'

 */


 /*
 dtx_sp_Alert_Every_Minute
	
	Exec [dbo].dtx_sp_Alert_Log_Full_PagerDuty;

	Exec [dbo].dtx_sp_Alert_MaxSize_Growth_PagerDuty;

	Exec [dbo].dtx_sp_Alert_Log_Full_PagerDuty_90;

	Exec [dbo].dtx_sp_Alert_Log_Full_90;
 */