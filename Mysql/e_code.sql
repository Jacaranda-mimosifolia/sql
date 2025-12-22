/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : e_code

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 18/04/2025 14:38:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `teacher_id` int NOT NULL COMMENT '教师id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级名称',
  `invitation_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邀请码',
  `join_number` int NOT NULL DEFAULT 0 COMMENT '加入人数',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `teacherId_Name`(`name` ASC, `teacher_id` ASC) USING BTREE COMMENT '教师id与班级名称组合不重复',
  INDEX `1`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `1` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO `class` VALUES (13, 1, '21132', 'UCXXO9I', 0, '2024-11-29 22:37:49', '2024-11-29 22:37:49');
INSERT INTO `class` VALUES (18, 1, '321132', 'T8XCMTF', 0, '2024-11-30 22:08:10', '2024-11-30 22:08:10');
INSERT INTO `class` VALUES (19, 1, '22软件工程2班', '005Z0T0', 0, '2024-11-30 22:08:17', '2024-11-30 22:08:17');
INSERT INTO `class` VALUES (29, 1, '2022计科9班', 'YS4MWKU', 0, '2024-12-03 17:49:08', '2024-12-03 17:49:08');
INSERT INTO `class` VALUES (31, 1, '444444444', 'CCJPO70', 0, '2024-12-03 21:53:33', '2024-12-03 21:53:33');
INSERT INTO `class` VALUES (32, 1, '323', 'J4Q52UL', 0, '2024-12-04 09:40:03', '2024-12-04 09:40:03');
INSERT INTO `class` VALUES (34, 64, '22软件工程2班', 'XO41U4R', 4, '2024-12-04 15:43:52', '2025-01-02 14:48:44');
INSERT INTO `class` VALUES (37, 64, '23软件工程4班', 'I0QK0EI', 0, '2024-12-04 16:27:29', '2024-12-04 16:27:29');
INSERT INTO `class` VALUES (38, 64, '23软件工程5班', 'PSX0E13', 1, '2024-12-04 16:27:33', '2024-12-04 16:27:33');
INSERT INTO `class` VALUES (41, 64, '21物联网1班', 'A4JJKBU', 0, '2025-01-03 15:39:10', '2025-01-03 15:39:10');
INSERT INTO `class` VALUES (42, 64, '22大数据1班', 'HWQZYYF', 0, '2025-01-03 15:56:55', '2025-01-03 15:56:55');

-- ----------------------------
-- Table structure for class_problem
-- ----------------------------
DROP TABLE IF EXISTS `class_problem`;
CREATE TABLE `class_problem`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '班级题目id',
  `problem_id` int NOT NULL COMMENT '题库id',
  `class_id` int NOT NULL COMMENT '班级id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `p_idANDc_id`(`problem_id` ASC, `class_id` ASC) USING BTREE COMMENT '题目id，班级id唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class_problem
-- ----------------------------
INSERT INTO `class_problem` VALUES (17, 19, 34);
INSERT INTO `class_problem` VALUES (20, 20, 34);
INSERT INTO `class_problem` VALUES (19, 22, 34);
INSERT INTO `class_problem` VALUES (18, 23, 34);
INSERT INTO `class_problem` VALUES (27, 27, 34);
INSERT INTO `class_problem` VALUES (28, 28, 34);
INSERT INTO `class_problem` VALUES (25, 33, 34);
INSERT INTO `class_problem` VALUES (26, 34, 34);

-- ----------------------------
-- Table structure for class_score
-- ----------------------------
DROP TABLE IF EXISTS `class_score`;
CREATE TABLE `class_score`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '班级学生题目得分id',
  `sc_id` int NULL DEFAULT NULL COMMENT '指定学生_班级id',
  `class_problem_id` int NULL DEFAULT NULL COMMENT '班级题目id',
  `score` int NULL DEFAULT NULL COMMENT '得分',
  `submit_number` int NOT NULL DEFAULT 0 COMMENT '提交次数',
  `pass_number` int NOT NULL DEFAULT 0 COMMENT '通过次数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sc_id`(`sc_id` ASC, `class_problem_id` ASC) USING BTREE COMMENT '班级学生id与班级题目唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of class_score
-- ----------------------------
INSERT INTO `class_score` VALUES (16, 53, 17, 4, 4, 2);
INSERT INTO `class_score` VALUES (17, 53, 20, 4, 1, 1);
INSERT INTO `class_score` VALUES (18, 53, 19, 0, 2, 0);
INSERT INTO `class_score` VALUES (19, 57, 17, 4, 1, 1);
INSERT INTO `class_score` VALUES (20, 58, 25, 4, 1, 1);
INSERT INTO `class_score` VALUES (21, 59, 25, 4, 1, 1);

-- ----------------------------
-- Table structure for problem
-- ----------------------------
DROP TABLE IF EXISTS `problem`;
CREATE TABLE `problem`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '题库id',
  `title` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '题目标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '题目内容（md格式）',
  `require` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '要求，为空按默认值（md格式）',
  `problem_tag_id` int NULL DEFAULT NULL COMMENT '标签组id',
  `grade` int NULL DEFAULT NULL COMMENT '题目等级（0简单，1一般，2困难）',
  `max_memory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '512' COMMENT '最大运行内存（MB)默认512',
  `max_time` int NOT NULL DEFAULT 5 COMMENT '最大运行时间（s）默认5',
  `input_test1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入1',
  `output_test1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输出1',
  `input_test2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入2',
  `output_test2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输出2',
  `input_test3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '测试输入3',
  `output_test3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输出3',
  `input_test4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输入4',
  `output_test4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '测试输出4',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem
-- ----------------------------
INSERT INTO `problem` VALUES (19, '合并排序数组', '### 题目描述\n\n给定排序数组 A 和 B，实现一个算法将 B 按排序顺序合并到 A 中。介绍如下：\n\n1. 数组 A 和 B 的均为排序数组，数字按从小到大排列。\n\n2. 数组 A 的的长度为 $n$，其中前 $m$ 个为数字，后 $n-m$ 个为 `None`；数组 B 的长度为 $n-m$。\n\n3. 需要将数组 B 的数字依次添加到数组 A 中，添加元素后 A 的依旧是排序数组。\n\n### 输入描述\n\n第一行为两个数字 $n, m(1<n,m<1000)$，空格隔开，含义如题干所示。\n\n第二行为 $n$ 个数字，数组 A 中的前 $n$ 项元素。\n\n第三行为 $n-m$ 个数字，数组 B 中的元素。\n\n### 输出描述\n\n输出一行，为合并后的 A 数组。\n\n### 输入输出样例\n\n#### 示例\n\n> 输入\n\n```txt\n10 6\n1 2 5 7 8 9\n2 3 6 10\n```\n\n> 输出\n\n```txt\n1 2 2 3 5 6 7 8 9 10\n```', '35435', NULL, 0, '640', 5, '1', '1', '1', '1', '1', '1', '1', '1', '2025-01-01 16:11:52', '2025-01-03 15:25:11');
INSERT INTO `problem` VALUES (20, '寻找岛屿的周长', '### 题目描述\n\n实现一个算法找到岛屿的周长。介绍如下：\n\n给定一个包含 0 和 1 的二维网格地图，其中 1 表示陆地， 0 表示水域。\n\n网格单元在水平和垂直方向上连接。网格完全被水包围，并且网格上只有一个岛，岛上没有湖泊。\n\n网格中一个单元是一个边长为 1 的正方形。网格是矩形，宽度和高度不超过 100。\n\n需要实现一个算法确定岛的周长。岛的周长指的是 1 与 0 相邻的边的个数乘以边长。\n\n例如对于如下网格单元构成的岛屿，周长为 16。\n\n```txt\n    [[0,1,0,0],\n     [1,1,1,0],\n     [0,1,0,0],\n     [1,1,0,0]]\n```\n\n### 输入描述\n\n第一行输入两个数字 N，M（1<N,M<1000），表示网格地图的高和宽。\n\n接下来 $N$ 行，每行 $M$ 个元素，为网格地图。\n\n### 输出描述\n\n输出一个数字，为岛屿的周长。\n\n### 输入输出样例\n\n#### 示例\n\n> 输入\n\n```txt\n4 4\n0 1 0 0\n1 1 1 0\n0 1 0 0\n1 1 0 0\n```\n![3.jpg](2)\n> 输出\n\n```txt\n16\n```', '212', NULL, 1, '512', 5, '2', '2', '2', '2', '2', '2', '2', '2', '2025-01-01 16:32:05', '2025-01-01 21:13:11');
INSERT INTO `problem` VALUES (22, '数组中的最长连续子序列', '### 数组中的最长连续子序列\n\n### 题目描述\n\n给定一个未排序的整数数组 `nums`，找出其中最长的连续子序列（连续子序列中的元素在值上是连续的）。返回该子序列的长度。\n\n例如：\n- 如果 `nums = [100, 4, 200, 1, 3, 2]`，则最长的连续子序列为 `[1, 2, 3, 4]`，返回其长度 `4`。\n\n### 输入描述\n\n输入是一个整数数组 `nums`，其中每个元素都是一个整数。\n\n### 输出描述\n\n输出是一个整数，表示最长连续子序列的长度。\n\n### 输入输出样例\n\n#### 示例\n\n> 输入\n\n```txt\n[100, 4, 200, 1, 3, 2]\n```\n\n> 输出\n\n```txt\n4\n```\n\n### 提示\n\n- `0 <= nums.length <= 10^5`\n- `-10^9 <= nums[i] <= 10^9`\n\n### 解题思路\n\n1. 使用哈希集合来存储数组中的所有元素，以便在 O(1) 时间内检查某个元素是否存在。\n2. 遍历数组中的每个元素，如果该元素是当前连续子序列的起点（即它的前驱不在哈希集合中），则从该元素开始向后查找连续的元素，直到找不到为止。\n3. 记录每次找到的最长连续子序列的长度，并更新最大值。\n4. 最后返回最大值。', '无', NULL, 0, '512', 5, '1', '1', '2', '2', '3', '3', '4', '4', '2025-01-01 22:18:48', '2025-01-01 22:18:48');
INSERT INTO `problem` VALUES (23, '2025愿望计划', '### 2025年愿望实现计划\n\n### 题目描述\n\n假设现在是2025年，你有一个愿望清单，每个愿望都有一个实现的难度值。你的目标是在有限的时间内实现尽可能多的愿望。每个愿望的实现需要一定的时间，并且在实现过程中不能同时进行其他愿望。你需要编写一个算法来确定在给定时间内可以实现的最大愿望数量。\n\n例如：\n- 如果你有3个愿望，难度值分别为 `[3, 2, 1]`，并且你有4个单位时间，那么你可以实现最多2个愿望（选择难度值为1和2的愿望）。\n\n### 输入描述\n\n输入包含两行：\n- 第一行是一个整数 `n`，表示愿望的数量。\n- 第二行是 `n` 个整数，表示每个愿望的实现难度值。\n- 第三行是一个整数 `T`，表示你可用的总时间。\n\n### 输出描述\n\n输出是一个整数，表示在给定时间内可以实现的最大愿望数量。\n\n### 输入输出样例\n\n#### 示例\n\n> 输入\n\n```txt\n3\n3 2 1\n4\n```\n\n> 输出\n\n```txt\n2\n```\n\n### 提示\n\n- `1 <= n <= 10^5`\n- `1 <= 每个愿望的难度值 <= 10^9`\n- `1 <= T <= 10^12`\n\n### 解题思路\n\n1. 首先，对愿望的难度值进行排序，以便从最简单的愿望开始实现。\n2. 初始化一个变量 `count` 来记录已经实现的愿望数量，以及一个变量 `time_spent` 来记录已经花费的时间。\n3. 遍历排序后的愿望列表，依次尝试实现每个愿望：\n   - 如果当前愿望的难度值加上已花费的时间不超过总时间 `T`，则实现该愿望，并更新 `count` 和 `time_spent`。\n   - 否则，停止遍历。\n4. 返回 `count`，即在给定时间内可以实现的最大愿望数量。', '无', NULL, 0, '512', 5, '2025', '2025', '2025', '2025', '2025', '2025', '2025', '2025', '2025-01-01 22:25:51', '2025-01-03 15:04:57');
INSERT INTO `problem` VALUES (25, '密码脱落', '### 题目描述\n\nX 星球的考古学家发现了一批古代留下来的密码。\n\n这些密码是由 A、B、C、D 四种植物的种子串成的序列。\n\n仔细分析发现，这些密码串当初应该是前后对称的（也就是我们说的镜像串）。\n\n由于年代久远，其中许多种子脱落了，因而可能会失去镜像的特征。\n\n你的任务是：给定一个现在看到的密码串，计算一下从当初的状态，它要至少脱落多少个种子，才可能会变成现在的样子。\n\n### 输入描述\n\n输入一行，表示现在看到的密码串（长度不大于 1000）。\n\n### 输出描述\n\n要求输出一个正整数，表示至少脱落了多少个种子。\n\n### 输入输出样例\n\n#### 示例 1\n\n> 输入\n\n````txt\nABCBA\n\n```txt\n>输出\n```txt\n0\n```txt\n\n#### 示例2\n\n>输入\n```txt\nABDCDCBABC\n````\n\n> 输出', NULL, NULL, 1, '512', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-11 15:32:16', NULL);
INSERT INTO `problem` VALUES (27, '密文搜索', NULL, NULL, NULL, 0, '512', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-01-24 15:32:31', NULL);
INSERT INTO `problem` VALUES (28, '穿越雷区', '### 穿越雷区\n\n#### 题目描述\n\n实现一个算法帮助玩家安全穿越雷区。游戏地图是一个由 `0` 和 `1` 组成的二维网格，其中 `0` 表示空地，`1` 表示地雷。玩家从左上角（坐标 (0, 0)）出发，目标是到达右下角（坐标 (N-1, M-1)）。玩家只能向右或向下移动。\n\n你的任务是计算出一条安全路径，使得玩家可以避开所有地雷并成功到达终点。如果有多条路径可以选择，返回任意一条即可。如果无法找到安全路径，则返回空列表。\n\n#### 输入描述\n\n第一行输入两个数字 N，M（1 ≤ N, M ≤ 100），表示地图的高度和宽度。\n\n接下来 N 行，每行 M 个元素，为地图的布局。\n\n#### 输出描述\n\n输出一个列表，包含玩家的移动路径。路径中的每个元素是一个坐标 (x, y)，表示玩家在该位置。如果无法找到安全路径，输出空列表。\n\n#### 输入输出样例\n\n##### 示例 1\n\n> 输入\n\n```txt\n3 3\n0 0 0\n0 1 0\n0 0 0\n```\n\n> 输出\n\n```txt\n[(0, 0), (0, 1), (0, 2), (1, 2), (2, 2)]\n```\n\n##### 示例 2\n\n> 输入\n\n```txt\n3 3\n0 1 0\n0 1 0\n0 0 0\n```\n\n> 输出\n\n```txt\n[]\n```\n\n#### 提示\n\n- 地图中至少有一个空地。\n- 地图的左上角和右下角一定是空地。', NULL, NULL, 0, '512', 5, '', '', '', '', '', '', '', '', '2025-01-25 15:32:36', '2025-01-03 15:27:43');
INSERT INTO `problem` VALUES (29, '饮料换购', NULL, NULL, NULL, 2, '512', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-01-03 08:32:41', NULL);
INSERT INTO `problem` VALUES (30, '字符计数', NULL, NULL, NULL, 2, '512', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-28 15:32:47', NULL);
INSERT INTO `problem` VALUES (32, '练功', NULL, NULL, NULL, 0, '512', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-29 15:33:02', NULL);
INSERT INTO `problem` VALUES (33, '回文日期', '回文日期\n\n### 题目描述\n\n在日常生活中，通过年、月、日这三个要素可以表示出一个唯一确定的日期。\n\n牛牛习惯用 8 位数字表示一个日期，其中，前 4 位代表年份，接下来 2 位代表月份，最后 2\n位代表日期。显然：一个日期只有一种表示方法，而两个不同的日期的表示方法不会相同。\n\n牛牛认为，一个日期是回文的，当且仅当表示这个日期的 8 位数字是回文的。现在，牛牛想知道：在他指定的两个日期之间包含这两个日期本身），有多少个真实存在的日期是回文的。\n\n提示：\n\n一个 8 位数字是回文的，当且仅当对于所有的 $i (1 \\leq i \\leq 8)$ 从左向右数的第 $i$ 个数字和第 9 - $i$ 个数字（即从右向左数的第 $i$ 个数字）是相同的。\n\n例如：\n\n1. 对于 2016 年 11 月 19 日，用 8 位数字 20161119 表示，它不是回文的。\n\n2. 对于 2010 年 1 月 2 日，用 8 位数字 20100102 表示，它是回文的。\n\n3. 对于 2010 年 10 月 2 日，用 8 位数字 20101002 表示，它不是回文的。\n\n每一年中都有 12 个月份：\n\n其中，1,3,5,7,8,10,12 月每个月有 31 天；4,6,9,11 月每个月有 30 天；而对于 2 月，闰年时有 29 天，平年时有 28 天。\n\n一个年份是闰年当且仅当它满足下列两种情况其中的一种：\n\n1. 这个年份是 4 的整数倍，但不是 100 的整数倍；\n\n2. 这个年份是 400 的整数倍。\n\n例如：\n\n1. 以下几个年份都是闰年：2000,2012,2016。\n\n2. 以下几个年份是平年：1900,2011,2014。\n\n### 输入描述\n\n输入两行，每行包括一个 8 位数字。\n\n第一行表示牛牛指定的起始日期。\n\n第二行表示牛牛指定的终止日期。\n\n保证 $date_i$ 和都是真实存在的日期，且年份部分一定为 4 位数字，且首位数字不为 0。\n\n保证 $date_1$ 一定不晚于 $date_2$。\n\n### 输出描述\n\n输出一个整数，表示在 $date_1$ 和 $date_2$ 之间，有多少个日期是回文的。\n\n### 输入输出样例\n\n#### 示例 1\n\n> 输入\n\n```txt\n20110101\n20111231\n```\n\n> 输出\n\n```txt\n1\n```\n\n#### 示例 2\n\n> 输入\n\n```txt\n20000101\n20101231\n```\n\n> 输出\n\n```txt\n2\n```', '', NULL, 1, '512', 5, '20110101\n20111231', '1', '20000101\n20101231', '2', '20110101\n20111231', '1', '20000101\n20101231', '2', '2025-01-03 15:48:02', '2025-01-03 15:48:02');
INSERT INTO `problem` VALUES (34, '最大公约数与最小公倍数', '### 最大公约数与最小公倍数\n\n#### 题目描述\n\n给定两个正整数 \\(a\\) 和 \\(b\\)，编写一个程序来计算它们的最大公约数（GCD）和最小公倍数（LCM）。\n\n#### 输入描述\n\n输入包含两个整数 \\(a\\) 和 \\(b\\)（1 ≤ \\(a\\), \\(b\\) ≤ 10^9）。\n\n#### 输出描述\n\n输出两个整数，第一个是最大公约数（GCD），第二个是最小公倍数（LCM）。用空格分隔这两个整数。\n\n#### 输入输出样例\n\n##### 示例 1\n\n> 输入\n\n```txt\n12 18\n```\n\n> 输出\n\n```txt\n6 36\n```\n\n##### 示例 2\n\n> 输入\n\n```txt\n5 7\n```\n\n> 输出\n\n```txt\n1 35\n```\n\n##### 示例 3\n\n> 输入\n\n```txt\n24 36\n```\n\n> 输出\n\n```txt\n12 72\n```\n\n#### 提示\n\n- 最大公约数（GCD）可以使用欧几里得算法来计算。\n- 最小公倍数（LCM）可以通过以下公式计算：\\( \\text{LCM}(a, b) = \\frac{|a \\times b|}{\\text{GCD}(a, b)} \\)。\n\n#### 示例代码框架\n\n```python\ndef gcd(a, b):\n    # 你的代码在这里\n    pass\n\ndef lcm(a, b):\n    # 你的代码在这里\n    pass\n\n# 读取输入\na, b = map(int, input().split())\n\n# 计算并输出结果\ngcd_result = gcd(a, b)\nlcm_result = lcm(a, b)\nprint(f\"{gcd_result} {lcm_result}\")\n```\n\n请实现 `gcd` 和 `lcm` 函数来完成题目要求。', '', NULL, 0, '512', 5, '12 18', '6 36', '', '', '', '', '', '', '2025-01-03 16:01:46', '2025-01-03 16:01:46');

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
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of problem_tag
-- ----------------------------
INSERT INTO `problem_tag` VALUES (1, 6, 10);
INSERT INTO `problem_tag` VALUES (2, 6, 11);
INSERT INTO `problem_tag` VALUES (3, 10, 10);
INSERT INTO `problem_tag` VALUES (4, 11, 989);
INSERT INTO `problem_tag` VALUES (5, 11, 53534535);
INSERT INTO `problem_tag` VALUES (6, 18, 19);
INSERT INTO `problem_tag` VALUES (18, 19, 51);
INSERT INTO `problem_tag` VALUES (19, 19, 52);
INSERT INTO `problem_tag` VALUES (20, 19, 53);
INSERT INTO `problem_tag` VALUES (11, 20, 29);
INSERT INTO `problem_tag` VALUES (17, 23, 22);
INSERT INTO `problem_tag` VALUES (15, 24, 50);
INSERT INTO `problem_tag` VALUES (21, 28, 37);
INSERT INTO `problem_tag` VALUES (22, 33, 54);
INSERT INTO `problem_tag` VALUES (23, 34, 55);

-- ----------------------------
-- Table structure for student_class
-- ----------------------------
DROP TABLE IF EXISTS `student_class`;
CREATE TABLE `student_class`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '表id',
  `student_id` int NOT NULL COMMENT '学生id',
  `class_id` int NOT NULL COMMENT '班级id',
  `join_time` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `studentId_classId`(`student_id` ASC, `class_id` ASC) USING BTREE COMMENT '班级学生id联合唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_class
-- ----------------------------
INSERT INTO `student_class` VALUES (51, 69, 33, '2024-12-10 20:17:16');
INSERT INTO `student_class` VALUES (53, 69, 34, '2024-12-30 10:23:55');
INSERT INTO `student_class` VALUES (54, 69, 35, '2024-12-31 09:31:41');
INSERT INTO `student_class` VALUES (56, 69, 38, '2025-01-01 17:16:17');
INSERT INTO `student_class` VALUES (57, 71, 34, '2025-01-02 19:38:24');
INSERT INTO `student_class` VALUES (58, 24, 34, '2025-01-03 15:49:43');
INSERT INTO `student_class` VALUES (59, 72, 34, '2025-01-03 16:07:01');

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
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (10, '23212323422', '2024-12-28 22:41:23');
INSERT INTO `tag` VALUES (11, '232123234222', '2024-12-28 22:41:25');
INSERT INTO `tag` VALUES (12, '你好', '2024-12-31 08:35:12');
INSERT INTO `tag` VALUES (13, '在吗', '2024-12-31 08:35:19');
INSERT INTO `tag` VALUES (16, '动态规划', '2025-01-01 15:54:08');
INSERT INTO `tag` VALUES (17, '4545', '2025-01-01 16:01:22');
INSERT INTO `tag` VALUES (18, '56556', '2025-01-01 16:01:54');
INSERT INTO `tag` VALUES (19, '排序', '2025-01-01 16:04:59');
INSERT INTO `tag` VALUES (20, '132', '2025-01-01 16:09:17');
INSERT INTO `tag` VALUES (21, '合并', '2025-01-01 16:10:51');
INSERT INTO `tag` VALUES (22, '2025', '2025-01-01 16:11:04');
INSERT INTO `tag` VALUES (23, '2024', '2025-01-01 16:11:25');
INSERT INTO `tag` VALUES (24, 'yu', '2025-01-01 16:13:48');
INSERT INTO `tag` VALUES (25, '000', '2025-01-01 16:23:13');
INSERT INTO `tag` VALUES (26, '999', '2025-01-01 16:23:20');
INSERT INTO `tag` VALUES (27, '222', '2025-01-01 16:23:32');
INSERT INTO `tag` VALUES (28, 'nihao', '2025-01-01 16:25:21');
INSERT INTO `tag` VALUES (29, '寻找', '2025-01-01 16:31:49');
INSERT INTO `tag` VALUES (30, 'ni', '2025-01-01 20:40:57');
INSERT INTO `tag` VALUES (34, '111', '2025-01-01 20:52:41');
INSERT INTO `tag` VALUES (36, '223', '2025-01-01 21:12:56');
INSERT INTO `tag` VALUES (37, '数组', '2025-01-01 22:18:32');
INSERT INTO `tag` VALUES (41, '564', '2025-01-01 22:19:06');
INSERT INTO `tag` VALUES (45, '56', '2025-01-01 22:19:33');
INSERT INTO `tag` VALUES (46, '7867', '2025-01-01 22:22:19');
INSERT INTO `tag` VALUES (47, '你好3', '2025-01-01 22:22:27');
INSERT INTO `tag` VALUES (48, '78', '2025-01-01 22:22:35');
INSERT INTO `tag` VALUES (49, '564323', '2025-01-01 22:22:41');
INSERT INTO `tag` VALUES (50, '43', '2025-01-02 14:47:55');
INSERT INTO `tag` VALUES (51, '递归', '2025-01-03 15:24:22');
INSERT INTO `tag` VALUES (52, '最小生成树', '2025-01-03 15:24:33');
INSERT INTO `tag` VALUES (53, '单调队列', '2025-01-03 15:24:43');
INSERT INTO `tag` VALUES (54, '日期', '2025-01-03 15:47:13');
INSERT INTO `tag` VALUES (55, '数学', '2025-01-03 16:01:10');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '身份id',
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `role` enum('student','teacher','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'student' COMMENT '角色',
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '账号状态 0：禁用，1：启用',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `profile_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像链接',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `sex` tinyint NULL DEFAULT NULL COMMENT '性别 0：男，1：女',
  `address` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `score` int NULL DEFAULT NULL COMMENT '积分',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创造时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `用户名`(`username` ASC) USING BTREE COMMENT '用户名唯一',
  UNIQUE INDEX `邮箱`(`email` ASC) USING BTREE COMMENT '邮箱唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', 'admin', '32432', 1, '竹林听雨', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (2, 'teacher2', 'E10ADC3949BA59ABBE56E057F20F883E', 'admin', 'xuan@qq.com', 1, '李强', 'https://web-tlias-itheima1024.oss-cn-chengdu.aliyuncs.com/23f57464-eb9b-42a6-b98e-91ab1937fbf3.jpg', NULL, NULL, NULL, 0, NULL, '2024-09-24 18:56:14', '2024-09-24 18:56:14');
INSERT INTO `user` VALUES (24, 'student2', 'E10ADC3949BA59ABBE56E057F20F883E', 'student', '32432423', 1, '王刚', 'https://web-tlias-itheima1024.oss-cn-chengdu.aliyuncs.com/23f57464-eb9b-42a6-b98e-91ab1937fbf3.jpg', NULL, 1, NULL, 0, NULL, '2024-09-25 21:44:15', '2024-09-25 21:44:15');
INSERT INTO `user` VALUES (64, 'teacher1', 'E10ADC3949BA59ABBE56E057F20F883E', 'teacher', '2848067648@qqy.com', 1, '李老师', 'https://sky-take-out-xuanyue.oss-cn-chengdu.aliyuncs.com/3834e7a0-7e76-4117-94cb-c93c19ba0e94.jpg', '18181818188', 0, '云南大理', 0, '1991-06-13', '2024-10-05 21:29:35', '2024-10-05 21:29:35');
INSERT INTO `user` VALUES (69, 'student1', 'E10ADC3949BA59ABBE56E057F20F883E', 'student', 'xuanyue2003@foxmail.com', 1, '李梅', 'https://web-tlias-itheima1024.oss-cn-chengdu.aliyuncs.com/23f57464-eb9b-42a6-b98e-91ab1937fbf3.jpg', NULL, 1, NULL, 0, NULL, '2024-10-15 21:27:23', '2024-10-15 21:27:23');
INSERT INTO `user` VALUES (71, 'student3', 'E10ADC3949BA59ABBE56E057F20F883E', 'student', '2899999067644@qq.com', 1, '李勋', 'https://web-tlias-itheima1024.oss-cn-chengdu.aliyuncs.com/23f57464-eb9b-42a6-b98e-91ab1937fbf3.jpg', NULL, NULL, NULL, 0, NULL, '2025-01-02 19:37:40', '2025-01-02 19:37:40');
INSERT INTO `user` VALUES (72, 'liyue', 'E10ADC3949BA59ABBE56E057F20F883E', 'student', '2848067648@qq.com', 1, '李月', 'https://web-tlias-itheima1024.oss-cn-chengdu.aliyuncs.com/23f57464-eb9b-42a6-b98e-91ab1937fbf3.jpg', '19948923333', 1, '云南昆明', 0, '2007-06-21', '2025-01-03 16:05:14', '2025-01-03 16:05:14');

-- ----------------------------
-- Table structure for webauthn_credential
-- ----------------------------
DROP TABLE IF EXISTS `webauthn_credential`;
CREATE TABLE `webauthn_credential`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户id',
  `credential_registration` json NULL COMMENT '注册凭据',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of webauthn_credential
-- ----------------------------
INSERT INTO `webauthn_credential` VALUES (52, 69, '{\"useTime\": \"2025-04-18 13:22:42\", \"credential\": {\"userHandle\": \"AAAARQ\", \"backupState\": null, \"credentialId\": \"Go3VsjFqJBpJlQI3ldtwUvyNm1JzD5uZFMBJnOcAH78\", \"publicKeyCose\": \"pQECAyYgASFYIHzwdoq5wheiNFka6LSyoNdwpDqieAwUba9J7P-vDw5mIlggrhLoJo6qwtcU3YZkSmSH1TWZBGn8_cpD2kUE2aGlJ-o\", \"backupEligible\": null, \"signatureCount\": 3}, \"transports\": [\"internal\"], \"userIdentity\": {\"id\": \"AAAARQ\", \"name\": \"xuanyue2003@foxmail.com\", \"displayName\": \"student1\"}, \"registrationTime\": \"2025-04-16 16:00:38\", \"credentialNickname\": \"555\", \"attestationMetadata\": null}');

SET FOREIGN_KEY_CHECKS = 1;
