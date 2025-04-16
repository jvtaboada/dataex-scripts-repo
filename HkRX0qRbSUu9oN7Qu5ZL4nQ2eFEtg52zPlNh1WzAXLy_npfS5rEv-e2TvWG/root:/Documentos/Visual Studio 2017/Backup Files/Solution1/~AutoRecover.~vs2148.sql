SELECT 

	DB_NAME(SER.database_id)					 as [Database]
	,SER.session_id								 as [Session ID]
	,blocking_session_id						 as [ID Processo bloqueador]
	,SER.status									 as [Estado Atual]
	,SER.command								 as [Comando Executado]
	,SQLTEXT.TEXT								 as [Texto Query]
	,percent_complete							 as [% de conclus�o]
	,SER.cpu_time								 as [Tempo CPU]
	--,(SER.total_elapsed_time/1000)				 as [Tempo Total em execu��o /segundos]
	,((SER.total_elapsed_time/1000)/60)			 as [Tempo execu��o /minutos]
FROM
	sys.dm_exec_requests						 AS [SER]
	CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS [SQLTEXT]
WHERE
	--CONDI��O: session_id > 50 (valores abaixo de 50 s�o processos de sistema)
	SER.session_id > 50
	order by [Tempo CPU] desc