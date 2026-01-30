show engines;

show status like 'com_______';

explain select * from movie;

show profiles;

show variables like '%slow_query_log%';

select @@have_profiling;

select @@profiling;


set profiling = 0;

select @@autocommit;
