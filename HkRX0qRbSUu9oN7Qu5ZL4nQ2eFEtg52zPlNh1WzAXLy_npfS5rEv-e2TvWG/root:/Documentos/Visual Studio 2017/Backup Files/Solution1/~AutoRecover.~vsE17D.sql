SELECT TOP (10) [id]
      ,[subject]
      ,[body]
      ,[sender]
      ,[email_date]
  FROM [dbo].[dtx_tb_checklists_emails]
  WHERE subject like '%SQLPRODUCAO-03%'
  order by  email_date DESC
  


Tempo de Disponibilidade do SQL Server




Availability Time66 Dia(s) 09 Hour(s) 43 Minuto(s)




Espaço em Disco




Drive NameTotal Size (GB)Space Used (GB)Free Space (GB)Space Used
(%)C:1261081886.000D:4095824327121.000F:8187768450394.000G:4095378331293.000L:2047464158323.000




TOP 5 - Informações dos Arquivos de Dados (MDF e NDF)




DatabaseLogical NameTotal Reserved (MB)Total Used (MB)Free Space (MB)Free Space
(%)Max SizeGrowthDBRododtrodoData3201520.062499435.50702084.5621.93-11024.00
MBDBRodoDBRodo_PTT20221085307.00433737.75651569.2560.04-11024.00
MBDBRodoDBRodo_PTT2023853775.50447029.81406745.6947.64-11024.00
MBDBRodoDBRodo_PTT2024790528.00672220.38118307.6314.97-11024.00
MBDBRodoDBRodo_PTT2021492000.00439778.1952221.8110.61-11024.00 MB




TOP 5 - Informações dos Arquivos de Log (LDF)




DatabaseLogical NameTotal Reserved (MB)Total Used (MB)Free Space (MB)Free Space
(%)Max SizeGrowthDBRodolgrodoLog353995.1320833.35333161.7794.111650000100000.00
MBtempdbtemplog50000.0013.5449986.4699.97-11024.00
MBBServerBSuperServer_log22398.8893.9222304.9599.58-11024.00
MBDBADataEXDBADataEX_log4227.4442.684184.7698.9920971521024.00
MBCHANGECHANGE_log3336.0044.883291.1298.6520971521024.00 MB




TOP 10 - Crescimento das Bases




ServerDatabaseActual Size (MB)Growth 1 Day (MB)Growth 15 Days (MB)Growth 30 Days
(MB)Growth 60 Days
(MB)SQLPRODUCAO-03DBRodo5623763.1011846.6214584.0170873.08129677.35SQLPRODUCAO-03CHANGE25093.87134.22-351.101255.674036.97SQLPRODUCAO-03BServer1225.3243.63655.44-20800.90-20942.34SQLPRODUCAO-03Auditoria554.202.1227.68-2066.50-1883.25SQLPRODUCAO-03msdb0.000.000.000.000.00SQLPRODUCAO-03DBADataEX1902.76-12.57-7.02-199.37-86.42TOTAL
ALL5652539.2512014.0214909.0149061.98110802.31




TOP 10 - Crescimento das Tabelas




ServerDatabaseTableActual Size (MB)Growth 1 Day (MB)Growth 15 Days (MB)Growth 30
Days (MB)Growth 60 Days
(MB)SQLPRODUCAO-03DBRodoGLTQ_DIGITALIZACOES3022.982060.541868.313022.98-5171.61SQLPRODUCAO-03DBRodoZ_PROCESSOS4869.821866.901447.162211.12298.39SQLPRODUCAO-03DBRodoGLID_IMPDOCCLIITENS85942.341045.4410484.4314342.5424507.89SQLPRODUCAO-03DBRodoGLGL_DOCUMENTOS485073.09827.964297.2810829.0816016.13SQLPRODUCAO-03DBRodoGLID_IMPLOTES120956.99506.36-821.86-2179.27-18231.46SQLPRODUCAO-03DBRodoGLID_IMPDOCCLIS198579.22452.343097.84-5576.66-11425.58SQLPRODUCAO-03DBRodoGLID_TANQUEIMPNFE31851.81449.973809.687865.095722.75SQLPRODUCAO-03DBRodoGLOP_OCORRENCIAS416683.59366.084382.698753.0315698.41SQLPRODUCAO-03DBRodoGLGV_PROCESSOITENS170455.67273.322363.214695.798398.40SQLPRODUCAO-03DBRodoGLCE_ARQUIVOENVIOSNDD450.37257.82163.97438.84-1870.32TOTAL
ALL-5652539.2512014.0214909.0149061.98110802.31




TOP 10 - Utilização Arquivos Databases - Writes (09:00 - 18:00)




DatabaseFile IDIO Stall Write (ms)Num of WritesAVG Write Stall
(ms)DBRodo591210815177400465.1DBRodo176707343159784764.8DBRodo226106365151979591.7tempdb1120210616946750.7tempdb4120295816818960.7tempdb3117633216818100.7tempdb5116106416778150.7tempdb7117475116747440.7tempdb6116402616747110.7tempdb8116821816737950.7




TOP 10 - Utilização Arquivos Databases - Reads (09:00 - 18:00)




DatabaseFile IDIO Stall Read (ms)Num od ReadsAVG Read Stall
(ms)DBRodo59606607858951.2DBRodo1602064060719861.0DBRodo38985219305641.0DBRodo4140187315440570.9tempdb66323096976960.9tempdb86158286971470.9tempdb16227876970190.9tempdb76244716967150.9tempdb46097656964970.9tempdb56227036964520.9




TOP 10 - Crescimento Arquivos Databases




DatabaseFile NameDurationStart TimeEnd TimeGrowth Size (MB)Application NameHost
NameLogin NameWithout Information about Auto Growth--------




TOP 10 - Databases Sem Backup nas últimas 16 Horas




Databasemastermodelmsdb




TOP 10 - Backup FULL e Diferencial das Bases




DatabaseBackup Start DateDuration (min)Recovery ModelTypeSize
(MB)DBRodo2025-04-15 23:01:3014FULLDiferencial245801.37DBRodo2025-04-15
23:01:3014FULLDiferencial245801.37CHANGE2025-04-15
23:00:431FULLDiferencial2246.09DBADataEX2025-04-15
23:01:080SIMPLEDiferencial1260.35BServer2025-04-15
23:00:240FULLDiferencial754.39Auditoria2025-04-15
23:00:070SIMPLEDiferencial116.33




TOP 5 - Queries em Execução a mais de 2 horas




dd hh:mm:ss.mssDatabaseLogin NameHost NameStart TimeStatusSession IDBlocking
Session IDWait InfoOpen Tran CountCPUReadsWritesQuery00 14:20:10.423masterNT
AUTHORITY\SYSTEMSQLPRODUCAO-032025-04-15
16:34:55suspended63-(101ms)SP_SERVER_DIAGNOSTICS_SLEEP0000EXEC
sp_server_diagnostics 600 14:15:56.343DBRodobenner10.101.0.272025-04-15
16:39:10sleeping2239--117211,48745SELECT NEXT VALUE FOR SEQ_GL




TOP 10 - Jobs em Execução




Job NameStart DateDurationStep NameWithout Information about a Job executing for
more than 10 minutes---




TOP 10 - Jobs Alterados




Job NameEnabledCreation DateChange DateVersionWithout information about changed
hobs----




TOP 10 - Jobs que Falharam




Job NameStatusExecution DateDurationSQL MessageAgendamento - Reporting - Gestao
de VolumeFailed20250416 03:50:0000:00:00The job failed. The Job was invoked by
Schedule 126 (Diário). The last step to run was step 1 (Verifica se é o
primário).Agendamento - Reporting - Gestao de VolumeFailed20250416
03:50:0000:00:00Executed as user: PATRUS\sqlservice. É o Servidor primário.
[SQLSTATE 42000] (Error 50000). The step failed.DBA - Monitor
IntegratorFailed20250416 02:35:0000:00:03The job failed. The Job was invoked by
Schedule 257 (Recorrente). The last step to run was step 1 (Monitor Log).DBA -
Monitor IntegratorFailed20250416 02:35:0000:00:03Executed as user:
PATRUS\sqlservice. Transaction (Process ID 1160) was deadlocked on lock
resources with another process and has been chosen as the deadlock victim. Rerun
the transaction. [SQLSTATE 40001] (Error 1205). The step failed.DBA - Manutenção
Tabelas ZFailed20250416 00:36:1700:06:41Executed as user: PATRUS\sqlservice.
...aint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "DBRodo", table
"dbo.K_Z_AGENDAMENTOERROS", column 'AGENDAMENTO'. [SQLSTATE 23000] (Error 547)
The statement has been terminated. [SQLSTATE 01000] (Error 3621) The DELETE
statement conflicted with the REFERENCE constraint "FK_21352_131516". The
conflict occurred in database "DBRodo", table "dbo.K_Z_AGENDAMENTOERROS", column
'AGENDAMENTO'. [SQLSTATE 23000] (Error 547) The statement has been terminated.
[SQLSTATE 01000] (Error 3621) The DELETE statement conflicted with the REFERENCE
constraint "FK_21352_131516". The conflict occurred in database "... The stepDBA
- Manutenção Tabelas ZFailed20250416 00:10:0000:41:36The job failed. The Job was
invoked by Schedule 229 (Diário). The last step to run was step 9 (Limpa
Z_Emails).DBA - Plano de Manutenção - Índices-Estatísticas -
22HCancelled20250415 22:53:5706:51:03Executed as user: PATRUS\sqlservice. The
step was cancelled (stopped) as the result of a stop job request. DBA - Plano de
Manutenção - Índices-Estatísticas - 22HCancelled20250415 22:00:0007:45:01The job
was stopped prior to completion by User PATRUS\sqlservice. The Job was invoked
by Schedule 233 (DIÁRIO AS 22H). The last step to run was step 6 (Reorganise +
Estatísticas).DBA - Monitor de SessãoFailed20250415 14:15:0000:00:02The job
failed. The Job was invoked by Schedule 249 (15 Mins). The last step to run was
step 1 (Executar).DBA - Monitor de SessãoFailed20250415 14:15:0000:00:02Executed
as user: PATRUS\sqlservice. DBCC execution completed. If DBCC printed error
messages, contact your system administrator. [SQLSTATE 01000] (Message 2528)
Warning: The join order has been enforced because a local join hint is used.
[SQLSTATE 01000] (Message 8625) There is already an object named
'##OUTPUT_WHOISACTIVE' in the database. [SQLSTATE 42S01] (Error 2714). The step
failed.




TOP 10 - Jobs Demorados




Job NameStatusExecution DateDurationSQL MessageDBA - CargasSucceeded20250415
21:00:0000:08:15The job succeeded. The Job was invoked by Schedule 227
(Recorrente 1 Hora). The last step to run was step 1 (Cargas).DBA -
CargasSucceeded20250415 22:00:0000:07:27The job succeeded. The Job was invoked
by Schedule 227 (Recorrente 1 Hora). The last step to run was step 1
(Cargas).DBA - Backup LogSucceeded20250416 06:45:0000:04:36The job succeeded.
The Job was invoked by Schedule 225 (15 Minutos). The last step to run was step
2 (BKP).BL - Ajustes no RadarSucceeded20250416 01:30:0000:04:07The job
succeeded. The Job was invoked by Schedule 193 (15 minutos). The last step to
run was step 1 (Data Manual).DBA - Backup LogSucceeded20250416
06:30:0000:03:54The job succeeded. The Job was invoked by Schedule 225 (15
Minutos). The last step to run was step 2 (BKP).DataEX - Alert DB - Every
DaySucceeded20250416 06:50:0000:02:42The job succeeded. The Job was invoked by
Schedule 197 (DataEX - Alert DB - Every Day). The last step to run was step 1
(DataEX - Alert DB).DBA - Backup LogSucceeded20250416 01:30:0000:02:17The job
succeeded. The Job was invoked by Schedule 225 (15 Minutos). The last step to
run was step 2 (BKP).DBA - Backup LogSucceeded20250415 22:15:0000:01:19The job
succeeded. The Job was invoked by Schedule 225 (15 Minutos). The last step to
run was step 2 (BKP).Agendamento - Verificação de Desagio CAPSucceeded20250415
19:45:0000:01:14The job succeeded. The Job was invoked by Schedule 128 (5
Minutos). The last step to run was step 1 (Executar).Agendamento - Verificação
de Desagio CAPSucceeded20250415 19:50:0000:01:06The job succeeded. The Job was
invoked by Schedule 128 (5 Minutos). The last step to run was step 1 (Executar).




TOP 10 - Queries Demoradas Dia Anterior (07:00 - 23:00)




Prefixo QueryQuantityTotal (s)AVG (s)MIN (s)MAX (s)WritesCPU
(m)ReadsOrdemWithout Information About Slow Queries--------1




TOP 10 - Queries Demoradas - Últimos 10 Dias (07:00 - 23:00)




DateQTDWithout Information About Slow Queries-




Média Contadores Dia Anterior (07:00 - 23:00)




HourBatch RequestsCPUPLESQL CompilationsUser ConnectionNum Slow QueriesReads
Slow QueriesPage
Splits/sec77713311022522272634--138288064468920534529025223814--138446015659919544311025864381--13861627578101091949397932354606--1387870534311955544263026314487--1389411293412674141375917433460--1390867293913685139602520393318--1392677788814849044365325384470--13945353175151018547376929544920--1396514675516796345351122454127--1397977172117860145330524343649--1399427296218891532387224362937--1401081079019897029560523642498--1402487675020668525576718642348--1403621787321516423518412702189--1404521620522456122348911791913--14051804803




TOP 10 - Conexões Abertas por Usuários




OrderLogin NameSession
Count1benner22601sa5391PATRUS\nddservice211PATRUS\sqlservice81PATRUS\ivory.davidson41NT
AUTHORITY\SYSTEM11NT SERVICE\SQLTELEMETRY12TOTAL2834




TOP 10 - Fragmentação dos Índices




DateDatabaseTableIndexFragmentation (%)Page CountFill FactorCompression-Without
Information about Index with more than 10% of Fragmentarion--0.00---




TOP 10 - Waits Stats Dia Anterior (07:00 - 23:00)




Wait TypeLast Log DateDif Wait (s)Dif Resource (s)Dif Signal (s)Dif Wait
CountPercentageCXPACKET2025-04-15
22:37:072219845.772194551.3925294.384677350233.97CXCONSUMER2025-04-15
22:37:072173322.612130642.5542680.064835833029.26HTDELETE2025-04-15
22:37:07400136.42397294.032842.3933487616.57HTREPARTITION2025-04-15
22:37:07286259.38282876.423382.9741804765.24BPSORT2025-04-15
22:37:07119911.12116827.333083.7842436011.70HTBUILD2025-04-15
22:37:07104946.23102101.222845.0134505021.97ASYNC_NETWORK_IO2025-04-15
22:37:0788507.3387152.021355.3192927061.33LCK_M_U2025-04-15
22:37:0757072.8957021.6051.28853401.44PREEMPTIVE_HADR_LEASE_MECHANISM2025-04-15
22:37:070.000.000.0003.78PREEMPTIVE_SP_SERVER_DIAGNOSTICS2025-04-15
22:37:070.000.000.0003.78




Alertas Sem CLEAR




AlertMessageDateOpen TimeDisk SpaceALERTA: Existe um disco com mais de 90% de
utilização no Servidor: SQLPRODUCAO-032024-09-17 10:55:3510 Dia(s) 20:00:57Large
LDF FileALERTA: Existe um Arquivo de Log com 50 % do tamanho do arquivo de Dados
no Servidor: SQLPRODUCAO-032023-10-08 20:05:3155 Dia(s) 10:51:01




TOP 50 - Alertas Últimas 24 horas




AlertMessageDateOpen TimeBlocked ProcessCLEAR: Não existe mais um processo
Bloqueado a mais de 2 minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 22:34:3200
Dia(s) 00:14:00Blocked Long ProcessCLEAR: Não existe mais um processo Bloqueado
a mais de 20 minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 22:34:3200 Dia(s)
00:14:00Blocked Long ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais
de 20 minuto(s) e um total de 2 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
22:20:32-Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 1 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
22:04:32-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 20:07:3200 Dia(s)
00:00:59Blocked ProcessALERTA: Existe(m) 2 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 3 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
20:06:33-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 19:01:3300 Dia(s)
00:01:00Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 8 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
19:00:33-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 18:54:3200 Dia(s)
00:01:00Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 2 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
18:53:32-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 17:24:3300 Dia(s)
00:00:59Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 1 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
17:23:34-SQL Server ConnectionCLEAR: Não existem mais 5000 Conexões Abertas no
SQL Server no Servidor: SQLPRODUCAO-032025-04-15 16:58:3300 Dia(s)
00:58:00Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 16:01:3300 Dia(s)
00:01:00Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 7 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
16:00:33-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 15:51:3300 Dia(s)
00:01:00Blocked ProcessALERTA: Existe(m) 2 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 3 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
15:50:33-Blocked ProcessCLEAR: Não existe mais um processo Bloqueado a mais de 2
minuto(s) no Servidor: SQLPRODUCAO-032025-04-15 15:35:3200 Dia(s)
00:01:00Blocked ProcessALERTA: Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2
minuto(s) e um total de 2 Lock(s) no Servidor: SQLPRODUCAO-032025-04-15
15:34:32-SQL Server ConnectionALERTA: Existem mais de 5000 Conexões Abertas no
SQL Server no Servidor: SQLPRODUCAO-032025-04-15 14:58:34-Blocked ProcessCLEAR:
Não existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 14:50:3300 Dia(s) 00:47:01Blocked Long ProcessCLEAR:
Não existe mais um processo Bloqueado a mais de 20 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 14:50:3300 Dia(s) 00:47:01Blocked Long ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 20 minuto(s) e um total de 6
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 14:03:32-Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 2
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 13:45:32-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 12:12:3300 Dia(s) 00:13:59Blocked Long ProcessCLEAR:
Não existe mais um processo Bloqueado a mais de 20 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 12:12:3300 Dia(s) 00:13:59SQL Server ConnectionCLEAR:
Não existem mais 5000 Conexões Abertas no SQL Server no Servidor:
SQLPRODUCAO-032025-04-15 11:58:3500 Dia(s) 00:00:01Blocked Long ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 20 minuto(s) e um total de 2
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 11:58:34-Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 2
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 11:40:32-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 10:28:3300 Dia(s) 00:01:00Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 8
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 10:27:33-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 10:20:3300 Dia(s) 00:12:00Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 3
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 10:08:33-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 10:06:3500 Dia(s) 00:01:59Blocked Long ProcessCLEAR:
Não existe mais um processo Bloqueado a mais de 20 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 10:06:3500 Dia(s) 00:01:59Blocked Long ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 20 minuto(s) e um total de 2
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 10:04:36-SQL Server
ConnectionALERTA: Existem mais de 5000 Conexões Abertas no SQL Server no
Servidor: SQLPRODUCAO-032025-04-15 09:58:33-Blocked ProcessALERTA: Existe(m) 1
Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 1 Lock(s) no
Servidor: SQLPRODUCAO-032025-04-15 09:46:33-Blocked ProcessCLEAR: Não existe
mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 09:40:3400 Dia(s) 00:06:02Blocked ProcessALERTA:
Existe(m) 12 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 37
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 09:34:32-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 09:24:3300 Dia(s) 00:02:00Blocked ProcessALERTA:
Existe(m) 4 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 6
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 09:22:33-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 09:09:3200 Dia(s) 00:01:59Blocked ProcessALERTA:
Existe(m) 5 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 8
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 09:07:33-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 09:06:3300 Dia(s) 00:01:01Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 9
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 09:05:32-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 08:36:3200 Dia(s) 00:01:00Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 10
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 08:35:32-Blocked ProcessCLEAR: Não
existe mais um processo Bloqueado a mais de 2 minuto(s) no Servidor:
SQLPRODUCAO-032025-04-15 07:21:3200 Dia(s) 00:01:00Blocked ProcessALERTA:
Existe(m) 1 Processo(s) Bloqueado(s) a mais de 2 minuto(s) e um total de 1
Lock(s) no Servidor: SQLPRODUCAO-032025-04-15 07:20:32-




TOP 10 - Login Failed - SQL Server




OrderTextNumber of ErrorWithout Information about Login Failed-




TOP 100 - Error Log do SQL Server




DateProcess InfoText2025-04-16 05:55:53spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092165).2025-04-16
05:55:53spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092163).2025-04-16 05:55:53spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092170).2025-04-16
05:55:53spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092166).2025-04-16 05:55:53spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092168).2025-04-16
05:55:53spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092171).2025-04-16 05:55:53spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092167).2025-04-16
05:53:51spid1639sChange Tracking autocleanup is blocked on side table of
"GLOP_CONTRATOFRETES". If the failure persists, check if the table
"GLOP_CONTRATOFRETES" is blocked by any process .2025-04-16
05:48:27ServerProcess 0:0:0 (0xb6d0) Worker 0x00000581F604E160 appears to be
non-yielding on Scheduler 80. Thread creation time: 13389239957606. Approx
Thread CPU Used: kernel 87484 ms, user 0 ms. Process Utilization 24%. System
Idle 78%. Interval: 87475 ms.2025-04-16 05:32:23spid288s[INFO] Database ID: [5].
Deleting unrecoverable checkpoint table row (id: 1092158).2025-04-16
05:32:23spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092153).2025-04-16 05:32:23spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092159).2025-04-16
05:32:23spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092157).2025-04-16 05:32:23spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092155).2025-04-16
05:32:23spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092156).2025-04-16 05:32:23spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092161).2025-04-16
05:32:23spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092154).2025-04-16 05:32:23spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092160).2025-04-16
05:32:23spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092152).2025-04-16 05:23:09spid1639sChange Tracking autocleanup is
blocked on side table of "GLOP_VIAGENS". If the failure persists, check if the
table "GLOP_VIAGENS" is blocked by any process .2025-04-16
05:22:13spid1639sChange Tracking autocleanup is blocked on side table of
"GLGL_DOCUMENTOTRIBUTOS". If the failure persists, check if the table
"GLGL_DOCUMENTOTRIBUTOS" is blocked by any process .2025-04-16
05:21:42spid1639sChange Tracking autocleanup is blocked on side table of
"FN_MOVIMENTACOES". If the failure persists, check if the table
"FN_MOVIMENTACOES" is blocked by any process .2025-04-16 05:21:11spid1639sChange
Tracking autocleanup is blocked on side table of "FN_LANCAMENTOCC". If the
failure persists, check if the table "FN_LANCAMENTOCC" is blocked by any process
.2025-04-16 05:20:38spid1639sChange Tracking autocleanup is blocked on side
table of "GLOP_VIAGENS". If the failure persists, check if the table
"GLOP_VIAGENS" is blocked by any process .2025-04-16 05:20:06spid1639sChange
Tracking autocleanup is blocked on side table of "GLOP_VIAGEMMANIFESTOS". If the
failure persists, check if the table "GLOP_VIAGEMMANIFESTOS" is blocked by any
process .2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092142).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092147).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092144).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092149).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092145).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092140).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092151).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092143).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092141).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092139).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092138).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092146).2025-04-16 05:19:47spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092150).2025-04-16
05:19:47spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092148).2025-04-16 05:19:35spid1639sChange Tracking autocleanup is
blocked on side table of "GLGL_DOCUMENTOTRIBUTOS". If the failure persists,
check if the table "GLGL_DOCUMENTOTRIBUTOS" is blocked by any process
.2025-04-16 05:18:16spid1639sChange Tracking autocleanup is blocked on side
table of "FN_MOVIMENTACOES". If the failure persists, check if the table
"FN_MOVIMENTACOES" is blocked by any process .2025-04-16 05:02:48spid288s[INFO]
Database ID: [5]. Deleting unrecoverable checkpoint table row (id:
1092128).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092127).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092125).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092132).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092135).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092133).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092136).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092131).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092137).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092129).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092130).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092126).2025-04-16
05:02:48spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092134).2025-04-16 05:02:48spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092124).2025-04-16
04:47:12spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092120).2025-04-16 04:47:12spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092118).2025-04-16
04:47:12spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092116).2025-04-16 04:47:12spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092123).2025-04-16
04:47:12spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092117).2025-04-16 04:47:12spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092121).2025-04-16
04:47:12spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092115).2025-04-16 04:47:12spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092119).2025-04-16
04:47:12spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092122).2025-04-16 04:47:12spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092114).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092108).2025-04-16 04:32:02spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092113).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092109).2025-04-16 04:32:02spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092110).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092106).2025-04-16 04:32:02spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092104).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092103).2025-04-16 04:32:02spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092111).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092107).2025-04-16 04:32:02spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092112).2025-04-16
04:32:02spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092105).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092099).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092097).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092100).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092093).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092089).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092087).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092091).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092096).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092101).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092085).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092094).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092088).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092086).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092098).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092092).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092090).2025-04-16 04:18:32spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092102).2025-04-16
04:18:32spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092095).2025-04-16 04:02:57spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092083).2025-04-16
04:02:57spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092081).2025-04-16 04:02:57spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092080).2025-04-16
04:02:57spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092084).2025-04-16 04:02:57spid288s[INFO] Database ID: [5]. Deleting
unrecoverable checkpoint table row (id: 1092082).2025-04-16
04:02:57spid288s[INFO] Database ID: [5]. Deleting unrecoverable checkpoint table
row (id: 1092079).





[https://www.dataex.com.br/wp-content/uploads/2019/07/Logo-Laranja-e-Cinza.png]
[https://www.dataex.com.br]
