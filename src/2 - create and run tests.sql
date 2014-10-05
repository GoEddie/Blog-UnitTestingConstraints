exec tSQLt.NewTestClass 'constraint on users.users'
go
create procedure [constraint on users.users].[SetUp]
as
	exec tSQLt.FakeTable 'gender', 'users'
	exec tSQLt.FakeTable 'users', 'users'
	
	insert into users.gender(gender_id, gender_description)
	select 1, 'Male'
	union
	select 2, 'Female'

	exec tSQLt.ApplyConstraint 'users', 'FK_users_gender_id_genders', 'users' 	
go

create procedure [constraint on users.users].[test allows male]
as
	insert into users.users(user_id, gender_id)
	select 100, 1	
go

create procedure [constraint on users.users].[test allows female]
as

	insert into users.users(user_id, gender_id)
	select 100, 2	
go
create procedure [constraint on users.users].[test disallows unknown values]
as
	--exec tSQLt.ExpectException 'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_users_gender_id_genders". The conflict occurred in database "SimpleSchema", table "users.gender", column ''gender_id''.'
	exec tSQLt.ExpectException @ExpectedMessagePattern = '%INSERT%conflicted%FOREIGN KEY%'
	insert into users.users(user_id, gender_id)
	select 100, 94898
go

exec tSQLt.Run 'constraint on users.users'


