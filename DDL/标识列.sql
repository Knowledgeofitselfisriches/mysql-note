#标识列
/*
又称为自增长列
含义：可以不用手动的插入值，系统提供默认的序列值


特点：
1、标识列必须和主键搭配吗？不一定，但要求是一个key（一般是主键或唯一）
2、一个表可以有几个标识列？至多一个！
3、标识列的类型只能是数值型
4、标识列可以通过 SET auto_increment_increment=3;设置步长
可以通过 手动插入值，设置起始值


*/

#一、创建表时设置标识列 auto_increment


DROP TABLE IF EXISTS tab_identity;
CREATE TABLE tab_identity(
	id INT  ,
	NAME FLOAT UNIQUE AUTO_INCREMENT,
	seat INT 


);
TRUNCATE TABLE tab_identity;


INSERT INTO tab_identity(id,NAME) VALUES(NULL,'john');
INSERT INTO tab_identity(NAME) VALUES('lucy');
SELECT * FROM tab_identity;

# 查询mysql 的变量
SHOW VARIABLES LIKE '%auto_increment%';
SHOW VARIABLES LIKE '%char%';
# auto_increment_increment 1  步长为1 可设置
# auto_increment_offset 1  起始量 为1 mysql 不支持设置

SET auto_increment_increment=3;
# 取巧办法修改起始值
INSERT INTO tab_identity(id,NAME) VALUES(10,'john');
INSERT INTO tab_identity(id,NAME) VALUES(NULL,'john');




