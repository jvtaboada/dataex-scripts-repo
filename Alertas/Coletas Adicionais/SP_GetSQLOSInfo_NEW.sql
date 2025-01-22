USE DBADataEx
GO

CREATE PROCEDURE SP_GetSQLInfo @Environment NVARCHAR(15)
WITH ENCRYPTION
AS
SELECT
	CASE 
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '8%' THEN 'SQL2000'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '9%' THEN 'SQL2005'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.0%' THEN 'SQL2008'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '10.5%' THEN 'SQL2008 R2'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '11%' THEN 'SQL2012'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '12%' THEN 'SQL2014'
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '13%' THEN 'SQL2016'     
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '14%' THEN 'SQL2017' 
	WHEN CONVERT(VARCHAR(128), SERVERPROPERTY ('productversion')) like '15%' THEN 'SQL2019' 
	ELSE 'unknown'
END AS MajorVersion,
	SERVERPROPERTY('ProductLevel') AS ProductLevel,
	SERVERPROPERTY('Edition') AS Edition,
	SERVERPROPERTY('ProductVersion') AS ProductVersion
INTO #SQLINFO

--SELECT host_platform as os_type,
--       host_distribution as os,
--       host_release as version
--INTO #OSINFO
--FROM sys.dm_os_host_info

CREATE TABLE #REGREAD
	(
	VALUE VARCHAR(40),
	OS VARCHAR(255)
	)
INSERT INTO #REGREAD
EXEC master..xp_instance_regread	@rootKey = 'HKEY_LOCAL_MACHINE', 
									@key = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion', 
									@valueName = 'ProductName'

INSERT INTO SQLOSInfo 
SELECT	
		GETDATE(),
		MajorVersion AS [SQL_ProductVersion], 
		ProductLevel AS [SQL_ProductLevel], 
		Edition AS [SQL_Edition], 
		[OS],
		@Environment
FROM #SQLINFO, #REGREAD
--DROP TABLE SQLOSInfo
--CREATE TABLE SQLOSInfo
--	(
--		[DataColeta] datetime,
--		[SQL_ProductVersion] sql_variant,
--		[SQL_ProductLevel] sql_variant,
--		[SQL_Edition] sql_variant,
--		[OS] VARCHAR(255),
--		[Environment] NVARCHAR (15)
--	)

DROP TABLE #SQLINFO
DROP TABLE #REGREAD
--TRUNCATE TABLE SQLOSInfo
--SELECT * FROM #SQLINFO
--SELECT * FROM #OSINFO
--SELECT * FROM SQLOSInfo
--EXEC DBADataEx.dbo.SP_GetSQLInfo PROD