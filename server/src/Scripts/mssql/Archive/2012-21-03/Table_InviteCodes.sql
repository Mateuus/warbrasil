USE [gameid_v1]
GO

/****** Object:  Table [dbo].[InviteCodes]    Script Date: 03/21/2012 11:06:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[InviteCodes](
	[invitecode] [varchar](50) NOT NULL,
	[Used] [int] NOT NULL,
	[Account] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[IsSent] [int] NOT NULL,
	[SentToEmail] [varchar](100) NOT NULL,
	[SendDate] [datetime] NOT NULL,
	[ReferralID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[PostedRefBonus] [int] NOT NULL,
	[MultiUsesMax] [int] NOT NULL,
	[MultiUsesLeft] [int] NOT NULL,
 CONSTRAINT [PK_InviteCodes] PRIMARY KEY CLUSTERED 
(
	[invitecode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_code]  DEFAULT (((0)-(0))-(0)) FOR [invitecode]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_Used]  DEFAULT ((0)) FOR [Used]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_Account]  DEFAULT ('none') FOR [Account]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_Timestamp]  DEFAULT (((8)-(1))-(2010)) FOR [CreateDate]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_IsSent]  DEFAULT ((0)) FOR [IsSent]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_SetToEmail]  DEFAULT ('s@s.com') FOR [SentToEmail]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_SendDate]  DEFAULT (((11)/(20))/(2010)) FOR [SendDate]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_ReferralID]  DEFAULT ((23742)) FOR [ReferralID]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_CustomerID]  DEFAULT ((0)) FOR [CustomerID]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_GivedRefBonus]  DEFAULT ((0)) FOR [PostedRefBonus]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_MultiUseLeft]  DEFAULT ((0)) FOR [MultiUsesMax]
GO

ALTER TABLE [dbo].[InviteCodes] ADD  CONSTRAINT [DF_InviteCodes_MultiUsesLeft]  DEFAULT ((0)) FOR [MultiUsesLeft]
GO


