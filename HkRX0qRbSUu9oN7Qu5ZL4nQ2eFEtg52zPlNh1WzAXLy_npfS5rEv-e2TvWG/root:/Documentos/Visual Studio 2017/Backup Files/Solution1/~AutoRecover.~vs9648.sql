sp_whoisactive

select top 1000 *
from DBADataEX.dbo.dtx_tb_Queries_Profile
--where TextData like 'update jdt1 set profitcode%'
order by StartTime desc

--Bloqueio 15h30 - 15h50


--Bloqueio 15h50 - 16h