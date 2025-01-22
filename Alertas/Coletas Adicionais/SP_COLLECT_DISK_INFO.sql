USE [DBADataEx]
GO
--CREATE TABLE [dbo].[Disk_Space](
--	[drive] [char](1) NULL,
--	[FreeSpace] [float] NULL,
--	[TotalSize] [float] NULL,
--	[DataHora] [datetime] NULL
--) ON [PRIMARY]

create procedure Sp_Collect_DISK_Info 
with encryption
as
	 if object_id('tempdb..#drives') is not null
	 drop table #drives;
	 
	 declare @time datetime
	 declare @hr int
	 declare @fso int 
	 declare @drive char(1)
	 declare @odrive int
	 declare @totalsize bigint
	 declare @totalsize_ bigint
	 declare @mb bigint ; set @mb = 1048576
	 declare @freespace int
	 declare @limite decimal
	 declare @cemail varchar(50) 
	 set @cemail = (select @@servername)
	 declare @emailreceiver varchar(50)
	 set @emailreceiver = 'suporte@dataex.com.br'
	 declare @profiler varchar(100)       
     declare @servert varchar(100) 

	 create table #drives (drive char(1) primary key,
	 freespace float null,       
	 totalsize float null,
	 indic int)

-- insert em #drives --------------------------------------------------------
	 
	 insert #drives(drive,freespace)
	 exec master.dbo.xp_fixeddrives
	 
	 exec @hr=sp_OACreate 'scripting.filesystemobject',@fso out
	 if @hr <> 0 exec sp_OAGetErrorInfo @fso

	 declare dcur cursor local fast_forward
	 for select drive from #drives
	 order by drive

	 open dcur

	 fetch next from dcur into @drive

	 while @@fetch_status=0
	 begin
		 exec @hr = sp_OAMethod @fso,'getdrive', @odrive out, @drive
		 if @hr <> 0 exec sp_OAGetErrorInfo @fso
		 exec @hr = sp_OAGetProperty @odrive,'totalsize', @totalsize out
		 if @hr <> 0 exec sp_OAGetErrorInfo @odrive
		 update #drives
		 set totalsize=@totalsize/@mb
		 where drive=@drive
		 fetch next from dcur into @drive
	 end

	 close dcur
	 deallocate dcur

-- zerar coluna [indic] da #drives -------------------------------------------------------------------------------
update #drives set indic = 0

--	select drive,freespace/1024 as [FreeSpace(GB)], totalsize/1024 as [TotalSize (GB)] from #drives

INSERT INTO DBADataEx.dbo.Disk_Space
SELECT	drive,
		ROUND(((freespace)/1024), 2) as [FreeSpace(GB)], 
		ROUND(((totalsize)/1024), 2) as [TotalSize (GB)],
		GETDATE()
FROM #drives

--EXEC DBADataEx.dbo.Sp_Collect_DISK_Info
--SELECT * FROM DBADataEx.dbo.Disk_Space
--TRUNCATE TABLE DBADataEx.dbo.Disk_Space