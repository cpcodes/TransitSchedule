USE [NextBusDisplay]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlatformOverride](
    [PlatformOverrideId] [INT] IDENTITY(1,1) NOT NULL,
    [Route]              [VARCHAR](50) NOT NULL,
    [Stop]               [VARCHAR](50) NOT NULL,
    [Platform]           [VARCHAR](50) NOT NULL,
    [UseNextBusFeed]     [BIT] NULL,
    [OverrideUntil]      [SMALLDATETIME] NOT NULL,
 CONSTRAINT [PK_PlatformOverride] PRIMARY KEY CLUSTERED
(
    [PlatformOverrideId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[PlatformOverride] ADD  CONSTRAINT [DF_PlatformOverride_OverrideUntil]  DEFAULT (GETDATE()) FOR [OverrideUntil]
GO

Coaster (398|28000) never uses next bus estimates?
Next Bus Estimate Appears To Be Modal - Should Be By Route


-- All Scheduled
http://localhost:56862/Default.aspx?stops=398,28000-399,27000-Metrolink-Amtrak
http://localhost:56862/Default.aspx?stops=398,28000-399,27000-Amtrak
http://localhost:56862/Default.aspx?stops=398,28000-399,27000-Metrolink

-- split estimated & scheduled
http://localhost:56862/Default.aspx?stops=398,28000-399,27000
?stops=399,27000-398,28000-Metrolink-Amtrak

SELECT  PlatformOverrideId,
        Route, CASE WHEN Route = '398' THEN 'Coaster'
                    WHEN Route = '399' THEN 'Sprinter'
                    ELSE 'Unknown' END Name,
        Stop,
        Platform,
        CASE UseNextBusFeed WHEN 1 THEN 'Yes' ELSE 'No' END UseNextBusFeed,
        OverrideUntil
FROM PlatformOverride
ORDER BY Route, Stop

-- UPDATE PlatformOverride SET UseNextBusFeed = 1
-- UPDATE PlatformOverride SET UseNextBusFeed = 0 WHERE PlatformOverrideId = 2

SELECT GETDATE() [Now],
        CONVERT(SMALLDATETIME, DATEDIFF(d, 0, GETDATE())) Today,
        DATEDIFF(n, DATEDIFF(d, 0, GETDATE()), GETDATE()) [Day Minute]
