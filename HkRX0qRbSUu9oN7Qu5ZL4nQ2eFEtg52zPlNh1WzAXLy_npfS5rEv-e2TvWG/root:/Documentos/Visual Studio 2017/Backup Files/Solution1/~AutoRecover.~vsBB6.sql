select  * 
from [DBADataEX].[dbo].[dtx_tb_Queries_Profile] 
with (nolock) 
where StartTime >= '2025-02-02 23:30:00.757'
and databasename = 'siscoob'
and textdata like 'exec sp_API_VFB_Reservas_Notificar_U%'
order by starttime 

exec sp_Rel_Cadastro_de_Faturas_Analitico @in_empCodigo=0,@in_hotCodigo=0,@in_da=1,@in_normal=1,@in_DTCadastroIni='2025-02-01 00:00:00',@in_DTCadastroFinal='2025-02-03 00:00:00'

exec sp_API_VFB_Reservas_Notificar_U @in_vfbIdentifier=N'TCR001',@in_notificar_vfb=0,@in_notificar_coob=1,@in_status=8,@in_erro_msg=N' <!doctype html> <html lang="en"> <head>   <title>Not Found</title> </head> <body>   <h1>Not Found</h1><p>The requested resource was not found on this server.</p> </body> </html> '	NULL	CBRTAPLDBPRD01	Core .Net SqlClient Data Provider	user_siscoob	170	3.10	2025-02-03 16:14:35.743	2025-02-03 16:14:38.843	CBRTAPLDBPRD01\COOBRASTUR	541949	27630	1079	siscoob	32
exec sp_API_VFB_Reservas_Notificar_U @in_vfbIdentifier=N'TCR001',@in_notificar_vfb=0,@in_notificar_coob=1,@in_status=8,@in_erro_msg=N' <!doctype html> <html lang="en"> <head>   <title>Not Found</title> </head> <body>   <h1>Not Found</h1><p>The requested resource was not found on this server.</p> </body> </html> '