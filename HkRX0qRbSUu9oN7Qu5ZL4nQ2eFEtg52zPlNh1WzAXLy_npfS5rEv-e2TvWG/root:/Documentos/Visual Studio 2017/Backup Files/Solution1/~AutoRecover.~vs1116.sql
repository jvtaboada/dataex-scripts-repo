-- PROCURANDO JOBS
SELECT j.name 
  FROM msdb.dbo.sysjobs AS j
  WHERE EXISTS 
  (
    SELECT 1 FROM msdb.dbo.sysjobsteps AS s
      WHERE s.job_id = j.job_id
      AND s.command LIKE '%dtx_sp_Alert_Index_Fragmentation%'
  );

  -- FILTRAR ULTIMAS MANUTENCOES
  select * from dtx_tb_Queries_Profile
  WHERE StartTime >= '2025-01-01 00:00:00.000'
  AND TextData like '%REBUILD%'
  AND TextData like '%REORGANIZE%'
  