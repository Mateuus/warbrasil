CREATE TABLE [dbo].[DBG_HWInfo]
(
[ComputerID] [bigint] NOT NULL CONSTRAINT [DF_DBG_HWInfo_MacAddress] DEFAULT (''),
[CustomerID] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_CustomerID] DEFAULT ((0)),
[ReportDate] [datetime] NOT NULL CONSTRAINT [DF_DBG_HWInfo_ReportDate] DEFAULT (((2000)-(1))-(1)),
[CPUName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DBG_HWInfo_CPUName] DEFAULT (''),
[CPUBrand] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DBG_HWInfo_CPUBrand] DEFAULT (''),
[CPUFreq] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_CPUFreq] DEFAULT ((0)),
[TotalMemory] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_TotalMemory] DEFAULT ((0)),
[DisplayW] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_DisplayW] DEFAULT ((0)),
[DisplayH] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_DisplayH] DEFAULT ((0)),
[gfxErrors] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_gfxIsValid] DEFAULT ((0)),
[gfxVendorId] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_gfxVendorId] DEFAULT ((0)),
[gfxDeviceId] [int] NOT NULL CONSTRAINT [DF_DBG_HWInfo_gfxDeviceId] DEFAULT ((0)),
[gfxDescription] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DBG_HWInfo_gfxDescription] DEFAULT (''),
[OSVersion] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DBG_HWInfo_osVersion] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DBG_HWInfo] ADD CONSTRAINT [PK_DBG_HWInfo_1] PRIMARY KEY CLUSTERED  ([ComputerID]) ON [PRIMARY]
GO
