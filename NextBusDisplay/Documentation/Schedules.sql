http://localhost/TransitSchedule/Default.aspx?stops=399,27000-398,28000-Metrolink-Amtrak
http://localhost/TransitSchedule/Default.aspx?stops=399,27000-399,27001
-- Debug
http://localhost:56862/Default.aspx?stops=399,27001

SELECT Number, Direction, [DepartTime], [Depart Time], Platform, Days
FROM (
SELECT -- DISTINCT --[StaticTrainId],
      [Train],
      [Number],
      [Direction],
      [DepartTime],
      (RIGHT('0' + CONVERT(VARCHAR,FLOOR(DepartTime/60)),2) + ':' + RIGHT('0' + CONVERT(VARCHAR, DepartTime - (FLOOR(DepartTime/60)*60)), 2)) AS [Depart Time],
      [Platform],
      [Days]
  FROM [NextBusDisplay].[dbo].[StaticTrains]
-- WHERE Train = 'Amtrak'
--WHERE Train = 'Coaster'
  -- AND Days IN ('Saturday', 'Sunday', 'Weekends', 'Friday')
-- WHERE Train = 'Metrolink'
--
WHERE Train = 'Sprinter'
 --  WHERE Number IN (564, 579, 644)
 -- WHERE Number IN (635, 644, 564, 664, 671, 672, 675, 690, 696, 691, 579)
--     OR DepartTime  IN (635, 644, 564, 664, 671, 672, 675, 690, 696, 691, 579)
) t1 ORDER BY Days, CAST(DepartTime AS INT), Train DESC, Number
--  ORDER BY Train DESC, Days, Number
-- ORDER BY CAST(DepartTime AS INT), Train DESC, Days, Number

/*
SELECT DISTINCT Train FROM [NextBusDisplay].[dbo].[StaticTrains]
-- DELETE FROM [NextBusDisplay].[dbo].[StaticTrains] WHERE [StaticTrainId]=139
SELECT MAX(StaticTrainID) FROM [NextBusDisplay].[dbo].[StaticTrains]


-- NOTE: Datafeed  epochTime Is In Milliseconds Since "1/1/1970 00:00:00.000"- Use Left(epochTime, 10) To Calculate UTCTime
-- Compute DateTime From Epoch Time
DECLARE @TestTime BIGINT, @epochTime VARCHAR(14)

SELECT  @epochTime='1367882820000'
SELECT @TestTime = CONVERT(BIGINT, SUBSTRING(@epochTime, 1, 10))

SELECT  DATEADD(s, @TestTime, '19700101 00:00:00:000') TestTimeCvtd,
        GETUTCDATE() UTCNow,
        DATEDIFF(s, '19700101 00:00:00:000', GETUTCDATE()) UTCTimeStamp,
        DATEADD(s, DATEDIFF(s, '19700101 05:00:00:000', GETUTCDATE()), '19700101 05:00:00:000') UtcTimeCvtd,
        (@TestTime - CONVERT(BIGINT, DATEDIFF(s,'19700101 00:00:00:000',GETUTCDATE())))/60 DiffMinutes

*/

