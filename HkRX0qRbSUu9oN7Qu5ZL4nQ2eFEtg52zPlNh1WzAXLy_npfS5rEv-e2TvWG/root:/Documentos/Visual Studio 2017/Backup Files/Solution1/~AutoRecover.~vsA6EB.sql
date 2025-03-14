USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_Job_Associados_Indicacoes_Clube_Indicador]    Script Date: 07/03/2025 10:52:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
##################################################
SISTEMA  : SisCoob
OBJETIVO : Job que incluí Indicadores no Clube do Indicador
AUTOR    : Rafael Bertoluci
DATA     : 02/02/2018
----------------------------------------------
ALTERAÇÃO
OBJETIVO : Realizado alteração na contagem das indicações premiadas devido a nova regra	
AUTOR    : Rafael Bertoluci
DATA     : 26/07/2018
----------------------------------------------
ALTERAÇÃO
OBJETIVO : Colocado para gerar agendas no Triton de Indicação Premiada e Clube do Indicador.
AUTOR    : Guilherme Feltes
DATA     : 11/12/2018
----------------------------------------------
ALTERAÇÃO
OBJETIVO : Alterado modo de geração das Agendas no Triton, agora utiliza a sp_Agenda_Espera_S
AUTOR    : Guilherme Feltes
DATA     : 07/02/2019
----------------------------------------------
ALTERAÇÃO
OBJETIVO : Retirado Agendas do JOB e criado nova procedure para executar as agendas
AUTOR    : Rafael Bertoluci
DATA     : 11/06/2019
----------------------------------------------
##################################################

EXEC [sp_Job_Associados_Indicacoes_Clube_Indicador]

*/

ALTER PROCEDURE [dbo].[sp_Job_Associados_Indicacoes_Clube_Indicador]
AS

BEGIN

	DECLARE @dataIndicacao DATETIME = '01/11/2016 00:00:00' -- Data da Alteração na Indicação Premiada
	DECLARE @dataCorte DATETIME = '01/01/2018 00:00:00' -- Data da alteração da contagem de indicações
	DECLARE @usuCodigo INT
	DECLARE @conCodigo INT
	DECLARE @agePrazo DATETIME
	DECLARE @assunto  VARCHAR(40)

/*
	SELECT AI.indiCodigo,
		 		 AI.indiIndicador,
				 AI.indiIndicado,
				 AI.tpplCodigo,
				 AI.plCodigo
	INTO #temp
	FROM tblAssociados_Indicacoes AI WITH(NOLOCK)
	LEFT JOIN tblAssociados_Indicadores_Bloqueados AIB WITH(NOLOCK)
	ON AI.indiIndicador = AIB.assNic
	WHERE AI.indiIndicador > 0
	AND AIB.assNic IS NULL
	AND (SELECT TOP 1 APM.menDtpagamento 
				FROM tblAssociados_Planos_Mensalidades APM WITH(NOLOCK)
				WHERE APM.assNic = AI.indiIndicado 
				AND APM.tpplCodigo = AI.tpplCodigo 
				AND APM.plCodigo = AI.plCodigo
				AND APM.menParcela = 3 
				AND APM.menDtpagamento IS NOT NULL 
				AND menAno = 1 
				AND APM.mentpcodigo = 2) BETWEEN @dataIndicacao AND @dataCorte
	ORDER BY AI.indiIndicador


	SELECT indiIndicado,
				 qtde = COUNT(indiCodigo)
	INTO #tempControle
	FROM #temp
	GROUP BY IndiIndicado
	HAVING (COUNT(indiCodigo) > 1)


	SELECT Ordem = ROW_NUMBER()OVER (PARTITION BY T.indiIndicador ORDER BY T.indiCodigo DESC,T.indiIndicado),
				 T.*
	INTO #tempDelete
	FROM #temp T
	INNER JOIN #tempControle TC
	ON T.indiIndicado = TC.Indiindicado


	DELETE #temp
	WHERE indiCodigo IN (SELECT indiCodigo FROM #tempDelete WHERE Ordem > 1)

*/

	--INSERT INTO #temp
	SELECT AI.indiCodigo,
		 		 AI.indiIndicador,
				 AI.indiIndicado,
				 AI.tpplCodigo,
				 AI.plCodigo
	INTO #temp
	FROM tblAssociados_Indicacoes AI WITH(NOLOCK)
	LEFT JOIN tblAssociados_Indicadores_Bloqueados AIB WITH(NOLOCK)
	ON AI.indiIndicador = AIB.assNic
	WHERE AI.indiIndicador > 0
	AND AIB.assNic IS NULL
	--AND AI.IndiIndicador = 6826469
	AND (SELECT TOP 1 APM.menDtpagamento 
				FROM tblAssociados_Planos_Mensalidades APM WITH(NOLOCK)
				WHERE APM.assNic = AI.indiIndicado 
				AND APM.tpplCodigo = AI.tpplCodigo 
				AND APM.plCodigo = AI.plCodigo
				AND APM.menParcela = 3 
				AND APM.menDtpagamento IS NOT NULL 
				AND menAno = 1 
				AND APM.mentpcodigo = 2) >= @dataCorte
	AND NOT EXISTS(SELECT menCodigo FROM tblAssociados_Planos_Mensalidades M WITH(NOLOCK) 
								 WHERE M.menDtpagamento IS NULL 
								 AND M.assNic = AI.indiIndicado
								 AND M.tpplCodigo = AI.tpplCodigo
								 AND M.plCodigo = AI.plCodigo
								 AND M.menParcela <= 3 
								 AND M.menAno = 1 
								 AND M.sitcodigo != 4)
	AND NOT EXISTS(SELECT TOP 1 1 FROM tblAssociados_Indicacoes_Clube_Indicador_Indicacoes AICII WITH(NOLOCK) 
								 WHERE AICII.indIndicado = AI.indiIndicado
								 AND AICII.indPlCodigo = AI.tpplCodigo
								 AND AICII.indTpPlCodigo = AI.tpplCodigo)
	ORDER BY AI.indiIndicador



	-- Indicações aptas
	SELECT DISTINCT NIC_Indicador = AI.indiIndicador
								 ,Nome_Indicador = ISNULL((SELECT assNome_RazaoSocial FROM tblAssociados WITH (NOLOCK) WHERE assnic = AI.indiIndicador),'')
								 ,Nic_Indicado = AI.indiIndicado
								 ,Nome_Indicado = ISNULL((SELECT assNome_RazaoSocial FROM tblAssociados WITH (NOLOCK) WHERE assnic = AI.indiIndicado),'')
								 ,Plano = AI.plCodigo
								 ,Tipo_Plano = AI.tpplCodigo
								 ,Venda_Plano_Indicado = CONVERT(VARCHAR(10),AI.indiData,103)
								 ,Pgto_3_mensal_Indicado = CONVERT(VARCHAR(10),(SELECT TOP 1 APM.menDtpagamento FROM tblAssociados_Planos_Mensalidades APM WITH(NOLOCK)
																																WHERE APM.assNic = AI.indiIndicado 
																																AND APM.tpplCodigo = AI.tpplCodigo 
																																AND APM.plCodigo = AI.plCodigo
																																AND APM.menParcela = 3 
																																AND APM.menDtpagamento IS NOT NULL 
																																AND menAno = 1
																																AND APM.mentpcodigo = 2),103)
								 ,Deletar = 0
	INTO #TempIndicacao  --JH descomentei para rodar o job!
	FROM tblAssociados_indicacoes AI WITH(NOLOCK)
	INNER JOIN #TEMP T
	ON  AI.indiIndicador = T.indiIndicador
	AND AI.indiIndicado = T.indiIndicado
	AND AI.tpplCodigo = T.tpplCodigo
	AND AI.plCodigo = T.plCodigo
	LEFT JOIN tblAssociados_Planos_Tipos APT WITH(NOLOCK)
	ON AI.tpPlCodigo = APT.tpplCodigo 
	WHERE NOT EXISTS(SELECT menCodigo FROM tblAssociados_Planos_Mensalidades M WITH(NOLOCK) 
									 INNER JOIN tblAssociados_Planos P WITH(NOLOCK)
									 ON P.assnic = M.assnic 
									 AND P.plCodigo = M.plCodigo
									 WHERE M.menMesref <= P.plUltima_Cobranca 
									 AND M.menDtpagamento IS NULL 
									 AND M.assNic = AI.indiIndicado
									 AND M.menParcela <= 3 
									 AND M.menAno = 1 
									 AND M.sitcodigo <> 5 
									 AND P.sitCodigo in (8,9))
	AND NOT EXISTS(SELECT TOP 1 1 FROM tblAssociados_Indicacoes_Clube_Indicador_Indicacoes WITH(NOLOCK) 
								 WHERE assNic = AI.indiIndicador
								 AND   indIndicado = AI.indiIndicado
								 AND   indPlCodigo = AI.plCodigo
								 AND   indTpPlCodigo = AI.tpplCodigo)
	ORDER BY Nome_indicador



	SELECT NIC_Indicador = indiIndicador,
				 QrdeIndicado = COUNT(indiCodigo)
	INTO #tempIndicador
	FROM #Temp
	GROUP BY indiIndicador
	ORDER BY indiIndicador



	SELECT DISTINCT NIC_Indicador,
									QrdeIndicado,
									ID = ROW_NUMBER()OVER (ORDER BY Nic_Indicador)
	INTO #tempValidacao
	FROM #tempIndicador T
	LEFT JOIN tblAssociados_Indicacoes_Clube_Indicador AICI WITH(NOLOCK)
	ON T.Nic_Indicador = AICI.assnic
	--WHERE AICI.assnic IS NULL

		BEGIN TRANSACTION

			DECLARE @mensagem VARCHAR(100)
			DECLARE @clubPremCodigo INT
			DECLARE @qtdeIndicacoes INT

			-- Insere Indicador no Clube do Indicador
	  
			DECLARE @clubCodigo INT
			DECLARE @NIC_Indicador INT
			DECLARE @count INT = 1

			WHILE @count <= (SELECT MAX(ID) FROM #tempValidacao WITH(NOLOCK))
				BEGIN
			  
					SET @NIC_Indicador = (SELECT NIC_Indicador FROM #tempValidacao WITH(NOLOCK) WHERE ID = @count)

					IF NOT EXISTS(SELECT TOP 1 1 FROM tblAssociados_Indicacoes_Clube_Indicador (NOLOCK) WHERE assNic = @NIC_Indicador)
						BEGIN

							INSERT INTO tblAssociados_Indicacoes_Clube_Indicador (assNic,catCodigo,clubDataEntrada,clubQtdeIndicacoes,clubPremCodigo,clubDataAtualizacao)
							SELECT DISTINCT TI.NIC_Indicador,
															catCodigo = CASE WHEN TV.QrdeIndicado BETWEEN 5 AND 9 THEN 1
																							 WHEN TV.QrdeIndicado BETWEEN 10 AND 14 THEN 2
																							 WHEN TV.QrdeIndicado BETWEEN 15 AND 19 THEN 3
																							 WHEN TV.QrdeIndicado >= 20 THEN 4 
																							 ELSE NULL END,
															clubDataEntrada = GETDATE(),
															clubQtdeIndicacoes = TV.QrdeIndicado,
															clubPremCodigo = CASE WHEN TV.QrdeIndicado BETWEEN 5 AND 9 THEN 1
																										WHEN TV.QrdeIndicado BETWEEN 10 AND 14 THEN 2
																										WHEN TV.QrdeIndicado BETWEEN 15 AND 19 THEN 3
																										WHEN TV.QrdeIndicado >= 20 THEN 4 
																										ELSE NULL END,
															clubDataAtualizacao = GETDATE()
							FROM #TempIndicacao TI
							INNER JOIN #tempValidacao TV
							ON TI.NIC_Indicador = TV.NIC_Indicador
							WHERE TI.NIC_Indicador =  @NIC_Indicador 
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível Inserir o indicador no Clube do Indicador! Por Favor Verifique.'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@NIC_Indicador,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END
					END

					SET @clubCodigo = SCOPE_IDENTITY()
				
					INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Indicacoes (clubCodigo,assnic,indIndicado,indPlCodigo,indTpPlCodigo,indDataDisponibilidade,indDisponivel)
					SELECT  @clubCodigo,
									Nic_Indicador,
									Nic_Indicado,
									Plano,
									Tipo_Plano,
									indDataDisponibilidade = Pgto_3_mensal_Indicado,
									indDisponivel = 1
					FROM #TempIndicacao
					WHERE NIC_Indicador = @NIC_Indicador
					IF @@ERROR <> 0
						BEGIN
							SET @mensagem = 'Não foi possível Inserir as Indicações do Indicador no Clube do Indicador! Por Favor Verifique.'
							INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@NIC_Indicador,@mensagem,GETDATE(),0)
							ROLLBACK TRANSACTION 
							RETURN
						END


					-- Envia Email para o Associado informando sua entrada no Clube do Indicador
					--EXEC [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Envia_Email2] @NIC_Indicador
					IF @@ERROR <> 0
						BEGIN
							SET @mensagem = 'Não foi possível encaminhar e-mail para o Indicador! Por Favor Verifique.'
							INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@NIC_Indicador,@mensagem,GETDATE(),0)
							ROLLBACK TRANSACTION 
							RETURN
						END
					
					SET @count = @count + 1
					
				END



			IF EXISTS(SELECT TOP 1 1 FROM #TempIndicacao TI
								LEFT JOIN #tempValidacao TV
								ON TI.NIC_Indicador = TV.NIC_Indicador
			       		WHERE TV.NIC_Indicador IS NULL)   -- Acrescenta novas indicações ao indicador
				BEGIN
	  
					DECLARE @Indicador INT
					DECLARE @atuClubCodigo INT
					DECLARE @countA INT = 1
					DECLARE @catCodigo INT

					TRUNCATE TABLE tmp_Associados_Indicacoes_Clube_Indicador_Agendas

					SELECT TI.NIC_Indicador,
								 ID = ROW_NUMBER()OVER (ORDER BY TI.NIC_Indicador)
					INTO #TempAtualiza
					FROM #TempIndicacao TI
					LEFT JOIN #tempValidacao TV
					ON TI.NIC_Indicador = TV.NIC_Indicador
					WHERE TV.NIC_Indicador IS NULL

					WHILE @countA <= (SELECT MAX(ID) FROM #TempAtualiza)
						BEGIN

							SET @Indicador = (SELECT Nic_Indicador FROM #TempAtualiza WHERE ID = @countA)

							SET @atuClubCodigo = (SELECT clubCodigo FROM tblAssociados_Indicacoes_Clube_Indicador WHERE assNic = @Indicador)
				
							INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Indicacoes (clubCodigo,assnic,indIndicado,indPlCodigo,indTpPlCodigo,indDataDisponibilidade,indDisponivel)
							SELECT @atuClubCodigo,
							       NIC_Indicador,
										 Nic_Indicado,
										 Plano,
										 Tipo_Plano,
										 Pgto_3_mensal_Indicado,
										 1
							FROM #TempIndicacao 
							WHERE NIC_Indicador = @Indicador
							AND Nic_Indicado NOT IN (SELECT AICII.indIndicado FROM tblAssociados_Indicacoes_Clube_Indicador_Indicacoes AICII WITH(NOLOCK) WHERE AICII.assnic = @Indicador AND AICII.indIndicado = Nic_Indicado AND AICII.indPlCodigo = Plano)
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível Inserir novas Indicações do Indicador no Clube do Indicador! Por Favor Verifique.'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END


							SET @qtdeIndicacoes = (SELECT [siscoob].[dbo].[fn_Associados_Indicacoes_Clube_Indicador_Indicacoes](@Indicador))


							IF @qtdeIndicacoes > 4
								SELECT @catCodigo =  (CASE WHEN @qtdeIndicacoes BETWEEN 5 AND 9 THEN 1
																					 WHEN @qtdeIndicacoes BETWEEN 10 AND 14 THEN 2
													 								 WHEN @qtdeIndicacoes BETWEEN 15 AND 19 THEN 3
																					 WHEN @qtdeIndicacoes >= 20 THEN 4 END)
							ELSE
								SET @catCodigo = NULL

/*
							IF @qtdeIndicacoes BETWEEN 1 AND 3
								BEGIN
									SELECT TOP 1 @conCodigo=conCodigo,
															 @agePrazo=GETDATE()
									FROM   [bdCRM].[dbo].[Contatos](NOLOCK)
									WHERE  assNic=@NIC_Indicador
									AND    conExcluido IS NULL
									--EXEC [bdCRM].[dbo].[sp_Agenda_Automatica_S] 'Indicação Premiada',@agePrazo,@usuCodigo,@conCodigo,0
									SET @assunto = (SELECT ageAssunto FROM [bdCRM].[dbo].[tblAgendas_Assuntos](NOLOCK) WHERE assCodigo=5)
									EXEC [bdCRM].[dbo].[sp_Agenda_Espera_S] @assunto,@agePrazo,@conCodigo
									IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Inserir novas Agendas de Indicação Premiada! Por Favor Verifique.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END
								END
							ELSE IF @qtdeIndicacoes BETWEEN 4 AND 20
								BEGIN
									SELECT TOP 1 @conCodigo=conCodigo,
															 @agePrazo=GETDATE()
									FROM   [bdCRM].[dbo].[Contatos] (NOLOCK)
									WHERE  assNic=@NIC_Indicador
									AND    conExcluido IS NULL
									--EXEC [bdCRM].[dbo].[sp_Agenda_Automatica_S] 'Clube do Indicador',@agePrazo,@usuCodigo,@conCodigo,0
									SET @assunto = (SELECT ageAssunto FROM [bdCRM].[dbo].[tblAgendas_Assuntos](NOLOCK) WHERE assCodigo=4)
									EXEC [bdCRM].[dbo].[sp_Agenda_Espera_S] @assunto,@agePrazo,@conCodigo
									IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Inserir Agendas do Clube do Indicador! Por Favor Verifique.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END
								END

*/
							-- Insere na Tabela temporária que criará as agendas para o Clube do Indicador	
							INSERT INTO tmp_Associados_Indicacoes_Clube_Indicador_Agendas VALUES (@NIC_Indicador,@qtdeIndicacoes) 
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível Inserir novas Agendas de Indicação Premiada! Por Favor Verifique.'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END



							IF (SELECT catCodigo FROM tblAssociados_Indicacoes_Clube_Indicador WITH(NOLOCK) WHERE assnic = @Indicador) <> @catCodigo
								BEGIN

									SET @clubPremCodigo = (SELECT clubPremCodigo FROM tblAssociados_Indicacoes_Clube_Indicador_Premios WITH(NOLOCK) WHERE catCodigo = @catCodigo)
					  
									UPDATE tblAssociados_Indicacoes_Clube_Indicador
									SET catCodigo = @catCodigo,
						  				clubQtdeIndicacoes = @qtdeIndicacoes,
											clubPremCodigo = @clubPremCodigo,
											clubDataAtualizacao = GETDATE()
									WHERE assnic = @Indicador
		  						IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Atualizar as Informações do Indicador! Por Favor Verifique.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END

								END
							ELSE
							 BEGIN

							    SET @clubPremCodigo = (SELECT clubPremCodigo FROM tblAssociados_Indicacoes_Clube_Indicador_Premios WITH(NOLOCK) WHERE catCodigo = @catCodigo)
					  
									UPDATE tblAssociados_Indicacoes_Clube_Indicador
									SET catCodigo = @catCodigo,
											clubPremCodigo = @clubPremCodigo,
						  				clubQtdeIndicacoes = @qtdeIndicacoes,
											clubDataAtualizacao = GETDATE()
									WHERE assnic = @Indicador
		  						IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Atualizar as Informações do Indicador! Por Favor Verifique.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@Indicador,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END

								END

							SET @countA = @countA + 1

						END		  

					DROP TABLE #TempAtualiza

				END

			-- Verifica se a indicação vai expirar, se sim retira o associado do clube do indicador	

				IF EXISTS(SELECT TOP 1 1 
									FROM tblAssociados_Indicacoes_Clube_Indicador_Indicacoes WITH(NOLOCK)
									WHERE DATEADD(YEAR,3,indDataDisponibilidade) < GETDATE())
					BEGIN
		  
						DECLARE @assnic INT
						DECLARE @indIndicado INT
						DECLARE @indPlCodigo INT

						DECLARE Indicacoes_Expiradas CURSOR FOR

						SELECT DISTINCT AICI.assnic,	
														AICII.indIndicado,
														AICII.indPlCodigo										 
						FROM tblAssociados_Indicacoes_Clube_Indicador AICI WITH(NOLOCK) 
						INNER JOIN tblAssociados_Indicacoes_Clube_Indicador_Indicacoes AICII WITH(NOLOCK)
						ON AICI.assnic = AICII.assnic
						WHERE DATEADD(YEAR,3,AICII.indDataDisponibilidade) < GETDATE()

						OPEN Indicacoes_Expiradas
								FETCH NEXT FROM Indicacoes_Expiradas
											INTO @assnic,@indIndicado,@indplCodigo
								 
						WHILE (@@FETCH_STATUS = 0)
							BEGIN
				  
								EXEC [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Indicacoes_E] @assnic,@indIndicado,@indPlCodigo
								IF @@ERROR <> 0
									BEGIN
										SET @mensagem = 'Não foi possível Retirar as Indicações Expiradas do Indicador! Por Favor Verifique.'
										INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnic,@mensagem,GETDATE(),0)
										ROLLBACK TRANSACTION 
										RETURN
									END

					 
								FETCH NEXT FROM Indicacoes_Expiradas
											INTO @assnic,@indIndicado,@indplCodigo

							END
						CLOSE Indicacoes_Expiradas
						DEALLOCATE Indicacoes_Expiradas	
					
					END

			-- Premiação no Clube do Indicador

			IF EXISTS(SELECT premCodigo FROM tblAssociados_Indicacoes_Clube_Indicador_Premiacoes WITH(NOLOCK) WHERE premData IS NULL AND premDataOpcao IS NOT NULL)
				BEGIN

					DECLARE @tpplCodigo INT
					DECLARE @assNome_RazaoSocial VARCHAR(300)
					DECLARE @assCPF_CNPJ VARCHAR(20)
					DECLARE @validadeInicial DATETIME
					DECLARE @validadeFinal DATETIME
					DECLARE @qtdeDiarias INT
					DECLARE @hisMotivo VARCHAR(1000)
					DECLARE @assnicTickets INT
					DECLARE @tktCodigo INT
					DECLARE @tktCortesia VARCHAR(30)
					DECLARE @premCodigo INT
					DECLARE @premClubCodigo INT
					DECLARE @categoriaCodigo INT
					DECLARE @premQtdeIndicacoes INT
			  
					DECLARE Premiacao_Automatica CURSOR FOR
					SELECT premCodigo,
								 assnic,
								 clubPremCodigo
					FROM tblAssociados_Indicacoes_Clube_Indicador_Premiacoes WITH(NOLOCK)
					WHERE premDataOpcao IS NOT NULL
					AND   premData IS NULL

					OPEN Premiacao_Automatica
							FETCH NEXT FROM Premiacao_Automatica
										INTO @premCodigo,@assnicTickets,@premClubCodigo

					/* COMEÇA AQUI O LOOPING P PERCORRER O CURSOS */

					WHILE @@FETCH_STATUS = 0
						BEGIN
					  
							SELECT @tpplCodigo = ISNULL(AICIPP.premOpcaoTpPlCodigo,AICIP.clubPremTpPlCodigo),
										 @assNome_RazaoSocial = A.assNome_RazaoSocial,
										 @assCPF_CNPJ = CONVERT(VARCHAR(20),CONVERT(DECIMAL(18,0),A.assCPF_CNPJ)),
										 @validadeInicial = CONVERT(VARCHAR(10),GETDATE(),103),
										 @validadeFinal = CONVERT(VARCHAR(10),DATEADD(YEAR,1,GETDATE()),103),
										 @qtdeDiarias = AICIP.clubPremQtdeDiarias,
										 @categoriaCodigo = AICIIC.catCodigo,
										 @hisMotivo = 'Premiação Clube do Indicador, categoria '+AICIIC.catDescricao+', '+clubPremDescricao+' com data de escolha em '+CONVERT(VARCHAR(10),AICIPP.premDataOpcao,103)+'.'
							FROM tblAssociados_Indicacoes_Clube_Indicador_Premios AICIP WITH(NOLOCK)
							INNER JOIN tblAssociados_Indicacoes_Clube_Indicador_Premiacoes AICIPP WITH(NOLOCK)
							ON AICIP.clubPremCodigo = AICIPP.clubPremCodigo
							INNER JOIN tblAssociados A WITH(NOLOCK)
							ON AICIPP.assnic = A.assNic
							INNER JOIN tblAssociados_Indicacoes_Clube_Indicador_Categorias AICIIC WITH(NOLOCK)
							ON AICIP.catCodigo = AICIIC.catCodigo
							WHERE AICIPP.premCodigo = @premCodigo 

							SET @tktCortesia = ''

							IF @categoriaCodigo = 4
								BEGIN
							  
									DECLARE @contador INT = 1

									SET @qtdeDiarias = 2

									WHILE @contador <= 2
										BEGIN

											EXEC [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Tickets_Cortesia_S]
											@tpPlCodigo,
											@assNome_RazaoSocial,
											@assCPF_CNPJ,
											@validadeInicial,
											@validadeFinal,
											@qtdeDiarias,
											@hisMotivo,
											@assnicTickets,
											@tktCodigo OUTPUT
											IF @@ERROR <> 0
												BEGIN
													SET @mensagem = 'Não foi possível Gerar Tickets Cortesia para o Associado! Por Favor Verifique.'
													INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
													ROLLBACK TRANSACTION 
													RETURN
												END

										 SET @tktCortesia = @tktCortesia+','+CONVERT(VARCHAR(15),@tktCodigo)

										 SET @contador = @contador + 1 

									 END
								END
							ELSE
								BEGIN

									EXEC [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Tickets_Cortesia_S]
									@tpPlCodigo,
									@assNome_RazaoSocial,
									@assCPF_CNPJ,
									@validadeInicial,
									@validadeFinal,
									@qtdeDiarias,
									@hisMotivo,
									@assnicTickets,
									@tktCodigo OUTPUT
									IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Gerar Tickets Cortesia para o Associado! Por Favor Verifique.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END

									SET @tktCortesia = @tktCodigo

								END

							-- Atualiza Dados da Premiação nas Tabelas Relacionadas

							UPDATE tblAssociados_Indicacoes_Clube_Indicador_Premiacoes
							SET premData = GETDATE(),
									premOpcaoTpPlCodigo = @tpPlCodigo, 
									premTktCodigo = @tktCortesia
							WHERE premCodigo = @premCodigo
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível Atualizar os Dados da Premiação. Atualização da tabela de Premiações'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END


							SELECT @qtdeIndicacoes = clubPremQtdeIndicacoes
							FROM tblAssociados_Indicacoes_Clube_Indicador_Premios WITH(NOLOCK)
							WHERE clubPremCodigo = @premClubCodigo

							DECLARE @countIndicacoes INT = 1
							DECLARE @indIndicadoAtualiza INT
							DECLARE @indPlCodigoAtualiza INT
							DECLARE @indTpPlCodigo INT

							SELECT ID = ROW_NUMBER()OVER (ORDER BY indDataDisponibilidade),
										 indIndicado,
										 indTpPlCodigo,
										 indPlCodigo,
										 indDataDisponibilidade
							INTO #tempAtualizacao
							FROM tblAssociados_Indicacoes_Clube_Indicador_Indicacoes AICII WITH(NOLOCK)
							WHERE assnic = @assnicTickets
							ORDER BY indDataDisponibilidade ASC

							/* PONTO DE ATENÇÃO*/
							WHILE @countIndicacoes <= (SELECT ID FROM #tempAtualizacao WHERE ID = @qtdeIndicacoes)
								BEGIN
							  
									SELECT @indIndicadoAtualiza = indIndicado,
												 @indPlCodigoAtualiza = indPlCodigo,
												 @indTpPlCodigo = indTpPlCodigo
									FROM #tempAtualizacao
									WHERE ID = @countIndicacoes							
													  

									UPDATE tblAssociados_Indicacoes_Clube_Indicador_Indicacoes
									SET    indDisponivel = 0,
												 premCodigo = @premCodigo
									WHERE indIndicado = @indIndicadoAtualiza
									AND   indPlCodigo = @indPlCodigoAtualiza
									AND   indTpPlCodigo = @indTpPlCodigo
									AND   indDisponivel = 1
									AND   premCodigo IS NULL
									IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível Atualizar os Dados da Premiação. Atualização da Tabela de Indicações'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END

									SET @countIndicacoes = @countIndicacoes + 1

								END

							DECLARE @catCodigoAtualiza INT = NULL
							DECLARE @clubPremCodigoAtualiza INT = NULL
							DECLARE @clubQtdeIndicacoes INT

							SET @clubQtdeIndicacoes = [dbo].[fn_Associados_Indicacoes_Clube_Indicador_Indicacoes](@assnicTickets)


							SET @catCodigoAtualiza = CASE WHEN @clubQtdeIndicacoes BETWEEN 5 AND 9 THEN 1
																						WHEN @clubQtdeIndicacoes BETWEEN 10 AND 14 THEN 2
																						WHEN @clubQtdeIndicacoes BETWEEN 15 AND 19 THEN 3
																						WHEN @clubQtdeIndicacoes >= 20 THEN 4 END 


           		SELECT @clubPremCodigoAtualiza = clubPremCodigo
							FROM tblAssociados_Indicacoes_Clube_Indicador_Premios WITH(NOLOCK)
							WHERE catCodigo = @catCodigoAtualiza 


							UPDATE tblAssociados_Indicacoes_Clube_Indicador
							SET clubQtdeIndicacoes = @clubQtdeIndicacoes,
									catCodigo = @catCodigoAtualiza,
									clubPremCodigo = @clubPremCodigoAtualiza,
									clubDataAtualizacao = GETDATE()
							WHERE assNic = @assnicTickets
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível Atualizar os Dados da Premiação. Atualização da Tabela do Clube do Indicador'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END

							-- Cadastro de Isenção de Taxa de Adesão


							IF @premClubCodigo > 1
								BEGIN
						    
									DECLARE @qtdeAnosIsencoes INT
									DECLARE @tpCodigo INT

									SELECT @qtdeAnosIsencoes = isenTpQtdeAnos,
												 @tpCodigo = isenTpCodigo
									FROM tblAssociados_Indicacoes_Clube_Indicador_Isencoes_Tipos WITH(NOLOCK)
									WHERE clubPremCodigo = @premClubCodigo
								
								
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Isencoes(assnic,isenData,isenDataInicial,isenDataFinal,isenDisponivel,isenTpCodigo,premCodigo)
									VALUES (@assnicTickets,GETDATE(),GETDATE(),DATEADD(YEAR,@qtdeAnosIsencoes,GETDATE()),1,@tpCodigo,@premCodigo)
									IF @@ERROR <> 0
										BEGIN
											SET @mensagem = 'Não foi possível salvar a isenção da taxa de adesão para novos Planos do Indicador.'
											INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
											ROLLBACK TRANSACTION 
											RETURN
										END


								END

							--- Envio do E-mail confirmando premiação
							EXEC [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Envia_Email_Premiacoes]@assnicTickets,@premCodigo
							IF @@ERROR <> 0
								BEGIN
									SET @mensagem = 'Não foi possível enviar e-mail confirmando a premiação no Clube do Indicador.'
									INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@assnicTickets,@mensagem,GETDATE(),0)
									ROLLBACK TRANSACTION 
									RETURN
								END

							DROP TABLE #tempAtualizacao

							FETCH NEXT FROM Premiacao_Automatica
										INTO @premCodigo,@assnicTickets,@premClubCodigo

						END
					CLOSE Premiacao_Automatica
					DEALLOCATE Premiacao_Automatica 
					/* FINAL */


				END


			COMMIT TRANSACTION


	DROP TABLE #temp
	--DROP TABLE #tempControle
	--DROP TABLE #tempDelete
	DROP TABLE #TempIndicacao
	DROP TABLE #tempIndicador
	DROP TABLE #tempValidacao



END