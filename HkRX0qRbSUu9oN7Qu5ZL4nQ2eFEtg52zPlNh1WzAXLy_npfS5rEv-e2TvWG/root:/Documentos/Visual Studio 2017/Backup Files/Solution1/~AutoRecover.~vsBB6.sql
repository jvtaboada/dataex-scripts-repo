select  * 
from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= '2025-02-02 06:30:00.757'
and databasename = 'siscoob'
order by StartTime

exec sp_Rel_Cadastro_de_Faturas_Analitico @in_empCodigo=0,@in_hotCodigo=0,@in_da=1,@in_normal=1,@in_DTCadastroIni='2025-02-01 00:00:00',@in_DTCadastroFinal='2025-02-03 00:00:00'