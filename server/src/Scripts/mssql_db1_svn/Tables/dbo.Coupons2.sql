CREATE TABLE [dbo].[Coupons2]
(
[CouponCode] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsUsed] [int] NULL,
[CustomerID] [int] NULL,
[Team] [int] NULL,
[MultiUse] [int] NULL CONSTRAINT [DF__Coupons2__MultiU__11207638] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Coupons2] ADD CONSTRAINT [PK_CouponsPAX2011] PRIMARY KEY CLUSTERED  ([CouponCode]) ON [PRIMARY]
GO
