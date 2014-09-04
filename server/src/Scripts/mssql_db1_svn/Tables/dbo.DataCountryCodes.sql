CREATE TABLE [dbo].[DataCountryCodes]
(
[CountryCode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryName] [nchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataCountryCodes] ADD CONSTRAINT [PK_DataCountryCodes] PRIMARY KEY CLUSTERED  ([CountryCode]) ON [PRIMARY]
GO
