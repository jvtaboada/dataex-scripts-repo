select * from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= '2025-04-02 00:00:00' --and EndTime <= '2023-07-12 07:30:00' 
and databasename = 'siscoob'
order by Writes desc

