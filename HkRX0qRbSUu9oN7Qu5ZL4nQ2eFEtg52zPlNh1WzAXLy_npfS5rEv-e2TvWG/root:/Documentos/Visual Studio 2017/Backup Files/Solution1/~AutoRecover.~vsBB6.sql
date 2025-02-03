select  * 
from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= GETDATE()-8 and EndTime <= GETDATE()-6
and databasename = 'siscoob'
order by duration desc