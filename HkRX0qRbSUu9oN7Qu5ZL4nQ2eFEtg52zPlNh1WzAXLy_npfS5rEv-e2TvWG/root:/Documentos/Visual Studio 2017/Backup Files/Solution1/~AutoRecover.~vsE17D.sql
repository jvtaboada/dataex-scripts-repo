SELECT TOP (10) [id]
      ,[subject]
      ,[body]
      ,[sender]
      ,[email_date]
  FROM [dbo].[dtx_tb_checklists_emails]
  WHERE subject like '%COBRAGNFE%'
  order by  email_date DESC
  

  
Tempo de Disponibilidade do SQL Server




Availability Time14 Dia(s) 20 Hour(s) 01 Minuto(s)




Espaço em Disco




Drive NameTotal Size (GB)Space Used (GB)Free Space (GB)Space Used
(%)C:1999187512394.000E:32921211765.000




TOP 5 - Informações dos Arquivos de Dados (MDF e NDF)




DatabaseLogical NameTotal Reserved (MB)Total Used (MB)Free Space (MB)Free Space
(%)Max SizeGrowthDB_GNFEDB_GNFE_Nota_Fisc336592.00336406.56185.440.06-160.00
MBDB_GNFE_ITFCDB_GNFE_ITFC160417.06153379.567037.504.39-110.00
MBmsdbMSDBData147585.567735.44139850.1394.76-110.00
MBDB_GNFEDB_GNFE_Nota_Fisc2141465.00140417.501047.500.74-110.00
MBDB_GNFEDB_GNFE_Fila_Hist135481.00133499.561981.441.46-110.00 MB




TOP 5 - Informações dos Arquivos de Log (LDF)




DatabaseLogical NameTotal Reserved (MB)Total Used (MB)Free Space (MB)Free Space
(%)Max SizeGrowthDB_GNFEDB_GNFE_Log17475.56908.5916566.9794.8020971521024.00
MBReportServerReportServer_log10050.9428.0710022.8799.72209715216.00
MBDB_GNFE_ITFCDB_GNFE_ITFC_log4112.6970.334042.3698.29209715210.00
MBmsdbMSDBLog1434.5614.851419.7198.96209715210.00
MBtempdbtemplog570.50303.03267.4746.88-110.00 MB




TOP 10 - Crescimento das Bases




ServerDatabaseActual Size (MB)Growth 1 Day (MB)Growth 15 Days (MB)Growth 30 Days
(MB)Growth 60 Days
(MB)COBRAGNFEDB_GNFE764713.50334.051610.064117.4810716.62COBRAGNFEDB_GNFE_ITFC153355.2285.35885.061754.803196.12COBRAGNFEReportServer21356.9138.56410.13805.001485.03COBRAGNFEDBADataEX1309.840.06-11.342.763.52COBRAGNFEDB_GNFE_HIST16009.930.000.00-666.97-666.97COBRAGNFEReportServerTempDB9.050.00-0.110.170.16COBRAGNFEDB_DBA0.000.000.000.000.00TOTAL
ALL956754.45458.022893.806013.2414734.48




TOP 10 - Crescimento das Tabelas




ServerDatabaseTableActual Size (MB)Growth 1 Day (MB)Growth 15 Days (MB)Growth 30
Days (MB)Growth 60 Days
(MB)COBRAGNFEDB_GNFEtbl_201_nfe293383.38147.321669.501969.904811.23COBRAGNFEDB_GNFEtbl_204_nfe_prod119350.9068.25761.631511.662752.54COBRAGNFEDB_GNFE_ITFCtbl_itfc_204_nfe_prod87806.9855.43573.251137.072080.95COBRAGNFEDB_GNFEtbl_054_fila_trns_hist127821.6047.3714.69664.141757.24COBRAGNFEDB_GNFEtbl_219_nfe_trak89185.9641.56441.19910.971707.66COBRAGNFEReportServerExecutionLogStorage21349.8338.56410.13805.001485.03COBRAGNFEDB_GNFE_ITFCtbl_itfc_201_nfe37572.5322.94236.87469.53846.65COBRAGNFEDB_GNFEtbl_052_fila_trns_retr13432.144.50-274.72-190.33-55.02COBRAGNFEDB_GNFEtbl_202_nfe_evet6369.774.3246.1990.22163.73COBRAGNFEDB_GNFEtbl_064_fila_pdf_hist5193.903.44-94.14-58.260.31TOTAL
ALL-956754.45458.022893.806013.2414734.48




TOP 10 - Utilização Arquivos Databases - Writes (09:00 - 18:00)




DatabaseFile IDIO Stall Write (ms)Num of WritesAVG Write Stall
(ms)DB_GNFE66913101021276.8DB_GNFE10132144197456.7DB_GNFE5103991155956.7tempdb211037312783504.0ReportServerTempDB1239349680533.5DB_GNFE25886822587752.3DB_GNFE_ITFC2162798741152.2ReportServerTempDB23795211766852.1master275535428171.8msdb211370206445331.8




TOP 10 - Utilização Arquivos Databases - Reads (09:00 - 18:00)




DatabaseFile IDIO Stall Read (ms)Num od ReadsAVG Read Stall
(ms)DB_GNFE2300622836359.2DB_GNFE_ITFC1580021826.5DB_GNFE10230752810635521.7DB_GNFE65929992853020.8DB_GNFE84556502191420.8ReportServer136889184020.0DB_GNFE54040892041219.8DB_GNFE3304215319.8DB_GNFE1467924718.9ReportServerTempDB1360824714.5




TOP 10 - Crescimento Arquivos Databases




DatabaseFile NameDurationStart TimeEnd TimeGrowth Size (MB)Application NameHost
NameLogin NameWithout Information about Auto Growth--------




TOP 10 - Databases Sem Backup nas últimas 16 Horas




DatabaseNo problem with Backups on the last 16 Hours




TOP 10 - Backup FULL e Diferencial das Bases




DatabaseBackup Start DateDuration (min)Recovery ModelTypeSize
(MB)DB_GNFE2025-04-16 00:23:43262FULLFULL769923.45DB_GNFE_ITFC2025-04-16
04:45:4048SIMPLEFULL153387.16ReportServer2025-04-16
00:11:218FULLFULL21362.86DB_GNFE_HIST2025-04-16
00:19:584SIMPLEFULL16050.11msdb2025-04-16
00:02:029SIMPLEFULL7876.06DBADataEX2025-04-16
05:33:000FULLFULL1317.10ReportServerTempDB2025-04-16
00:19:560SIMPLEFULL13.15master2025-04-16 00:02:010SIMPLEFULL6.09DB_DBA2025-04-16
00:19:570SIMPLEFULL3.33model2025-04-16 00:02:020FULLFULL2.83




TOP 5 - Queries em Execução a mais de 2 horas




dd hh:mm:ss.mssDatabaseLogin NameHost NameStart TimeStatusSession IDBlocking
Session IDWait InfoOpen Tran CountCPUReadsWritesQuery-Without Queries running
for more than 2 hours------------




TOP 10 - Jobs em Execução




Job NameStart DateDurationStep NameWithout Information about a Job executing for
more than 10 minutes---




TOP 10 - Jobs Alterados




Job NameEnabledCreation DateChange DateVersionWithout information about changed
hobs----




TOP 10 - Jobs que Falharam




Job NameStatusExecution DateDurationSQL MessageWithout Information about failed
Jobs----




TOP 10 - Jobs Demorados




Job NameStatusExecution DateDurationSQL MessageGNFe - 316 - Tratamento de
Retorno Servico Transmissão - envManifestoSucceeded20250416 02:36:2100:08:08O
trabalho foi bem-sucedido. O trabalho foi invocado por Agenda 106 (Agenda
envManifesto). A última etapa a ser executada foi 4 (Status 11 3a Vez).GNFe -
316 - Tratamento de Retorno Servico Transmissão - envManifestoSucceeded20250416
02:11:5100:08:00O trabalho foi bem-sucedido. O trabalho foi invocado por Agenda
106 (Agenda envManifesto). A última etapa a ser executada foi 4 (Status 11 3a
Vez).GNFe - 302 - Tratamento de Retorno Servico Transmissão -
NFeCancelamentoSucceeded20250416 06:46:0000:08:00O trabalho foi bem-sucedido. O
trabalho foi invocado por Agenda 25 (Agenda NFeCancelamento). A última etapa a
ser executada foi 4 (Status 11 3a Vez).GNFe - 314 - Tratamento de Retorno
Servico Transmissão - NFeConsultaDest]Succeeded20250416 06:45:5000:08:00O
trabalho foi bem-sucedido. O trabalho foi invocado por Agenda 97 (Agenda
NFeConsultaDest). A última etapa a ser executada foi 4 (Status 11 3a Vez).GNFe -
315 - Tratamento de Retorno Servico Transmissão - nfeDownloadNFSucceeded20250416
06:45:5000:08:00O trabalho foi bem-sucedido. O trabalho foi invocado por Agenda
99 (Agenda nfeDownloadNF). A última etapa a ser executada foi 4 (Status 11 3a
Vez).GNFe - 304 - Tratamento de Retorno Servico Transmissão -
NfeConsultaSucceeded20250416 06:38:0000:08:00O trabalho foi bem-sucedido. O
trabalho foi invocado por Agenda 27 (Agenda NfeConsulta). A última etapa a ser
executada foi 4 (Status 11 3a Vez).GNFe - 303 - Tratamento de Retorno Servico
Transmissão - NFeInutilizacaoSucceeded20250416 06:23:1000:08:00O trabalho foi
bem-sucedido. O trabalho foi invocado por Agenda 26 (Agenda NFeInutilizacao). A
última etapa a ser executada foi 4 (Status 11 3a Vez).MDFe - 302 - Tratamento de
Retorno Serviço Transmissão - MDFeRecepcaoEventoSucceeded20250416
02:42:4200:02:05O trabalho foi bem-sucedido. O trabalho foi invocado por Agenda
158 (MDFeRecepcaoEvento). A última etapa a ser executada foi 1
(MDFeRecepcaoEvento).MDFe - 302 - Tratamento de Retorno Serviço Transmissão -
MDFeRecepcaoEventoSucceeded20250416 06:47:4000:02:01O trabalho foi bem-sucedido.
O trabalho foi invocado por Agenda 158 (MDFeRecepcaoEvento). A última etapa a
ser executada foi 1 (MDFeRecepcaoEvento).MDFe - 302 - Tratamento de Retorno
Serviço Transmissão - MDFeRecepcaoEventoSucceeded20250416 06:40:4000:02:00O
trabalho foi bem-sucedido. O trabalho foi invocado por Agenda 158
(MDFeRecepcaoEvento). A última etapa a ser executada foi 1 (MDFeRecepcaoEvento).




TOP 10 - Queries Demoradas Dia Anterior (07:00 - 23:00)




Prefixo QueryQuantityTotal (s)AVG (s)MIN (s)MAX (s)WritesCPU
(m)ReadsOrdem--Transfere novos lotes para fila de transmissão exec dbo.s051x1_0
@cd_estd_emit_nfe = 0 ,@cd_cnpj_emit_nfe = 0 ,@cd_user_manu = 'Job-021'
144042562.8129.5629.0030.254053119534209897691--Gera Arquivo de Retorno ERP de
Notas Fiscais Recebidas dos Fornecedores exec s201i5_9 @funcao = '1' ,@cd_ambi =
1 ,@cd_user = 'Job-031' 141341871.4429.6326.3348.1614757409196813244681221exec
dtx_sp_Load_SQL_Counter 8374199.175.025.015.42191366755671--Importa Arquivos de
Notas exec dbo.sitfc201m0_0 @cd_user_cadm = 'Job-010'
6262785.454.453.0113.61212531003537155941101-- Converte notas em processo de
contingencia exec dbo.s061m3_0 @funcao = 'I' ,@cd_ambi = 1 ,@cd_user_manu =
'Job-040' ,@fl_abre_tran = 'S'5952059.653.463.009.250881917392138651--Transfere
as notas do DB_GNFE_ITFC para DB_GNFE e inicia Validação exec dbo.s201i1_0
@funcao = 'S' ,@cd_user_manu = 'Job-020'
5852492.254.263.0022.066415434149689640491exec dbo.s597m7_0 @funcao = '11'
,@cd_serv_webs = 'MDFeRecepcaoEvento' ,@cd_user_manu = 'Job-302' ,@fl_dbug = 'N'
,@qt_wait_for = '00:00:0041149139.86119.56119.03120.072410119619062131declare
@p5 int set @p5=0 declare @p6 varchar(255) set @p6='Inclusão realizada com
sucesso.' exec s051s1_1
@cd_user_manu='SERVTRAN1',@cd_serv_tran3281173.483.583.008.7375463099258814131declare
@p5 int set @p5=0 declare @p6 varchar(255) set @p6='Inclusão realizada com
sucesso.' exec s051s1_1
@cd_user_manu='SERVTRAN1B',@cd_serv_tra3271179.913.613.005.9178459475258030561declare
@p5 int set @p5=0 declare @p6 varchar(255) set @p6='Inclusão realizada com
sucesso.' exec s051s1_1
@cd_user_manu='SERVTRAN2',@cd_serv_tran240867.523.613.007.7239338895189457471OUTRAS5952568219.4495.473.00134.659804738245382409259342TOTAL12754716550.9827.473.00134.651893898162932217226978453




TOP 10 - Queries Demoradas - Últimos 10 Dias (07:00 - 23:00)




DateQTD2025-04-15127542025-04-14128972025-04-1393702025-04-1291202025-04-11120552025-04-10122452025-04-09124792025-04-08125782025-04-07123232025-04-0610008




Média Contadores Dia Anterior (07:00 - 23:00)




HourBatch RequestsCPUPLESQL CompilationsUser ConnectionNum Slow QueriesReads
Slow QueriesPage
Splits/sec71493577192113189018285890182858486208818947807922144989372609893726085024149236628439221471157131171157131178550833102406887991315112781940112781940186214381124967915914151127114530127114530869624812230619519141481120915021120915028767415132085298791214510437121410437121488158361423156102391214610907988010907988088648741524161105991314811636246811636246889228121623764109591414812173890912173890989840641724466113191415012759878412759878490575951821957116791314611258006711258006791320911916439120391113891920177919201779170928201513612399011349015386190153861918228121149351275901131895640078956400791897692214835131190113088634383886343839195447




TOP 10 - Conexões Abertas por Usuários




OrderLogin NameSession Count1gnfe1091COBRA\Administrator171AUTORIDADE
NT\SISTEMA32TOTAL129




TOP 10 - Fragmentação dos Índices




DateDatabaseTableIndexFragmentation (%)Page CountFill
FactorCompression2025-04-02
00:00:00DB_GNFEtbl_219_nfe_traki01_219_nfe_trak97.6325348330NO
Compression2025-04-02
00:00:00DB_GNFEtbl_219_nfe_traki02_219_nfe_trak96.3727541800NO
Compression2025-04-02
00:00:00DB_GNFEtbl_219_nfe_trakipk_219_nfe_trak93.7759598510NO
Compression2025-04-02
00:00:00ReportServerExecutionLogStoragePK__Executio__05F5D74515DA3E5D13.9215834400NO
Compression2025-04-02
00:00:00ReportServerExecutionLogStorageIX_ExecutionLog11.93226780NO Compression




TOP 10 - Waits Stats Dia Anterior (07:00 - 23:00)




Wait TypeLast Log DateDif Wait (s)Dif Resource (s)Dif Signal (s)Dif Wait
CountPercentageCXPACKET2025-04-15
22:37:0745463.1844699.48763.6975919826.06LCK_M_X2025-04-15
22:37:0719275.3319109.03166.292128357.43MSQL_XP2025-04-15
22:37:075951.735951.730.002038513.54PREEMPTIVE_OS_AUTHENTICATIONOPS2025-04-15
22:37:073051.883051.880.0035231151.83LCK_M_IX2025-04-15
22:37:071096.981051.2845.71571911.45PAGEIOLATCH_SH2025-04-15
22:37:071068.681065.333.35556971.45BACKUPIO2025-04-15
22:37:07201.24194.336.92104556.55LATCH_SH2025-04-15
22:37:0743.5740.802.7723491.13ASYNC_IO_COMPLETION2025-04-15
22:37:070.000.000.0008.33BACKUPBUFFER2025-04-15 22:37:070.000.000.0006.82




Alertas Sem CLEAR




AlertMessageDateOpen TimeDisk SpaceALERTA: Existe um disco com mais de 90% de
utilização no Servidor: COBRAGNFE2025-03-11 06:25:3336 Dia(s) 00:29:54




TOP 50 - Alertas Últimas 24 horas




AlertMessageDateOpen TimeAlert Without ClearALERTA: Existe(m) Alerta(s) sem
Clear no Servidor: COBRAGNFE2025-04-16 06:50:18-




TOP 10 - Login Failed - SQL Server




OrderTextNumber of ErrorWithout Information about Login Failed-




TOP 100 - Error Log do SQL Server




DateProcess InfoText2025-04-16 00:00:42spid17sThis instance of SQL Server has
been using a process ID of 2032 since 01/04/2025 10:54:38 (local) 01/04/2025
13:54:38 (UTC). This is an informational message only; no user action is
required.





[https://www.dataex.com.br/wp-content/uploads/2019/07/Logo-Laranja-e-Cinza.png]
[https://www.dataex.com.br]