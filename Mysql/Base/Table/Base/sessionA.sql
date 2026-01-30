drop table if exists account;
CREATE TABLE account
(
    id      INT PRIMARY KEY,
    balance INT
) ENGINE = InnoDB;

# 实验一重置数据
TRUNCATE TABLE account;
INSERT INTO account
VALUES (1, 1),
       (2, 2);

# 实验二重置数据
# TRUNCATE TABLE account;
# INSERT INTO account VALUES (1, 10), (3, 30), (5, 50);

# 设置事务手动提交
set @@autocommit = 0;
# 设置事务隔离级别为rc
SET SESSION TRANSACTION ISOLATION LEVEL repeatable read;

# 开启事务
START TRANSACTION;
select * from account;
INSERT INTO account VALUES (3, 3);
delete from account where id = 1;
UPDATE account SET balance = 200 WHERE id = 2;
-- 修改后的查询
select * from account;
-- 此时还没提交
commit;

rollback;

show processlist;
# 查看正在运行线程
SELECT *
FROM information_schema.innodb_trx
WHERE trx_mysql_thread_id = CONNECTION_ID();

# ru->读取其他事务未提交，涉及到innodb的mvcc机制                脏读
# rc->每次读取都做一个Read view，读取同一条数据，两次读取不一致    不可重复读
# rr->只读一个read view快照，查询一些集合行时，可能会出现新的行数据 幻读，可以用行级锁里规避幻读
# s->
# innodb的rr已经修复了幻读
# FOR UPDATE = 当前读
                                                                                                                                                      # RR + 当前读 = next-key lock
                                                                                                                                                      # next-key lock = “行 + 间隙”都锁住
                                                                                                                                                      # 所以：
                                                                                                                                                      # 幻读不是“没发生”，而是“被禁止发生”。
