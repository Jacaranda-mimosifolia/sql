-- 查看当前用户权限
SELECT * FROM user_sys_privs;

-- 指定查看C##CHEN用户权限
SELECT * FROM dba_sys_privs WHERE grantee = 'C##CHEN';
SELECT * FROM dba_tab_privs WHERE grantee = 'C##CHEN';
SELECT * FROM dba_role_privs WHERE grantee = 'C##CEHN';
SELECT * FROM dba_sys_privs WHERE grantee = 'SYSTEM';

-- 查看所有用户权限
SELECT * FROM dba_sys_privs;
SELECT * FROM dba_tab_privs;
SELECT * FROM dba_role_privs;

-- 赋予C##CHEN用户系统权限
GRANT CREATE SESSION TO C##CHEN;
GRANT CREATE VIEW TO C##CHEN;
GRANT CREATE PROCEDURE TO C##CHEN;
GRANT CREATE TABLE TO C##CHEN;
GRANT CREATE TABLESPACE TO C##CHEN;
grant CONNECT to C##CHEN;
grant RESOURCE to C##CHEN;

-- 赋予C##CHEN用户对象权限
GRANT SELECT ANY TABLE TO C##CHEN;
-- GRANT INSERT TO C##CHEN;
-- GRANT UPDATE TO C##CHEN;
-- GRANT DELETE TO C##CHEN;
-- GRANT EXECUTE TO C##CHEN;
