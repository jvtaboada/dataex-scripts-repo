sp_whoisactive

select top 1000 *
from DBADataEX.dbo.dtx_tb_Queries_Profile
--where TextData like 'update%'
where HostName = 'ASCSRV-TS-SAP01'
order by StartTime desc

--Bloqueio 15h30 - 15h50
hostname fica como o ts: ASCSRV-TS-SAP01
consulta consegui: update jdt1 set profitcode = @Centro where BaseRef =@list_of_cols_val_tab_del and ShortName (...)

--Bloqueio 15h50 - 16h
hostanem também fica como o TS: ASCSRV-TS-SAP01
consulta fica como: update jdt1 set OcrCode2 = @Unidadenegocios where BaseRef =@list_of_cols_val_tab_del and ShortN