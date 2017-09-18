-- nctdgaov77.NextBusDisplay.dbo.StaticTrains
-- tnctdgaov11.NextBusDisplay.dbo.StaticTrains
/*
http://localhost:2448/Default.aspx?stops=399,27000-398,28000-Metrolink-Amtrak
http://localhost:2448/Admin.aspx
*/
USE NextBusDisplay
GO
SELECT * FROM (
    --SELECT TOP 1 t.Train, /*t.Days, t.Direction, t.Number, t.Platform,*/ t.DepartTime,
    --      CAST(DATEDIFF(mi, DATEDIFF(d, 0, GETDATE()), GETDATE()) AS INT) AS [CurTime],
    --      CAST(GETDATE() AS TIME) AS SysTime
    --FROM StaticTrains t
    --WHERE t.Train IN ('Sprinter')
    --  AND t.Days IN ('Mon-Thu', 'WeekDays')
    --  AND CAST(t.DepartTime AS INT) > CAST(DATEDIFF(mi, DATEDIFF(d, 0, GETDATE()), GETDATE()) AS INT)
    --UNION
    SELECT  t.Train,
            t.Days,
            -- t.Direction,
            t.Number,
            -- t.Platform,
            t.DepartTime,
            CAST(DATEADD(mi, CAST(t.DepartTime AS INT), DATEDIFF(d, 0, GETDATE())) AS TIME) AS [DepTime]
            --, CAST(DATEDIFF(mi, DATEDIFF(d, 0, GETDATE()), GETDATE()) AS INT) AS [CurTime],
            --, CAST(GETDATE() AS TIME) AS SysTime
    FROM StaticTrains t
    WHERE t.Train IN ('Coaster')
    -- WHERE Number IN (664, 672)
      -- OR DepartTime = '872'
     -- AND t.Days IN ('Mon-Thu', 'WeekDays', 'Friday')
      -- AND CAST(t.DepartTime AS INT) > CAST(DATEDIFF(mi, DATEDIFF(d, 0, GETDATE()), GETDATE()) AS INT)
) t1
ORDER BY Days, CAST(t1.DepartTime AS INT), Train

/*
SELECT * FROM StaticTrains WHERE Number IN (654, 672)
-- UPDATE StaticTrains SET DepartTime = '872' WHERE  Number = 654

SELECT MAX(StaticTrainID) MAX_ID FROM StaticTrains

SELECT (6+12)*60+35 AS '6:35pm', (9+12)*60+29 AS '9:29pm'

*/
