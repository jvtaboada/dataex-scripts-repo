--INSERTS DOS PARÂMETROS PARA RODAR PROCS DE REPLICATEDS

--ALERT LOGIN REPLICATED
INSERT INTO [dbo].[dtx_tb_Alert_Parameter]
           ([Nm_Alert]
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
VALUES
           ('Login replicated'
           ,'dtx_sp_Alert_Login_replicated'
           ,1
           ,0
           ,1
           ,24
           ,'Hours'
           ,NULL
           ,NULL
           ,'ProfileDataEX'
           ,'suporte@dataex.com.br'
           ,'ALERT: Login replicated on Server:'
           ,NULL
           ,'ALERTA: Login Para ser Replicado no Servidor:'
           ,NULL
           ,'Login replicated'
           ,NULL
           ,'Login(s)'
           ,NULL);
		   
--ALERT JOB REPLICATED
INSERT INTO [dbo].[dtx_tb_Alert_Parameter]
           ([Nm_Alert]
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
VALUES
           ('Job replicated'
           ,'dtx_sp_Alert_Job_replicated'
           ,1
           ,0
           ,1
           ,24
           ,'Hours'
           ,NULL
           ,NULL
           ,'ProfileDataEX'
           ,'suporte@dataex.com.br'
           ,'ALERT: Job replicated on Server:'
           ,NULL
           ,'ALERTA: Job Para ser Replicado no Servidor:'
           ,NULL
           ,'Job replicated'
           ,NULL
           ,'Job(s)'
           ,NULL);

--ALERT LINKED SERVER REPLICATED
INSERT INTO [dbo].[dtx_tb_Alert_Parameter]
           ([Nm_Alert]
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
VALUES
           ('LinkedServers replicated'
           ,'dtx_sp_Alert_LinkedServers_replicated'
           ,1
           ,0
           ,1
           ,24
           ,'Hours'
           ,NULL
           ,NULL
           ,'ProfileDataEX'
           ,'suporte@dataex.com.br'
           ,'ALERT: LinkedServers replicated on Server:'
           ,NULL
           ,'ALERTA: LinkedServers Para ser Replicado no Servidor:'
           ,NULL
           ,'LinkedServers replicated'
           ,NULL
           ,'Linked Servers'
           ,NULL);