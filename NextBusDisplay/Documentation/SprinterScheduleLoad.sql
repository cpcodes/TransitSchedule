USE [NextBusDisplay]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************
**      Author: Dave Vroman
** Description: Update / Insert Schedules From The NextBus XML Feed
** Must Do A Delete Schedule / Insert Schedule - There Is No Unique Set Of Flags In The Data
Remove BlockID? Yes
Add RunID (Counter Of Runs In This Direction Today)
Add Hr? Which Would Make It Unique. But A Small Change Around The Hour Split Would Change This Value Too And Make It Not Updateable
*********************************************************************************/
ALTER PROCEDURE [dbo].[UpSertSchedule](
    @Train       VARCHAR(50),
    @Number      VARCHAR(50),
    @Direction   VARCHAR(50),
    -- @BlockID     VARCHAR(50),
    @StopID      VARCHAR(50),
    @DepartHr    VARCHAR(50),
    @DepartMin   VARCHAR(50),
    @Platform    VARCHAR(50),
    @Days        VARCHAR(50)
)
AS
DECLARE @IntTime AS INTEGER, @ID BIGINT
SELECT @IntTime = CONVERT(INT, @DepartHr) * 60 + CONVERT(INT, @DepartMin)

--UPDATE StaticTrains
--    SET DepartTime = CONVERT(VARCHAR, @IntTime),
--        Direction  = @Direction
--WHERE Train = @Train
--  AND Number = @Number
--  AND [Days] = @Days
--  AND BlockID = @BlockID
--  AND StopID = @StopID

--IF @@ROWCOUNT = 0 BEGIN
    SELECT @ID = MAX(StaticTrainId) + 1 FROM StaticTrains

    INSERT INTO StaticTrains
    (StaticTrainId, Train, Number, Direction, DepartTime, [Platform], [Days], BlockID, StopID) VALUES
    (@ID, @Train, @Number, @Direction, CONVERT(VARCHAR, @IntTime), '', @Days, @BlockID, @StopID)
--END
--ELSE
--    PRINT 'Updated ' + @Train + @Number + @Days + @BlockID + @StopID
--    -- This Should Not Happen On The First Pass

GO


USE NextBusDisplay
GO
DELETE FROM StaticTrains WHERE Number = '398'
--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Friday" direction="Oceanside">
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007', '06','30', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006', '06','36', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005', '06','57', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004', '07','06', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003', '07','11', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002', '07','19', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001', '07','27', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar', '07','32', '','Friday'
    -- <tr blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'   , '07', '46', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'   , '07', '52', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'   , '08', '15', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'   , '08', '24', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'   , '08', '29', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'   , '08', '35', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'   , '08', '42', '','Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar', '08', '48', '','Friday'
--    <tr blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '09', '48', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '09', '54', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '10', '14', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '10', '23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '10', '31', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '10', '37', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '10', '43', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '10', '50', '', 'Friday'
--    <tr blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '12', '38', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '12', '45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '13', '05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '13', '15', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '13', '24', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '13', '30', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '13', '37', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '13', '43', '', 'Friday'
--    <tr blockID='39803'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '14', '16', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '14', '22', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '14', '42', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '14', '52', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '15', '01', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '15', '07', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '15', '14', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '15', '19', '', 'Friday'
--    <tr blockID='39804'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '15', '45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '15', '51', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '16', '12', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '16', '23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '16', '29', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '16', '35', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '16', '42', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '16', '48', '', 'Friday'
--    <tr blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '16', '27', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '16', '34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '16', '54', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '17', '05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '17', '11', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '17', '17', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '17', '23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '17', '29', '', 'Friday'
--    <tr blockID='39802'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '16', '52', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '16', '58', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '17', '19', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '17', '28', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '17', '34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '17', '44', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '17', '50', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '17', '54', '', 'Friday'
--    <tr blockID='39803'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '17', '34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '17', '40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '18', '02', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '18', '12', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '18', '18', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '18', '23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '18', '32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '18', '37', '', 'Friday'
--    <tr blockID='39804'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '18', '25', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '18', '32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '18', '52', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '19', '02', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '19', '07', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '19', '13', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '19', '19', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '19', '26', '', 'Friday'
--    <tr blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '19', '10', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '19', '16', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '19', '36', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '19', '46', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '19', '53', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '19', '59', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '20', '05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '20', '12', '', 'Friday'
--    <tr blockID='39805'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '20', '15', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '20', '20', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '20', '40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '20', '48', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '20', '56', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '21', '02', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '21', '09', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '21', '15', '', 'Friday'
--    <tr blockID='39805'>
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28007'      , '22', '45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28006'      , '22', '50', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28005'      , '23', '10', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28004'      , '23', '18', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28003'      , '23', '26', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28002'      , '23', '32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28001'      , '23', '39', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'Oceanside', '28000_ar'   , '23', '45', '', 'Friday'

-- SouthBound
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '05','15', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '05','19', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '05','25', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '05','31', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '05','37', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '05','46', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '06','07', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '06','15', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '06','00', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '06','05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '06','11', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '06','17', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '06','23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '06','32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '06','53', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '07','00', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '06','41', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '06','45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '06','51', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '06','58', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '07','04', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '07','14', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '07','34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '07','42', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '07','19', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '07','23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '07','29', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '07','35', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '07','41', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '07','51', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '08','14', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '08','20', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '07','42', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '07','47', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '07','53', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '07','58', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '08','05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '08','15', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '08','38', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '08','45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '09','39', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '09','44', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '09','50', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '09','55', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '10','01', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '10','11', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '10','32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '10','41', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '11','05', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '11','10', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '11','16', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '11','23', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '11','29', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '11','39', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '11','59', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '12','06', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '14','32', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '14','37', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '14','43', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '14','49', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '14','54', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '15','04', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '15','28', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '15','36', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '15','34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '15','40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '15','47', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '15','54', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '16','00', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '16','10', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '16','31', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '16','37', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '17','04', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '17','09', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '17','16', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '17','21', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '17','29', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '17','40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '18','00', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '18','07', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '17','40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '17','45', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '17','51', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '17','57', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '18','03', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '18','17', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '18','39', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '18','46', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '18','35', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '18','40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '18','46', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '18','52', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '19','02', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '19','12', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '19','33', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '19','41', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000',     '21','29', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001',     '21','34', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002',     '21','40', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003',     '21','46', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004',     '21','51', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005',     '22','01', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006',     '22','22', '', 'Friday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar',  '22','30', '', 'Friday'


EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '06','30', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '06','36', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '06','57', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '07','06', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '07','11', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '07','19', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '07','27', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '07','32', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '07','46', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '07','52', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '08','15', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '08','24', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '08','29', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '08','35', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '08','42', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '08','48', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '09','48', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '09','54', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '10','14', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '10','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '10','31', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '10','37', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '10','43', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '10','50', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '12','38', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '12','45', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '13','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '13','15', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '13','24', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '13','30', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '13','37', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '13','43', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '14','16', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '14','22', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '14','42', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '14','52', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '15','01', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '15','07', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '15','14', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '15','19', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '15','45', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '15','51', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '16','12', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '16','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '16','29', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '16','35', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '16','42', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '16','48', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '16','27', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '16','34', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '16','54', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '17','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '17','11', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '17','17', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '17','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '17','29', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '16','52', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '16','58', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '17','19', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '17','28', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '17','34', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '17','44', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '17','50', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '17','54', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '17','34', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '17','40', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '18','02', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '18','12', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '18','18', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '18','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '18','32', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '18','37', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '18','25', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '18','32', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '18','52', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '19','02', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '19','07', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '19','13', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '19','19', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '19','26', '', 'Monday'

EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'        , '19','10', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'        , '19','16', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'        , '19','36', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'        , '19','46', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'        , '19','53', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'        , '19','59', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'        , '20','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'     , '20','12', '', 'Monday'

-- SELECT * FROM StaticTrains WHERE Number = '398'
-- DELETE FROM StaticTrains WHERE Number = '398'

--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Monday" direction="San Diego">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '05','15', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '05','19', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '05','25', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '05','31', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '05','37', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '05','46', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '06','07', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '06','15', '', 'Monday'

    --  blockID='39802'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '06','00', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '06','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '06','11', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '06','17', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '06','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '06','32', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '06','53', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '07','00', '', 'Monday'

    --  blockID='39803'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '06','41', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '06','45', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '06','51', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '06','58', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '07','04', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '07','14', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '07','34', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '07','42', '', 'Monday'

    --  blockID='39804'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '07','19', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '07','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '07','29', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '07','35', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '07','41', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '07','51', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '08','14', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '08','20', '', 'Monday'

    --  blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '07','42', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '07','47', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '07','53', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '07','58', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '08','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '08','15', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '08','38', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '08','45', '', 'Monday'

    --  blockID='39802'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '09','39', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '09','44', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '09','50', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '09','55', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '10','01', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '10','11', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '10','32', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '10','41', '', 'Monday'

    --  blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '11','05', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '11','10', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '11','16', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '11','23', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '11','29', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '11','39', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '11','59', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '12','06', '', 'Monday'

    --  blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '14','32', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '14','37', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '14','43', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '14','49', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '14','54', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '15','04', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '15','28', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '15','36', '', 'Monday'

    --  blockID='39803'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '15','34', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '15','40', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '15','47', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '15','54', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '16','00', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '16','10', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '16','31', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '16','37', '', 'Monday'

    --  blockID='39804'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '17','04', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '17','09', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '17','16', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '17','21', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '17','29', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '17','40', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '18','00', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '18','07', '', 'Monday'

    --  blockID='39801'>
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'    ,  '17','40', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'    ,  '17','45', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'    ,  '17','51', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'    ,  '17','57', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'    ,  '18','03', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'    ,  '18','17', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'    ,  '18','39', '', 'Monday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar' ,  '18','46', '', 'Monday'

--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Saturday" direction="Oceanside">
    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'09','48', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'09','54', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'10','17', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'10','25', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'10','31', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'10','36', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'10','43', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'10','51', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'12','27', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'12','33', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'12','54', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'13','02', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'13','08', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'13','14', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'13','22', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'13','28', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'15','18', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'15','25', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'15','47', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'15','56', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'16','02', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'16','08', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'16','15', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'16','20', '', 'Saturday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'17','00', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'17','06', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'17','26', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','37', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','43', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','48', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','55', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'18','03', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'18','45', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'18','52', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'19','13', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','24', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','30', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','35', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'19','42', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'19','48', '', 'Saturday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'22','45', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'22','50', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'23','10', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'23','18', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'23','26', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'23','32', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'23','39', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'23','45', '', 'Saturday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Saturday" direction="San Diego">
    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'08','36', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'08','41', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'08','47', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'08','53', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'08','59', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'09','09', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'09','30', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'09','36', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'11','07', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'11','12', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'11','18', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'11','24', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'11','30', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'11','40', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'12','02', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'12','10', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'13','50', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'13','55', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'14','01', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'14','07', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'14','13', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'14','23', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'14','45', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'14','53', '', 'Saturday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'15','34', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'15','39', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'15','45', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'15','51', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'15','57', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'16','07', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'16','28', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'16','34', '', 'Saturday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','15', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','20', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','26', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','32', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'17','38', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'17','48', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','09', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','17', '', 'Saturday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'18','35', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'18','40', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'18','46', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'18','52', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'18','59', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'19','10', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'19','31', '', 'Saturday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'19','37', '', 'Saturday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Sunday" direction="Oceanside">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'09','48', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'09','54', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'10','17', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'10','25', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'10','31', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'10','36', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'10','43', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'10','51', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'12','27', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'12','33', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'12','54', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'13','02', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'13','08', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'13','14', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'13','22', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'13','28', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'15','18', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'15','25', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'15','47', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'15','56', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'16','02', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'16','08', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'16','15', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'16','20', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'18','45', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'18','52', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'19','13', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','24', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','30', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','35', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'19','42', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'19','48', '', 'Sunday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Sunday" direction="San Diego">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'08','36', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'08','41', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'08','47', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'08','53', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'08','59', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'09','09', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'09','30', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'09','36', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'11','07', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'11','12', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'11','18', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'11','24', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'11','30', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'11','40', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'12','02', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'12','10', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'13','50', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'13','55', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'14','01', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'14','07', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'14','13', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'14','23', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'14','45', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'14','53', '', 'Sunday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','15', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','20', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','26', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','32', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'17','38', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'17','48', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','09', '', 'Sunday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','17', '', 'Sunday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Thursday" direction="Oceanside">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'06','30', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'06','36', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'06','57', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'07','06', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'07','11', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'07','19', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'07','27', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'07','32', '', 'Thursday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'07','46', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'07','52', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'08','15', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'08','24', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'08','29', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'08','35', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'08','42', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'08','48', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'09','48', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'09','54', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'10','14', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'10','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'10','31', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'10','37', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'10','43', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'10','50', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'12','38', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'12','45', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'13','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'13','15', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'13','24', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'13','30', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'13','37', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'13','43', '', 'Thursday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'14','16', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'14','22', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'14','42', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'14','52', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'15','01', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'15','07', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'15','14', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'15','19', '', 'Thursday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'15','45', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'15','51', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','12', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'16','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'16','29', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'16','35', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'16','42', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'16','48', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','27', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','34', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','54', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','11', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','17', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','29', '', 'Thursday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','52', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','58', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'17','19', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','28', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','34', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','44', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','50', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','54', '', 'Thursday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'17','34', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'17','40', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','02', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'18','12', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'18','18', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'18','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'18','32', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'18','37', '', 'Thursday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'18','25', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'18','32', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','52', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','02', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','07', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','13', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'19','19', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'19','26', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'19','10', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'19','16', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'19','36', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','46', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','53', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','59', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'20','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'20','12', '', 'Thursday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Thursday" direction="San Diego">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'05','15', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'05','19', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'05','25', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'05','31', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'05','37', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'05','46', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','07', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'06','15', '', 'Thursday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','00', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','11', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','17', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'06','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'06','32', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','53', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','00', '', 'Thursday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','41', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','45', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','51', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','58', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','04', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','14', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'07','34', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','42', '', 'Thursday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','19', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','29', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','35', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','41', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','51', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','14', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','20', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','42', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','47', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','53', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','58', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'08','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'08','15', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','38', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','45', '', 'Thursday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'09','39', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'09','44', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'09','50', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'09','55', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'10','01', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'10','11', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'10','32', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'10','41', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'11','05', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'11','10', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'11','16', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'11','23', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'11','29', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'11','39', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'11','59', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'12','06', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'14','32', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'14','37', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'14','43', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'14','49', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'14','54', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'15','04', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'15','28', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'15','36', '', 'Thursday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'15','34', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'15','40', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'15','47', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'15','54', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'16','00', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'16','10', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'16','31', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'16','37', '', 'Thursday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','04', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','09', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','16', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','21', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'17','29', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'17','40', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','00', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','07', '', 'Thursday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','40', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','45', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','51', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','57', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'18','03', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'18','17', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','39', '', 'Thursday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','46', '', 'Thursday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Tuesday" direction="Oceanside">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'06','30', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'06','36', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'06','57', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'07','06', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'07','11', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'07','19', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'07','27', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'07','32', '', 'Tuesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'07','46', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'07','52', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'08','15', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'08','24', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'08','29', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'08','35', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'08','42', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'08','48', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'09','48', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'09','54', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'10','14', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'10','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'10','31', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'10','37', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'10','43', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'10','50', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'12','38', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'12','45', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'13','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'13','15', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'13','24', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'13','30', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'13','37', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'13','43', '', 'Tuesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'14','16', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'14','22', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'14','42', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'14','52', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'15','01', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'15','07', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'15','14', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'15','19', '', 'Tuesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'15','45', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'15','51', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','12', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'16','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'16','29', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'16','35', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'16','42', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'16','48', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','27', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','34', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','54', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','11', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','17', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','29', '', 'Tuesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','52', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','58', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'17','19', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','28', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','34', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','44', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','50', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','54', '', 'Tuesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'17','34', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'17','40', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','02', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'18','12', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'18','18', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'18','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'18','32', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'18','37', '', 'Tuesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'18','25', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'18','32', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','52', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','02', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','07', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','13', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'19','19', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'19','26', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'19','10', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'19','16', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'19','36', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','46', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','53', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','59', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'20','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'20','12', '', 'Tuesday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Tuesday" direction="San Diego">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'05','15', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'05','19', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'05','25', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'05','31', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'05','37', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'05','46', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','07', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'06','15', '', 'Tuesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','00', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','11', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','17', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'06','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'06','32', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','53', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','00', '', 'Tuesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','41', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','45', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','51', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','58', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','04', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','14', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'07','34', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','42', '', 'Tuesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','19', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','29', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','35', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','41', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','51', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','14', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','20', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','42', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','47', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','53', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','58', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'08','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'08','15', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','38', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','45', '', 'Tuesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'09','39', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'09','44', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'09','50', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'09','55', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'10','01', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'10','11', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'10','32', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'10','41', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'11','05', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'11','10', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'11','16', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'11','23', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'11','29', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'11','39', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'11','59', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'12','06', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'14','32', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'14','37', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'14','43', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'14','49', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'14','54', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'15','04', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'15','28', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'15','36', '', 'Tuesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'15','34', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'15','40', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'15','47', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'15','54', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'16','00', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'16','10', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'16','31', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'16','37', '', 'Tuesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','04', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','09', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','16', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','21', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'17','29', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'17','40', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','00', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','07', '', 'Tuesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','40', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','45', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','51', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','57', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'18','03', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'18','17', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','39', '', 'Tuesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','46', '', 'Tuesday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Wednesday" direction="Oceanside">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'06','30', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'06','36', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'06','57', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'07','06', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'07','11', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'07','19', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'07','27', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'07','32', '', 'Wednesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'07','46', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'07','52', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'08','15', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'08','24', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'08','29', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'08','35', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'08','42', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'08','48', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'09','48', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'09','54', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'10','14', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'10','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'10','31', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'10','37', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'10','43', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'10','50', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'12','38', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'12','45', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'13','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'13','15', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'13','24', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'13','30', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'13','37', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'13','43', '', 'Wednesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'14','16', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'14','22', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'14','42', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'14','52', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'15','01', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'15','07', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'15','14', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'15','19', '', 'Wednesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'15','45', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'15','51', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','12', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'16','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'16','29', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'16','35', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'16','42', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'16','48', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','27', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','34', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'16','54', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','11', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','17', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','29', '', 'Wednesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'16','52', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'16','58', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'17','19', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'17','28', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'17','34', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'17','44', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'17','50', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'17','54', '', 'Wednesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'17','34', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'17','40', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','02', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'18','12', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'18','18', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'18','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'18','32', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'18','37', '', 'Wednesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'18','25', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'18','32', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'18','52', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','02', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','07', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','13', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'19','19', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'19','26', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28007'         ,'19','10', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28006'         ,'19','16', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28005'         ,'19','36', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28004'         ,'19','46', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28003'         ,'19','53', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28002'         ,'19','59', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28001'         ,'20','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'OceanSide', '28000_ar'      ,'20','12', '', 'Wednesday'


--  <route tag="398" title="Coaster" scheduleClass="20130401" serviceClass="Wednesday" direction="San Diego">
    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'05','15', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'05','19', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'05','25', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'05','31', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'05','37', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'05','46', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','07', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'06','15', '', 'Wednesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','00', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','11', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','17', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'06','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'06','32', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'06','53', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','00', '', 'Wednesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'06','41', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'06','45', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'06','51', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'06','58', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','04', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','14', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'07','34', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'07','42', '', 'Wednesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','19', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','29', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','35', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'07','41', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'07','51', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','14', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','20', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'07','42', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'07','47', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'07','53', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'07','58', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'08','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'08','15', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'08','38', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'08','45', '', 'Wednesday'

    -- blockID="39802">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'09','39', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'09','44', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'09','50', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'09','55', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'10','01', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'10','11', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'10','32', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'10','41', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'11','05', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'11','10', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'11','16', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'11','23', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'11','29', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'11','39', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'11','59', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'12','06', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'14','32', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'14','37', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'14','43', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'14','49', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'14','54', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'15','04', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'15','28', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'15','36', '', 'Wednesday'

    -- blockID="39803">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'15','34', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'15','40', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'15','47', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'15','54', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'16','00', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'16','10', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'16','31', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'16','37', '', 'Wednesday'

    -- blockID="39804">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','04', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','09', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','16', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','21', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'17','29', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'17','40', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','00', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','07', '', 'Wednesday'

    -- blockID="39801">
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28000'         ,'17','40', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28001'         ,'17','45', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28002'         ,'17','51', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28003'         ,'17','57', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28004'         ,'18','03', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28005'         ,'18','17', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28006'         ,'18','39', '', 'Wednesday'
EXEC UpSertSchedule 'Coaster', '398', 'San Diego', '28007_ar'      ,'18','46', '', 'Wednesday'
