USE [NextBusDisplay]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StopDisplay](
    [StopNumber]    [INT] NOT NULL,
    [Show]          [BIT] NOT NULL,
    [Platform]      [INT] NULL,
    [Description]   [VARCHAR](50) NOT NULL,
    [StopID]        [VARCHAR](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[StopDisplay] ADD  CONSTRAINT [DF_StopDisplay_Description]  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[StopDisplay] ADD  CONSTRAINT [DF_StopDisplay_StopID]  DEFAULT ('') FOR [StopID]
GO
