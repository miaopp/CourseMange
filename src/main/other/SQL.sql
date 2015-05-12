CREATE TABLE `user` (
  `user_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
	`user_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '用户名',
	`user_password`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '密码',
	`user_realname`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '真实姓名',
  `user_class` 				INT 				NOT NULL DEFAULT 0		COMMENT '班级',
	`user_dept` 			INT 		NOT NULL DEFAULT 0		COMMENT '所在学院',
	`user_power` 					SMALLINT 			NOT NULL DEFAULT 0		COMMENT '身份',
  `user_major` 			INT 		NOT NULL DEFAULT 0		COMMENT '所在专业',
	PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '用户表';

CREATE TABLE `course` (
  `course_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id`				INT 				NOT NULL DEFAULT 0		COMMENT '上课老师',
  `course_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '课程名称',
  `course_dept`				INT 		NOT NULL DEFAULT 0  	COMMENT '开设课程学院',
  `course_major`				INT 		NOT NULL DEFAULT 0  	COMMENT '开设课程专业',
  `target_class`				INT 				NOT NULL DEFAULT 0		COMMENT '上课班级',
  `begin_week`				INT 				NOT NULL DEFAULT 0  	COMMENT '上课时间',
  `end_week`				INT 				NOT NULL DEFAULT 0  	COMMENT '下课时间',
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室课程表';

CREATE TABLE `apply` (
  `apply_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `course_id`				BIGINT UNSIGNED			NOT NULL DEFAULT 0  	COMMENT '课程编号',
  `lab_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '上课实验室',
  `user_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '申请用户',
  `apply_day_of_week`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '申请的星期几',
  `apply_orders`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0		COMMENT '申请的第几节课',
  `state` 					TINYINT 			NOT NULL DEFAULT 0		COMMENT '状态',
  `apply_time`				DATETIME 			NOT NULL 	DEFAULT '1971-01-01 00:00:00'  	COMMENT '申请时间',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室申请信息表';

CREATE TABLE `lab` (
  `lab_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `lab_name`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '实验室名称',
  `lab_address`				VARCHAR(64)			NOT NULL DEFAULT ''  	COMMENT '实验室地址',
  `lab_dept`				INT			NOT NULL DEFAULT 0  	COMMENT '实验室所属学院',
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '实验室信息表';

CREATE TABLE `schedule` (
  `schedule_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `lab_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0  	COMMENT '实验室id',
  `course_id`				BIGINT UNSIGNED 				NOT NULL DEFAULT 0  	COMMENT '课程id',
  `state`    TINYINT  NOT NULL  DEFAULT 0 COMMENT '被安排情况',
  `week`				INT 				NOT NULL DEFAULT 0  	COMMENT '第几周',
  `day_of_week`       INT 				NOT NULL DEFAULT 0  	COMMENT '星期几',
  `orders`				INT 			NOT NULL DEFAULT 0  	COMMENT '第几节课',
  PRIMARY KEY (`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '排课信息表';

CREATE TABLE `notice` (
  `notice_id` 					BIGINT UNSIGNED 	NOT NULL AUTO_INCREMENT COMMENT 'id',
  `apply_id` 				INT 				NOT NULL DEFAULT 0		COMMENT '对应课程申请',
	`course_id` 			INT 		NOT NULL DEFAULT 0		COMMENT '对应课程',
	`lab_id` 				INT 			NOT NULL DEFAULT 0		COMMENT '申请实验室',
  `user_id` 			INT 		NOT NULL DEFAULT 0		COMMENT '申请老师',
  `target_user` 			INT 		NOT NULL DEFAULT 0		COMMENT '待处理用户',
  `notice_state` 			INT 		NOT NULL DEFAULT 0		COMMENT '处理状态',
	PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT '公告表';
