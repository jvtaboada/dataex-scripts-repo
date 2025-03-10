USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Indicacoes_E]    Script Date: 10/03/2025 11:31:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
##################################################
SISTEMA  : SisCoob - Clube do Indicador
OBJETIVO : Retira Indicação Expirada do Clube do Indicador
AUTOR    : Rafael Bertoluci
DATA     : 19/02/2018
-------------------------------------
##################################################


*/

ALTER PROCEDURE [dbo].[sp_Associados_Indicacoes_Clube_Indicador_Indicacoes_E]
(
	@in_assnic INT,
	@in_indIndicado INT,
	@in_indPlCodigo INT
)
AS

BEGIN

  DECLARE @mensagem VARCHAR(100)

  BEGIN TRANSACTION

	 -- Retira validade da indicação
	 UPDATE tblAssociados_Indicacoes_Clube_Indicador_Indicacoes
	 SET   indDisponivel = 0
	 WHERE assnic = @in_assnic
	 AND   indIndicado = @in_indIndicado
	 AND   indPlCodigo = @in_indPlCodigo
	 IF @@ERROR <> 0
	   BEGIN
		   SET @mensagem = 'Não foi possível retirar indicação do Clube do Indicador! Por Favor Verifique.'
			 INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@in_assnic,@mensagem,NULL,NULL)
			 ROLLBACK TRANSACTION 
			 RETURN
		 END


	BEGIN

		DECLARE @catCodigo INT
		DECLARE @qtdeIndicacoes INT

		SET @qtdeIndicacoes = (SELECT [siscoob].[dbo].[fn_Associados_Indicacoes_Clube_Indicador_Indicacoes](@in_assnic))

		IF @qtdeIndicacoes > 4
			SELECT @catCodigo =  (CASE WHEN @qtdeIndicacoes BETWEEN 5 AND 10 THEN 1
									   WHEN @qtdeIndicacoes BETWEEN 10 AND 14 THEN 2
									   WHEN @qtdeIndicacoes BETWEEN 15 AND 19 THEN 3
									   WHEN @qtdeIndicacoes >= 20 THEN 4 END)
		ELSE
		  SET @catCodigo = NULL

		IF (SELECT catCodigo FROM tblAssociados_Indicacoes_Clube_Indicador WITH(NOLOCK) WHERE assNic = @in_assnic) <> @catCodigo
      BEGIN
				  
				DECLARE @clubPremCodigo INT

				SET @clubPremCodigo = (SELECT clubPremCodigo FROM tblAssociados_Indicacoes_Clube_Indicador_Premios WITH(NOLOCK) WHERE catCodigo = @catCodigo)
				  
				UPDATE tblAssociados_Indicacoes_Clube_Indicador
				SET catCodigo = @catCodigo,
						clubQtdeIndicacoes = @qtdeIndicacoes,
						clubPremCodigo = @clubPremCodigo,
						clubDataAtualizacao = GETDATE()
				WHERE assnic = @in_assnic
				IF @@ERROR <> 0
	        BEGIN
		        SET @mensagem = 'Não foi possível Alterar as informações do Indicador! Por Favor Verifique.'
						INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@in_assnic,@mensagem,NULL,NULL)
			      ROLLBACK TRANSACTION 
			      RETURN
		      END

      END
		ELSE
			BEGIN

				UPDATE tblAssociados_Indicacoes_Clube_Indicador
				SET catCodigo = @catCodigo,
				    clubQtdeIndicacoes = @qtdeIndicacoes,
					  clubDataAtualizacao = GETDATE()
				WHERE assnic = @in_assnic
				IF @@ERROR <> 0
	        BEGIN
		        SET @mensagem = 'Não foi possível Alterar as informações do Indicador! Por Favor Verifique.'
						INSERT INTO tblAssociados_Indicacoes_Clube_Indicador_Erros VALUES (@in_assnic,@mensagem,NULL,NULL)
			      ROLLBACK TRANSACTION 
			      RETURN
		      END  

			END
  END

	
	COMMIT TRANSACTION
END
		