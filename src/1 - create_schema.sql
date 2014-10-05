SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [users].[gender](
	[gender_id] [int] IDENTITY(1,1) NOT NULL,
	[gender_description] [varchar](6) NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[gender_id] ASC
	)
)

GO

CREATE TABLE [users].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](255) NOT NULL,
	[last_name] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[gender_id] [int] NOT NULL,
	 CONSTRAINT [PK_users_user_id] PRIMARY KEY CLUSTERED 
	(
		[user_id] ASC
	)
)
GO
ALTER TABLE [users].[users]  
	WITH CHECK ADD CONSTRAINT [FK_users_gender_id_genders] FOREIGN KEY([gender_id])
		REFERENCES [users].[gender] ([gender_id])
GO

ALTER TABLE [users].[users] CHECK CONSTRAINT [FK_users_gender_id_genders]
GO



