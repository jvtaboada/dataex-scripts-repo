sp_whoisactive

select top 1000 *
from DBADataEX.dbo.dtx_tb_Queries_Profile
--where TextData like 'update%'
where HostName = 'ASCSRV-TS-SAP01'
order by StartTime desc

--Bloqueio 15h30 - 15h50
hostname fica como o ts: ASCSRV-TS-SAP01
consulta consegui: update jdt1 set profitcode = @Centro where BaseRef =@list_of_cols_val_tab_del and ShortName (...)
EXECUTE SBO_SP_TransactionNotification N'13',N'U',1,N'DocEntry',N'159790'

@object_type nvarchar(20) = 13,        -- SBO Object Type
@transaction_type nchar(1) = UPDATE,     -- [A]dd, [U]pdate, [D]elete, [C]ancel, C[L]ose
@num_of_cols_in_key int = 1,
@list_of_key_cols_tab_del = DocEntry nvarchar(255),
@list_of_cols_val_tab_del = 159790 nvarchar(255)

--Bloqueio 15h50 - 16h
hostanem tamb�m fica como o TS: ASCSRV-TS-SAP01
consulta fica como: update jdt1 set OcrCode2 = @Unidadenegocios where BaseRef =@list_of_cols_val_tab_del and ShortN
EXECUTE SBO_SP_TransactionNotification N'13',N'U',1,N'DocEntry',N'162371'
