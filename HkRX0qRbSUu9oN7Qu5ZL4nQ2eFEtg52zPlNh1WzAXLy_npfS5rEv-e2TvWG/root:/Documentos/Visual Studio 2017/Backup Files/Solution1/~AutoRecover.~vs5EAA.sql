USE [SBO_DATACENT_OFICIAL]
GO
/****** Object:  StoredProcedure [dbo].[SBO_SP_TransactionNotification]    Script Date: 06/02/2025 16:42:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER proc [dbo].[SBO_SP_TransactionNotification] 

@object_type nvarchar(20) = 13,        -- SBO Object Type
@transaction_type nchar(1) = UPDATE,     -- [A]dd, [U]pdate, [D]elete, [C]ancel, C[L]ose
@num_of_cols_in_key int = 1,
@list_of_key_cols_tab_del = DocEntry nvarchar(255),
@list_of_cols_val_tab_del = 159790 nvarchar(255)

AS

begin

-- Return values
declare @error  int       -- Result (0 for no error)
declare @error_message nvarchar (200)     -- Error string to be displayed
select @error = 0
select @error_message = N'Ok'

--------------------------------------------------------------------------------------------------------------------------------

--  ADD YOUR  CODE  HERE

--------------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
---- Regra: Obrigar o preenchimento da chave da acesso eletronica para os modelos de notas: 55, 57 e CTe
---- Utilização: Utilizada para obrigar o preenchimento correto da chave de acesso em documentos de entrada com modelo de nota eletronica
---- versao 1 - 10/12/2013 - Sandra Arioso - Service1
---- Criação do documento

-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------- 
-- -- NOTA FISCAL DE ENTRADA
 

-- IF  @object_type = '18' and (@transaction_type = 'A' or @transaction_type = 'U')
--        begin
--        IF  (Select Count (*) 
--From OPCH T0 INNER JOIN PCH1 T1 ON T0.DOCENTRY=T1.DOCENTRY
--Where T0.DocNum = @list_of_cols_val_tab_del 
--AND T1.USAGE NOT IN (42,43)
--and (ISNULL(cast(t0.U_ChaveAcesso as varchar(100)),'A') = 'A' or
--len(cast(t0.U_ChaveAcesso as varchar(100))) <> 44) And t0.SeqCode in(-1,-2) 
--And t0.Model in(39,44,45)) > 0
--      Begin
--           SET @error             = 1
--          SET @error_message      = 'O Preenchimento da Chave da NFe COM 44 Caracteres é obrigatório'
      

--    select @error, @error_message
--    end
--    end

--/*
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
--Fim                                                                                                           
--¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
--*/
  
----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
---- Regra: Obrigar o preenchimento da chave da acesso eletronica para os modelos de notas: 55, 57 e CTe
---- Utilização: Utilizada para obrigar o preenchimento correto da chave de acesso em documentos de entrada com modelo de nota eletronica
---- versao 1 - 10/12/2013 - Sandra Arioso - Service1
---- Criação do documento

-----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------- 
----DEVOLUÇÃO DE NOTA FISCAL DE SAIDA


  IF  @object_type = '14' and (@transaction_type = 'A' or @transaction_type = 'U')
        begin
        IF  (Select Count (*) 
From ORIN T0 
Where T0.DocNum = @list_of_cols_val_tab_del 
and (ISNULL(cast(t0.U_ChaveAcesso as varchar(100)),'A') = 'A' or
len(cast(t0.U_ChaveAcesso as varchar(100))) <> 44) And t0.SeqCode in(-1,-2) 
And t0.Model in(39,44,45)) > 0
      Begin
           SET @error              = 1
          SET @error_message    = 'O Preenchimento da Chave da NFe COM 44 Caracteres é obrigatório'
        End
    end
    /*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/


--------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Obrigar o preenchimento da chave da acesso eletronica para os modelos de notas: 55, 57 e CTe
-- Utilização: Utilizada para obrigar o preenchimento correto da chave de acesso em documentos de entrada com modelo de nota eletronica
-- versao 1 - 10/12/2013 - Sandra Arioso - Service1
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
-- DEVOLUÇÃO DE ENTREGA


  IF  @object_type = '16' and (@transaction_type = 'A' or @transaction_type = 'U')
        begin
        IF  (Select Count (*) 
From ORDN T0 
Where T0.DocNum = @list_of_cols_val_tab_del 
and (ISNULL(cast(t0.U_ChaveAcesso as varchar(100)),'A') = 'A' or
len(cast(t0.U_ChaveAcesso as varchar(100))) <> 44) And t0.SeqCode in(-1,-2) 
And t0.Model in(39,44,45)) > 0
      Begin
           SET @error              = 1
          SET @error_message      = 'O Preenchimento da Chave da NFe COM 44 Caracteres é obrigatório'
        End
    end
    /*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
 
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Valida_Chave_Acesso_NFe
-- Objetivo: Obrigar o preenchimento da chave da acesso eletronica para os modelos de notas: 55, 57 e CTe
-- Utilização: Utilizada para obrigar o preenchimento correto da chave de acesso em documentos de entrada com modelo de nota eletronica
-- versao 1 - 10/12/2013 - Sandra Arioso - Service1
-- Criação do documento
---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
-- RECEBIMENTO DE MERCADORIA


  IF  @object_type = '20' and (@transaction_type = 'A' or @transaction_type = 'U')
        begin
        IF  (Select Count (*) 
From OPDN T0 
Where T0.DocNum = @list_of_cols_val_tab_del 
and (ISNULL(cast(t0.U_ChaveAcesso as varchar(100)),'A') = 'A' or
len(cast(t0.U_ChaveAcesso as varchar(100))) <> 44) And t0.SeqCode in(-1,-2) 
And t0.Model in(39,44,45)) > 0
      Begin
           SET @error              = 1
          SET @error_message      = 'O Preenchimento da Chave da NFe COM 44 Caracteres é obrigatório'
        End
    end

/*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/




---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Obrigar o preenchimento do campo modelos de notas: NFe(55) e NFSe
-- Utilização: Utilizada para obrigar o preenchimento do campo modelo de nota fiscal
-- versao 1 - 22/04/2014 - Jaime Charles - Service1
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--- NOTA FISCAL SAÍDA


if @object_type = '13' and (@transaction_type = 'A' or @transaction_type = 'U')
Begin

        if (SELECT Model FROM OINV WHERE DocEntry = @list_of_cols_val_tab_del) = '0' or 
                (SELECT Model FROM OINV WHERE DocEntry = @list_of_cols_val_tab_del) is null
  
  Begin
    set @error_message = 'O campo modelo da nota fiscal é obrigatório !'
                  set @error = 99

          
  end
end

----------------------------------------------------------------------------------------------------

/*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
  


---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Obrigar o preenchimento do campo modelos de notas: NFe(55) e NFSe
-- Utilização: Utilizada para obrigar o preenchimento do campo modelo de nota fiscal
-- versao 1 - 22/04/2014 - Jaime Charles - Service1
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--- ENTREGA


if @object_type = '15' and (@transaction_type = 'A' or @transaction_type = 'U')
Begin

        if (SELECT Model FROM ODLN WHERE DocEntry = @list_of_cols_val_tab_del) = '0' or 
                (SELECT Model FROM ODLN WHERE DocEntry = @list_of_cols_val_tab_del) is null
  
  Begin
    set @error_message = 'O campo modelo da nota fiscal é obrigatório !'
                  set @error = 99

          
  end
end

----------------------------------------------------------------------------------------------------

/*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/


---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Obrigar o preenchimento do campo modelos de notas: NFe(55) e NFSe
-- Utilização: Utilizada para obrigar o preenchimento do campo modelo de nota fiscal
-- versao 1 - 22/04/2014 - Jaime Charles - Service1
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--- NOTA FISCAL ENTRADA


if @object_type = '18' and (@transaction_type = 'A' or @transaction_type = 'U')
Begin

        if (SELECT Model FROM OPCH WHERE DocEntry = @list_of_cols_val_tab_del) = '0' or 
                (SELECT Model FROM OPCH WHERE DocEntry = @list_of_cols_val_tab_del) is null
  
  Begin
    set @error_message = 'O campo modelo da nota fiscal é obrigatório !'
                  set @error = 99

          
  end
end

----------------------------------------------------------------------------------------------------

/*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/



---------------------------------------------------------------------------------------------------------------------------------------
-- Regra: Obrigar o preenchimento do campo modelos de notas: NFe(55) e NFSe
-- Utilização: Utilizada para obrigar o preenchimento do campo modelo de nota fiscal
-- versao 1 - 22/04/2014 - Jaime Charles - Service1
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--- RECEBIMENTO DE MERCADORIA


if @object_type = '20' and (@transaction_type = 'A' or @transaction_type = 'U')
Begin

        if (SELECT Model FROM OPDN  WHERE DocEntry = @list_of_cols_val_tab_del) = '0' or 
                (SELECT Model FROM OPDN  WHERE DocEntry = @list_of_cols_val_tab_del) is null
  
  Begin
    set @error_message = 'O campo modelo da nota fiscal é obrigatório !'
                  set @error = 99

          
  end
end


----------------------------------------------------------------------------------------------------------------
----Processo de Aprovação de Compras -- Renan Vergas 16/12/2014
----------------------------------------------------------------------------------------------------------------

-- Obrigatório informar á Area de Compra no Pedido de Compra

IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF exists (SELECT OPOR.DocEntry 
      FROM [dbo].[OPOR]
      WHERE (OPOR.U_TDS_AREA is null OR OPOR.U_TDS_AREA = '') and OPOR.DocDate >= '20150504'
              AND OPOR.DocEntry = @list_of_cols_val_tab_del) 

      BEGIN
            SET @error = '001'
            SET @error_message = 'Informe a Área de Compra !' 
      END
END

/*
-- Obrigatório informar o Projeto quando a Área de Compra for Capex

IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF exists (SELECT OPOR.DocEntry 
      FROM [dbo].[OPOR]
      WHERE (OPOR.U_TDS_AREA = 'CAPEX' and (OPOR.U_TDS_PROJETO is null OR OPOR.U_TDS_PROJETO = '')) and OPOR.DocDate >= '20150504'
              AND OPOR.DocEntry = @list_of_cols_val_tab_del) 

      BEGIN
            SET @error = '001'
            SET @error_message = 'Informe o Projeto !' 
      END
End

-- Obrigatório informar o Sub-Projeto se houver Projeto no Pedido

IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.U_TDS_SUB_PROJETO is null OR T1.U_TDS_SUB_PROJETO = '')  AND (T0.U_TDS_PROJETO is not null OR T0.U_TDS_PROJETO <> '') and T0.DocDate >= '20150504' AND T0.DocEntry = @list_of_cols_val_tab_del) > 0 
     
      BEGIN
           SET @error = '002'
            SET @error_message = 'Informe o Sub-Projeto !'

      END
END
*/
/*-- Obrigatório informar o centro de custo

IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode is null OR T1.OcrCode = '')  AND T0.DocEntry = @list_of_cols_val_tab_del) > 0 
     
      BEGIN
           SET @error = '002'
            SET @error_message = 'Informe o Centro de Custo !'

      END
END*/


-- Obrigatório Autorização de Todos os Níveis para atualizar Pedido com o flag "Autorizado"

--IF @object_type = '22' AND @transaction_type in ('A','U')

--BEGIN
--IF exists (SELECT OPOR.DocEntry 
--      FROM [dbo].[OPOR]
--      WHERE ((OPOR.NumAtCard is null OR OPOR.NumAtCard <> 'Aprovado') and OPOR.Confirmed = 'Y' and OPOR.U_TDS_AREA <> 'CONTRATOS' and OPOR.U_TDS_AREA <> 'TESOURARIA' ) 
--              and OPOR.DocDate >= '20150504' AND OPOR.Docnum not in (21070,5388,5545,5560,5562,5563,5540,5896,5625,8393,8069,9491,17525,17526,17527,18658,18797,19205,19206,19207,19067) and OPOR.DocEntry = @list_of_cols_val_tab_del) 

--      BEGIN
--            SET @error = '003'
--            SET @error_message = 'Pedido ainda nao foi Aprovado !' 
--      END
--END

----------------------------------------------------------------------------------------------------

/*
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/


-- ===================================== REPLICADOR ========================================== --
  IF (ISNUMERIC (@object_type)=1) AND 
    ( (@object_type = 1) OR (@object_type = 2) OR (@object_type = 4) )
  BEGIN
    DECLARE @CodeRS1 VARCHAR(8)
    SELECT @CodeRS1 = RIGHT('00000000' + CONVERT(VARCHAR, (select count(1) from [@SONE3RS1])+1), 8)
    INSERT INTO [@SONE3RS1]
      (Code, Name, U_ObjType, U_OperType, U_KeyName, U_KeyValue, U_DateTrigger, U_Status)  
    VALUES 
      (@CodeRS1, @CodeRS1, @object_type, @transaction_type, @list_of_key_cols_tab_del, 
        @list_of_cols_val_tab_del, GetDate(), 0);     
  END
-- ===================================== REPLICADOR ========================================== --


--=======================================VALIDAÇÕES DUOCONECT================================--


--- TELA DE NOTA FISCAL DE SAÍDA,DADOS PN(DESCONSIDERANDO EXPORTAÇÃO)---
declare @ERRO AS int
set     @erro = 0001

if @list_of_cols_val_tab_del <> ''
  Begin
  
  if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
        WHERE (T1.StreetNoS IS NULL)
        AND T2.Usage <> 20
        
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 1
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: NÚMERO'
    End
  
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
        WHERE (T1.StreetS IS NULL)
        AND T2.Usage <> 20
        
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = @erro
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: RUA'
    End
  
        if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
        WHERE (T1.AddrTypeS IS NULL)
        AND T2.Usage <> 20
        
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 2
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: TIPO LOGRADOURO'
    End
	/*
      if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
        WHERE (T1.ZipCodeS IS NULL)
        AND T2.Usage <> 20
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 3
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: CEP'
    End */
       if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
        WHERE (T1.BlockS IS NULL)
        AND T2.Usage <> 20
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 4
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: BAIRRO'
    End
        if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry = T2.DocEntry
        WHERE (T1.CityS IS NULL)
        AND T2.Usage <> 20       
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 5
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: CIDADE'
    End
        if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN INV1 T2 ON T0.DocEntry = T2.DocEntry
        WHERE (T1.StateS IS NULL)
        AND T2.Usage <> 20
                 AND T0.DocEntry = @list_of_cols_val_tab_del
				 AND T0.CARDCODE NOT IN ('C01797')) > 0
    Begin
      SET @error      = 6
      SET @error_message  = 'VERIFICAR ENDEREÇO PN, FALTA PREENCHER CAMPO: ESTADO'
    End
	
     if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
      INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
      WHERE (T1.TaxId0 IS NULL OR T1.TaxId0='')AND (T1.TaxId4 IS NULL OR T1.TaxId4 ='')
      AND T2.Usage <> 20 
                 AND T0.DocEntry = @list_of_cols_val_tab_del
				 AND T0.CARDCODE NOT IN ('C01797')) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'VERIFICAR DADOS PN, FALTA PREENCHER CAMPO: CNPJ OU CPF'
    End
	
      if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
      INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
      WHERE (T1.TaxId1 IS NULL OR T1.TaxId1='')
      AND T2.Usage <> 20
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 8
      SET @error_message  = 'VERIFICAR DADOS PN, FALTA PREENCHER OU MARCAR COMO ISENTO CAMPO: INSCRIÇÃO ESTADUAL'
    End
    

    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry=T1.DocEntry
      INNER JOIN INV1 T2 ON T0.DocEntry=T2.DocEntry
      WHERE (T1.TaxId3 IS NULL OR T1.TaxId3='') and T0.BPLId in (3,26) and T1.CityS = 'CAMPINAS'
      AND T2.Usage <> 20
                 AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 8
      SET @error_message  = 'PARA PREFEITURA DE CAMPINAS E CLIENTE DE CAMPINAS É OBRIGATÓRIO INFORMAR A INSCRIÇÃO MUNICIPAL NO DOCUMENTO, ABA IMPOSTO ->IDENTIFICAÇÕES FISCAIS'
    End
    end
  
--FIM DADOS DO PN---

---DADOS DO ITEM---
    --if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    INNER JOIN OITM T2 ON T1.ITEMCODE =T2.ITEMCODE 
    --    WHERE T2.ItemClass  = 1 AND (T2.U_SKILL_SerMun  IS NULL OR T2.U_SKILL_SerMun ='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = 9
    --  SET @error_message  = 'NÃO INFORMADO O CÓDIGO MUNICIPAL DO SERVIÇO PARA O ITEM '+ CONVERT(VARCHAR(20),((SELECT TOP 1 T1.ItemCode
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    INNER JOIN OITM T2 ON T1.ITEMCODE=T2.ITEMCODE
    --    WHERE  T0.DocEntry = @list_of_cols_val_tab_del AND T2.ItemClass =1 AND(T2.U_SKILL_SerMun  IS NULL OR T2.U_SKILL_SerMun =''))))
    --End


    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ITEMCODE =T2.ITEMCODE 
        WHERE T2.ItemClass  = 1 AND (T2.U_CodClass   IS NULL OR T2.U_CodClass  ='')
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 13
      SET @error_message  = 'NÃO INFORMADO O CÓDIGO DE CLASSIFICAÇÃO PARA O ITEM '+ CONVERT(VARCHAR(20),((SELECT TOP 1 T1.ItemCode
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ITEMCODE=T2.ITEMCODE
        WHERE  T0.DocEntry = @list_of_cols_val_tab_del AND T2.ItemClass =1 AND(T2.U_CodClass   IS NULL OR T2.U_CodClass  =''))))
    End

    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ITEMCODE =T2.ITEMCODE 
        WHERE T2.ItemClass  = 1 AND (T2.U_SKILL_LisSer  IS NULL OR T2.U_SKILL_LisSer ='')
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 10
      SET @error_message  = 'NÃO INFORMADO O CÓDIGO DA LISTA DE SERVIÇO PARA O ITEM '+ CONVERT(VARCHAR(20),((SELECT TOP 1 T1.ItemCode
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ITEMCODE=T2.ITEMCODE
        WHERE  T0.DocEntry = @list_of_cols_val_tab_del and T2.ItemClass =1 AND(T2.U_SKILL_LisSer  IS NULL OR T2.U_SKILL_LisSer =''))))
    End
    

    --if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    INNER JOIN OITM T2 ON T1.ITEMCODE =T2.ITEMCODE 
    --    WHERE T2.ItemClass =1 AND(T2.U_SKILL_CodCNAE  IS NULL OR T2.U_SKILL_CodCNAE ='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = 11
    --  SET @error_message  = 'NÃO INFORMADO O CÓDIGO CNAE PARA O ITEM '+ CONVERT(VARCHAR(20),((SELECT TOP 1 T1.ItemCode
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    INNER JOIN OITM T2 ON T1.ITEMCODE=T2.ITEMCODE
    --    WHERE   T0.DocEntry = @list_of_cols_val_tab_del AND T2.ItemClass =1 AND(T2.U_SKILL_CodCNAE  IS NULL OR T2.U_SKILL_CodCNAE =''))))
    --End
    
    
    
      if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ItemCode= T2.ItemCode
        WHERE T2.ITEMCLASS=2 AND (T2.NCMCode IS NULL OR T2.NCMCode= -1)

        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 12
      SET @error_message  = 'VERIFICAR NCM DO ITEM CÓDIGO: '+CONVERT(VARCHAR(20),( (SELECT TOP 1 T1.ItemCode
        FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
        INNER JOIN OITM T2 ON T1.ItemCode= T2.ItemCode
        WHERE   T0.DocEntry = @list_of_cols_val_tab_del AND T2.ITEMCLASS =2 AND (T2.NCMCode IS NULL OR T2.NCMCode=-1))))
    End
--- FIM DADOS DO ITEM---


---DADOS FISCAIS NÃO OBRIGATÓRIOS SAP---  
---CTS'S E IDENTIFICAÇÕES FISCAIS---
    --if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    WHERE (T1.CSTCode IS NULL OR T1.CSTCode='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = @erro
    --  SET @error_message  = 'VERIFICAR CST ICMS DO ITEM CÓDIGO: '+CONVERT(VARCHAR(20),( (SELECT T1.ItemCode
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --   WHERE (T1.CSTCode IS NULL OR T1.CSTCode=''))))
    --End
    --if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    WHERE (T1.CSTfCOFINS IS NULL OR T1.CSTfCOFINS='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = @erro
    --  SET @error_message  = 'VERIFICAR CST COFINS DO ITEM CÓDIGO: '+CONVERT(VARCHAR(20),( (SELECT T1.ItemCode
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --   WHERE (T1.CSTfCOFINS IS NULL OR T1.CSTfCOFINS=''))))
    --End
    --if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    WHERE (T1.CSTfIPI IS NULL OR T1.CSTfIPI='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = @erro
    --  SET @error_message  = 'VERIFICAR CST IPI DO ITEM CÓDIGO: '+CONVERT(VARCHAR(20),( (SELECT T1.ItemCode
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --   WHERE (T1.CSTfIPI IS NULL OR T1.CSTfIPI=''))))
    --End
    --    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
    --IF (SELECT count(T0.DocEntry)
    --    FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    WHERE (T1.CSTfPIS IS NULL OR T1.CSTfPIS='')
    --    AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
    --Begin
    --  SET @error      = @erro
    --  SET @error_message  = 'VERIFICAR CST PIS DO ITEM CÓDIGO: '+CONVERT(VARCHAR(20),( (SELECT T1.ItemCode
    --  FROM OINV T0 INNER JOIN INV1 T1 ON T0.DocEntry=T1.DocEntry
    --    WHERE (T1.CSTfPIS IS NULL OR T1.CSTfPIS=''))))
    --End
    
      
      -- Preenche centro de custo para as contas de receita---
      
          if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      declare @Centro as nvarchar (10)
      declare @Unidadenegocios as nvarchar (10)
      set @Centro = (select distinct(ocrcode) from inv1 where DocEntry = @list_of_cols_val_tab_del )
      set @Unidadenegocios = (select distinct(OcrCode2) from inv1 where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN INV1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE (T3.OcrCode <> '' or T3.OcrCode2 <> '') 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set profitcode = @Centro  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '3%' and TransType =13
      update jdt1 set OcrCode2 = @Unidadenegocios  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '3%' and TransType =13
      end
End 
 

    -- Preenche centro de custo para as contas de despesa entrada nf---
      
--      if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
--      begin
--     -- declare @Centro as nvarchar (10)
--      set @Centro = (select distinct(ocrcode) from PCH1 where DocEntry = @list_of_cols_val_tab_del )
--      --declare @baseref as nvarchar (10)
--    IF (SELECT count(T0.DocEntry)
--        FROM OPCH T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
--        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
--        INNER JOIN PCH1 T3 ON T0.DocEntry =T3.DocEntry 
--        WHERE T3.OcrCode <> '' 
--        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
--Begin

  --    update jdt1 set profitcode = @Centro  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '4%' and TransType =18
  --    end
--End 

    -- Preenche centro de custo para as contas de custo entrada---
      
--      if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
--      begin
--     -- declare @Centro as nvarchar (10)
--      set @Centro = (select distinct(ocrcode) from PCH1 where DocEntry = @list_of_cols_val_tab_del )
--      --declare @baseref as nvarchar (10)
--    IF (SELECT count(T0.DocEntry)
--        FROM OPCH T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
--        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
--        INNER JOIN PCH1 T3 ON T0.DocEntry =T3.DocEntry 
--        WHERE T3.OcrCode <> '' 
--        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
--Begin

--      update jdt1 set profitcode = @Centro  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '5%' and TransType =18
--      end
--End 


-- Atualiza o campo de descrição da natura da operação na tela de recebimento de mercadorias, criado por Daniel Becker em 17/07/2017
    if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      begiN
      declare @Usage as nvarchar (max)
      set @Usage = (select top 1 T1.descr from PDN1 T0 inner join OUSG T1 on T0.Usage =t1.ID and t0.LineNum =0 where T0.DocEntry =@list_of_cols_val_tab_del )
          IF (SELECT distinct count(T0.DocEntry)
        FROM OPDN T0 
        WHERE  T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update OPDN set u_NatOper = @Usage  where DocEntry  =@list_of_cols_val_tab_del  
      end
End 


-- Atualiza o campo de descrição da natura da operação na tela de Devoluções em vendas, criado por Daniel Becker em 17/07/2017
    if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      
      set @Usage = (select top 1 T1.descr from rdn1 T0 inner join OUSG T1 on T0.Usage =t1.ID and t0.LineNum =0 where T0.DocEntry =@list_of_cols_val_tab_del )
          IF (SELECT distinct count(T0.DocEntry)
        FROM ORDN T0 
        WHERE  T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ORDN set u_NatOper = @Usage  where DocEntry  =@list_of_cols_val_tab_del  
      end
End 



    
      if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      ---declare @Centrod as nvarchar (10)
      set @Centro = (select distinct(ocrcode) from rin1 where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM ORIN T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN RIN1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set profitcode = @Centro  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '3%' and TransType =14
      end
End 


-- Preenche Ref1 com o número da NF nas linhas do lançamento
--    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
--      begiN
--      declare @Ref1 as nvarchar (10)
--      set @Ref1 = (select distinct case when model <> 46 then(Serial) when model = 46 then
--      (select distinct U_NrRetNFSE  from dbo.[@SKILL_NOFSNFSE001]  where U_NrDocEntry =@list_of_cols_val_tab_del) end  from OINV where DocEntry = @list_of_cols_val_tab_del )
--      --declare @baseref as nvarchar (10)
--    IF (SELECT distinct count(T0.DocEntry)
--        FROM OINV T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
--        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
--        INNER JOIN INV1 T3 ON T0.DocEntry =T3.DocEntry 
--        WHERE  T0.DocEntry = @list_of_cols_val_tab_del) > 0
--Begin

--      update jdt1 set Ref1 = @Ref1  where BaseRef  =@list_of_cols_val_tab_del  and TransType =13
--      end
--End 




-- VALIDA CENTRO DE CUSTO NAS CONTAS DO NÍVEL 5 NO PEDIDO DE COMPRA

IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.AcctCode LIKE '5%' OR T1.AcctCode LIKE '4%')
     AND (T1.OcrCode ='' OR T1.OcrCode IS NULL)) > 0
      BEGIN
        SET @error      = 00110
        SET @error_message  = 'VALIDAÇÃO ASCENTY: OBRIGATÓRIO INFORMAR CENTRO DE CUSTO NAS CONTAS DO NÍVEL 5 E 4, VERIFIQUE A REGRA DE DISTRIBUIÇÃO'
    ENd

-- VALIDA CENTRO DE CUSTO NAS CONTAS DO NÍVEL 5 NA NOTA FISCAL DE ENTRADA 

IF  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPCH  T0 INNER JOIN PCH1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.AcctCode LIKE '5%' OR T1.AcctCode LIKE '4%')
     AND (T1.OcrCode ='' OR T1.OcrCode IS NULL)) > 0
      BEGIN
        SET @error      = 00110
        SET @error_message  = 'VALIDAÇÃO ASCENTY: OBRIGATÓRIO INFORMAR CENTRO DE CUSTO NAS CONTAS DO NÍVEL 5 E 4, VERIFIQUE A REGRA DE DISTRIBUIÇÃO'
    ENd

    --VALIDA PREENCHIMENTO DO CÓDIGO DE IMPOSTO NO PEDIDO DE COMPRAS

    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.TAXCODE IS NULL OR T1.TAXCODE='') ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM CONTER CÓDIGO DE IMPOSTO NO PEDIDO DE COMPRAS'
    ENd

    -- Valida Filial do ativo no pedido de compras

    
    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
    inner join OITM T2 on T1.ItemCode=T2.ItemCode 
    inner join OACS T3 on T2.[AssetClass] = T3.[Code]
     Where 
     --t0.datasource <> 'O' 
     T2.ItemType ='F' and
     T3.BplId <> T0.BplId and
     T0.DocEntry  = @list_of_cols_val_tab_del
      ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'Ativo Fixo Informado no Pedido de compras não corresponde a filial do pedido'
    ENd
    
    --Utilização
    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.usage IS NULL OR T1.usage='') ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM TER UTILIZAÇÃO INFORMADA'
    ENd


    --Preço Unitário
    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.Price =0 ) ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM TER PREÇO UNITÁRIO INFORMADO DIFERENTE DE ZERO'
    ENd

    --Conta Contábil
    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.AcctCode  is null or T1.AcctCode ='') ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM CONTA CONTÁBIL INFORMADAS'
    ENd

    --  --Regra de Distribuição
    --IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
  --      IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
    -- inner join OITM t2 on t1.itemcode=t2.ItemCode 
    -- Where 
    -- --t0.datasource <> 'O' 
    -- T0.DocEntry  = @list_of_cols_val_tab_del
    -- and t2.itemtype <>'F'
    -- AND (T1.OcrCode  is null or T1.OcrCode ='') ) > 0
    --  BEGIN
    --    SET @error      = 00111
    --    SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM TER REGRA DE DISTRIBUIÇÃO INFORMADAS'
    --ENd

	/*
      --Sub Projeto se o Projeto estiver informado
    IF  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND (T1.U_TDS_SUB_PROJETO   is null or T1.U_TDS_SUB_PROJETO ='') 
     and T0.U_TDS_PROJETO <>'') > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: TODAS AS LINHAS DEVEM TER SUB PROJETO INFOMARDOS'
    ENd
*/

    --Não permite inserir pedido de compras com itens sem classificação de depreciação, inicialmente era em NF de entrada
      IF  @object_type = '22' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPOR  T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry inner join itm7 t2 on t1.ItemCode =t2.ItemCode  
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del
     AND t2.DprType='RECLASSIFICAR' ) > 0
      BEGIN
        SET @error      = 00111
        SET @error_message  = 'VALIDAÇÃO ASCENTY: ITEM DE ATIVO NÃO PODE ESTAR COM A AREA DE DEPRECIAÇÃO COMO RECLASSIFICAR, REVISAR O CADASTRO DO ATIVO'
    ENd

    --Obriga a informar a NF de origem em capitalização manual para ativo fixo
    --  IF  @object_type = '30' and( @transaction_type in( 'A','U'))
  --      IF (Select Count(1) FROM OJDT  T0 INNER JOIN OACQ T1 ON T0.BaseRef  =T1.DocNum  
    -- Where 
    -- --t0.datasource <> 'O' 
    -- T0.TransId    = @list_of_cols_val_tab_del
    -- and T0.memo not like '%Nota de cr%'
    -- and t1.TransType ='1470000049' and (t1.Reference = '' or t1.Reference is null)) > 0
    --  BEGIN
    --    SET @error      = 00112
    --    SET @error_message  = 'VALIDAÇÃO ASCENTY: PARA LANÇAR CAPITALIZAÇÃO MANUAL, DEVE SER REFERENCIADO O NÚMERO DA NF DE ENTRADA DE ORIGEM'
    --ENd

    
    
--VALIDA NF DE ENTRADA DUPLICADA
      IF  @object_type = '18' and( @transaction_type = 'A')
        IF (Select Count(*) FROM OPCH T0 
    INNER JOIN PCH1 T1 ON T0.DOCENTRY=T1.DOCENTRY
     Where 
     T0.DocEntry  = @list_of_cols_val_tab_del 
     AND T1.USAGE NOT IN (42,43)
	 and T0.Model not in (55, 56)
     and T0.CardCode <> 'F00077' --inclui nota modelo 22, e modelo IMPOSTO da regra alteração joão victor 31/10 - chamado - 3398 ( and T0.Model not in (19,55))
     AND T0.Serial IN (SELECT top 1 ISnull (Serial,'') FROM OPCH WHERE Serial=T0.Serial and T0.CardCode =CardCode and CANCELED ='N' AND T0.DocNum <> DocNum AND T0.Model = Model AND T0.BPLId =BPLId AND ISNULL (SeriesStr,'')=ISNULL (T0.SeriesStr,'')))> 0
      BEGIN
        SET @error      = 001
        SET @error_message  = 'NOTA FISCAL COM NÚMERO DUPLICADO'
    ENd


    --VALIDA NF DE ENTRADA DUPLICADA - DEVOLUÇÕES EM COMPRAS, INCLUÍDA EM 26/06/2017 POR DANIEL BECKER, APÓS VALIDAÇÕES NA PLANILA DE MELHORIASS
    IF  @object_type = '21' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ORPD T0 
    INNER JOIN RPD1 T1 ON T0.DOCENTRY=T1.DOCENTRY
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del 
     AND T1.USAGE NOT IN (42,43)
     and T0.Model not in (19,55, 56) --exclui nota modelo 22, e modelo IMPOSTO da regra
     
     AND T0.Serial IN (SELECT ISnull (Serial,'') FROM ORPD WHERE Serial=T0.Serial AND T0.CardCode =CardCode and CANCELED ='N' AND T0.DocNum <> DocNum AND T0.Model = Model and T0.BPLId =BPLId AND (T0.seriesstr =seriesstr OR T0.seriesstr IS NULL))) > 0
      BEGIN
        SET @error      = 001
        SET @error_message  = 'NOTA FISCAL COM NÚMERO DUPLICADO'
    ENd



      --VALIDA NF DE ENTRADA DUPLICADA - RECEBIMENTO DE MERCADORIAS EM COMPRAS, INCLUÍDA EM 26/06/2017 POR DANIEL BECKER, APÓS VALIDAÇÕES NA PLANILA DE MELHORIAS
    IF  @object_type = '20' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPDN T0 
    INNER JOIN PDN1 T1 ON T0.DOCENTRY=T1.DOCENTRY
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del 
     AND T1.USAGE NOT IN (42,43)
     and T0.Model not in (19,55, 56) --exclui nota modelo 22, e modelo IMPOSTO da regra
     AND T0.Serial IN (SELECT ISnull (Serial,'') FROM OPDN WHERE Serial=T0.Serial AND T0.CardCode =CardCode and CANCELED ='N' AND T0.DocNum <> DocNum AND T0.Model = Model and T0.BPLId =BPLId AND (T0.seriesstr =seriesstr OR T0.seriesstr IS NULL))) > 0
      BEGIN
        SET @error      = 001
        SET @error_message  = 'NOTA FISCAL COM NÚMERO DUPLICADO'
    ENd


  --VALIDA DOCUMENTO COM DATA DE LANÇAMENTO POSTERIOR A DATA DO DOCUMENTO, CRIADO POR DANIEL BECKER, CONFORME PLANILHA DE MELHORIAS.
    IF  @object_type = '18' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPCH T0 
    
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del 
     AND  T0.TaxDate > T0.DocDate 
     ) > 0
      BEGIN
        SET @error      = 26062017
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> DATA DO DOCUMENTO É POSTERIOR A DATA DO LANÇAMENTO, VERIFICAR DATAS'
    ENd


    --Checa item de ativo em duplicidade na linha do pedido de compras , criado por Daniel Becker em 25/07
    IF  @object_type = '22' and( @transaction_type = 'A')
    Begin
        IF (Select top 1 Count(T1.ItemCode) FROM OPOR T0 INNER JOIN POR1 T1 ON T0.DocEntry =T1.DocEntry 
    INNER JOIN OITM T2 ON T1.ITEMCODE=T2.ITEMCODE
     Where 
     --t0.datasource <> 'O' 
     T0.DocEntry  = @list_of_cols_val_tab_del 
     AND T2.ITEMTYPE='F' and T2.ItemClass <> 1
     group by  t1.ItemCode having count(t1.ItemCode)>1
     --and T1.ItemCode ='A00001'
     --AND  T0.TaxDate > T0.DocDate 
     ) > 1
      BEGIN
        SET @error      = 2017
      --  SET @error_message = 'Ativo Duplicado, verifique pedido'
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> ITEM EM DUPLICIDADE LINHA: ' +convert(nvarchar(100),((select top 1 linenum +1 from por1 where por1.DocEntry =@list_of_cols_val_tab_del and por1.ItemCode = CONVERT(NVARCHAR(100),((SELECT TOP 1 por1.itemcode FROM POR1 inner join oitm on por1.itemcode=oitm.itemcode WHERE por1.DocEntry =@list_of_cols_val_tab_del and ItemClass <> 1 group by  por1.ItemCode having count(por1.itemcode)>1  ORDER BY 1 ASC)))))) +' E LINHA: '+
        convert(nvarchar(100),((select top 1 linenum +1 from por1 where por1.DocEntry =@list_of_cols_val_tab_del and por1.ItemCode = CONVERT(NVARCHAR(100),((SELECT TOP 1 por1.itemcode FROM POR1 inner join oitm on por1.itemcode=oitm.ItemCode WHERE por1.DocEntry =@list_of_cols_val_tab_del and ItemClass <> 1 group by  por1.ItemCode having count(por1.itemcode)>1  ORDER BY 1 DESC)))ORDER BY LINENUM DESC))) 
    END
    END

    -- Valida  subaquisicao no item de ativo
 if  @object_type = '112' and(  @transaction_type IN( 'U'))
      begin
     IF (SELECT sum(T2.APC)
      FROM DRF1 T0 inner join ODRF T100 on t0.DocEntry =T100.DocEntry  inner join OITM T1 on T0.ItemCode =T1.ItemCode 
    inner join fix1  T2 on T0.ItemCode=T2.ItemCode
      
      WHERE 
         T100.U_DC_ValidaCompras ='Sim' 
       and T0.DocEntry  = @list_of_cols_val_tab_del ) > 0
    Begin
      SET @error      = 7
      SET @error_message  = ' Sub-aquisicao nao é permitida!'
    End   
End

    --CHECA SE PN TEM ADIANTAMENTO EM ABERTO E OBRIGA VALIDAÇÃO NA NOTA FISCAL DE ENTRADA
    
    
      IF  @object_type = '18' and( @transaction_type = 'A')
      Begin
      declare @DbAdiantamentos table (AD Int)
    INSERT INTO @DbAdiantamentos 
    SELECT BaseRef  FROM JDT1 WHERE TransType =204 AND BalDueCred =0 AND SHORTNAME = (SELECT CARDCODE FROM OPCH WHERE DocEntry =@list_of_cols_val_tab_del ) and baseref not in(select isnull(BaseAbs ,'') from PCH9)
        IF (Select Count(1) 
    FROM @DbAdiantamentos  
    WHERE AD NOT IN(SELECT top 1 ISNULL(BaseAbs,'')  FROM PCH9 WHERE DOCENTRY=@list_of_cols_val_tab_del)
    and ((SELECT DpmAmnt  FROM OPCH  WHERE DocEntry =@list_of_cols_val_tab_del )=0 and (select U_DC_AdChk from OPCH where docentry=@list_of_cols_val_tab_del )=01)
     ) > 0
      BEGIN
        SET @error      = 27072017
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> PN POSSUI ADIANTAMENTO EM ABERTO, VERIFIQUE SE DEVE SER VINCULADO A ESSA NF OU MARQUE COMO SIM A OPÇÃO DE ADIANTAMENTO CHECADO'
    --DROP TABLE ##TMP_AD
    ENd
    End
	

    ---VALIDA CHAVE DE ACESSO DA NF-E, CRIADO POR DANIEL BECKER EM 26/06/2017, ESSA VALIDAÇÃO CHAMA UMA FUNCTION QUE RECEBE A CHAVE DE ACESSO, CALCULA O DIGITO E CONFERE COM O MÉTODO 11

    IF  @object_type = '18' and  @transaction_type IN ('A','U')
    begin
    DECLARE @CHAVE AS NVARCHAR(44)
    DECLARE @RETORNO AS NVARCHAR(10)
    DECLARE @DOCENTRY AS NVARCHAR (10)
    
    SET @CHAVE = (SELECT U_chaveacesso  FROM OPCH WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @DOCENTRY  = (SELECT DOCENTRY  FROM OPCH WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @RETORNO = (SELECT dbo.usf_calcula_dv_nfe(@CHAVE))

        IF @RETORNO = '0' AND @DOCENTRY =@list_of_cols_val_tab_del 
     
      BEGIN
        SET @error      = 26062017
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> CÁLCULO DO DÍGITO DA CHAVE DE ACESSO DA NF-E ESTÁ INCOSISTENTE, VERIFICAR CHAVE DE ACESSO'
        end
end


    ---VALIDA CHAVE DE ACESSO NA TELA DE DEVOLUÇÕES EM VENDAS

  IF  @object_type = '16' and  @transaction_type IN ('A','U')
    begin
    --DECLARE @CHAVE AS NVARCHAR(44)
    --DECLARE @RETORNO AS NVARCHAR(10)
    --DECLARE @DOCENTRY AS NVARCHAR (10)
    
    SET @CHAVE = (SELECT U_chaveacesso  FROM ORDN WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @DOCENTRY  = (SELECT DOCENTRY  FROM ORDN WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @RETORNO = (SELECT dbo.usf_calcula_dv_nfe(@CHAVE))

        IF @RETORNO = '0' AND @DOCENTRY =@list_of_cols_val_tab_del 
     
      BEGIN
        SET @error      = 26062017
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> CÁLCULO DO DÍGITO DA CHAVE DE ACESSO DA NF-E ESTÁ INCOSISTENTE, VERIFICAR CHAVE DE ACESSO'
        end
end


 ---VALIDA CHAVE DE ACESSO NA TELA DE RECEBIMENTO DE MERCADORIAS EM COMPRAS

  IF  @object_type = '20' and  @transaction_type IN ('A','U')
    begin
    --DECLARE @CHAVE AS NVARCHAR(44)
    --DECLARE @RETORNO AS NVARCHAR(10)
    --DECLARE @DOCENTRY AS NVARCHAR (10)
    
    SET @CHAVE = (SELECT U_chaveacesso  FROM OPDN WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @DOCENTRY  = (SELECT DOCENTRY  FROM OPDN WHERE DocEntry =@list_of_cols_val_tab_del )
    SET @RETORNO = (SELECT dbo.usf_calcula_dv_nfe(@CHAVE))

        IF @RETORNO = '0' AND @DOCENTRY =@list_of_cols_val_tab_del 
     
      BEGIN
        SET @error      = 26062017
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> CÁLCULO DO DÍGITO DA CHAVE DE ACESSO DA NF-E ESTÁ INCOSISTENTE, VERIFICAR CHAVE DE ACESSO'
        end
end

--Parceiro de Negócios

  IF ( ( @object_type = '2' ) AND ( @transaction_type = 'A' ) )
          OR ( ( @object_type = '2' ) AND ( @transaction_type = 'U' ) ) 
            BEGIN
              DECLARE @Parceiro NVARCHAR(200)
              SELECT @Parceiro = T0.CardCode FROM CRD7 T0 LEFT JOIN OCRD T1 ON T0.CardCode = T1.CardCode WHERE T0.CardCode = @list_of_cols_val_tab_del --AND T1.CardType <> 'S'
            

  -------- Nome  ------ 
                    IF (( SELECT CardName FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = ''
                     OR ( SELECT CardName FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = NULL
                     OR ( SELECT CardName FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) IS NULL ) 
                        BEGIN
                            SET @error = 1 ;
                            SET @error_message = 'Validação Ascenty --> FAVOR PREENCHER A RAZÃO SOCIAL!'
                        END

  ------ Telefone ------
                    ELSE 
                    IF (( SELECT Phone1 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = ''
                     OR ( SELECT Phone1 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = NULL
                     OR ( SELECT Phone1 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) IS NULL ) 
                            BEGIN
                                SET @error = 2 ;
                    SET @error_message = 'Validação Ascenty --> FAVOR PREENCHER O TELEFONE !'
                            END

              ------ DDD ------
                    ELSE 
                    IF (( SELECT Phone2 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = ''
                     OR ( SELECT Phone2 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = NULL
                     OR ( SELECT Phone2 FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) IS NULL ) 
                            BEGIN
                                SET @error = 3 ;
                                SET @error_message = 'Validação Ascenty --> FAVOR PREENCHER O DDD'
                            END
  
  ------ E-Mail Geral ------
                    ELSE 
                    IF (( SELECT E_Mail FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = ''
                     OR ( SELECT E_Mail FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) = NULL
                     OR ( SELECT E_Mail FROM OCRD WHERE CardCode = @list_of_cols_val_tab_del ) IS NULL ) 
                            BEGIN
                                SET @error = 2 ;
                                SET @error_message = 'Validação Ascenty--> FAVOR PREENCHER O EMAIL (ABA "GERAL")'
                            ENd

              --Endereço
            
    ------ Checagem de ENDereço Informado-----
                ELSE 
            --IF @object_type = '2' AND ( @transaction_type = 'A' OR @transaction_type = 'U' ) 
            IF ( SELECT COUNT(1) FROM OCRD T0 WHERE T0.CardType <> 'L' AND T0.CardCode = @list_of_cols_val_tab_del AND T0.CardCode NOT IN ( SELECT S0.CardCode FROM CRD1 S0 WHERE S0.CardCode = T0.CardCode AND S0.AdresType = CASE WHEN T0.CardType = 'C' THEN 'S' ELSE 'B' END)) > 0 
                             BEGIN
                                  SET @error = 9
                                  SET @error_message = 'Validação Ascenty --> Endereço não informado'
                             END
    
     
     ------ Checagem de ENDereço Completo  ------
                ELSE 
                      IF ( SELECT COUNT(1) FROM OCRD T0 INNER JOIN CRD1 T1 ON ( CASE WHEN T0.CardType = 'C' THEN T0.ShipToDef ELSE BillToDef END) = T1.Address AND T0.CardCode = T1.CardCode WHERE T0.CardCode = @list_of_cols_val_tab_del and t1.Country = 'BR' 
                AND ( T1.Street IS NULL
                OR LEN(T1.Street) < 1
                OR T1.State IS NULL
                OR T1.County IS NULL
                OR T1.Country IS NULL
                OR T1.Street = ''
                OR T1.StreetNo = ''
                OR T1.StreetNo  is null
                OR T1.ZipCode = ''
                OR T1.ZipCode  is null
                OR T1.State = ''
                OR T1.County = ''
                OR T1.Country = ''
                OR T1.City = '' )
                AND T1.AdresType = ( CASE WHEN T0.CardType = 'C' THEN 'S' ELSE 'B' END)
                AND T0.CardType IN ( 'C', 'S' ) ) > 0 
               BEGIN
                   SET @error = 18
                   SET @error_message = 'Validação Ascenty --> Endereço incompleto'
                 END

               else
               IF ( SELECT COUNT(1) FROM OCRD T0 INNER JOIN CRD1 T1 ON ( CASE WHEN T0.CardType = 'C' THEN T0.ShipToDef ELSE BillToDef END) = T1.Address AND T0.CardCode = T1.CardCode WHERE T0.CardCode = @list_of_cols_val_tab_del and t1.Country = 'BR' 
                AND ( T1.U_SKILL_indIEDest='' or T1.U_SKILL_indIEDest is null))>0
                 BEGIN
                   SET @error = 18
                   SET @error_message = 'Validação Ascenty --> Informar Indicador da IE no endereço de entrega'
                 END
        
           END
 
  --cnpj
     if  @object_type = '2' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OCRD T0 INNER JOIN CRD7 T1 ON T0.CARDCODE=T1.CARDCODE
      INNER JOIN CRD1 T2 ON T1.CardCode =T2.CardCode AND T1.Address =T2.Address 
      WHERE ((T1.TaxId0 IS NULL OR T1.TaxId0='') and (T1.TaxId4 IS NULL OR T1.TaxId4 =''))
      and T1.AddrType  ='S'
      AND (T1.[Address] IS NOT NULL OR T1.[Address] <>'')
      and T0.CardCode not  in ('F05246','C01797','F04556','F04687','F05004','F02678','F01491','F04499','F03841','F03841', 'F03531','F04908','F04676', 'F02812','F02773','F02773','F01138','C00895','C00577','F01557','F01539','F00048','F01763','PF00125','C00741','C00263','C00374','C00453','F00489''C00216','F00555','F00547','F00513','F00556','F00600','F00554','F00498','F00579','C00199','C00222','c00214','c00204','c00218','F01108','F01310','F00599','F00580','F00204','F00506','F00567','F00623','F00617','F00541','F00618','F01260','F00561','F00592','F00620','F00619','F00558','F00628','F00631','F00625','F00507','F00543','F00607','F00489','F00586','F00635','F00548','F00575','F00613', 'F00614','F00636','F00499','F00582','F00573','F00565','F00509','F01366','F00055','F00496','F00603','F00576','F00557','F00638','F00624','F05246','F04662','F03294','F05304','F05322','F05513','F05461','F05456','F03885','F04324','F05592','F05365','F05476','F04134','F05756','F05694')
                 AND T0.CardCode = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 70
      SET @error_message  = 'Validação Ascenty --> FALTA PREENCHER CAMPO: CNPJ OU CPF'
    End
	
  if  @object_type = '2' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OCRD T0 INNER JOIN CRD7 T1 ON T0.CARDCODE=T1.CARDCODE
      --INNER JOIN CRD1 T2 ON T1.CardCode =T2.CardCode AND T1.Address =T2.Address --Removido no chamado 1989
      
      WHERE (T1.TaxId1 IS NULL OR T1.TaxId1='')
      and T0.CardCode not like 'PF%'
      and T1.AddrType  = 'S' --Corrigido no chamado 1989
	  AND T1.TaxId1 != 'Isento' --Inserido no chamado 1989
      AND (T1.[Address] IS NOT NULL OR T1.[Address] <>'')
      and T0.CardCode not  in ('F05004','F01138','C00895','C00577','F01557','F01539','F00048','F01763','PF00125','C00741','C00263','C00374','C00453','F00489''C00216','F00555','F00547','F00513','F00556','F00600','F00554','F00498','F00579','C00199','C00222','c00214','c00204','c00218','F01108','F01310','F00599','F00580','F00204','F00506','F00567','F00623','F00617','F00541','F00618','F01260','F00561','F00592','F00620','F00619','F00558','F00628','F00631','F00625','F00507','F00543','F00607','F00489','F00586','F00635','F00548','F00575','F00613', 'F00614','F00636', 'F00499','F00499','F00582','F00573','F00565','F00509','F01366','F00496','F00603','F00576','F00557','F00638','F00624')
                 AND T0.CardCode = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7777
      SET @error_message  = 'Validação Ascenty --> PREENCHER INSCRIÇÃO ESTADUAL OU MARCAR COMO ISENTO SE FOR O CASO'
    End

    --Obriga Preencher Indicador de Natureza da Retenção, campo compõe registro F600 da EFD Contribuições, criado por Daniel Becker em 27/06/2017



    if  @object_type = '2' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OCRD T0 
      
      WHERE          (T0.U_IND_NAT_RET =''      or T0.U_IND_NAT_RET is null)
       and T0.CardType ='C'
                 AND T0.CardCode = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 70
      SET @error_message  = 'Validação Ascenty --> Obrigatório informar o indicador de Natureza da Retenção'
    End

	
      --Validações Pedido de Compras / Aprovação

    --Validações Pedido de Compras / Aprovação

-- Valida se Nº da solicitação de compras do ServiceNow foi preenchida

      if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE (T0.U_U_DC_No_Snow ='' or T0.U_U_DC_No_Snow is null)
      and T0.DocDate >='20180912'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 10
      SET @error_message  = 'Obrigatório preenchimento do Nº ServiceNow'
    End
    

-----aqui pwb
-- Atualiza status do pedido de acordo com fluxo de aprovação

if  @object_type = '22' and( @transaction_type in ('U'))
Begin
    

declare @valor as numeric (19,6)
declare @ctrl as nvarchar (max)
declare @cfo as nvarchar (max)
declare @dir as nvarchar (max)
declare @ceo as nvarchar (max)
declare @statusPC as nvarchar (max)
declare @statusPC_1 as nvarchar (max)
declare @statusPC_atual as nvarchar (max)



set @valor=(select [DocTotal] from OPOR where DocEntry =@list_of_cols_val_tab_del)
set @ctrl=(select U_TDS_APROV2 from OPOR where DocEntry =@list_of_cols_val_tab_del)
set @cfo=(select U_TDS_APROV1 from OPOR where DocEntry =@list_of_cols_val_tab_del)
set @dir=(select U_TDS_APROV3 from OPOR where DocEntry =@list_of_cols_val_tab_del)
set @ceo=(select U_TDS_APROV4 from OPOR where DocEntry =@list_of_cols_val_tab_del)

set @statusPC_atual=(select U_TDS_APROV5 from OPOR where DocEntry =@list_of_cols_val_tab_del)

if @statusPC_atual = '01' or @statusPC_atual is NULL
begin
--verifica se o pedido já está aprovado

	--Seta como aprovado caso controller aprove no nível 1
	if @valor <= '9999.99' and @ctrl = '02'
	Begin
	set @statusPC ='02'
	set @statusPC_1 ='Pedido Aprovado'
	end

	--Seta como reprovado caso controller não aprove no nível 1
	if @valor <= '9999.99' and @ctrl = '03'
	Begin
	set @statusPC ='03'
	set @statusPC_1 ='Pedido Reprovado'
	end

	

	--Verifica aprovação nível 2
	if @valor > '9999.99' and @valor <= '49999.98' and @cfo = '02'
	Begin
	set @statusPC ='02'
	set @statusPC_1 ='Pedido Aprovado'
	end

	if @valor > '9999.99' and @valor <= '49999.98' and @cfo = '03'
	Begin
	set @statusPC ='03'
	set @statusPC_1 ='Pedido Reprovado'
	end

--	Verifica aprovação nivel 3
	if @valor > '49999.98' and @valor <= '50000.00' and @dir = '02'
	Begin
	set @statusPC ='02'
	set @statusPC_1 ='Pedido Aprovado'
	end

	if @valor > '49999.98' and @valor <= '50000.00' and @dir = '03'
	Begin
	set @statusPC ='03'
	set @statusPC_1 ='Pedido Reprovado'
	end

	-- Verifica aprovação nivel 4
	if @valor > '49999.99' and @ceo = '02'
	Begin
	set @statusPC ='02'
	set @statusPC_1 ='Pedido Aprovado'
	end

	if @valor > '49999.99' and @ceo = '03'
	Begin
	set @statusPC ='03'
	set @statusPC_1 ='Pedido Reprovado'
	end


	if @valor > '9999.99' and @ctrl= '02' and @cfo='01' and @dir='01' and @ceo='01'
	Begin
	set @StatusPC_1 = 'Aguardando Aprovação CFO'
	end

	if @valor > '49999.98' and @ctrl= '02' and @cfo='02' and @dir='01' and @ceo='01'
	Begin
	set @StatusPC_1 = 'Aguardando Aprovação 2º Diretor'
	end

	if @valor > '50000.00' and @ctrl= '02' and @cfo='02' and @dir='02' and @ceo='01'
	Begin
	set @StatusPC_1 = 'Aguardando Aprovação CEO'
	end

	
	update OPOR set U_TDS_APROV5 = @statusPC where docentry = @list_of_cols_val_tab_del
	update OPOR set NumAtCard = @statusPC_1 where docentry = @list_of_cols_val_tab_del
	IF @statusPC = 03 
	BEGIN
	update OPOR set DOCSTATUS = 'C' where docentry = @list_of_cols_val_tab_del
	UPDATE OPOR SET CANCELED ='Y' WHERE docentry = @list_of_cols_val_tab_del
	UPDATE POR1 SET LINESTATUS ='C' WHERE docentry = @list_of_cols_val_tab_del
	UPDATE OPOR SET U_DC_Status = '04' WHERE docentry = @list_of_cols_val_tab_del
	END
	end
end

--Fim status pedido
-- Reabri pedido de compras ao cancelar nota 

if  @object_type = '18' and( @transaction_type in('A'))
  Begin
  declare @pedidoC int 
  set @pedidoC = (select top 1 U_DC_PedComp From OPCH  where DocEntry =  @list_of_cols_val_tab_del and CANCELED <>'N') 
  --declare @DocBae as int
  --set @DocBae =  case when (select distinct baseentry from PCH1 where DocEntry =@list_of_cols_val_tab_del )> 0 then 1 else 0 end
  if @pedidoC > 0   begin 
  declare @linhasped as int
  set @linhasped =(select count(linenum) from por1 where docentry=@pedidoC )
  if  @linhasped >1 
  begin
  
 UPDATE OPOR set DOCSTATUS = 'O' where docentry = @pedidoC 
 UPDATE POR1 SET LINESTATUS ='O' WHERE docentry = @pedidoC and docentry not in (select isnull(baseentry,'') from PCH1 where BaseLine =por1.LineNum  )
 end
 if @linhasped = 1 
 begin
 
 UPDATE OPOR set DOCSTATUS = 'O' where docentry = @pedidoC
 UPDATE POR1 SET LINESTATUS ='O' WHERE docentry = @pedidoC 
 end
 UPDATE OPOR SET U_DC_Status = '01' WHERE docentry = @pedidoC
end
end

-- if  @object_type = '18' and( @transaction_type in('A'))
--    Begin
--  declare @pedidoC int 
--  set @pedidoC = (select top 1 U_DC_PedComp From OPCH  where DocEntry =  @list_of_cols_val_tab_del and CANCELED='C') 
--  if @pedidoC > 0 begin 
-- update OPOR set DOCSTATUS = 'O' where docentry = @pedidoC
--UPDATE POR1 SET LINESTATUS ='O' WHERE docentry = @pedidoC
--UPDATE OPOR SET U_DC_Status = '01' WHERE docentry = @pedidoC
--end
--end

 -- Fim     
--Muda Status para pendente sempre que adiciona um PC novo
    
    if  @object_type = '22' and( @transaction_type in('A'))
    Begin
    
        update OPOR set U_TDS_Aprov2 ='01' where docentry =@list_of_cols_val_tab_del
     End 

    --Guarda Status do Pedido na tabela de Log
      if  @object_type = '22' and( @transaction_type in('A', 'U'))

    begin  

declare @PC as Nvarchar (20)
declare @Status as Nvarchar (10)
declare @ValorPC as Numeric (19,6)

set @PC = (select DocNum from OPOR where DocEntry = @list_of_cols_val_tab_del)
set @Status =(select u_TDS_APROV1 from OPOR where DocEntry =@list_of_cols_val_tab_del )
set @ValorPC =(select DocTotal from OPOR where DocEntry =@list_of_cols_val_tab_del )

if @PC not in (select CODE from DC_EFD.dbo.DC_Controle_PC where Code =@PC) 
begin
--set @ValorPC  = (select Valor from  DC_EFD.dbo.DC_Controle_PC where CODE= @PC)
--delete from DC_EFD.dbo.DC_Controle_PC where code = @PC
insert into DC_EFD.dbo.DC_Controle_PC values (@PC, @Status, @ValorPC )
end

if @PC in (select CODE from DC_EFD.dbo.DC_Controle_PC where Code =@list_of_cols_val_tab_del) 
begin
update DC_EFD.dbo.DC_Controle_PC set name = @Status where code =@list_of_cols_val_tab_del 
end
end

-- Atualiza Status quando o pedido for autorizado pelo Gilson.

if  @object_type = '22' and( @transaction_type in ('U'))
Begin
if (SELECT count(T0.DocEntry)
        FROM OPOR T0  INNER JOIN DC_EFD.DBO.DC_Controle_PC T1 on cast(T0.DOCENTRY as nvarchar(20))COLLATE SQL_Latin1_General_CP1_CI_AS =cast(T1.CODE as nvarchar (20))COLLATE SQL_Latin1_General_CP1_CI_AS
         WHERE 
      cast (   T0.U_TDS_APROV1 as nvarchar(100))collate SQL_Latin1_General_CP1_CI_AS <> cast(T1.Name as nvarchar(20)) collate SQL_Latin1_General_CP1_CI_AS
         AND T0.UserSign2  IN (6)
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    Begin
update DC_EFD.dbo.DC_Controle_PC set name = @Status where code =@list_of_cols_val_tab_del 
end
end


--Verifica se Status está diferente do log e se usuário pode mudar

 -- if  @object_type = '22' and( @transaction_type = 'U')

  --  begin  
  --   if
  --(SELECT count(T0.DocEntry)
  --      FROM OPOR T0  INNER JOIN DC_EFD.DBO.DC_Controle_PC T1 on cast(T0.DOCENTRY as nvarchar(20))COLLATE SQL_Latin1_General_CP1_CI_AS =cast(T1.CODE as nvarchar (20))COLLATE SQL_Latin1_General_CP1_CI_AS
  --       WHERE 
  --    cast (   T0.U_TDS_APROV1 as nvarchar(100))collate SQL_Latin1_General_CP1_CI_AS <> cast(T1.Name as nvarchar(20)) collate SQL_Latin1_General_CP1_CI_AS
  --       AND T0.UserSign2 NOT IN (6)
  --  AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
  --    Begin
      
  --    SET @error      = 78
  --    SET @error_message  = 'Sem permissão para modificar status de aprovação '
    
  --  end
  --  end
    

    -- Impede inserção de pedido de compra com status aprovado
    if  @object_type = '22' and( @transaction_type = 'A')

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPOR T0  
         WHERE 
      T0.U_TDS_APROV5 =02
      and U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 78
      SET @error_message  = 'Pedido de Compra com Status Autorizado para a Area Selecionada não é permitido, selecione pendente para responsável aprovar '
    
    end
    end


    --Checa se Controladoria aprovou o Pedido Para liberar Aprovação de Compras.
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPOR T0  
         WHERE 
      T0.U_TDS_APROV2 <> '02' and T0.U_TDS_APROV1 ='02' and T0.U_TDS_APROV5<>'02' 
      and U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and T0.Docdate >='20180912'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 78
      SET @error_message  = 'Pedido ainda não Autorizado pela Controladoria, aguardar autorização...'
    
    end
    end

    --Checa se CFO aprovou o Pedido Para liberar Aprovação de Compras.
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPOR T0  
         WHERE 
      T0.U_TDS_APROV1 <> '02' and T0.U_TDS_APROV3 ='02' and T0.U_TDS_APROV5<>'02' 
      and U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and T0.Docdate >='20180912'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 78
      SET @error_message  = 'Pedido ainda não Autorizado pelo CFO, aguardar autorização...'
    
    end
    end


 --   Checa se 2º Diretor aprovou o Pedido Para liberar Aprovação de Compras.
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPOR T0  
         WHERE 
      T0.U_TDS_APROV3 <> '02' and T0.U_TDS_APROV4 ='02' and T0.U_TDS_APROV5<>'02'
      and U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and T0.Docdate >='20180912'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 78
      SET @error_message  = 'Pedido ainda não Autorizado pelo 2º Diretor, aguardar autorização...'
    
    end
    end

    --Impede inserção de NF de entrada com status do pedido de compras como pendente

      if  @object_type = '18' and( @transaction_type in( 'A','U'))

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPCH T0  inner join PCH1 T1 ON T0.DOCENTRY =T1.DocEntry LEFT JOIN OPOR T2 ON T1.BaseEntry =T2.DocEntry 
         WHERE 
      (T2.U_TDS_APROV1 <>02 )
      and T2.U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and t2.DocDate >='20180912'
      and T0.DocTotal >'10000.00' and T0.DocTotal <'50000.00'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 799
      SET @error_message  = 'Pedido de compras deve ser aprovado pelo CFO, valores entre 10 e 50 mil'
    
    end
    end


    -- Aprovação Segundo Diretor
      if  @object_type = '18' and( @transaction_type in( 'A','U'))

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPCH T0  inner join PCH1 T1 ON T0.DOCENTRY =T1.DocEntry LEFT JOIN OPOR T2 ON T1.BaseEntry =T2.DocEntry 
         WHERE 
      (T2.U_TDS_APROV3 <>02 )
      and T2.U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and t2.DocDate >='20180912'
      and T0.DocTotal >'50000.01' and T0.DocTotal <'100000.00'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 799
      SET @error_message  = 'Pedido de compras deve ser aprovado pelo Segundo Diretor, valores entre 50 e 100 mil'
    
    end
    end


      -- Aprovação CEO
      if  @object_type = '18' and( @transaction_type in( 'A','U'))

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPCH T0  inner join PCH1 T1 ON T0.DOCENTRY =T1.DocEntry LEFT JOIN OPOR T2 ON T1.BaseEntry =T2.DocEntry 
         WHERE 
      (T2.U_TDS_APROV4 <>02 )
      and T2.U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and T0.DocTotal >'100000.01'
      and t2.DocDate >='20180912'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 799
      SET @error_message  = 'Pedido de compras deve ser aprovado pelo CEO, valor superior a 100 mil'
    
    end
    end

      if  @object_type = '18' and( @transaction_type in( 'A','U'))

    begin  
     if
  (SELECT count(T0.DocEntry)
        FROM OPCH T0  inner join PCH1 T1 ON T0.DOCENTRY =T1.DocEntry LEFT JOIN OPOR T2 ON T1.BaseEntry =T2.DocEntry 
         WHERE 
      (T2.U_TDS_APROV2 <>02 )
      and T2.U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
      and t2.DocDate >='20180912'
    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
      Begin
      
      SET @error      = 78
      SET @error_message  = 'Pedido com status pendente pela controladoria não pode ser lançado como Nota Fiscal de Entrada'
    
    end
    end


--    --Guarda Status do Pedido na tabela de Log
--      if  @object_type = '22' and( @transaction_type in('A', 'U'))

--    begin  

--declare @PC as Nvarchar (20)
--declare @Status as Nvarchar (10)
--declare @ValorPC as numeric (19,6)
--set @PC = (select docentry from OPOR where DocEntry = @list_of_cols_val_tab_del)
--set @Status =(select u_TDS_APROV1 from OPOR where DocEntry =@list_of_cols_val_tab_del )
--set @ValorPc =(select DocTotal from OPOR where DocEntry =@list_of_cols_val_tab_del )
--if @PC not in (select CODE from DC_EFD.dbo.DC_Controle_PC where Code =@list_of_cols_val_tab_del) 
--begin
--insert into DC_EFD.dbo.DC_Controle_PC values (@PC, @Status,@ValorPC )
--end
----if @PC in (select CODE from DC_EFD.dbo.DC_Controle_PC where Code =@list_of_cols_val_tab_del) 
----begin
----update DC_EFD.dbo.DC_Controle_PC set name = @Status where code =@list_of_cols_val_tab_del 
----end
--end

---- Atualiza Status quando o pedido for autorizado pelo Gilson.

--if  @object_type = '22' and( @transaction_type in ('U'))
--Begin
--if (SELECT count(T0.DocEntry)
--        FROM OPOR T0  INNER JOIN DC_EFD.DBO.DC_Controle_PC T1 on cast(T0.DOCENTRY as nvarchar(20))COLLATE SQL_Latin1_General_CP1_CI_AS =cast(T1.CODE as nvarchar (20))COLLATE SQL_Latin1_General_CP1_CI_AS
--         WHERE 
--      cast (   T0.U_TDS_APROV1 as nvarchar(100))collate SQL_Latin1_General_CP1_CI_AS <> cast(T1.Name as nvarchar(20)) collate SQL_Latin1_General_CP1_CI_AS
--         AND T0.UserSign2  IN (6)
--    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
--    Begin
--update DC_EFD.dbo.DC_Controle_PC set name = @Status where code =@list_of_cols_val_tab_del 
--end
--end


----Verifica se Status está diferente do log e se usuário pode mudar

--  if  @object_type = '22' and( @transaction_type = 'U')

--    begin  
--     if
--  (SELECT count(T0.DocEntry)
--        FROM OPOR T0  INNER JOIN DC_EFD.DBO.DC_Controle_PC T1 on cast(T0.DOCENTRY as nvarchar(20))COLLATE SQL_Latin1_General_CP1_CI_AS =cast(T1.CODE as nvarchar (20))COLLATE SQL_Latin1_General_CP1_CI_AS
--         WHERE 
--      cast (   T0.U_TDS_APROV1 as nvarchar(100))collate SQL_Latin1_General_CP1_CI_AS <> cast(T1.Name as nvarchar(20)) collate SQL_Latin1_General_CP1_CI_AS
--         AND T0.UserSign2 NOT IN (6)
--    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
--      Begin
      
--      SET @error      = 78
--      SET @error_message  = 'Sem permissão para modificar status de aprovação '
    
--    end
--    end
    

--    -- Impede inserção de pedido de compra com status aprovado
--    if  @object_type = '22' and( @transaction_type = 'A')

--    begin  
--     if
--  (SELECT count(T0.DocEntry)
--        FROM OPOR T0  
--         WHERE 
--      T0.U_TDS_APROV1 =02
--      and U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
--    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
--      Begin
      
--      SET @error      = 78
--      SET @error_message  = 'Pedido de Compra com Status Autorizado para a Area Selecionada não é permitido, selecione pendente para responsável aprovar '
    
--    end
--    end


--    --Impede inserção de NF de entrada com status do pedido de compras comp pendente

--      if  @object_type = '18' and( @transaction_type in( 'A','U'))

--    begin  
--     if
--  (SELECT count(T0.DocEntry)
--        FROM OPCH T0  inner join PCH1 T1 ON T0.DOCENTRY =T1.DocEntry LEFT JOIN OPOR T2 ON T1.BaseEntry =T2.DocEntry 
--         WHERE 
--      T2.U_TDS_APROV1 <>02
--      and T2.U_TDS_AREA not in ('CONTRATOS', 'TESOURARIA')
--    AND    T0.DocEntry = @list_of_cols_val_tab_del) > 0
    
--      Begin
      
--      SET @error      = 78
--      SET @error_message  = 'Pedido com status pendente não pode ser lançado como Nota Fiscal de Entrada'
    
--    end
--    end
/*

--Valida Unidade solicitacao de compras








    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End

    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(24,29,5,28,47)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Na Solicitação de Compras é necessário informar a Unidade de Negócio '
    End
    -- Filial Osasco
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Rio de Janeiro
      if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Hortolândia
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Sumaré
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End


    --Filial Vinhedo
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
      
      WHERE T0.BPLId in(47)
      and (T0.u_Unidade not in('13','14', '15'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End

    -- Valida Unidade de Negócio no pedido de compras

      if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(24,29,5,28,47)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'No Pedido de Compras é necessário informar a Unidade de Negócio '
    End
    -- Filial Osasco
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Rio de Janeiro
      if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Hortolândia
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09','16'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Sumaré
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08','17'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End


    --Filial Vinhedo
    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPOR T0
      
      WHERE T0.BPLId in(47)
      and (T0.u_Unidade not in('13','14', '15'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End

    --Valida Unidade de Negócio NF de Entrada
    if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(24,29,5,28,47)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 77
      SET @error_message  = 'Para Lançar Despesas é necessário informar a Unidade de Negócio '
    End

    --Filial Osasco
    if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Rio de Janeiro
      if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Hortolândia
    if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09','16'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Sumaré
    if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08','17'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End


    --Filial Vinhedo
    if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPCH T0
      
      WHERE T0.BPLId in(47)
      and (T0.u_Unidade not in('13','14', '15'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End


    --Valida Unidade de negócio Nota fiscal de saída
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(24,29,5,28,47)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'No Faturamento é necessário informar a Unidade de Negócio '
    End

    --Filial Osasco
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Rio de Janeiro
      if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Hortolândia
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09','16'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Sumaré
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08','17'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End

    --Filial Vinhedo
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OINV T0
      
      WHERE T0.BPLId in(47)
      and (T0.u_Unidade not in('13','14', '15'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
  
      --Valida Unidade de Negócio LCM
    if  @object_type = '30' and( @transaction_type = 'A'or  @transaction_type = 'U')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(24,29,5,28,47)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Para Lançar Despesas é necessário informar a Unidade de Negócio '
    End

    -- FIlial Osasco
    if  @object_type = '30' and(  @transaction_type = 'A'or  @transaction_type = 'U')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(24)
      and (T0.u_Unidade not in ('01','02','11','12'))
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- FIlial Rio de Janeiro
    if  @object_type = '30' and( @transaction_type = 'A')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(29)
      and (T0.u_Unidade not in ('03','04','10'))
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Hortolândia
    if  @object_type = '30' and( @transaction_type = 'A')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(5)
      and (T0.u_Unidade not in ('05','06','09','16'))
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Sumaré
    if  @object_type = '30' and( @transaction_type = 'A')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(28)
      and (T0.u_Unidade not in ('07','08','17'))
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    
    --Filial Vinhedo
    if  @object_type = '30' and(  @transaction_type = 'A'or  @transaction_type = 'U')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransId =T1.TransId 
      
      WHERE T1.BPLId IN(47)
      and (T0.u_Unidade not in ('13','14','15'))
      and T0.TransType=30
      and (T0.Memo not like '%Capitalização%'
      or T0.ref1 not like'Trf O%')
      and t1.ShortName not in('1.1.1.002.010','1.1.1.002.001')
                 AND T0.TransId   = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 78
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    */
    --Preenche Observações dos Pedidos de Vendas

--   if  @object_type = '13' and( @transaction_type in( 'A', 'U'))

--    begin  

--DECLARE @VENCIMENTO AS NVARCHAR(20)
--declare @Mes as Nvarchar (20)

--set @VENCIMENTO = (select convert(nvarchar(10),(DocDueDate),104) from oinv where docentry =@list_of_cols_val_tab_del)

--set @mes = (
--select case when month(getdate()) = 01 then 'JANEIRO'
--when month(getdate()) = 02 then 'FEVEREIRO'
--when month(getdate()) = 03 then 'MARÇO'
--when month(getdate()) = 04 then 'ABRIL'
--when month(getdate()) = 05 then 'MAIO'
--when month(getdate()) = 06 then 'JUNHO'
--when month(getdate()) = 07 then 'JULHO'
--when month(getdate()) = 08 then 'AGOSTO'
--when month(getdate()) = 09 then 'SETEMBRO'
--when month(getdate()) = 10 then 'OUTUBRO'
--when month(getdate()) = 11 then 'NOVEMBRO'
--when month(getdate()) = 12 then 'DEZEMBRO'
--  end    )

--Begin

--      update OINV set Header  = CONVERT(NVARCHAR(max),('FATURAMENTO REFERENTE ')) + @mes + ' '+ CONVERT (NVARCHAR(10),( YEAR(GETDATE()))) +' '+ 'VENCIMENTO: ' + @VENCIMENTO
-- WHERE DocEntry  =@list_of_cols_val_tab_del  and bplid in( 3,8,12,13,26)

-- -- update ORDR set Comments  = CONVERT(NVARCHAR(max),('REFERENTE ')) + @mes + ' ' +  CONVERT (NVARCHAR(10),( YEAR(GETDATE())))
-- --WHERE DocEntry  =@list_of_cols_val_tab_del 

      
--End 
--ENd

--------------------------------------------------------------------------------------------------------------------------------

--  VALIDAÇÕES CRIADAS POR BRUNO PALLOTA - CRIADO EM 14/07/2018

--Última atualização 14/07/2018

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*--Unidade de negócio entrada de mercadorias -- Criado por Bruno Pallota 14.07.2018 --
      if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGN T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGN T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
      -- Filial Rio de Janeiro
      if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGN T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Hortolândia
    if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGN T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- Filial Sumaré
    if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGN T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- PREENCHE UNIDADE DE NEGÓCIO LCM

      if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from OIGN where DocEntry = @list_of_cols_val_tab_del )
      declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OIGN T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =59
      end
End

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--Unidade de negócio saída de mercadorias -- Criado por Bruno Pallota 14.07.2018 --
      if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGE T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    -- Filial Osasco
    if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGE T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
      --Filial Rio de Janeiro
      if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGE T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Hortolândia
    if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGE T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Sumaré
    if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OIGE T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- PREENCHE UNIDADE DE NEGÓCIO LCM

      if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from OIGE where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OIGE T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =60
      end
End
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Valida Unidade de negócio tranferência de estoque -- Criado por Bruno Pallota 14.07.2018 --

      if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OWTR T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OWTR T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Rio de Janeiro
      if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OWTR T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Hortolândia
    if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OWTR T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    --Filial Sumaré
    if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OWTR T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento '
    End
    -- PREENCHE UNIDADE DE NEGÓCIO LCM

      if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from OWTR where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OWTR T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =67
      end
End
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Validação unidade de negócio Dev.Nota Fiscal de Entrada -- Criado por Bruno Pallota 14.07.2018 --

  if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPC T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPC T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    -- Filial Rio de Janeiro
      if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPC T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Hortolândia
    if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPC T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Sumaré
    if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPC T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End

          -- PREENCHE UNIDADE DE NEGÓCIO LCM

      if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from ORPC where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM ORPC T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =19
      end
End
--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------- 
-- Validação unidade de negócio Recebimento de Mercadorias -- Criado por Bruno Pallota 14.07.2018 --

  if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPDN T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPDN T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Rio de Janeiro
      if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPDN T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Hortolândia
    if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPDN T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Sumaré
    if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPDN T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End

--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------- 
-- Validação unidade de negócio Devolução de Mercadorias -- Criado por Bruno Pallota 14.07.2018 --

if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPD T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = 'Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPD T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Rio de Janeiro
      if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPD T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Hortolândia
    if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPD T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Sumaré
    if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORPD T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    
--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------- 
-- Validação unidade de negócio Adiantamento Fornecedor -- Criado por Bruno Pallota 14.07.2018 --

  if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODPO T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = '204 Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODPO T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Rio de Janeiro
      if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODPO T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Hortolândia
    if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODPO T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Sumaré
    if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODPO T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    -- PREENCHE UNIDADE DE NEGÓCIO LCM

      if  @object_type = '204' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from ODPO where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM ODPO T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =204
      end
End
--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------- 
-- Validação unidade de negócio Entrega(Vendas) -- Criado por Bruno Pallota 14.07.2018 --

  if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODLN T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = '15 Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODLN T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --Filial Rio de Janeiro
      if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODLN T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --FIlial Hortolândia
    if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODLN T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --FIlial Sumaré
    if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODLN T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Validação unidade de negócio Devolução(Vendas) -- Criado por Bruno Pallota 14.07.2018 --

if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORDN T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = '16 Para esta operação é necessário informar a Unidade de Negócio'
    End
    --FIlial Osasco
    if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORDN T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    -- FIlial Rio de Janeiro
      if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORDN T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --FIlial Hortolândia
    if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORDN T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --FIlial Sumaré
    if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORDN T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
-- Validação unidade de negócio Dev. Nota Fiscal de Saída -- Criado por Bruno Pallota 14.07.2018 --

if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORIN T0
      
      WHERE T0.BPLId in(24,29,5,28)
      and (T0.u_Unidade ='' or t0.U_Unidade is null)
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 79
      SET @error_message  = '14 Para esta operação é necessário informar a Unidade de Negócio'
    End
    --Filial Osasco
    if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORIN T0
      
      WHERE T0.BPLId in(24)
      and (T0.u_Unidade not in('01','02','11','12'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End
    --FIlial Rio de Janeiro
      if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORIN T0
      
      WHERE T0.BPLId in(29)
      and (T0.u_Unidade not in('03','04','10'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End   
    --FIlial Hortolândia
    if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORIN T0
      
      WHERE T0.BPLId in(5)
      and (T0.u_Unidade not in('05','06','09'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End   
    
    --FIlial Sumaré
    if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ORIN T0
      
      WHERE T0.BPLId in(28)
      and (T0.u_Unidade not in('07','08'))
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Unidade Informada não Pertence a Filial do Documento.'
    End   
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
      -- PREENCHE UNIDADE DE NEGÓCIO LCM NF DE SAIDA - Criado por Bruno Pallota 14.07.2018 --

      if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from OINV where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OINV T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =13
      end
End 

-- PREENCHE UNIDADE DE NEGÓCIO LCM NF DE ENTRADA - Criado por Bruno Pallota 14.07.2018 --

      if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      --declare @unidade as nvarchar (20)
      set @unidade = (select distinct(u_unidade) from OPCH where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OPCH T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        WHERE T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update ojdt set U_Unidade = @unidade  where BaseRef  =@list_of_cols_val_tab_del  and TransType =18
      end
End 
*/


---VALIDAÇÕES ENTRADA AUTOMÁTICA DE NF---

  if  @object_type = '112' and(  @transaction_type ='U')
      begin
      declare @PedCompra as int
      declare @Validado as nvarchar(100)
      declare @ObsFluxo as nvarchar(max)
      set @Validado = (select U_DC_ValidaCompras from ODRF where docentry=@list_of_cols_val_tab_del )
      set @PedCompra = (Select U_DC_PedComp from ODRF where docentry = @list_of_cols_val_tab_del)
      set @ObsFluxo = (Select U_DC_Obs_Fluxo from ODRF where docentry = @list_of_cols_val_tab_del)
      if @PedCompra > 0
      Begin
      declare @Account as nvarchar (100)
      set @Account =(select TOP 1  AcctCode from POR1 T0 inner join OPOR t1 on t0.docentry=t1.DocEntry INNER JOIN ODRF T3 ON T1.DOCNUM = T3.U_DC_PedComp  where  (AcctCode like '5%' OR AcctCode like '4%') and T3.DOCENTRY=@list_of_cols_val_tab_del ORDER BY T0.LINENUM ASC)
      end
      --declare @baseref as nvarchar (10)
    IF @Account <> '' and (@Validado <> 'Sim' or @Validado is null) and (@ObsFluxo is null)
Begin
            SET @error      = 777
      SET @error_message  = 'Pedido de Compras para Despesas ou Custo, realizar a validação do Pedido'
      end 
End

---Atualiza Obs Esboço ----



if  @object_type = '112' and(  @transaction_type in('A', 'U'))
      begin
      declare @NumNf as nvarchar (200)
      declare @Fornecedor as nvarchar(100)
      set @NumNf  = (select Serial from ODRF where docentry=@list_of_cols_val_tab_del )
      set @Fornecedor  = (Select CardName  from ODRF where docentry = @list_of_cols_val_tab_del)
      
      
      update odrf set JrnlMemo = (select 'NF ENTRADA: ' +@NumNf + ' ' + CONVERT(NVARCHAR(10),(@Fornecedor))) where DocEntry =@list_of_cols_val_tab_del 
     -- set @Account =(select TOP 1  AcctCode from POR1 T0 inner join OPOR t1 on t0.docentry=t1.DocEntry INNER JOIN ODRF T3 ON T1.DOCNUM = T3.U_DC_PedComp  where  (AcctCode like '5%' OR AcctCode like '4%') and T3.DOCENTRY=@list_of_cols_val_tab_del ORDER BY T0.LINENUM ASC)
      
      -- Impede gravação de esboço com conta validada diferente da conta do esboço.

if  @object_type = '112' and(  @transaction_type in('A', 'U'))
BEGIN
create table ##TMP_ACCOUNT (linha  INT, docentry  NVARCHAR(100), ITEMSAP  nvarchar(200), ACCTCODESAP nvarchar(200), ACCTCODEDUO  nVARCHAR(100), LINENUM INT)
insert into ##TMP_ACCOUNT 

select distinct
ROW_NUMBER ()over (order by T1.LINENUM)'Linha', 
 T0.DocEntry , T1.ItemCode , ISNULL(T1.ACCTCODE, 'semconta' ) , t1.U_DC_ACCTCODE, T1.LineNum 
  from 
  
ODRF T0 INNER JOIN DRF1 T1 ON T0.DocEntry =T1.DOCENTRY 
INNER JOIN OITM T2 ON T1.ItemCode =T2.ItemCode 
 WHERE T0.DOCENTRY =@list_of_cols_val_tab_del 

 DECLARE @LINHA AS INT
 SET @LINHA = (SELECT MAX(LINENUM) FROM ##TMP_ACCOUNT)
 DECLARE @COUNT AS INT
 SET @COUNT =0
 DECLARE @ITEMLINHA AS NVARCHAR (200)
 DECLARE @AccountDUO AS NVARCHAR (200)

WHILE @COUNT <= @LINHA
BEGIN     
  SET @ITEMLINHA = (SELECT ITEMSAP FROM ##TMP_ACCOUNT WHERE LINENUM =@COUNT )
  SET @AccountDUO = (SELECT ACCTCODEDUO FROM ##TMP_ACCOUNT WHERE LINENUM =@COUNT)     
      
      IF @ITEMLINHA LIKE 'C%' AND @AccountDUO LIKE '4%' 
Begin
            SET @error      = 7771
      SET @error_message  = 'Verifique se contas contábeis estão corretas, item de custo informado e conta de despesa atribúída: ' +  @ITEMLINHA
      end

      IF @ITEMLINHA LIKE 'D%' AND @AccountDUO LIKE '5%' 
Begin
            SET @error      = 7771
      SET @error_message  = 'Verifique se contas contábeis estão corretas, item de despesa informado e conta de custo atribúída: ' +  @ITEMLINHA
      end

      set @COUNT = @COUNT + 1
      continue
ENd
DROP TABLE ##TMP_ACCOUNT 
End


End


----------------------------------------------------------------------------------------------------------------------
------ Trava - solicitação de compras e esboço.
------ Regra: Obrigar o preenchimento do campo 'Justificativa para escolha do fornecedor ou cotação'
------ Data de criação: 21/07/2022
------ Desenvolvimento: Marcos Silva - DuoConect
------ Chamado - 2425
------ Change - 14/04/2023 
----------------------------------------------------------------------------------------------------------------------



	if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      
	  IF (SELECT count(*)
      FROM OPRQ T0 LEFT JOIN ODRF T1 ON T0.draftKey = T1.DOCENTRY   
     
	 WHERE (convert(nvarchar(100), T0.U_DC_JustFC) ='' or convert(nvarchar(100), T0.U_DC_JustFC)is null)
				 AND T0.CreateDate >= '20230417'
				 AND T1.CREATEDATE IS NULL
				 AND T0.draftKey IS NULL
                 AND T0.DocEntry  = @list_of_cols_val_tab_del 
				  ) > 0
    Begin
      SET @error      = 957
      SET @error_message  = 'Informe a Justificativa para escolha do fornecedor ou cotação'
    End


	  if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      
	  IF (SELECT count(*)
      FROM OPRQ T0 LEFT JOIN ODRF T1 ON T0.draftKey = T1.DOCENTRY   
      
	  WHERE (convert(nvarchar(100), T0.U_DC_JustFC) ='' or convert(nvarchar(100), T0.U_DC_JustFC)is null)
				 AND T1.CreateDate >= '20230417'
				 AND T1.CREATEDATE IS NOT NULL
				 AND T0.draftKey IS NOT NULL
                 AND T0.DocEntry  = @list_of_cols_val_tab_del 
				  ) > 0
    Begin
      SET @error      = 958
      SET @error_message  = 'Informe a Justificativa para escolha do fornecedor ou cotação'
    End



 
 if  @object_type = '112' and(  @transaction_type in ('A','U'))
      
	  IF (Select Count(*) 
	  FROM ODRF T0 
      INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry   
       
	   Where 
       T0.DocEntry = @list_of_cols_val_tab_del 
	   and T0.CANCELED <> 'C' 
	   and T0.CreateDate >= '20230417'
	   and T0.ObjType = '1470000113' 
	   AND (convert(nvarchar(100), T0.U_DC_JustFC) ='' or convert(nvarchar(100), T0.U_DC_JustFC)is null)
      ) > 0

        BEGIN
          SET @error      = 959
          SET @error_message  = 'Informe a Justificativa para escolha do fornecedor ou cotação'
      END
   ----------------------------------------------------------------------------------------------------------------------- 
------ Fim da Trava para Obrigar o preenchimento do campo 'Justificativa para escolha do fornecedor ou cotação'
-------------------------------------------------------------------------------------------------------------------------------

--Valida item de ativo duplicado no esboço
  if  @object_type = '112' and(  @transaction_type IN('A', 'U'))
      begin
     IF (SELECT top 1 count(T0.ItemCode)
      FROM DRF1 T0 INNER JOIN ODRF T1 ON T0.DocEntry =T1.DocEntry 
        INNER JOIN OITM T2 on T0.ItemCode =t2.itemcode 
      WHERE 
      T1.U_DC_ValidaCompras ='Sim'  and t2.ItemType ='F'
      and  T0.DocEntry  = @list_of_cols_val_tab_del group by t0.itemcode  order by 1 desc) > 1
    Begin
      SET @error      = 7
      SET @error_message  = 'Item de ativo duplicado.'
    End   
End

-- Valida item de filial diferente no esboço
 if  @object_type = '112' and(  @transaction_type IN('A', 'U'))
      begin
     IF (SELECT count(T0.Docentry)
      FROM DRF1 T0 inner join ODRF T100 on t0.DocEntry =T100.DocEntry  inner join OITM T1 on T0.ItemCode =T1.ItemCode 
      inner join OACS T2 on T1.AssetClass =T2.Code
      inner join oitm t3 on t0.ItemCode =t3.ItemCode 
      
      WHERE 
        T2.BPLId <> T100.BPLId and T100.U_DC_ValidaCompras ='Sim' and t3.ItemType ='f'
       and T0.DocEntry  = @list_of_cols_val_tab_del ) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Item de ativo não pertence a filial do documento, verifique itens do esboço.'
    End   
End
/*
-- Valida se todas as areas checaram o esboço de NF de entrada antes de permitir inserção do documento

 if  @object_type = '18' and(  @transaction_type = 'A')
      begin
    --  declare @PedCompra as int
    --  declare @Validado as nvarchar(100)
      set @Validado = (select U_DC_ValidaCompras from OPCH where draftkey<>'' and docentry=@list_of_cols_val_tab_del )
      set @PedCompra = (Select U_DC_PedComp from OPCH where draftkey<>'' and docentry = @list_of_cols_val_tab_del)
      if @PedCompra > 0
      Begin
      declare @ValidContabilidade as nvarchar(10)
      declare @ValidFiscal as nvarchar(10)
      set @ValidContabilidade = (select U_DC_ValidaContabil  from OPCH where draftkey<>'' and docentry=@list_of_cols_val_tab_del )
      set @ValidFiscal = (select U_DC_ValidaFiscal from OPCH where draftkey<>'' and docentry=@list_of_cols_val_tab_del )
      declare @Esboco as int
      declare @Utilizacao as int --utilização (14/12/2020) Chamado 1729
      set @Esboco = (select DraftKey from OPCH where draftkey<>'' and docentry=@list_of_cols_val_tab_del )
      set @Utilizacao = (select count (T0.Usage) from PCH1 T0 INNER JOIN OUSG T1 on T0.Usage = T1.ID where (T1.FreeChrgBP <> 'Y' or T1.TaxOnly <> 'Y') and T0.DocEntry = @list_of_cols_val_tab_del) 
      end
      --declare @baseref as nvarchar (10)
    IF ((@ValidContabilidade <> 'Sim' or @ValidFiscal <> 'Sim')or (@ValidContabilidade is null or @ValidFiscal is null)) and @Esboco >0 and @Utilizacao > 0 --Alterado em 27/11/2020 para não bloquear NFs de remessa (gratuito e só imposto <> de Sim)
Begin
            SET @error      = 777
      SET @error_message  = 'Esboço não Validado por todas as areas, checar status de verificação do documento'
      end
End
-- Processa XML na tela da Skill
*/
if  @object_type = '18' and(  @transaction_type ='A')
      begin
    declare @DocImp as int
    set @DocImp =(select draftKey  from opch where docentry =@list_of_cols_val_tab_del)

      end
      --declare @baseref as nvarchar (10)
    IF @DocImp <> 0
Begin
            update [dbo].[@SKILL_IMPO_ADMI_001] set U_OpEsboco  = 'N' where u_NrDocumento=@DocImp 
      update [dbo].[@SKILL_IMPO_ADMI_001] set U_NrDocumento  = @list_of_cols_val_tab_del  where u_NrDocumento=@DocImp 
      end

-- Impede adicionar NF - Criado por Bruno 08/10/2018

--if  @object_type = '18' and(  @transaction_type ='A')
--  begin
--  if (SELECT count(T0.DocEntry) FROM OPCH T0 WHERE T0.Usersign not in ('286','282','40','43','38','1', '121','122','154','159','162','177', '187','196', '194','161','223','142') and T0.U_TDS_AREA not in ('TESOURARIA') and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
--  begin
--  SET @error = 778
--  SET @error_message = 'Usuário não autorizado a inserir nota fiscal de entrada'
--  end
--  end

-- Impede grava esboço se os campos NUMERO DO PEDIDO DE COMPRAS, QUANTIDADE, PREÇO UNITARIO não estiverem preenchido - Criado por Bruno 27/11/2018

if  @object_type = '112' and(  @transaction_type = 'U')
  begin
  if (SELECT count(T0.DocEntry) FROM ODRF T0 WHERE T0.ObjType = '18'and T0.U_DC_cancel  <> '02' and t0.U_DC_ValidaCompras ='Sim' and T0.U_DC_PedComp is null and T0.DocEntry  =@list_of_cols_val_tab_del) > 0
  begin
  SET @error = 779
  SET @error_message = 'Número do pedido de compras deve ser informado'
  end
  end

if  @object_type = '112' and(  @transaction_type = 'U')
  begin
  if (SELECT count(T0.DocEntry) FROM DRF1 T0 INNER JOIN ODRF T1 ON T0.DocEntry = T1.DocEntry WHERE T1.ObjType = '18' and T0.Price <= '0.000000' and T0.DocEntry  =@list_of_cols_val_tab_del) > 0
  begin
  SET @error = 780
  SET @error_message = 'Informe o valor unitário na linha do documento'
  end
  end
  /*
  --Impede Integracao de NF duplicada (Importador DuoConect)
        if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
  begin

  declare @chaveA as nvarchar(200)
  set @chaveA =(select u_chaveacesso from odrf where DocEntry =@list_of_cols_val_tab_del and CreateDate not in ('20201219', '20201220') )

  if @chaveA in (select u_chaveacesso from odrf where DocEntry <> @list_of_cols_val_tab_del and ObjType in (18,20) and DocStatus = 'O' and CreateDate not in ('20201219', '20201220') )
  begin
  SET @error = 779
  SET @error_message = 'XML COM CHAVE DE ACESSO JA INTEGRADO COMO ESBOCO'
  end
  enD*/

  
  --Impede Integracao de NF duplicada (Importador DuoConect) NF ENTRADA --Alteração 08/04/2024 chamado 3485 
        if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
  begin

  declare @chaveA as nvarchar(200)
  set @chaveA =(select u_chaveacesso from odrf where DocEntry =@list_of_cols_val_tab_del and CreateDate not in ('20201219', '20201220') and ObjType in (18) )
 
  if @chaveA in (select u_chaveacesso from odrf where DocEntry <> @list_of_cols_val_tab_del and ObjType in (18) and DocStatus = 'O' and CreateDate not in ('20201219', '20201220') )
  begin
  SET @error = 779
  SET @error_message = 'XML COM CHAVE DE ACESSO JA INTEGRADO COMO ESBOCO'
  end
  enD

    --Impede Integracao de NF duplicada (Importador DuoConect) Recebimento de mercadorias --Alteração 08/04/2024 chamado 3485 
        if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
  begin

   declare @chaveB as nvarchar(200)

set @chaveB =(select u_chaveacesso from odrf where DocEntry =@list_of_cols_val_tab_del and CreateDate not in ('20201219', '20201220') and ObjType in (20) )

 if @chaveB in (select distinct 
case 
when U_DC_Cancel <> '01' and  (select a.U_U_DC_Canc from dbo.[@DC_REG_RECEB] a where a.U_DC_ChaveAcesso = u_chaveacesso) <> '1' then u_chaveacesso
when U_DC_Cancel <> '01' and  (select a.U_U_DC_Canc from dbo.[@DC_REG_RECEB] a where a.U_DC_ChaveAcesso = u_chaveacesso) = '1' then ''
else u_chaveacesso
end
from odrf where DocEntry <> @list_of_cols_val_tab_del and ObjType in (20) and DocStatus = 'O' and CreateDate not in ('20201219', '20201220'))
begin
  SET @error = 3485
  SET @error_message = 'XML COM CHAVE DE ACESSO JA INTEGRADO COMO ESBOCO'
  end
  enD

  -- GRANDES GRUPOS
   if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
   Begin
   declare @PedidoCompra as Int
   set @PedCompra = (select U_DC_PedComp from ODRF where docentry =@list_of_cols_val_tab_del)
   declare @UnidadeN as nvarchar(100)
   declare @Grupo as nvarchar (100)
   declare @SubGrupo as nvarchar (100)
   declare @FaseN as nvarchar (100)

   set @UnidadeN = (select Top 1 OcrCode2  from POR1 where docentry = @PedCompra )
   set @Grupo = (select Top 1 OcrCode3  from POR1 where docentry = @PedCompra )
   set @SubGrupo = (select Top 1 OcrCode4  from POR1 where docentry = @PedCompra )
   set @faseN = (select Top 1 Project from POR1 where DocEntry =@PedCompra )

   update DRF1 set OcrCode2 =@UnidadeN, OcrCode3 = @Grupo, OcrCode4 = @SubGrupo , project =@faseN where DocEntry =@list_of_cols_val_tab_del and ObjType ='18' 

   End

          if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
  begin

  --declare @chaveA as nvarchar(200)
  DECLARE @DRAFKEY AS INT
  SET @DRAFKEY = (SELECT DRAFTKEY FROM OPDN WHERE DOCENTRY = @list_of_cols_val_tab_del and CreateDate not in ('20201219', '20201220') )
  set @chaveA =(select u_chaveacesso from ODRF where DocEntry =@list_of_cols_val_tab_del  and CreateDate not in ('20201219', '20201220'))

  if @chaveA in (select u_chaveacesso from OPDN where  CANCELED = 'N' and CreateDate not in ('20201219', '20201220') )
  begin
  SET @error = 779
  SET @error_message = 'XML COM CHAVE DE ACESSO JA INTEGRADO COMO ESBOCO'
  end
  enD


if  @object_type = '112' and(  @transaction_type IN( 'A', 'U'))
  begin

  --declare @chaveA as nvarchar(200)
  --DECLARE @DRAFKEY AS INT
  SET @DRAFKEY = (SELECT DRAFTKEY FROM OPDN WHERE DOCENTRY = @list_of_cols_val_tab_del  and CreateDate not in ('20201219', '20201220'))
  set @chaveA =(select u_chaveacesso from ODRF where DocEntry =@list_of_cols_val_tab_del and CreateDate not in ('20201219', '20201220'))

  if @chaveA in (select u_chaveacesso from OPCH where  CANCELED = 'N' and CreateDate not in ('20201219', '20201220'))
  begin
  SET @error = 779
  SET @error_message = 'XML COM CHAVE DE ACESSO JA INTEGRADO COMO ESBOCO'
  end
  enD


  --FIM VALIDACAO ESBOCO XML IMPORTER DUOCONECT
-----------
----------------------------------------------------------------------------------------------------------
---- Trecho criado por Bruno Pallota em 18/01/2019 - Atualiza Saldo e Status do Pedido de Compras

if  @object_type = '22' and( @transaction_type in ('A'))
  begin
  Begin
  update OPOR set U_DC_SaldoPedido = DocTotal where docentry = @list_of_cols_val_tab_del
  update OPOR set U_DC_Status = '01' where docentry = @list_of_cols_val_tab_del
  end
  end

if @object_type = '18' and( @transaction_type in ('A','U'))
  begin
  declare @baseentry as int
  set @baseentry =(select distinct t1.baseentry from opch t0 inner join pch1 t1 on t0.docentry = t1.docentry where t0.docentry =@list_of_cols_val_tab_del)
  if @baseentry > 0
  begin
  update OPCH set U_DC_Pedcomp =@baseentry where docentry =@list_of_cols_val_tab_del AND CANCELED <> 'C'
  end
  end
  
  --fim


  ----Atualiza Itens de/para tabela de usuário --Desabilitada em 19/08/2022 - chamado 2423 - 	RITM0377648 - Erro 245
  --if  @object_type = '20' and(  @transaction_type IN('A'))
  --    begin
  --    DELETE FROM dbo.[@DC_XML_ITMBP] WHERE CODE IN (SELECT L.FREETXT FROM PDN1 L INNER JOIN OPDN C ON L.DOCENTRY =C.DOCENTRY AND C.BPLID = U_dc_BPLID AND C.DOCENTRY=@list_of_cols_val_tab_del) 

  --  insert into dbo.[@DC_XML_ITMBP] (Name, U_DC_BplId , U_DC_CardCode, U_DC_ItemCode , U_DC_CodeXML )
  --        select    L.FreeTxt + '_' + CONVERT(NVARCHAR(10),(C.BPLID)),C.BplId,C.CARDCODE, L.ITEMCODE,L.FREETXT  from PDN1 L INNER JOIN OPDN C ON L.DOCENTRY=C.DOCENTRY
  --    WHERE C.DOCENTRY=@list_of_cols_val_tab_del
  --    End

  ----


   --Atualiza Itens de/para tabela de usuário
    if  @object_type = '20' and(  @transaction_type IN('A'))
      begin
      DELETE FROM dbo.[@DC_XML_ITMBP] WHERE name IN (SELECT L.FREETXT FROM PDN1 L INNER JOIN OPDN C ON L.DOCENTRY =C.DOCENTRY AND C.BPLID = U_dc_BPLID AND C.DOCENTRY=@list_of_cols_val_tab_del) 

    insert into dbo.[@DC_XML_ITMBP] (Name, U_DC_BplId , U_DC_CardCode, U_DC_ItemCode , U_DC_CodeXML )
          select    CONVERT(NVARCHAR (100), L.FreeTxt) + '_' + CONVERT(NVARCHAR(10),(C.BPLID)),C.BplId,C.CARDCODE, L.ITEMCODE,CONVERT(NVARCHAR (100), L.FreeTxt)  from PDN1 L INNER JOIN OPDN C ON L.DOCENTRY=C.DOCENTRY
      WHERE C.DOCENTRY=@list_of_cols_val_tab_del
      End

  --





--------------------------------------------------------------------------------------------------------
--Adiciona numero da nf no pedido de compras

declare @pedcomp int

    if  @object_type = '18' and( @transaction_type in('A','U'))
    Begin
      SET @pedcomp = (select u_dc_pedcomp from opch where DocEntry =@list_of_cols_val_tab_del) 
      update OPOR set U_U_DC_NotaFiscal = @list_of_cols_val_tab_del where DocEntry =@pedcomp
    End
--------------------------------------------------------------------------------------------------------

if @object_type = '18' and( @transaction_type in ('A','U'))
  begin
  declare @pedido as int, @notafiscal as int, @saldopc as numeric (19,6), @totalpc as numeric (19,6)
  set @pedido =(select U_DC_PedComp from OPCH where DocEntry =@list_of_cols_val_tab_del)
  set @notafiscal =(select T1.U_U_DC_NotaFiscal from OPCH T0 inner join OPOR T1 on T0.DocEntry = T1.U_U_DC_NotaFiscal where T0.DocEntry =@list_of_cols_val_tab_del)
  set @totalpc =(select T1.DocTotal from OPCH T0 inner join OPOR T1 on T0.U_DC_PedComp = T1.DocEntry where T0.DocEntry =@list_of_cols_val_tab_del)
  set @saldopc =(select T1.DocTotal -(select sum(DocTotal) from OPCH where U_DC_PedComp = T0.U_DC_PedComp and CANCELED = 'N') from OPCH T0 inner join OPOR T1 on T0.U_DC_PedComp = T1.DocEntry where T0.DocEntry =@list_of_cols_val_tab_del)
  if @notafiscal > 0
  begin
  update OPOR set U_DC_SaldoPedido =@saldopc where DocEntry =@pedido
  end
  if @saldopc = 0
  begin
  update OPOR set U_DC_Status = '03' where DocEntry =@pedido
  update OPOR set DocStatus = 'C' where DocEntry =@pedido
  update POR1 set LineStatus = 'C' where DocEntry =@pedido
  end
  if @saldopc > 0 and @saldopc < @totalpc
  begin
  update OPOR set U_DC_Status = '02' where DocEntry =@pedido
  end
  end

-- Impede criação de entrega com numeração manual
if  @object_type = '15' and(  @transaction_type ='A')
  begin
  if (SELECT count(T0.DocEntry) 
      FROM ODLN T0 
      WHERE T0.series='-1'
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Não é permitido criar nota de entrega com numeração manual'
  end
  end
  
 
  -- Projetos: Impede Insercao de Pedido com Projeto nao Aprovado.
if  @object_type = '22' and(  @transaction_type in('A','U'))
  begin
  if (SELECT count(T0.DocEntry) 
      FROM OPOR T0 INNER JOIN DBO.[@DC_CON_OBRANV] T1 ON T0.U_DC_PRJNAMENV = T1.CODE
      WHERE T1.U_DC_STATUS <> 'A' and T0.DocEntry not in ('135975','152051','140153')
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Pedido Vinculado com Projeto nao Aprovado'
  end
  enD
  



---- Impede insercao de pedido com projeto e sem fase da obra
--IF @object_type = '22' AND @transaction_type in ('A','U')

--BEGIN
--IF (Select Count(1) FROM [dbo].[OPOR] T0 
--      WHERE (T0.U_DC_PRJNAMENV is not null OR T0.U_DC_PRJNAMENV <> '')  AND (T0.U_DC_FASENV is  null OR T0.U_DC_FASENV  = '')  AND T0.DocEntry = @list_of_cols_val_tab_del) > 0 
     
--      BEGIN
--           SET @error = '002'
--            SET @error_message = 'Pedido com Projeto, informe a fase respectiva!'

--      END
--END
--
/* --TRAVA COMENTADA EM 22/11/2021 E RESTAURADA A VERSÃO DE BKP DA BASE DE PROJETOS (TRAVA ABAIXO)
-- Impede insercao ou atualizacao  de pedido com projeto e fase nao pertencente ao Projeto
IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0

      WHERE T0.U_DC_FASENV <> 
	  (select distinct [U_DC_FASE]  
	  from [dbo].[@DC_CON_OBRA_FNV] 
	  where  U_DC_CODPRJ =
	  T0.U_DC_PRJNAMENV)  AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0 
     
      BEGIN
           SET @error = '002'
           SET @error_message = 'A fase nao pertence ao projeto selecionado!'

      END
END
--
*/


-- Impede insercao de pedido com projeto e fase nao pertencente ao Projeto (RESGATADA DA BASE DE PROJETOS EM 22/11/2021)
IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0

      WHERE T0.U_DC_PRJNAMENV <> (select distinct [U_DC_CODPRJ] from [dbo].[@DC_CON_OBRA_FNV] where U_DC_FASE=T0.U_DC_FASENV and U_DC_CODPRJ = T0.U_DC_PRJNAMENV)  AND T0.DocEntry = @list_of_cols_val_tab_del) > 0 
								 
								 
					   
																		 
     
      BEGIN
           SET @error = '002'
           SET @error_message = 'A fase nao pertence ao projeto selecionado!'

      END
END

  -- Projetos: Impede Insercao de Pedido com Saldo excedido na fase.
if  @object_type = '22' and(  @transaction_type in('A'))
begin
Declare @Obra as nvarchar(100)
Set @Obra = (select U_DC_PRJNAMENV from OPOR A  where A.CANCELED ='N' and A.DocEntry =@list_of_cols_val_tab_del)
declare @Total as Numeric (19,2)
declare @fase as nvarchar (100)
set @fase =(select U_DC_FASENV from OPOR where docentry =@list_of_cols_val_tab_del)
set @Total = (select Sum(DocTotal) from OPOR a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  
group by A.U_DC_PRJNAMENV )


declare @Orcamento as numeric (19,2)
set @Orcamento = (select isnull(a.[orçamento total],0)  from dbo.vDC_CON_OBRAFNV  A  where A.[Codigo do Projeto]=@Obra and A.[Disciplina / Fase]=@fase)
  begin
  if (SELECT count(T0.DocEntry) 
      FROM OPOR T0 
      WHERE @Orcamento < (@Total)
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Orçamento excedido para fase do Projeto, valor ultrapassa o estipulado em: '  + CONVERT(NVARCHAR(100),( -1* (@Orcamento - @Total ) ))
  end
  end
  end



  -- Projetos: Impede Insercao de Pedido com Saldo excedido na fase Atualizacao .
if  @object_type = '22' and(  @transaction_type in('U'))
begin
--Declare @Obra as nvarchar(100)
Set @Obra = (select U_DC_PRJNAMENV from OPOR A  where A.CANCELED ='N' and A.DocEntry =@list_of_cols_val_tab_del)
---declare @Total as Numeric (19,2)
--eclare @fase as nvarchar (100)
set @fase =(select U_DC_FASENV from OPOR where docentry =@list_of_cols_val_tab_del)
set @Total = (select Sum(DocTotal) from OPOR a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  
group by A.U_DC_PRJNAMENV )


--declare @Orcamento as numeric (19,2)
set @Orcamento = (select isnull(a.[orçamento total],0)  from dbo.vDC_CON_OBRAFNV  A  where A.[Codigo do Projeto]=@Obra and A.[Disciplina / Fase]=@fase)
  begin
  if (SELECT count(1) 
     
      WHERE @Orcamento < (@Total )
    ) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Orçamento excedido para fase do Projeto, saldo excede em: '  + CONVERT(NVARCHAR(100),( -1*( @Orcamento - @Total  )))
  end
  end
  end
  

  --impede solicitacao com fase sem orcamento

  if  @object_type = '1470000113' and(  @transaction_type in('A','U'))
begin
--Declare @Obra as nvarchar(100)
Set @Obra = (select U_DC_PRJNAMENV from OPRQ A  where A.CANCELED ='N' and A.DocEntry =@list_of_cols_val_tab_del)
--declare @Total as Numeric (19,2)
--declare @fase as nvarchar (100)
set @fase =(select U_DC_FASENV from OPRQ where docentry =@list_of_cols_val_tab_del)
set @Total = (select Sum(DocTotal) from OPRQ a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  and DocStatus ='O' and U_DC_OkSolicit <> 03
group by A.U_DC_PRJNAMENV )
 DECLARE @Total1 as numeric (19,2)

  declare @draft as int
 set @draft = (select draftkey from OPRQ where docentry = @list_of_cols_val_tab_del)
 set @Total1 = isnull((select Sum(DocTotal) from ODRF a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  and docentry<> @draft   and ObjType ='1470000113' and WddStatus<>'N'and DocStatus ='O'
group by A.U_DC_PRJNAMENV  ),0)
-- set @Total1 = (select Sum(DocTotal) from ODRF a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase   and ObjType ='1470000113'
--group by A.U_DC_PRJNAMENV )

--set @Total = @Total +@total1

--declare @Orcamento as numeric (19,2)
set @Orcamento = (select isnull(a.[orçamento total],0)  from dbo.vDC_CON_OBRAFNV  A  where A.[Codigo do Projeto]=@Obra and A.[Disciplina / Fase]=@fase)
  begin
  if (SELECT count(T0.DocEntry) 
      FROM OPRQ T0 
      WHERE @Orcamento < (@Total)
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Orçamento excedido para fase do Projeto, valor ultrapassa o estipulado em: '  + CONVERT(NVARCHAR(100),( -1* ( @Orcamento - @Total ) ))
  end
  end
  end
  


  -- Trava de Saldo na Fase do Projeto, quando é gravado o esboco de solicitacao
  if  @object_type = '112' and(  @transaction_type in('A','U'))
begin
--Declare @Obra as nvarchar(100)
Set @Obra = (select U_DC_PRJNAMENV from ODRF A  where A.CANCELED ='N' and A.DocEntry =@list_of_cols_val_tab_del)
--declare @Total as Numeric (19,2)
--declare @fase as nvarchar (100)
set @fase =(select U_DC_FASENV from ODRF where docentry =@list_of_cols_val_tab_del)

-- Busca os Valores das Solicitacoes Aprovadas
set @Total = (select Sum(DocTotal) from OPRQ a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase and DocStatus ='O' and U_DC_OkSolicit <> 03
group by A.U_DC_PRJNAMENV )

-- Busca os Valores das Solicitacoes em Aprovacao ou aprovados e nao gravados como solicitacao ainda
-- DECLARE @Total1 as numeric (19,2)
 set @Total1 = (select Sum(DocTotal) from ODRF a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase   and ObjType ='1470000113' and WddStatus <> 'N' and DocStatus ='O'
 and a.DocEntry not in(select isnull(draftkey,'') from OPRQ)
group by A.U_DC_PRJNAMENV )

-- Busca Valores dos Pedidos de Compras Aprovados
 DECLARE @Total2 as numeric (19,2)
 set @Total2 = (select Sum(DocTotal) from OPOR a    where a.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  and ISNULL(U_TDS_APROV5,'01') not in ('03') 
group by A.U_DC_PRJNAMENV )

set @Total = @Total +@total1 + @Total2

--declare @Orcamento as numeric (19,2)
set @Orcamento = (select isnull(a.[orçamento total],0)  from dbo.vDC_CON_OBRAFNV  A  where A.[Codigo do Projeto]=@Obra and A.[Disciplina / Fase]=@fase)
  begin
  if (SELECT count(T0.DocEntry) 
      FROM ODRF T0 
      WHERE @Orcamento < (@Total) and T0.ObjType ='1470000113'
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Orçamento excedido para fase do Projeto, valor ultrapassa o estipulado em: '  + CONVERT(NVARCHAR(100),( -1* (@Orcamento - @Total ) ))
  end
  end
  end
  

   -- Trava de Saldo na Fase do Projeto, quando é gravado a solicitacao
  if  @object_type = '1470000113' and(  @transaction_type in('A','U'))
begin
--Declare @Obra as nvarchar(100)
Set @Obra = (select U_DC_PRJNAMENV from ODRF A  where A.CANCELED ='N' and A.DocEntry =@list_of_cols_val_tab_del)
--declare @Total as Numeric (19,2)
--declare @fase as nvarchar (100)
set @fase =(select U_DC_FASENV from ODRF where docentry =@list_of_cols_val_tab_del)

-- Busca os Valores das Solicitacoes Aprovadas
set @Total = (select Sum(DocTotal) from OPRQ a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase and DocStatus ='O' and U_DC_OkSolicit <> 03
group by A.U_DC_PRJNAMENV )

-- Busca os Valores das Solicitacoes em Aprovacao ou aprovados e nao gravados como solicitacao ainda
-- DECLARE @Total1 as numeric (19,2)
 set @Total1 = (select Sum(DocTotal) from ODRF a    where A.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase   and ObjType ='1470000113' and WddStatus <> 'N' and DocStatus ='O'
 and a.DocEntry not in(select isnull(draftkey,'') from OPRQ)
group by A.U_DC_PRJNAMENV )

-- Busca Valores dos Pedidos de Compras Aprovados
 --DECLARE @Total2 as numeric (19,2)
 set @Total2 = (select Sum(DocTotal) from OPOR a    where a.CANCELED ='N' and A.U_DC_PRJNAMENV =@Obra and U_DC_FASENV =@fase  and ISNULL(U_TDS_APROV5,'01') not in ('03') 
group by A.U_DC_PRJNAMENV )

set @Total = @Total +@total1 + @Total2

--declare @Orcamento as numeric (19,2)
set @Orcamento = (select isnull(a.[orçamento total],0)  from dbo.vDC_CON_OBRAFNV  A  where A.[Codigo do Projeto]=@Obra and A.[Disciplina / Fase]=@fase)
  begin
  if (SELECT count(T0.DocEntry) 
      FROM OPRQ T0 
      WHERE @Orcamento < (@Total) --and T0.ObjType ='1470000113'
    and T0.DocEntry  = @list_of_cols_val_tab_del) > 0
  begin
  SET @error = 778
  SET @error_message = 'Validação Ascenty: Orçamento excedido para fase do Projeto, valor ultrapassa o estipulado em: '  + CONVERT(NVARCHAR(100),( -1* (@Orcamento - @Total ) ))
  end
  end
  end
  
  
  --Validacoes Solicitacoes
    --Bloqueia Fornecedor nao Homologado
     if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0  inner JOIN OCRD T1 on T0.U_DC_FornSol=T1.CardCode 
      
      WHERE isnull(T1.IndustryC,'') not in('3', '5') 
      --and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Fornecedor selecionado não Homologado ou Isento'
    End

    --Bloqueia Fornecedor nao Homologado
      if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0  inner JOIN OCRD T1 on T0.U_DC_FornSol=T1.CardCode 
      
      WHERE isnull(T1.IndustryC,'') not in('3', '5') 
      and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Fornecedor selecionado não Homologado ou Isento'
    End


    -- Valida preenchimento recusa contabilidade
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0  
      
      WHERE T0.U_DC_ValidaContabil = 'Reprovado' and isnull(U_DC_ObsCon,'') = ''
      --and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Preencher motivo da recusa contabil'
    End



      -- Valida preenchimento recusa compras
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0  
      
      WHERE T0.U_DC_OkSolicit  in ('03','04' )and isnull(U_DC_ObsPur ,'') = ''
      --and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Preencher motivo da recusa de compras'
    End


  --Impede insercao sem observacao
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 
      WHERE (T0.Comments ='' or T0.Comments is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio preencher Justificativa '
    End


    --Impede insercao sem obs

      if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 
      WHERE (T0.Comments ='' or T0.Comments is null) and T0.ObjType= '1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio preencher Justificativa '
    End


  -- Impede data vencimento em branco 
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 
      WHERE T0.U_DC_VencNF ='' or (T0.U_DC_VencNF is null)
      and T0.U_DC_HistProd ='Sim'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Data de Vencimento da NF Obrigatoria '
    End


    -- Impede Quote em branco se finalidade igual a revenda 
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 
      WHERE T0.U_DC_Finalidade ='Revenda' 
      and (T0.U_DC_Quote  ='' or T0.U_DC_Quote is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Quote '
    End

    -- Impede item que nao seja os genericos
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
      inner join OITM T2 on T1.Itemcode =T2.Itemcode 
      WHERE T1.Itemcode not in ('MG0001','SG0001') and T2.InvntItem  ='N'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 11117
      SET @error_message  = 'Item informado nao pode ser utilizado na solicitação '
    End

    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
      
      WHERE (T1.U_SKILL_DescForn ='' or T1.U_SKILL_DescForn is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Voce deve preencher a descricao do item que esta sendo solicitado '
    End


    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
      
      WHERE replace(convert(nvarchar(max),(t1.U_SKILL_InfAdItem)), '.','') not in (select replace(isnull(NCMCode,''),'.','') from ONCM)
              and T1.ItemCode =   'MG0001'
               AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'O NCM informado nao existe no SAP, verificar ou solicitar cadastro '
    End


    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE t1.U_SKILL_InfAdItem is null and T1.ItemCode ='MG0001'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'O NCM deve ser informado para item de material '
    End

    --Obriga informar se produto foi comprado ou nao
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (T0.U_DC_HistProd ='' or  T0.U_DC_HistProd is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar se Produto ou Servico ja foi adquirido'
    End

    --Obriga informar justifique
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Justic)) ='' or  convert(nvarchar(max),(T0.U_DC_Justic)) is null)
      and T0.U_DC_HistProd ='Sim'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Justificativa'
    End

    --Obriga informar a quem solicitacao atende
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_SolFin )) ='' or  convert(nvarchar(max),(T0.U_DC_SolFin )) is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a quem atende'
    End


    --Obriga informar cliente se for cliente ou ambos atendido
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_CliVinSol )) ='' or  convert(nvarchar(max),(T0.U_DC_CliVinSol )) is null)
                      and T0.U_DC_SolFin <> 'Ascenty'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Cliente Atendido'
    End

      --Obriga informar portunidade se for cliente ou ambos atendido
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_OportAsc )) ='' or  convert(nvarchar(max),(T0.U_DC_OportAsc )) is null)
                      and T0.U_DC_SolFin <> 'Ascenty'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Numero Oportunidade Ascenty'
    End

    --Obriga informar Finalidade Consumo ou Revenda
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Finalidade )) ='' or  convert(nvarchar(max),(T0.U_DC_Finalidade )) is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a Finalidade'
    End

      --Obriga informar o que esta sendo comprado
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Prod )) ='' or  convert(nvarchar(max),(T0.U_DC_Prod )) is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar o que esta sendo comprado'
    End

    --Obriga informar Qual a Finalidade
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_FinalidadeComp )) ='' or  convert(nvarchar(max),(T0.U_DC_FinalidadeComp )) is null)
                      and T0.U_DC_Prod in ('Produto', 'Serviço')
               AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Qual a Finalidade'
    End


      --Obriga informar onde sera utilizado
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_LocalFin )) ='' or  convert(nvarchar(max),(T0.U_DC_LocalFin )) is null)
            and T0.U_DC_Prod in ('Produto', 'Serviço')
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio iformar onde sera utilizado'
    End


      --Obriga informar qual area
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_AreaUtil )) ='' or  convert(nvarchar(max),(T0.U_DC_AreaUtil )) is null)
            and T0.U_DC_Prod in ('Produto', 'Serviço')
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a area'


    End

      --Obriga informar qual projeto
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProjeto )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProjeto )) is null)
      and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.U_DC_AreaUtil in ('Datacenter', 'Telecon', 'Telecom')
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar qual o projeto'


    End

      --Obriga informar qual classeficicao gerencial
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_ClassGerS )) ='' or  convert(nvarchar(max),(T0.U_DC_ClassGerS )) is null)
      and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.U_DC_AreaUtil in ('Telecon', 'Telecom')
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar qual a classificação gerencial'


    End


        --Obriga informar validade se for servico
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_ValidServ1)) ='' or  convert(nvarchar(max),(T0.U_DC_ValidServ1 )) is null)
      and T0.U_DC_Prod ='Serviço'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar validade do serviço'


    End


        --Obriga informar descricao do produto se for outro 
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProdSer )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProdSer )) is null)
      and T0.U_DC_Prod ='Outro'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Descrição do Produto'



    End

      -- Obriga a preencher o projeto se produto for outro
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0 inner join PRQ1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProjeto )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProjeto )) is null)
      and T0.U_DC_Prod ='Outro'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Qual e o Projeto'


    End



        -- Obriga a preencher qual finalidade (texto) se software-licenca
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
       
      WHERE T0.U_DC_Prod in ('Software', 'Licença')
      and (convert(nvarchar(max),(T0.U_DC_FinalidadeComp)) is null or convert(nvarchar(max),(T0.U_DC_FinalidadeComp))='')
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio Qual a Finalidade'


    End

        -- Obriga a preencher qual Validade
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0
       
      WHERE T0.U_DC_Prod in ('Software', 'Licença')
      and (T0.U_DC_ValidServ1 = ''  or T0.U_DC_ValidServ1 is null)
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio Qual a Validade do Serviço'


    End


    --Validacoes Solicitacoes Esboco

      --Obriga informar qual classeficicao gerencial
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_ClassGerS )) ='' or  convert(nvarchar(max),(T0.U_DC_ClassGerS )) is null)
      and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.U_DC_AreaUtil in ('Telecon', 'Telecom')
      and T0.ObjType =1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar qual a classificação gerencial'


    End

    
        -- Obriga a preencher qual finalidade (texto) se software-licenca
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0
       
      WHERE T0.U_DC_Prod in ('Software', 'Licença')
      and (convert(nvarchar(max),(T0.U_DC_FinalidadeComp)) is null or convert(nvarchar(max),(T0.U_DC_FinalidadeComp))='')
                and T0.ObjType =1470000113
              AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio Qual a Finalidade'


    End

        -- Obriga a preencher qual Validade
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0
       
      WHERE T0.U_DC_Prod in ('Software', 'Licença')
      and (T0.U_DC_ValidServ1 = ''  or T0.U_DC_ValidServ1 is null)
      and T0.ObjType =1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio Qual a Validade do Serviço'


    End



      --Obriga informar descricao do produto se for outro 
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProdSer )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProdSer )) is null)
      and T0.U_DC_Prod ='Outro'
      and T0.ObjType =1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Descriação do Produto'


    End

      -- Obriga a preencher o projeto se produto for outro
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProjeto )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProjeto )) is null)
      and T0.U_DC_Prod ='Outro'
      and T0.ObjType =1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Qual e o Projeto'


    End

  -- Impede data vencimento em branco 
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 
      WHERE T0.U_DC_VencNF ='' or (T0.U_DC_VencNF is null) 
      and T0.ObjType=1470000113
      and T0.U_DC_HistProd ='Sim'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Data de vencimento da NF Obrigatoria '


    End

    -- Impede Quote em branco se finalidade igual a revenda 
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 
      WHERE T0.U_DC_Finalidade ='Revenda'
      and (T0.U_DC_Quote  ='' or T0.U_DC_Quote is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Quote '
    End

    -- Impede item que nao seja os genericos
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
      inner join OITM T2 on T1.Itemcode =T2.Itemcode 
      WHERE T1.Itemcode not in ('MG0001','SG0001') and T2.InvntItem  ='N' 
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 1117
      SET @error_message  = 'Item informado nao pode ser utilizado na solicitação '
    End

    --Decricao item comprado
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
      
      WHERE (T1.U_SKILL_DescForn ='' or T1.U_SKILL_DescForn is null) 
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Voce deve preencher a descricao do item que esta sendo solicitado '
    End

    --valida ncm SAP
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
      
      WHERE replace(convert(nvarchar(max),(t1.U_SKILL_InfAdItem)), '.','') not in (select replace(isnull(NCMCode,''),'.','') from ONCM)
              and T1.ItemCode =   'MG0001'
            and T0.ObjType=1470000113
               AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'O NCM informado nao existe no SAP, verificar ou solicitar cadastro '
    End

    --valida ncm
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE t1.U_SKILL_InfAdItem is null and T1.ItemCode ='MG0001'
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'O NCM deve ser informado para item de material '
    End

    --Obriga informar se produto foi comprado ou nao
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (T0.U_DC_HistProd ='' or  T0.U_DC_HistProd is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar se Produto ou Servico ja foi adquirido'
    End

    --Obriga informar justifique
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
      and T0.U_DC_HistProd ='Sim'
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Justic)) ='' or  convert(nvarchar(max),(T0.U_DC_Justic)) is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Justificativa'
    End

    --Obriga informar a quem solicitacao atende
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_SolFin )) ='' or  convert(nvarchar(max),(T0.U_DC_SolFin )) is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a quem atende'
    End


    --Obriga informar cliente se for cliente ou ambos atendido
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_CliVinSol )) ='' or  convert(nvarchar(max),(T0.U_DC_CliVinSol )) is null)
      and T0.ObjType=1470000113
                      and T0.U_DC_SolFin <> 'Ascenty'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Cliente Atendido'
    End

      --Obriga informar portunidade se for cliente ou ambos atendido
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_OportAsc )) ='' or  convert(nvarchar(max),(T0.U_DC_OportAsc )) is null)
      and T0.ObjType=1470000113
                      and T0.U_DC_SolFin <> 'Ascenty'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Numero Oportunidade Ascenty'
    End

    --Obriga informar Finalidade Consumo ou Revenda
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Finalidade )) ='' or  convert(nvarchar(max),(T0.U_DC_Finalidade )) is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a Finalidade'
    End

      --Obriga informar o que esta sendo comprado
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_Prod )) ='' or  convert(nvarchar(max),(T0.U_DC_Prod )) is null)
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar o que esta sendo comprado'
    End

    --Obriga informar Qual a Finalidade
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_FinalidadeComp )) ='' or  convert(nvarchar(max),(T0.U_DC_FinalidadeComp )) is null)
                 and T0.ObjType=1470000113
                    and T0.U_DC_Prod in ('Produto', 'Serviço')
               AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar Qual a Finalidade'
    End


      --Obriga informar onde sera utilizado
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_LocalFin )) ='' or  convert(nvarchar(max),(T0.U_DC_LocalFin )) is null)
            and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio iformar onde sera utilizado'
    End


      --Obriga informar qual area
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_AreaUtil )) ='' or  convert(nvarchar(max),(T0.U_DC_AreaUtil )) is null)
            and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar a area'


    End

      --Obriga informar qual projeto
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_DescProjeto )) ='' or  convert(nvarchar(max),(T0.U_DC_DescProjeto )) is null)
      and T0.U_DC_Prod in ('Produto', 'Serviço')
      and T0.U_DC_AreaUtil in ('Datacenter', 'Telecon', 'Telecom')
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar qual o projeto'


    End


        --Obriga informar validade se for servico
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0 inner join DRF1 T1 on T0.DocEntry = t1.DocEntry 
       
      WHERE (convert(nvarchar(max),(T0.U_DC_ValidServ1 )) ='' or  convert(nvarchar(max),(T0.U_DC_ValidServ1 )) is null)
      and T0.U_DC_Prod ='Serviço'
      and T0.ObjType=1470000113
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Obrigatorio informar validade do serviço'


    End


    
    --filiais sem unidade de negocio  
    --Solicitacao de compras
    if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM OPRQ T0  
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      --and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End


    --Solicitacao de compras
    if  @object_type = '112' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.DocEntry)
      FROM ODRF T0  
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --lcm
    if  @object_type = '30' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM OJDT T0 inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T1.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --nf entrada
	--declare @unidade nvarchar (20)
	--set @unidade =(SELECT convert(nvarchar(100),(U_Unidade))
 --     FROM OPCH T0  WHERE  T0.DocEntry  = @list_of_cols_val_tab_del)


	if  @object_type = '18' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM OPCH T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui - NF entrada'-- + isnull(convert(nvarchar(max),( @unidade)),'')
    End


    --nf saida
    if  @object_type = '13' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM OINV T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --Pedido de compras


    if  @object_type = '22' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM OPOR T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --RECEBIMENTO MERC
    if  @object_type = '20' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM OPDN T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --DEV MERCA
    if  @object_type = '21' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM ORPD T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End


    --DEV NF ENTRADA
    if  @object_type = '19' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM ORPC T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End


    --ENTREGA
    if  @object_type = '15' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM ODLN T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End


    --DEV ENTREGA
    if  @object_type = '16' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM ORDN T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End

    --DEV NF SAIDA
    if  @object_type = '14' and( @transaction_type = 'A' or @transaction_type ='U')
      IF (SELECT count(T0.TransId)
      FROM ORIN T0 --inner join JDT1 t1 on t0.TransId =t1.TransId 
      
      WHERE T0.BPLId not in(24,29,5,28,47)
      and (T0.u_Unidade <>'' or t0.U_Unidade is not null )
      and T0.U_Unidade <> '-'
      
                 AND T0.TransId  = @list_of_cols_val_tab_del) > 0
    Begin
      SET @error      = 7
      SET @error_message  = 'Informado Unidade para filial que nao possui'
    End
	
    --vincula solicitacao no pedido de compras
    if  @object_type = '22' and( @transaction_type in ('A','U'))
      begin
      declare @SolBase as int =0
      declare @LinhaBase as int =0

      set @SolBase =(select U_ECF_COO   from OPOR where DocEntry =@list_of_cols_val_tab_del )
      set @LinhaBase= (select top 1 Linenum from PRQ1 where Docentry=@SolBase order by LineNum Asc )
      if @SolBase > 0 
      Begin
      update OPOR set U_DC_SolBase =@SolBase where docentry=@list_of_cols_val_tab_del 
      --update por1 set BaseType = '1470000113' where DocEntry =@list_of_cols_val_tab_del 
      --update POR1 set BaseLine = @LinhaBase where DocEntry =@list_of_cols_val_tab_del --and LineNum =
      --update PRQ1 set TrgetEntry = @list_of_cols_val_tab_del where DocEntry =@SolBase 
      --update prq1 set TargetType = '22' where DocEntry =@SolBase 
        update prq1 set LineStatus ='C' where DocEntry= @SolBase
        update OPRQ set DocStatus ='C' where docentry= @SolBase 
        update OPRQ set U_DC_PedComp = @list_of_cols_val_tab_del where DocEntry =@SolBase 
      End
      


    End

            --IMPEDE LANÇAMENTO DE NF DE ENTRADA JÁ LANÇADA EM RECEBIMENTO DE MERCADORIAS
    IF  @object_type = '18' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPCH T0 
  
     Where 
     T0.DocEntry  = @list_of_cols_val_tab_del and T0.Serial = (SELECT top 1 T9.Serial FROM OPDN T9 WHERE  T9.CardCode = T0.CardCode and T9.CANCELED = 'N' and T0.CANCELED = 'N' and T9.SeriesStr = T0.SeriesStr and T9.Model = T0.Model and T9.BplID = T0.BPLID and T9.Serial = T0.Serial)
     ) > 0
      BEGIN
        SET @error      = 20052020
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> NOTA FISCAL JÁ LANÇADA EM RECEBIMENTO DE MERCADORIAS.'
    END
    

            --IMPEDE LANÇAMENTO DE NF DE SAÍDA JÁ LANÇADA EM ENTREGA
    IF  @object_type = '13' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OINV T0 
  
     Where 
     T0.DocEntry  = @list_of_cols_val_tab_del and T0.Serial = (SELECT top 1 T9.Serial FROM ODLN T9 WHERE T9.CardCode = T0.CardCode and T9.CANCELED = 'N' and T0.CANCELED = 'N' and T9.SeriesStr = T0.SeriesStr and T9.Model = T0.Model and T9.BplID = T0.BPLID and T9.Serial = T0.Serial)
     ) > 0
      BEGIN
        SET @error      = 20052020
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> NOTA FISCAL JÁ LANÇADA EM VENDAS - ENTREGA.'
    END
      
--IMPEDE LANÇAMENTO DE RECEBIMENTO DE MERCADORIAS JÁ LANÇADA EM NF DE ENTRADA
    IF  @object_type = '20' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPDN T0 
  
     Where 
     T0.DocEntry  = @list_of_cols_val_tab_del and T0.Serial = (SELECT top 1 T9.Serial FROM OPCH T9 WHERE  T9.CardCode = T0.CardCode and T9.CANCELED = 'N' and T0.CANCELED = 'N' and T9.SeriesStr = T0.SeriesStr and T9.Model = T0.Model and T9.BplID = T0.BPLID and T9.Serial = T0.Serial)
     ) > 0
      BEGIN
        SET @error      = 0306200
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> NOTA FISCAL JÁ LANÇADA EM NOTA FISCAL DE ENTRADA.'
    END
    

            --IMPEDE LANÇAMENTO DE ENTREGA JÁ LANÇADA EM NF DE SAÍDA
    IF  @object_type = '15' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ODLN T0 
  
     Where 
     T0.DocEntry  = @list_of_cols_val_tab_del and T0.Serial = (SELECT top 1 T9.Serial FROM OINV T9 WHERE T9.CardCode = T0.CardCode and T9.CANCELED = 'N' and T0.CANCELED = 'N' and T9.SeriesStr = T0.SeriesStr and T9.Model = T0.Model and T9.BplID = T0.BPLID and T9.Serial = T0.Serial)
     ) > 0
      BEGIN
        SET @error      = 030620201
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> NOTA FISCAL JÁ LANÇADA EM NOTA FISCAL DE SAÍDA.'
    END

------------------------------------------------- 
-------VALIDAÇÕES DE UNIDADE DE NEGÓCIO----------
-------------------------------------------------


    --IMPEDE INSERÇÃO DE NF DE SAÍDA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '13' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OINV T0 
              INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420201
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    
    --IMPEDE INSERÇÃO DE PEDIDO DE COMPRA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '22' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPOR T0 
              INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420202
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END

    --IMPEDE INSERÇÃO RECEBIMENTO DE MERCADORIAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '20' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPDN T0 
              INNER JOIN PDN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420203
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    
    --IMPEDE INSERÇÃO DE SOLICITAÇÃO DE COMPRAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '1470000113' and( @transaction_type in('A'))
        IF (Select Count(1) FROM OPRQ T0 
              INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
    -- AND ((T0.U_DC_ValidaContabil = 'sim' and (T1.OcrCode2 is null or T1.OcrCode2 = '')) or (T0.U_DC_ValidaContabil = 'não' and (T1.U_DC_Unidade_Negocio is null or T1.U_DC_Unidade_Negocio = '')))
         ) > 0
      BEGIN
        SET @error      = 170420204
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
-----------------------------------------------------------------------------------------------------------------
--IMPEDE ATUALIZAÇÃO DE SOLICITAÇÃO DE COMPRAS SEM CENTRO DE CUSTO DIMENSÃO 2 EM DOCUMENTOS CRIADOS A PARTIR DE 18/09/2020
    IF  @object_type = '1470000113' and( @transaction_type in('U'))
        IF (Select Count(1) FROM OPRQ T0 
              INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C' and T0.CreateDate > '20200918'
    -- AND ((T0.U_DC_ValidaContabil = 'sim' and (T1.OcrCode2 is null or T1.OcrCode2 = '')) or (T0.U_DC_ValidaContabil = 'não' and (T1.U_DC_Unidade_Negocio is null or T1.U_DC_Unidade_Negocio = '')))
         ) > 0
      BEGIN
        SET @error      = 02102020
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    

------------------------------------------------------------------------------------------------------------------


    --IMPEDE INSERÇÃO DE NOTA FISCAL DE ENTRADA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '18' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OPCH T0 
              INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420205
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    
    --IMPEDE INSERÇÃO DE DEV. NOTA FISCAL DE ENTRADA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '19' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ORPC T0 
              INNER JOIN RPC1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420206
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    
    --IMPEDE INSERÇÃO DE COTAÇÃO DE VENDAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '23' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OQUT T0 
              INNER JOIN QUT1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420207
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END
    --IMPEDE INSERÇÃO DE DEVOLUÇÃO DE MERCADORIAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '21' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ORPD T0 
              INNER JOIN RPD1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420208
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END 
    --IMPEDE INSERÇÃO DE DEVOLUÇÃO SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '16' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ORDN T0 
              INNER JOIN RDN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 170420209
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END   
    --IMPEDE INSERÇÃO DE DEVOLUÇÃO DE NOTA FISCAL DE SAÍDA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '14' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ORIN T0 
              INNER JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 1704202010
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END     
    --IMPEDE INSERÇÃO DE ENTREGA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '15' and( @transaction_type = 'A')
        IF (Select Count(1) FROM ODLN T0 
              INNER JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
         ) > 0
      BEGIN
        SET @error      = 1704202011
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END     
    --IMPEDE INSERÇÃO DE PEDIDO DE VENDA SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '17' and( @transaction_type in ('U'))
        IF (Select Count(1) FROM ORDR T0 
              INNER JOIN RDR1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     --T0.DocEntry = @list_of_cols_val_tab_del and T0.CreateDate >= '20200701'
      T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.CANCELED <> 'C'
     AND T1.OcrCode2 is null
         ) > 0
      BEGIN
        SET @error      = 1704202012
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END   
    
 -- inicia aqui   
    ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM NF DE SAÍDA 
    IF  @object_type = '13' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM ( SELECT CASE   WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
						  WHEN T0.BplId = '54' and T1.OcrCode2 <>'SPE 01' THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
                          ELSE '0'
                          END as 'Erro'

              FROM OINV T0 
              INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052001
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
          
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM PEDIDO DE COMPRA
    IF  @object_type = '22' and( @transaction_type in ('A'))
        IF (Select COUNT (*) FROM ( SELECT CASE   WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
						  WHEN T0.BplId = '54' and T1.OcrCode2 <>'SPE 01' THEN '1'
                         --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OPOR T0 
              INNER JOIN POR1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052002
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM RECEBIMENTO DE MERCADORIAS 
    IF  @object_type = '20' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                         WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                         --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OPDN T0 
              INNER JOIN PDN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052003
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
  
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM SOLICITAÇÃO DE COMPRAS 
    IF  @object_type = '1470000113' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                           WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						   WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                         --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OPRQ T0 
              INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052004
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    

    


    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM NOTA FISCAL DE ENTRADA 
    IF  @object_type = '18' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                         WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                           WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						   WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                         --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OPCH T0 
              INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052005
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM DEVOLUÇÃO DE NOTA FISCAL DE ENTRADA 
    IF  @object_type = '19' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ORPC T0 
              INNER JOIN RPC1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052006
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM COTAÇÃO DE VENDAS 
    IF  @object_type = '23' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OQUT T0 
              INNER JOIN QUT1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052007
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM DEVOLUÇÃO DE MERCADORIAS 
    IF  @object_type = '21' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                         WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ORPD T0 
              INNER JOIN RPD1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052008
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM DEVOLUÇÃO 
    IF  @object_type = '16' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                           WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						   WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                         --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ORDN T0 
              INNER JOIN  RDN1 T1 ON T0.DocEntry = T1.DocEntry    
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052009
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM DEVOLUÇÃO DE NOTA FISCAL DE SAÍDA 
    IF  @object_type = '14' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ORIN T0 
              INNER JOIN RIN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052010
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.' 
    END
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM ENTREGA 
    IF  @object_type = '15' and( @transaction_type = 'A')
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ODLN T0 
              INNER JOIN DLN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052011
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
    ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM PEDIDO DE VENDA 
    IF  @object_type = '17' and( @transaction_type in ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                         WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                         -- WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
						  WHEN T0.BplId = '49' and T1.OcrCode2 not in ('HTL 05', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ORDR T0 
              INNER JOIN RDR1 T1 ON T0.DocEntry = T1.DocEntry and T0.CreateDate >= '20200701'
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052012
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
        
          
    
    --IMPEDE LANÇAMENTO CONTÁBIL MANUAL EM CONTA DE RESULTADO SEM UNIDADE DE NEGÓCIOS
    IF  @object_type = '30' and( @transaction_type in ('A'))
        IF (Select Count(1) FROM OJDT T0 
              INNER JOIN JDT1 T1 ON T0.TransId = T1.TransId
    
     Where 
     T0.TransId  = @list_of_cols_val_tab_del 
     AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') 
     and (T1.OcrCode2 is null or T1.OcrCode2 = '') and T0.TransType = '30'and T0.[U_SIEBS_BoeKey] is null--<> '1470000090'
     ) > 0
      BEGIN
        SET @error      = 15042020
        SET @error_message  = 'OBJ 30:  VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO LANÇAMENTO.'
    END
    
    
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM LANÇAMENTO CONTÁBIL MANUAL
    IF  @object_type = '30' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T1.BplId = '5' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T1.BplId = '24' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T1.BplId = '28' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T1.BplId = '29' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T1.BplId = '47' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T1.BplId in ('6','45') and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T1.BplId = '6' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T1.BplId = '45' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T1.BplId = '3' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T1.BplId = '7' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T1.BplId = '1' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T1.BplId = '46' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T1.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44')  and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T1.BplId = '48' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T1.BplId = '49' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T1.BplId = '50' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T1.BplId = '51' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
   						  WHEN T1.BplId = '55' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05','TEL 01') THEN '1'
						  WHEN T1.BplId = '56' and T0.TransType = '30' AND  (T1.Account Like '3%%' or T1.[Account] Like '4%%' or T1.[Account] Like '5%%') and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'                      --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
                          ELSE '0'
                          END as 'Erro'

              FROM OJDT T0 
              INNER JOIN JDT1 T1 ON T0.TransId = T1.TransId and T0.TransType <> '1470000090'  
     Where 
     T0.TransId = @list_of_cols_val_tab_del 
                  ) T9 WHERE T9.Erro <> '0') <>0 
      BEGIN
        SET @error      = 12052012
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  OBJ 30: UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
    
      

      --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM ESBOÇO (SOLICITAÇÃO DE COMPRAS)
      IF  @object_type = '112' and( @transaction_type in ('A','U'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          --WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ODRF T0 
              INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry 
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C' and (T0.ObjType = '1470000113' OR T0.ObjType = '18') 
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 080720200
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END




		  IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  ( isnull(t1.OcrCode2,'') ='' or t1.OcrCode2 is null)  and  T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '45'
            SET @error_message = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'

      END
	  END


	  	  
		  
		  IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(t1.DocEntry ) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  (  t1.OcrCode2 is null)  and T0.ObjType = '1470000113' and  T0.DocEntry  = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '444444'
            SET @error_message = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'

      END
	  END


    --IMPEDE INSERÇÃO DE ESBOÇO DE SOLICITAÇÃO DE COMPRAS SEM CENTRO DE CUSTO DIMENSÃO 2
    --if  @object_type = '11222' and(  @transaction_type in ('A','U'))
    --  IF (Select Count(*) FROM ODRF T0 
    --            INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry   
    --   Where 
    --   T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C' and T0.ObjType = '1470000113' AND isnull(t1.OcrCode2 ,'') = ''
    --  -- AND ((T0.U_DC_ValidaContabil = 'sim' and (T1.OcrCode2 is null or T1.OcrCode2 = '')) or (T0.U_DC_ValidaContabil = 'não' and (T1.U_DC_Unidade_Negocio is null or T1.U_DC_Unidade_Negocio = '')))
    --       ) > 0
    --    BEGIN
    --      SET @error      = 080720201
    --      SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    --  END

    --IMPEDE INSERÇÃO DE SAÍDA DE MERCADORIAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '60' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OIGE T0 
              INNER JOIN IGE1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') 
         ) > 0
      BEGIN
        SET @error      = 1704202011
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END 

        ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM SAÍDA DE MERCADORIAS 
    IF  @object_type = '60' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OIGE T0 
              INNER JOIN IGE1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052012
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
        

    --    -- PREENCHE UNIDADE DE NEGÓCIO EM LCM DE SAÍDA DE MERCADORIAS


      if  @object_type = '60' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      declare @UnidadeSM as nvarchar (10)
      set @UnidadeSM = (select distinct(ocrcode2) from IGE1 where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OIGE T0 INNER JOIN OJDT T1 ON T0.TransId = T1.TransId  
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN IGE1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode2 <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set OcrCode2 = @UnidadeSM  where BaseRef  =@list_of_cols_val_tab_del and TransType ='60'
      end
End 
      

      
--IMPEDE INSERÇÃO DE ENTRADA DE MERCADORIAS SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '59' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OIGN T0 
              INNER JOIN IGN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') 
         ) > 0
      BEGIN
        SET @error      = 1704202011
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END 


        ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM ENTRADA DE MERCADORIAS 
    IF  @object_type = '59' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OIGN T0 
              INNER JOIN IGN1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052012
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
        

    --    -- PREENCHE UNIDADE DE NEGÓCIO LCM EM ENTRADA DE MERCADORIAS


      if  @object_type = '59' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      declare @UnidadeEM as nvarchar (10)
      set @UnidadeEM = (select distinct(ocrcode2) from IGN1 where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OIGN T0 INNER JOIN OJDT T1 ON T0.TransId = T1.TransId  
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN IGN1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode2 <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set OcrCode2 = @UnidadeEM  where BaseRef  =@list_of_cols_val_tab_del and TransType ='59'
      end
End 
    
      
--IMPEDE INSERÇÃO DE TRANSFERÊNCIA DE ESTOQUE SEM CENTRO DE CUSTO DIMENSÃO 2
    IF  @object_type = '67' and( @transaction_type = 'A')
        IF (Select Count(1) FROM OWTR T0 
              INNER JOIN WTR1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND (T1.OcrCode2 is null or T1.OcrCode2 = '') 
         ) > 0
      BEGIN
        SET @error      = 1704202011
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR UNIDADE DE NEGÓCIOS NA LINHA DO DOCUMENTO.'
    END 


        ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM TRANSFERÊNCIA DE ESTOQUE 
    IF  @object_type = '67' and( @transaction_type IN ('A'))
        IF (Select COUNT (*) FROM (SELECT CASE  WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'MTZ 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          --WHEN T0.BplId in ('6','45') and T1.OcrCode2 not in ('JDI 01', 'JDI 02') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' --alterado por DuoRF - Chamado 1743
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ('PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '49' and T1.OcrCode2 <> 'HTL 05' THEN '1'
                          WHEN T0.BplId = '50' and T1.OcrCode2 <> 'SUM 03' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM OWTR T0 
              INNER JOIN WTR1 T1 ON T0.DocEntry = T1.DocEntry   
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C'
                  ) T9 WHERE T9.Erro <> '0') <>0
      BEGIN
        SET @error      = 12052012
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO.'
    END
        
        
--Finalizar aqui


        -- PREENCHE UNIDADE DE NEGÓCIO LCM EM TRANSFERÊNCIA DE ESTOQUE


      if  @object_type = '67' and( @transaction_type = 'A' or @transaction_type ='U')
      begin
      declare @UnidadeTF as nvarchar (10)
      set @UnidadeTF = (select distinct(ocrcode2) from WTR1 where DocEntry = @list_of_cols_val_tab_del )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OWTR T0 INNER JOIN OJDT T1 ON T0.TransId = T1.TransId  
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN WTR1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode2 <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set OcrCode2 = @UnidadeTF  where BaseRef  =@list_of_cols_val_tab_del and TransType ='67'
      end
End 


-- change 22-10-2021
--Unidade de Negócios em solicitação de compras
	    IF  @object_type = '1470000113' and( @transaction_type IN ('A','U'))
	 begin
	 if exists
	 (
	 Select T0.code from dbo.[@DC_UNIDADE_NEGOCIO] T0 where U_DC_DocEntry = @list_of_cols_val_tab_del --and U_DC_LineNum in (select Linenum from PRQ1 where docentry = @list_of_cols_val_tab_del)
	 )
	 begin
	 --UPDATE dbo.[@DC_UNIDADE_NEGOCIO] set U_DC_Unidade = (select concat (isnull(T1.Ocrcode,''), ';', isnull(T1.Ocrcode2,'')) from  OPRQ T0 INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry where T0.DocEntry = @list_of_cols_val_tab_del and U_DC_LineNum = T1.LineNum)
   -- WHERE U_DC_DocEntry = @list_of_cols_val_tab_del and U_DC_LineNum = T1.LineNum
	delete from dbo.[@DC_UNIDADE_NEGOCIO] where U_DC_DocEntry = @list_of_cols_val_tab_del
	end
	end
	    
		
		IF  @object_type = '1470000113' and( @transaction_type IN ('A','U'))
	begin
	if not exists
	
	(
	Select T0.code from dbo.[@DC_UNIDADE_NEGOCIO] T0 where U_DC_DocEntry = @list_of_cols_val_tab_del-- and U_DC_LineNum in (select Linenum from PRQ1 where docentry = @list_of_cols_val_tab_del)
	)
	begin
	 insert into dbo.[@DC_UNIDADE_NEGOCIO] (U_DC_DocEntry, U_DC_LineNum, U_DC_Unidade, U_DC_Grupo, U_DC_SubGrp, U_DC_Fase, U_DC_Dim1)
    (select T0.DocEntry, T1.LineNum, T1.OcrCode2 , T1.OcrCode3 , T1.OcrCode4 , T1.Project , T1.OcrCode 
    FROM OPRQ T0 INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry where T0.DocEntry = @list_of_cols_val_tab_del )
	 end
	 end

    --entrou a parte de cima, change dia 22-10-2021 
	----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM SOLICITAÇÃO DE COMPRAS - INSERT TABELA
    --IF  @object_type = '1470000113' and( @transaction_type IN ('A')) and @list_of_cols_val_tab_del not in (select U_DC_DocEntry from dbo.[@DC_UNIDADE_NEGOCIO])
    --BEGIN 
    --insert into dbo.[@DC_UNIDADE_NEGOCIO] (U_DC_DocEntry, U_DC_LineNum, U_DC_Unidade)
    --select T0.DocEntry, T1.LineNum, concat (isnull(T1.Ocrcode,''), ';', isnull(T1.Ocrcode2,''))   
    --FROM OPRQ T0 INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry where T0.DocEntry = @list_of_cols_val_tab_del 


    --END
    ----VALIDAÇÃO UNIDADE DE NEGÓCIOS EM SOLICITAÇÃO DE COMPRAS - UPDATE TABELA
    --IF  @object_type = '1470000113' and( @transaction_type IN ('U')) and @list_of_cols_val_tab_del  in (select U_DC_DocEntry from dbo.[@DC_UNIDADE_NEGOCIO])
    --    Begin
    --UPDATE dbo.[@DC_UNIDADE_NEGOCIO] set U_DC_Unidade = (select concat (isnull(T1.Ocrcode,''), ';', isnull(T1.Ocrcode2,'')) from  OPRQ T0 INNER JOIN PRQ1 T1 ON T0.DocEntry = T1.DocEntry where T0.DocEntry = @list_of_cols_val_tab_del and U_DC_LineNum = T1.LineNum)
    --WHERE U_DC_DocEntry = @list_of_cols_val_tab_del 
    
    --END
    
          --VALIDAÇÃO: IMPEDE A INSERÇÃO DE NF DE ENTRADA DE ITEM DO GRUPO CRÉDITO DE ICMS COM UTILIZAÇÕES SEM O FLAG "SÓ IMPOSTO" E "GRATUITO"
    
    IF  @object_type = '18' and( @transaction_type = 'A')
        IF (Select Count(*) FROM PCH1 T0
              INNER JOIN OITM T1 ON T0.ItemCode = T1.ItemCode
              INNER JOIN OPCH T2 ON T0.DocEntry = T2.DocEntry
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND T1.[ItmsGrpCod] = '710' and  (T0.[FreeChrgBP] <> 'Y' or  T0.[TaxOnly] <> 'Y')

         ) > 0
      BEGIN
        SET @error      = 060720201
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> UTILIZAÇÃO INCORRETA PARA O ITEM'
    END
	
    --VALIDAÇÃO: IMPEDE A INSERÇÃO DE DEV. DE NF DE ENTRADA DE ITEM DO GRUPO CRÉDITO DE ICMS COM UTILIZAÇÕES SEM O FLAG "SÓ IMPOSTO" E "GRATUITO"
    
    IF  @object_type = '19' and( @transaction_type = 'A')
        IF (Select Count(*) FROM RPC1 T0
              INNER JOIN OITM T1 ON T0.ItemCode = T1.ItemCode
              INNER JOIN ORPC T2 ON T0.DocEntry = T2.DocEntry
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND T1.[ItmsGrpCod] = '710' and  (T0.[FreeChrgBP] <> 'Y' or  T0.[TaxOnly] <> 'Y')

         ) > 0
      BEGIN
        SET @error      = 060720202
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> UTILIZAÇÃO INCORRETA PARA O ITEM'
    END 
  
  --VALIDAÇÃO: IMPEDE A INSERÇÃO DE NF DE SAÍDA DE ITEM DO GRUPO CRÉDITO DE ICMS COM UTILIZAÇÕES SEM O FLAG "SÓ IMPOSTO" E "GRATUITO"
    
    IF  @object_type = '13' and( @transaction_type = 'A')
        IF (Select Count(*) FROM INV1 T0
              INNER JOIN OITM T1 ON T0.ItemCode = T1.ItemCode
              INNER JOIN OINV T2 ON T0.DocEntry = T2.DocEntry
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND T1.[ItmsGrpCod] = '710' and  (T0.[FreeChrgBP] <> 'Y' or  T0.[TaxOnly] <> 'Y')

         ) > 0
      BEGIN
        SET @error      = 060720203
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> UTILIZAÇÃO INCORRETA PARA O ITEM'
    END 

    --VALIDAÇÃO: IMPEDE A INSERÇÃO DE DEV. DE NF DE SAÍDA DE ITEM DO GRUPO CRÉDITO DE ICMS COM UTILIZAÇÕES SEM O FLAG "SÓ IMPOSTO" E "GRATUITO"
    
    IF  @object_type = '14' and( @transaction_type = 'A')
        IF (Select Count(*) FROM RIN1 T0
              INNER JOIN OITM T1 ON T0.ItemCode = T1.ItemCode
              INNER JOIN ORIN T2 ON T0.DocEntry = T2.DocEntry
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del AND T1.[ItmsGrpCod] = '710' and  (T0.[FreeChrgBP] <> 'Y' or  T0.[TaxOnly] <> 'Y')

         ) > 0
      BEGIN
        SET @error      = 060720204
        SET @error_message  = 'VALIDAÇÃO ASCENTY-> UTILIZAÇÃO INCORRETA PARA O ITEM'
    END       
    
	
      --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM ESBOÇO DE NF DE ENTRADA COM VALIDAÇÃO DE COMPRAS 
    IF  @object_type = '112' and @transaction_type in ('A','U')
        IF (Select COUNT (*) FROM ( SELECT CASE   WHEN T0.BplId = '5' and T1.OcrCode2 not in ('HTL 01', 'HTL 02', 'HTL 03', 'HTL 04', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '24' and T1.OcrCode2 not in ('SPO 01', 'SPO 02', 'SPO 03', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '28' and T1.OcrCode2 not in ('SUM 01', 'SUM 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '29' and T1.OcrCode2 not in ('RIO 01', 'RIO 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '47' and T1.OcrCode2 not in ('VIN 01', 'VIN 02', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '6'  and T1.OcrCode2 not in ('JDI 01', 'TEL 01') THEN '1' 
                          WHEN T0.BplId = '45' and T1.OcrCode2 not in ('JDI 02', 'TEL 01') THEN '1' 
                          WHEN T0.BplId = '3' and T1.OcrCode2 not in ('CPS 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId = '7' and T1.OcrCode2 <> 'FTZ 01' THEN '1'
                          WHEN T0.BplId = '1' and T1.OcrCode2 <> 'MTZ 01' THEN '1'
                          WHEN T0.BplId = '46' and T1.OcrCode2 not in ( 'PLN 01', 'TEL 01') THEN '1'
                          WHEN T0.BplId in ('9','25','26','30','31','32','34','35','36','37','38','39','40','41','42','43','44') and T1.OcrCode2 <> 'TEL 01' THEN '1'
                          WHEN T0.BplId = '48' and T1.OcrCode2 <> 'MIA 01' THEN '1'
                          WHEN T0.BplId = '51' and T1.OcrCode2 not in ('SPO 04', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '52' and T1.OcrCode2 not in ('SPO 05', 'SPO 06') THEN '1'
                          WHEN (T1.OcrCode2 is null or T1.OcrCode2 = '') THEN '1'
						  WHEN T0.BplId = '55' and T1.OcrCode2 not in ('VIN 03', 'VIN 04','VIN 05', 'TEL 01') THEN '1'
						  WHEN T0.BplId = '56' and T1.OcrCode2 not in ('SUM 04', 'TEL 01') THEN '1'
						  ELSE '0'
                          END as 'Erro'

              FROM ODRF T0 
              INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry and T0.ObjType = T1.ObjType and T0.ObjType = '18' 
     Where 
     T0.DocEntry = @list_of_cols_val_tab_del and T0.CANCELED <> 'C' /*and T0.ObjType = '18' */and T0.U_DC_ValidaCompras = 'Sim'
                  ) T9 WHERE T9.Erro <> '0') >0
      BEGIN
        SET @error      = 120720
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  UNIDADE INFORMADA NA LINHA DO DOCUMENTO NÃO PERTENCE À FILIAL DO LANÇAMENTO OU INVÁLIDA.'
    END
    
	
  --Impede LCM negativo   
        if  @object_type = '30' and  @transaction_type IN ('A')
    begin
    if (SELECT count(T0.TransID) FROM JDT1 T0 WHERE (T0.debit < 0 or T0.Credit <0) and T0.TransID  = @list_of_cols_val_tab_del) > 0
    begin
    SET @error = 71220
    SET @error_message = 'Não é possível inserir Lançamento contábil com valor negativo'
    end
    end   

  
    ----IMPEDE INSERÇÃO DE NOTA FISCAL DE ENTRADA SEM O PREENCHIMENTO DO CAMPO "Auto PC: Incide Imposto Quantas X" NO CABEÇALHO OU NA LINHA DO DOCUMENTO
    --    IF  @object_type = '18' and( @transaction_type in ('A','U'))
    --    Begin
    --    IF (Select Count(*) FROM OPCH T0 
    --              INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry
    --              INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
    --     Where 
    --     T0.DocEntry = @list_of_cols_val_tab_del and T2.[ItemType] = 'F' and T0.U_DC_ValidaFiscal = 'sim' and t1.AcctCode not like '1.2.3%'
    --     and (T0.U_DC_IncideImposto is null or (T0.U_DC_IncideImposto = 'sim'
    --                      and(   (T0.[U_DC_IncideImpostoX] is null and T1.[U_DC_IncideImposto_X] is null)
    --                        or (T0.[U_DC_IncideImpostoX] is null and T1.[U_DC_IncideImposto_X] = '')
    --                        or (T0.[U_DC_IncideImpostoX] = '' and T1.[U_DC_IncideImposto_X] is null)
    --                        or (T0.[U_DC_IncideImpostoX] = '' and T1.[U_DC_IncideImposto_X] = ''))))         
    --      ) > 0
    --      BEGIN
    --        SET @error      = 27072001
    --        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR se Incide Imposto e Quantas X NO CABEÇALHO OU LINHA DO DOCUMENTO.'
    --    END
    --    end
		
        
  
    ----IMPEDE INSERÇÃO DE ESBOÇO DE NF DE ENTRADA SEM O PREENCHIMENTO DO CAMPO "Auto PC: Incide Imposto Quantas X" NO CABEÇALHO OU NA LINHA DO DOCUMENTO PARA ITENS DE SERVIÇO DE ATIVO FIXO 
    --    IF  @object_type = '112' and( @transaction_type IN ('A','U'))
    --    Begin
    --    IF (Select Count(*) FROM ODRF T0 
    --              INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry
    --              INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
    --     Where 
    --     T0.DocEntry = @list_of_cols_val_tab_del and T2.[ItemType] = 'F' and T0.U_DC_ValidaFiscal = 'sim' and T0.ObjType = '18' and t1.AcctCode not like '1.2.3%'
    --     and (T0.U_DC_IncideImposto is null or (T0.U_DC_IncideImposto = 'sim'
    --                      and(   (T0.[U_DC_IncideImpostoX] is null and T1.[U_DC_IncideImposto_X] is null)
    --                        or (T0.[U_DC_IncideImpostoX] is null and T1.[U_DC_IncideImposto_X] = '')
    --                        or (T0.[U_DC_IncideImpostoX] = '' and T1.[U_DC_IncideImposto_X] is null)
    --                        or (T0.[U_DC_IncideImpostoX] = '' and T1.[U_DC_IncideImposto_X] = ''))))         
    --      ) > 0
    --      BEGIN
    --        SET @error      = 27072002
    --        SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR se Incide Imposto e Quantas X NO CABEÇALHO OU LINHA DO DOCUMENTO.'
    --    END
    --    end

	
    --IMPEDE INSERÇÃO DE NOTA FISCAL DE ENTRADA SEM O PREENCHIMENTO DO CAMPO "Auto PC: Incide Imposto Quantas X" NO CABEÇALHO OU NA LINHA DO DOCUMENTO
        IF  @object_type = '18' and( @transaction_type in ('A','U'))
        Begin
        IF (Select Count(*) FROM OPCH T0 
                  INNER JOIN PCH1 T1 ON T0.DocEntry = T1.DocEntry
                  INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
         Where 
         T0.DocEntry = @list_of_cols_val_tab_del and T2.[ItemType] = 'F' and T0.U_DC_ValidaFiscal = 'sim' and t1.AcctCode not like '1.2.3%'
         and (T0.U_DC_IncideImposto is null or (T0.U_DC_IncideImposto = 'sim'
                          and(   (isnull(T0.[U_DC_IncideImpostoX], '') = '' and isnull((select TOP 1 [U_DC_IncideImposto_X] from PCH1 where docentry = @list_of_cols_val_tab_del and U_DC_IncideImposto =  'Sim'), '') = ''))))         
          ) > 0
          BEGIN
            SET @error      = 27072001
            SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR se Incide Imposto e Quantas X NO CABEÇALHO OU LINHA DO DOCUMENTO.'
        END
        end

        
  
    --IMPEDE INSERÇÃO DE ESBOÇO DE NF DE ENTRADA SEM O PREENCHIMENTO DO CAMPO "Auto PC: Incide Imposto Quantas X" NO CABEÇALHO OU NA LINHA DO DOCUMENTO PARA ITENS DE SERVIÇO DE ATIVO FIXO 
        IF  @object_type = '112' and( @transaction_type IN ('A','U'))
        Begin
        IF (Select Count(*) FROM ODRF T0 
                  INNER JOIN DRF1 T1 ON T0.DocEntry = T1.DocEntry
                  INNER JOIN OITM T2 ON T1.ItemCode = T2.ItemCode
         Where 
         T0.DocEntry = @list_of_cols_val_tab_del and T2.[ItemType] = 'F' and T0.U_DC_ValidaFiscal = 'sim' and T0.ObjType = '18' and t1.AcctCode not like '1.2.3%'
         and (T0.U_DC_IncideImposto is null or (T0.U_DC_IncideImposto = 'sim'
                          and(   (isnull(T0.[U_DC_IncideImpostoX], '') = '' and isnull((select TOP 1 [U_DC_IncideImposto_X] from DRF1 where docentry = @list_of_cols_val_tab_del and U_DC_IncideImposto =  'Sim'), '') = ''))))         
          ) > 0
          BEGIN
            SET @error      = 27072002
            SET @error_message  = 'VALIDAÇÃO ASCENTY-> INFORMAR se Incide Imposto e Quantas X NO CABEÇALHO OU LINHA DO DOCUMENTO.'
        END
        end
          
          

    -- Validação de informações da Nota de Entrada (Compras).
    --IF (@error = 0) AND (@object_type in ('18')) AND (@transaction_type IN ('A'))
    --begin
    --     IF (SELECT Isnull(sum(t2.APC),0)
    --      FROM PCH1 T0 inner join OPCH T100 on t0.DocEntry =T100.DocEntry 
    --             inner join OITM T1 on T0.ItemCode =T1.ItemCode 
    --             inner join fix1  T2 on T0.ItemCode=T2.ItemCode
          
    --      WHERE T0.DocEntry  = @list_of_cols_val_tab_del ) > 0
    --    Begin 
    --        SELECT 
    --        @Error = 220120211, 
    --        @error_message = 'VALIDAÇÃO ASCENTY-> JÁ EXISTEM ENTRADAS DE CAPITALIZAÇÃO PARA ESTE ITEM DE ATIVO.'
    --      END 

    --   END

-- 1803 RITM0359829 - Base fevereiro JDT1 base na INV1
-- Inserir unidade de negócio na linha JDT1 quando não houver com base na INV1
IF  @object_type = '30' and (@transaction_type IN ('A'))
BEGIN
  IF EXISTS
  (SELECT T0.TransId FROM OJDT T0 
    INNER JOIN JDT1 T1 ON T0.[TransId] = T1.[TransId] 
    WHERE T0.[U_SIEBS_CriadBs] = '1' 
      and T0.[U_SIEBS_BoeKey] is not null 
      and T1.[Account] = '4.2.0.001.007'
      and T0.TransId = @list_of_cols_val_tab_del
      and T0.TransType = '30'
      )
  
  BEGIN
    Declare @OcrCode2 char (6)
    set @OcrCode2= (
      select distinct

      isnull(TINV1.OcrCode2,TUNID.U_OcrCode2) as [Un. Negocio]

      from OJDT as TOJDT
      inner join JDT1 TJDT1 ON TOJDT.TransId = TJDT1.TransId --Boletos
      inner join OBOE TOBOE on TOJDT.[U_SIEBS_BoeKey] = TOBOE.[BoeKey]--Contas a Receber
      inner join ORCT TORCT on TOBOE.[PmntNum] = TORCT.[DocNum]
      inner join RCT2 TRCT2 on TORCT.[DocNum] = TRCT2.[DocNum]--NF de Entrada
      inner join OINV TOINV on TRCT2.[DocEntry] = TOINV.[DocEntry]--parcelas da nf
      inner join [INV6] TINV6 on TOINV.[DocEntry] = TINV6.[DocEntry]--itens
      inner join (select distinct DocEntry,OcrCode2 from INV1) TINV1 on TOINV.[DocEntry] = TINV1.[DocEntry]--filial
      inner join [OBPL] TOBPL on TOINV.[BPLId] = TOBPL.[BPLId]--cadastro de parceiros de negocios
      inner join [OCRD] TOCRD on TOINV.[CardCode] = TOCRD.[CardCode]--forma de pagamento
      inner join [OPYM] TOPYM on TOINV.[PeyMethod] = TOPYM.[PayMethCod] and TOPYM.[BankTransf] = 'B'--unidade de negócios de - para
      left join [@DC_UNIDADE_DEPARA] TUNID on TOINV.[U_Unidade] = TUNID.[Code]--nfse
      left join [@SKILL_NOFSNFSE001] TNFSE on TOINV.[DocEntry] = TNFSE.[U_NrDocEntry]

      WHERE TOJDT.[U_SIEBS_BoeKey] <> ''
      and TJDT1.[Debit] <> '0' and TOJDT.TransID = @list_of_cols_val_tab_del)
    
    UPDATE JDT1 set OcrCode2 = @OcrCode2 where TransID = @list_of_cols_val_tab_del and Account = '4.2.0.001.007' -- função que faz o update

  END
  
END


 -- 1787 RITM0357857 - Solicitação de bloqueio de NF com data inferiro ao sistema
 -- Validação de datas de vencimento e lançamento no documento de Nota Fiscal de Entrada (Compras)
  IF (@error = 0) AND (@object_type in ('18')) AND (@transaction_type IN ('A','U'))
  BEGIN

    DECLARE @trv150221 AS VARCHAR(MAX)
    SET @trv150221 ='FALSE'

      select @trv150221 = 'TRUE'
      from OPCH t0
      INNER JOIN PCH6 T1 ON T0.DocEntry = T1.DocEntry 
      where T0.DocEntry  = @list_of_cols_val_tab_del
      and ( t1.DueDate < t0.TaxDate )

      if (@trv150221 <> 'FALSE')
      begin
          set @error = 150221
          set @error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO QUE A DATA DE VENCIMENTO SEJA INFERIOR A DATA DO DOCUMENTO.'
      end

  END

  /* 
	// Chamado 1914 - Bloquear Documentos com caracter pipe na descrição do item

	OINV	NF de Saída	13
	ORIN	Devolução NF de Saída	14
	ODLN	Entrega		15
	ORDN	Devolução		16

	OPCH	NF de Entrada		18
	ORPC	Devolução de NF de Entrada		19
	OPDN	Recebimento Mercadoria		20
	ORPD	Devolução Mercadoria		21
	OPOR	Pedido de Compra		22

	ODRF	Esboços de documentos	112

	//
	*/

	/* Módulo de Vendas */

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('13')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[OINV] T0
				INNER JOIN [dbo].[INV1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914131,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('14')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ORIN] T0
				INNER JOIN [dbo].[RIN1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914142,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('15')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ODLN] T0
				INNER JOIN [dbo].[DLN1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914153,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('16')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ORDN] T0
				INNER JOIN [dbo].[RDN1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914164,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	/* Módulo de Compras */

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('18')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[OPCH] T0
				INNER JOIN [dbo].[PCH1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914185,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('19')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ORPC] T0
				INNER JOIN [dbo].[RPC1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914196,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('20')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[OPDN] T0
				INNER JOIN [dbo].[PDN1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914207,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('21')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ORPD] T0
				INNER JOIN [dbo].[RPD1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914218,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('22')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[OPOR] T0
				INNER JOIN [dbo].[POR1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 1914229,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	/* Esboço de documentos */

	-- Bloquear documento com caracter pipe na descrição do item
	IF (@Object_type in ('112')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.DocEntry
				FROM [dbo].[ODRF] T0
				INNER JOIN [dbo].[DRF1] T1 ON T0.DocEntry = T1.DocEntry
	
				WHERE T0.DocEntry = @list_of_cols_val_tab_del
				AND T0.ObjType in ('13','14','15','16','18','19','20','21','22')
				AND (
					(T1.Dscription LIKE '%|%')
				)
			)

			BEGIN
				SELECT
				@Error = 191411210,
				@error_message = 'VALIDAÇÃO ASCENTY-> NÃO É PERMITIDO O CARACTER PIPE NA DESCRIÇÃO DO ITEM.'
			END

	END

	/*
	// Fim do chamado 1914
	

*/


-- Trava para bloquear campos obrigatórios quando atualizar para NFS-e após adicionar documento (Chamado DUO - 1678)
  IF (@error = 0) AND (@object_type in ('13')) AND (@transaction_type IN ('U'))
  BEGIN

    DECLARE @trv2004211 AS VARCHAR(MAX)
    SET @trv2004211 ='FALSE'

      select @trv2004211 = 'TRUE',
      		 @error_message =
      		 	CASE
      		 		when (isnull(T0.U_Loc_exec_serv,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO LOCAL DE EXECUÇÃO DO SERVIÇOS NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServPais,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO PAIS NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServRua,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO LOGRADOURO NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServNumero,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO NUMERO NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when ((T1.Building is not null ) AND (isnull(T0.U_SKILL_ServComple,'') = '')) then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO COMPLEMENTO NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServBairro,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO BAIRRO NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServCEP,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO CEP NÃO FOI PREENCHIDO PARA NFS-E!'
      		 		when (isnull(T0.U_SKILL_ServTipLog,'') = '') then 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO TIPO LOGRADOURO NÃO FOI PREENCHIDO PARA NFS-E!'
      		 	else
      		 		''
      		 	end

      from OINV T0
      INNER JOIN OBPL T1 ON T0.BPLId = T1.BPLId
      INNER JOIN INV1 T2 ON T0.DocEntry = T2.DocEntry
      where T0.DocEntry  = @list_of_cols_val_tab_del
      and T0.model = 46 
      and (
	  		(T1.CITY = 'Osasco' AND T2.ItemCode = 'RO016') 
	  		OR
	  		T1.CITY = 'Vinhedo'
	  )
      and (
      		(isnull(T0.U_Loc_exec_serv,'') = '') 
      		OR
			(isnull(T0.U_SKILL_ServPais,'') = '')
			OR
			(isnull(T0.U_SKILL_ServRua,'') = '') 
			OR
			(isnull(T0.U_SKILL_ServNumero,'') = '')
			OR
			((T1.Building is not null ) AND (isnull(T0.U_SKILL_ServComple,'') = ''))
			OR
			(isnull(T0.U_SKILL_ServBairro,'') = '')
			OR
			(isnull(T0.U_SKILL_ServCEP,'') = '') 
			OR
			(isnull(T0.U_SKILL_ServTipLog,'') = '')
      )
      
      IF (@trv2004211 <> 'FALSE')
      begin
          set @error = 2004211
          --set @error_message = 'VALIDAÇÃO ASCENTY-> CAMPOS DE USUÁRIO PARA NOTA FISCAL DE SERVIÇO NÃO ESTÃO PREENCHIDOS'
      end

  END   
  
-- Trava para verificar Estado e Município quando for NFS-e (Chamado DUO - 1678)
  IF (@error = 0) AND (@Object_type in ('13')) AND (@transaction_type IN ('A'))
	BEGIN
	-- Declare the variable to be used.
		DECLARE @FilialUF VARCHAR(MAX); --Estado na OBPL
		DECLARE @EstadoNF VARCHAR(MAX); --Estado na OINV
		DECLARE @FilialMun VARCHAR(MAX); --Municip na OBPL
		DECLARE @MunNF VARCHAR(MAX); --Municip na OINV
	-- Initialize the variable.
		SET @FilialUF = (SELECT T1.State FROM OBPL T0 INNER JOIN OCNT T1 ON T0.County = T1.AbsId INNER JOIN OINV T2 ON T0.BPLId = T2.BPLId WHERE T2.DocEntry = @list_of_cols_val_tab_del);
		SET @EstadoNF = (SELECT T1.STATE FROM OINV T0  INNER JOIN INV12 T1 ON T0.DocEntry = T1.DocEntry WHERE T0.DocNum = @list_of_cols_val_tab_del);
		SET @FilialMun = (SELECT T1.Name FROM OBPL T0 INNER JOIN OCNT T1 ON T0.County = T1.AbsId INNER JOIN OINV T2 ON T0.BPLId = T2.BPLId WHERE T2.DocEntry = @list_of_cols_val_tab_del);
		SET @MunNF = (SELECT T2.Name FROM OINV T0 INNER JOIN INV12 T1 ON T0.DocEntry = T1.DocEntry INNER JOIN OCNT T2 ON T1.County = T2.AbsId WHERE T0.DocNum =  @list_of_cols_val_tab_del);


	    DECLARE @trv2004212 AS VARCHAR(MAX)
	    SET @trv2004212 ='FALSE'

	      select @trv2004212 = 'TRUE',
	      		 @error_message =
	      		 	CASE
	      		 		when ( isnull(T12.State,'') = '' ) then 'VALIDAÇÃO ASCENTY-> NA ABA IMPOSTO O ESTADO ESTÁ VAZIO'
	      		 		when ( isnull(T12.County, '') = '' ) then 'VALIDAÇÃO ASCENTY-> NA ABA IMPOSTO O MUNICÍPIO ESTÁ VAZIO'
	      		 		when ( @FilialUF != @EstadoNF and T0.model = 46 ) then 'VALIDAÇÃO ASCENTY-> NA ABA IMPOSTO O ESTADO ESTÁ DIFERENTE DA FILIAL PARA NFS-E!'
	      		 		when ( @FilialMun != @MunNF and T0.model = 46 ) then 'VALIDAÇÃO ASCENTY-> NA ABA IMPOSTO O MUNICÍPIO ESTÁ DIFERENTE DA FILIAL PARA NFS-E!'

	      		 	else
	      		 		''
	      		 	end

	      from OINV T0
	      INNER JOIN INV12 T12 ON T0.DocEntry = T12.DocEntry
	      where T0.DocEntry  = @list_of_cols_val_tab_del
	      and (
	      		( isnull(T12.State,'') = '' )
				OR
				( isnull(T12.County,'') = '' )
				OR
				( @FilialUF != @EstadoNF and T0.model = 46 )
      			OR
				( @FilialMun != @MunNF and T0.model = 46 )
      		)
      	
      	IF (@trv2004212 <> 'FALSE')
		BEGIN
			SELECT
			@Error = 2004212
			--@error_message = 'VALIDAÇÃO ASCENTY-> NA ABA IMPOSTO O ESTADO E MUNICÍPIO ESTÃO DIFERENTES DA FILIAL PARA NFS-E!'
		END

END



-- Trava para validar os dados cadastrais da NFSe estão iguais ao da filial indicada (Chamado DUO - 1678)
IF (@object_type in ('13')) AND (@transaction_type IN ('U'))
	BEGIN
		IF EXISTS(
			SELECT T0.BPLId
			FROM OBPL T0
			INNER JOIN OINV T1 ON T0.BPLId = T1.BPLId
			WHERE T1.DocEntry = @list_of_cols_val_tab_del 
			AND T1.model = 46 
			AND (
				T0.CITY != T1.U_LOC_EXEC_SERV
				OR T0.COUNTRY != (SELECT T10.CODE FROM OCRY T10 WHERE T1.U_SKILL_SERVPAIS = T10.CntCodNum)
				OR CONCAT(T0.AddrType,' ',T0.Street) != T1.U_SKILL_SERVRUA
				OR T0.StreetNo != T1.U_SKILL_SERVNUMERO
				OR SUBSTRING(T0.Building,1,35) != T1.U_SKILL_SERVCOMPLE --campo com tamanhos diferentes 
				OR T0.Block != T1.U_SKILL_SERVBAIRRO 
				OR T0.ZipCode != (SUBSTRING(T1.U_SKILL_SERVCEP,1, 5) +'-'+ SUBSTRING(T1.U_SKILL_SERVCEP,6, 3)) --não tem o traço
				OR T0.AddrType != T1.U_SKILL_SERVTIPLOG 
				)
			)
			BEGIN
				SET @error      = 2004213
				SET @error_message  = 'VALIDAÇÃO ASCENTY-> OS DADOS DE ENDEREÇO DESTA NFS-E ESTÃO DIFERENTES DA FILIAL SELECIONADA!'
			END
	END

-- TRANSACTION PARA VALIDAR SE A SEQUENCIA DA NF ESTÁ DE ACORDO COM O USO PRINCIPAL (Chamado DUO - 1678)
IF (@object_type in ('13')) AND (@transaction_type IN ('A'))
	BEGIN
		IF EXISTS(
			SELECT T0.DocEntry
			FROM OINV T0
			INNER JOIN INV1 T1 ON T0.DocEntry = T1.DocEntry
			WHERE T0.DocEntry = @list_of_cols_val_tab_del 
			AND (
				 (T1.Usage = 44 AND T0.Model not in ('58')) -- FATURA LOCAÇÃO = FATURA_1 // alterado da OINV.MainUsage para INV1.Usage
				 OR
				 (T1.Usage = 39 AND T0.Model not in ('46')) -- PREST SERVICO = NFS-E
				)
			)
			BEGIN
				SET @error      = 2004214
				SET @error_message  = 'VALIDAÇÃO ASCENTY-> A SEQUÊNCIA DA NOTA NÃO ESTÁ DE ACORDO COM UTILIZAÇÃO!'
			END
	END


--Validar o tipo de tributação quando for NFS-e para Campinas (Chamado DUO - 1678)
IF (@object_type in ('13')) AND (@transaction_type IN ('U'))
	BEGIN
		IF EXISTS(
			SELECT T0.DocEntry
			FROM OINV T0
			INNER JOIN INV12 T1 ON T0.DocEntry = T1.DocEntry
			WHERE T0.DocEntry = @list_of_cols_val_tab_del 
			AND T0.model = 46 
			AND (
				 (T1.County = 4888 AND T1.MainUsage = 39 AND T0.U_SKILL_TipTrib != 'T')
				 OR
				 (T1.County != 4888 AND T1.MainUsage = 39 AND T0.U_SKILL_TipTrib != '1')
				)
			)
			BEGIN
				SET @error      = 2004215
				SET @error_message  = 'VALIDAÇÃO ASCENTY-> CAMPO DE USUÁRIO TIPO DE TRIBUTAÇÃO ESTÁ DIVERGENTE DA REGRA!'
			END
	END

	-- VALIDAÇÃO DO ENDEREÇO DE ENTREGA DA NOTA FISCAL E PN (Chamado DUO - 1805)
IF (@Object_type in ('13')) AND (@transaction_type IN ('A'))
	BEGIN
		IF NOT EXISTS (
			SELECT DISTINCT T0.ShipToCode

			FROM OINV T0
			INNER JOIN  CRD1 T1 ON T0.CARDCODE = T1.CARDCODE AND T0.ShipToCode = T1.Address AND T1.AdresType = 'S'

			WHERE T0.DocEntry = @list_of_cols_val_tab_del
		)

		BEGIN
			SELECT
			@Error = 180501,
			@error_message = 'VALIDAÇÃO ASCENTY-> CAMPO PONTO DE ENTREGA DA ABA LOGÍSTICA NA NOTA FISCAL É DIFERENTE DA ID DO ENDEREÇO NO CADASTRO DO PN.'
		END

END

	--Chamado 2054 - RITM0365785 - campo obrigatorio (item de compra e venda e unidade de medida diferente de manual)
		IF (@Object_type in ('4')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.ItemCode
				FROM [dbo].[OITM] T0
				
	
				WHERE T0.ItemCode = @list_of_cols_val_tab_del
				AND (
					(T0.SellItem <> 'Y')
					OR
					(T0.PrchseItem <> 'Y')
					--OR
				--	(T0.UgpEntry = -1)
				)
			)

			BEGIN
				SELECT
				@Error = 2508211,
				@error_message = 'VALIDAÇÃO ASCENTY-> Definir cadastro como "item de compra" e "item de venda"'
			END

	END

		IF (@Object_type in ('4')) AND (@transaction_type IN ('A'))
		BEGIN
			IF EXISTS (
				SELECT T0.ItemCode
				FROM [dbo].[OITM] T0
				
	
				WHERE T0.ItemCode = @list_of_cols_val_tab_del
				AND (
					
					(T0.UgpEntry = -1)
				)
			)

			BEGIN
				SELECT
				@Error = 2508211,
				@error_message = 'VALIDAÇÃO ASCENTY-> Definir unidade de medida diferente de "Manual"'
			END

	END


	-- Adicionado 22-10-2021, change

	if (@object_type = '30' and @Transaction_type in ('A', 'U'))
		begin
			if exists (SELECT T0.TransType
			FROM OJDT T0 INNER JOIN JDT1 T1 ON T0.TransID = T1.TransID WHERE isnull(T1.LineMemo,'') = '' and T0.TransID = @list_of_cols_val_tab_del and T0.TransType = 30
			-- 
			)
			Begin
			
			   set @error = 03092021 -- chamado 2068
			   set @error_message = ' VALIDAÇÃO ASCENTY: NÃO É POSSÍVEL REALIZAR LANÇAMENTO CONTÁBIL MANUAL COM OBSVERCAÇÕES DA LINHA EM BRANCO '
			   
			end
		end


			   --- Atualiza referencia da solicitacao para cópia no pedido de compras, change 22-10-2021

       if  @object_type = '1470000113' and( @transaction_type = 'A' or @transaction_type ='U')
	   Begin
      update  OPRQ set U_ECF_COO = @list_of_cols_val_tab_del where docentry = @list_of_cols_val_tab_del
      End





	  -- impede modificar o projeto ou a fase na solicitacao inserida e aprovada

	  IF  @object_type = '1470000113' and( @transaction_type IN ('A','U'))
        Begin
        declare @EsbocoS as int
set @EsbocoS = (select draftkey from OPRQ where docentry = @list_of_cols_val_tab_del)

declare @PrjFase as nvarchar(100)
set @PrjFase =
(
select U_DC_PRJNAMENV + U_DC_FASENV



from odrf where docentry  = @EsbocoS 
)

if @PrjFase <> isnull((select U_DC_PRJNAMENV + U_DC_FASENV  from OPRQ where docentry = @list_of_cols_val_tab_del),'')

Begin
SET @error      = 2004216
				SET @error_message  = 'VALIDAÇÃO ASCENTY-> PROJETO OU FASE DO PROJETO, NAO PODEM SER MODIFICADOS!'
End

      end



--		 Impede modificar o projeto ou fase no pedido de compras 

		
		  IF  @object_type = '22' and( @transaction_type IN ('A','U'))
        Begin
       declare @SolB as int
set @SolB = (select U_ECF_COO  from OPOR where docentry= @list_of_cols_val_tab_del)

set @PrjFase =
(
select U_DC_PRJNAMENV + U_DC_FASENV



from OPRQ  where docentry  = @SolB 
)

if @PrjFase <> isnull((select  U_DC_PRJNAMENV + U_DC_FASENV  from OPOR where docentry = @list_of_cols_val_tab_del),'')


Begin
SET @error      = 2004216
				SET @error_message  = 'VALIDAÇÃO ASCENTY-> PROJETO OU FASE DO PROJETO, DIFERENTE DA SOLICITACAO:' + CONVERT(NVARCHAR(100),(@SolB ))
End

        end




--inicio change 21-01-2022




	  --VALIDACOES DE REGRA DE CENTRO DE CUSTOS COM NOVA TABELA DE VALIDACOES DE CODIGO DE CENTRO X GRUPO DE CONTAS
	   IF  @object_type = '30' and( @transaction_type IN ('A','U'))
		IF EXISTS(SELECT T99.TransId FROM JDT1 T99 
						WHERE left(T99.Account,1) NOT IN(
						SELECT T1.U_DC_Conta
						FROM [@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE T99.ProfitCode = T0.U_DC_CCusto)
						and (T99.ProfitCode is not null and T99.ProfitCode <> '' )
						and t99.TransId = @list_of_cols_val_tab_del)
      BEGIN
        SET @error      = 231121
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END
   
	--VALIDAÇÃO UNIDADE DE NEGÓCIOS EM SOLICITAÇÃO DE COMPRA
    IF  @object_type = '1470000113' and( @transaction_type = 'U')
        IF EXISTS(SELECT AcctCode FROM PRQ1 A0  
						WHERE left(A0.AcctCode,1) NOT IN (
						SELECT T1.U_DC_Conta
						FROM
						[@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE A0.OcrCode = T0.U_DC_CCusto)
						and A0.OcrCode is not null and A0.OcrCode <> '' /*and T99.DueDate between '20210101' and '20210131'*/
						and A0.DocEntry = @list_of_cols_val_tab_del
						--AND A0.AcctCode NOT LIKE '%1_' OR a0.AcctCode NOT LIKE '%2_'
						)
					
      BEGIN
        SET @error      = 071221 --07/12/2021 - 1
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END
	
    --VALIDAÇÃO UNIDADE DE NEGÓCIOS EM PEDIDO DE COMPRAS
    IF  @object_type = '22' and( @transaction_type = 'A')
        IF EXISTS(SELECT AcctCode FROM POR1 A0  
						WHERE left(A0.AcctCode,1) NOT IN (
						SELECT T1.U_DC_Conta
						FROM
						[@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE A0.OcrCode = T0.U_DC_CCusto)
						and A0.OcrCode is not null and A0.OcrCode <> '' /*and T99.DueDate between '20210101' and '20210131'*/
						and A0.DocEntry = @list_of_cols_val_tab_del
						--AND a0.AcctCode NOT LIKE '%1_' OR a0.AcctCode NOT LIKE '%2_'
						)
					
						
      BEGIN
        SET @error      = 061221
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END
	

	--VALIDAÇÃO UNIDADE DE NEGÓCIOS EM NOTA FISCAL DE ENTRADA 
    IF  @object_type = '18' and( @transaction_type IN('A','U'))
        IF EXISTS(SELECT AcctCode FROM PCH1 A0  
						WHERE left(A0.AcctCode,1) NOT IN(
						SELECT T1.U_DC_Conta
						FROM
						[@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE A0.OcrCode = T0.U_DC_CCusto)
						and A0.OcrCode is not null and A0.OcrCode <> '' /*and T99.DueDate between '20210101' and '20210131'*/
						and A0.DocEntry = @list_of_cols_val_tab_del
						AND (A0.AcctCode NOT LIKE '1%' )
						)

      BEGIN
        SET @error      = 0712212 --07/12/2021 - 2
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END

		
	--VALIDAÇÃO UNIDADE DE NEGÓCIOS EM PEDIDO DE VENDA
    IF  @object_type = '17' and( @transaction_type = 'A')
        IF EXISTS(SELECT AcctCode FROM RDR1 A0  
						WHERE left(A0.AcctCode,1) NOT IN (
						SELECT T1.U_DC_Conta
						FROM
						[@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE A0.OcrCode = T0.U_DC_CCusto)
						and A0.OcrCode is not null and A0.OcrCode <> '' /*and T99.DueDate between '20210101' and '20210131'*/
						and A0.DocEntry = @list_of_cols_val_tab_del
						--AND A0.AcctCode NOT LIKE '%1_' OR a0.AcctCode NOT LIKE '%2_'
						)
      BEGIN
        SET @error      = 0712213 --07/12/2021 - 3
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END

	
	--VALIDAÇÃO UNIDADE DE NEGÓCIOS EM NOTA FISCAL DE SAÍDA
    IF  @object_type = '13' and( @transaction_type = 'A')
        IF EXISTS(SELECT AcctCode FROM INV1 A0  
						WHERE left(A0.AcctCode,1) NOT IN (
						SELECT T1.U_DC_Conta
						FROM
						[@DC_REgra_cc] T0
						inner join [@DC_REgra_cc1] T1 on T0.Code = T1.Code
						WHERE A0.OcrCode = T0.U_DC_CCusto)
						and A0.OcrCode is not null and A0.OcrCode <> '' /*and T99.DueDate between '20210101' and '20210131'*/
						and A0.DocEntry = @list_of_cols_val_tab_del
						--AND A0.AcctCode NOT LIKE '%1_' OR a0.AcctCode NOT LIKE '%2_'
						)
						
      BEGIN
        SET @error      = 0712214 --07/12/2021 - 4
        SET @error_message  = 'VALIDAÇÃO ASCENTY->  Centro de custo não pode ser utilizado para esta conta.'
    END
	
	  --FIM--



	  -- REGRAS DE CENTRO DE CUSTO NOVAS

	    -- Preenche centro de custo para as contas de despesa entrada nf---
      
      if  @object_type = '18' and( @transaction_type = 'A')
      begin
      declare @Centro2 as nvarchar (10)
      set @Centro = (select top 1 (ocrcode) from PCH1 where DocEntry = @list_of_cols_val_tab_del  and AcctCode like '4%' order by LineNum asc )
	   set @Centro2 = (select top 1 (ocrcode2) from PCH1 where DocEntry = @list_of_cols_val_tab_del  and AcctCode like '4%' order by LineNum asc )
      --declare @baseref as nvarchar (10)
    IF (SELECT count(T0.DocEntry)
        FROM OPCH T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN PCH1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set profitcode = @Centro , OcrCode2 = @Centro2  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '4%' and TransType =18
      end
End 

    -- Preenche centro de custo para as contas de custo entrada---
      
      if  @object_type = '18' and( @transaction_type = 'A' )
      begin
     -- declare @Centro as nvarchar (10)
      set @Centro = (select top 1 (ocrcode) from PCH1 where DocEntry = @list_of_cols_val_tab_del  and AcctCode like '5%' order by LineNum asc )
	   set @Centro2 = (select top 1 (ocrcode2) from PCH1 where DocEntry = @list_of_cols_val_tab_del and AcctCode like '5%' order by LineNum asc )
      --declare @baseref as nvarchar (10)
	  declare @dspad as numeric (19,6)
	  set @dspad=(SELECT sum(TotalSumSy)  FROM PCH13 T0 WHERE T0.[DocEntry] =@list_of_cols_val_tab_del)

    IF (SELECT count(T0.DocEntry)
        FROM OPCH T0 INNER JOIN OJDT T1 ON T0.DocEntry = T1.BaseRef AND T0.ObjType =T1.TransType 
        INNER JOIN JDT1 T2 ON T1.TransId = T2.TransId 
        INNER JOIN PCH1 T3 ON T0.DocEntry =T3.DocEntry 
        WHERE T3.OcrCode <> '' 
        AND T0.DocEntry = @list_of_cols_val_tab_del) > 0
Begin

      update jdt1 set profitcode = @Centro, OcrCode2 =@Centro2  where BaseRef  =@list_of_cols_val_tab_del  and ShortName like '5%' and TransType =18
	  if @dspad > 0
	  Begin
	  update jdt1 set ProfitCode =@centro, OcrCode2 =@Centro2  where debit+credit =@dspad and baseref = @list_of_cols_val_tab_del  and TransType =18
	  end
      end
End 

	  -- FIM


-- REGRAS ABAIXO FORAM COMENTADAS POR TEREM ATUALIZADO LCMS INDEVIDAMENTE
--	  -- DISTRIBUIÇÃO DE CUSTOS PARA NOTA FISCAL DE ENTRADA
--IF  @object_type = '18' and (@transaction_type = 'A' or @transaction_type ='U')
--BEGIN
--		declare @Centro_custo_NE as nvarchar (10)
--		declare @Unidade_negocios_NE as nvarchar (10)

--		set @Centro_custo_NE = (select top 1 T0.OcrCode from PCH1 T0
--		where T0.DocEntry = @list_of_cols_val_tab_del)

--		set @Unidade_negocios_NE = (select top 1 T0.OcrCode2 from PCH1 T0
--		where T0.DocEntry = @list_of_cols_val_tab_del)
	  
--IF (SELECT count(T0.TransId) FROM OJDT T0 
--	INNER JOIN OPCH T1 ON T0.TransId = T1.TransId AND T0.TransType = T1.ObjType 
--	INNER JOIN PCH1 T2 ON T1.DocEntry = T2.DocEntry
--	INNER JOIN JDT1 T3 ON T0.TransId = T3.TransId
--	WHERE T1.DocEntry = @list_of_cols_val_tab_del
--	AND isnull(T3.Credit, '') is not null
--	AND (T2.OcrCode <> '' or T2.OcrCode2 <> '') ) > 0

--	Begin
--		UPDATE JDT1 SET ProfitCode = @Centro_custo_NE 
--			WHERE BaseRef = @list_of_cols_val_tab_del 
--			AND ShortName in (select top 1 T0.TaxExpAct from PCH4 T0 
--							  where T0.DocEntry = @list_of_cols_val_tab_del
--							  and T0.TaxExpAct like '3%' or T0.TaxExpAct like '5%'
--							  )
--			AND Credit > 0
--			AND TransType = 18

--		UPDATE JDT1 SET OcrCode2 = @Unidade_negocios_NE
--			WHERE BaseRef = @list_of_cols_val_tab_del 
--			AND ShortName like '3%' or ShortName like '5%' 
--			AND Credit > 0
--			AND TransType = 18
			 	
--	END
--END

---- DISTRIBUIÇÃO DE CUSTOS PARA NOTA FISCAL DE SAÍDA
--IF  @object_type = '13' and (@transaction_type = 'A' or @transaction_type ='U')
--BEGIN
--		declare @Centro_custo_NS as nvarchar (10)
--		declare @Unidade_negocios_NS as nvarchar (10)

--		set @Centro_custo_NS = (select top 1 T0.OcrCode from INV1 T0
--		where T0.DocEntry = @list_of_cols_val_tab_del)

--		set @Unidade_negocios_NS = (select top 1 T0.OcrCode2 from INV1 T0
--		where T0.DocEntry = @list_of_cols_val_tab_del)
	  
--IF (SELECT count(T0.TransId) FROM OJDT T0 
--	INNER JOIN OINV T1 ON T0.TransId = T1.DocEntry AND T0.TransType = T1.ObjType 
--	INNER JOIN INV1 T2 ON T1.DocEntry = T2.DocEntry
--	INNER JOIN JDT1 T3 ON T0.TransId = T3.TransId
--	WHERE T1.DocEntry = @list_of_cols_val_tab_del
--	AND isnull(T3.Credit, '') is not null
--	AND (T2.OcrCode <> '' or T2.OcrCode2 <> '') ) > 0

--	Begin
--		UPDATE JDT1 SET ProfitCode = @Centro_custo_NS
--			WHERE BaseRef = @list_of_cols_val_tab_del 
--			AND ShortName in (select top 1 T0.TaxExpAct from PCH4 T0 
--							where T0.DocEntry = @list_of_cols_val_tab_del
--							and T0.TaxExpAct like '3%' or T0.TaxExpAct like '5%'
--							)
--			AND Credit > 0
--			AND TransType = 13

--		UPDATE JDT1 SET OcrCode2 = @Unidade_negocios_NS
--			WHERE BaseRef = @list_of_cols_val_tab_del 
--			AND ShortName like '3%' or ShortName like '5%' 
--			AND Credit > 0
--			AND TransType = 13
			 	
--	END
--END
/*
-- Centro de custo para Lançamento contábil manual
	IF @object_type = '30' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[JDT1] 
	WHERE (ProfitCode is null OR ProfitCode = '')  AND TransId = @list_of_cols_val_tab_del and (Account like '3%' or ACCOUNT like '4%' or Account Like '5%')) > 0 
     
      BEGIN
           SET @error = '16122021'
            SET @error_message = 'Informe o Centro de Custo nas contas de resultado!'

      END
END	
*/
-- centro de custo para solicitação de compra
	IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[PRQ1] 
	WHERE (OcrCode is null OR OcrCode = '')  AND DocEntry = @list_of_cols_val_tab_del and (AcctCode like '3%' or AcctCode like '4%' or AcctCode Like '5%') )> 0 
     
      BEGIN
           SET @error = '17122021'
            SET @error_message = 'Informe o Centro de Custo!'

      END
END

-- centro de custo em pedido de compra
	IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[por1] 
	WHERE (OcrCode is null OR OcrCode = '')  AND DocEntry = @list_of_cols_val_tab_del and (AcctCode like '3%' or AcctCode like '4%' or AcctCode Like '5%') )> 0 
     
      BEGIN
           SET @error = '171220212'
            SET @error_message = 'Informe o Centro de Custo!'

      END
END

-- centro de custo em nota fiscal de entrada
	IF @object_type = '18' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[pch1] 
	WHERE (OcrCode is null OR OcrCode = '')  AND DocEntry = @list_of_cols_val_tab_del and (AcctCode like '3%' or AcctCode like '4%' or AcctCode Like '5%') )> 0 
     
      BEGIN
           SET @error = '171220213'
            SET @error_message = 'Informe o Centro de Custo!'

      END
END

-- centro de custo em pedido de venda
	IF @object_type = '17' AND @transaction_type in ('U')

BEGIN
IF (Select Count(1) FROM [dbo].[rdr1] 
	WHERE (OcrCode is null OR OcrCode = '')  AND DocEntry = @list_of_cols_val_tab_del and (AcctCode like '3%' or AcctCode like '4%' or AcctCode Like '5%') )> 0 
     
      BEGIN
           SET @error = '171220214'
            SET @error_message = 'Informe o Centro de Custo!'

      END
END

-- centro de custo em nota fiscal de saída
	IF @object_type = '13' AND @transaction_type in ('A','U') 

BEGIN
IF (Select Count(1) FROM [dbo].[inv1] 
	WHERE (OcrCode is null OR OcrCode = '') and FreeChrgBP <> 'Y' AND DocEntry = @list_of_cols_val_tab_del and (AcctCode like '3%' or AcctCode like '4%' or AcctCode Like '5%') )> 0 
     
      BEGIN
           SET @error = '171220215'
            SET @error_message = 'Informe o Centro de Custo!'

      END
END




-- fim change 21-01-2022

--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

-- Regra: Verificar se o NCM do item da nota de entrada esta igual ao do cadastro no SAP
-- Utilização: Utilizada para obrigar o preenchimento correto do NCM que pode ter sido excluido da tabela TIP
-- versao 1 - 05/04/2022 - Murilo Garcia Martins
-- Criação do documento

---------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------- 
--DEVOLUÇÃO DE NOTA FISCAL DE ENTRADA

IF  @object_type = '19' and (@transaction_type = 'A' or @transaction_type = 'U')
        begin
        IF 
		(
		Select Count (*) 
From
 ORPC T0 inner join 
 RPC1 T1 ON T0.docentry = T1.docentry inner join 
 OITM T2 ON T1.itemcode = T2.itemcode inner join ONCM T3 ON T2.[NCMCode] = T3.[AbsEntry]
Where
 T0.DocNum = @list_of_cols_val_tab_del 
 and cast(T1.U_SKILL_InfAdItem as varchar(200))<> CAST (T3.ncmcode AS VARCHAR(20))
 ) > 0
      Begin
           SET @error              = '9999'
          SET @error_message    = 'O NCM do item não e válido'
        End
    end

--DEVOLUÇÃO DE MERCADORIAS

IF  @object_type = '21' and (@transaction_type = 'A' or @transaction_type = 'U')
        begin
        IF 
		(
		Select Count (*) 
From
 ORPD T0 inner join 
 RPD1 T1 ON T0.docentry = T1.docentry inner join 
 OITM T2 ON T1.itemcode = T2.itemcode inner join ONCM T3 ON T2.[NCMCode] = T3.[AbsEntry]
Where
 T0.DocNum = @list_of_cols_val_tab_del 
 and cast(T1.U_SKILL_InfAdItem as varchar(200))<> CAST (T3.ncmcode AS VARCHAR(20))
 ) > 0
      Begin
           SET @error              = '9999'
          SET @error_message    = 'O NCM do item não e válido'
        End
    end

	--inicio change dia 17-06-2022

	----------------------------------------------------------------------------------------------------------------------
------ Trava - OITM
------ Regra: Obrigar o preenchimento da classe de ativo "NÃO DEPRECIAR"
------ Data de criação: 14/04/2022
------ Desenvolvimento: Marcos Silva - DuoConect
------ Chamado - 2269
----------------------------------------------------------------------------------------------------------------------
/*
IF @object_type = '4'and (@transaction_type = 'A' or @transaction_type = 'U')
 BEGIN
        IF  (SELECT COUNT(DISTINCT dprarea)FROM ITM7 
             WHERE  ItemCode = @list_of_cols_val_tab_del and DprArea= 'NAO DEPRECIAR' )=0 
                     
      BEGIN
           SET @error             = 401
           SET @error_message      = 'USAR CLASSE QUE CONTENHA "NÃO DEPRECIAR".'
   END
 END


IF @object_type = '4'and (@transaction_type = 'A' or @transaction_type = 'U')
 BEGIN
        IF  (SELECT COUNT(DISTINCT dprarea)FROM ITM7 
             WHERE ItemCode = @list_of_cols_val_tab_del)
                     <2
      BEGIN
           SET @error             = 401
           SET @error_message      = 'ADICIONAR CLASSE DE ATIVO SECUNDARIA.'
   END
 END
 */
 
  IF @object_type = '4'and @transaction_type IN ('A') 
	BEGIN
		IF (SELECT COUNT(T0.DprArea) FROM ITM7 T0
								 INNER JOIN OITM T1 ON T0.ItemCode=T1.ItemCode
								 WHERE T1.ItemCode = @list_of_cols_val_tab_del AND T1.ITEMTYPE = 'F' AND T0.DprArea not like 'NAO DEPRECIAR') >1 
																					
      BEGIN
           SET @error             = 401
           SET @error_message      = 'USAR CLASSE QUE CONTENHA "NÃO DEPRECIAR".'
	  END
	END

	
	IF @object_type = '4'and @transaction_type IN ('A','U') 
	BEGIN
		IF (SELECT COUNT(T0.DprArea) FROM ITM7 T0
								 INNER JOIN OITM T1 ON T0.ItemCode=T1.ItemCode
								 WHERE T1.ItemCode = @list_of_cols_val_tab_del AND T1.ITEMTYPE = 'F') =1 
																					
      BEGIN
           SET @error             = 402
           SET @error_message      = 'ADICIONAR CLASSE DE ATIVO SECUNDARIA.'
	  END
	END



	

	  -- valida preenchimento de centro de custo para projetos capex

	  IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = ''  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'VALIDACAO ASCENTY: INFORME TIPO DE COMPRA'

      END
	  END




	  IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode3 is null OR T1.OcrCode3 = '') and isnull(T0.U_DC_CapSN,'') = '2'  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'TIPO DE COMPRA CAPEX, OBRIGATORIO INFORMAR PROJETO, DISCIPLINA, GRUPO , SUBGRUPO E FASE'

      END
	  END


	   IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode4 is null OR T1.OcrCode4 = '') and isnull(T0.U_DC_PRJNAMENV,'') <> '' and isnull(T0.U_DC_CapSN,'') = '2'   AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'PEDIDO PARA PROJETO CAPEX, OBRIGATORIO INFORMAR GRUPO E SUBGRUPO NA REGRA DE DISTRIBUICAO'

      END
	  END


	     IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (isnull(T1.Project,''))='' and isnull(T0.U_DC_PRJNAMENV,'') <> '' and isnull(T0.U_DC_CapSN,'') = '2'   AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'PEDIDO PARA PROJETO CAPEX, OBRIGATORIO INFORMAR FASE'

      END
	  END


	  
	  IF @object_type = '22' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPOR] T0 inner join POR1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = '2' and  isnull(T0.U_DC_PRJNAMENV,'') <> '' and t1.OcrCode3  <>  (select isnull(U_DC_GRUPO,'')  from dbo.[@DC_LINK_GRP_SUB] where T1.OcrCode4 =U_DC_SUBGRP  )  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'PEDIDO PARA PROJETO CAPEX, GRUPO E SUBGRUPO INFORMADOS NAO FAZEM PARTE DA MESMA REGRA'

      END
	  END

 -- Validacoes capex solicitacoes
 
  IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = ''  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'VALIDACAO ASCENTY: INFORME TIPO DE COMPRA'

      END
	  END




	  IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode3 is null OR T1.OcrCode3 = '') and isnull(T0.U_DC_CapSN,'') = '2'  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'TIPO DE COMPRA CAPEX, OBRIGATORIO INFORMAR PROJETO, DISCIPLINA, GRUPO , SUBGRUPO E FASE'

      END
	  END


	   IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode4 is null OR T1.OcrCode4 = '') and isnull(T0.U_DC_PRJNAMENV,'') <> '' and isnull(T0.U_DC_CapSN,'') = '2'   AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, OBRIGATORIO INFORMAR GRUPO E SUBGRUPO NA REGRA DE DISTRIBUICAO'

      END
	  END



	  --
	  	   IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.Project is null OR T1.Project = '') and isnull(T0.U_DC_PRJNAMENV,'') <> '' and isnull(T0.U_DC_CapSN,'') = '2'   AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, OBRIGATORIO INFORMAR FASE'

      END
	  END

	  --


	  
	  IF @object_type = '1470000113' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[OPRQ] T0 inner join PRQ1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = '2' and  isnull(T0.U_DC_PRJNAMENV,'') <> '' and t1.OcrCode3  <>  (select isnull(U_DC_GRUPO,'')  from dbo.[@DC_LINK_GRP_SUB] where T1.OcrCode4 =U_DC_SUBGRP  )  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, GRUPO E SUBGRUPO INFORMADOS NAO FAZEM PARTE DA MESMA REGRA'

      END
	  END



	  -- validacoes capex em esboco de solicitacoes

	   IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = '' and T0.ObjType = '1470000113' AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'VALIDACAO ASCENTY: INFORME TIPO DE COMPRA'

      END
	  END



	  --
	  IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode3 is null OR T1.OcrCode3 = '') and T0.ObjType = '1470000113' and isnull(T0.U_DC_CapSN,'') = '2'  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'TIPO DE COMPRA CAPEX, OBRIGATORIO INFORMAR PROJETO, DISCIPLINA, GRUPO , SUBGRUPO E FASE'

      END
	  END
--
	  IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.Project is null OR T1.Project = '') and T0.ObjType = '1470000113' and isnull(T0.U_DC_CapSN,'') = '2'  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'TIPO DE COMPRA CAPEX, OBRIGATORIO FASE'

      END
	  END







	   IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE (T1.OcrCode4 is null OR T1.OcrCode4 = '')and T0.ObjType = '1470000113' and isnull(T0.U_DC_PRJNAMENV,'') <> '' and isnull(T0.U_DC_CapSN,'') = '2'   AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, OBRIGATORIO INFORMAR GRUPO E SUBGRUPO NA REGRA DE DISTRIBUICAO'

      END
	  END


	    IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = '2' and T0.ObjType = '1470000113' and isnull(U_DC_PRJNAMENV,'')=''  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, INFORME O PROJETO'

      END
	  END

	  
	  IF @object_type = '112' AND @transaction_type in ('A','U')

BEGIN
IF (Select Count(1) FROM [dbo].[ODRF] T0 inner join DRF1 T1 on T0.DocEntry = T1.DocEntry
      WHERE  isnull(T0.U_DC_CapSN,'') = '2' and T0.ObjType = '1470000113' and  isnull(T0.U_DC_PRJNAMENV,'') <> '' and t1.OcrCode3  <>  (select isnull(U_DC_GRUPO,'')  from dbo.[@DC_LINK_GRP_SUB] where T1.OcrCode4 =U_DC_SUBGRP  )  AND T0.DocEntry = @list_of_cols_val_tab_del)  > 0 
     
      BEGIN
           SET @error = '44'
            SET @error_message = 'SOLICITACAO PARA PROJETO CAPEX, GRUPO E SUBGRUPO INFORMADOS NAO FAZEM PARTE DA MESMA REGRA'

      END
	  END


	  -- reabre pedido de compra 
	  IF @object_type = '18' AND @transaction_type in ('C')

	  Begin
	  declare @PCnf as int
	  set @PCnf = (select  U_DC_PedComp from OPCH where docentry =@list_of_cols_val_tab_del )

	  UPDATE OPOR set DocStatus = 'O' where docentry = @PCnf 
	  Update POR1 set LineStatus ='O' where ItemCode in (select itemcode from PCH1 where docentry =@list_of_cols_val_tab_del) and DocEntry =@PCnf 

	  end 

  ----------------------------------------------------------------------------------------------------------------------------------------
  --CHAMADO 3172 - DUOCONECT - MARCOS PEREIRA - IMPEDE A CRIAÇÃO DE  PEDIDO DE COMPRAS COM O PARCEIRO NÃO HOMOLOGADO 07/07/2023
  ----------------------------------------------------------------------------------------------------------------------------------------

 IF(@object_type = '22' AND (@transaction_type = 'A' ))
      IF(SELECT COUNT(T0."DocEntry")
                FROM OPOR T0 
                INNER JOIN OCRD T1 ON T0."CARDCODE" = T1."CARDCODE" 
                      WHERE isnull(T1.IndustryC,'') not in('3', '5') 
      --and T0.ObjType ='1470000113'
                 AND T0.DocEntry  = @list_of_cols_val_tab_del) > 0
                              
                BEGIN
        SET @error = 2222;
        SET @error_message = 'PARCEIRO DE NEGÓCIOS NÃO HOMOLOGADO OU ISENTO'; 
                END 

 ----------------------------------------------------------------------------------------------------------------------------------------
 -- FIM  DA TRAVA - CHAMADO 3172
 ----------------------------------------------------------------------------------------------------------------------------------------
 
 /*
 /*Bloco teste para obrigatoriedade do preenchimento para o Código do Serviço */

IF  @object_type = '18' and (@transaction_type = 'A' )
       
	
	IF
		(
			SELECT count(T1.DocEntry) FROM OPCH t1
			
			WHERE t1.Model ='46' AND t1.U_U_CodServ = ''
		)  > 0 

      BEGIN
        SET @error      = 20240718;
        SET @error_message  = 'Preencher o Código de Serviço';
    ENd
	
	*/



---------------------------------------------------------------------------------------------------------------------- 
------ Fim da Trava Obrigar o preenchimento da classe de ativo "NÃO DEPRECIAR"
---------------------------------------------------------------------------------------------------------------------- 

--fim change dia 17-06-2022

    /*


	-- Change 22-09-2023 - chamado 3097



¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Fim                                                                                                           
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/
-- fim change 22-04-2022

 
 -- Change 22-09-2023 - chamado 3097
 
    IF @object_type = '18' AND @transaction_type in ('A','U')

	BEGIN
	IF
		(
			SELECT count(T1.DocEntry) FROM [dbo].[PCH13]  T1 
			INNER JOIN OEXD T2 ON T1.[ExpnsCode] = T2.[ExpnsCode]
			inner join PCH1 T3 ON T1.DocEntry =T3.DocEntry
			WHERE substring(T2.[ExpnsAcct],0,10)<> substring( T3.AcctCode,0,10) and T1.DocEntry =@list_of_cols_val_tab_del 
		)  > 0 
     
      BEGIN
           SET @error = '3097'
            SET @error_message = 'NOTA FISCAL: CONTA DO ITEM E CONTA DA DESPESA ADICIONAL NAO SAO DO MESMO GRUPO CONTABIL'

      END 
	END 

	
 IF  @object_type = '112' and (@transaction_type = 'U')
begin
if((SELECT U_DC_ValidaCompras from ODRF where DocEntry = @list_of_cols_val_tab_del) = 'Sim' and (select count(*) from dbo.[@DC_DATAHORA_APROV] where Name = @list_of_cols_val_tab_del) = 0)
insert into dbo.[@DC_DATAHORA_APROV](Name, U_DC_Aprov_Comp) values(@list_of_cols_val_tab_del, GetDate())
end

IF  @object_type = '112' and (@transaction_type = 'U')
begin
if((SELECT U_DC_ValidaContabil from ODRF where DocEntry = @list_of_cols_val_tab_del) = 'Sim' and (select isnull(U_DC_Aprov_Ctb, '') from dbo.[@DC_DATAHORA_APROV] where Name = @list_of_cols_val_tab_del) = '')
update dbo.[@DC_DATAHORA_APROV] set U_DC_Aprov_Ctb = GetDate() where Name = @list_of_cols_val_tab_del
end

--IF  @object_type = '112' and (@transaction_type = 'U')
--begin
--if((SELECT U_DC_ValidaFiscal from ODRF where DocEntry = @list_of_cols_val_tab_del) = 'Sim' and (select isnull(U_DC_Aprov_Fiscal, '') from dbo.[@DC_DATAHORA_APROV] where Name = @list_of_cols_val_tab_del) = '')
--update dbo.[@DC_DATAHORA_APROV] set U_DC_Aprov_Fiscal = GetDate() where Name = @list_of_cols_val_tab_del
--end


		--adicionar na tabela de verificação do valor
IF(@object_type = '22' AND (@transaction_type in ('A', 'U') ))
begin
insert into dbo.[@DC_PEDAPROV](Name, U_DC_AprovStts, U_DC_Valor, U_DC_Used) (select DocEntry, U_DC_Status, DocTotal, 0 from opor where DocEntry = @list_of_cols_val_tab_del);
END 
/*
--mudar o status quando alterar o valor
IF(@object_type = '22' AND (@transaction_type = 'U' ))
BEGIN
      IF(SELECT top 1 U_DC_Valor from dbo.[@DC_PEDAPROV] where Name = @list_of_cols_val_tab_del and U_DC_Valor <> (select DocTotal from opor where DocEntry = @list_of_cols_val_tab_del) and U_DC_Used = 0 order by Code Desc) > 0
		update opor set U_TDS_APROV5 = '01', U_TDS_APROV1 = '01', U_TDS_APROV2 = '01', U_TDS_APROV3 = '01', U_TDS_APROV4 = '01' where DocEntry = @list_of_cols_val_tab_del
		update dbo.[@DC_PEDAPROV] set U_DC_Used = '1' where Name = @list_of_cols_val_tab_del and U_DC_Valor <> (select DocTotal from opor where DocEntry = @list_of_cols_val_tab_del) and U_DC_Used = 0
                END 
 */
 IF  @object_type = '1470000113' and (@transaction_type = 'A' or @transaction_type = 'U')
begin
if((SELECT U_TDS_AREA from OPRQ where DocEntry = @list_of_cols_val_tab_del) = 'ORCAMENTOS')
Begin
           SET @error             = 20240116
          SET @error_message      = 'Selecionar área de compras valida'
      

    select @error, @error_message
    end
end

 IF  @object_type = '22' and (@transaction_type = 'A' or @transaction_type = 'U')
begin
if((SELECT U_TDS_AREA from OPOR where DocEntry = @list_of_cols_val_tab_del) = 'ORCAMENTOS')
Begin
           SET @error             = 20240116
          SET @error_message      = 'Selecionar área de compras valida'
      

    select @error, @error_message
    end
end 

----------------------------------------------------------------------------------------------------------------------------------
/*Bloco teste para obrigatoriedade do preenchimento para o tipo de fornecedor */

IF  @object_type = '2' and (@transaction_type = 'A' or @transaction_type = 'U')
        IF ((Select case when T0.CardType = 'C' then 'V' when T0.CardType = 'S' and isnull(T0.U_Formtipo, '-') = '-' then 'F' else 'V' end from ocrd t0 where CardCode = @list_of_cols_val_tab_del)) = 'F'
      BEGIN
        SET @error      = 20240214
        SET @error_message  = 'Preencher o tipo de fornecedor'
    ENd
	-- FIM CHANGE 22-09-2023
 IF  @object_type = '22' and (@transaction_type = 'A')
begin
update opor set U_DC_CodRegra = (SELECT distinct T1.[U_DC_CodRegra] FROM [dbo].[@DC_CAD_REGRA]  T1 inner join OPOR T0 on T1.[U_DC_Area] = T0.U_TDS_AREA and  T1.[U_DC_Status]='A' and T1.U_DC_Empresa = 'SBO_DATACENT_OFICIAL' where T0.DocEntry = @list_of_cols_val_tab_del) where DocEntry = @list_of_cols_val_tab_del
end 

----------------------------------------------------------------------------------------------------------------------------------
/*Bloco teste para obrigatoriedade do preenchimento do Código de Serviço na Nota Fiscal de Entrada */


IF  @object_type = '18' and (@transaction_type = 'A')
begin
if((SELECT count(DocNum) from OPCH where DocEntry = @list_of_cols_val_tab_del and isnull(u_u_CodServ, '') = '' and model = 46) > 0)
Begin
           SET @error             = 20240116
          SET @error_message      = 'Para adicionar a nota preencher o campo "Codigo do Serviço"'

 
    select @error, @error_message
    end
end

IF  @object_type = '13' and (@transaction_type in ('U', 'A'))
IF((SELECT VATFirst from OINV WHERE DocEntry = @list_of_cols_val_tab_del) =  'T' or (SELECT VATFirst from OINV WHERE DocEntry = @list_of_cols_val_tab_del) =  '')
begin
update OINV set VATFirst = 'Y' where DocEntry = @list_of_cols_val_tab_del
end


IF @object_type = '1470000113' and @transaction_type = 'A'

IF 

(SELECT TOP 1
'TRUE' 
FROM PRQ1
WHERE ISNULL (U_DC_AbrCaixa, '' ) = '' AND ItemCode LIKE 'MG%' AND DocEntry = @list_of_cols_val_tab_del) = 'TRUE' 

BEGIN
SET @error      = 20240821
        SET @error_message  = 'Para itens de material ou ativo é obrigatorio informar se pode abrir a caixa'


end 

--Validação da regra do campo caixa de operação, projeto demanda ativo fixo esbolço

IF @object_type = '112' and @transaction_type = 'A'

IF 

(SELECT TOP 1
'TRUE' 
FROM DRF1 INNER JOIN ODRF ON DRF1.DocEntry = ODRF.DocEntry
WHERE ISNULL (U_DC_AbrCaixa, '' ) = '' AND ItemCode LIKE 'MG%' AND ODRF.DocEntry = @list_of_cols_val_tab_del AND ODRF.ObjType = 1470000113 ) = 'TRUE' 

BEGIN
SET @error      = 20240821
        SET @error_message  = 'Para itens de material ou ativo é obrigatorio informar se pode abrir a caixa'


end 
 -- Select the return values  ---------------------------------------------------------------------------------------------------------------------------------------

select @error, @error_message

end


