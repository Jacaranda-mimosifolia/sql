-- MOVIE
CREATE INDEX idx_movie_year_desc ON MOVIE(YEAR DESC);

-- PERSONAGE
CREATE INDEX idx_personage_fans_count_desc ON PERSONAGE(FANS_COUNT DESC);

-- MOVIE_PERSONAGE
CREATE INDEX idx_movie_personage_auteur_desc ON MOVIE_PERSONAGE(AUTEUR DESC);
CREATE INDEX idx_movie_personage_scriptwriter_desc ON MOVIE_PERSONAGE(SCRIPTWRITER DESC);
CREATE INDEX idx_movie_personage_actor_desc ON MOVIE_PERSONAGE(ACTOR DESC);

-- RATING
CREATE INDEX idx_rating_rating_desc ON RATING(RATING DESC);

-- -- 测试索引是否应用成功，启用执行计划
-- EXPLAIN PLAN FOR
-- SELECT * FROM MOVIE WHERE YEAR = 2020;
-- -- 查看执行计划
-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
--
-- -- 查看用户所有索引
-- SELECT * FROM USER_INDEXES;
--
-- -- 删除索引
-- DROP INDEX IDX_MOVIE_YEAR_DESC;  -- index_name
--
-- -- 表分区（Partitioning）
