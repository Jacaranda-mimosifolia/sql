# 查看mysql存储路径
show variables like '%datadir%';
# 关闭Mysql服务
# 找到C:\ProgramData\MySQL\MySQL Server 8.0\my.ini文件
# 修改文件权限，开启用户修改权限
# 修改其中的datadir=""为你所要的路径并保存
# 将C:\ProgramData\MySQL\MySQL Server 8.0\Data复制到新的存储路径
# 重新打开Mysql服务
# 再次查看mysql存储路径
show variables like '%datadir%';
