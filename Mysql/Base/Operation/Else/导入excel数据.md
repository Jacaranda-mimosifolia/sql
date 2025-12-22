# 查看sql可导入导出的存储路径
show global variables like '%secure_file_priv%';
# 修改该路径,修改my.ini中的 secure-file-priv=""
# my.ini路径,"C:\ProgramData\MySQL\MySQL Server 8.0"
# 重启Mysql80服务

# 检查一个全局系统变量 'local_infile' 的状态,该变量表示是否能导入数据
show global variables like 'local_infile';
# 改为可导
set global local_infile=1;
# 在my.ini中添加 local_infile=1,重启服务

# 将.xlsx导出.csv文件
# 笔记本另存为utf-8编码
# 将文件保存在该路径下

# 事先创建数据表用来存放，当存在一个问题，若excel表的列太多，该如何更高效的去创建呢？
create table excel_table(
    id varchar(10) primary key,
    name varchar(10),
    phone char(13),
    age char(3)
) engine=innoDB default charset=utf8;  # 指定搜索引擎和默认数据集

select * from excel_table;

# 客户端连接服务端，表示允许上传文件
# mysql --local-infile -u root -p

# 导入数据
# load data [local] infile...
load data infile 'E:/DataGrip/Uploads/text.csv' into table excel_table fields terminated by ',' enclosed by '"' ignore 1 ROWS;
# fields terminated by ','      用','号来区分单个数据
# IGNORE 1 ROWS                 忽略字段名
# 如果指定local关键词，则表明从客户主机读文件。如果local没指定，文件必须位于服务器上。

# 导出数据
# select column_name into outfile %secure_file_priv% ... from table_name;
select * into outfile 'E:/DataGrip/Uploads/user1.csv' fields terminated by ',' lines terminated by '\n' from excel_table;

# 使用联合查询拼接字段名导出  联合查询的目标表记得加上别名 as else_name
select * into outfile 'E:/DataGrip/Uploads/user2.csv' fields terminated by ',' lines terminated by '\n' from (select 'id','name','phone','age' union select * from excel_table) as e;

# 分隔符
# fields关键字指定了文件字段的分割格式
# lines 关键字指定了每列数据的分割格式（默认为'\n'即为换行符）

# terminated by            分隔符，意思是以什么字符作为分隔符
# enclosed by              字段括起字符
# escaped by               转义字符
# lines terminated by      描述字段的分隔符，默认情况下是tab字符（\t）
# ignore number lines      用来忽略导入文件的开始的行。例如：number＝1，则忽略导入文件的第一行数据。

