# select...into outfile
select * into outfile 'E:/DataGrip/Uploads/user.csv'fields terminated by ',' lines terminated by '\n' from excel_table;
