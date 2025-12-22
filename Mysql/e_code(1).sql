/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云2(内网)
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 10.8.0.1:3306
 Source Schema         : e_code

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 20/04/2025 21:27:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_chat_history
-- ----------------------------
# DROP TABLE IF EXISTS `ai_chat_history`;
# CREATE TABLE `ai_chat_history`  (
#   `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话历史主键id',
#   `user_id` int NULL DEFAULT NULL COMMENT '会话所属用户id',
#   `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话类型',
#   `history_content` json NULL COMMENT '会话历史内容',
#   `create_time` datetime NULL DEFAULT NULL COMMENT '会话创建时间',
#   PRIMARY KEY (`id`) USING BTREE
# ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;
#
# -- ----------------------------
# -- Table structure for class
# -- ----------------------------
# DROP TABLE IF EXISTS `class`;
# CREATE TABLE `class`  (
#   `id` int NOT NULL AUTO_INCREMENT COMMENT '班级id',
#   `teacher_id` int NOT NULL COMMENT '教师id',
#   `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级名称',
#   `invitation_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邀请码',
#   `join_number` int NOT NULL DEFAULT 0 COMMENT '加入人数',
#   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
#   `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
#   PRIMARY KEY (`id`) USING BTREE,
#   UNIQUE INDEX `teacherId_Name`(`name` ASC, `teacher_id` ASC) USING BTREE COMMENT '教师id与班级名称组合不重复',
#   INDEX `1`(`teacher_id` ASC) USING BTREE,
#   CONSTRAINT `1` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
# ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
#
# -- ----------------------------
# -- Table structure for class_problem
# -- ----------------------------
# DROP TABLE IF EXISTS `class_problem`;
# CREATE TABLE `class_problem`  (
#   `id` int NOT NULL AUTO_INCREMENT COMMENT '班级题目id',
#   `problem_id` int NOT NULL COMMENT '题库id',
#   `class_id` int NOT NULL COMMENT '班级id',
#   PRIMARY KEY (`id`) USING BTREE,
#   UNIQUE INDEX `p_idANDc_id`(`problem_id` ASC, `class_id` ASC) USING BTREE COMMENT '题目id，班级id唯一'
# ) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
#
# -- ----------------------------
# -- Table structure for class_score
# -- ----------------------------
# DROP TABLE IF EXISTS `class_score`;
# CREATE TABLE `class_score`  (
#   `id` int NOT NULL AUTO_INCREMENT COMMENT '班级学生题目得分id',
#   `sc_id` int NULL DEFAULT NULL COMMENT '指定学生_班级id',
#   `class_problem_id` int NULL DEFAULT NULL COMMENT '班级题目id',
#   `score` int NULL DEFAULT NULL COMMENT '得分',
#   `submit_number` int NOT NULL DEFAULT 0 COMMENT '提交次数',
#   `pass_number` int NOT NULL DEFAULT 0 COMMENT '通过次数',
#   PRIMARY KEY (`id`) USING BTREE,
#   UNIQUE INDEX `sc_id`(`sc_id` ASC, `class_problem_id` ASC) USING BTREE COMMENT '班级学生id与班级题目唯一'
# ) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '题库id',
  `title` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '题目标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '题目内容（md格式）',
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '题目答案（md格式）',
  `problem_tag_id` int NULL DEFAULT NULL COMMENT '标签组id',
  `grade` int NULL DEFAULT NULL COMMENT '题目等级（0简单，1一般，2困难）',
  `max_memory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '255' COMMENT '最大运行内存（MB)默认255',
  `max_time` int NOT NULL DEFAULT 3 COMMENT '最大运行时间（s）默认3',
  `input_test1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入1',
  `output_test1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输出1',
  `input_test2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入2',
  `output_test2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输出2',
  `input_test3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入3',
  `output_test3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输出3',
  `input_test4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输入4',
  `output_test4` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输出4',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for problem_tag
-- ----------------------------
DROP TABLE IF EXISTS `problem_tag`;
CREATE TABLE `problem_tag`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '题目标签id',
  `problem_id` int NOT NULL COMMENT '题目id',
  `tag_id` int NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `problem_id`(`problem_id` ASC, `tag_id` ASC) USING BTREE COMMENT '题目标签id联合不能相同'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for student_class
-- ----------------------------
# DROP TABLE IF EXISTS `student_class`;
# CREATE TABLE `student_class`  (
#   `id` int NOT NULL AUTO_INCREMENT COMMENT '表id',
#   `student_id` int NOT NULL COMMENT '学生id',
#   `class_id` int NOT NULL COMMENT '班级id',
#   `join_time` datetime NOT NULL COMMENT '加入时间',
#   PRIMARY KEY (`id`) USING BTREE,
#   UNIQUE INDEX `studentId_classId`(`student_id` ASC, `class_id` ASC) USING BTREE COMMENT '班级学生id联合唯一'
# ) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE COMMENT '标签名称唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
# DROP TABLE IF EXISTS `user`;
# CREATE TABLE `user`  (
#   `id` int NOT NULL AUTO_INCREMENT COMMENT '身份id',
#   `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
#   `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
#   `role` enum('student','teacher','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'student' COMMENT '角色',
#   `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
#   `status` tinyint NOT NULL DEFAULT 1 COMMENT '账号状态 0：禁用，1：启用',
#   `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
#   `profile_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像链接',
#   `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
#   `sex` tinyint NULL DEFAULT NULL COMMENT '性别 0：男，1：女',
#   `address` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
#   `score` int NULL DEFAULT NULL COMMENT '积分',
#   `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
#   `create_time` datetime NULL DEFAULT NULL COMMENT '创造时间',
#   `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
#   PRIMARY KEY (`id`) USING BTREE,
#   UNIQUE INDEX `用户名`(`username` ASC) USING BTREE COMMENT '用户名唯一',
#   UNIQUE INDEX `邮箱`(`email` ASC) USING BTREE COMMENT '邮箱唯一'
# ) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
#
# -- ----------------------------
# -- Table structure for webauthn_credential
# -- ----------------------------
# DROP TABLE IF EXISTS `webauthn_credential`;
# CREATE TABLE `webauthn_credential`  (
#   `id` int NOT NULL AUTO_INCREMENT,
#   `user_id` int NOT NULL COMMENT '用户id',
#   `credential_registration` json NULL COMMENT '注册凭据',
#   PRIMARY KEY (`id`) USING BTREE
# ) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;
#
# SET FOREIGN_KEY_CHECKS = 1;
