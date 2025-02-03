select  * 
from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= GETDATE()-8 --and EndTime <= '2025-01-28 23:59:59.000' 
and databasename = 'siscoob'
order by StartTime

select GETDATE()-8