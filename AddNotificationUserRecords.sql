USE [mbdbx101]
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 9 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 10 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 11 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 12 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 13 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[CandidateID])
     SELECT 14 AS NotificationID, c.CandidateID
FROM     Candidates AS c INNER JOIN
                  Centres AS ct ON c.CentreID = ct.CentreID
WHERE  (ct.Active = 1) AND (c.Active = 1) AND (c.EmailAddress LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[AdminUserID])
     SELECT 3 AS NotificationID, a.AdminID
FROM     AdminUsers AS a INNER JOIN
                  Centres AS ct ON a.CentreID = ct.CentreID
WHERE  (a.Active = 1) AND (ct.Active = 1) AND (a.Email LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[AdminUserID])
     SELECT 5 AS NotificationID, a.AdminID
FROM     AdminUsers AS a INNER JOIN
                  Centres AS ct ON a.CentreID = ct.CentreID
WHERE  (a.Active = 1) AND (ct.Active = 1) AND (a.Email LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[AdminUserID])
     SELECT 1 AS NotificationID, a.AdminID
FROM     AdminUsers AS a INNER JOIN
                  Centres AS ct ON a.CentreID = ct.CentreID
WHERE  (a.Active = 1) AND (ct.Active = 1) AND (a.Email LIKE '%@%')
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[AdminUserID])
     SELECT 2 AS NotificationID, a.AdminID
FROM     AdminUsers AS a INNER JOIN
                  Centres AS ct ON a.CentreID = ct.CentreID
WHERE  (a.Active = 1) AND (ct.Active = 1) AND (a.Email LIKE '%@%') AND (a.IsCentreManager = 1)
GO

INSERT INTO [dbo].[NotificationUsers]
           ([NotificationID]           
           ,[AdminUserID])
     SELECT 8 AS NotificationID, a.AdminID
FROM     AdminUsers AS a INNER JOIN
                  Centres AS ct ON a.CentreID = ct.CentreID
WHERE  (a.Active = 1) AND (ct.Active = 1) AND (a.Email LIKE '%@%') AND (a.ContentCreator = 1)
GO