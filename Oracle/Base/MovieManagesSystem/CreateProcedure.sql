-- insert_movie_and_types
CREATE OR REPLACE PROCEDURE insert_movie_and_types (
    p_id            IN NUMBER,              -- 电影 ID
    p_name          IN VARCHAR2,            -- 电影名称
    p_year          IN NUMBER,              -- 上映年份
    p_img           IN VARCHAR2,            -- 海报路径
    p_website       IN VARCHAR2,            -- 网站链接
    p_imdb          IN VARCHAR2,            -- IMDB 码
    p_introduction  IN CLOB,                -- 电影简介
    p_type_ids      IN VARCHAR2             -- 电影类型 IDs，以逗号分隔
)
IS
    -- 变量声明
    v_movie_id      MOVIE.MOVIE_ID%TYPE;   -- %TYPE 获取字段 MOVIE_ID 的数据类型
    v_type_id       NUMBER(2);
    v_pos           NUMBER := 1;
    v_comma_pos     NUMBER;
BEGIN
    -- 插入电影数据到 MOVIE 表
    INSERT INTO MOVIE (MOVIE_ID, NAME, YEAR, IMG, WEBSITE, IMDB, INTRODUCTION)
    VALUES (p_id, p_name, p_year, p_img, p_website, p_imdb, p_introduction)
    RETURNING MOVIE_ID INTO v_movie_id;

    -- 将电影类型插入到 MOVIE_TYPE 表
    LOOP
        -- 提取类型 ID
        v_comma_pos := INSTR(p_type_ids, ',', v_pos);
        IF v_comma_pos = 0 THEN
            v_type_id := TO_NUMBER(SUBSTR(p_type_ids, v_pos));  -- 获取最后一个类型 ID
        ELSE
            v_type_id := TO_NUMBER(SUBSTR(p_type_ids, v_pos, v_comma_pos - v_pos));  -- 获取类型 ID
        END IF;

        -- 插入电影类型
        INSERT INTO MOVIE_TYPE (MOVIE_ID, TYPE_ID)
        VALUES (v_movie_id, v_type_id);

        -- 更新 v_pos，准备提取下一个类型 ID
        IF v_comma_pos = 0 THEN
            EXIT;
        ELSE
            v_pos := v_comma_pos + 1;
        END IF;
    END LOOP;

    COMMIT;  -- 提交事务
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;  -- 出错时回滚事务
        RAISE;     -- 抛出异常
END insert_movie_and_types;

-- PL/SQL匿名块调用
BEGIN
    -- 调用存储过程 insert_movie，并传入参数
    insert_movie_and_types(
        p_id      => 111111,            -- 电影 ID
        p_name    => 'Inception',       -- 电影名称
        p_year    => 2010,              -- 上映年份
        p_img     => 'inception.jpg',   -- 海报图片路径
        p_website => 'http://inception.com', -- 网站链接
        p_imdb    => 111111,
        p_introduction => NULL,
        p_type_ids => '1,2,4'
    );
END;

-- 查看用户的存储过程
SELECT OBJECT_NAME
FROM USER_PROCEDURES
WHERE OBJECT_TYPE = 'PROCEDURE';

-- 指定查看存储过程
SELECT *
FROM USER_PROCEDURES
WHERE OBJECT_NAME = 'INSERT_MOVIE_AND_TYPES';

-- 指定查看存储过程创建中的报错信息
SELECT *
FROM USER_ERRORS
WHERE TYPE = 'PROCEDURE' AND NAME = 'INSERT_MOVIE_AND_TYPES';

-- 查看存储过程的源码
SELECT TEXT
FROM USER_SOURCE
WHERE NAME = 'INSERT_MOVIE_AND_TYPES' AND TYPE = 'PROCEDURE'
ORDER BY LINE;

-- 删除存储过程
DROP PROCEDURE INSERT_MOVIE_AND_TYPES;


-- delete_movie_and_types
CREATE OR REPLACE PROCEDURE delete_movie_and_types (
    p_movie_id IN NUMBER            -- 电影 ID
) IS
BEGIN
    -- 1. 删除 MOVIE_TYPE 表中与电影 ID 相关的类型记录
    DELETE FROM MOVIE_TYPE
    WHERE MOVIE_ID = p_movie_id;

    -- 2. 删除 MOVIE 表中对应的电影记录
    DELETE FROM MOVIE
    WHERE MOVIE_ID = p_movie_id;

    -- 3. 删除 TYPE 表中未被其他电影使用的类型（仅删除没有其他电影使用的类型）
    DELETE FROM TYPE
    WHERE TYPE_ID IN (
        SELECT TYPE_ID
        FROM MOVIE_TYPE
        WHERE TYPE_ID NOT IN (SELECT TYPE_ID FROM MOVIE_TYPE WHERE MOVIE_ID != p_movie_id)
    );
    COMMIT;

-- 异常处理
EXCEPTION
    WHEN OTHERS THEN
        -- 出现错误时回滚事务
        ROLLBACK;
        -- 抛出异常
        RAISE;
END delete_movie_and_types;

-- 调用
BEGIN
    delete_movie_and_types(
            p_movie_id => 111111
    );
END;
