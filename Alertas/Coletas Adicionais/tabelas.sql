USE [DBADataEX]
GO

/****** Object:  Table [dbo].[Status_Jobs]    Script Date: 01/10/2020 11:23:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Status_Jobs](
	[NomeJob] [nvarchar](200) NULL,
	[DataUltimaExecucao] [nvarchar](100) NULL,
	[STATUS] [nvarchar](50) NULL
) ON [PRIMARY]
GO


USE [DBADataEX]
GO

/****** Object:  Table [dbo].[WaitTypes]    Script Date: 01/10/2020 11:24:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WaitTypes](
	[WaitType] [nvarchar](120) NULL,
	[Wait_S] [decimal](16, 2) NULL,
	[Resource_S] [decimal](16, 2) NULL,
	[Signal_S] [decimal](16, 2) NULL,
	[WaitCount] [bigint] NULL,
	[Percentage] [decimal](5, 2) NULL,
	[AvgWait_S] [decimal](16, 4) NULL,
	[AvgRes_S] [decimal](16, 4) NULL,
	[AvgSig_S] [decimal](16, 4) NULL,
	[InfoURL] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

USE [DBADataEX]
GO

/****** Object:  Table [dbo].[VLFs]    Script Date: 01/10/2020 11:25:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VLFs](
	[Contagem] [int] NULL,
	[DBName] [varchar](255) NULL,
	[DataColeta] [datetime] NULL
) ON [PRIMARY]
GO

USE [DBADataEX]
GO

/****** Object:  Table [dbo].[TB_Backups]    Script Date: 01/10/2020 11:26:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TB_Backups](
	[NomeDaBase] [nvarchar](256) NULL,
	[TipoBackup] [varchar](20) NULL,
	[TamanhoBackup] [decimal](18, 3) NULL,
	[DataBackup] [datetime] NULL
) ON [PRIMARY]
GO

USE DBADataEx
GO
CREATE TABLE CPUINFO (
	DataColeta datetime,
	VirtualMachineType NVARCHAR(60),
	NUMA_Config NVARCHAR(60),
	NUMA_Nodes INT,
	Physical_CPUs INT,
	CPU_Cores INT,
	Logical_CPUs INT,
	Logical_CPUs_per_NUMA INT,
	CPU_AffinityType VARCHAR(60),
	ParallelCostThreshold_Current INT, 
	MAXDOP_Current INT, 
	MAXDOP_Optimal_Value NVARCHAR(60), 
	MAXDOP_Optimal_Reason NVARCHAR(1024),
	[Environment] [varchar](10) NULL
	)

--Add new column "ServerName"
USE DBADataEx
GO
ALTER TABLE [dbaDataEx].[dbo].[CPUINFO]
ADD [HostName] VARCHAR (20) NULL;


USE [DBADataEx]
GO
CREATE TABLE [dbo].[Disk_Space](
	[drive] [char](1) NULL,
	[FreeSpace] [float] NULL,
	[TotalSize] [float] NULL,
	[DataHora] [datetime] NULL
) ON [PRIMARY]

USE [DBADataEX]
GO
CREATE TABLE SQLOSInfo
	(
		[DataColeta] datetime,
		[SQL_ProductVersion] sql_variant,
		[SQL_ProductLevel] sql_variant,
		[SQL_Edition] sql_variant,
		[OS] VARCHAR(255),
		[Environment] NVARCHAR (15)
	)
	
	
	
USE [DBADataEX]
GO

/****** Object:  Table [dbo].[dtx_tb_tbsize]    Script Date: 10/2/2020 3:15:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dtx_tb_tbsize](
	[db] [varchar](255) NULL,
	[tb] [varchar](255) NULL,
	[schema] [varchar](100) NULL,
	[rowCounts] [bigint] NULL,
	[reserved_KB] [float] NULL,
	[reserved_MB] [float] NULL,
	[reserved_GB] [float] NULL,
	[used_KB] [float] NULL,
	[used_MB] [float] NULL,
	[used_GB] [float] NULL,
	[unused_KB] [float] NULL,
	[unused_MB] [float] NULL,
	[unused_GB] [float] NULL,
	[date] [datetime] NULL
) ON [PRIMARY]
GO


