CREATE TABLE [dbo].[DBG_RefPixelLog]
(
[CustomerID] [int] NOT NULL,
[ReferralID] [int] NOT NULL,
[PixelUrl] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PixelCallTime] [datetime] NOT NULL,
[ErrorMsg] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
