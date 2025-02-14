sp_whoisactive

use DBADataEX
go
declare @dia_ant as char(8)
select @dia_ant = convert(varchar, getdate()-1, 112)	
select B.name,
A.err_timestamp,
a.err_severity,
a.err_number,
a.username,
a.database_id,
replace(replace(a.err_message, char(13),''), char(10), '') as err_message,
replace(replace(a.sql_text, char(13),''), char(10), '') as sql_text,
a.client_hostname,
Dt_Error
from dbo.[dtx_tb_Log_DB_Error] A (nolock)
join sys.databases B (nolock) on A.database_id = B.database_id
where err_timestamp >= @dia_ant --and err_timestamp < '20210922'
order by err_timestamp