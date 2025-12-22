use my_db;

create table milk
(
    id       int primary key auto_increment,
    name     varchar(20) not null           comment '商品名',
    material varchar(20) default 'raw milk' comment '配料',
    region   varchar(20) not null           comment '原产地',
    nu_id    int         auto_increment     comment '营养表外键',
    by_id    int         auto_increment     comment '购买详情外键',
    constraint foreign key milk (nu_id) references nutrition (id) on update cascade on delete cascade,
    constraint foreign key milk (by_id) references buy (id) on update cascade on delete cascade
) comment '牛奶主表';

create table nutrition
(
    id               int primary key auto_increment,
    energy           int not null comment 'kj',
    energy_NRV       int not null comment '能量，越低越好',
    protein          int not null comment 'g',
    protein_NRV      int not null comment '蛋白质，越高越好',
    fat              int not null comment 'g',
    fat_NRV          int not null comment '脂肪，越低越好',
    carbohydrate     int not null comment 'g',
    carbohydrate_NRV int not null comment '碳水化合物，越低越好',
    Na               int not null comment 'mg',
    Na_NRV           int not null comment '钠，越低越好',
    Ca               int not null comment 'mg',
    Ca_NRV           int not null comment '钙，越高越好'
) comment '营养成分表';

create table buy
(
    id       int primary key auto_increment,
    date     date not null comment 'year-month-day',
    capacity int  not null comment 'ml',
    number   int  not null comment 'boxes',
    price    int  not null comment 'RMB'
) comment '购买详情表';


select *
from milk;

select *
from nutrition;

select *
from buy;

insert into milk
values (null, 'VegaOro', null, 'Spain', null, null);

insert into nutrition
values (null, 264, 0.03, 3.1, 0.05, 3.6, 0.06, 4.6, 0.02, 50, 0.03, 120, 0.15)

insert into buy
values ()

# 查看主键字段
SHOW INDEX FROM milk WHERE Key_name = 'PRIMARY';