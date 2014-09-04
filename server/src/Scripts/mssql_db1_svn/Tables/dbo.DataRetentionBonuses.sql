CREATE TABLE [dbo].[DataRetentionBonuses]
(
[Day] [int] NOT NULL,
[Bonus] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataRetentionBonuses] ADD CONSTRAINT [PK_DataRetentionBonuses] PRIMARY KEY CLUSTERED  ([Day]) ON [PRIMARY]
GO
