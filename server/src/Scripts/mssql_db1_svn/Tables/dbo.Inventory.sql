CREATE TABLE [dbo].[Inventory]
(
[CustomerID] [int] NOT NULL,
[ItemID] [int] NOT NULL,
[LeasedUntil] [datetime] NOT NULL,
[Quantity] [int] NOT NULL CONSTRAINT [DF__Inventory__Quant__41F8B7BD] DEFAULT ((1)),
[UpSlot1] [int] NOT NULL CONSTRAINT [DF__Inventory__UpSlo__7A3D10E0] DEFAULT ((0)),
[UpSlot2] [int] NOT NULL CONSTRAINT [DF__Inventory__UpSlo__7C255952] DEFAULT ((-1)),
[UpSlot3] [int] NOT NULL CONSTRAINT [DF__Inventory__UpSlo__7D197D8B] DEFAULT ((-1)),
[UpSlot4] [int] NOT NULL CONSTRAINT [DF__Inventory__UpSlo__7E0DA1C4] DEFAULT ((-1)),
[UpSlot5] [int] NOT NULL CONSTRAINT [DF__Inventory__UpSlo__7F01C5FD] DEFAULT ((-1))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Inventory] ON [dbo].[Inventory] ([CustomerID]) ON [PRIMARY]
GO
