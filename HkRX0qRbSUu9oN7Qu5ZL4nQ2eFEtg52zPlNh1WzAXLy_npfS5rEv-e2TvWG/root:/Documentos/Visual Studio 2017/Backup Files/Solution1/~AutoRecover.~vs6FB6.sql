SELECT 
    SERVERPROPERTY('MachineName') AS NomeServidor,
    SERVERPROPERTY('ServerName') AS NomeInstancia,
    SERVERPROPERTY('Edition') AS Edicao,
    SERVERPROPERTY('ProductVersion') AS Versao,
    SERVERPROPERTY('EngineEdition') AS TipoInstancia,
    SERVERPROPERTY('IsClustered') AS Clusterizado,
    SERVERPROPERTY('InstanceDefaultDataPath') AS CaminhoDados,
    SERVERPROPERTY('InstanceDefaultLogPath') AS CaminhoLogs;


SELECT @@VERSION