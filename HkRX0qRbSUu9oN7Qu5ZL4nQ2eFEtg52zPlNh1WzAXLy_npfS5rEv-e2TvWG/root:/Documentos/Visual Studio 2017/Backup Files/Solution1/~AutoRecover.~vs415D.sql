sp_whoisactive

sp_WhoIsActive @Output_Column_List = '[dd hh:mm:ss.mss][session_id][database_name][host_name][blocking_session_id][login_name][status][sql_text]'

dbcc inputbuffer(549)

sp_who2 549

SELECT T0.[Component] , T0.[ID] , T0.[Counter]  FROM [dbo].[CHEN] T0 WITH (NOLOCK) ORDER BY T0.[Component],T0.[ID]