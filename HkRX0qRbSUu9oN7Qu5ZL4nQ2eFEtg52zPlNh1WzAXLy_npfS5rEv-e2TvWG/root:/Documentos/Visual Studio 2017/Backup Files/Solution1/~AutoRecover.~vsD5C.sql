USE [DBADataEX]
GO
/****** Object:  StoredProcedure [dbo].[dtx_sp_Envia_Relatorio_Mensal]    Script Date: 27/01/2025 09:51:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dtx_sp_Envia_Relatorio_Mensal]
AS
BEGIN
	DECLARE @InstanceNameEmail NVARCHAR(100) = CAST(@@SERVERNAME AS NVARCHAR(100));
	DECLARE @InstanceNameFile NVARCHAR(100) = REPLACE(CAST(@@SERVERNAME AS NVARCHAR(100)),  '\', '_');
	DECLARE @FileName NVARCHAR(100) = @InstanceNameFile + '_' + FORMAT(GETDATE(), 'MM') + '_' + CAST(YEAR(GETDATE()) AS NVARCHAR(4));
	DECLARE @NextMonth DATE = DATEADD(MONTH, 1, GETDATE());
	DECLARE @Subject NVARCHAR(256) = 
		'[DataEX - Ascenty] Relatório Mensal - ' 
		+ FORMAT(@NextMonth, 'MM') + '/' 
		+ CAST(YEAR(@NextMonth) AS NVARCHAR(4));
	DECLARE @AttachmentPath NVARCHAR(MAX) = 'C:\DataEx\Rel\Relatorio_mensal_' + @FileName + '.html';
 
	DECLARE @Body NVARCHAR(MAX) = 
		'<html>
			<body style="display: flex; justify-content: center; align-items: center; height: 100%; margin: 0;">
 
				<div style="border: 1px dashed #F25022; padding: 20px; text-align: center; max-width: 600px;">
 
					<img src="https://sqlreports.blob.core.windows.net/reports/DataEX.png" alt="Logo da DataEX" style="max-width: 100%; height: auto; margin-bottom: 20px;">
					<h1>Prezados, bom dia!</h1>
					<h2><p>Desejamos a você e à sua equipe um excelente início de mês!</p></h2>
					<p>Segue em anexo o relatório mensal do ambiente <span style="color: #F25022;"><b>' + @InstanceNameEmail + '</b></span>, monitorado pela <b>Data<span style="color:#F25022;">EX</span></b>.</p>
					<br>
					<p>Qualquer dúvida ou sugestão, estamos à disposição!</p>
					<p>Atenciosamente,<br>Suporte <b>Data<span style="color:#F25022;">EX</span></b></p>

				</div>
			</body>
		</html>'

	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'ProfileDataEX',
		@recipients = 'suporte@dataex.com.br',
		@copy_recipients = 'edgard.broggio@dataex.com.br', 
		@subject = @Subject,
		@body = @Body,
		@body_format = 'HTML',
		@file_attachments = @AttachmentPath;
END