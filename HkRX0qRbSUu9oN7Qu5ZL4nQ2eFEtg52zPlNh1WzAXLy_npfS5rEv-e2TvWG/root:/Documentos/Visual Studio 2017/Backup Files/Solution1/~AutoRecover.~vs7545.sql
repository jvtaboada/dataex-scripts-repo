USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_Job_Hoteis_Negociacoes_Carteira]    Script Date: 27/02/2025 11:19:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
##########################################################################
SISTEMA  : Siscoob
OBJETIVO : Cadastro de Carteira de executivos de conta
AUTOR    : Marcos Fazio de Castro
DATA     : 23/04/2012
--------------------------------------------------------------------------
DATA ALTERACAO : 21/10/2015
OBJETIVO       : Aumentar variável ref. colunas hotNomeFantasia e hotRazao_Social de 50 p/ 60
AUTOR          : Jairo Schell
DATA           : 21/10/2015
--------------------------------------------------------------------------
DATA ALTERACAO : 03/07/2019
OBJETIVO       : Alterada estrutura de CURSOR
AUTOR          : Rafael Bertoluci
--------------------------------------------------------------------------
##########################################################################
*/
ALTER PROCEDURE [dbo].[sp_Job_Hoteis_Negociacoes_Carteira]  
 (@in_excCodigo INT)
AS

BEGIN
  DECLARE @count_exc INT
  DECLARE @num_exc INT
  DECLARE @excCodigo INT
  DECLARE @UFdescricao VARCHAR(2)
  DECLARE @count_hot INT
  DECLARE @num_hot INT
  DECLARE @hotCodigo INT
  DECLARE @hotCnpj VARCHAR(20)
  DECLARE @hotNomefantasia VARCHAR(60)
  DECLARE @hotCidade VARCHAR(30)
  DECLARE @hotUf VARCHAR(2)
  DECLARE @hotEmail VARCHAR(60)
  DECLARE @hotFone VARCHAR(15)
  DECLARE @contato VARCHAR(30)
  DECLARE @cargo VARCHAR(30)
  DECLARE @tipCodigo int
  DECLARE @hotCorCidade VARCHAR(10)

  DECLARE exc_cursor CURSOR FOR 
  SELECT DISTINCT TOP 100 PERCENT excCodigo,
																	 UFdescricao
  FROM tblHoteis_Negociacoes_Executivos_Conta_UFS WITH(NOLOCK)
  WHERE (excCodigo = @in_excCodigo OR @in_excCodigo IS NULL)

  OPEN exc_cursor
		FETCH NEXT FROM exc_cursor 
			INTO @excCodigo,@UFdescricao
  --SET @count_exc = 1
  --SET @num_exc = @@CURSOR_ROWS

  --WHILE @count_exc <= @num_exc
	WHILE @@FETCH_STATUS = 0
		BEGIN
    
		 -------- LOOP NOS HOTéIS
			DECLARE hot_cursor CURSOR FOR 
			SELECT DISTINCT TOP 100 PERCENT hotCodigo,
																			hotCnpj,
																			hotNomefantasia,
																			hotCidade,
																			hotUf,
																			hotEmail,
																			hotFone,
																			tipCodigo
			FROM tblHoteis WITH(NOLOCK)
			WHERE hotUf = @UFdescricao 
			AND hotcodigo NOT IN (SELECT hotCodigo FROM tblHoteis_Desativados WITH(NOLOCK)) 
			AND hotCnpj IS NOT NULL
			AND hotCidade IS NOT NULL  

			OPEN hot_cursor
				FETCH NEXT FROM hot_cursor 
					INTO @hotCodigo,@hotCnpj,@hotNomefantasia,@hotCidade,@hotUf,@hotEmail,@hotFone,@tipCodigo
			--SET @count_hot = 1
			--SET @num_hot = @@CURSOR_ROWS
insert
			--WHILE @count_hot <= @num_hot
			WHILE @@FETCH_STATUS = 0
				BEGIN
					

					SET @contato = NULL
					SET @cargo = NULL

					SELECT TOP 1 @contato = C.contNome,
											 @cargo = car.carDescricao				  
					FROM   tblHoteis_Contatos C WITH(NOLOCK)
					INNER  JOIN tblHoteis_Contatos_Cargo car WITH(NOLOCK) 
					ON     car.carCodigo = c.carCodigo
					WHERE  hotcodigo = @hotCodigo 
					ORDER  BY Car.carCodigo DESC
		 
					IF @hotCidade is NULL
						PRINT(@hotNomefantasia)

					--busca codigo da cidade - desativado. Tabela do ibge não tem POrto de galinhas por exemplo		
					--SET @hotCorCidade = rtrim(cast((SELECT munCodigo
					--FROM [tblIBGE_Municipios]
					--WHERE replace(dbo.fnTiraAcento(munDescricao),'''','') = dbo.fnTiraAcento(@hotCidade)) as VARCHAR(10)))
					--IF @hotCorCidade IS NULL
					--print(@hotNomefantasia)

					--busca e insert ou update		 
		--      IF EXISTS(SELECT TOP 1 carCodigo FROM tblHoteis_Negociacoes_Carteira WHERE carCnpj = @hotCnpj)
					IF EXISTS(SELECT TOP 1 carCodigo FROM tblHoteis_Negociacoes_Carteira WITH(NOLOCK) WHERE hotCodigo = @hotCodigo)
						BEGIN
							-- UPDATE
							UPDATE tblHoteis_Negociacoes_Carteira
							SET    carCNPJ = @hotCnpj,
										 carNomeHotel = @hotNomefantasia,
										 tpCodigo = 2,
										 redCodigo = @tipCodigo,
										 carUF = @hotUf,
										 carCidade = @hotCidade,
										 carTelefones = @hotFone,
										 hotCodigo = @hotCodigo,
										 carEmail = @hotEmail,
										 excCodigo = @excCodigo,
										 carContato = @Contato,
										 carCargo = @Cargo,
										 carDtAtualizacao = CONVERT(VARCHAR(10),GETDATE(),103)
							WHERE hotCodigo = @hotCodigo
		--          WHERE  carCnpj = @hotCnpj
						END
					ELSE 
						BEGIN
							-- INSERT
							INSERT INTO SisCoob.dbo.tblHoteis_Negociacoes_Carteira
												 (carCNPJ
												 ,carNomeHotel
												 ,tpCodigo
												 ,redCodigo
												 ,carUF
												 ,carCidade
												 ,carTelefones
												 ,hotCodigo
												 ,carEmail
												 ,excCodigo
												 ,carContato
												 ,carCargo
												 ,carDtAtualizacao)
							VALUES (@hotCnpj
										 ,@hotNomefantasia
										 ,2
										 ,@tipCodigo
										 ,@hotUf
										 ,@hotCidade
										 ,@hotFone
										 ,@hotCodigo
										 ,@hotEmail
										 ,@excCodigo
										 ,@Contato
										 ,@Cargo
										 ,CONVERT(VARCHAR(10),GETDATE(),103))
						END

			FETCH NEXT FROM hot_cursor 
					INTO @hotCodigo,@hotCnpj,@hotNomefantasia,@hotCidade,@hotUf,@hotEmail,@hotFone,@tipCodigo
					--SET @count_hot=@count_hot+1
		END

			CLOSE hot_cursor
			DEALLOCATE hot_cursor

		FETCH NEXT FROM exc_cursor 
			INTO @excCodigo,@UFdescricao
			--SET @count_exc=@count_exc+1
  END
	
  CLOSE exc_cursor
  DEALLOCATE exc_cursor
END

