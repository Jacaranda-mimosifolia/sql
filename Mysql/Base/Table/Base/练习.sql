# 如果存在movie表则删除
drop table if exists movie;
create table movie
(
    movie_id int primary key auto_increment,
    name     varchar(20)
);

drop table if exists area;
create table area
(
    area_id   int primary key auto_increment,
    area_name varchar(8)
);

# 多对多制作国家表，一部电影有多个国家制作，一个国家可以制作多部电影
drop table if exists movie_area;
create table movie_area
(
    movie_id int,
    area_id  int,
    primary key (movie_id, area_id) # 联合主键,联合主键不能使用自增约束
);

# 多对一电影时长表，一个电影可能有多个版本，也就有多种时长，多对一关系
drop table if exists length;
create table length
(
    length   int,
    movie_id int,
    foreign key length (movie_id) references movie (movie_id)# 在多对一的关系中，要在多的表中建立外键联系一的表
        on update cascade
        on delete cascade
);

# 插入数据
insert into movie (name) # 自增主键可以省略
values ('泰坦尼克号'),
       ('疯狂动物城'),
       ('你的名字');
insert into area (area_name)
values ('美国'),
       ('日本'),
       ('英国');
insert into movie_area
values (1, 1),
       (1, 3),
       (2, 3),
       (3, 2);
insert into length
values (120, 1),
       (140, 1),
       (130, 2),
       (180, 3),
       (184, 3);

# 查询美国电影，这里使用内连接
select m.name, a.area_name
from movie as m
         join movie_area as m_a
         join area as a
where m.movie_id = m_a.movie_id
  and m_a.area_id = a.area_id
  and a.area_name = '美国';
# 这是错误的写法，应该先用join on规定连接条件，最后再写where过滤条件

# 正确写法
select m.name, a.area_name
from movie as m
         join movie_area as m_a on m.movie_id = m_a.movie_id
         join area as a on m_a.area_id = a.area_id
where a.area_name = '美国';

# exists
# 查询拥有播放时长的电影
select m.name
from movie as m
where exists(select 1 from length as l where m.movie_id = l.movie_id);

# 子查询
# 查询不属于'日本'的电影有哪些
select m.name
from movie as m
where m.movie_id not in (select m_a.movie_id
                         from movie_area as m_a
                                  join area as a on m_a.area_id = a.area_id
                         where a.area_name = '日本');

# 外键测试
# 查询所有电影以及他们所对应的时长,这里需要查询所有的电影，因此是左连接
select movie.name, length.length
from movie
         left join length on length.movie_id = movie.movie_id
where movie.name = '你的名字';

# 1. 避免插入无效数据
insert into length
values (1, 5);
# 插入一个不存在movie_id到length中，会因外键约束而失败

# 2. 保证数据完整性
# 父表是借钱者，子表是被借者。
# 当父表想要删除/修改已经由子表关联的数据时，就像是借钱者借了钱不认账，这是不被允许的。
# 当子表删除/修改与父表关联的数据时，就像是被借者放言不需要借钱者还钱了，这是可以的。
delete
from movie
where movie_id = 2; # 删除父表中的数据，不可行
delete
from length
where movie_id = 1; # 删除子表中的数据，可行

SELECT @@character_set_database, @@collation_database;


# GROUP BY：按国家统计电影数量
SELECT a.area_name, COUNT(DISTINCT ma.movie_id) AS 电影数量
FROM area a
         JOIN movie_area ma ON a.area_id = ma.area_id
GROUP BY a.area_name;

# WHERE vs HAVING（重点）
# 需求：只看“美国参与的电影”，并且要求美国参与的电影数 >= 2
SELECT a.area_name, COUNT(DISTINCT ma.movie_id) AS 电影数量
FROM area a
         JOIN movie_area ma ON a.area_id = ma.area_id
WHERE a.area_name = '美国' -- 分组前过滤“行”
GROUP BY a.area_name
HAVING COUNT(DISTINCT ma.movie_id) >= 2; -- 分组后过滤“组”

SELECT a.area_name, COUNT(DISTINCT ma.movie_id) AS 电影数量
FROM area a
         JOIN movie_area ma ON a.area_id = ma.area_id
GROUP BY a.area_name
ORDER BY 电影数量 DESC, a.area_name;

SELECT movie_id, name
FROM movie
ORDER BY movie_id
LIMIT 2, 2;

# 查询不是日本电影的，其他国家电影数量大于1的国家有哪些
select a.area_name, count(distinct ma.movie_id) as '电影数量'
from movie_area ma
         join area a on ma.area_id = a.area_id
where not a.area_name = '日本'
group by a.area_name
having count(distinct ma.movie_id)>1;

select * from movie where movie.movie_id>1;
select * from movie order by movie.movie_id desc;
select * from movie group by movie.movie_id having movie.movie_id>1;
SELECT movie_id, name FROM movie ORDER BY movie_id LIMIT 1, 2;

# 当其他会话中的事务dml 表account,
# 则无法drop table if exists account;

# 当其他会话中有未提交事务对表 account 做过 DML 操作时，当前会话执行
# DROP TABLE IF EXISTS account;
# 会被阻塞（或一直等待），原因是：DROP TABLE 需要获取表的元数据锁（MDL），而该锁与未提交事务持有的 MDL 不兼容。

# @@autocommit 是系统变量读取形式，SET autocommit 更直观。