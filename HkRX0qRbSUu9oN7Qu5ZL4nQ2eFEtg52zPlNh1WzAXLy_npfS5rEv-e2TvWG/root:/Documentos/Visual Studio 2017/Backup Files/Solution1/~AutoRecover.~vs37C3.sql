USE [bdcrm]
GO
/****** Object:  StoredProcedure [dbo].[sp_job_Aniversariantes_Usuarios]    Script Date: 12/03/2025 10:20:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_job_Aniversariantes_Usuarios]
AS
BEGIN  
	SET LANGUAGE 'Portuguese'
	DECLARE @usuEmail VARCHAR(50)
	DECLARE @usuCodigo INT
	DECLARE @conCodigo INT
	DECLARE @conTelefoneCelular VARCHAR(20)
	DECLARE @conDDDCelular VARCHAR(10)
	DECLARE @usuNome VARCHAR(100)	
	DECLARE @count_ass INT
	DECLARE @num_ass INT
	DECLARE @count_ass1 INT
	DECLARE @num_ass1 INT	
	DECLARE @assnic INT

	DECLARE @body    VARCHAR(max)
	DECLARE @Email   VARCHAR(100)	
	DECLARE @senha   VARCHAR(20)
	DECLARE @codigo  INT
	DECLARE @hotCodigo INT
	DECLARE @nomeHotel VARCHAR(100)
	DECLARE @nomeCidade VARCHAR(100)


    DECLARE  aniversarios_cursor CURSOR FOR 
	 SELECT  c.empcodigo,conCodigo,usuCodigo,conDDDCelular,conTelefoneCelular,conEmail,assNic
	   FROM  Contatos  C WITH(NOLOCK)	   
	  WHERE  substring(convert(varchar(10),conNascimento,103),1,5) = substring(convert(varchar(10),GETDATE(),103),1,5)	
	  AND	 ISNULL(conEmail,'') <> ''
	  AND C.tipCodigo <> 1
	  AND C.tipCodigo <> 2
	  and empcodigo not in(43,44)
	OPEN aniversarios_cursor
	SET @count_ass = 1
	SET @num_ass = @@CURSOR_ROWS

	FETCH NEXT FROM aniversarios_cursor INTO @conCodigo, @usuCodigo,@conDDDCelular,@conTelefoneCelular,@usuEmail,@assnic     
    WHILE (@@FETCH_STATUS = 0)
		BEGIN	  
			SET @body='<!doctype html>
                <html xmlns="http://www.w3.org/1999/xhtml">
                	<head>
                	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
                	<title>Aniversariantes COOB+</title>
                	<!--<meta name="viewport" content="width=device-width, initial-scale=1.0"/>-->
                	<link rel="icon" href="http://marketingcoobmais.com.br/aniversariantes/images/favicon.ico">
                	</head>
                	<body style="margin: 0; padding: 0; text-decoration: none;">
                		<!-- INICIO DA TABELA / CONTEÚDO -->
                		<table border="0" cellpadding="0" cellspacing="0" width="509" style="background: #3c2c80" bgcolor="#3c2c80">
                			<!-- LINHA BASE 100% -->
                			<tr>
                				<td align="center" valign="top" bgcolor="#3c2c80"><!-- COLUNA BASE -->
                					<!-- TABELA DO CONTEÚDO -->
                					<table align="center" border="0" cellpadding="0" cellspacing="0" width="600" style="border-collapse: collapse; text-decoration: none">
                						<tr><!-- LINHA 1 -->
                							<td  align="center" bgcolor="#3c2c80" width="50" height="120" valign="top"><img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_01.png" width="50" height="120" alt="Clique para liberar e veja as informações" style="display: block" /><!-- COL ÚNICA -->
                                            
                                            </td><!-- COL 1 -->
                							<td  align="center" bgcolor="#3c2c80" width="509" height="120" valign="middle"><img src="http://marketingcoobmais.com.br/aniversariantes/images/coobmais-viagens.png" width="306" height="84" alt="Clique para liberar e veja as informações" style="display: block" /><!-- COL ÚNICA -->
                                            
                                            <td  align="center" bgcolor="#3c2c80" width="41" height="120" valign="top"><img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_03.png" width="41" height="120" alt="Clique para liberar e veja as informações" style="display: block" /><!-- COL ÚNICA -->
                                            
                                            </td><!-- COL 1 -->
                                            </td><!-- COL 1 -->
                							
                						</tr><!-- FIM LINHA 1 -->
                						
                						<!-- FIM LINHA 1 -->
                						
                						<tr><!-- LINHA 1 -->
                							
                							<td  bgcolor="#3c2c80" align="center" valign="top" width="50" height="40"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_04.png" width="50" height="40" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="509" height="40"><!-- COL 1 -->
                                                &nbsp;
                                            </td><!-- COL 1 -->
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="41" height="40"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_06.png" width="41" height="40" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                							
                							
                                        </tr><!-- FIM LINHA 1 -->
                                        
                                        <tr><!-- LINHA 1 -->
                							
                							<td  bgcolor="#3c2c80" align="center" valign="top" width="50" height="182"><!-- COL 1 -->
                                            
                                                &nbsp;
                                            
                                            </td><!-- COL 1 -->
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="509" height="182"><!-- COL 1 -->
                                            
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_08.png" width="509" height="182" alt="Clique para liberar e veja as informações" style="display: block"/>    
                                            
                                            </td><!-- COL 1 -->
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="41" height="182"><!-- COL 1 -->
                                            
                                                &nbsp;
                                            
                                            </td><!-- COL 1 -->
                							
                							
                                        </tr>
                                        
                                        <tr><!-- LINHA 1 -->
                							
                							<td  bgcolor="#3c2c80" align="center" valign="top" width="50" height="145"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_10.png" width="50" height="145" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                                            
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="middle" width="509" height="145"><!-- COL 1 -->
                                            
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/gif-aniversario.gif" width="400" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            
                                            </td><!-- COL 1 -->
                                            
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="41" height="145"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_12.png" width="41" height="145" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                							
                							
                                        </tr><!-- FIM LINHA 1 -->
                                        
                                        <tr><!-- LINHA 1 -->
                							
                							<td  bgcolor="#3c2c80" align="center" valign="top" width="50" height="489"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_13.png" width="50" height="489" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                                            
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="middle" width="509" height="489"><!-- COL 1 -->
                                            
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_14.png" width="509" height="489" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            
                                            </td><!-- COL 1 -->
                                            
                                            
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="41" height="489"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_15.png" width="41" height="489" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                							
                							
                                        </tr>
                                        
                                        
                                        
                                        
                                        <tr><!-- LINHA 1 -->
                                        
                                            <td  bgcolor="#3c2c80" align="center" valign="top" width="50" height="45"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_16.png" width="50" height="45" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                							
                							<td  bgcolor="#FFFFFF" align="center" valign="top" width="509" height="45"><!-- COL 1 -->
                                            
                                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="509" style="border-collapse: collapse; text-decoration: none">
                                                
                                                    <tr>
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="31" height="45">
                                                            &nbsp;
                                                        </td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="143" height="45"><img src="http://marketingcoobmais.com.br/aniversariantes/images/frase.png" width="134" height="32" alt="Clique para liberar e veja as informações" style="display: block"/></td>
                
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://www.facebook.com/coobmais/" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/face.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://www.instagram.com/coobmaisviagens/?hl=pt-br" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/insta.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://www.youtube.com/channel/UC85XIUgu7cBSdtCwRpxhDkg" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/youtube.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://www.linkedin.com/company/coobmaisviagens/" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/linkedin.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://open.spotify.com/user/ych9gz1nmnidx0o6ei6npq7md" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/spotify.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://viajantecoobmais.com.br" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/blog.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="42" height="45">
                                                        <a href="https://www.tiktok.com/@coobmais?lang=pt-BR" target="_blank" style="text-decoration: none; border: none"><img src="http://marketingcoobmais.com.br/aniversariantes/images/tiktok.png" width="32" height="33" alt="Clique para liberar e veja as informações" style="display: block"/></a></td>
                                                        
                                                        <td bgcolor="#FFFFFF" align="center" valign="top" width="31" height="45">
                                                            &nbsp;
                                                        </td>
                                                        
                                                    </tr>                                
                                                </table>
                                            
                                            </td><!-- COL 1 -->
                							
                                            <td  bgcolor="#ffffff" align="center" valign="top" width="41" height="45"><!-- COL 1 -->
                                            <img src="http://marketingcoobmais.com.br/aniversariantes/images/aniversariantes-viajantes_18.png" width="41" height="45" alt="Clique para liberar e veja as informações" style="display: block"/>
                                            </td><!-- COL 1 -->
                							
                                        </tr>
                                        
                                        <!-- FIM LINHA 1 -->
                					</table>
                					<!-- FIM TABELA CONTEÚDO -->
                				</td><!-- FIM COLUNA BASE -->
                			</tr>
                			<!-- FIM LINHA BASE 100% -->
                		</table>
                		<!-- FIM DA TABELA -->
                	</body>
                </html>'

			DECLARE @assunto VARCHAR(1000)
			SET @assunto = 'Feliz Aniversário!'
			EXEC siscoob.dbo.Envia_Email 1, @usuEmail, @assunto, @body

			-- Insert no Marketing o Historico de quantidades enviadas
			EXEC sp_Marketing_S 7,@usuCodigo,1,@assnic
			
			SET @count_ass=@count_ass+1
			FETCH NEXT FROM aniversarios_cursor INTO @conCodigo, @usuCodigo,@conDDDCelular,@conTelefoneCelular,@usuEmail,@assnic
			
		END		
		CLOSE aniversarios_cursor
		DEALLOCATE aniversarios_cursor
		
END