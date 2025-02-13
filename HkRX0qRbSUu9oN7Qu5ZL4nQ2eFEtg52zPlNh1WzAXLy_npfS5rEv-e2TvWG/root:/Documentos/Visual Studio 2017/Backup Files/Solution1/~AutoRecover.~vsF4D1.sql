Use DBADataEX;

DECLARE @HtmlOutput VARCHAR(MAX), @Header VARCHAR(4000);

SELECT 
			[Nm_Server] [Server],
			[Nm_Database] [Database],
			[Actual_Size] [Actual Size (MB)],
			[Growth_1_day] [Growth 1 Day (MB)],
			[Growth_15_days] [Growth 15 Days (MB)],
			[Growth_30_days] [Growth 30 Days (MB)],
			[Growth_60_days] [Growth 60 Days (MB)]
		INTO ##Email_HTML5
		FROM (
			SELECT	TOP 10
					[Nm_Server], 
					[Nm_Database], 
					ISNULL([Actual_Size], 0) AS [Actual_Size],
					ISNULL([Growth_1_day] , 0) AS [Growth_1_day],
					ISNULL([Growth_15_days] , 0) AS [Growth_15_days], 
					ISNULL([Growth_30_days], 0) AS [Growth_30_days],
					ISNULL([Growth_60_days], 0) AS [Growth_60_days]
			FROM [dbo].[dtx_tb_CheckList_Database_Growth_Email]
			WHERE [Nm_Server] IS NOT NULL		
				
			UNION
				
			SELECT	[Nm_Server], 
					[Nm_Database], 
					ISNULL([Actual_Size], 0) AS [Actual_Size],
					ISNULL([Growth_1_day] , 0) AS [Growth_1_day],
					ISNULL([Growth_15_days] , 0) AS [Growth_15_days], 
					ISNULL([Growth_30_days], 0) AS [Growth_30_days],
					ISNULL([Growth_60_days], 0) AS [Growth_60_days]
			FROM [dbo].[dtx_tb_CheckList_Database_Growth_Email]
			WHERE [Nm_Server] IS NULL		) A	

			SET @Header = 'TOP 10 - Crescimento das Bases';				
			  	
	
	EXEC dbo.dtx_sp_Export_Table_HTML_Output
		@Ds_Tabela = '##Email_HTML5', -- varchar(max)
		@Ds_Alinhamento  = 'center',
		@Ds_OrderBy = '[Server] DESC,[Growth 1 Day (MB)] DESC,[Actual Size (MB)] DESC',
		@Ds_Saida = @HtmlOutput OUTPUT;

	DROP TABLE ##Email_HTML5	

	PRINT @HtmlOutput;