create table member(
	id varchar(50) not null primary key,
	passwd varchar(16) not null,
	name varchar(10) not null,
	reg_date datetime not null
);

insert into member(
id, passwd, name, reg_date
) values (
'jang-ah-young','jang-ah-young','장아영', now()
);

select * from member;

