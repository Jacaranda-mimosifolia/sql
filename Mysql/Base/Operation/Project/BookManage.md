/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : bookmanagement

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 03/11/2023 20:49:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE if not exists bookmanagement;
USE bookmanagement;

-- ----------------------------
-- Table structure for tb_admin
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin`  (
  `admin_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `admin_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员名称',
  `pwd` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES (1, 'admin', 'admin');
INSERT INTO `tb_admin` VALUES (2, 'admin1', 'admin1');

-- ----------------------------
-- Table structure for tb_book
-- ----------------------------
DROP TABLE IF EXISTS `tb_book`;
CREATE TABLE `tb_book`  (
  `book_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '图书id',
  `book_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书名称',
  `book_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书作者',
  `price` decimal(7, 1) NOT NULL COMMENT '图书定价',
  `book_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书类型',
  `isbn` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书ISBN号',
  `book_number` int(0) NOT NULL COMMENT '图书总数量',
  `cur_loan_number` int(0) NOT NULL DEFAULT 0 COMMENT '目前借出数量',
  PRIMARY KEY (`book_id`) USING BTREE,
  UNIQUE INDEX `isbn`(`isbn`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_book
-- ----------------------------
INSERT INTO `tb_book` VALUES (1, '数据库系统概论', '王珊、萨师煊', 39.0, '计算机', '978704040661', 3, 0);
INSERT INTO `tb_book` VALUES (2, 'java编程思想', 'Bruce Eckel', 108.0, '计算机', '978704040324', 3, 0);
INSERT INTO `tb_book` VALUES (3, '红星照耀中国', '（美）埃德加·斯诺 著，王涛 译', 39.8, '文学', '9787570204786', 2, 0);
INSERT INTO `tb_book` VALUES (4, '乡土中国', '费孝通', 132.0, '绘本', '9787555286240', 3, 0);

-- ----------------------------
-- Table structure for tb_bookbarcode
-- ----------------------------
DROP TABLE IF EXISTS `tb_bookbarcode`;
CREATE TABLE `tb_bookbarcode`  (
  `book_barcode_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '图书条码Id',
  `book_barcode` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图书条码(内部编码)',
  `book_id` int(0) NOT NULL COMMENT '图书编号',
  `loan_state` int(0) NOT NULL DEFAULT 1 COMMENT '在馆状态（0 表示不在馆，1表示在馆）',
  `is_loan` int(0) NOT NULL DEFAULT 1 COMMENT '是否可借（0 表示不可借，1表示可借）不可借是指该书可能丢失，或者可能不允许外借等等',
  PRIMARY KEY (`book_barcode_id`) USING BTREE,
  INDEX `book_id`(`book_id`) USING BTREE,
  CONSTRAINT `tb_bookbarcode_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `tb_book` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_bookbarcode
-- ----------------------------
INSERT INTO `tb_bookbarcode` VALUES (1, '111111', 1, 0, 1);
INSERT INTO `tb_bookbarcode` VALUES (2, '111112', 1, 0, 1);
INSERT INTO `tb_bookbarcode` VALUES (3, '111113', 1, 0, 1);
INSERT INTO `tb_bookbarcode` VALUES (4, '111114', 2, 1, 1);
INSERT INTO `tb_bookbarcode` VALUES (5, '111115', 2, 0, 1);
INSERT INTO `tb_bookbarcode` VALUES (6, '111116', 2, 1, 0);
INSERT INTO `tb_bookbarcode` VALUES (7, '111117', 3, 1, 1);
INSERT INTO `tb_bookbarcode` VALUES (8, '111118', 4, 1, 1);
INSERT INTO `tb_bookbarcode` VALUES (9, '111119', 4, 0, 1);

-- ----------------------------
-- Table structure for tb_borrow_return
-- ----------------------------
DROP TABLE IF EXISTS `tb_borrow_return`;
CREATE TABLE `tb_borrow_return`  (
  `borrow_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '借阅编号',
  `reader_id` int(0) NOT NULL COMMENT '读者id',
  `book_barcode_id` int(0) NOT NULL COMMENT '图书条码id',
  `borrow_date` datetime(0) NOT NULL COMMENT '借阅日期',
  `duereturn_date` datetime(0) NOT NULL COMMENT '应还日期',
  `return_date` datetime(0) NULL DEFAULT NULL COMMENT '实际归还日期',
  `overdue_penalty` decimal(7, 1) NULL DEFAULT NULL COMMENT '超期罚款',
  PRIMARY KEY (`borrow_id`) USING BTREE,
  INDEX `reader_id`(`reader_id`) USING BTREE,
  INDEX `book_barcode_id`(`book_barcode_id`) USING BTREE,
  CONSTRAINT `tb_borrow_return_ibfk_1` FOREIGN KEY (`reader_id`) REFERENCES `tb_reader` (`reader_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tb_borrow_return_ibfk_2` FOREIGN KEY (`book_barcode_id`) REFERENCES `tb_bookbarcode` (`book_barcode_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_borrow_return
-- ----------------------------
INSERT INTO `tb_borrow_return` VALUES (1, 1, 1, '2022-06-10 00:00:00', '2022-08-10 00:00:00', '2022-07-12 00:00:00', 0.0);
INSERT INTO `tb_borrow_return` VALUES (2, 1, 2, '2022-06-10 00:00:00', '2022-08-10 00:00:00', '2022-07-12 00:00:00', 0.0);
INSERT INTO `tb_borrow_return` VALUES (3, 1, 1, '2022-09-10 00:00:00', '2022-10-10 00:00:00', NULL, NULL);
INSERT INTO `tb_borrow_return` VALUES (4, 5, 2, '2022-09-15 00:00:00', '2022-10-15 00:00:00', NULL, NULL);
INSERT INTO `tb_borrow_return` VALUES (5, 5, 5, '2022-09-15 00:00:00', '2022-10-15 00:00:00', NULL, NULL);
INSERT INTO `tb_borrow_return` VALUES (8, 5, 3, '2022-09-15 00:00:00', '2022-10-15 00:00:00', NULL, NULL);
INSERT INTO `tb_borrow_return` VALUES (9, 5, 9, '2023-07-16 00:00:00', '2023-08-16 00:00:00', NULL, NULL);

-- ----------------------------
-- Table structure for tb_reader
-- ----------------------------
DROP TABLE IF EXISTS `tb_reader`;
CREATE TABLE `tb_reader`  (
  `reader_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '读者id',
  `reader_no` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '读者编号',
  `reader_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '读者真实姓名',
  `pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `sex` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `dept` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属部门/所在学院',
  `type_id` int(0) NULL DEFAULT NULL COMMENT '读者所属类别id',
  `type_name` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '读者所属类别',
  `cur_loan_number` int(0) NOT NULL DEFAULT 0 COMMENT '目前在借数量',
  `loan_number` int(0) NOT NULL DEFAULT 0 COMMENT '历史借阅数量',
  `state` int(0) NOT NULL DEFAULT 1 COMMENT '用户状态（0表示 删除、1表示 正常、2表示 挂失）',
  PRIMARY KEY (`reader_id`) USING BTREE,
  UNIQUE INDEX `reader_no`(`reader_no`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `tb_reader_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `tb_readertype` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_reader
-- ----------------------------
INSERT INTO `tb_reader` VALUES (1, 'r0001', '陈宝荣', '123456', '男', '软件学院', 1, '教职工', 1, 2, 1);
INSERT INTO `tb_reader` VALUES (2, 'r0002', '谢佳', '666666', '女', '软件学院', 1, '教职工', 0, 0, 1);
INSERT INTO `tb_reader` VALUES (3, 'r0003', '张晨阳', '666666', '男', '数信学院', 1, '教职工', 0, 0, 1);
INSERT INTO `tb_reader` VALUES (4, 'r0006', '龚佳倩', '666666', '女', '数信学院', 2, '研究生', 0, 0, 1);
INSERT INTO `tb_reader` VALUES (5, 'r0008', '施永强', '123456', '男', '计算机学院', 2, '研究生', 3, 0, 1);
INSERT INTO `tb_reader` VALUES (6, 'r0009', '刘丽', '666666', '女', '软件学院', 3, '本科生', 0, 0, 1);
INSERT INTO `tb_reader` VALUES (8, 'r0011', '马文勇', '666666', '男', '软件学院', 3, '本科生', 0, 0, 1);

-- ----------------------------
-- Table structure for tb_readertype
-- ----------------------------
DROP TABLE IF EXISTS `tb_readertype`;
CREATE TABLE `tb_readertype`  (
  `type_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '读者类型id',
  `type_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '读者类型（本科生，研究生，教职工）',
  `max_loan_number` int(0) NOT NULL COMMENT '最大借阅数量',
  `borrowing_period` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '借书期限（以月为单位）',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_readertype
-- ----------------------------
INSERT INTO `tb_readertype` VALUES (1, '教职工', 50, '2');
INSERT INTO `tb_readertype` VALUES (2, '研究生', 30, '1');
INSERT INTO `tb_readertype` VALUES (3, '本科生', 15, '1');

SET FOREIGN_KEY_CHECKS = 1;
