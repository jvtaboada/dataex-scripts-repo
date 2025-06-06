USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_API_VFB_Logs_C]    Script Date: 04/02/2025 12:09:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
##################################################
SISTEMA  : VFB - Reservas
OBJETIVO : Criar logs em etapas diversas no Fluxo de Reservas da VFB
AUTOR    : Ricardo Brusch
DATA     : 05/12/2024
*/

ALTER PROCEDURE [dbo].[sp_API_VFB_Logs_C]
	@in_referencia VARCHAR(100),
	@in_acao NVARCHAR(200)
AS
BEGIN  	
	SET LANGUAGE BRAZILIAN
	
	INSERT INTO 
		tblHoteis_Reservas_Online_Controle_VFB_Logs (referencia, acao)
	VALUES
	   ( @in_referencia, @in_acao )

END
