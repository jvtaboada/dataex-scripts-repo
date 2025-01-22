USE DBADataEX
go

SET NOCOUNT ON


IF ( OBJECT_ID('[dbo].[dtx_sp_Configuration_Table]') IS NOT NULL ) 
	DROP PROCEDURE [dbo].dtx_sp_Configuration_Table
GO

CREATE procedure dtx_sp_Configuration_Table @Ds_Email VARCHAR(MAX),@Ds_Profile_Email VARCHAR(MAX),@Fl_Language bit
AS
BEGIN

	IF ( OBJECT_ID('[dbo].[dtx_tb_Alert]') IS NOT NULL )
		DROP TABLE [dbo].[dtx_tb_Alert];

	CREATE TABLE [dbo].[dtx_tb_Alert] (
		[Id_Alert]				INT IDENTITY PRIMARY KEY,
		[Id_Alert_Parameter]	SMALLINT NOT NULL,
		[Ds_Message] VARCHAR(2000),
		[Fl_Type]				TINYINT,						-- 0: CLEAR / 1: ALERT
		[Dt_Alert]				DATETIME DEFAULT(GETDATE())
	);


	IF ( OBJECT_ID('[dbo].[dtx_tb_Alert_Parameter]') IS NOT NULL )
		DROP TABLE [dbo].[dtx_tb_Alert_Parameter];

	CREATE TABLE [dbo].[dtx_tb_Alert_Parameter] (
		[Id_Alert_Parameter] SMALLINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		[Nm_Alert] VARCHAR(100) NOT NULL,
		[Nm_Procedure] VARCHAR(100) NOT NULL,
		[Fl_Language] BIT NOT NULL,    --0 - English | 1 - Portuguese
		[Fl_Clear] BIT NOT NULL,
		[Fl_Enable] BIT NOT NULL, 
		[Vl_Parameter] SMALLINT NULL,
		[Ds_Metric] VARCHAR(50) NULL,
		[Vl_Parameter_2] INT,
		[Ds_Metric_2] VARCHAR(50) NULL,
		[Ds_Profile_Email] VARCHAR(200) NULL,
		[Ds_Email] VARCHAR(500) NULL,
		Ds_Message_Alert_ENG varchar(1000),
		Ds_Message_Clear_ENG varchar(1000),
		Ds_Message_Alert_PTB varchar(1000),
		Ds_Message_Clear_PTB varchar(1000),
		Ds_Email_Information_1_ENG VARCHAR(200),
		Ds_Email_Information_2_ENG VARCHAR(200),
		Ds_Email_Information_1_PTB VARCHAR(200),
		Ds_Email_Information_2_PTB VARCHAR(200)
		
	) ON [PRIMARY];

	ALTER TABLE [dbo].[dtx_tb_Alert]
	ADD CONSTRAINT FK01_Alert
	FOREIGN KEY ([Id_Alert_Parameter])
	REFERENCES [dbo].[dtx_tb_Alert_Parameter] ([Id_Alert_Parameter]);

	
INSERT INTO [dbo].[dtx_tb_Alert_Parameter]
		([Nm_Alert], [Nm_Procedure],[Fl_Language], [Fl_Clear],[Fl_Enable], [Vl_Parameter], [Ds_Metric], [Ds_Profile_Email], [Ds_Email],Ds_Message_Alert_ENG,Ds_Message_Clear_ENG,Ds_Message_Alert_PTB,Ds_Message_Clear_PTB,[Ds_Email_Information_1_ENG],[Ds_Email_Information_2_ENG],[Ds_Email_Information_1_PTB],[Ds_Email_Information_2_PTB]) 
VALUES	('Version DB CheckList ',				'2.0',@Fl_Language,									0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
		('Version DB Alert ',					'2.0',@Fl_Language,									0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
		('Blocked Process',				'dtx_sp_Alert_Blocked_Process',@Fl_Language,				1,1,		2,		'Minutes',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There are ###1 Blocked Processes for more than ###2 minutes and a total of ###3 Lock(s) on Server: ' ,'CLEAR: There is not a Blocked Process for more than ###1 minutes on Server: ' ,'ALERTA: Existe(m) ###1 Processo(s) Bloqueado(s) a mais de ###2 minuto(s) e um total de ###3 Lock(s) no Servidor:  ','CLEAR: N�o existe mais um processo Bloqueado a mais de ###1 minuto(s) no Servidor: ','TOP 50 - Process by Lock Level','TOP 50 - Process Executing on Database','TOP 50 - Processos por N�vel de Lock','TOP 50 - Processos executando no Banco de Dados '),
		('Blocked Long Process',		'dtx_sp_Alert_Blocked_Process',@Fl_Language,			1,1,		20,		'Minutes',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There are ###1 Blocked Processes for more than ###2 minutes and a total of ###3 Lock(s) on Server: ' ,'CLEAR: There is not a Blocked Process for more than ###1 minutes on Server: ' ,'ALERTA: Existe(m) ###1 Processo(s) Bloqueado(s) a mais de ###2 minuto(s) e um total de ###3 Lock(s) no Servidor:  ','CLEAR: N�o existe mais um processo Bloqueado a mais de ###1 minuto(s) no Servidor: ','TOP 50 - Process by Lock Level','TOP 50 - Process Executing on Database','TOP 50 - Processos por N�vel de Lock','TOP 50 - Processos executando no Banco de Dados '),
		('Log Full',				'dtx_sp_Alert_Log_Full',@Fl_Language,				1,1,		85,		'Percent',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Log File with more than ###1% used on Server: ','CLEAR: There is not a Log File with more than ###1 % used on Server: ','ALERTA: Existe um Arquivo de Log com mais de ###1% de utiliza��o no Servidor: ','CLEAR: N�o existe mais um Arquivo de Log com mais de ###1 % de utiliza��o no Servidor:','Transaction Log Informations','TOP 50 - Process Executing on Database','Informa��es dos Arquivos de Log','TOP 50 - Processos executando no Banco de Dados'),
		('CPU Utilization',						'dtx_sp_Alert_CPU_Utilization',@Fl_Language,					1,1,		85,		'Percent',	@Ds_Profile_Email,	@Ds_Email,'ALERT: Cpu utilization is greater than ###1% on Server: ','CLEAR: Cpu utilization is lower than ###1% on Server: ','ALERTA: O Consumo de CPU est� acima de ###1% no Servidor: ','CLEAR: O Consumo de CPU est� abaixo de ###1% no Servidor: ','CPU Utilization','TOP 50 - Process Executing on Database','Consumo de CPU no Servidor','TOP 50 - Processos executando no Banco de Dados'),
		('Disk Space',					'dtx_sp_Alert_Disk_Space',@Fl_Language,					1,1,		80,		'Percent',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a disk with more than ###1% used on Server: ','CLEAR: There is not a disk with more than ###1% used on Server: ','ALERTA: Existe um disco com mais de ###1% de utiliza��o no Servidor: ','CLEAR: N�o existe mais um volume de disco com mais de ###1% de utiliza��o no Servidor: ','Disk Space on Server','TOP 50 - Process Executing on Database','Espa�o em Disco no Servidor','TOP 50 - Processos executando no Banco de Dados'),
		('Database Without Backup',				'dtx_sp_Alert_Database_Without_Backup',@Fl_Language,			0,1,		24,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Database without Backup in the last ###1 Hours on Server: ','','ALERTA: Existem Databases sem Backup nas �ltimas ###1 Horas no Servidor: ','','Database without Backup in the last ###1 Hours','','Databases sem Backup nas �ltimas ###1 Horas',''),
		('SQL Server Restarted',			'dtx_sp_Alert_SQLServer_Restarted',@Fl_Language,			0,1,		20,		'Minutes',		@Ds_Profile_Email,	@Ds_Email,'ALERT: SQL Server restarted in the last ###1 Minutes on Server: ','','ALERTA: SQL Server Reiniciado nos �ltimos ###1 Minutos no Servidor: ','','SQL Server Restared in the last ###1 minutes','','SQL Server Reiniciado nos �ltimos ###1 Minutos',''),
		('Trace Creation',			'dtx_sp_Trace_Creation',@Fl_Language,							0,1,		3,		'Seconds',		@Ds_Profile_Email,	@Ds_Email,'This is not an Alert','','N�o � um Alerta. � para a cria��o do profile de 3 segundos.','',NULL,NULL,NULL,NULL),
		('Slow Queries',				'dtx_sp_Alert_Slow_Queries',@Fl_Language,				0,0,		500,	'Quantity',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There are ###1 slower queries in the last ###2 minutes on Server: ','','ALERTA: Existem ###1 queries demoradas nos �ltimos ###2 minutos no Servidor: ','','TOP 50 - Process Executing on Database','TOP 50 - Slow Queries','TOP 50 - Processos executando no Banco de Dados','TOP 50 - Queries Demoradas'),
		('Database Status',					'dtx_sp_Alert_Database_Status',@Fl_Language,				1,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Database that is not ONLINE on Server: ','CLEAR: All databases are ONLINE on Server: ','ALERTA: Existe uma Database que n�o est� ONLINE no Servidor: ','CLEAR: N�o existe mais uma Database que n�o est� ONLINE no Servidor: ','Databases not ONLINE','','Bases que n�o est�o ONLINE ',''),
		('Page Corruption',				'dtx_sp_Alert_Page_Corruption',@Fl_Language,				0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a corrupted page on a database on Server: ','','ALERTA: Existe uma P�gina Corrompida no BD no Servidor: ','','Corrupted Pages','','P�ginas Corrompidas',''),
		('Database Corruption',		'dtx_sp_Alert_CheckDB',@Fl_Language,						0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a corrupted database on Server: ','','ALERTA: Existe um Banco de Dados Corrompido no Servidor: ','','Corrupted Database','','Banco de Dados Corrompido',''),
		('Job Failed',						'dtx_sp_Alert_Job_Failed',@Fl_Language,						0,1,		24,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: Jobs failed in the last ###1 Hours on Server: ','','ALERTA: Jobs que Falharam nas �ltimas ###1 Horas no Servidor: ','','TOP 50 - Failed Jobs',NULL,'TOP 50 - Jobs que Falharam',NULL),
		('Database Created',					'dtx_sp_Alert_Database_Created',@Fl_Language,				0,1,		24,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: Database created in the last ###1 Hours on Server: ','','ALERTA: Database Criada nas �ltimas ###1 Horas no Servidor: ','','Created Database','Created Database - Data and Log Files','Database Criada','Database Criada - Arquivos de Dados e Log'),
		('Tempdb MDF File Utilization',	'dtx_sp_Alert_Tempdb_MDF_File_Utilization',@Fl_Language,	1,1,		70,		'Percent',	@Ds_Profile_Email,	@Ds_Email,'ALERT: The Tempdb MDF file is greater than ###1% used on Server: ','CLEAR: The Tempdb MDF file is lower than ###1% used on Server:  ','ALERTA: O Tamanho do Arquivo MDF do Tempdb est� acima de ###1% no Servidor: ','CLEAR: O Tamanho do Arquivo MDF do Tempdb est� abaixo de ###1% no Servidor: ','Tempdb MDF File Size', 'TOP 50 - Process Executing on Database', 'Tamanho Arquivo MDF Tempdb','TOP 50 - Processos executando no Banco de Dados'),
		('SQL Server Connection',				'dtx_sp_Alert_SQLServer_Connection',@Fl_Language,				1,1,		5000,	'Quantity',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There are more than ###1 Openned Connections on Server: ','CLEAR: There are not ###1 Openned Connections on Server: ','ALERTA: Existem mais de ###1 Conex�es Abertas no SQL Server no Servidor: ','CLEAR: N�o existem mais ###1 Conex�es Abertas no SQL Server no Servidor: ','TOP 25 - Open Connections on SQL Server','TOP 50 - Process Executing on Database','TOP 25 - Conex�es Abertas no SQL Server','TOP 50 - Processos executando no Banco de Dados'),
		('Database Errors',						'dtx_sp_Alert_Database_Errors',@Fl_Language,						0,0,		1000,	'Quantity',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There are ###1 Errors on the Last Day on Server: ','','ALERTA: Existem ###1 Erros do Banco de Dados Dia Anterior no Servidor: ','','TOP 50 - Database Erros from Yesterday',NULL,'TOP 50 - Erros do Banco de Dados Dia Anterior',NULL),
		('Slow Disk',					'dtx_sp_Alert_Slow_Disk',@Fl_Language,					0,1,		24,	'Hour',			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a slow disk message on the Last Day on Server: ','','ALERTA: Existe uma mensagem de lentid�o de Disco no Dia Anterior no Servidor: ','','Yesterday Slow Disk Access ',NULL,'Lentid�o de Acesso a Disco no Dia Anterior',NULL),
		('Slow Disk Every Hour',		'dtx_sp_Alert_Slow_Disk',@Fl_Language,					0,0,		1,	'Hour',			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a slow disk message in the Last Hour on Server: ','','ALERTA: Existe uma mensagem de lentid�o de Disco na �ltima Hora no Servidor: ','','Slow Disk Access ',NULL,'Lentid�o de Acesso a Disco',NULL),
		('Process Executing',			'dtx_sp_Send_Mail_Executing_Process',@Fl_Language,		0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'INFO: SQL Process running Now on Server: ','','INFO: Processos executando no Banco de Dados agora no servidor: ','','TOP 50 - Process Executing on Database',NULL,'Processos em Execu��o no Banco de Dados',NULL),
		('Database CheckList ',		'dtx_sp_Send_Mail_CheckList_DBA',@Fl_Language,			0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'INFO: Database Checklist on Server: ','','INFO: Checklist do Banco de Dados no Servidor: ','',NULL,NULL,NULL,NULL),
		('SQL Server Configuration',			'dtx_sp_SQLServer_Configuration',@Fl_Language,		0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'INFO: Database Information on Server: ','','INFO: Informa��es do Banco de Dados no Servidor: ','',NULL,NULL,NULL,NULL),
		('Long Running Process',				'dtx_sp_Alert_Long_Runnning_Process',@Fl_Language,				0,1,		2,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Process in execution for more than ###1 Hours on Server: ','','ALERTA: Existe(m) Processo(s) em Execu��o h� mais de ###1 Hora(s) no Servidor: ','','TOP 50 - Process Executing on Database',NULL,'Processos executando no Banco de Dados',NULL),
		('Slow File Growth',			'dtx_sp_Alert_Slow_File_Growth',@Fl_Language,			0,1,		5,		'Seconds',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a slow growth database file on Server: ','','ALERTA: Existe um Crescimento Lento de Arquivo de Base no Servidor: ','','TOP 50 - Database File Growth',NULL,'TOP 50 - Crescimentos de Arquivos Databases',NULL),
		('Alert Without Clear',				'dtx_sp_Alert_Without_Clear',@Fl_Language,						0,1,		NULL,	NULL,			@Ds_Profile_Email,	@Ds_Email,'ALERT: There is an Openned Alert on Server: ','','ALERTA: Existe(m) Alerta(s) sem Clear no Servidor: ','','Alerts Without CLEAR',NULL,'Alertas sem CLEAR',NULL),
		('Login Failed',					'dtx_sp_Alert_Login_Failed',@Fl_Language,					0,1,		100,	'Number',			@Ds_Profile_Email,	@Ds_Email,'ALERT: There are failed attempts to login on Server: ','','ALERTA: Existem tentativas de Login com falha no servidor: ','','Logins Failed - SQL Server',NULL,'Falhas de Login - SQL Server',NULL),
		('Database Without Log Backup',			'dtx_sp_Alert_Database_Without_Log_Backup',@Fl_Language,		1,1,		2,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Database without Log Backup in the last ###1 Hours on Server: ','CLEAR: There is not a Database without Log Backup in the last ###1 Hours on Server: ','ALERTA: Existem Databases sem Backup de Log nas �ltimas ###1 Horas no Servidor: ','CLEAR: N�o Existe Database sem Backup de Log nas �ltimas ###1 Horas no Servidor: ','Databases Without Log Backup','TOP 50 - Process Executing on Database','Databases sem Backup do Log','TOP 50 - Processos executando no Banco de Dados'),
		('IO Pending',			'dtx_sp_Alert_IO_Pending',@Fl_Language,		0,1,		10,		'Seconds',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a IO Pending for more than ###1 Seconds on Server: ','','ALERTA: Existe uma opera��o de IO maior que ###1 Segundos pendentes no Servidor: ','','TOP 50 - IO Pending Operation','TOP 50 - Process Executing on Database','TOP 50 - Opera��es de IO pendentes','TOP 50 - Processos executando no Banco de Dados'),
		('Memory Available',			'dtx_sp_Alert_Memory_Available',@Fl_Language,		1,1,		2,		'GB',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There are Less than ###1 GB of Memory Available on Server: ','CLEAR: There are More than ###1 GB of Memory Available on Server: ','ALERTA: Existe menos de ###1 GB de Mem�ria Disponivel no Servidor: ','CLEAR: Existe mais de ###1 GB de Mem�ria Disponivel no Servidor: ','Memory Used','TOP 50 - Process Executing on Database','Utiliza��o de Mem�ria','TOP 50 - Processos executando no Banco de Dados'),
		('Job Disabled',			'dtx_sp_Alert_Job_Disabled',@Fl_Language,		0,1,		NULL,		NULL,		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a Disabled Job From Yesterday on Server: ','','ALERTA: Existe um Job que foi Desabilitado no Servidor: ','','Jobs Disabled','','Jobs Desabilitados',''),
		('Large LDF File',			'dtx_sp_Alert_Large_LDF_File',@Fl_Language,		1,1,		50,		'Percent',		@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a LDF File with ###1 % of the MDF File on Server: ','CLEAR: There is not a LDF File with ###1 % of the MDF File on Server:  ','ALERTA: Existe um Arquivo de Log com ###1 % do tamanho do arquivo de Dados no Servidor: ','CLEAR: N�o existe um Arquivo de Log com ###1 % do tamanho do arquivo de Dados no Servidor: ','Database File Informations','TOP 50 - Process Executing on Database','Informa��es dos Arquivos das Bases de Dados','TOP 50 - Processos executando no Banco de Dados'),
		('Rebuild Failed',			'dtx_sp_Alert_Rebuild_Failed',@Fl_Language,						0,1,		8,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: The Rebuild Job failed because Lock Timeout on Server: ','','ALERTA: O Job de Rebuild falhou por causa de Lock no Servidor : ','','Last Lock Registered',NULL,'�ltimo Lock Registrado',NULL),
		('DeadLock',			'dtx_sp_Alert_DeadLocks',@Fl_Language,						0,0,		24,		'Hours',		@Ds_Profile_Email,	@Ds_Email,'ALERT: We had ###2 DeadLocks in the last ###1 Hours on Server: ','','ALERTA: Aconteceram ###2 DeadLocks as ultimas ###1 Horas no Servidor : ','','DeadLocks Occurrence',NULL,'Ocorr�ncias de DeadLocks',NULL),
		('Database Growth',			'dtx_sp_Alert_Database_Growth',@Fl_Language,						0,1,		20,		'GB',		@Ds_Profile_Email,	@Ds_Email,'ALERT: We had a large Database Growth in the Last 24 Hours on Server : ','','ALERTA: Tivemos um crescimento grande de base nas �ltimas 24 horas no Servidor : ','','Database Growth',NULL,'Crescimento da Base',NULL),
		('MaxSize Growth',			'dtx_sp_Alert_MaxSize_Growth',@Fl_Language,						1,1,		80,		'Percent',	@Ds_Profile_Email,	@Ds_Email,'ALERT: There is a file with more than ###1% of the Maxsize used on Server: ','CLEAR: There is not a file with more than ###1% of the Maxsize used on Server: ','ALERTA: Existe um arquivo com mais de ###1% de utiliza��o do Maxsize no servidor: ','CLEAR: N�o existe um arquivo com mais de ###1% de utiliza��o do Maxsize no servidor: ','SQL Server File(s)','TOP 50 - Process Executing on Database','Arquivo(s) do SQL Server','TOP 50 - Processos executando no Banco de Dados'),
		('CPU Utilization MI',  	 'dtx_sp_Alert_CPU_Utilization_MI',    @Fl_Language,    1,   0,    85,    'Percent', @Ds_Profile_Email,	@Ds_Email,'ALERT: Cpu utilization is greater than ###1% on Server: ','CLEAR: Cpu utilization is lower than ###1% on Server: ',	'ALERTA: O Consumo de CPU est� acima de ###1% no Servidor: ',      'CLEAR: O Consumo de CPU est� abaixo de ###1% no Servidor: ', 	   'CPU Utilization', 'TOP 50 - Process Executing on Database',  'Consumo de CPU no Servidor',      'TOP 50 - Processos executando no Banco de Dados'),
		('Database Mirroring',  	 'dtx_sp_Alert_Status_DB_Mirror',    @Fl_Language,    0,   0,    NULL,    NULL, @Ds_Profile_Email,	@Ds_Email,'ALERT: The DB Mirror Status has changed on Server: ','',	'ALERTA: O Status do Database Mirror mudou no Servidor: ',      '', 	   'Database Mirroring Status', '',  'Status do Database Mirroring',      ''),
	    ('Failover Cluster Active Node',  	 'dtx_sp_Alert_Cluster_Active_Node',    @Fl_Language,    0,   0,    NULL,    NULL, @Ds_Profile_Email,	@Ds_Email,'ALERT: The Failover Cluster Active Node has Changed','',	'ALERTA: O n� ativo do Cluster mudou',      '', 	   'Failover Cluster Nodes Now', '',  'Failover Cluster Nodes agora',      ''),
	    ('Failover Cluster Node Status',  	 'dtx_sp_Alert_Cluster_Node_Status',    @Fl_Language,    1,   0,    NULL,    NULL, @Ds_Profile_Email,	@Ds_Email,'ALERT: Some Failover Cluster Node are not UP','CLEAR: ALL Failover Cluster Nodes are UP',	'ALERTA: Algum n� do Cluster n�o est� com o status UP',      'CLEAR: Todos os n�s do Cluster est�o com o status UP', 	   'Failover Cluster Nodes', '',  'N�s do Cluster',      ''),
	    ('AlwaysON AG STATUS',	'dtx_sp_Alert_AlwaysON_AG_Status',	@Fl_Language,	0,	0,	NULL,		NULL,	@Ds_Profile_Email,	@Ds_Email,'ALERT: The AlwaysON Status are not SYNCHRONIZED and HEALTHY on Server: ','CLEAR: The AlwaysON Status are SYNCHRONIZED and HEALTHY on Server: ',	'ALERTA: O Status do AlwaysON AG est� difernete de SYNCHRONIZED e HEALTHY no Servidor: ',	'CLEAR: O Status do AlwaysON AG est� como SYNCHRONIZED e HEALTHY no Servidor: ','AlwaysON AG Dadabase Status','TOP 50 - Process Executing on Database',	'Status das bases do AlwaysON AG','TOP 50 - Processos executando no Banco de Dados'),
		('Index Fragmentation','dtx_sp_Alert_Index_Fragmentation',@Fl_Language,0,0,7,'Days', @Ds_Profile_Email,	@Ds_Email,'ALERT: We have a Index Fragmented for more than ###1 days on Server : ','',	'ALERTA: Temos pelo menos um �ndice Fragmentado por mais de ###1 dias no Servidor: ',      '', 	   'Indexes Fragmented for a long time', '',  'Indices Fragmentados por muito tempo',      '')

		-- Alert that needs more than one metric			
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 65536, --Index with 500 MB 
				[Ds_Metric_2] = 'Pages'
		WHERE [Nm_Alert] =  'Index Fragmentation';
							
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 1, 
				[Ds_Metric_2] = 'Minute'
		WHERE [Nm_Alert] =  'CPU Utilization MI';
					
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 10, 
				[Ds_Metric_2] = 'GB'
		WHERE [Nm_Alert] IN ('Large LDF File');
		
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 1, --SPID that is generating the lock must be executing for at least 1 minute
				[Ds_Metric_2] = 'minute'
		WHERE [Nm_Alert] IN ('Blocked Process','Blocked Long Process');
		
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 10240, --GB to sent a log alerta
				[Ds_Metric_2] = 'MB'
		WHERE [Nm_Alert] = 'Log Full';

		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 10000, 
				[Ds_Metric_2] = 'MB'
		WHERE [Nm_Alert] = 'Tempdb MDF File Utilization';

		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET
				[Vl_Parameter_2] = 24, 
				[Ds_Metric_2] = 'Hour'
		WHERE [Nm_Alert] = 'Slow File Growth';

		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET		[Vl_Parameter_2] = 5, 
				[Ds_Metric_2] = 'Minutes'
		WHERE [Nm_Alert] = 'Slow Queries';

		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET		[Vl_Parameter_2] = 24, 
				[Ds_Metric_2] = 'Hour'
		WHERE [Nm_Alert] = 'Database Errors';

	
		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET		[Vl_Parameter_2] = 5, 
				[Ds_Metric_2] = 'MB'
		WHERE [Nm_Alert] = 'Slow Disk Every Hour';


		UPDATE [dbo].[dtx_tb_Alert_Parameter]
		SET		[Vl_Parameter_2] = 100, 
				[Ds_Metric_2] = 'Quantity'
		WHERE [Nm_Alert] = 'DeadLock';
		
		IF CONVERT(char(20), SERVERPROPERTY('IsClustered')) = 1
			UPDATE [dbo].[dtx_tb_Alert_Parameter]
			SET Fl_Enable = 1
			WHERE Nm_Alert IN ('Failover Cluster Active Node','Failover Cluster Node Status')
		
END


GO

if OBJECT_ID('dtx_tb_Alert_Cluster_Active_Node') is NOT  NULL
	DROP TABLE Alert_Cluster_Active_Node

	create table dtx_tb_Alert_Cluster_Active_Node(
		Nm_Active_server varchar(100))

	insert into dtx_tb_Alert_Cluster_Active_Node
	select CONVERT(VARCHAR(100), SERVERPROPERTY('ComputerNamePhysicalNetBIOS'))


if OBJECT_ID('dtx_tb_Log_IO_Pending') is  null
	CREATE TABLE [dbo].dtx_tb_Log_IO_Pending(
	Id_Log_IO_Pending int identity , 	
	[Nm_Database] [varchar](128) NULL,
	[Physical_Name] [varchar](260) NOT NULL,
	[IO_Pending] [int] NOT NULL,
	[IO_Pending_ms] [bigint] NOT NULL,
	[IO_Type] [varchar](60) NOT NULL,
	[Number_Reads] [bigint] NOT NULL,
	[Number_Writes] [bigint] NOT NULL,
	[Dt_Log] [datetime] NOT NULL
) ON [PRIMARY]


if OBJECT_ID('dtx_tb_Alert_Customization') is  null
begin 	
 create table dtx_tb_Alert_Customization(
		Id_Alert_Customizations int identity,
		Nm_Alert varchar(100),
		Nm_Procedure varchar(200),
		Ds_Customization varchar(8000))

	ALTER TABLE dtx_tb_Alert_Customization
		ADD Dt_Customization DATETIME
		 CONSTRAINT DF_Alert_Customization  DEFAULT (GETDATE())
end

if OBJECT_ID('[dtx_tb_Log_DeadLock]') is  not NULL
	DROP TABLE dtx_tb_Log_DeadLock
	
CREATE TABLE [dbo].[dtx_tb_Log_DeadLock](
	[eventName] [varchar](100) NULL,
	[eventDate] [datetime] NULL,
	[deadlock] [xml] NULL,
	[Nm_Object] [varchar](500) NULL ,
	[Nm_Database] [varchar](500) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

if OBJECT_ID('dtx_tb_Queries_Profile') is null

	CREATE TABLE [dbo].[dtx_tb_Queries_Profile](
		[TextData] varchar(max) NULL,
		[NTUserName] [varchar](128) NULL,
		[HostName] [varchar](128) NULL,
		[ApplicationName] [varchar](128) NULL,
		[LoginName] [varchar](128) NULL,
		[SPID] [int] NULL,
		[Duration] [numeric](15, 2) NULL,
		[StartTime] [datetime] NULL,
		[EndTime] [datetime] NULL,
		[ServerName] [varchar](128) NULL,
		[Reads] bigint NULL,
		[Writes] bigint NULL,
		[CPU] bigint NULL,
		[DataBaseName] [varchar](128) NULL,
		[RowCounts] bigint NULL,
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]   


	-- Used in Procedure stpAlert_Page_Corruption
	IF ( OBJECT_ID('[dbo].[dtx_tb_Suspect_Pages_History]') IS  NULL )
		CREATE TABLE [dbo].[Suspect_Pages_History](
		[database_id] [int] NOT NULL,
		[file_id] [int] NOT NULL,
		[page_id] [bigint] NOT NULL,
		[event_type] [int] NOT NULL,
		[Dt_Corruption] [datetime] NOT NULL
	) ON [PRIMARY]

IF ( OBJECT_ID('[dbo].[dtx_tb_Status_Job_SQL_Agent]') IS  NULL )
	
-- Job Status History. Used on Status Job Alerta
	CREATE TABLE dtx_tb_Status_Job_SQL_Agent(
		Name VARCHAR(200),
		Dt_Referencia DATE,
		Date_Modified DATETIME,
		Fl_Status BIT)
    
  
if object_id('dtx_tb_Table_Size_History') is  null
	CREATE TABLE [dbo].[dtx_tb_Table_Size_History] (
		[Id_Size_History] [int] IDENTITY(1,1) NOT NULL,
		[Id_Server] [smallint] NULL,
		[Id_Database] [smallint] NULL,
		[Id_Table] [int] NULL,
		[Nm_Drive] [char](1) NULL,
		[Nr_Total_Size] [numeric](15, 2) NULL,
		[Nr_Data_Size] [numeric](15, 2) NULL,
		[Nr_Index_Size] [numeric](15, 2) NULL,
		[Qt_Rows] [bigint] NULL,
		[Dt_Log] [date] NULL,
		CONSTRAINT [PK_Table_Size_History] PRIMARY KEY CLUSTERED (
			[Id_Size_History] ASC
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]


if object_id('dtx_tb_User_Database') is  null
	CREATE TABLE [dbo].dtx_tb_User_Database (
		[Id_Database] [int] IDENTITY(1,1) NOT NULL,
		[Nm_Database] [varchar](500) NULL,
		CONSTRAINT [PK_User_Database] PRIMARY KEY CLUSTERED (Id_Database)
	) ON [PRIMARY]


if object_id('dtx_tb_User_Table') is  null
	CREATE TABLE [dbo].dtx_tb_User_Table (
		[Id_Table] [int] IDENTITY(1,1) NOT NULL,
		[Nm_Table] [varchar](1000) NULL,
		CONSTRAINT [PK_User_Table] PRIMARY KEY CLUSTERED (
			[Id_Table] ASC
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]	


if object_id('dtx_tb_User_Server') is  null

	CREATE TABLE [dbo].dtx_tb_User_Server (
		[Id_Server] [int] IDENTITY(1,1) NOT NULL,
		[Nm_Server] [varchar](100) NOT NULL,
		CONSTRAINT [PK_User_Server] PRIMARY KEY CLUSTERED (
			[Id_Server] ASC
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

GO

if object_id('dtx_tb_Index_Fragmentation_History') is  null
BEGIN 	
	CREATE TABLE dtx_tb_Index_Fragmentation_History(
		[Id_Index_Fragmentation_History] [int] IDENTITY(1,1) NOT NULL,
		[Dt_Log] [date] NULL,
		[Id_Server] [smallint] NULL,
		[Id_Database] [smallint] NULL,
		[Id_Table] [int] NULL,
		[Nm_Index] [varchar](700) NULL,
		Nm_Schema varchar(50),
		[Avg_Fragmentation_In_Percent] [numeric](5, 2) NULL,
		[Page_Count] [int] NULL,
		[Fill_Factor] [tinyint] NULL,
		[Fl_Compression] [tinyint] NULL
	) ON [PRIMARY]


	CREATE NONCLUSTERED INDEX IX01_Index_Fragmentation_History
	ON dtx_tb_Index_Fragmentation_History(Dt_Log, Id_Server, Id_Database, Id_Table, Id_Index_Fragmentation_History)
	WITH(FILLFACTOR=95)

	CREATE NONCLUSTERED INDEX IX02_Index_Fragmentation_History 
	ON dtx_tb_Index_Fragmentation_History (Id_Table,Nm_Index,Id_Database,Id_Server) 
	WITH(FILLFACTOR=90)
END
GO

-----

IF (OBJECT_ID('[dbo].[dtx_vw_Index_Fragmentation_History]') IS NOT NULL)
	drop view [dbo].[dtx_vw_Index_Fragmentation_History]
GO
create view [dbo].[dtx_vw_Index_Fragmentation_History]
AS
select A.Dt_Log, B.Nm_Server, C.Nm_Database,D.Nm_Table ,A.Nm_Index, A.Nm_Schema, 
	A.Avg_Fragmentation_In_Percent, A.Page_Count, A.Fill_Factor, A.Fl_Compression
from dtx_tb_Index_Fragmentation_History A
	inner join dtx_tb_User_Server B on A.Id_Server = B.Id_Server
	inner join dtx_tb_User_Database C on A.Id_Database = C.Id_Database
	inner join dtx_tb_User_Table D on A.Id_Table = D.Id_Table


GO


IF (OBJECT_ID('[dbo].[dtx_tb_File_Utilization_History]') IS  NULL)

	CREATE TABLE [dbo].dtx_tb_File_Utilization_History (
		[Nm_Database] [nvarchar](128) NULL,
		[file_id] [smallint] NOT NULL,
		[io_stall_read_ms] [bigint] NOT NULL,
		[num_of_reads] [bigint] NOT NULL,
		[avg_read_stall_ms] [numeric](10, 1) NULL,
		[io_stall_write_ms] [bigint] NOT NULL,
		[num_of_writes] [bigint] NOT NULL,
		[avg_write_stall_ms] [numeric](10, 1) NULL,
		[io_stalls] [bigint] NULL,
		[total_io] [bigint] NULL,
		[avg_io_stall_ms] [numeric](10, 1) NULL,
		[Dt_Log] [datetime] NOT NULL
	) ON [PRIMARY]

GO


if OBJECT_ID('dtx_tb_SQL_Counter') is  null
BEGIN

	CREATE TABLE [dbo].dtx_tb_SQL_Counter (
		Id_Counter INT identity, 
		Nm_Counter VARCHAR(50) 
	)

	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'BatchRequests'
	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'User_Connection'
	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'CPU'
	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'Page Life Expectancy'
	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'SQL_Compilations'
	INSERT INTO dtx_tb_SQL_Counter (Nm_Counter)
	SELECT 'Page Splits/sec'

END

-- SELECT * FROM SQL_Counter
if OBJECT_ID('dtx_tb_Log_Counter') is  null
	CREATE TABLE [dbo].[dtx_tb_Log_Counter] (
		[Id_Log_Counter] [int] IDENTITY(1,1) NOT NULL,
		[Dt_Log] [datetime] NULL,
		[Id_Counter] [int] NULL,
		[Value] BIGINT NULL
	) ON [PRIMARY]


if object_id('dtx_tb_Index_Fragmentation_History') is not null
	drop table dtx_tb_Index_Fragmentation_History

CREATE TABLE dtx_tb_Index_Fragmentation_History(
	[Id_Index_Fragmentation_History] [int] IDENTITY(1,1) NOT NULL,
	[Dt_Log] [date] NULL,
	[Id_Server] [smallint] NULL,
	[Id_Database] [smallint] NULL,
	[Id_Table] [int] NULL,
	[Nm_Index] [varchar](1000) NULL,
	Nm_Schema varchar(50),
	[Avg_Fragmentation_In_Percent] [numeric](5, 2) NULL,
	[Page_Count] [int] NULL,
	[Fill_Factor] [tinyint] NULL,
	[Fl_Compression] [tinyint] NULL
) ON [PRIMARY]




if object_id('dtx_tb_Waits_Stats_History') is not null
	drop table dtx_tb_Waits_Stats_History
GO
CREATE TABLE [dbo].[dtx_tb_Waits_Stats_History](
[Id_Waits_Stats_History] [int] IDENTITY(1,1) NOT NULL,
[Dt_Log] [datetime] NULL default(getdate()),
[WaitType] [varchar](60) NOT NULL,
[Wait_S] [decimal](14, 2) NULL,
[Resource_S] [decimal](14, 2) NULL,
[Signal_S] [decimal](14, 2) NULL,
[WaitCount] [bigint]  NULL,
[Percentage] [decimal](4, 2) NULL,
Id_Store int,
CONSTRAINT [PK_Waits_Stats_History] PRIMARY KEY CLUSTERED (	[Id_Waits_Stats_History] ASC )
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX01_Waits_Stats_History ON dtx_tb_Waits_Stats_History([WaitType],Id_Waits_Stats_History) 
GO
