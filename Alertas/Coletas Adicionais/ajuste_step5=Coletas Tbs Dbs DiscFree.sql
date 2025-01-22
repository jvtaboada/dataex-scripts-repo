-- coleta dbs
DECLARE @DatabasesSize TABLE
    (
  DBName varchar(255),
  FileNme varchar(255),
  SpaceUsed INT,
  FreeSpaceMB FLOAT,
  size int 
    )
INSERT  INTO @DatabasesSize
EXEC sp_MSforeachdb 
      'use [?]; Select ''?'' DBName, Name FileNme, fileproperty(Name,''SpaceUsed'') SpaceUsed,
    size/128.0 - CAST(FILEPROPERTY(NAME, ''SpaceUsed'') AS INT)/128.0 AS FreeSpaceMB, size
    from sysfiles'
    INSERT INTO DBADataEX.dbo.DBSize
SELECT 
    A.DBName,
    A.FileNme,
    CAST(A.SpaceUsed * 1.0 * 8 / 1024  AS DECIMAL (15,5)) AS TAMANHO_MB,
    CAST(A.SPACEUSED * 1.0 * 8 /1024/1024 AS DECIMAL(15,5)) AS TAMANHO_GB,
    CAST(A.FREESPACEMB  AS DECIMAL(15,5)) AS FREESPACE_MB,
    CAST(A.FreeSpaceMB / 1024 AS DECIMAL (15,5)) AS FREESPACE_GB,
    CAST(A.SpaceUsed * 1.0 * 8 /1024  AS DECIMAL (15,5)) +  CAST(A.FREESPACEMB AS DECIMAL(15,5)) AS TotalMB,
    CAST(A.SPACEUSED * 1.0 * 8 /1024/1024 AS DECIMAL(15,5)) + CAST(A.FreeSpaceMB / 1024 AS DECIMAL (15,5)) AS TotalGB,
    GETDATE() 
    FROM @DatabasesSize A INNER JOIN SYS.MASTER_FILES B ON A.FileNme = B.NAME COLLATE SQL_Latin1_General_CP850_CI_AS AND A.DBNAME = DB_NAME(B.database_id)
    --WHERE B.DATABASE_ID > 4

waitfor delay '00:00:01'
-- coleta discos free

USE DBADataEX;
create table #discos 
(
 disco varchar(10),
 free_space int
-- data datetime
)
INSERT INTO #discos
exec('xp_fixeddrives')
go
INSERT INTO discos
SELECT
disco, free_space, data = getdate()
FROM #discos
drop table #discos

--coleta tabelas
waitfor delay '00:00:01'
declare @dia as int
SELECT @dia = DAY(getdate()); --AS DayOfMonth;
select @dia
If (@dia in (1,15))
begin
print 'roda'  
exec DBADataEX.[dbo].[dtx_sp_SizeAllTables]
end
else
begin
print 'pula'
end

