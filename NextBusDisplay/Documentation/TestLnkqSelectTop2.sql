--DECLARE @TestTime BIGINT, @epochTime VARCHAR(14)

--SELECT  @epochTime='1367882820000'
--SELECT @TestTime = CONVERT(BIGINT, SUBSTRING(@epochTime, 1, 10))
-- SELECT DATENAME(d, GETDATE())
-- SELECT CONVERT(DATETIME, DATEDIFF(d, 0, GETDATE()))
-- SELECT DATEDIFF(n, CONVERT(DATETIME, DATEDIFF(d, 0, GETDATE())), GETDATE())

-- SELECT DATEPART(dw, GETDATE()) DOW
--SELECT  DATEADD(s, @TestTime, '19700101 00:00:00:000') TestTimeCvtd,
--        GETUTCDATE() UTCNow,
--        DATEDIFF(s, '19700101 00:00:00:000', GETUTCDATE()) UTCTimeStamp,
--        DATEADD(s, DATEDIFF(s, '19700101 05:00:00:000', GETUTCDATE()), '19700101 05:00:00:000') UtcTimeCvtd,
--        (@TestTime - CONVERT(BIGINT, DATEDIFF(s,'19700101 00:00:00:000',GETUTCDATE())))/60 DiffMinutes

USE NextBusDisplay
GO
DECLARE @p0 VARCHAR(50) = 'Sprinter',
        @p1 INT = CONVERT(INT, DATEDIFF(n, CONVERT(DATETIME, DATEDIFF(d, 0, GETDATE())), GETDATE())),
        @p2 VARCHAR(50) = 'Escondido',
        @p3 VARCHAR(50) = '27001',
        @p4 VARCHAR(30)
SELECT @p4 = CASE DATEPART(dw, GETDATE())
             WHEN 1 THEN 'Sunday'
             WHEN 2 THEN 'Monday'
             WHEN 3 THEN 'Tuesday'
             WHEN 4 THEN 'Wednesday'
             WHEN 5 THEN 'Thursday'
             WHEN 6 THEN 'Friday'
             WHEN 7 THEN 'Saturday' END
-- SELECT @p4 = 'Friday'
DECLARE @p5 VARCHAR(30) = CASE WHEN @p4 = 'Saturday' OR @p4 = 'Sunday' THEN 'Weekends'
                               ELSE 'Weekdays' END
DECLARE @p6 VARCHAR(30) = CASE WHEN @p5 = 'WeekDays' AND  @p4 <> 'Friday' THEN 'Mo-Th'
                               WHEN @p4 = 'Friday' THEN 'Fri-Sun'
                               ELSE 'Fri-Sun' END
-- Sprinter End Points SELECT @p3 = '27000' -- '27014'
-- Coaster Test SELECT @p0 = 'Coaster', @p2 = 'San Diego', @p3 = '28001'
-- Coaster End Points SELECT @p3 = '28000' -- '28007'

-- Show The Current Calculated Values
SELECT @p0 [train], @p1 [minute], (RIGHT('0' + CONVERT(VARCHAR,FLOOR(@p1/60)), 2) + ':' + RIGHT('0' + CONVERT(VARCHAR, @p1 - (FLOOR(@p1/60)*60)), 2)) AS [Time], @p4 [Day], @p5 [Week], @p6 [WorkDays], GETDATE() [now]

SELECT TOP (2) [t0].[StaticTrainId], [t0].[Train], [t0].[Number], [t0].[Direction],
        [t0].[DepartTime],
        (RIGHT('0' + CONVERT(VARCHAR,FLOOR(DepartTime/60)), 2) + ':' + RIGHT('0' + CONVERT(VARCHAR, DepartTime - (FLOOR(DepartTime/60)*60)), 2)) AS [Depart Time],
        CONVERT(INT, [t0].[DepartTime]) - @p1 [Minutes],
        [t0].[Platform], [t0].[Days], [t0].[StopID]
FROM [dbo].[StaticTrains] AS [t0]
WHERE ([t0].[Train] = @p0)
  AND ((CONVERT(Int,[t0].[DepartTime])) >= @p1)
  AND ([t0].[Direction] = @p2)
  AND ([t0].[StopID] = @p3)
  AND ([t0].[Days] IN (@p4, @p5, @p6))
ORDER BY CONVERT(Int,[t0].[DepartTime])

SELECT @p2 = 'Oceanside'

SELECT TOP (2) [t0].[StaticTrainId], [t0].[Train], [t0].[Number], [t0].[Direction],
        [t0].[DepartTime],
        (RIGHT('0' + CONVERT(VARCHAR,FLOOR(DepartTime/60)),2) + ':' + RIGHT('0' + CONVERT(VARCHAR, DepartTime - (FLOOR(DepartTime/60)*60)), 2)) AS [Depart Time],
        CONVERT(INT, [t0].[DepartTime]) - @p1 [Minutes],
        [t0].[Platform], [t0].[Days], [t0].[StopID]
FROM [dbo].[StaticTrains] AS [t0]
WHERE ([t0].[Train] = @p0)
  AND ((CONVERT(Int,[t0].[DepartTime])) >= @p1)
  AND ([t0].[Direction] = @p2)
  AND ([t0].[StopID] = @p3)
  AND ([t0].[Days] IN (@p4, @p5, @p6))
ORDER BY CONVERT(Int,[t0].[DepartTime])

