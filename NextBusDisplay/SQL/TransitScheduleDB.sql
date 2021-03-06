USE [NextBusDisplay]
GO
/****** Object:  User [ExtPrg]    Script Date: 09/22/2017 12:59:40 ******/
CREATE USER [ExtPrg] FOR LOGIN [ExtPrg] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblHoliDate]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblHoliDate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Holiday] [date] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[DOW] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StopDisplay]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StopDisplay](
	[StopNumber] [int] NOT NULL,
	[Show] [bit] NOT NULL,
	[Platform] [int] NULL,
	[Description] [varchar](50) NOT NULL,
	[StopID] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StaticTrains_test]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StaticTrains_test](
	[StaticTrainId] [int] IDENTITY(1,1) NOT NULL,
	[Train] [varchar](50) NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[Direction] [varchar](50) NOT NULL,
	[DepartTime] [varchar](50) NOT NULL,
	[Platform] [varchar](50) NOT NULL,
	[Days] [varchar](50) NOT NULL,
	[TrainID] [varchar](50) NOT NULL,
	[BlockID] [varchar](50) NOT NULL,
	[StopID] [varchar](50) NOT NULL,
	[stop_sequence] [int] NOT NULL,
	[Trip_id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_StaticTrains_test] PRIMARY KEY CLUSTERED 
(
	[StaticTrainId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StaticTrains]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StaticTrains](
	[StaticTrainId] [int] NOT NULL,
	[Train] [varchar](50) NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[Direction] [varchar](50) NOT NULL,
	[DepartTime] [varchar](50) NOT NULL,
	[Platform] [varchar](50) NOT NULL,
	[Days] [varchar](50) NOT NULL,
	[TrainID] [varchar](50) NOT NULL,
	[BlockID] [varchar](50) NOT NULL,
	[StopID] [varchar](50) NOT NULL,
	[stop_sequence] [int] NOT NULL,
	[Trip_id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_StaticTrains] PRIMARY KEY CLUSTERED 
(
	[StaticTrainId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StaticTrainOverride]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaticTrainOverride](
	[StaticTrainOverrideId] [int] IDENTITY(1,1) NOT NULL,
	[StaticTrainId] [int] NOT NULL,
	[ShowSchedule] [bit] NOT NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_StaticTrainOverride] PRIMARY KEY CLUSTERED 
(
	[StaticTrainOverrideId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceNotice]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceNotice](
	[AutoID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceNoticeID] [varchar](20) NOT NULL,
	[DisplayText] [varchar](8000) NOT NULL,
	[DisplayFrom] [date] NOT NULL,
	[DisplayTo] [date] NOT NULL,
 CONSTRAINT [PK_ServiceNotice] PRIMARY KEY CLUSTERED 
(
	[AutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlatformOverride]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlatformOverride](
	[PlatformOverrideId] [int] IDENTITY(1,1) NOT NULL,
	[Route] [varchar](50) NOT NULL,
	[Stop] [varchar](50) NOT NULL,
	[Platform] [varchar](50) NOT NULL,
	[UseNextBusFeed] [bit] NULL,
	[OverrideUntil] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_PlatformOverride] PRIMARY KEY CLUSTERED 
(
	[PlatformOverrideId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlatformDisplay]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlatformDisplay](
	[PlatformDisplayId] [int] NOT NULL,
	[Route] [varchar](50) NULL,
	[Stop] [varchar](50) NULL,
	[Platform] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AmtrakNos]    Script Date: 09/22/2017 12:59:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AmtrakNos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Number] [varchar](50) NOT NULL,
	[WkDays] [varchar](50) NOT NULL,
	[Depart] [varchar](50) NOT NULL,
	[Direction] [varchar](50) NOT NULL,
	[Departure] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__AmtrakNos__Depar__3F466844]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[AmtrakNos] ADD  DEFAULT ('') FOR [Departure]
GO
/****** Object:  Default [DF_PlatformOverride_OverrideUntil]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[PlatformOverride] ADD  CONSTRAINT [DF_PlatformOverride_OverrideUntil]  DEFAULT (getdate()) FOR [OverrideUntil]
GO
/****** Object:  Default [DF_ServiceNotice2_ServiceNoticeID]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[ServiceNotice] ADD  CONSTRAINT [DF_ServiceNotice2_ServiceNoticeID]  DEFAULT (' ') FOR [ServiceNoticeID]
GO
/****** Object:  Default [DF_ServiceNotice2_DisplayText]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[ServiceNotice] ADD  CONSTRAINT [DF_ServiceNotice2_DisplayText]  DEFAULT (' ') FOR [DisplayText]
GO
/****** Object:  Default [DF_ServiceNotice2_DisplayFrom]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[ServiceNotice] ADD  CONSTRAINT [DF_ServiceNotice2_DisplayFrom]  DEFAULT (getdate()) FOR [DisplayFrom]
GO
/****** Object:  Default [DF_ServiceNotice2_DisplayTo]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[ServiceNotice] ADD  CONSTRAINT [DF_ServiceNotice2_DisplayTo]  DEFAULT (getdate()) FOR [DisplayTo]
GO
/****** Object:  Default [DF__StaticTra__Train__29572725]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains] ADD  DEFAULT ('') FOR [TrainID]
GO
/****** Object:  Default [DF__StaticTra__Block__2A4B4B5E]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains] ADD  DEFAULT ('') FOR [BlockID]
GO
/****** Object:  Default [DF__StaticTra__StopI__2B3F6F97]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains] ADD  DEFAULT ('') FOR [StopID]
GO
/****** Object:  Default [DF__StaticTra__stop___2C3393D0]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains] ADD  DEFAULT ((0)) FOR [stop_sequence]
GO
/****** Object:  Default [DF__StaticTra__Trip___2D27B809]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains] ADD  DEFAULT ('') FOR [Trip_id]
GO
/****** Object:  Default [DF__StaticTra__Train__300424B4]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains_test] ADD  DEFAULT ('') FOR [TrainID]
GO
/****** Object:  Default [DF__StaticTra__Block__30F848ED]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains_test] ADD  DEFAULT ('') FOR [BlockID]
GO
/****** Object:  Default [DF__StaticTra__StopI__31EC6D26]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains_test] ADD  DEFAULT ('') FOR [StopID]
GO
/****** Object:  Default [DF__StaticTra__stop___32E0915F]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains_test] ADD  DEFAULT ((0)) FOR [stop_sequence]
GO
/****** Object:  Default [DF__StaticTra__Trip___33D4B598]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StaticTrains_test] ADD  DEFAULT ('') FOR [Trip_id]
GO
/****** Object:  Default [DF_StopDisplay_Description]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StopDisplay] ADD  CONSTRAINT [DF_StopDisplay_Description]  DEFAULT ('') FOR [Description]
GO
/****** Object:  Default [DF_StopDisplay_StopID]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[StopDisplay] ADD  CONSTRAINT [DF_StopDisplay_StopID]  DEFAULT ('') FOR [StopID]
GO
/****** Object:  Default [DF_tblHoliDate_Holiday]    Script Date: 09/22/2017 12:59:40 ******/
ALTER TABLE [dbo].[tblHoliDate] ADD  CONSTRAINT [DF_tblHoliDate_Holiday]  DEFAULT (getdate()) FOR [Holiday]
GO
