# 设置事务隔离级别为读取未提交数据，会出现脏读现象
SET SESSION TRANSACTION ISOLATION LEVEL serializable;

set @@autocommit=0;

# 开启事务
START TRANSACTION;
# SELECT：快照读（consistent read）→ 不加行锁，读的是 事务开始/首次读的快照
select * from account;
# FOR UPDATE：当前读（current read）→ 要加锁，读的是 最新已提交版本（同时对读到/扫描到的范围加锁）
select * from account FOR UPDATE;  # 在sessionA提交前忙等待，在sA提交后会读取到当前修改过的数据
INSERT INTO account VALUES (3, 3);  # 尝试在其他未提交事务插入后插入->忙等待
delete from account where id = 1;  # 尝试在其他未提交事务删除后删除->忙等待
-- 其他事务提交修改后的查询
select * from account where id>1 FOR UPDATE;;  # 幻读
commit;

rollback;

SELECT *
FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();
