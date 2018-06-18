drop table member;

create table member(
  id varchar(50) not null primary key,
  passwd varchar(60) not null,
  name varchar(10) not null,
  reg_date datetime not null,
  address varchar(100) not null,
  tel varchar(20) not null
);
