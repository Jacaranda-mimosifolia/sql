-- PRIMARY_TABLE
-- MOVIE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE (
    movie_id NUMBER(8) PRIMARY KEY,                                     -- 电影 ID，主键
    name VARCHAR2(255),                                                 -- 电影名称
    year NUMBER(4),                                                     -- 上映年份
    img VARCHAR2(255),                                                  -- 电影海报
    website VARCHAR2(255),                                              -- 网站链接
    imdb VARCHAR2(20) UNIQUE,                                           -- IMDb 号，唯一
    introduction CLOB                                                   -- 电影简介
);

-- PERSONAGE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE PERSONAGE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE PERSONAGE (
    personage_id NUMBER(8) PRIMARY KEY,                                 -- 角色 ID，主键
    name VARCHAR2(255),                                                 -- 名称
    img VARCHAR2(255),                                                  -- 图片
    gender VARCHAR2(3),                                                 -- 性别
    birth VARCHAR2(17),                                                 -- 出生日期
    death VARCHAR2(17),                                                 -- 死亡日期
    birth_area VARCHAR2(255),                                           -- 出生地
    cn_name VARCHAR2(255),                                              -- 中文名
    fn_name VARCHAR2(255),                                              -- 外文名
    family_member VARCHAR2(255),                                        -- 家庭成员
    imdb VARCHAR2(255),                                                 -- IMDb 码
    profession VARCHAR2(255),                                           -- 职业
    fans_count NUMBER(10),                                              -- 粉丝
    introduction CLOB                                                   -- 简介
);
-- MOVIE_PERSONAGE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE_PERSONAGE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE_PERSONAGE (
    movie_id NUMBER(8),                                                 -- 电影 ID，外键非空，指向 MOVIE 表
    personage_id NUMBER(8),                                             -- 角色 ID，外键非空，指向 PERSONAGE 表
    auteur NUMBER(1) DEFAULT 0 CHECK (auteur IN (0, 1)),                -- 导演，0/1范围约束
    scriptwriter NUMBER(1) DEFAULT 0 CHECK (scriptwriter IN (0, 1)),    -- 编辑，0/1范围约束
    actor NUMBER(1) DEFAULT 0 CHECK (actor IN (0, 1)),                  -- 演员，0/1范围约束
    CONSTRAINT pk_movie_personage PRIMARY KEY (movie_id, personage_id), -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_movie_personage_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE,                 -- 级联删除
    CONSTRAINT fk_movie_personage_personage FOREIGN KEY (personage_id) REFERENCES PERSONAGE(personage_id) ON DELETE CASCADE  -- 级联删除
);

-- N:M
-- TYPE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TYPE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE TYPE (
    type_id NUMBER(2) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,         -- 类型 ID，主键自增
    type_name VARCHAR2(9)                                               -- 类型名称，非空，中文占3个字节
);

-- MOVIE_TYPE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE_TYPE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE_TYPE (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    type_id NUMBER(9) NOT NULL,                                         -- 类型 ID，外键非空，指向 TYPE 表
    CONSTRAINT pk_movie_type PRIMARY KEY (movie_id, type_id),           -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_movie_type_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE,     -- 级联删除
    CONSTRAINT fk_movie_type_type FOREIGN KEY (type_id) REFERENCES TYPE(type_id) ON DELETE CASCADE          -- 级联删除
);

-- TAG
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TAG CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE TAG (
    tag_id NUMBER(3) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,          -- 标签 ID，主键自增
    tag_name VARCHAR2(255) NOT NULL                                     -- 标签名称，非空
);

-- MOVIE_TAG
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE_TAG CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE_TAG (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    tag_id NUMBER(9) NOT NULL,                                          -- 标签 ID，外键非空，指向 TAG 表
    CONSTRAINT pk_movie_tag PRIMARY KEY (movie_id, tag_id),             -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_movie_tag_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE,      -- 级联删除
    CONSTRAINT fk_movie_tag_tag FOREIGN KEY (tag_id) REFERENCES TAG(tag_id) ON DELETE CASCADE               -- 级联删除
);

-- TYPE_TAG
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE TYPE_TAG CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE TYPE_TAG (
    type_id NUMBER(9) NOT NULL,                                         -- 类型 ID，外键非空，指向 TYPE 表
    tag_id NUMBER(9) NOT NULL,                                          -- 标签 ID，外键非空，指向 TAG 表
    CONSTRAINT pk_type_tag PRIMARY KEY (type_id, tag_id),               -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_type_tag_type FOREIGN KEY (type_id) REFERENCES TYPE(type_id) ON DELETE CASCADE,           -- 级联删除
    CONSTRAINT fk_type_tag_tag FOREIGN KEY (tag_id) REFERENCES TAG(tag_id) ON DELETE CASCADE                -- 级联删除
);

-- AREA
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE AREA CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE AREA (
    area_id NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,         -- 地区 ID，主键自增
    area_name VARCHAR2(200) NOT NULL                                    -- 地区名称，非空
);

-- MOVIE_AREA
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE_AREA CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE_AREA (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    area_id NUMBER(4) NOT NULL,                                         -- 地区 ID，外键非空，指向 AREA 表
    CONSTRAINT pk_movie_area PRIMARY KEY (movie_id, area_id),           -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_movie_area_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE,     -- 级联删除
    CONSTRAINT fk_movie_area_area FOREIGN KEY (area_id) REFERENCES AREA(area_id) ON DELETE CASCADE          -- 级联删除
);

-- LANGUAGE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE LANGUAGE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE LANGUAGE (
    language_id NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,     -- 语言 ID，主键自增
    language_name VARCHAR2(100) NOT NULL                                -- 语言名称，非空
);

-- MOVIE_LANGUAGE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE MOVIE_LANGUAGE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE MOVIE_LANGUAGE (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    language_id NUMBER(4) NOT NULL,                                     -- 语言 ID，外键非空，指向 LANGUAGE 表
    CONSTRAINT pk_movie_lang PRIMARY KEY (movie_id, language_id),       -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_movie_lang_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE,     -- 级联删除
    CONSTRAINT fk_movie_lang_lang FOREIGN KEY (language_id) REFERENCES LANGUAGE(language_id) ON DELETE CASCADE  -- 级联删除
);


-- 1:N
-- RELEASE
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RELEASE CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE RELEASE (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    release VARCHAR2(100) NOT NULL,                                     -- 上映，非空
    CONSTRAINT pk_movie_release PRIMARY KEY (movie_id, release),        -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_release_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE         -- 级联删除
);

-- LENGTH
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE LENGTH CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE LENGTH (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    length VARCHAR2(100) NOT NULL,                                      -- 片长，非空
    CONSTRAINT pk_movie_length PRIMARY KEY (movie_id, length),          -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_length_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE          -- 级联删除
);

-- ALIAS
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE ALIAS CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE ALIAS (
    movie_id NUMBER(8) NOT NULL,                                        -- 电影 ID，外键非空，指向 MOVIE 表
    alias VARCHAR2(100) NOT NULL,                                       -- 片长，非空
    CONSTRAINT pk_movie_alias PRIMARY KEY (movie_id, alias),            -- 主键约束，确保数据对唯一性
    CONSTRAINT fk_alias_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE           -- 级联删除
);

-- 1:1
-- RATING
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE RATING CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
CREATE TABLE RATING (
    movie_id NUMBER(8) PRIMARY KEY,                                     -- 电影 ID，外键非空，指向 MOVIE 表
    counting VARCHAR2(100) DEFAULT 0,                                   -- 总评分人数
    rating NUMBER(10) DEFAULT 0,                                        -- 平均分
    stars1 VARCHAR2(15) DEFAULT 0,                                      -- 一星占比
    stars2 VARCHAR2(15) DEFAULT 0,                                      -- 二星占比
    stars3 VARCHAR2(15) DEFAULT 0,                                      -- 三星占比
    stars4 VARCHAR2(15) DEFAULT 0,                                      -- 四星占比
    stars5 VARCHAR2(15) DEFAULT 0,                                      -- 五星占比
    contrast VARCHAR2(100),                                             -- 对比
    CONSTRAINT fk_rating_movie FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id) ON DELETE CASCADE          -- 级联删除
);
