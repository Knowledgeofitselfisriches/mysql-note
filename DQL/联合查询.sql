# 多条查询语句连合在一起
SELECT * from employees WHERE email like '%a%'
UNION
SELECT * from employees WHERE email LIKE  '%b%';

# 联合查询的特点
# 1. 查询的列数必须一致
# 2. 每一列的类型和含义一致
# 3. 它自动去除重复  不想去除重复 使用union ALL
