USE [gameid_v1]
GO
CREATE NONCLUSTERED INDEX [IDX_UserRoundResult_CID_GRP]
ON [dbo].[DBG_UserRoundResults] ([CustomerID], [GameReportTime])

GO
