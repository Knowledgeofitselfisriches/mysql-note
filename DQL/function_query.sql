/*
常见函数：
  1. 隐藏实现细节
  2. 代码重用
  使用： select function(params) [from table]
  特点：

      函数名
      功能
      可函数嵌套
  分类：
      单行函数：
      concat length ifnull isnull
      分组函数：统计、聚合函数
单行函数：
  字符函数
      length(str) 取str的字节长度
      concat(*str)
      upper/lower(str)
      substr/ substring

  数学函数
  日期函数
  其它函数
  流程控制函数
分组函数
 sum
 avg
 max
 min
 count
*/
# 字符函数
SHOW VARIABLES LIKE '%char%';
# mysql索引从1 开始 substr截取字符 重载了四个方法
# 从指定索引为3位置开始截取 thon
SELECT substr('python', 3) out_put;
# 从指定索引1截取指定字符长度（2）的字符
SELECT substr('python', 1, 2) out_put;
# instr 返回子串在原始字符串中的第一次出现的起始位置， 不存在返回0
SELECT instr('python', 'on') out_put;
# Trim(str) 去除前后的空格或指定的字符
SELECT trim('                aaaapythonaaaajavaaaajs          ') AS out_put;
SELECT trim('a' FROM 'aaaapythonaaaajavaaaajs') AS out_put;
# lpad(str, 10, '*') 用指定的字符左填充实现str指定的长度10
# rpad(str, 10, '*') 用指定的字符右填充实现str指定的长度10
SELECT lpad('python', 10, '-');
# replace(src_str，ord_str, new_str ) 用new-str替换 str中 的ord_str
SELECT replace('php 天下第一', 'php', 'python');

# 数学函数
# round (number)四舍五入默认取整
# round(number, int) 取小数点后int位
# rand 返回[0, 1）
SELECT round(-1.55);
SELECT round(-1.558888, 2);
# ceil(number) 向上取整
SELECT ceil(1.002);
# floor(number) 向下取整
# TRUNCATE(number， int) 截断指定位数
SELECT truncate(1.111111, 1);
# mod取余 a - a/b * b mod(10, -3) 10 -10/3=3*3 = 1
SELECT mod(10, -3);

# 日期函数
# now() 当前完整时间
SELECT now();
# curdate() 当前日期
SELECT curdate();
# curtime() 当前时间
SELECT curtime();
SELECT current_date();
# datediff 返回两个日期相差的天数
SELECT datediff(date(now()), '18-09-12');

# 获取指定时间部分year month day weekend hours min second week（0 开始）
SELECT year(now());
SELECT month(now());
SELECT week(now());
SELECT weekday(now());
SELECT weekofyear(now());
SELECT dayofweek(now());
SELECT dayofmonth(now());
SELECT monthname(now());
SELECT day(now());
SELECT hour(now());
SELECT minute(now());
SELECT second(now());
SELECT time(now());
SELECT timestamp(now());
SELECT time_to_sec(now());
# 日期转换
# 字符转日期 str_to_date(str, format);
/*
  %Y  四位年份
  %y  二位年份
  %m  01，02月份
  %c  1，2，3月份
  %d  01，02日
  %H  24小时
  %h  12小时
  %i  分钟
  %s  秒
*/
SELECT str_to_date('1998-2-01', '%Y-%c-%d');
SELECT str_to_date('4-3 1998', '%c-%d %Y');
# 日期转为字符
SELECT date_format(now(), '%y年 %m月 %d日');

# 系统函数
SELECT version();
SELECT database();
SELECT user();
# 加密该字符
SELECT password('cwq');
SELECT md5('cwq');
# 流程控制函数
# if(exp1,exp2,exp3) 类似java三元运算符
SELECT if(10 > 5, 'big', 'small');
# case()：switch case()效果 等值判断
# case 字段/表达式
# when var1 then  value/语句
# when var2 then  value/语句
# when var3 then  value/语句
# end
SELECT salary 原始工资, department_id, CASE department_id
                                     WHEN 30 THEN salary * 1.1
                                     WHEN 40 THEN salary * 1.2
                                     WHEN 50 THEN salary * 1.3
                                     ELSE salary
    END AS    新工资
FROM employees;
# case 多重case 区间判断
# case
# when 条件1 then value或语句
# when 条件2 then value或语句
# when 条件3 then value或语句
# else value或语句
# end
SELECT salary     原始工资,
       department_id,
       CASE
         WHEN salary > 20000 THEN 'A'
         WHEN salary > 18000 THEN 'B'
         WHEN salary > 17000 THEN 'C'

         ELSE 'D'
           END AS 工资级别
FROM employees;

# 分组函数
# sum min max avg count
# 参数支持
# sun/avg  数值型
# min/max  可比较型 日期 字符 数值
# count  计算非空的字段 任何类型 (null 除外)

SELECT sum(salary), avg(salary), max(salary), min(salary), count(salary)
FROM employees;
# 是否忽略null值
# sum，avg count max min 都忽略
# 和distinct 去重 配合
SELECT sum(DISTINCT salary)
FROM employees;

# count详细
# count（*） 统计行数
# count(1) 统计1的个数
# myisam 下 count(*) 高
# innodb 下 count(*) = count(1)
# count(field) 底层需要判断null
# 6.和分组函数一同查询的字段有限制， 一般是groupby之后的字段


## 分组查询
/*
 select 查询列表必须是分组函数和group by 后出现的字段
       field  group_function()
 from table
 where condition 筛选原始数据表
 group by
 having          筛选分组结果集
 order by
 特点：
   1. 分组查询筛选条件分为两类：
                  数据源          位置             关键字
    分组前筛选    原始表         group by 前       where
    分组后筛选    分组结果集     group by后        having
   分组函数做条件放置于having中
   考虑到性能原因， 优先考虑where 关键字
   2.group by 支持 多个字段 函数
   3. 支持排序
*/
SELECT avg(salary), department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;
SELECT max(salary), manager_id
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;
#分组结果筛选
SELECT count(*), department_id
FROM employees
GROUP BY department_id
HAVING count(*)>2;
# 按表达式分组 having、group by支持别名
select count(*), length(last_name)
FROM  employees
GROUP BY length(last_name)
HAVING count(*) > 5;
# 支持多分组， 排序
select count(*), length(last_name)
FROM  employees
GROUP BY length(last_name)
HAVING count(*) >  5
order by length(last_name) asc;


# sql 语句执行顺序
/*
    from
    where   返回结果集 不是原表
    group by
    having
    select
    order by
*/