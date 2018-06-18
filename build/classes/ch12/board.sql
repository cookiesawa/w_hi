create table board(
  num int not null primary key auto_increment
, writer varchar(50) not null
, subject varchar(200) not null
, content text not null
, passwd varchar(60) not null
, reg_date datetime not null
, ip varchar(50) not null
, readcount int default 0
, ref int not null
, re_step smallint not null
, re_level smallint not null
);