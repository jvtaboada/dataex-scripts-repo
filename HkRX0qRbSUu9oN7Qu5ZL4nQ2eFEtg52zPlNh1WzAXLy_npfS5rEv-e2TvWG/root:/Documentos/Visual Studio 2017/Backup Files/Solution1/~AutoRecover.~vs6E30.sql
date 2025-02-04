use bdtarefas
sp_helptext sp_Monitor_CA

  
/*  
##############################################################  
SISTEMA  : Siscoob  
OBJETIVO : Monitor Sistema de Tarefas Central de Atendimento  
AUTOR    : Rafael Bertoluci  
DATA     : 19/10/2017  
-------------------------------------------------------------  
SISTEMA        : Sic - Central de Atendimento - Intenção de Cancelamento  
OBJETIVO       : Ajuste do monitor para em dias Não  
AUTOR          : João Hermógenes  
DATA ALTERACAO : 10/09/2020  
--------------------------------------------------------------  
##############################################################  
  
EXEC [dbo].[sp_Monitor_CA]  
  
*/  
  
CREATE PROCEDURE [dbo].[sp_Monitor_CA]  
  
AS  
BEGIN  
  
 DECLARE @dataMesInicial DATETIME  
 DECLARE @dataMesFinal DATETIME  
 DECLARE @data_atual DATETIME  
 DECLARE @mes_Atual VARCHAR(2)  
 DECLARE @ano_Atual VARCHAR(4)  
   
 SET @data_atual = GETDATE()  
  
 SET @mes_Atual = SUBSTRING(CONVERT(VARCHAR(10),@data_atual,103),4,2)  
  
 SET @ano_Atual = SUBSTRING(CONVERT(VARCHAR(10),@data_atual,103),7,4)  
  
 SET @dataMesInicial = '01/'+@mes_Atual+'/'+@ano_Atual+' 00:00:00'  
   
 SET @dataMesFinal = CONVERT(VARCHAR(10),EOMONTH(@data_Atual,0),103)+' 23:59:59'  
   
 --SELECT @data_atual,@mes_Atual,@ano_Atual,@dataMesInicial,@dataMesFinal   
  
 --IF DATEPART(DAY,@data_atual) <= 25 AND DATEPART(MONTH,@data_atual) = 11 AND DATEPART(YEAR,@data_atual) = 2017  
 --  BEGIN  
  
 --   SET @dataMesInicial = '27/10/2017'  
  
 --   SET @dataMesFinal = '25/11/2017'  
  
 --  END  
 -- ELSE  
 --  BEGIN  
      
 --   IF DATEPART(DAY,@data_atual) IN (26,27,28,29,30,31)  
 --    SET @dataMesInicial = '26/'+SUBSTRING(CONVERT(VARCHAR(10),DATEPART(MONTH,@data_atual)+100),2,2)+'/'+CONVERT(VARCHAR(10),DATEPART(YEAR,@data_atual))  
 --   ELSE  
 --    SET @dataMesInicial = '26/'+SUBSTRING(CONVERT(VARCHAR(10),DATEPART(MONTH,DATEADD(MONTH,-1,@data_atual))+100),2,2)+'/'+CONVERT(VARCHAR(10),DATEPART(YEAR,@data_atual))  
  
     
 --   IF DATEPART(MONTH,@data_atual) = 1 AND DATEPART(DAY,@data_atual) <= 25   
 --    SET @dataMesInicial = DATEADD(YEAR,-1,@dataMesInicial)  
  
  
 --   IF DATEPART(DAY,@data_atual) IN (26,27,28,29,30,31)  
 --    SET @dataMesFinal = '25/'+SUBSTRING(CONVERT(VARCHAR(10),DATEPART(MONTH,DATEADD(MONTH,1,@data_atual))+100),2,2)+'/'+CONVERT(VARCHAR(10),DATEPART(YEAR,@data_atual))  
 --   ELSE  
 --    SET @dataMesFinal = '25/'+CONVERT(VARCHAR(10),DATEPART(MONTH,@data_atual))+'/'+CONVERT(VARCHAR(10),DATEPART(YEAR,@data_atual))  
  
     
 --   IF DATEPART(MONTH,@data_atual) = 12 AND DATEPART(DAY,@data_atual) in (26,27,28,29,30,31)  
 --    SET @dataMesFinal = DATEADD(YEAR,1,@dataMesFinal)  
  
 --  END  
  
 -- variáveis do dia, 1° Contato  
 DECLARE @IntCancDia_Recebidos DECIMAL(18,0)  
 DECLARE @IntCancDia_Revertidos DECIMAL(18,0)  
 DECLARE @IntCancDia_Porcentagem DECIMAL(18,2)  
 DECLARE @IntCancDia_NaoRevertidos DECIMAL(18,0)  
 DECLARE @IntCancDia_ME DECIMAL(18,0)  
 DECLARE @IntCancDia_Argumentacao DECIMAL(18,0)  
  
 -- variáveis do mês, 1° Contato  
 DECLARE @IntCancDia_AcuMes_Recebidos DECIMAL(18,0)  
 DECLARE @IntCancDia_AcuMes_Revertidos DECIMAL(18,0)  
 DECLARE @IntCancDia_AcuMes_Porcentagem DECIMAL(18,2)  
 DECLARE @IntCancDia_AcuMes_NaoRevertidos DECIMAL(18,0)   
 DECLARE @IntCancDia_AcuMes_ME DECIMAL(18,0)  
 DECLARE @IntCancDia_AcuMes_Argumentacao DECIMAL(18,0)  
 DECLARE @IntCancDia_AcuMes_Certificacoes DECIMAL(18,0)  
  
   
 CREATE TABLE #tempTarefas (etaCodigo INT  
         ,etaTarCodigo VARCHAR(30)  
         ,nomeAssociado VARCHAR(500)  
         ,tarCodigo INT  
         ,tarDescricao VARCHAR(MAX)   
         ,tpDescricao VARCHAR(500)   
         ,deptoDescricao VARCHAR(500)   
         ,para VARCHAR(500)  
         ,etapa VARCHAR(5)  
         ,etaDescricao VARCHAR(MAX)  
         ,prazo VARCHAR(1000)   
         ,COR VARCHAR(100)   
         ,editar INT  
         ,troca_usuario INT  
         ,OrderTemo INT  
         ,OrderCor INT)  
  
 -- Intenção de Cancelamento do dia, 1° Contato  
  SELECT @IntCancDia_Recebidos = SUM(A.IntCancDia_Recebidos)   
  FROM (  
  SELECT IntCancDia_Recebidos = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE (AR.itensCodigo IN (107,195,206) OR itensCodigo = 196   
  AND NOT EXISTS(SELECT APSTT.plCodigo   
                 FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
        WHERE APSTT.assNic = AR.assNic  
        AND   APSTT.plCodigo = ARP.plCodigo  
        AND   APSTT.tpPlCodigo = ARP.tpplCodigo  
        AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
        AND   CONVERT(VARCHAR(6),AR.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal))  
  AND   (SELECT COUNT(R.reCodigo)   
      FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
    INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
    ON P.recodigo = R.recodigo   
    WHERE R.assnic = AR.assnic   
    AND P.plcodigo = ARP.plcodigo  
    AND R.redatageracao > AR.redatageracao   
    AND R.itensCodigo IN (195,196)  
    AND P.tpplCodigo < 1000) = 0  
  AND   U.deptoCodigo = 10  
  AND   AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND   (APCD.canCodigo NOT IN (5,56)  OR APCD.canCodigo IS NULL)  
  AND   DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND   DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND   DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE()))A  
  
  
  SELECT @IntCancDia_Revertidos = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE --(AR.itensCodigo IN (195,196))-- OR AR.itensCodigo = 196 --AND (SELECT sitCodigo FROM siscoob.dbo.tblAssociados_Planos WITH(NOLOCK)  
                                                      --     WHERE assnic = AR.assNic  
                            --   AND plCodigo = ARP.plCodigo  
                           --    AND tpplCodigo = ARP.tpPlCodigo) <> 11)  
  --AND   SUBSTRING(AR.reSolicitacao,CHARINDEX('REVERTIDO:',AR.reSolicitacao)+11,1)='S'  
  (AR.itensCodigo = 195 AND (APST.susData IS NULL OR APST.susDataConclusao IS NOT NULL)   
  AND (SELECT COUNT(R.reCodigo)   
   FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
   ON P.recodigo = R.recodigo   
   WHERE R.assnic = AR.assnic   
   AND P.plcodigo = ARP.plcodigo  
   AND R.redatageracao > AR.redatageracao   
   AND R.itensCodigo IN (195,196)  
   AND P.tpplCodigo < 1000) = 0  
   OR AR.itensCodigo = 196 AND (APCD.cancData IS NULL OR APCD.cancDataConclusao IS NOT NULL)   
   AND (SELECT COUNT(R.reCodigo)   
    FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
    INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
    ON P.recodigo = R.recodigo   
    WHERE R.assnic = AR.assnic   
    AND P.plcodigo = ARP.plcodigo  
    AND R.redatageracao > AR.redatageracao   
    AND R.itensCodigo IN (195,196)  
    AND P.tpplCodigo < 1000) = 0  
   AND NOT EXISTS(SELECT APSTT.plCodigo   
         FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
         WHERE APSTT.assNic = AR.assNic  
         AND   APSTT.plCodigo = ARP.plCodigo  
         AND   APSTT.tpPlCodigo = ARP.tpplCodigo  
         AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
         AND   CONVERT(VARCHAR(6),AR.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal))  
  AND AR.reSolicitacao LIKE '%REVERTIDO: SIM%'  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  --AND   APCD.cancData IS NULL  
  --AND   APST.susData IS NULL   
  AND   DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND   DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND   DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  
  IF @IntCancDia_Revertidos > 0  
   SELECT @IntCancDia_Porcentagem = ((@IntCancDia_Revertidos*100)/(@IntCancDia_Recebidos))  
  ELSE   
   SELECT @IntCancDia_Porcentagem = 0  
  
  SELECT @IntCancDia_NaoRevertidos = (@IntCancDia_Recebidos-@IntCancDia_Revertidos)  
  
  SELECT @IntCancDia_ME = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  AND   APCD.cancCodigo = (SELECT TOP 1 cancCodigo FROM [Siscoob].[dbo].[tblAssociados_Planos_Cancelamentos_Definitivos] WITH(NOLOCK)  
         WHERE assnic = APCD.assnic  
           AND   tpPlCodigo = APCD.tpplCodigo  
           AND   plCodigo = APCD.plCodigo  
           ORDER BY 1 DESC)  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   AND   APST.susCodigo = (SELECT TOP 1 susCodigo FROM [Siscoob].[dbo].[tblAssociados_Planos_Suspensoes_Temporarias] WITH(NOLOCK)  
                            WHERE assnic = APST.assnic  
          AND   tpPlCodigo = APST.tpplCodigo  
          AND   plCodigo = APST.plCodigo  
          ORDER BY 1 DESC)  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND ((AR.itensCodigo = 188 AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
                                      INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK) ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  AND (((APCD.cancCodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL) OR APCD.cancCodigo IS NULL)  
        OR   ((APST.susCodigo IS NOT NULL OR APST.susdataconclusao IS NOT NULL) OR APST.susCodigo IS NULL)))  
  OR AR.itensCodigo = 207 AND (APCD.cancCodigo IS NULL OR DATEADD(MINUTE,5,APCD.cancDataConclusao) < AR.reDatageracao))  
  
  --WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  --AND U.deptoCodigo = 10  
  --  -- Alterado dia 13/3/2018 - Jairo/Rafael  
  ----AND APCD.assnic IS NULL  
  ----AND APST.assNic IS NULL  
  --  AND   (((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL) OR APCD.cancodigo IS NULL)  
  --         OR   ((APST.susCodigo IS NOT NULL OR APST.susdataconclusao IS NOT NULL) OR APST.susCodigo IS NULL))  
  --  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  --AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  --AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  --AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --          ON A.reCodigo = B.reCodigo  
  --          WHERE A.assNic = AR.assNic  
  --          AND   B.plCodigo = ARP.plCodigo  
  --          AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --          AND   A.itensCodigo IN (195,196)  
  --          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
    
  
  SELECT @IntCancDia_Argumentacao = ((@IntCancDia_Revertidos) - (@IntCancDia_ME))  
  
  IF @IntCancDia_Argumentacao < 0  
   SET @IntCancDia_Argumentacao = 0  
  
  
 /*#####################################################################################################################*/    
  -- Intenção de Cancelamento do mês, 1° contato   
  SELECT @IntCancDia_AcuMes_Recebidos = SUM(A.IntCancMes_Recebidos) FROM (  
  SELECT IntCancMes_Recebidos = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE (AR.itensCodigo IN (107,195,206) OR itensCodigo = 196   
  AND NOT EXISTS(SELECT APSTT.plCodigo   
      FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
      WHERE APSTT.assNic = AR.assNic  
      AND   APSTT.plCodigo = ARP.plCodigo  
      AND   APSTT.tpPlCodigo = ARP.tpplCodigo  
      AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
      AND   CONVERT(VARCHAR(6),AR.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal))  
  AND   (SELECT COUNT(R.reCodigo)   
    FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
    INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
    ON P.recodigo = R.recodigo   
    WHERE R.assnic = AR.assnic   
    AND P.plcodigo = ARP.plcodigo  
    AND R.redatageracao > AR.redatageracao   
    AND R.itensCodigo IN (195,196)  
    AND P.tpplCodigo < 1000) = 0  
    AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
    AND   U.deptoCodigo = 10  
    AND   AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    AND  (APCD.canCodigo NOT IN (5,56)  OR APCD.canCodigo IS NULL))A  
  
  
  SELECT @IntCancDia_AcuMes_Revertidos = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE --(AR.itensCodigo IN (195,196))-- OR AR.itensCodigo = 196 AND (SELECT sitCodigo FROM siscoob.dbo.tblAssociados_Planos WITH(NOLOCK)  
                                       --                    WHERE assnic = AR.assNic  
                      --         AND plCodigo = ARP.plCodigo  
                       --        AND tpplCodigo = ARP.tpPlCodigo) <> 11)  
  --AND   SUBSTRING(AR.reSolicitacao,CHARINDEX('REVERTIDO:',AR.reSolicitacao)+11,1)='S'  
  (AR.itensCodigo = 195 AND (APST.susData IS NULL OR APST.susDataConclusao IS NOT NULL) AND (SELECT COUNT(R.reCodigo)   
                        FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
                        INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
                        ON P.recodigo = R.recodigo   
                        WHERE R.assnic = AR.assnic   
                        AND P.plcodigo = ARP.plcodigo  
                        AND R.redatageracao > AR.redatageracao   
                        AND R.itensCodigo IN (195,196)  
                        AND P.tpplCodigo < 1000) = 0  
   OR AR.itensCodigo = 196 AND (APCD.cancData IS NULL OR APCD.cancDataConclusao IS NOT NULL) AND (SELECT COUNT(R.reCodigo)   
                           FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
                           INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
                           ON P.recodigo = R.recodigo   
                           WHERE R.assnic = AR.assnic   
                           AND P.plcodigo = ARP.plcodigo  
                           AND R.redatageracao > AR.redatageracao   
                           AND R.itensCodigo IN (195,196)  
                           AND P.tpplCodigo < 1000) = 0) AND NOT EXISTS(SELECT APSTT.plCodigo   
                                       FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
                                       WHERE APSTT.assNic = AR.assNic  
                                       AND   APSTT.plCodigo = ARP.plCodigo  
                                       AND   APSTT.tpPlCodigo = ARP.tpplCodigo  
                                       AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
                                       AND   CONVERT(VARCHAR(6),AR.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal)  
  AND AR.reSolicitacao LIKE '%REVERTIDO: SIM%'  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  -- AND   APCD.cancData IS NULL  
  --AND   APST.susData IS NULL   
  AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  
  IF @IntCancDia_AcuMes_Revertidos > 0  
   SELECT @IntCancDia_AcuMes_Porcentagem = ((@IntCancDia_AcuMes_Revertidos*100)/(@IntCancDia_AcuMes_Recebidos))  
  ELSE  
   SELECT @IntCancDia_AcuMes_Porcentagem = 0  
  
  SELECT @IntCancDia_AcuMes_NaoRevertidos = (@IntCancDia_AcuMes_Recebidos - @IntCancDia_AcuMes_Revertidos)  
  
  
  SELECT @IntCancDia_AcuMes_ME = COUNT(DISTINCT CONCAT(AR.assnic,ARP.plCodigo,ARP.tpPlCodigo))--ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    -- Alterado dia 13/3/2018 - Jairo/Rafael(supervisão)  
  --AND APCD.cancCodigo IS NULL  
  --AND APST.susCodigo IS NULL  
    --AND   (((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL) OR APCD.cancodigo IS NULL)  
    --       OR   ((APST.susCodigo IS NOT NULL OR APST.susdataconclusao IS NOT NULL) OR APST.susCodigo IS NULL))  
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND ((AR.itensCodigo = 188 AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
                                      INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
                                ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  AND (((APCD.cancCodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL) OR APCD.cancCodigo IS NULL)  
        OR   ((APST.susCodigo IS NOT NULL OR APST.susdataconclusao IS NOT NULL) OR APST.susCodigo IS NULL)))  
     OR AR.itensCodigo = 207 AND (APCD.cancCodigo IS NULL OR DATEADD(MINUTE,5,APCD.cancDataConclusao) < AR.reDatageracao))  
  
  --FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  --INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  --ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  --ON    AR.assnic = APCD.assnic  
  --AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  --AND   ARP.plCodigo = APCD.plCodigo  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  --ON    AR.assnic = APST.assnic  
  --AND   ARP.tpPlCodigo = APST.tpplCodigo  
  --AND   ARP.plCodigo = APST.plCodigo  
  --INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  --ON AR.reUsuarioSolicitante = U.usuUsuario  
  --WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  --AND U.deptoCodigo = 10  
  --  -- Alterado dia 13/3/2018 - Jairo/Rafael(supervisão)  
  ----AND APCD.cancCodigo IS NULL  
  ----AND APST.susCodigo IS NULL  
  --  AND   (((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL) OR APCD.cancodigo IS NULL)  
  --         OR   ((APST.susCodigo IS NOT NULL OR APST.susdataconclusao IS NOT NULL) OR APST.susCodigo IS NULL))  
  --AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  --AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --          INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --        ON A.reCodigo = B.reCodigo  
  --        WHERE A.assNic = AR.assNic  
  --        AND   B.plCodigo = ARP.plCodigo  
  --        AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --        AND   A.itensCodigo IN (195,196)  
  --        AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  SELECT @IntCancDia_AcuMes_Argumentacao = (@IntCancDia_AcuMes_Revertidos - @IntCancDia_AcuMes_ME)  
  
  IF @IntCancDia_AcuMes_Argumentacao < 0  
   SET @IntCancDia_AcuMes_Argumentacao = 0  
  
  INSERT INTO #tempTarefas EXEC sp_Tarefas_Etapas_P_Monitor 0,1,15,'alopes',NULL,NULL,NULL,NULL,NULL  
  
  INSERT INTO #tempTarefas EXEC sp_Tarefas_Etapas_P_Monitor 0,1,13,'alopes',NULL,NULL,NULL,NULL,NULL  
  
  SELECT @IntCancDia_AcuMes_Certificacoes = ISNULL(COUNT(T1.tarCodigo),0) FROM #tempTarefas T1  
  INNER JOIN tblTarefas T2 WITH(NOLOCK)  
  ON T1.tarCodigo = T2.tarCodigo  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T1.etaCodigo = TE.etaCodigo  
  WHERE (/*T1.COR = 'VERDE' OR */T1.COR = 'AMARELO')  -- Alterado por Rafael Bertoluci em 11/09/2018 para calcular tarefas para o dia  
  --AND SUBSTRING(T1.prazo,CHARINDEX('Prazo daqui a ',T1.prazo)+14,CHARINDEX('Dia',T1.prazo)-14-CHARINDEX('Prazo daqui a ',T1.prazo)) = 0 -- Alterado em 03/09/2018 por Rafael Bertoluci  
  AND LEFT(T1.para,17) = 'Central de Atend.'  
  AND T2.sitCodigo <= 2  
  AND TE.etaSequencia = 1  
  
  --DROP TABLE #tempTarefas  
  
  
  
  
 -- ***** TODOS OS RETORNOS (valor são varchar)  
 -- (INTENÇÃO DE CANCELAMENTO DO DIA)  
 SELECT ordem = 1, valor = CONVERT(VARCHAR(10),@IntCancDia_Recebidos), descr = 'IntCancDia_Recebidos'   
 UNION  
 SELECT ordem = 2, valor = CONVERT(VARCHAR(10),@IntCancDia_Revertidos), descr = 'IntCancDia_Revertidos'   
 UNION  
 SELECT ordem = 3, valor = CONVERT(VARCHAR(10),@IntCancDia_Porcentagem)+'%', descr = 'IntCancDia_Porcentagem'   
 UNION  
 SELECT ordem = 4, valor = CONVERT(VARCHAR(10),@IntCancDia_NaoRevertidos), descr = 'IntCancDia_NaoRevertidos'   
 UNION  
 SELECT ordem = 5, valor = CONVERT(VARCHAR(10),@IntCancDia_ME), descr = 'IntCancDia_ME'   
 UNION  
 SELECT ordem = 6, valor = CONVERT(VARCHAR(10),@IntCancDia_Argumentacao), descr = 'IntCancDia_Argumentacao'   
 UNION  
  
 -- (INTENÇÃO DE CANCELAMENTO DO DIA - ACUMULADO DO MÊS)  
 SELECT ordem = 7, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_Recebidos), descr = 'IntCancDia_AcuMes_Recebidos'  
 UNION  
 SELECT ordem = 8, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_Revertidos), descr = 'IntCancDia_AcuMes_Revertidos'  
 UNION  
 SELECT ordem = 9, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_Porcentagem)+'%', descr = 'IntCancDia_AcuMes_Porcentagem'  
 UNION  
 SELECT ordem = 10, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_NaoRevertidos), descr = 'IntCancDia_AcuMes_NaoRevertidos'  
 UNION  
 SELECT ordem = 11, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_ME), descr = 'IntCancDia_AcuMes_ME'  
 UNION  
 SELECT ordem = 12, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_Argumentacao), descr = 'IntCancDia_AcuMes_Argumentacao'  
 UNION  
 SELECT ordem = 13, valor = CONVERT(VARCHAR(10),@IntCancDia_AcuMes_Certificacoes), descr = 'IntCancDia_AcuMes_Certificacoes'  
  
 ------------------------------------------------------------------------------------------------------------------  
  
  
 -- Variáveis do dia, 2° Contato  
 DECLARE @SegContRealDia_Realizados DECIMAL(18,0)  
 DECLARE @SegContRealDia_Revertidos DECIMAL(18,0)  
 DECLARE @SegContRealDia_Porcentagem DECIMAL(18,2)  
 DECLARE @SegContRealDia_NaoRevertidos DECIMAL(18,0)  
 DECLARE @SegContRealDia_ME DECIMAL(18,0)  
 DECLARE @SegContRealDia_Argumentacao DECIMAL(18,0)  
  
 -- Variáveis do acumulado do mês, 2° Contato  
 DECLARE @SegContRealDia_AcuMes_Realizados DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_Revertidos DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_Porcentagem DECIMAL(18,2)  
 DECLARE @SegContRealDia_AcuMes_NaoRevertidos DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_ME DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_Argumentacao DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_ContatoSemSucesso DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_PendentesMesesAnteriores DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_PendentesNoPrazo DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_PendentesForaDoPrazo DECIMAL(18,0)  
 DECLARE @SegContRealDia_AcuMes_SemSucesso DECIMAL(18,0)  
  
  
 DECLARE @dia_um DATETIME  
  SET @dia_um = @dataMesInicial  
  
 DECLARE @dias_uteis_ate_agora INT  
  SET @dias_uteis_ate_agora = siscoob.dbo.fn_Calcula_Dias_Uteis(@dia_um,@data_atual)  
   
 DECLARE @dias_uteis_ate_final INT  
 DECLARE @dia_ultimo DATETIME  
   SET @dia_ultimo = @dataMesFinal  
  
 SET @dias_uteis_ate_final = siscoob.dbo.fn_Calcula_Dias_Uteis(@data_atual,@dia_ultimo)  
  
 --SELECT @dias_uteis_ate_agora,@dias_uteis_ate_final  
  
  
 -- 2° contato Realizado, Acumulado do dia  
  SELECT @SegContRealDia_Realizados =   
  (SELECT SegContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
   FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
   ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
   ON    AR.assnic = APCD.assnic  
   AND   ARP.tpPlCodigo = APCD.tpplCodigo  
   AND   ARP.plCodigo = APCD.plCodigo  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
   ON AR.reUsuarioSolicitante = U.usuUsuario  
   WHERE (AR.itensCodigo IN (7,107,206))  
   AND (APST.susCodigo IS NOT NULL OR APCD.cancCodigo IS NOT NULL)   
   AND U.deptoCodigo = 10  
   AND  AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND (APCD.canCodigo NOT IN (5,56)  OR APCD.canCodigo IS NULL)  
   AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
   AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
   AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   (A.itensCodigo = 195 OR A.itensCodigo = 196 AND NOT EXISTS(SELECT APSTT.plCodigo   
                       FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
                       WHERE APSTT.assNic = A.assNic  
                       AND   APSTT.plCodigo = B.plCodigo  
                       AND   APSTT.tpPlCodigo = B.tpplCodigo  
                       AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
                       AND   CONVERT(VARCHAR(6),A.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal))  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT SegContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
   FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
   ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
   ON    AR.assnic = APCD.assnic  
   AND   ARP.tpPlCodigo = APCD.tpplCodigo  
   AND   ARP.plCodigo = APCD.plCodigo  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
   ON AR.reUsuarioSolicitante = U.usuUsuario  
   WHERE AR.itensCodigo IN (181,200,207)  
   AND   U.deptoCodigo = 10  
   AND   AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND (APCD.canCodigo NOT IN (5,56) OR APCD.canCodigo IS NULL)  
   AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
   AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
   AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
   AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
         AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  --+  
  --(SELECT SegContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  --FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  --INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  --ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  --ON    AR.assnic = APCD.assnic  
  --AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  --AND   ARP.plCodigo = APCD.plCodigo  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  --ON    AR.assnic = APST.assnic  
  --AND   ARP.tpPlCodigo = APST.tpplCodigo  
  --AND   ARP.plCodigo = APST.plCodigo  
  -- INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  --ON AR.reUsuarioSolicitante = U.usuUsuario  
  --WHERE AR.itensCodigo = 26  
  --AND U.deptoCodigo = 10  
  --AND (APCD.canCodigo <> 5  OR APCD.canCodigo IS NULL)  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  --AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  --AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  --AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --          ON A.reCodigo = B.reCodigo  
  --          WHERE A.assNic = AR.assNic  
  --          AND   B.plCodigo = ARP.plCodigo  
  --          AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --          AND   A.itensCodigo IN (195,196)  
  --          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  --+  
  --(SELECT SegContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  -- FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  -- INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  -- ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  -- LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  -- ON    AR.assnic = APCD.assnic  
  -- AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  -- AND   ARP.plCodigo = APCD.plCodigo  
  -- LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  -- ON    AR.assnic = APST.assnic  
  -- AND   ARP.tpPlCodigo = APST.tpplCodigo  
  -- AND   ARP.plCodigo = APST.plCodigo  
  -- INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  -- ON AR.reUsuarioSolicitante = U.usuUsuario  
  -- WHERE AR.itensCodigo IN (195,196)  
  -- --AND AR.reSolicitacao LIKE 'Plano em dia: Não'  
  -- AND   AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  -- AND U.deptoCodigo = 10  
  -- AND (APCD.canCodigo <> 5  OR APCD.canCodigo IS NULL)  
  -- AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  -- AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  -- AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  -- AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  -- AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --          ON A.reCodigo = B.reCodigo  
  --          WHERE A.assNic = AR.assNic  
  --          AND   B.plCodigo = ARP.plCodigo  
  --          AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --          AND   A.itensCodigo IN (195,196)  
  --          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  
  
  
  SELECT @SegContRealDia_Revertidos = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  AND   APCD.canCodigo NOT IN (5,56)  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  AND   APST.motCodigo NOT IN (5,56)  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (181,200,207)  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (195,196)  
        AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  
  IF @SegContRealDia_Revertidos > 0  
   SELECT @SegContRealDia_Porcentagem = ((@SegContRealDia_Revertidos*100)/(@SegContRealDia_Realizados))  
  ELSE  
   SELECT @SegContRealDia_Porcentagem = 0  
  
  SELECT @SegContRealDia_NaoRevertidos = (@SegContRealDia_Realizados - @SegContRealDia_Revertidos)  
  
  
  SELECT @SegContRealDia_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    -- Alterado dia 13/03/2018 - Jairo/Rafael(supervisão)  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NULL OR APST.susDataConclusao IS NULL)   
    AND   ((APCD.cancodigo IS NOT NULL AND CONVERT(VARCHAR(10),APCD.cancdataconclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103))  
           OR   (APST.susCodigo IS NOT NULL AND CONVERT(VARCHAR(10),APST.susDataConclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103)))  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
             INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
           ON A.reCodigo = B.reCodigo  
           WHERE A.assNic = AR.assNic  
           AND   B.plCodigo = ARP.plCodigo  
           AND   B.tpPlCodigo = ARP.tpPlCodigo  
           AND   A.itensCodigo IN (195,196)  
        AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'   
           AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
    
  
  SELECT @SegContRealDia_Argumentacao = (@SegContRealDia_Revertidos - @SegContRealDia_ME)  
  
  IF @SegContRealDia_Argumentacao < 0  
   SET @SegContRealDia_Argumentacao = 0  
  
  
 /*#####################################################################################################################*/    
  -- 2° contato Realizado, Acumulado do mês   
  SELECT @SegContRealDia_AcuMes_Realizados =   
  (SELECT SegContRealDia_AcuMes_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
   FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
   ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
   ON    AR.assnic = APCD.assnic  
   AND   ARP.tpPlCodigo = APCD.tpplCodigo  
   AND   ARP.plCodigo = APCD.plCodigo  
   AND   APCD.canCodigo NOT IN (5,56)  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   AND   APST.motCodigo NOT IN (5,56)  
   INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
   ON AR.reUsuarioSolicitante = U.usuUsuario  
   WHERE (AR.itensCodigo IN (7,107,206))  
   AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
   AND U.deptoCodigo = 10  
   AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
         AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
            AND   (A.itensCodigo = 195 OR A.itensCodigo = 196 AND NOT EXISTS(SELECT APSTT.plCodigo   
                       FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
                       WHERE APSTT.assNic = A.assNic  
                       AND   APSTT.plCodigo = B.plCodigo  
                       AND   APSTT.tpPlCodigo = B.tpplCodigo  
                       AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
                       AND   CONVERT(VARCHAR(6),A.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal))  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT SegContRealDia_AcuMes_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
   FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
   ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
   ON    AR.assnic = APCD.assnic  
   AND   ARP.tpPlCodigo = APCD.tpplCodigo  
   AND   ARP.plCodigo = APCD.plCodigo  
   AND   APCD.canCodigo NOT IN (5,56)  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   AND   APST.motCodigo NOT IN (5,56)  
   INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
   ON AR.reUsuarioSolicitante = U.usuUsuario  
   WHERE AR.itensCodigo IN (181,200,207)  
   AND U.deptoCodigo = 10  
   AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
   AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
         AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT SegContRealDia_AcuMes_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
   FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
   INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
   ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
   ON    AR.assnic = APCD.assnic  
   AND   ARP.tpPlCodigo = APCD.tpplCodigo  
   AND   ARP.plCodigo = APCD.plCodigo  
   AND   APCD.canCodigo NOT IN (5,56)  
   LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
   ON    AR.assnic = APST.assnic  
   AND   ARP.tpPlCodigo = APST.tpplCodigo  
   AND   ARP.plCodigo = APST.plCodigo  
   AND   APST.motCodigo NOT IN (5,56)  
   INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
   ON AR.reUsuarioSolicitante = U.usuUsuario  
   WHERE AR.itensCodigo = 26  
   AND (SELECT COUNT(A.reCodigo) FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK)  
      INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
      ON A.reCodigo = B.reCodigo  
      WHERE A.assNic = AR.assnic  
      AND B.plCodigo = ARP.plCodigo  
      AND B.tpPlCodigo = ARP.tpPlCodigo  
      AND A.reDatageracao > AR.reDatageracao  
      AND A.itensCodigo IN (7,107,200,181,196,195,188,206,207)) = 0  
   AND U.deptoCodigo = 10  
   AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
   AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
         AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  --+  
  --(SELECT SegContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  -- FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  -- INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  -- ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  -- LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  -- ON    AR.assnic = APCD.assnic  
  -- AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  -- AND   ARP.plCodigo = APCD.plCodigo  
  -- LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  -- ON    AR.assnic = APST.assnic  
  -- AND   ARP.tpPlCodigo = APST.tpplCodigo  
  -- AND   ARP.plCodigo = APST.plCodigo  
  -- INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  -- ON AR.reUsuarioSolicitante = U.usuUsuario  
  -- WHERE AR.itensCodigo IN (195,196)  
  -- --AND AR.reSolicitacao LIKE 'Plano em dia: Não'  
  -- AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  -- AND U.deptoCodigo = 10  
  -- AND (APCD.canCodigo <> 5  OR APCD.canCodigo IS NULL)  
  -- AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  -- AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  -- AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --          ON A.reCodigo = B.reCodigo  
  --          WHERE A.assNic = AR.assNic  
  --          AND   B.plCodigo = ARP.plCodigo  
  --          AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --          AND   A.itensCodigo IN (195,196)  
  --          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  
  
  
  SELECT @SegContRealDia_AcuMes_Revertidos = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  AND   APCD.canCodigo NOT IN (5,56)  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  AND   APST.motCodigo NOT IN (5,56)  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (181,200,207)  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND U.deptoCodigo = 10  
  AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)   
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (195,196)  
        AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  
  SELECT @SegContRealDia_AcuMes_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    --Alterado dia 13/03/2018 Jairo/Rafael(supervisão)  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NULL OR APST.susDataConclusao IS NULL)   
    AND ((APCD.cancodigo IS NOT NULL AND CONVERT(VARCHAR(10),APCD.cancdataconclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103))  
        OR (APST.susCodigo IS NOT NULL AND CONVERT(VARCHAR(10),APST.susDataConclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103)))  
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (195,196)  
        AND   A.resolicitacao NOT LIKE '%Plano em dia: Não%'   
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  --FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  --INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  --ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  --ON    AR.assnic = APCD.assnic  
  --AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  --AND   ARP.plCodigo = APCD.plCodigo  
  --LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  --ON    AR.assnic = APST.assnic  
  --AND   ARP.tpPlCodigo = APST.tpplCodigo  
  --AND   ARP.plCodigo = APST.plCodigo  
  --INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  --ON AR.reUsuarioSolicitante = U.usuUsuario  
  --WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  --AND U.deptoCodigo = 10  
  --  --Alterado dia 13/03/2018 Jairo/Rafael(supervisão)  
  ----AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  ----AND (APCD.cancDataConclusao IS NULL OR APST.susDataConclusao IS NULL)   
  --  AND   ((APCD.cancodigo IS NOT NULL AND CONVERT(VARCHAR(10),APCD.cancdataconclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103))  
  --         OR   (APST.susCodigo IS NOT NULL AND CONVERT(VARCHAR(10),APST.susDataConclusao,103) = CONVERT(VARCHAR(10),AR.reDataGeracao,103)))  
  --AND  AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  --AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
  --           INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
  --         ON A.reCodigo = B.reCodigo  
  --         WHERE A.assNic = AR.assNic  
  --         AND   B.plCodigo = ARP.plCodigo  
  --         AND   B.tpPlCodigo = ARP.tpPlCodigo  
  --         AND   A.itensCodigo IN (195,196)  
  --         AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
   
  
   
  SELECT @SegContRealDia_AcuMes_ContatoSemSucesso = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo = 26 AND (SELECT COUNT(A.reCodigo) FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK)  
                                 INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
                  ON A.reCodigo = B.reCodigo  
                                 WHERE A.assNic = AR.assnic  
                  AND B.plCodigo = ARP.plCodigo  
                  AND B.tpPlCodigo = ARP.tpPlCodigo  
                  AND A.reDatageracao > AR.reDatageracao  
                  AND A.itensCodigo IN (7,107,200,181,196,195,188,207,206)) = 0  
  AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
   AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
        INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
        ON A.reCodigo = B.reCodigo  
        WHERE A.assNic = AR.assNic  
        AND   B.plCodigo = ARP.plCodigo  
        AND   B.tpPlCodigo = ARP.tpPlCodigo  
        AND   A.itensCodigo IN (195,196)  
        AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  
   SET @SegContRealDia_AcuMes_NaoRevertidos = ((@SegContRealDia_AcuMes_Realizados - @SegContRealDia_AcuMes_ContatoSemSucesso) - @SegContRealDia_AcuMes_Revertidos)  
  
  IF @SegContRealDia_AcuMes_Revertidos > 0  
   SELECT @SegContRealDia_AcuMes_Porcentagem = ((@SegContRealDia_AcuMes_Revertidos*100)/(@SegContRealDia_AcuMes_Realizados - @SegContRealDia_AcuMes_ContatoSemSucesso))  
  ELSE  
   SELECT @SegContRealDia_AcuMes_Porcentagem = 0  
  
  
  
  SELECT @SegContRealDia_AcuMes_Argumentacao = (@SegContRealDia_AcuMes_Revertidos - @SegContRealDia_AcuMes_ME)  
  
  
  
  IF @SegContRealDia_AcuMes_Argumentacao < 0  
   SET @SegContRealDia_AcuMes_Argumentacao = 0  
  
  
  SELECT @SegContRealDia_AcuMes_PendentesMesesAnteriores = ISNULL(COUNT(T1.tarCodigo),0)  
  FROM #tempTarefas T1  
  INNER JOIN tblTarefas T2 WITH(NOLOCK)  
  ON T1.tarCodigo = T2.tarCodigo  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T1.etaCodigo = TE.etaCodigo  
  WHERE T1.COR = 'VERMELHO'  
  AND T1.prazo LIKE '%Atrasado%'  
  AND T1.OrderTemo > DATEDIFF(N,@dataMesInicial,@data_atual)  
  AND LEFT(T1.para,17) = 'Central de Atend.'  
  AND T2.sitCodigo <= 2  
  AND TE.etaSequencia = 1  
  
  
  
  SELECT @SegContRealDia_AcuMes_PendentesForaDoPrazo = ISNULL(COUNT(T1.tarCodigo),0)  
  FROM #tempTarefas T1  
  INNER JOIN tblTarefas T2 WITH(NOLOCK)  
  ON T1.tarCodigo = T2.tarCodigo  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T1.etaCodigo = TE.etaCodigo  
  WHERE T1.COR = 'VERMELHO'  
  AND T1.prazo LIKE '%Atrasado%'  
  AND T1.OrderTemo <= DATEDIFF(N,@dataMesInicial,@data_atual)  
  AND LEFT(T1.para,17) = 'Central de Atend.'  
  AND T2.sitCodigo <= 2  
  AND TE.etaSequencia = 1  
  
  
  SELECT @SegContRealDia_AcuMes_PendentesNoPrazo = ISNULL(COUNT(T1.tarCodigo),0)  
  FROM #tempTarefas T1  
  INNER JOIN tblTarefas T2 WITH(NOLOCK)  
  ON T1.tarCodigo = T2.tarCodigo  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T1.etaCodigo = TE.etaCodigo  
  WHERE (T1.COR = 'VERDE' OR T1.COR = 'AMARELO')  
  --AND T1.prazo LIKE '%Aguardando Atendimento.%'   
  AND T1.OrderTemo < 0  
  AND LEFT(T1.para,17) = 'Central de Atend.'  
  AND T2.sitCodigo <= 2  
  AND TE.etaSequencia = 1  
  
    
  SELECT @SegContRealDia_AcuMes_SemSucesso = ISNULL(COUNT(T1.tarCodigo),0)  
  FROM #tempTarefas T1  
  INNER JOIN tblTarefas T2 WITH(NOLOCK)  
  ON T1.tarCodigo = T2.tarCodigo  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T1.etaCodigo = TE.etaCodigo  
  WHERE T1.COR = 'VERMELHO'  
  AND T1.prazo LIKE '%Atrasado%'  
  AND T1.OrderTemo > DATEDIFF(N,@dataMesInicial,@data_atual)  
  AND LEFT(T1.para,17) = 'Central de Atend.'  
  AND T2.sitCodigo = 3  
  AND TE.etaSequencia = 6  
  
  
  
 -- (2º CONTATO REALIZADO DO DIA)  
 SELECT ordem = 1, valor = CONVERT(VARCHAR(10),@SegContRealDia_Realizados), descr = 'SegContRealDia_Realizados'   
 UNION   
 SELECT ordem = 2, valor = CONVERT(VARCHAR(10),@SegContRealDia_Revertidos), descr = 'SegContRealDia_Revertidos'   
 UNION   
 SELECT ordem = 3, valor = CONVERT(VARCHAR(10),@SegContRealDia_Porcentagem)+'%', descr = 'SegContRealDia_Porcentagem'   
 UNION   
 SELECT ordem = 4, valor = CONVERT(VARCHAR(10),@SegContRealDia_NaoRevertidos), descr = 'SegContRealDia_NaoRevertidos'   
 UNION   
 SELECT ordem = 5, valor = CONVERT(VARCHAR(10),@SegContRealDia_ME), descr = 'SegContRealDia_ME'   
 UNION   
 SELECT ordem = 6, valor = CONVERT(VARCHAR(10),@SegContRealDia_Argumentacao), descr = 'SegContRealDia_Argumentacao'   
 UNION   
  
 -- (2º CONTATO REALIZADO DO DIA - ACUMULADO DO MÊS)  
 SELECT ordem = 7, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_Realizados), descr = 'SegContRealDia_AcuMes_Realizados'   
 UNION  
 SELECT ordem = 8, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_Revertidos), descr = 'SegContRealDia_AcuMes_Revertidos'   
 UNION  
 SELECT ordem = 9, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_Porcentagem)+'%', descr = 'SegContRealDia_AcuMes_Porcentagem'   
 UNION  
 SELECT ordem = 10, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_NaoRevertidos), descr = 'SegContRealDia_AcuMes_NaoRevertidos'   
 UNION  
 SELECT ordem = 11, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_ME), descr = 'SegContRealDia_AcuMes_ME'   
 UNION  
 SELECT ordem = 12, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_Argumentacao), descr = 'SegContRealDia_AcuMes_Argumentacao'   
 UNION  
 SELECT ordem = 13, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_ContatoSemSucesso), descr = 'SegContRealDia_AcuMes_ContatoSemSucesso'   
 UNION  
 SELECT ordem = 14, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_PendentesMesesAnteriores), descr = 'SegContRealDia_AcuMes_PendentesMesesAnteriores'  
 UNION  
 SELECT ordem = 15, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_PendentesNoPrazo), descr = 'SegContRealDia_AcuMes_PendentesNoPrazo'  
 UNION  
 SELECT ordem = 16, valor = CONVERT(VARCHAR(10),@SegContRealDia_AcuMes_PendentesForaDoPrazo), descr = 'SegContRealDia_AcuMes_PendentesForaDoPrazo'  
  
  
  
 ---------------------------------------------------------------------------------------------------------  
  
 -- 3° Contato, Acumulado do Dia  
 DECLARE @TerContRealDia_Realizados DECIMAL(18,0)  
 DECLARE @TerContRealDia_Porcentagem DECIMAL(18,2)   
 DECLARE @TerContRealDia_Revertidos DECIMAL(18,0)  
 DECLARE @TerContRealDia_ME DECIMAL(18,0)  
 DECLARE @TerContRealDia_Desconsideracao DECIMAL(18,0)  
 DECLARE @TerContRealDia_CancEfetivosMes DECIMAL(18,0)  
  
 -- 3° Contato, Acumulado do Mês  
 DECLARE @TerContRealMes_Realizados DECIMAL(18,0)  
 DECLARE @TerContRealMes_Porcentagem DECIMAL(18,2)  
 DECLARE @TerContRealMes_Revertidos DECIMAL(18,0)  
 DECLARE @TerContRealMes_ME DECIMAL(18,0)  
 DECLARE @TerContRealMes_Desconsideracao DECIMAL(18,0)  
 DECLARE @TerContRealMes_Tendencia DECIMAL(18,0)  
  
  
  -- 3° Contato, Acumulado do Dia  
  SELECT @TerContRealDia_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE ((AR.itensCodigo IN (184,186,187,202)  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
             INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
           ON A.reCodigo = B.reCodigo  
           WHERE A.assNic = AR.assNic  
           AND   B.plCodigo = ARP.plCodigo  
           AND   B.tpPlCodigo = ARP.tpPlCodigo  
           AND   A.itensCodigo IN (195,196)  
           AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')) OR  
  (AR.itensCodigo IN (188,207)  
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
           OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (187,202)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')))  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
   AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  
  
  SELECT @TerContRealDia_Revertidos =   
  (SELECT TerContRealDia_Revertidos = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo = 186  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (195,196)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT TerContRealDia_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    --Alterado dia 13/03/2018 Jairo/Rafael  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NOT NULL OR APST.susDataConclusao IS NOT NULL)   
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
           OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (187,202)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT TerContRealDia_Desconsideracao = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (187,202)  
  AND   (SELECT COUNT(ItensCodigo) FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
         INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
         ON    R.reCodigo = P.reCodigo AND P.tpPlCodigo < 1000  
      WHERE R.assNic = AR.assNic  
      AND P.plCodigo = ARP.plCodigo  
      AND P.tpPlCodigo = ARP.plCodigo  
      AND itensCodigo IN (188,207)  
      AND R.reDatageracao >= AR.reDatageracao) = 0   
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (195,196)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  
  
  
  IF @TerContRealDia_Revertidos > 0 AND @TerContRealDia_Realizados > 0  
   SELECT @TerContRealDia_Porcentagem = ((@TerContRealDia_Revertidos*100)/(@TerContRealDia_Realizados))  
  ELSE   
   SELECT @TerContRealDia_Porcentagem = 0  
  
  
  SELECT @TerContRealDia_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    --Alterado dia 13/03/2018 Jairo/Rafael  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NOT NULL OR APST.susDataConclusao IS NOT NULL)   
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
           OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (187,202)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  SELECT @TerContRealDia_Desconsideracao = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (187,202)  
  AND   (SELECT COUNT(ItensCodigo) FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
         INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
         ON    R.reCodigo = P.reCodigo AND P.tpPlCodigo < 1000  
      WHERE R.assNic = AR.assNic  
      AND P.plCodigo = ARP.plCodigo  
      AND P.tpPlCodigo = ARP.plCodigo  
      AND itensCodigo IN (188,207)  
      AND R.reDatageracao >= AR.reDatageracao) = 0   
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
  AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
  AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
        INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
        ON A.reCodigo = B.reCodigo  
        WHERE A.assNic = AR.assNic  
        AND   B.plCodigo = ARP.plCodigo  
        AND   B.tpPlCodigo = ARP.tpPlCodigo  
        AND   A.itensCodigo IN (195,196)  
        AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  
  --SELECT TerContRealDia_CancEfetivosMes = ISNULL((SELECT COUNT(DISTINCT AP.assNic+ap.tpplcodigo+ap.plcodigo)           
  --FROM   siscoob.dbo.tblAssociados_Planos AP WITH(NOLOCK)  
  --LEFT   JOIN  siscoob.dbo.tblAssociados_Planos_Cancelamentos APC WITH(NOLOCK)  
  --ON     APC.assnic = AP.assnic   
  --AND    APC.tpplcodigo = AP.tpplcodigo   
  --AND    APC.plcodigo = AP.plcodigo   
  --LEFT   JOIN  siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APST WITH(NOLOCK)  
  --ON     APST.assnic = AP.assnic    
  --AND    APST.tpplcodigo = AP.tpplcodigo      
  --AND    APST.plcodigo = AP.plcodigo  
  --AND    CONVERT(VARCHAR(10),AP.plDtCancelamento,103) = CONVERT(VARCHAR(10),APST.susDtSuspensao,103)  
  --WHERE  AP.plDtCancelamento BETWEEN '27/10/2017 00:00:00' AND '25/11/2017 23:59:59'  
  --AND    (AP.tpcanCodigo <> 1 OR AP.tpcanCodigo IS NULL)  
  --AND    AP.sitcodigo in(9,11)   
  --AND    AP.cancodigo NOT IN (3,5,50)  
  --AND    AP.canCodigo <> 36   
  --AND    AP.sitCodigo <> 8   
  --AND   (APC.cancsic = 2 OR APC.cancsic IS NULL) AND (APST.sussic <> 1 OR APST.sussic IS NULL)),0)  
  
  
  
  
  SELECT @TerContRealDia_CancEfetivosMes = (SELECT ISNULL(COUNT(DISTINCT AR.assNic+ARP.tpplcodigo+ARP.plcodigo),0)           
  FROM   siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER  JOIN  siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON     AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000   
  WHERE  AR.itensCodigo = 7   
  AND    AR.reDeptoSolicitante = 10  
  AND    NOT EXISTS(SELECT cancCodigo FROM siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
                    WHERE APCD.assnic = AR.assnic  
           AND APCD.plCodigo = ARP.plCodigo  
           AND APCD.tpplCodigo = ARP.tpplCodigo  
           AND APCD.canCodigo IN (5,56))    
  AND    AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND    EXISTS(SELECT A.reDataGeracao   
                FROM  siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK)  
                INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
         ON    A.reCodigo = B.reCodigo  
         WHERE A.assNic = AR.assNic  
         AND   B.plCodigo = ARP.plCodigo  
         AND   B.tpPlCodigo = ARP.tpPlCodigo  
         AND   A.itensCodigo = 196  
         AND   A.reDeptoSolicitante = 10  
         AND   A.reSolicitacao NOT LIKE '%Plano em dia: Não%'  
         AND NOT EXISTS(SELECT APSTT.plCodigo   
             FROM Siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporaria APSTT WITH(NOLOCK)  
             WHERE APSTT.assNic = AR.assNic  
             AND   APSTT.plCodigo = ARP.plCodigo  
             AND   APSTT.tpPlCodigo = ARP.tpplCodigo  
             AND   APSTT.susNegociada = 0 --adicionado em 13/11/2023, conforme chamado #32375, espelhando a regra do mapa de atendimento  
             AND   CONVERT(VARCHAR(6),AR.reDatageracao,112) BETWEEN APSTT.susMesInicial AND APSTT.susMesFinal)  
         AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT ISNULL(COUNT(DISTINCT AR.assNic+ARP.tpplcodigo+ARP.plcodigo),0)           
  FROM   siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER  JOIN  siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON     AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000   
  WHERE  AR.itensCodigo IN (107,206)  
  AND    AR.reDeptoSolicitante = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND    AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND    EXISTS(SELECT A.reDataGeracao   
                FROM  siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK)  
                INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
         ON    A.reCodigo = B.reCodigo  
         WHERE A.assNic = AR.assNic  
         AND   B.plCodigo = ARP.plCodigo  
         AND   B.tpPlCodigo = ARP.tpPlCodigo  
         AND   A.itensCodigo IN (195,196)  
         AND   A.reDeptoSolicitante = 10  
         AND   A.reSolicitacao NOT LIKE '%Plano em dia: Não%'  
         AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  
  
  
  
 /*#####################################################################################################################*/    
  
  -- 3° Contato, Acumulado do Mês  
  SELECT @TerContRealMes_Realizados = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE ((AR.itensCodigo IN (184,186,187,202)  
  AND   EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59') OR  
    (AR.itensCodigo IN (188,207)  
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
           OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
            INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
          ON A.reCodigo = B.reCodigo  
          WHERE A.assNic = AR.assNic  
          AND   B.plCodigo = ARP.plCodigo  
          AND   B.tpPlCodigo = ARP.tpPlCodigo  
          AND   A.itensCodigo IN (187,202)  
          AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))))  
  AND   U.deptoCodigo = 10  
  AND   AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  
  
  
  SELECT @TerContRealMes_Revertidos =   
  (SELECT TerContRealMes_Revertidos = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo = 186  
  AND   U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND   EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT TerContRealMes_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
 AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    --Alterado dia 13/03/2018 Jairo/Rafael  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NOT NULL OR APST.susDataConclusao IS NOT NULL)   
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
           OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
             INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
           ON A.reCodigo = B.reCodigo  
           WHERE A.assNic = AR.assNic  
           AND   B.plCodigo = ARP.plCodigo  
           AND   B.tpPlCodigo = ARP.tpPlCodigo  
           AND   A.itensCodigo IN (187,202)  
           AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  +  
  (SELECT TerContRealMes_Desconsideracao = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (187,202)  
  AND   U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND   (SELECT COUNT(ItensCodigo) FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
         INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
         ON    R.reCodigo = P.reCodigo AND P.tpPlCodigo < 1000  
      WHERE R.assNic = AR.assNic  
      AND P.plCodigo = ARP.plCodigo  
      AND P.tpPlCodigo = ARP.plCodigo  
      AND itensCodigo IN (188,207)  
      AND R.reDatageracao >= AR.reDatageracao) = 0   
  AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND   EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'))  
  
  
  IF @TerContRealMes_Revertidos  > 0 AND @TerContRealMes_Realizados > 0  
   SELECT @TerContRealMes_Porcentagem = ((@TerContRealMes_Revertidos*100)/(@TerContRealMes_Realizados))  
  ELSE  
   SELECT @TerContRealMes_Porcentagem = 0  
  
  
  SELECT @TerContRealMes_ME = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
  ON    AR.assnic = APCD.assnic  
  AND   ARP.tpPlCodigo = APCD.tpplCodigo  
  AND   ARP.plCodigo = APCD.plCodigo  
  LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
  ON    AR.assnic = APST.assnic  
  AND   ARP.tpPlCodigo = APST.tpplCodigo  
  AND   ARP.plCodigo = APST.plCodigo  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (188,207) -- Alterar para assunto correto  
  AND U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
    --Alterado dia 13/03/2018 Jairo/Rafael  
  --AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
  --AND (APCD.cancDataConclusao IS NOT NULL OR APST.susDataConclusao IS NOT NULL)   
    AND   ((APCD.cancodigo IS NOT NULL AND APCD.cancdataconclusao IS NOT NULL)  
        OR   (APST.susCodigo IS NOT NULL AND APST.susdataconclusao IS NOT NULL))  
  AND AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
        INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
        ON A.reCodigo = B.reCodigo  
        WHERE A.assNic = AR.assNic  
        AND   B.plCodigo = ARP.plCodigo  
        AND   B.tpPlCodigo = ARP.tpPlCodigo  
        AND   A.itensCodigo IN (187,202)  
        AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  SELECT @TerContRealMes_Desconsideracao = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)  
  FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
  INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
  ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
  INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
  ON AR.reUsuarioSolicitante = U.usuUsuario  
  WHERE AR.itensCodigo IN (187,202)  
  AND   U.deptoCodigo = 10  
  AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
  AND   (SELECT COUNT(ItensCodigo) FROM siscoob.dbo.tblAssociados_Reats R WITH(NOLOCK)  
         INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos P WITH(NOLOCK)  
         ON    R.reCodigo = P.reCodigo AND P.tpPlCodigo < 1000  
      WHERE R.assNic = AR.assNic  
      AND P.plCodigo = ARP.plCodigo  
      AND P.tpPlCodigo = ARP.plCodigo  
      AND itensCodigo IN (188,207)  
      AND R.reDatageracao >= AR.reDatageracao) = 0   
  AND   AR.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59'  
  AND   EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
              INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
            ON A.reCodigo = B.reCodigo  
            WHERE A.assNic = AR.assNic  
            AND   B.plCodigo = ARP.plCodigo  
            AND   B.tpPlCodigo = ARP.tpPlCodigo  
            AND   A.itensCodigo IN (195,196)  
            AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  DECLARE @perc_mes DECIMAL(18,2)  
  DECLARE @intencoesFaltantes INT  
  DECLARE @cancelamentosMes INT  
  
  --SELECT primeiro = @SegContRealDia_AcuMes_Revertidos, segundo = @SegContRealDia_AcuMes_Realizados,terceiro = @SegContRealDia_AcuMes_ContatoSemSucesso  
  
  IF @SegContRealDia_AcuMes_Realizados > 0  
    SET @perc_mes = (1-((@SegContRealDia_AcuMes_Revertidos)/CASE WHEN (@SegContRealDia_AcuMes_Realizados - @SegContRealDia_AcuMes_ContatoSemSucesso) = 0 THEN 1 ELSE (@SegContRealDia_AcuMes_Realizados - @SegContRealDia_AcuMes_ContatoSemSucesso)END))  
  ELSE   
    SET @perc_mes = 0  
  
  SET @intencoesFaltantes = (ISNULL(@SegContRealDia_AcuMes_PendentesMesesAnteriores,0)+ISNULL(@SegContRealDia_AcuMes_PendentesNoPrazo,0)+ISNULL(@SegContRealDia_AcuMes_PendentesForaDoPrazo,0))  
  
  SET @cancelamentosMes = (SELECT [Siscoob].[dbo].[fn_Associados_Planos_Cancelamento_Quantidade_Tendencia](@dataMesInicial+' 00:00:00',@dataMesFinal+' 23:59:59'))  
  
  IF @dias_uteis_ate_agora = 0   
    SET @dias_uteis_ate_agora = 1  
  IF @dias_uteis_ate_final = 0  
    SET @dias_uteis_ate_final = 1  
  
   --SELECT @cancelamentosMes,@intencoesFaltantes,@perc_mes,@dias_uteis_ate_agora,@dias_uteis_ate_final  
  
    IF @perc_mes > 0 AND @perc_mes < 1  
    --SET @TerContRealMes_Tendencia = (@TerContRealDia_CancEfetivosMes+(@intencoesFaltantes*@perc_mes)+(@TerContRealDia_CancEfetivosMes/@dias_uteis_ate_agora))*@dias_uteis_ate_final  
   SET @TerContRealMes_Tendencia = (@cancelamentosMes+(@intencoesFaltantes*@perc_mes)+((@cancelamentosMes/@dias_uteis_ate_agora)*(CASE WHEN @dias_uteis_ate_final = 0 THEN 1 ELSE @dias_uteis_ate_final END)))  
  ELSE   
    SET @TerContRealMes_Tendencia = 0  
  
  
 -- (3º CONTATO REALIZADO DO DIA)  
 SELECT ordem = 1, valor = CONVERT(VARCHAR(10),@TerContRealDia_Realizados), descr = 'TerContRealDia_Realizados'   
 UNION  
 SELECT ordem = 2, valor = CONVERT(VARCHAR(10),@TerContRealDia_Porcentagem)+'%', descr = 'TerContRealDia_Porcentagem'   
 UNION   
 SELECT ordem = 3, valor = CONVERT(VARCHAR(10),@TerContRealDia_Revertidos), descr = 'TerContRealDia_Revertidos'  
 UNION  
 SELECT ordem = 4, valor = CONVERT(VARCHAR(10),@TerContRealDia_ME), descr = 'TerContRealDia_ME'  
 UNION  
 SELECT ordem = 5, valor = CONVERT(VARCHAR(10),@TerContRealDia_Desconsideracao), descr = 'TerContRealDia_Desconsideracao'  
 UNION  
 SELECT ordem = 6, valor = CONVERT(VARCHAR(10),@TerContRealDia_CancEfetivosMes), descr = 'TerContRealDia_CancEfetivosMes'   
 UNION  
  
 -- (3º CONTATO REALIZADO DO MES)  
 SELECT ordem = 7, valor = CONVERT(VARCHAR(10),@TerContRealMes_Realizados), descr = 'TerContRealMes_Realizados'  
 UNION  
 SELECT ordem = 8, valor = CONVERT(VARCHAR(10),@TerContRealMes_Porcentagem)+'%', descr = 'TerContRealMes_Porcentagem'  
 UNION  
 SELECT ordem = 9, valor = CONVERT(VARCHAR(10),@TerContRealMes_Revertidos), descr = 'TerContRealMes_Revertidos'   
 UNION  
 SELECT ordem = 10, valor = CONVERT(VARCHAR(10),@TerContRealMes_ME), descr = 'TerContRealMes_ME'   
 UNION  
 SELECT ordem = 11, valor = CONVERT(VARCHAR(10),@TerContRealMes_Desconsideracao), descr = 'TerContRealMes_Desconsideracao'   
 UNION  
 SELECT ordem = 12, valor = CONVERT(VARCHAR(10),@TerContRealMes_Tendencia), descr = 'TerContRealMes_Tendencia'  
  
 -------------------------------------------------------------------------  
  
  
 -- Pendêcias das Tarefas por Departamento  
  
 DECLARE @Cancelamentos_noprazo INT  
 DECLARE @DemaisProcessos_noprazo INT  
 DECLARE @Cobranca_noprazo INT  
 DECLARE @noShow_noprazo INT  
 DECLARE @financeiro_NoPrazo INT  
  
  
 DECLARE @Cancelamentos_foraprazo INT  
 DECLARE @DemaisProcessos_foraprazo INT  
 DECLARE @Cobranca_foraprazo INT  
 DECLARE @noShow_foraprazo INT  
 DECLARE @financeiro_ForaPrazo INT  
  
  
 TRUNCATE TABLE #tempTarefas  
  
 INSERT INTO #tempTarefas EXEC sp_Tarefas_Etapas_P_Monitor  0,1,0,NULL,NULL,NULL,NULL,NULL,NULL  
  
  -- Pendências Operacional Cancelamento  
  SELECT @Cancelamentos_noprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (13,15) -- Tipos de Cancelamento  
  AND TE.deptoCodigoDestino = 5   
  AND TE.sitCodigo <= 2  
  AND (T.COR = 'VERDE' OR T.COR = 'AMARELO')  
    
  SELECT @Cancelamentos_foraprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (13,15) -- Tipos de Cancelamento  
  AND TE.deptoCodigoDestino = 5   
  AND TE.sitCodigo <= 2  
  AND T.COR = 'VERMELHO'  
  
  
  
   -- Pendências Operacional Demais Processos  
  SELECT @DemaisProcessos_noprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (5,6,8,18) -- Demais Tipos  
  AND TE.deptoCodigoDestino = 5   
  AND TE.sitCodigo <= 2  
  AND (T.COR = 'VERDE' OR T.COR = 'AMARELO')  
    
  SELECT @DemaisProcessos_foraprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (5,6,8,18) -- Demais Tipos  
  AND TE.deptoCodigoDestino = 5   
  AND TE.sitCodigo <= 2  
  AND T.COR = 'VERMELHO'  
  
  
  
   -- Pendências Cobrança  
  SELECT @Cobranca_noprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (4,12,16) -- Tipos de Cobrança  
  AND TE.deptoCodigoDestino = 16   
  AND TE.sitCodigo <= 2  
  AND (T.COR = 'VERDE' OR T.COR = 'AMARELO')  
    
  SELECT @Cobranca_foraprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (4,12,16) -- Tipos de Cobrança  
  AND TE.deptoCodigoDestino = 16   
  AND TE.sitCodigo <= 2  
  AND T.COR = 'VERMELHO'  
   
  
  
    -- Pendências Cobrança  
  SELECT @noShow_noprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo = 10 -- Tipos de No-Show  
  AND TE.deptoCodigoDestino = 10   
  AND TE.sitCodigo <= 2  
  AND (T.COR = 'VERDE' OR T.COR = 'AMARELO')  
    
  SELECT @noShow_foraprazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo = 10 -- Tipos de No-Show  
  AND TE.deptoCodigoDestino = 10   
  AND TE.sitCodigo <= 2  
  AND T.COR = 'VERMELHO'  
  
  
  -- Pendências Financeiro  
  SELECT @financeiro_NoPrazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (9,10,11)  
  AND TE.deptoCodigoDestino = 2   
  AND TE.sitCodigo <= 2  
  AND (T.COR = 'VERDE' OR T.COR = 'AMARELO')  
    
  SELECT @financeiro_ForaPrazo = ISNULL(COUNT(DISTINCT T.tarCodigo),0)   
  FROM #tempTarefas T  
  INNER JOIN tblTarefas_Etapas TE WITH(NOLOCK)  
  ON T.etaCodigo = TE.etaCodigo  
  INNER JOIN tblTarefas TF WITH(NOLOCK)  
  ON T.tarCodigo = TF.tarCodigo  
  WHERE TF.tpCodigo IN (9,10,11)  
  AND TE.deptoCodigoDestino = 2   
  AND TE.sitCodigo <= 2  
  AND T.COR = 'VERMELHO'  
  
  
  
 -- (PENDENCIAS OUTROS DEPARTAMENTOS)  
 SELECT ordem = 1, prazo = NULL, foraPrazo = NULL, descr = 'Operacional', cor = '#10c888'   
 UNION  
 SELECT ordem = 2, prazo = CONVERT(VARCHAR(10),@Cancelamentos_noprazo), foraPrazo = CONVERT(VARCHAR(10),@Cancelamentos_foraprazo), descr =  '<UL><LI>Cancelamentos</UL></LI>', cor = '#f9f9f9'   
 UNION  
 SELECT ordem = 3, prazo = CONVERT(VARCHAR(10),@DemaisProcessos_noprazo), foraPrazo = CONVERT(VARCHAR(10),@DemaisProcessos_foraprazo), descr =  '<UL><LI>DemaisProcessos</UL></LI>', cor = '#f9f9f9'  
 UNION  
 SELECT ordem = 4, prazo = NULL, foraPrazo = NULL, descr = 'Cobrança', cor = '#10c888'  
 UNION  
 SELECT ordem = 5, prazo = CONVERT(VARCHAR(10),@Cobranca_noprazo), foraPrazo = CONVERT(VARCHAR(10),@Cobranca_foraprazo), descr = '<UL><LI>Cobrança</UL></LI>', cor = '#f9f9f9'  
 UNION  
 SELECT ordem = 6, prazo = NULL, foraPrazo = NULL, descr = 'Hotéis', cor = '#10c888'  
 UNION  
 SELECT ordem = 7, prazo = CONVERT(VARCHAR(10),@noShow_noprazo), foraPrazo = CONVERT(VARCHAR(10),@noShow_foraprazo), descr = '<UL><LI>No-Show</UL></LI>', cor = '#f9f9f9'  
  
  
  
 /*##################### Populando Tabela para o SIC ################################*/  
  
 DECLARE @SegContRealDia_ContatoSemSucesso INT  
  
 SELECT @SegContRealDia_ContatoSemSucesso = ISNULL(COUNT(DISTINCT AR.assnic+ARP.plCodigo+ARP.tpPlCodigo),0)   
 FROM siscoob.dbo.tblAssociados_Reats AR WITH(NOLOCK)  
 INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos ARP WITH(NOLOCK)  
 ON    AR.reCodigo = ARP.reCodigo AND ARP.tpPlCodigo < 1000  
 LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Cancelamentos_Definitivos APCD WITH(NOLOCK)  
 ON    AR.assnic = APCD.assnic  
 AND   ARP.tpPlCodigo = APCD.tpplCodigo  
 AND   ARP.plCodigo = APCD.plCodigo  
 LEFT  JOIN siscoob.dbo.tblAssociados_Planos_Suspensoes_Temporarias APST WITH(NOLOCK)  
 ON    AR.assnic = APST.assnic  
 AND   ARP.tpPlCodigo = APST.tpplCodigo  
 AND   ARP.plCodigo = APST.plCodigo  
 INNER JOIN siscoob.dbo.tblUsuarios U WITH(NOLOCK)  
 ON AR.reUsuarioSolicitante = U.usuUsuario  
 WHERE AR.itensCodigo = 26 AND (SELECT COUNT(A.reCodigo) FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK)  
                                INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
                 ON A.reCodigo = B.reCodigo  
                                WHERE A.assNic = AR.assnic  
                 AND B.plCodigo = ARP.plCodigo  
                 AND B.tpPlCodigo = ARP.tpPlCodigo  
                 AND A.reDatageracao > AR.reDatageracao  
                 AND A.itensCodigo IN (7,107,200,181,196,195,188,207,206)) = 0  
 AND (APCD.cancCodigo IS NOT NULL OR APST.susCodigo IS NOT NULL)  
 AND U.deptoCodigo = 10  
 AND AR.resolicitacao NOT LIKE '%Plano em dia: Não%'  
 AND DATEPART(DAY,AR.reDatageracao) = DATEPART(DAY,GETDATE())  
 AND DATEPART(MONTH,AR.reDatageracao) = DATEPART(MONTH,GETDATE())  
 AND DATEPART(YEAR,AR.reDatageracao) = DATEPART(YEAR,GETDATE())  
 AND EXISTS(SELECT A.reDataGeracao FROM siscoob.dbo.tblAssociados_Reats A WITH(NOLOCK) -- Inserido em 29/11/2017 por Rafael Bertoluci a pedido da Alessandra Lopes.  
       INNER JOIN siscoob.dbo.tblAssociados_Reats_Planos B WITH(NOLOCK)  
       ON A.reCodigo = B.reCodigo  
       WHERE A.assNic = AR.assNic  
       AND   B.plCodigo = ARP.plCodigo  
       AND   B.tpPlCodigo = ARP.tpPlCodigo  
       AND   A.itensCodigo IN (195,196)  
       AND   A.reDatageracao BETWEEN @dataMesInicial+' 00:00:00' AND @dataMesFinal+' 23:59:59')  
  
  
  UPDATE [bdsic].[dbo].[tblCentral_Atendimento_Intencoes_Cancelamentos_Diarios]  
  SET  [recebidas] = @IntCancDia_Recebidos  
      ,[revertidas] = @IntCancDia_Revertidos  
      ,[nao_revertidas] = @IntCancDia_NaoRevertidos  
      ,[aproveitamento] = @IntCancDia_Porcentagem  
      ,[recebidas_mes] = @IntCancDia_AcuMes_Recebidos  
      ,[revertidas_mes] = @IntCancDia_AcuMes_Revertidos  
      ,[nao_revertidas_mes] = @IntCancDia_AcuMes_NaoRevertidos  
      ,[aproveitamento_mes] = @IntCancDia_AcuMes_Porcentagem  
      ,[cancelamentos_efetivos] = @TerContRealDia_CancEfetivosMes  
      ,[cancelamentos_tendencia] = @TerContRealMes_Tendencia  
    ,[meta] = (SELECT top 1 meta FROM [bdSIC].[dbo].[tblCancelamentos_Mes_Meta] where mesref = convert(varchar(6),@data_atual,112))  
      ,[data_atualizacao] = GETDATE()  
   ,[certContactadas] = @SegContRealDia_Realizados  
      ,[certRevertidas] = @SegContRealDia_Revertidos  
      ,[certdoDia] = @SegContRealDia_NaoRevertidos  
      ,[cerSemContato] = @SegContRealDia_ContatoSemSucesso  
      ,[certContactadas_mes] = @SegContRealDia_AcuMes_Realizados  
      ,[certRevertidas_mes] = @SegContRealDia_AcuMes_Revertidos  
      ,[certdoMes] = @SegContRealDia_AcuMes_NaoRevertidos  
      ,[cerSemContato_mes] = @SegContRealDia_AcuMes_ContatoSemSucesso  
  
  UPDATE [bdSic].[dbo].[tblCentral_Atendimento_Intencoes_Cancelamentos_Mensal]  
  SET    [realizadas] = @SegContRealDia_AcuMes_Realizados  
        ,[revertidas] = @SegContRealDia_AcuMes_Revertidos  
        ,[nao_revertidas] = @SegContRealDia_AcuMes_NaoRevertidos  
     ,[sem_sucesso] = @SegContRealDia_AcuMes_ContatoSemSucesso  
    ,[desconsideracoes] = @TerContRealMes_Desconsideracao  
    ,[me] = (@IntCancDia_AcuMes_ME + @SegContRealDia_AcuMes_ME + @TerContRealMes_ME)  
  
 UPDATE [bdSic].[dbo].[tblCentral_Atendimento_Fechamento_Mensal]  
  SET qtde = @IntCancDia_AcuMes_Recebidos  
  WHERE mesref = CONVERT(VARCHAR(6),GETDATE(),112)   
 AND tpCodigo = 1  
  
  
  UPDATE [bdSic].[dbo].[tblCentral_Atendimento_Fechamento_Mensal]  
  SET qtde = @IntCancDia_AcuMes_Revertidos  
  WHERE mesref = CONVERT(VARCHAR(6),GETDATE(),112)   
 AND tpCodigo = 2  
  
  
 UPDATE [bdSic].[dbo].[tblCentral_Atendimento_Certificacoes]  
 SET cenNoPrazo = @SegContRealDia_AcuMes_PendentesNoPrazo,  
      cenForaPrazo = @SegContRealDia_AcuMes_PendentesForaDoPrazo,  
      operNoPrazo = @Cancelamentos_noprazo,  
      operForaPrazo = @Cancelamentos_foraprazo,  
      demaisNoPrazo = @DemaisProcessos_noprazo,  
      demaisForaPrazo = @DemaisProcessos_foraprazo,  
      cobNoPrazo = @Cobranca_noprazo,  
      cobForaPrazo = @Cobranca_foraprazo,  
      hotNoPrazo = @noShow_noprazo,  
      hotForaPrazo = @noShow_foraprazo,  
   finNoPrazo = @financeiro_NoPrazo,  
   finForaPrazo = @financeiro_ForaPrazo  
 DROP TABLE #tempTarefas  
  
END