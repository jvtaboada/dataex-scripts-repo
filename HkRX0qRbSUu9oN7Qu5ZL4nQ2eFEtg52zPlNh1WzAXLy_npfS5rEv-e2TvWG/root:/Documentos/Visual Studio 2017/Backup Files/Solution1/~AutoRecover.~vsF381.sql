

USE DBADataEX
SELECT * FROM dtx_tb_Queries_Profile
with (nolock)
WHERE StartTime >= '2025-04-02 09:00:00'
AND DataBaseName = 'siscoob'
ORDER BY Writes DESC

use siscoob
select top 1000 *
from sys.objects
where type = 