--SERVIDOR HOMOLOGAÇÃO - "VERSÃO ANTIGA"
USE [siscoob]
GO
/****** Object:  StoredProcedure [dbo].[sp_API_VFB_Reservas_Notificar_U]    Script Date: 04/02/2025 12:01:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ricardo Brusch
-- Create date: 07/08/2024
-- Description: Atualizar reservas já notificadas
-- =============================================
ALTER PROCEDURE [dbo].[sp_API_VFB_Reservas_Notificar_U]
	@in_vfbIdentifier VARCHAR(6),
	@in_notificar_vfb  INT = 0,
	@in_notificar_coob INT = 0,
	@in_status         INT = 0,
	@in_erro_msg       NVARCHAR(MAX) = NULL
AS
BEGIN
	SET LANGUAGE BRAZILIAN

	IF @in_notificar_vfb > 0
		UPDATE tblHoteis_Reservas_Online_Controle_VFB SET vfbNotificacao = 1 WHERE vfbIdentifier = @in_vfbIdentifier

	IF @in_notificar_coob > 0
		UPDATE tblHoteis_Reservas_Online_Controle_VFB SET sitCodigo = @in_status WHERE vfbIdentifier = @in_vfbIdentifier

	IF @in_erro_msg IS NOT NULL
	BEGIN
		DECLARE @texto_log NVARCHAR(MAX)

		SET @texto_log =  '[' + CONVERT(nvarchar, GETDATE(), 120) + '] ' + @in_erro_msg + ' ;;'
		UPDATE tblHoteis_Reservas_Online_Controle_VFB SET logs = @texto_log + ISNULL(logs, '')  WHERE vfbIdentifier = @in_vfbIdentifier
	END 

	--UPDATE tblHoteis_Reservas_Online_Controle_VFB SET sitCodigo = @sitCodigo, vfbNotificacao = @in_notificar_vfb, logs = @in_erro_msg WHERE vfbIdentifier = @in_vfbIdentifier
	
	SELECT 1 AS sucesso, 0 AS erro, 'Registro atualizado com sucesso' AS mensagem
	
	RETURN

END;