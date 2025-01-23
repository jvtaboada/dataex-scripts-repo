use msdb
go

/*
ALERTAS CRIADOS PARA MONITORAR O ALWAYS ON EM CLINTES.

0-VALIDAR SE EXISTE OPERATORS


USE [msdb]
GO

/****** Object:  Operator [DTX_PagerDuty]    Script Date: 11/05/2022 15:50:40 ******/
EXEC msdb.dbo.sp_add_operator @name=N'DTX_PagerDuty', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com', 
		@category_name=N'[Uncategorized]'
GO





USE [msdb]
if not exists (
select NULL
from msdb.dbo.sysoperators
where name = 'DTX_DBA_Operator')
begin 
    EXEC [msdb].[dbo].[sp_add_operator]
            @name = N'DTX_DBA_Operator',
            @enabled = 1,
            @pager_days = 0,
            @email_address = N'suporte@dataex.com.br'   -- Emails: ‘suporte@dataex.com; EMail2@provedor.com'    (Email 2 pode ser dos Clientes)
end


USE [msdb]
    
if not exists (
select NULL
from msdb.dbo.sysoperators
where name = 'DTX_DBA_Team_Operator')
begin 
    EXEC [msdb].[dbo].[sp_add_operator]
            @name = 'DTX_DBA_Team_Operator',
            @enabled = 1,
            @pager_days = 0,
            @email_address = N'suporte@dataex.com.br'   -- ‘EMail1@provedor.com;EMail2@provedor.com'    
end
go



1-CRIAR NA BASE DO CLIENTE
2-CRIAR OS ALERTAS PARA OS OPERATORS
3-VALIDAR SE EXISTE PROFILE SETADO NO AGENT DE CADA INSTANCIA

*/

EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Cluster is not up or that a security permissions issue was encountered',
@message_id=19411,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Cluster is not up or that a security permissions issue was encountered',
@job_id=N'00000000-0000-0000-0000-000000000000';



EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Attempt to switch Always On Availability Groups to the local Windows Server Failover Clustering
',
@message_id=19413
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Attempt to switch Always On Availability Groups to the local Windows Server Failover Clustering
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Specifying the name of a remote WSFC cluster
',
@message_id=19418
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Specifying the name of a remote WSFC cluster
',
@job_id=N'00000000-0000-0000-0000-000000000000';








EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Windows Server Failover Cluster within the lease timeout period
',
@message_id=19419
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Windows Server Failover Cluster within the lease timeout period
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - SQL Server hosting availability group Failover Cluster within the lease timeout period
',
@message_id=19421
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'SQL Server hosting availability group Failover Cluster within the lease timeout period
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Failed to remove the resource dependency in which resource
',
@message_id=19467
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Failed to remove the resource dependency in which resource
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Seeding of availability database failed with a transient error
',
@message_id=19494
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Seeding of availability database failed with a transient error
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Automatic seeding of availability database in availability group failed
',
@message_id=19495
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Automatic seeding of availability database in availability group failed
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Automatic seeding of availability database
',
@message_id=19496
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Automatic seeding of availability database
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Cannot initiate a target seeding operation
',
@message_id=19505
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Cannot initiate a target seeding operation
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Connection timeout has occurred while attempting to establish a connection
',
@message_id=35201
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Connection timeout has occurred while attempting to establish a connection
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Connection timeout has occurred on a previously established
',
@message_id=35206
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Connection timeout has occurred on a previously established
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Specifying a valid session-timeout value.
',
@message_id=35214
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Specifying a valid session-timeout value.
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Health check timeout value for availability group
',
@message_id=35229
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Health check timeout value for availability group
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - The session timeout value was exceeded while waiting
',
@message_id=35256
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'The session timeout value was exceeded while waiting
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Synchronization of a secondary database, was interrupted
',
@message_id=35268
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Synchronization of a secondary database, was interrupted
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Recovery for availability databases is pending
',
@message_id=35274
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Recovery for availability databases is pending
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Replication background task hit a lock timeout
',
@message_id=40093
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Replication background task hit a lock timeout
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Seeding operation cannot be initiated
',
@message_id=40694
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Seeding operation cannot be initiated
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Error occurred while waiting for the local availability replica of availability group
',
@message_id=41164
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Error occurred while waiting for the local availability replica of availability group
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn -  Availability replica is currently being accessed by another operation
',
@message_id=41165
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Availability replica is currently being accessed by another operation
',
@job_id=N'00000000-0000-0000-0000-000000000000';




EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Changing roles
',
@message_id=1480
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Changing roles
',
@job_id=N'00000000-0000-0000-0000-000000000000';





EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Has been suspended
',
@message_id=35264
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Has been suspended
',
@job_id=N'00000000-0000-0000-0000-000000000000';










EXEC msdb.dbo.sp_add_alert
@name=N'DataEx- AlwaysOn - Has been resumed
',
@message_id=35265
,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=1,
@category_name=N'[Uncategorized]',
@notification_message = 'Has been resumed
',
@job_id=N'00000000-0000-0000-0000-000000000000';


/*

criacao dos alertas 


*/

USE [msdb]
GO
EXEC msdb.dbo.sp_update_operator @name=N'DTX_PagerDuty', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'cloud-and-data-managed-services-realtime-alerts-dataex.8c4gkzed@dataex.pagerduty.com', 
		@pager_address=N''
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Attempt to switch Always On Availability Groups to the local Windows Server Failover Clustering
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Changing roles
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Cluster is not up or that a security permissions issue was encountered', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Connection timeout has occurred on a previously established
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Connection timeout has occurred while attempting to establish a connection
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Error occurred while waiting for the local availability replica of availability group
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Has been resumed
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Has been suspended
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Health check timeout value for availability group
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Recovery for availability databases is pending
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Seeding of availability database failed with a transient error
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Specifying a valid session-timeout value.
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - SQL Server hosting availability group Failover Cluster within the lease timeout period
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Synchronization of a secondary database, was interrupted
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Windows Server Failover Cluster within the lease timeout period
', @operator_name=N'DTX_PagerDuty', @notification_method = 1
GO



USE [msdb]
GO

EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn -  Availability replica is currently being accessed by another operation
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Attempt to switch Always On Availability Groups to the local Windows Server Failover Clustering
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Automatic seeding of availability database in availability group failed
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Automatic seeding of availability database
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Cannot initiate a target seeding operation
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Changing roles
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Cluster is not up or that a security permissions issue was encountered', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Connection timeout has occurred on a previously established
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Connection timeout has occurred while attempting to establish a connection
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Error occurred while waiting for the local availability replica of availability group
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Failed to remove the resource dependency in which resource
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Has been resumed
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Has been suspended
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Health check timeout value for availability group
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Recovery for availability databases is pending
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Replication background task hit a lock timeout
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Seeding of availability database failed with a transient error
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Seeding operation cannot be initiated
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Specifying a valid session-timeout value.
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Specifying the name of a remote WSFC cluster
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - SQL Server hosting availability group Failover Cluster within the lease timeout period
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Synchronization of a secondary database, was interrupted
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - The session timeout value was exceeded while waiting
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO
EXEC msdb.dbo.sp_add_notification @alert_name=N'DataEx- AlwaysOn - Windows Server Failover Cluster within the lease timeout period
', @operator_name=N'DTX_DBA_Operator', @notification_method = 1
GO


