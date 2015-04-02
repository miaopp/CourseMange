CREATE TABLE `user` (
  `user_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
	`user_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '用户名',
	`user_password`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '密码',
	`user_number`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '用户编号',
  `class` 				INT 				NOT NULL DEFAULT 0		COMMENT '班级',
	`dept` 			VARCHAR(18) 		NOT NULL DEFAULT ''		COMMENT '所在专业',
	`power` 					SMALLINT 			NOT NULL DEFAULT 0		COMMENT '身份',
	PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '用户表';

CREATE TABLE `course` (
  `course_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '课程名称',
  `target_class`				INT 				NOT NULL DEFAULT 0		COMMENT '上课班级',
  `course_time`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '上课时间',
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室课程表';

CREATE TABLE `apply` (
  `apply_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_id`				BIGINT UNSIGNED			NOT NULL DEFAULT 0  	COMMENT '课程编号',
  `lab_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '上课实验室',
  `apply_time`				DATETIME 			NOT NULL 	DEFAULT '1971-01-01 00:00:00'  	COMMENT '申请时间',
  `lab_time`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '上课时间',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室信息表';

CREATE TABLE `lab` (
  `lab_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_id`				BIGINT UNSIGNED			NOT NULL DEFAULT 0  	COMMENT '已安排课程编号',
  `user_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '上课老师',
  `lab_time`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '上课时间',
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室信息表';