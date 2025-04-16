--SELECT *
--INTO TBSGO_ReclassificacaoMensalBacen_BKP20250416_GMUD4830
--FROM TBSGO_ReclassificacaoMensalBacen;

-- nomenclatura GMUD: BKP20250416_GMUD4830


Use BDFGCSGO

begin tran


-- QDT de linhas alteradas = 1
Update bdfgcsgo..TBSGO_ReclassificacaoMensalBacen
set CD_ReclassificacaoMensalBacenStatus = '3'
where ID_ReclassificacaoMensalBacen = '108'

SELECT CD_ReclassificacaoMensalBacenStatus 
FROM bdfgcsgo..TBSGO_ReclassificacaoMensalBacen
where ID_ReclassificacaoMensalBacen = '108';

 

--Antes de efetuar o commit verificar se a quantidade de linhas alteradas é correponte ao resultado
--Caso não efetuar rolback e devolver o chamado com o print do resultado.
--commit
--rolback
