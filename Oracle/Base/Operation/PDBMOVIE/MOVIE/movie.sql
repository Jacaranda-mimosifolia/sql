-- 创建数据表
CREATE TABLE User_(
    User_type char(10) NOT NULL,
    User_num char(10) NOT NULL,
    User_name char(40) NOT NULL,
    User_address char(50) NOT NULL,
    User_contract char(10),
    User_telephone char(15),
    User_remarks char(60),
    CONSTRAINT pk_rd PRIMARY KEY (User_num));

-- 添加备注
COMMENT ON COLUMN User_.User_type IS '客户类型';
COMMENT ON COLUMN User_.User_num IS '客户编号';
COMMENT ON COLUMN User_.User_address IS '客户名称';
COMMENT ON COLUMN User_.User_contract IS '联系人';
COMMENT ON COLUMN User_.User_telephone IS '联系电话';
COMMENT ON COLUMN User_.User_remarks IS '备注';

-- 创建数据表
CREATE TABLE Received(
    Received_id char(10) PRIMARY KEY NOT NULL,
    Received_date date NOT NULL,
    User_num char(10) NOT NULL,
    Received_people char(10),
    Received_type char(12) NOT NULL,
    Received_amount Float NOT NULL,
    Received_capital char(15),
    Received_unit_people char(60),
    Received_remark char(50),
    Received_collection BLOB,
    CONSTRAINT fk_num FOREIGN KEY (User_num) REFERENCES User_ (User_num));

-- 查询表空间中的数据表
SELECT DISTINCT TABLE_NAME FROM USER_TAB_COLUMNS;

-- 查询用户所有表
SELECT * FROM DBA_TABLES WHERE OWNER='MOVIE';

-- 查看字段信息
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME='USER_';

SELECT * FROM DBA_TAB_COLUMNS WHERE TABLE_NAME='USER_';

SELECT CONSTRAINT_NAME FROM DBA_CONSTRAINTS WHERE TABLE_NAME='USER_';

-- 重命名数据表
ALTER TABLE Received RENAME TO Received01;

-- 添加字段
ALTER TABLE Received01 ADD (Temp CHAR(50));
ALTER TABLE Received01 ADD (Temp2 CHAR(50));
ALTER TABLE Received01 ADD (Temp3 CHAR(50));

-- 添加唯一约束
ALTER TABLE Received01 ADD CONSTRAINT Received_date UNIQUE (Received_date);
SELECT constraint_name, constraint_type FROM DBA_CONSTRAINTS WHERE table_name = 'RECEIVED01';

-- 删除唯一约束
ALTER TABLE Received01 DROP CONSTRAINT Received_date;
SELECT * FROM DBA_CONSTRAINTS WHERE table_name = 'RECEIVED01';

-- 删除字段
ALTER TABLE Received01 DROP COLUMN TEMP;
ALTER TABLE Received01 DROP COLUMN TEMP2;
ALTER TABLE Received01 DROP COLUMN TEMP3;

-- 修改char字符长度
ALTER TABLE Received01 MODIFY (Received_capital VARCHAR2(70));

-- 插入数据
-- 插入用户数据
INSERT INTO User_ (User_type, User_num, User_name, User_address, User_contract, User_telephone, User_remarks) VALUES
('Type1', 'U001', 'John Doe', '123 Elm St, City A', '1234567890', '555-1234', 'Regular customer');

INSERT INTO User_ (User_type, User_num, User_name, User_address, User_contract, User_telephone, User_remarks) VALUES
('Type2', 'U002', 'Jane Smith', '456 Oak St, City B', '0987654321', '555-5678', 'VIP customer');

INSERT INTO User_ (User_type, User_num, User_name, User_address, User_contract, User_telephone, User_remarks) VALUES
('Type1', 'U003', 'Emily Johnson', '789 Pine St, City C', NULL, '555-8765', 'New customer');

INSERT INTO User_ (User_type, User_num, User_name, User_address, User_contract, User_telephone, User_remarks) VALUES
('Type2', 'U004', 'Michael Brown', '321 Maple St, City D', '1122334455', '555-4321', 'Regular customer');

-- 一次性插入接收记录
INSERT ALL
    INTO Received01 (Received_id, Received_date, User_num, Received_people, Received_type, Received_amount, Received_capital, Received_unit_people, Received_remark, Received_collection) VALUES
    ('R001', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'U001', 'John Doe', 'Type1', 1000.50, 'Capital1', 'Unit1', 'Remark1', NULL)
    INTO Received01 (Received_id, Received_date, User_num, Received_people, Received_type, Received_amount, Received_capital, Received_unit_people, Received_remark, Received_collection) VALUES
    ('R002', TO_DATE('2024-11-02', 'YYYY-MM-DD'), 'U002', 'Jane Smith', 'Type2', 2000.00, 'Capital2', 'Unit2', 'Remark2', NULL)
    INTO Received01 (Received_id, Received_date, User_num, Received_people, Received_type, Received_amount, Received_capital, Received_unit_people, Received_remark, Received_collection) VALUES
    ('R003', TO_DATE('2024-11-03', 'YYYY-MM-DD'), 'U001', 'John Doe', 'Type1', 1500.75, 'Capital1', 'Unit1', 'Remark3', NULL)
SELECT * FROM dual;

-- 删除表
DROP TABLE User_;
DROP TABLE RECEIVED01;

-- 查询表
SELECT * FROM USER_;
SELECT * FROM RECEIVED01;

-- 复制表结构和数据
CREATE TABLE RECEIVED02 AS
SELECT * FROM RECEIVED01;
SELECT * FROM RECEIVED02;

-- 只复制表结构
CREATE TABLE Received02 AS
SELECT * FROM Received01 WHERE 1=0;

-- 修改数据遇到的问题：
-- 外键问题
-- 问题：如果您尝试修改 User_num 字段，使其指向不存在的用户，则会违反外键约束。
-- 解决方法：在修改 User_num 之前，确保目标值在 User_ 表中存在。
UPDATE Received01
SET User_num = 'U999'
WHERE Received_id = 'R001';  -- 假设 U999 不存在于 User_ 表中

-- 非空问题
-- 问题：如果尝试将 NOT NULL 约束的字段修改为 NULL，则会违反非空约束。
-- 解决方法：确保修改的字段不被设为 NULL。
UPDATE Received01
SET Received_type = NULL
WHERE Received_id = 'R001';  -- 违反了 NOT NULL 约束

-- 删除数据遇到的问题：
-- 尝试删除 Received01 表中的记录
-- 问题：如果 Received01 表的记录被其他表的外键引用，尝试直接删除该记录会导致外键约束错误。
-- 解决方法：1.确保在删除之前，首先删除所有引用该记录的外键。2.使用 ON DELETE CASCADE 选项创建外键约束，以便在删除主表记录时自动删除相关的外键记录。
-- 尝试删除 Received01 表中的记录
DELETE FROM Received01
WHERE Received_id = 'R001';  -- 如果 R001 被外部表引用，将失败

-- 忽略外键删除
TRUNCATE TABLE Received02;

-- 一般删除
DELETE FROM RECEIVED02;

SELECT * FROM RECEIVED02;
