 DECLARE @in_divRegional INT = 0, -- alterado dia 24/06/2016 por Rafael Bertoluci
  @in_hotUF VARCHAR(2) = NULL, 
  @in_hotCidade VARCHAR(50) = NULL, 	   
  @in_hotCodigo int = 0, 	   
  @in_tipCodigo int = 0, 
  @in_tempCodigo int = 0,
  @in_tpPlCodigo int = 0,
  @in_dtinicial DATETIME = '01/01/2025',
  @in_dtfinal DATETIME = '31/01/2025',
  @in_dtValInicial DATETIME = NULL,
  @in_dtValFinal DATETIME = NULL, 
  @in_redCodigo int = 0 ,
  @in_order int = 1,
	@in_SomenteHoteis BIT = 1,     -- Acrescentado filtro Chamado nº 1379 - dia 01/03/2017 Jairo Schell
	@in_hotRegCodigo INT = 0,
	@in_sitCodigo INT = NULL    -- Acrescentado filtro chamado nº 6228 - dia 10/10/2017 Nicodemos


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

 /* AQUI */
select a.*--, 
				/*
				isnull(CASE WHEN a.tpreserva = 1 THEN ((a.diferencaRede)/a.diarias)*a.resqtdediarias              
						  ELSE 0
				 END,0) AS resvlDiferenca,
				 isnull(CASE WHEN a.tpreserva = 2 THEN (a.diferencaHcd/a.diarias)*a.resqtdediarias
						  ELSE 0
				 END,0) AS resvldiferencahcd
				 */
/* ATÉ AQUI */
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
WHERE a.diarias = 0
ORDER BY a.resDthospini