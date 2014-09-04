CREATE TABLE [dbo].[Inventory_FPS]
(
[CustomerID] [int] NOT NULL,
[WeaponID] [int] NOT NULL,
[AttachmentID] [int] NOT NULL,
[LeasedUntil] [datetime] NOT NULL,
[Slot] [int] NOT NULL,
[IsEquipped] [int] NOT NULL CONSTRAINT [DF_Inventory_FPS_IsEquipped] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Inventory_FPS_CustomerID] ON [dbo].[Inventory_FPS] ([CustomerID]) ON [PRIMARY]
GO
