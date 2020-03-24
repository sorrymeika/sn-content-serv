--# mysql -u root -p
--# Enter password: 12345Qwert

-- 创建用户
create user 'dev'@'localhost' identified by '12345Qwert';

-- 设置用户密码等级
ALTER USER 'dev'@'localhost' IDENTIFIED WITH mysql_native_password BY '12345Qwert';
FLUSH PRIVILEGES;

-- 查看用户
SELECT User, Host FROM mysql.user;

-- 查看用户权限
show grants for 'dev'@'localhost';

-- 创建交易(购物车、订单)数据库
create database if not exists sn_content;
-- 分配权限
grant ALL on sn_content.* to 'dev'@'localhost';

-- 展示所有数据库
show databases;

-- 使用数据库
use sn_content;

create table headline (
    id bigint(20) primary key auto_increment COMMENT '主键',
    userId int(11) not null COMMENT '用户ID',
    type tinyint(4) COMMENT '文章类型 - 1: 新闻头条, 2: 问答, 3: 知识库, 4: 评测 5: 博客',
    status tinyint(4) COMMENT '状态 - 0: 草稿, 1: 已发布, 2: 删除, 3: 违规',
    title varchar(200) COMMENT '标题',
    shortTitle varchar(100) COMMENT '短标题',
    pictures varchar(180) COMMENT '图片列表`|`隔开',
    description varchar(400) COMMENT '简介',
    content text COMMENT '正文',
    tags varchar(100) COMMENT '标签',
    praise int(11) COMMENT '赞',
    diss int(11) COMMENT '踩',
    createAt datetime DEFAULT CURRENT_TIMESTAMP,
    createBy varchar(20),
    updateAt datetime,
    updateBy varchar(20),
    INDEX userIdIndex (userId)
) ENGINE InnoDB COMMENT="文章表";

create table headlineComments (
    id bigint(20) primary key auto_increment COMMENT '主键',
    headlineId bigint(20) not null COMMENT '头条ID',
    content varchar(400) COMMENT '评论内容',
    createAt datetime DEFAULT CURRENT_TIMESTAMP,
    createBy varchar(20),
    INDEX headlineIdIndex (headlineId)
) ENGINE InnoDB COMMENT="文章评论表";

create table topic (
    id bigint(20) primary key auto_increment COMMENT '主键',
    name varchar(20) not null COMMENT '话题名',
    picture varchar(20) not null COMMENT '话题图片',
    description varchar(2048) not null COMMENT '话题介绍',
    pid varchar(20) not null COMMENT '父话题ID',
    INDEX pidIndex (pid)
) ENGINE InnoDB COMMENT="话题表";

create table blog (
    id int(11) primary key auto_increment COMMENT '主键',
    name varchar(20) not null COMMENT '博客名',
    description varchar(2048) not null COMMENT '博客描述',
    userId int(11) not null COMMENT '博主用户ID',
    headerImg varchar(20) COMMENT '页眉图片',
    status tinyint(4) COMMENT '状态 - 0: 已注销 1: 正常',
    createAt datetime DEFAULT CURRENT_TIMESTAMP,
    createBy varchar(20),
    updateAt datetime on update CURRENT_TIMESTAMP,
    updateBy varchar(20),
    approveAt datetime,
    approveBy varchar(20),
    INDEX userIdIndex (userId)
) ENGINE InnoDB COMMENT="博客表";

create table blogHeadlineRel (
    headlineId bigint(20) not null primary key,
    blogId int(11) not null,
    catalogId int(11) not null,
    INDEX blogIdIndex (blogId),
    INDEX catalogIdIndex (catalogId)
) ENGINE InnoDB COMMENT="博客文章关联表";

create table blogCatalog (
    id int(11) primary key auto_increment COMMENT '主键',
    name varchar(20) not null COMMENT '类目名',
    blogId int(11) not null COMMENT '博客ID',
    createAt datetime DEFAULT CURRENT_TIMESTAMP,
    createBy varchar(20),
    updateAt datetime,
    updateBy varchar(20),
    INDEX blogIdIndex (blogId)
) ENGINE InnoDB COMMENT="博客文章分类表";
