USE BDFGCSGO

BEGIN TRAN

-- QDT de linhas alteradas = 1
Update bdfgcsgo..TBSGO_ReclassificacaoMensalBacen
set CD_ReclassificacaoMensalBacenStatus = '3'
where ID_ReclassificacaoMensalBacen = '108'

--Antes de efetuar o commit verificar se a quantidade de linhas alteradas � correponte ao resultado
--Caso n�o efetuar rolback e devolver o chamado com o print do resultado.
--commit
--rolback