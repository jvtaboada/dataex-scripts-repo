USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_WS_Hoteis_Analise_Tarifaria_C4]    Script Date: 11/03/2025 10:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
##################################################
-------------------------------------
DATA           : 11/06/2019
OBJETIVO       : Analise gerencial criada para popular a tabela [Siscoob].[dbo].[tmp_Hoteis_Analise_Gerencial_Mes]
AUTOR          : Leonardo Lovatto
-------------------------------------
##################################################

*/
ALTER PROCEDURE [dbo].[sp_WS_Hoteis_Analise_Tarifaria_C4]
 (--@in_regCodigo int,
  @in_divRegional INT = 0, -- alterado dia 24/06/2016 por Rafael Bertoluci
  @in_hotUF VARCHAR(2) = NULL, 
  @in_hotCidade VARCHAR(50) = NULL, 	   
  @in_hotCodigo int = 0, 	   
  @in_tipCodigo int = 0, 
  @in_tempCodigo int = 0,
  @in_tpPlCodigo int = 0,
  @in_dtinicial DATETIME = '01/01/2024',
  @in_dtfinal DATETIME = '31/01/2024',
  @in_dtValInicial DATETIME = NULL,
  @in_dtValFinal DATETIME = NULL, 
  @in_redCodigo int = 0 ,
  @in_order int = 1,
	@in_SomenteHoteis BIT = 1,     -- Acrescentado filtro Chamado nº 1379 - dia 01/03/2017 Jairo Schell
	@in_hotRegCodigo INT = 0,
	@in_sitCodigo INT = NULL    -- Acrescentado filtro chamado nº 6228 - dia 10/10/2017 Nicodemos
	)
AS
--EXEC [Siscoob].[dbo].[sp_WS_Hoteis_Analise_Tarifaria_C4] 0,null,null,0,0,0,0,@dataIni,@dataFim,null,null,0,1,1,0,null

-- TESTE DE PROCEDURE

 -- DECLARE @in_divRegional INT-- alterado dia 24/06/2016 por Rafael Bertoluci
 -- DECLARE @in_hotUF VARCHAR(2) 
 -- DECLARE @in_hotCidade VARCHAR(50)  
 -- DECLARE @in_hotCodigo int  
 -- DECLARE @in_tipCodigo int = 0
 -- DECLARE @in_tempCodigo int = 0
 -- DECLARE @in_tpPlCodigo int = 0
 -- DECLARE @in_dtinicial DATETIME   
 -- DECLARE @in_dtfinal DATETIME 
 -- DECLARE @in_dtValInicial DATETIME = NULL
 -- DECLARE @in_dtValFinal DATETIME = NULL 
 -- DECLARE @in_redCodigo INT
 -- --DECLARE @in_ordenacao VARCHAR(50) 
 -- DECLARE @in_order INT
	--DECLARE @in_SomenteHoteis BIT
	--DECLARE @in_regDivCodigo INT
	--DECLARE @in_hotRegCodigo INT = NULL
	--DECLARE @in_sitCodigo INT = NULL

 -- SET @in_divRegional = 0
 -- SET @in_hotUF = null
 -- SET @in_hotCidade = null
 -- SET @in_hotCodigo = 3249
 -- SET @in_dtinicial = '22/01/2017'
 -- SET @in_dtfinal = '22/01/2018' 
 -- SET @in_redCodigo = 0
 -- SET @in_order = 1
 -- SET @in_SomenteHoteis = 0
 -- SET @in_regDivCodigo = 0
  
BEGIN

DECLARE @hotRegCodigo TABLE (ID INT)

IF @in_hotRegCodigo = 1
 INSERT INTO @hotRegCodigo (ID)
 VALUES (1)

IF @in_hotRegCodigo = 2
 INSERT INTO @hotRegCodigo (ID)
 VALUES (2),(3)

IF @in_hotRegCodigo = 3
 INSERT INTO @hotRegCodigo (ID)
 VALUES (4),(5)

----------------------------------------- Verifica a ordernação das ttarifas

--DECLARE @in_ordenacao VARCHAR(100)

--IF @in_order <> 0
--SET @in_ordenacao = ISNULL((SELECT ordDetalhes FROM [tblHoteis_Ordenacao_Tarifaria]
--                           WHERE ordID = @in_order),0)
--ELSE   
--SET @in_ordenacao = (SELECT ordDetalhes FROM [tblHoteis_Ordenacao_Tarifaria]
--                           WHERE ordID = 0)

--SET @in_ordenacao = 'diferenca'

----------------------------------------- cria base de conhecimento

/* AQUI */
  select a.*, 
				 isnull(CASE WHEN a.tpreserva = 1 THEN ((a.diferencaRede)/a.diarias)*a.resqtdediarias              
						  ELSE 0 
						  END, 0) AS resvlDiferenca,
				 isnull(CASE WHEN a.tpreserva = 2 THEN (a.diferencaHcd/a.diarias)*a.resqtdediarias
						  ELSE 0
						  END,0) AS resvldiferencahcd
	INTO   #temp_modelo
	FROM
 (
	SELECT R.hotCodigo,
				 isnull((CASE 
							WHEN (R.resDThospIni <= @in_dtfinal) AND (R.resDThospfim > @in_dtfinal AND (R.resDThospIni = @in_dtfinal)) THEN DATEDIFF(day,R.resDThospIni,DATEADD(DAY,1,@in_dtfinal))
							WHEN (R.resDThospIni >= @in_dtinicial) AND (R.resDThospfim <= @in_dtfinal) THEN DATEDIFF(day,R.resDThospIni,R.resDthospFim)
							WHEN (R.resDThospIni >= @in_dtinicial) AND (R.resDThospfim > @in_dtfinal) THEN DATEDIFF(day,R.resDThospIni,DATEADD(DAY,1,@in_dtfinal))
							WHEN (R.resDThospIni < @in_dtinicial) AND (R.resDThospfim <= @in_dtfinal) THEN DATEDIFF(day,@in_dtinicial,R.resDThospfim)
							WHEN (R.resDThospIni < @in_dtinicial) AND (R.resDThospfim > @in_dtfinal) THEN DATEDIFF(day,@in_dtinicial,@in_dtfinal+1)
				  END) * resvldiaria,0) AS resvltotal,
         --R.resvltotal,
				 isnull(CASE 
							WHEN (R.resDThospIni <= @in_dtfinal) AND (R.resDThospfim > @in_dtfinal) AND (R.resDThospIni = @in_dtfinal) AND (R.tpCodigo in (1,2,3,4,12)) THEN DATEDIFF(day,R.resDThospIni,DATEADD(DAY,1,@in_dtfinal))
							WHEN (R.resDThospIni >= @in_dtinicial) AND (R.resDThospfim <= @in_dtfinal) AND (R.tpCodigo in (1,2,3,4,12)) THEN DATEDIFF(day,R.resDThospIni,R.resDthospFim)
							WHEN (R.resDThospIni >= @in_dtinicial) AND (R.resDThospfim > @in_dtfinal) AND (R.tpCodigo in (1,2,3,4,12)) THEN DATEDIFF(day,R.resDThospIni,DATEADD(DAY,1,@in_dtfinal))
							WHEN (R.resDThospIni < @in_dtinicial) AND (R.resDThospfim <= @in_dtfinal) AND (R.tpCodigo in (1,2,3,4,12)) THEN DATEDIFF(day,@in_dtinicial,R.resDThospfim)
							WHEN (R.resDThospIni < @in_dtinicial) AND (R.resDThospfim > @in_dtfinal) AND (R.tpCodigo in (1,2,3,4,12)) THEN DATEDIFF(day,@in_dtinicial,@in_dtfinal+1)
				 END,0) AS resqtdediarias,
         --R.resqtdediarias,
         --R.resvldiferenca AS resvldiferenca,
				 ISNULL(RO.resPgtoDif_Rede_Gold,0) AS diferencaRede,
				 ISNULL(RO.resPgtoDif_HCD,0) AS diferencaHCD,
         R.resDthospini AS resDthospini,
         R.resDthospfim AS resDthospfim,
         T.tpplcodigo AS cdplano,
				 R.tpCodigo AS tpreserva,
				 isnull(CASE 
						WHEN  r.resLocalizador IS NOT NULL AND r.tpCodigo = 1 THEN 
							ro.resQtdeDiarias
						ELSE 
							r.resQtdediarias 
				 END,0) AS diarias,
				 plFamilia = ISNULL(AP.plFamilia,0) -- Incluído por Rafael Bertoluci (24/08/2017)
  --INTO   #temp_modelo
  FROM   tblHoteis_Reservas R WITH(NOLOCK)
	LEFT	 JOIN tblHoteis_Reservas_OnLine RO WITH(NOLOCK)
	ON		 RO.resLocalizador = R.resLocalizador
  INNER  JOIN tblHoteis H WITH(NOLOCK) 
  ON     H.hotCodigo = R.hotCodigo
  INNER  JOIN tblUFS U  WITH(NOLOCK) 
  ON     H.hotuf = U.ufcodigo
  LEFT   OUTER JOIN tblHoteis_Divisoes_Regionais G  WITH(NOLOCK) -- alterado dia 24/06/2016 por Rafael Bertoluci
  ON     G.divregCodigo = H.divregCodigo -- -- alterado dia 24/06/2016 por Rafael Bertoluci
--LEFT OUTER JOIN tblHoteis_Tipo_Rede r on t.tipCodigo = H.tipCodigo
  LEFT   OUTER JOIN siscoob.dbo.tblAssociados_planos_Tickets T  WITH(NOLOCK) 
  ON     T.tktcodigo = R.tktCodigo 
     --,H.tipCodigo
	LEFT   OUTER JOIN Siscoob.dbo.tblAssociados_Planos AP WITH(NOLOCK) -- Incluído por Rafael Bertoluci (24/08/2017)
	ON     T.tpplCodigo = AP.tpplCodigo
	AND    T.plCodigo = AP.plCodigo
	AND    T.assNic = AP.assNic
  FULL   OUTER JOIN tblHoteis_Redes hrd WITH(NOLOCK)  -- Alterado por Leticia Margarites (16-05-2016) 
  ON     hrd.redCodigo = H.redCodigo
  WHERE  R.hotCodigo = H.hotCodigo 
  AND   (@in_tpPlCodigo = '0' OR @in_tpPlCodigo = T.tpplcodigo)
  
  --  AND   dbo.somentedata(R.resDthospini) BETWEEN dbo.somentedata(@in_dtinicial) AND dbo.somentedata(@in_dtfinal)
  AND   (R.resDthospini BETWEEN @in_dtinicial AND @in_dtfinal OR R.resDThospfim BETWEEN @in_dtinicial AND @in_dtfinal OR R.resDThospini <= @in_dtinicial AND R.resDThospfim >= @in_dtfinal)
  AND    H.hotcodigo NOT IN (SELECT hotcodigo FROM tblhoteis_desativados WITH(NOLOCK) WHERE hotreembolso <> 1 AND hotcodigo not in (4389)) --pelo largo, vip e ilso , adicionado o where 31/01/2018 para aparecer o nacional turismo, 
																																																																					 --colocado o where na tabela de hoteis_desativados conforme Chamado: #8883
  --AND    H.sitCodigo <> 4         -- Tirado dia 01/03/2017 - Chamado nº 1379 (acrescentado o mesmo filtro abaixo)
  AND   (G.divregCodigo = @in_divRegional OR @in_divRegional ='0') -- alterado dia 24/06/2016 por Rafael Bertoluci
  AND   (H.hotuf = @in_hotUF OR @in_hotUF is null)
  AND   (H.hotCidade = @in_hotCidade OR @in_hotCidade is null)
  AND   (H.hotcodigo = @in_hotCodigo OR @in_hotCodigo ='0')
  AND   (H.tipCodigo = @in_tipCodigo OR @in_tipCodigo ='0')
  AND   (hrd.redCodigo = @in_redCodigo OR @in_redCodigo = 0)
  AND    R.tpCodigo not in (10,11,13,14,15,16,17)
	AND   ((@in_SomenteHoteis = 1 AND H.sitcodigo <> 4) OR @in_SomenteHoteis = 0)  -- Acrescentado filtro Chamado nº 1379 - dia 01/03/2017 Jairo Schell
	AND   (ISNULL(@in_hotRegCodigo,0) = 0 OR U.regCodigo in (SELECT * FROM @hotRegCodigo)) -- Incluído por Rafael Bertoluci Chamado 3131 em 17/05/2017
	AND		(ISNULL(@in_sitCodigo,0) = 0 OR H.sitCodigo = @in_sitCodigo)   -- Acrescentado filtro chamado nº 6228 - dia 10/10/2017 Nicodemos
	AND   (@in_tempCodigo = '0' OR (dbo.Fn_Busca_Temporada_Hotel2 (R.resDthospini,R.hotCodigo) = @in_tempCodigo)) 
	)A
-------------------------------------------------------------------------------------
CREATE INDEX [IX_temp_modelo]
ON #temp_modelo (hotCodigo)

CREATE INDEX [IX1_temp_modelo]
ON #temp_modelo (hotCodigo,cdPlano)

-------------------------------------------------------------------------------------
  SELECT HO.hotCodigo,HO.hotNomefantasia,G.divregDescricao,hrd.redNome,HO.hotuf,HO.hotCidade,t.tipDescricao,hrd.redCodigo,GH.gruCodigo, HO.sitCodigo, HO.hotPlanoGo, -- alterado dia 24/06/2016 por Rafael Bertoluci
         -- alta
         ISNULL((SELECT MAX(vigValor) FROM tblHoteis_tarifas_vigentes  WITH(NOLOCK) 
                 WHERE  hotCodigo = HO.hotCodigo
				         AND    tartipcodigo = 2 -- inserido por Rafael Bertoluci 08/06/2016 para trazer valores somente de quartos duplos  
                 AND    tempCodigo = 1 
								 AND   (vigValidade >= GETDATE() OR (SELECT TOP 1 1 FROM tblHoteis WITH(NOLOCK) WHERE sitCodigo <> 1 AND hotCodigo = HO.hotCodigo) = 1)),0) AS alta, -- Inserido por Rafael Bertoluci 19/04/2017
         -- media
         ISNULL((SELECT MAX(vigValor) FROM tblHoteis_tarifas_vigentes  WITH(NOLOCK) 
                 WHERE  hotCodigo = HO.hotCodigo
				         AND    tartipcodigo = 2 -- inserido por Rafael Bertoluci 08/06/2016 para trazer valores somente de quartos duplos 
                 AND    tempCodigo = 2
								 AND   (vigValidade >= GETDATE() OR (SELECT TOP 1 1 FROM tblHoteis WITH(NOLOCK) WHERE sitCodigo <> 1 AND hotCodigo = HO.hotCodigo) = 1)),0) AS media, -- -- Inserido por Rafael Bertoluci 19/04/2017
         -- baixa
         ISNULL((SELECT MAX(vigValor) FROM tblHoteis_tarifas_vigentes  WITH(NOLOCK) 
                 WHERE  hotCodigo = HO.hotCodigo
				         AND    tartipcodigo = 2 -- inserido por Rafael Bertoluci 08/06/2016 para trazer valores somente de quartos duplos 
                 AND    tempCodigo = 3
								 AND   (vigValidade >= GETDATE() OR (SELECT TOP 1 1 FROM tblHoteis WITH(NOLOCK) WHERE sitCodigo <> 1 AND hotCodigo = HO.hotCodigo) = 1)),0) AS baixa, -- -- Inserido por Rafael Bertoluci 19/04/2017
         -- UNICA
         ISNULL((SELECT MAX(vigValor) FROM tblHoteis_tarifas_vigentes  WITH(NOLOCK) 
                 WHERE  hotCodigo = HO.hotCodigo
				         AND    tartipcodigo = 2 -- inserido por Rafael Bertoluci 08/06/2016 para trazer valores somente de quartos duplos 
                 AND    tempCodigo = 4
								 AND   (vigValidade >= GETDATE() OR (SELECT TOP 1 1 FROM tblHoteis WITH(NOLOCK) WHERE sitCodigo <> 1 AND hotCodigo = HO.hotCodigo) = 1)),0) AS unica, -- -- Inserido por Rafael Bertoluci 19/04/2017
		          -- reservas - outros(HCD,Permuta,Adminnistrativa,Diárias Gratis)  inserido por Rafael Bertoluci 08/06/2016 para trazer todas as diárias analisadas
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    tpreserva IN (2,3,4,12)),0) AS qtde_outros,
         -- reservas - vip
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 0								  
                 AND    cdplano IN (1,21,0)),0) AS qtde_vip,
         -- reservas - master
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo 
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano IN (2,22)),0) AS qtde_master,
         -- reservas - gold vip
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 31),0) AS qtde_Goldvip,
         -- reservas - gold master
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 32),0) AS qtde_Goldmaster,
          -- reservas - diamante
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo    -- inserido por Rafael Bertoluci 08/06/2016, verifica diárias plano diamante
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 33),0) AS qtde_Diamante,

----------------------------------
				--Quantidade de diarias no plano familia
			         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1
                 AND    tpreserva IN (2,3,4,12)),0) AS qtde_Outros_Familia,
         -- reservas - vip
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo  -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1 
                 AND    cdplano IN (1,21,0)),0) AS qtde_Vip_Familia,
         -- reservas - master
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo  -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1 
                 AND    cdplano IN (2,22)),0) AS qtde_Master_Familia,
         -- reservas - gold vip
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo  -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1
                 AND    cdplano = 31),0) AS qtde_Goldvip_Familia,
         -- reservas - gold master
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo  -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1
                 AND    cdplano = 32),0) AS qtde_Goldmaster_Familia,
          -- reservas - diamante
         ISNULL((SELECT SUM(resQtdediarias) FROM #temp_modelo  -- Incluído por Rafael Bertoluci (24/08/2017)
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1 
                 AND    cdplano = 33),0) AS qtde_Diamante_Familia,

---------------				 
		  -- valor total 
         ISNULL((SELECT SUM(resvltotal) FROM #temp_modelo 
                 WHERE  hotCodigo = HO.hotCodigo),0) AS Valor_total ,
--                 AND    cdplano IS NOT NULL),0)*1.07 AS Valor_total ,
--------------------------------------------- valor
				 -- reservas - Outros (HCD, Permuta, Administrativa, Cama Extra, Pacote, All Inclusive, Meia Pensão, Pensão Completa)
				 ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferencahcd),0)
								 FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
                 --AND    tpreserva IN (2,3,4,5,6,7,8,9)),0) AS valor_outros,
								 AND    tpreserva IN (4,5,6,7,8,9)),0) AS valor_outros,

				 ISNULL((SELECT (SUM(resvltotal)+ISNULL(SUM(resvldiferencahcd),0)) * 0.85 
								 FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    tpreserva IN (2,3)),0) AS valor_outros2,
         -- reservas - vip valor
         ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo 
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    cdplano IN (1,21)),0) AS valor_vip,
         -- reservas - master valor
         ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    cdplano IN (2,22)),0) AS valor_master,
         -- reservas - gold vip valor
         ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    cdplano = 31),0) AS valor_Goldvip,
         -- reservas - gold master valor
         ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    cdplano = 32),0) AS valor_Goldmaster,
		 -- reservas - diamante valor
         ISNULL((SELECT SUM(resvltotal)+ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo   -- inserido por Rafael Bertoluci 08/06/2016, verifica valor diária plano diamante
                 WHERE  hotCodigo = HO.hotCodigo 
                 AND    cdplano = 33),0) AS valor_Diamante,
----------------------------------
         -- reservas - vip valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 0  
                 AND    cdplano IN (1,21)),0) AS valordif_vip,
         -- reservas - master valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano IN (2,22)),0) AS valordif_master,
         -- reservas - gold vip valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 31),0) AS valordif_Goldvip,
         -- reservas - gold master valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 32),0) AS valordif_Goldmaster,
         -- reservas - diamante valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo  -- inserido por Rafael Bertoluci 08/06/2016, verifica valor diferença diária plano diamante
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 0
                 AND    cdplano = 33),0) AS valordif_Diamante,

 ---------------------------------- Valor de Diferença Planos Familia
         -- reservas - vip valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1 
                 AND    cdplano IN (1,21)),0) AS valordif_vip_Familia,
         -- reservas - master valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 1 
                 AND    cdplano IN (2,22)),0) AS valordif_master_Familia,
         -- reservas - gold vip valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 1 
                 AND    cdplano = 31),0) AS valordif_Goldvip_Familia,
         -- reservas - gold master valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo
                 WHERE  hotCodigo = HO.hotCodigo 
								 AND    plFamilia = 1 
                 AND    cdplano = 32),0) AS valordif_Goldmaster_Familia,
         -- reservas - diamante valor
         ISNULL((SELECT ISNULL(SUM(resvldiferenca),0) FROM #temp_modelo  -- inserido por Rafael Bertoluci 08/06/2016, verifica valor diferença diária plano diamante
                 WHERE  hotCodigo = HO.hotCodigo
								 AND    plFamilia = 1  
                 AND    cdplano = 33),0) AS valordif_Diamante_Familia,
		 (SELECT max(tarValidade) 
              FROM   tblHoteis_Tarifas WHERE  hotCodigo = Ho.hotCodigo) as validade

  INTO   #temp
  FROM   tblHoteis HO WITH(NOLOCK) 
  INNER  JOIN tblUFS U 
  ON     HO.hotuf = U.ufcodigo
  LEFT   OUTER JOIN tblHoteis_Divisoes_Regionais G -- alterado dia 24/06/2016 por Rafael Bertoluci
  ON     G.divregCodigo = HO.divregCodigo -- alterado dia 24/06/2016 por Rafael Bertoluci
	LEFT   OUTER JOIN tblHoteis_Grupos_Hoteis GH
  ON     HO.hotCodigo= GH.hotCodigo
  LEFT   OUTER JOIN tblHoteis_Tipo_Rede T 
  ON     T.tipCodigo = HO.tipCodigo
  FULL OUTER JOIN tblHoteis_Redes hrd WITH(NOLOCK)  -- Alterado por Leticia Margarites (16-05-2016)  -- 
  ON    hrd.redCodigo = HO.redCodigo
  WHERE  HO.hotcodigo NOT IN (SELECT hotcodigo FROM tblhoteis_desativados WITH(NOLOCK) WHERE hotreembolso <> 1 AND hotcodigo not in (4389)) --pelo largo, vip e ilso, adicionado o where 31/01/2018 para aparecer o nacional turismo
																																																																													 --colocado o where na tabela de hoteis_desativados conforme Chamado: #8883
  --AND   (HO.sitCodigo <> 4)  -- Tirado dia 01/03/2017 - Chamado nº 1379 (acrescentado o mesmo filtro abaixo)
  AND   (G.divregCodigo = @in_divRegional OR @in_divRegional ='0') -- alterado dia 24/06/2016 por Rafael Bertoluci
  AND   (HO.hotuf = @in_hotUF OR @in_hotUF is null)
  AND   (HO.hotCidade = @in_hotCidade OR @in_hotCidade is null)
  AND   (HO.hotcodigo = @in_hotCodigo OR @in_hotCodigo ='0')
  AND   (HO.tipCodigo = @in_tipCodigo OR @in_tipCodigo ='0')
  AND   (hrd.redCodigo = @in_redCodigo OR @in_redCodigo = 0)
	AND   ((@in_SomenteHoteis = 1 AND HO.sitcodigo <> 4) OR @in_SomenteHoteis = 0)  -- Acrescentado filtro Chamado nº 1379 - dia 01/03/2017 Jairo Schell
	AND		(ISNULL(@in_sitCodigo,0) = 0 OR HO.sitCodigo = @in_sitCodigo)   -- Acrescentado filtro chamado nº 6228 - dia 10/10/2017 Nicodemos
END

DECLARE @mesref AS VARCHAR(7)
DECLARE @mes AS INT
DECLARE @mens_vip MONEY
DECLARE @mens_master MONEY
DECLARE @mens_goldVip MONEY
DECLARE @mens_GoldMaster MONEY
DECLARE @mens_Diamante MONEY

-- Variáveis para calcular planos familia
-- Incluído por Rafael Bertoluci (24/08/2017)
DECLARE @mens_vip_familia MONEY
DECLARE @mens_master_familia MONEY
DECLARE @mens_goldVip_familia MONEY
DECLARE @mens_GoldMaster_familia MONEY
DECLARE @mens_Diamante_familia MONEY

--calcula valor da mensalidade. Tirei 15 %  **Lucro da empresa**
--SET @mens_vip = dbo.fn_Calcula_Valor_Mensalidade(@in_dtinicial,@in_dtinicial+1,2,21)*0.85
--SET @mens_master = dbo.fn_Calcula_Valor_Mensalidade(@in_dtinicial,@in_dtinicial+1,2,22)*0.85
--SET @mens_goldVip =dbo.fn_Calcula_Valor_Mensalidade(@in_dtinicial,@in_dtinicial+1,2,31)*0.85
--SET @mens_GoldMaster =dbo.fn_Calcula_Valor_Mensalidade(@in_dtinicial,@in_dtinicial+1,2,32)*0.85
SET @mens_vip = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,21,7,0),0)*0.85
SET @mens_master = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,22,7,0),0)*0.85
SET @mens_goldVip =isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,31,7,0),0)*0.85
SET @mens_GoldMaster =isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,32,7,0),0)*0.85
SET @mens_Diamante =isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,33,7,0),0)*0.85

-- Valores para as variáveis planos familia
-- Incluído por Rafael Bertoluci (24/08/2017)
SET @mens_vip_familia = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,21,7,1),0)*0.85
SET @mens_master_familia = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,22,7,1),0)*0.85
SET @mens_goldVip_familia = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,31,7,1),0)*0.85
SET @mens_GoldMaster_familia = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,32,7,1),0)*0.85
SET @mens_Diamante_familia = isnull(dbo.fn_Calcula_Valor_Mensalidade(GETDATE(),GETDATE()+1,2,33,7,1),0)*0.85





SET @mes = MONTH(@in_dtinicial)

IF @mes >= 10 
  SET @mesref = CAST(YEAR(@in_dtinicial) AS VARCHAR(4))+'/'+CAST(@mes AS VARCHAR(2)) 
ELSE
  SET @mesref = CAST(YEAR(@in_dtinicial) AS VARCHAR(4))+'/0'+CAST(@mes AS VARCHAR(1)) 

----------------calcula mp de cada plano
SELECT *, 
       --média ponderada pela arrecadação - vip
--      (qtde_vip * (((12 * (SELECT vlrtm FROM bdcoobras.dbo.Associados_Planos_Mensalidades_Tipos_Valor
--                           WHERE  cdplano = 21 
--                           AND    mesref = @mesref)) /7)*1.07))+valordif_vip AS media_vip,
     
	 --(qtde_vip * (((12 * @mens_vip) /7)*1.07))+valordif_vip AS media_vip,
	 isnull((qtde_vip * ((12 * @mens_vip) /7))+valordif_vip,0) AS media_vip,
      

	  ----média ponderada pela arrecadação - master
   --   (qtde_master * (((12 * @mens_master) /7)*1.07))+valordif_master AS media_master, 
   --    --média ponderada pela arrecadação - gold vip
   --   (qtde_goldvip * (((12 * @mens_goldvip) /7)*1.07))+valordif_goldvip AS media_goldvip, 
   --    --média ponderada pela arrecadação - gold master
   --   (qtde_goldmaster * (((12 * @mens_goldmaster) /7)*1.07))+valordif_goldmaster AS media_goldmaster,
	  -- --média ponderada pela arrecadação - diamante
   --   (qtde_goldmaster * (((12 * @mens_Diamante) /7)*1.07))+valordif_Diamante AS media_diamante

	 --média ponderada pela arrecadação - master
      isnull((qtde_master * ((12 * @mens_master) /7))+valordif_master,0) AS media_master, 
       --média ponderada pela arrecadação - gold vip
      isnull((qtde_goldvip * ((12 * @mens_goldvip) /7))+valordif_goldvip,0) AS media_goldvip, 
       --média ponderada pela arrecadação - gold master
      isnull((qtde_goldmaster * ((12 * @mens_goldmaster) /7))+valordif_goldmaster,0) AS media_goldmaster,
	   --média ponderada pela arrecadação - diamante
      isnull((qtde_Diamante * ((12 * @mens_Diamante) /7))+valordif_Diamante,0) AS media_diamante,
 

 -- Incluído por Rafael Bertoluci (24/08/2017)
 			 --média ponderada pela arrecadação - vip_Familia
	    isnull((qtde_Vip_Familia * ((12 * @mens_vip_Familia) /7))+valordif_vip_Familia,0) AS media_vip_Familia,
	    --média ponderada pela arrecadação - master_Familia
      isnull((qtde_Master_Familia * ((12 * @mens_master_Familia) /7))+valordif_master_Familia,0) AS media_master_Familia, 
       --média ponderada pela arrecadação - gold vip_Familia
      isnull((qtde_goldvip_Familia * ((12 * @mens_goldvip_Familia) /7))+valordif_goldvip_Familia,0) AS media_goldvip_Familia, 
       --média ponderada pela arrecadação - gold master_Familia
      isnull((qtde_goldmaster_Familia * ((12 * @mens_goldmaster_Familia) /7))+valordif_goldmaster_Familia,0) AS media_goldmaster_Familia,
	     --média ponderada pela arrecadação - diamante_Familia
      isnull((qtde_Diamante_Familia * ((12 * @mens_Diamante_Familia) /7))+valordif_Diamante_Familia,0) AS media_diamante_Familia
					
INTO   #temp2
FROM   #temp
WHERE (validade BETWEEN @in_dtValInicial AND @in_dtValFinal+' 23:59:59' OR @in_dtValInicial IS NULL)

DECLARE @valor_Total MONEY
DECLARE @perc_Total FLOAT
SET @valor_Total = isnull((SELECT ISNULL(SUM(valor_total),0) FROM #temp2),0)
--SET @perc_Total = (SELECT (SUM(ISNULL(qtde_outros,0))+SUM(ISNULL(qtde_vip,0))+SUM(ISNULL(qtde_master,0))+SUM(ISNULL(qtde_goldvip,0))+SUM(ISNULL(qtde_goldmaster,0))+SUM(ISNULL(qtde_Diamante,0))) FROM #temp2)

--Alterada para calcular quantidade de planos familia junto com os normais 
SET @perc_Total = isnull((SELECT (SUM(ISNULL(qtde_outros,0))+SUM(ISNULL(qtde_outros_Familia,0))+SUM(ISNULL(qtde_vip,0))+SUM(ISNULL(qtde_Vip_Familia,0))+SUM(ISNULL(qtde_master,0))+SUM(ISNULL(qtde_Master_Familia,0))+SUM(ISNULL(qtde_goldvip,0))+SUM(ISNULL(qtde_Goldvip_Familia,0))+SUM(ISNULL(qtde_goldmaster,0))+SUM(ISNULL(qtde_Goldmaster_Familia,0))+SUM(ISNULL(qtde_Diamante,0))+SUM(ISNULL(qtde_Diamante_Familia,0))) FROM #temp2),'0.00')

----------------calcula mp 
SELECT *, --valor_total/(qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante) AS media_g,
	     			--CASE	WHEN (qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante) = 0 THEN 0
						--ELSE valor_total/(qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)
				
						--Alterado para Calcular junto as quantidades com plano Familia
						-- Incluído por Rafael Bertoluci (24/08/2017)
	     			isnull(CASE	WHEN ((qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia)) = 0 THEN 0
						ELSE valor_total/((qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia))
						END,0) AS media_g,
			 
			 
			 
			 --perc_utilizacao = CONVERT(FLOAT,(((qtde_outros+qtde_vip+qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)*100)/@perc_Total)),--(valor_total/@valor_total)*100, -- Alterado por Rafael Bertoluci Chamado 2950 em 17/05/2017
		   --perc_utilizacao = (Valor_total/(qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)),

			 -- Alterado para calcular os valores de planos Familia em conjunto
			 -- Incluído por Rafael Bertoluci (24/08/2017)
			 perc_utilizacao = isnull(CONVERT(FLOAT,((((qtde_outros+qtde_vip+qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia))*100)/@perc_Total)),0),

       --mp_arrec = CASE WHEN (qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante) = 0 THEN 0
       --                ELSE ((valor_outros+media_vip+media_master+media_goldvip+media_goldmaster+media_diamante) / (qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante))
       --                END, (qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante) AS TotalDiarias INTO #temp3

			 -- Alterado para calcular os valores de planos Familia em conjunto
			 -- Incluído por Rafael Bertoluci (24/08/2017)
			  mp_arrec = isnull(CASE WHEN ((qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia)) = 0 THEN 0
                   ELSE (((valor_outros+valor_outros2+media_vip+media_master+media_goldvip+media_goldmaster+media_diamante)+(media_vip_Familia+media_master_Familia+media_goldvip_Familia+media_goldmaster_Familia+media_diamante_Familia)) / ((qtde_outros+qtde_vip +qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia)))
                   END,0), 
			  TotalDiarias = isnull(((qtde_outros+qtde_vip+qtde_master+qtde_goldvip+qtde_goldmaster+qtde_Diamante)+(qtde_outros_Familia+qtde_vip_Familia+qtde_master_Familia+qtde_goldvip_Familia+qtde_goldmaster_Familia+qtde_Diamante_Familia)),0)
INTO #temp3
FROM   #temp2
WHERE  Valor_total > 0


IF @in_dtValInicial IS NOT NULL
BEGIN
	SELECT hotCodigo,
				 hotNomefantasia,
				 divregDescricao,
				 redNome,
				 hotuf,
				 hotCidade,
				 tipDescricao,
				 redCodigo,
				 gruCodigo,
				 sitCodigo,
				 alta,
				 media,
				 baixa,
				 unica,
				 qtde_outros = (qtde_outros+qtde_Outros_Familia),
				 qtde_vip = (qtde_vip+qtde_vip_Familia),
				 qtde_master = (qtde_master+qtde_master_Familia),
				 qtde_Goldvip = (qtde_Goldvip+qtde_Goldvip_Familia),
				 qtde_Goldmaster = (qtde_Goldmaster+qtde_Goldmaster_Familia),
				 qtde_Diamante = (qtde_Diamante+qtde_Diamante_Familia),
				 qtde_Outros_Familia,
				 qtde_Vip_Familia,
				 qtde_Master_Familia,
				 qtde_Goldvip_Familia,
				 qtde_Goldmaster_Familia,
				 qtde_Diamante_Familia,
				 Valor_total,
				 valor_outros = valor_outros + valor_outros2,
				 valor_vip,
				 valor_master,
				 valor_Goldvip,
				 valor_Goldmaster,
				 valor_Diamante,
				 valordif_vip,
				 valordif_master,
				 valordif_Goldvip,
				 valordif_Goldmaster,
				 valordif_Diamante,
				 validade,
				 media_vip,
				 media_master,
				 media_goldvip,
				 media_goldmaster,
				 media_diamante,
				 media_vip_Familia,
				 media_master_Familia,
				 media_goldvip_Familia,
				 media_goldmaster_Familia,
				 media_diamante_Familia,
				 media_g,
				 perc_utilizacao,
				 mp_arrec,
				 TotalDiarias,
	       (mp_arrec-media_g) AS diferenca,
				 hotPlanoGo,
				 ano = YEAR(@in_dtinicial),
				 mes = MONTH(@in_dtinicial)
	FROM   #temp3
	ORDER  BY TotalDiarias DESC

END 

ELSE 
BEGIN



	SELECT hotCodigo,
				 hotNomefantasia,
				 divregDescricao,
				 redNome,
				 hotuf,
				 hotCidade,
				 tipDescricao,
				 redCodigo,
				 gruCodigo,
				 sitCodigo,
				 alta,
				 media,
				 baixa,
				 unica,
				 qtde_outros = (qtde_outros+qtde_Outros_Familia),
				 qtde_vip = (qtde_vip+qtde_vip_Familia),
				 qtde_master = (qtde_master+qtde_master_Familia),
				 qtde_Goldvip = (qtde_Goldvip+qtde_Goldvip_Familia),
				 qtde_Goldmaster = (qtde_Goldmaster+qtde_Goldmaster_Familia),
				 qtde_Diamante = (qtde_Diamante+qtde_Diamante_Familia),
				 qtde_Outros_Familia,
				 qtde_Vip_Familia,
				 qtde_Master_Familia,
				 qtde_Goldvip_Familia,
				 qtde_Goldmaster_Familia,
				 qtde_Diamante_Familia,
				 Valor_total,
				 valor_outros = valor_outros + valor_outros2,
				 valor_vip,
				 valor_master,
				 valor_Goldvip,
				 valor_Goldmaster,
				 valor_Diamante,
				 valordif_vip,
				 valordif_master,
				 valordif_Goldvip,
				 valordif_Goldmaster,
				 valordif_Diamante,
				 validade,
				 media_vip,
				 media_master,
				 media_goldvip,
				 media_goldmaster,
				 media_diamante,
				 media_vip_Familia,
				 media_master_Familia,
				 media_goldvip_Familia,
				 media_goldmaster_Familia,
				 media_diamante_Familia,
				 media_g,
				 perc_utilizacao,
				 mp_arrec,
				 TotalDiarias,
	       (mp_arrec-media_g) AS diferenca,
				 tempCodigo = @in_tempCodigo,
				 hotPlanoGo,
				 ano = YEAR(@in_dtinicial),
				 mes = MONTH(@in_dtinicial)
	FROM   #temp3
	ORDER  BY TotalDiarias DESC

END

--SELECT TOP 1 * FROM #temp
--SELECT TOP 1 * FROM #temp2
--SELECT TOP 100 * FROM #temp3
--SELECT * FROM #temp_modelo


DROP TABLE #temp
DROP TABLE #temp2
DROP TABLE #temp3
DROP TABLE #temp_modelo