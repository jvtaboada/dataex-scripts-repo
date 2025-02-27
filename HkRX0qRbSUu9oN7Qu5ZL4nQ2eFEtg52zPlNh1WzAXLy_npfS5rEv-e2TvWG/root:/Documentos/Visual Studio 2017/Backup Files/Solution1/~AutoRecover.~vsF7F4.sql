SELECT DISTINCT tipCodigo 
FROM tblHoteis
WHERE tipCodigo NOT IN (SELECT redCodigo FROM tblHoteis_Negociacoes_Redes);

