select TOP 5 * 
from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= '2025-02-12 01:30:00' and EndTime <= '2023-07-12 07:30:00' order by StartTime
