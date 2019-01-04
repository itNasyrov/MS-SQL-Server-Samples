

CREATE TABLE [dbo].[TableName](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[field_1] [varchar](10) NOT NULL,
	[field_2] [int] NULL,
	[field_3] [smalldatetime] NOT NULL,
	[field_4] [bit] NOT NULL,
 CONSTRAINT [PK_TableName_1] PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[TableName_History](
	[id] [int] NULL,
	[field_1] [varchar](10) NULL,
	[field_2] [int] NULL,
	[field_3] [smalldatetime] NULL,
	[field_4] [bit] NULL,
	[change] [varchar](15) NULL,
	[change_id] [int] NULL,
	[change_user] [varchar](50) NULL,
	[change_date] [datetime] NULL
) ON [PRIMARY]

GO

CREATE TRIGGER [dbo].[History__TableName_afterInsert]
 ON [dbo].[TableName]
 FOR INSERT
 AS
 BEGIN
   SET NOCOUNT ON

   INSERT INTO dbo.TableName_History
   SELECT *
		  ,'insert'
		  ,ISNULL((SELECT MAX(change_id) + 1 FROM dbo.TableName_History), 1)
		  ,SUSER_SNAME()
		  ,GETDATE()
	  FROM inserted

GO

CREATE TRIGGER [dbo].[History__TableName_afterUpdate]
 ON [dbo].[TableName]
 FOR UPDATE
 AS
 BEGIN
   SET NOCOUNT ON

   DECLARE @rowcount INT = 0

   SET @rowcount = (
     SELECT DISTINCT COUNT(*)
	    FROM (
       SELECT *
       FROM deleted
       UNION
       SELECT *
       FROM inserted
     ) AS t
   )

   IF (@rowcount > 1)
   BEGIN
     DECLARE @change_id INT = ISNULL((SELECT MAX(change_id) + 1 FROM dbo.TableName_History), 1)

     INSERT INTO dbo.TableName_History
     SELECT *
		    ,'before update'
		    ,@change_id
		    ,SUSER_SNAME()
		    ,GETDATE()
     FROM deleted
     UNION
     SELECT *
		    ,'after update'
		    ,@change_id
		    ,SUSER_SNAME()
		    ,GETDATE()
     FROM inserted
   END
 END

GO

CREATE TRIGGER [dbo].[History__TableName_afterDelete]
 ON [dbo].[TableName]
 FOR DELETE
 AS
 BEGIN
   SET NOCOUNT ON

   INSERT INTO dbo.TableName_History
   SELECT *
		  ,'delete'
		  ,ISNULL((SELECT MAX(change_id) + 1 FROM dbo.TableName_History), 1)
		  ,SUSER_SNAME()
		  ,GETDATE()
	  FROM deleted
 END
GO