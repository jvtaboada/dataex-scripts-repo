use DBADataex
go

-- CPU

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
 [Nm_Alert]
,[Nm_Procedure]
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,99
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
WHERE Nm_Alert = 'CPU Utilization'

select * from dbo.dtx_tb_Alert_Parameter

-- Disk

use DBADataex
go


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
 [Nm_Alert]
,[Nm_Procedure]
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,98
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
WHERE Nm_Alert = 'Disk Space'

select * FROM [dbo].dtx_tb_Alert_Parameter 
WHERE Nm_Alert = 'Disk Space'

-- Menoria

use DBADataex
go


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
 [Nm_Alert]
,[Nm_Procedure]
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,1
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
WHERE Nm_Alert = 'Memory Available'


select * FROM [dbo].dtx_tb_Alert_Parameter 
WHERE Nm_Alert = 'Memory Available'


-- restart

use DBADataex
go


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
 [Nm_Alert]
,[Nm_Procedure]
,[Fl_Language]
,[Fl_Clear]
,[Fl_Enable]
,5
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
WHERE Nm_Alert = 'SQL Server Restarted'


select * FROM [dbo].dtx_tb_Alert_Parameter 
WHERE Nm_Alert = 'SQL Server Restarted'


-- CPU
update [dbo].dtx_tb_Alert_Parameter set
Vl_Parameter = 90
WHERE Id_Alert_Parameter = 6

-- disk

update [dbo].dtx_tb_Alert_Parameter set
Vl_Parameter = 90
WHERE Id_Alert_Parameter = 7

