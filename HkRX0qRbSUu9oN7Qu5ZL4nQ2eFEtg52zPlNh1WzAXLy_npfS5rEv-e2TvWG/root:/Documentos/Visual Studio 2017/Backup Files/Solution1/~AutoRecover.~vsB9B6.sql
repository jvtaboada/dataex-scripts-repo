SELECT *
FROM [DBADataex].[dbo].[dtx_tb_Alert_Parameter]
WHERE Nm_Alert LIKE '%Restarted%'

INSERT INTO [DBADataex].[dbo].[dtx_tb_Alert_Parameter]
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
			('SQL Server Restarted PagerDuty',
			'dtx_sp_Alert_SQLServer_Restarted_PagerDuty',
			1', 
			0
			)