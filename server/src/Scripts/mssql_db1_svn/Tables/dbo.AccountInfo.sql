CREATE TABLE [dbo].[AccountInfo]
(
[CustomerID] [int] NOT NULL,
[email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_email] DEFAULT ('noemail@nowhere.com'),
[firstname] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_firstname] DEFAULT ('John'),
[lastname] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_lastname] DEFAULT ('Doe'),
[sex] [int] NOT NULL CONSTRAINT [DF__AccountInfo__sex__208CD6FA] DEFAULT ((0)),
[dob] [datetime] NOT NULL CONSTRAINT [DF_AccountInfo_dob] DEFAULT (((1)/(1))/(1910)),
[street] [char] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_street] DEFAULT ('1 Main St'),
[city] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_city] DEFAULT ('Los Angeles'),
[state] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_state] DEFAULT ('CA'),
[postalcode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_AccountInfo_postalcode] DEFAULT ('0'),
[Country] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_Country] DEFAULT ((1)),
[phone] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_AccountInfo_phone] DEFAULT (((555)-(555))-(5555)),
[OptOut1] [int] NOT NULL CONSTRAINT [DF_AccountInfo_OutOut1] DEFAULT ((0)),
[admin_note] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_AccountInfo_admin_note] DEFAULT (''),
[NumReferrals] [int] NULL CONSTRAINT [DF__AccountIn__NumRe__18C19800] DEFAULT ((0)),
[GeoCode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[AccountInfo] TO [support1]
GRANT INSERT ON  [dbo].[AccountInfo] TO [support1]
GRANT DELETE ON  [dbo].[AccountInfo] TO [support1]
GRANT UPDATE ON  [dbo].[AccountInfo] TO [support1]
GO

ALTER TABLE [dbo].[AccountInfo] ADD CONSTRAINT [PK_AccountInfo] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
