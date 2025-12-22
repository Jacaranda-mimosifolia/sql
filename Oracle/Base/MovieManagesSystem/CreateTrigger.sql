-- trg_before_insert_movie_personage
CREATE OR REPLACE TRIGGER trg_before_insert_movie_personage
BEFORE INSERT ON MOVIE_PERSONAGE
FOR EACH ROW
DECLARE
    v_personage_exists INTEGER;
BEGIN
    -- 检查 personage_id 是否存在
    SELECT COUNT(*)
    INTO v_personage_exists
    FROM PERSONAGE
    WHERE personage_id = :NEW.personage_id;

    -- 调试输出
    DBMS_OUTPUT.PUT_LINE('Personage count: ' || v_personage_exists);

    -- 如果 personage 不存在，抛出错误，阻止插入操作
    IF v_personage_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('RAISE APPLICATION ERROR');
        RAISE_APPLICATION_ERROR(-20001, 'Personage with ID ' || :NEW.personage_id || ' does not exist.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('INSERT SUCCESSFUL');
END;

-- 查看用户触发器
SELECT TRIGGER_NAME
FROM USER_TRIGGERS;

-- 指定查看触发器详情
SELECT *
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'TRG_BEFORE_INSERT_MOVIE_PERSONAGE';

-- 查看触发器创建中的报错信息
SELECT *
FROM USER_ERRORS
WHERE TYPE = 'TRIGGER' AND NAME = 'TRG_BEFORE_INSERT_MOVIE_PERSONAGE';

-- 查看触发器源码
SELECT TEXT
FROM USER_SOURCE
WHERE NAME = 'TRG_BEFORE_INSERT_MOVIE_PERSONAGE'
AND TYPE = 'TRIGGER'
ORDER BY LINE;

-- 删除
DROP TRIGGER trg_before_insert_movie_personage;

-- 尝试插入不存在的 PERSONAGE
INSERT INTO MOVIE_PERSONAGE (movie_id, personage_id, auteur, scriptwriter, actor)
VALUES (111111, 1236942, 1, 0, 0);




-- trg_insert_movie_personage
CREATE OR REPLACE TRIGGER trg_insert_movie_personage
BEFORE INSERT ON MOVIE_PERSONAGE
FOR EACH ROW
DECLARE
    v_movie_personage_exists INTEGER;   -- 检查 MOVIE_PERSONAGE 中是否已经存在该记录
BEGIN
    -- 检查 MOVIE_PERSONAGE 中是否已经存在相同的 (movie_id, personage_id)
    SELECT COUNT(*)
    INTO v_movie_personage_exists
    FROM MOVIE_PERSONAGE
    WHERE movie_id = :NEW.movie_id AND personage_id = :NEW.personage_id;

    -- 如果 MOVIE_PERSONAGE 已存在，则更新相应字段
    IF v_movie_personage_exists > 0 THEN
        -- 根据传入的参数更新对应的角色属性
        IF :NEW.auteur = 1 THEN
            UPDATE MOVIE_PERSONAGE
            SET auteur = 1
            WHERE movie_id = :NEW.movie_id AND personage_id = :NEW.personage_id;
        END IF;

        IF :NEW.scriptwriter = 1 THEN
            UPDATE MOVIE_PERSONAGE
            SET scriptwriter = 1
            WHERE movie_id = :NEW.movie_id AND personage_id = :NEW.personage_id;
        END IF;

        IF :NEW.actor = 1 THEN
            UPDATE MOVIE_PERSONAGE
            SET actor = 1
            WHERE movie_id = :NEW.movie_id AND personage_id = :NEW.personage_id;
        END IF;
    ELSE
        -- 如果 MOVIE_PERSONAGE 不存在，才插入新记录
        INSERT INTO MOVIE_PERSONAGE (movie_id, personage_id, auteur, scriptwriter, actor)
        VALUES (:NEW.movie_id, :NEW.personage_id, :NEW.auteur, :NEW.scriptwriter, :NEW.actor);
    END IF;
END;




-- 删除
DROP TRIGGER TRG_INSERT_MOVIE_PERSONAGE;


-- 插入
INSERT INTO MOVIE_PERSONAGE (movie_id, personage_id, auteur, scriptwriter, actor)
VALUES (111111, 27551706, 0, 0, 1);  -- 演员

INSERT INTO MOVIE_PERSONAGE (movie_id, personage_id, auteur, scriptwriter, actor)
VALUES (111111, 27551706, 1, 0, 0);  -- 导演

DELETE FROM MOVIE_PERSONAGE WHERE movie_id = 111111 AND personage_id = 27551706;


