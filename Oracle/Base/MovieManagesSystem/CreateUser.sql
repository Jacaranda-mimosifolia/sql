-- USER
-- READONLY_USER
CREATE USER READONLY_USER IDENTIFIED BY 123456;

-- 赋予连接权限
GRANT CONNECT TO READONLY_USER;

-- 将 MOVIE 表空间的数据表都赋予给 READONLY_USER 用户查询功能
BEGIN
    FOR t IN (SELECT table_name, owner
              FROM dba_tables
              WHERE tablespace_name = 'MOVIE' AND owner = 'MOVIE')
    LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT ON ' || t.owner || '.' || t.table_name || ' TO readonly_user';
    END LOOP;
END;

-- 将 MOVIE 表空间的视图都赋予给 READONLY_USER 用户查询功能
BEGIN
    FOR v IN (SELECT view_name, owner
              FROM dba_views
              WHERE owner = 'MOVIE')
    LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT ON ' || v.owner || '.' || v.view_name || ' TO readonly_user';
    END LOOP;
END;

-- 移除多余的用户权限
REVOKE SELECT ON USER_INFO FROM READONLY_USER;
REVOKE SELECT ON COMMON FROM READONLY_USER;

-- 查看用户
SELECT *
FROM dba_users
WHERE USERNAME='READONLY_USER';

-- 查看用户的默认表空间和临时表空间
SELECT username, default_tablespace, temporary_tablespace
FROM dba_users
WHERE username='READONLY_USER';

-- 查看指定用户权限
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'READONLY_USER';

-- 查看当前用户权限
SELECT * FROM USER_TAB_PRIVS;

-- 查看用户锁状态
SELECT username, account_status
FROM dba_users
WHERE username = 'READONLY_USER';

-- 解开/上锁
ALTER USER READONLY_USER ACCOUNT UNLOCK;  -- 解锁
ALTER USER READONLY_USER IDENTIFIED BY 123456 ACCOUNT LOCK;  -- 上锁并改密码


-- ROLE
-- ADMIN_ROLE
CREATE ROLE ADMIN_ROLE;

-- 赋予连接权限
GRANT CONNECT TO ADMIN_ROLE;

-- grant_table
BEGIN
    -- 定义一个游标，遍历表空间下所有的表
    FOR t IN (SELECT owner, table_name
              FROM dba_tables
              WHERE tablespace_name = 'MOVIE'
              AND owner NOT IN ('SYS', 'SYSTEM')  -- 避免授予系统表权限
              AND table_name NOT IN ('TYPE','USER_INFO','COMMON'))
    LOOP
        -- 构建并执行授予所有权限的动态 SQL
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE, ALTER ON ' || t.owner || '.' || t.table_name || ' TO ADMIN_ROLE WITH ADMIN OPTION;';
    END LOOP;
END;
GRANT SELECT ON TYPE TO ADMIN_ROLE WITH ADMIN OPTION ;  -- 只赋予查询权限

-- grant_view
BEGIN
    -- 定义一个游标，遍历表空间下所有的表
    FOR v IN (SELECT owner, view_name
              FROM dba_views
              WHERE owner = 'MOVIE')  -- 避免授予系统表权限
    LOOP
        EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' || v.owner || '.' || v.view_name || ' TO ADMIN_ROLE WITH ADMIN OPTION;';
    END LOOP;
END;

-- 查看角色权限
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'ADMIN_ROLE';

-- 删除角色
DROP ROLE ADMIN_ROLE;

-- MOVIE_ADMIN
CREATE USER MOVIE_ADMIN IDENTIFIED BY 123456;
GRANT ADMIN_ROLE TO MOVIE_ADMIN;
DROP USER MOVIE_ADMIN;

-- 查看指定用户权限
SELECT * FROM DBA_TAB_PRIVS WHERE GRANTEE = 'MOVIE_ADMIN';

-- 查看当前用户权限
SELECT * FROM USER_TAB_PRIVS;

--
CREATE PROFILE chen_pro_sql LIMIT
    SESSIONS_PER_USER          1000    -- 每个用户最大会话数
    CPU_PER_SESSION            1000    -- 每个会话的最大 CPU 时间（秒）
    LOGICAL_READS_PER_SESSION  2000    -- 每个会话的最大读取数
    FAILED_LOGIN_ATTEMPTS      3       -- 最大登录失败次数
    PASSWORD_LOCK_TIME         10      -- 锁定天数
    PASSWORD_LIFE_TIME         UNLIMITED -- 密码的生命周期（无限制）
    PASSWORD_GRACE_TIME        UNLIMITED -- 密码过期的宽限期
    PASSWORD_REUSE_TIME        UNLIMITED -- 密码重用的时间（无限制）
    PASSWORD_REUSE_MAX         UNLIMITED -- 密码重用的最大次数（无限制）
    COMPOSITE_LIMIT            UNLIMITED; -- 复合限制（如临时表空间限制）
