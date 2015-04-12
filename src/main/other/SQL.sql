CREATE TABLE `user` (
  `user_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
	`user_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '用户名',
	`user_password`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '密码',
	`user_realname`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '真实姓名',
  `user_class` 				INT 				NOT NULL DEFAULT 0		COMMENT '班级',
	`user_dept` 			VARCHAR(18) 		NOT NULL DEFAULT ''		COMMENT '所在学院',
	`user_power` 					SMALLINT 			NOT NULL DEFAULT 0		COMMENT '身份',
  `user_major` 			VARCHAR(18) 		NOT NULL DEFAULT ''		COMMENT '所在专业',
	PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '用户表';

CREATE TABLE `course` (
  `course_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '课程名称',
  `target_class`				INT 				NOT NULL DEFAULT 0		COMMENT '上课班级',
  `begin_week`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '上课时间',
  `end_week`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '下课时间',
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室课程表';

CREATE TABLE `apply` (
  `apply_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_id`				BIGINT UNSIGNED			NOT NULL DEFAULT 0  	COMMENT '课程编号',
  `lab_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '上课实验室',
  `user_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '申请用户',
  `apply_time`				DATETIME 			NOT NULL 	DEFAULT '1971-01-01 00:00:00'  	COMMENT '申请时间',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室信息表';

CREATE TABLE `lab` (
  `lab_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `lab_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '实验室名称',
  `lab_address`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '实验室地址',
  `lab_dept`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '实验室所属学院',
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室信息表';

CREATE TABLE `schedule` (
  `schedule_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `lab_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0  	COMMENT '实验室id',
  `course_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0  	COMMENT '课程id',
  `state`    TINYINT  NOT NULL  DEFAULT 0 COMMENT '被安排情况',
  `week`				INT 				NOT NULL DEFAULT 0  	COMMENT '第几周',
  `day_of_week`       INT 				NOT NULL DEFAULT 0  	COMMENT '星期几',
  `order`				INT 			NOT NULL DEFAULT 0  	COMMENT '第几节课',
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '排课信息表';