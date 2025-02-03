sp_whoisactive

USE siscoob; -- Substitua pelo nome da base em análise
GO

SELECT
name AS [Nome do Banco de Dados],
recovery_model_desc AS [Modelo de Recuperação],
log_reuse_wait_desc AS [Motivo de Espera de Log]
FROM sys.databases
WHERE name = 'siscoob';