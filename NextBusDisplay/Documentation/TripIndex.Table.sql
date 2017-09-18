-- x "h:\My Documents\Visual Studio 2012\Projects\NextBusScheduleImport\Documentation\TripIndex.table.sql"

USE [Test]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[TripIndex](
    [indx]          INT IDENTITY(1,1) NOT NULL,
    [route_id]      VARCHAR(50) NOT NULL,       -- [dbo].[routes].[route_id]            [dbo].[trips-nextbus]
    [trip_id]       VARCHAR(50) NOT NULL,       -- [dbo].[trips-nextbus].[trip_id]      [dbo].[stop_times]
    [service_id]    VARCHAR(50) NOT NULL,       -- [dbo].[calendar]                     [dbo].[trips-nextbus]                [dbo].[trips]
    [Number]        VARCHAR(50) NOT NULL,       -- [dbo].[StaticTrains].[Number]                        -- This Is The Value I Want To Save - Could Be Number Assigned To Hardware
    [StaticTrainId] INT NOT NULL,               -- [dbo].[StaticTrains].[StaticTrainId]
 CONSTRAINT [PK_TripIndex] PRIMARY KEY CLUSTERED
(
    [indx] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[TripIndex] ADD  CONSTRAINT [DF_TripIndex_route_id]  DEFAULT ('') FOR [route_id]
GO
ALTER TABLE [dbo].[TripIndex] ADD  CONSTRAINT [DF_TripIndex_trip_id]  DEFAULT ('') FOR [trip_id]
GO
ALTER TABLE [dbo].[TripIndex] ADD  CONSTRAINT [DF_TripIndex_Number]  DEFAULT ('') FOR [Number]
GO
ALTER TABLE [dbo].[TripIndex] ADD  CONSTRAINT [DF_TripIndex_StaticTrainId]  DEFAULT ((0)) FOR [StaticTrainId]
GO


UPDATE StaticTrains SET StopID = '28000' WHERE Train = 'Coaster'
UPDATE StaticTrains SET StopID = '27000' WHERE Train = 'Sprinter'
UPDATE StaticTrains SET Direction = 'Escondido', Number = '' WHERE Train = 'Sprinter'
UPDATE StaticTrains SET Platform = 'Sprinter Platform' WHERE Train = 'Sprinter'
UPDATE StaticTrains SET Direction = 'San Diego' WHERE Train = 'Coaster'

-- Convert WeekDays / Weekends For Next Bus Import Of Sprinter And Coaster
DECLARE
    @StaticTrainId INT,
    @Train VARCHAR(50),
    @Number VARCHAR(50),
    @Direction VARCHAR(50),
    @DepartTime VARCHAR(50),
    @Platform VARCHAR(50),
    @Days VARCHAR(50),
    @TrainID VARCHAR(50),
    @StopID VARCHAR(50),
    @Srch VARCHAR(50)
--  SELECT @days = 'Monday'   , @Srch = 'Weekdays'    -- @Srch =  'Mo-Th'
--  SELECT @days = 'Tuesday'  , @Srch = 'Weekdays'    -- @Srch =  'Mo-Th'
--  SELECT @days = 'Wednesday', @Srch = 'Weekdays'    -- @Srch =  'Mo-Th'
--  SELECT @days = 'Thursday' , @Srch = 'Weekdays'    -- @Srch =  'Mo-Th'

--  SELECT @days = 'Friday'   , @Srch = 'Weekdays'    -- @Srch =  'Fri-Sun'

--  SELECT @days = 'Saturday' , @Srch = 'Weekends'    -- @Srch =  'Fri-Sun'
--  SELECT @days = 'Sunday'   , @Srch = 'Weekends'    -- @Srch =  'Fri-Sun'

    DECLARE curDupTrains CURSOR FAST_FORWARD READ_ONLY FOR
SELECT Train,  Number, Direction, DepartTime, [Platform], TrainID, StopID
FROM [dbo].[StaticTrains]
WHERE train = 'coaster'
  AND Days = @Srch
    -- 'Weekends'
OPEN curDupTrains

FETCH NEXT FROM curDupTrains INTO @Train, @Number, @Direction, @DepartTime, @Platform, @TrainID, @StopID

WHILE @@FETCH_STATUS = 0 BEGIN
    SELECT @StaticTrainID = MAX([StaticTrainId]) + 1 FROM StaticTrains
    INSERT INTO StaticTrains (StaticTrainID, Train,  Number, Direction, DepartTime, [Platform], TrainID, StopID, BlockID, Days)
    VALUES (@StaticTrainID, @Train, @Number, @Direction, @DepartTime, @Platform, @TrainID, @StopID, '', @Days)

    FETCH NEXT FROM curDupTrains INTO @Train, @Number, @Direction, @DepartTime, @Platform, @TrainID, @StopID
END

CLOSE curDupTrains
DEALLOCATE curDupTrains
-- DELETE FROM StaticTrains WHERE Days IN ('WeekDays', 'WeekEnds') AND train IN ('coaster', 'sprinter')


/*
SELECT * FROM StaticTrains WHERE DepartTime = '315'

INSERT INTO TripIndex  (
    route_id     , -- dbo.routes.route_id            dbo.trips-nextbus
    trip_id      , -- dbo.trips-nextbus.trip_id      dbo.stop_times
    service_id   , -- dbo.calendar                     dbo.trips-nextbus                dbo.trips
    Number       , -- dbo.StaticTrains.Number                        -- This Is The Value I Want To Save - Could Be Number Assigned To Hardware
    StaticTrainId  -- dbo.StaticTrains.StaticTrainId
) VALUES (
'399',
'9158575',
'C_WDSCHoff',
'630',
-- 147)
-- 192)
-- 282)
-- 327)
-- 237)
*/
SELECT * FROM TRipindex
-- TRUNCATE TABLE TripIndex
SELECT *
FROM TripIndex i
    INNER JOIN trips t ON i.trip_id = t.trip_id
    INNER JOIN StaticTrains s ON i.StaticTrainId = s.StaticTrainId



