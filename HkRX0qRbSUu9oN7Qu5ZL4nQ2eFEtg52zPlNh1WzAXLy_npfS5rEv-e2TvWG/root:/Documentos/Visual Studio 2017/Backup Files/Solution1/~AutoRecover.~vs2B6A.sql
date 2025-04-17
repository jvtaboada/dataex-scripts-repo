EXEC sp_executesql 
N'
WITH topBOM AS (
    SELECT 
        promotionArticleCode AS pac,
        bm.articleCode AS ac
    FROM promotionArticleDetail bm
    WHERE bm.articleCode = @P0

    UNION ALL

    SELECT 
        bb.promotionArticleCode,
        ba.pac
    FROM topBOM ba
    JOIN promotionArticleDetail bb ON ba.pac = bb.articleCode
),
bomHeaders AS (
    SELECT 
        a.pac AS articleCode
    FROM topBOM a
    LEFT JOIN topBOM b ON a.pac = b.ac
    INNER JOIN Article ON a.pac = Article.articleCode
    LEFT OUTER JOIN AddUserDefinedFields ON AddUserDefinedFields.ArticleCode = Article.articleCode
    WHERE 
        b.ac IS NULL 
        AND Article.articleCode IN (
            SELECT articleCode 
            FROM Article 
            WHERE LEN(code) = 15 
               OR (groupcode1 = ''0590'' AND ud4 <> ''APLIC. DIRETA'')
        )
    GROUP BY a.pac
),
currentArticle AS (
    SELECT TOP 1 
        @P1 AS articleCode 
    FROM bomHeaders 
    HAVING COUNT(bomHeaders.articleCode) = 0
),
headers AS (
    SELECT articleCode FROM bomHeaders
    UNION
    SELECT articleCode FROM currentArticle
),
bomInfo AS (
    SELECT 
        articleCode AS bomHeader,
        CAST(NULL AS nvarchar(85)) AS parent,
        CAST(articleCode AS nvarchar(85)) AS child,
        0 AS level,
        CAST(articleCode AS nvarchar(4000)) AS breadCrumb,
        CAST('' AS nvarchar(4000)) AS branchId
    FROM headers

    UNION ALL

    SELECT 
        bomInfo.bomHeader,
        a.promotionArticleCode,
        a.articleCode,
        level + 1,
        CAST(breadCrumb + '' > '' + a.articleCode AS nvarchar(4000)) AS breadCrumb,
        CAST(
            CASE 
                WHEN branchId <> '''' THEN branchId + '' > '' + a.promotionArticleCode 
                ELSE a.promotionArticleCode 
            END AS nvarchar(4000)
        ) AS branchId
    FROM promotionArticleDetail a
    INNER JOIN bomInfo ON a.promotionArticleCode = bomInfo.child
)
SELECT DISTINCT TOP 100001
    bomHeader,
    COUNT(bomHeader) OVER (PARTITION BY bomHeader) AS bomHeaderArticles,
    bomInfo.child AS articleCode,
    level AS ROW_DEPTH,
    breadCrumb,
    Article.articleCode AS [Article.articleCode],
    Article.warehouse AS [Article.warehouse],
    Article.code AS [Article.code],
    Article.uD1 AS [Article.uD1],
    Article.uD5 AS [Article.uD5],
    AddUserDefinedFields.aUDField4 AS [Article.aUDField4],
    Article.eoqCalculated AS [Article.eoqCalculated],
    Article.averageDemand AS [Article.averageDemand],
    Article.stockOnHand AS [Article.stockOnHand],
    Article.stockOnOrder AS [Article.stockOnOrder],
    Article.backOrders AS [Article.backOrders],
    Article.orderLevel AS [Article.orderLevel],
    Article.roundedOrderQuantity AS [Article.roundedOrderQuantity],
    ROUND(Article.leadTime, 2) AS [Article.leadTimeInMonths],
    Article.unitPrice AS [Article.unitPrice],
    Article.supplierMinOrderQuantity AS [Article.supplierMinOrderQuantity],
    Article.supplierIncOrderQuantity AS [Article.supplierIncOrderQuantity],
    Article.description AS [Article.description]
FROM bomInfo
INNER JOIN Article ON bomInfo.child = Article.articleCode
LEFT OUTER JOIN AddUserDefinedFields ON Article.articleCode = AddUserDefinedFields.articleCode
WHERE Article.articleCode IN (
    SELECT articleCode 
    FROM Article 
    WHERE LEN(code) = 15 
       OR (groupcode1 = ''0590'' AND ud4 <> ''APLIC. DIRETA'')
)
ORDER BY breadCrumb
',
N'@P0 nvarchar(4000), @P1 nvarchar(4000)',
N'02_059015000018', N'02_059015000018'