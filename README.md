本SQL project 采用医院数据库进行ORACLE模拟建模，并进而完成了数据库查询，存储过程，自定义函数，和数据同步的操作。本project 主要采用ORACLE完成，仅在数据库查询时采用了MySQL语句。

以下是主要内容：
1.建模围绕着五大主题建立事实表和维度表：employment，appointment, treatment, medication和hospitalization；并按照星座模型进行外键联接。

2.数据库查询中使用了MySQL 语句，进行连接查询，子查询，集合运算，聚合分析函数等查询语句的运用

3.阈值控制：创建存储过程打印违规治疗的医生和相关病人的治疗信息

4.报表分析：创建自定义函数分析空置房间数;计算各时间段之间的appointment累计数

5.同步数据和提升效率：
5.1创建日志记录分析程序运行情况
5.2分别采用全量或增量抽取方式同步数据，
5.3同步数据后检查日志，并从中查阅/修正错误记录和寻找提升效率的可能性。


数据来源于此网站且自行进一步发挥: https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php#h_one 
