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
    Article.articleCode AS [Article