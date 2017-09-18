USE NextBusDisplay
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/********************************************************************************
** vw_PlatformOverride - Add Stop Characteristics To The Platform Override Table
*********************************************************************************/
ALTER VIEW dbo.vw_PlatformOverride
AS

SELECT
       o.Route,
       o.Stop,
       s.Description AS [Stop_Descr],
       o.Platform,
       o.UseNextBusFeed,
       o.PlatformOverrideId
FROM PlatformOverride o
    INNER JOIN StopDisplay s (NOLOCK) ON o.Stop = s.StopID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
