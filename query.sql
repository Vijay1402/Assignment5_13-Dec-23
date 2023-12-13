CREATE DATABASE Assessment05Db
USE Assessment05Db

create schema bank

create table bank.Customer
(CId int primary key identity(1000,1),
Cname nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(50) not null unique,
CPwd as (right(Cname, 2)+ convert(nvarchar, CId) + left(Contact,2)) persisted )

create table bank.MailInfo
(MailTo nvarchar(50) not null unique,
MailDate date default GetDate(),
MailMessage nvarchar(100))

create trigger bank.trgMailToCust
on bank.Customer
after insert
as
declare @CustEmail nvarchar(50), @CustPwd nvarchar(50)
select @CustEmail = CEmail from inserted
select @CustPwd = CPwd from inserted
insert into bank.MailInfo(MailTo, MailDate, MailMessage)
values (@CustEmail, GETDATE(), 'Your netbanking password is: '+@CustPwd+'.It is valid upto 2 days only. Update it.')
print 'Record Inserted & Mail message updated with pwd.'

 
insert into bank.Customer values ('Vijay', 'vijay@xyz.com', '9876543210')
insert into bank.Customer values ('Govind', 'govind@xyz.com', '9811143210')
insert into bank.Customer values ('Suhas', 'suhas@xyz.com', '9874443210')
insert into bank.Customer values ('Mahesh', 'mahesh@xyz.com', '9877653210')

select * from bank.Customer
select * from bank.MailInfo
