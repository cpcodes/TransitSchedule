SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/********************************************************************************
**** UpdateCoasterPlatform - Update The Next Scheduled Platform For The Coaster Based The Current Time
*********************************************************************************/
ALTER PROCEDURE dbo.sp_PlatformOverride
AS
-- Update The Platform Override Automatically When It Has Expired
UPDATE PlatformOverride SET Platform = 'As Scheduled'
WHERE Platform <> 'As Scheduled'
  AND GETDATE() > OverrideUntil

-- Get The Current Platform Data
SELECT PlatformOverrideId, Route, Stop, Platform, UseNextBusFeed, OverrideUntil
FROM PlatformOverride
ORDER BY Route
GO
