/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80024
 Source Host           : localhost:3306
 Source Schema         : ssm

 Target Server Type    : MySQL
 Target Server Version : 80024
 File Encoding         : 65001

 Date: 09/07/2021 09:48:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for c3p0testtable
-- ----------------------------
DROP TABLE IF EXISTS `c3p0testtable`;
CREATE TABLE `c3p0testtable`  (
  `a` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of c3p0testtable
-- ----------------------------

-- ----------------------------
-- Table structure for clazz
-- ----------------------------
DROP TABLE IF EXISTS `clazz`;
CREATE TABLE `clazz`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `gradeId` int NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gradeId`(`gradeId`) USING BTREE,
  CONSTRAINT `clazz_ibfk_1` FOREIGN KEY (`gradeId`) REFERENCES `grade` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clazz
-- ----------------------------
INSERT INTO `clazz` VALUES (12, 13, '网络1901', '网络专业2019届1班');
INSERT INTO `clazz` VALUES (13, 1, '软件1901', '软件技术专业1班');
INSERT INTO `clazz` VALUES (14, 12, '数媒1901', '数媒专业1901班');
INSERT INTO `clazz` VALUES (18, 12, '数媒1902', '数媒2班');

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of grade
-- ----------------------------
INSERT INTO `grade` VALUES (1, '软件技术', '信息工程学院软件技术专业2019届');
INSERT INTO `grade` VALUES (12, '数媒', '信息工程学院数媒专业2019届。');
INSERT INTO `grade` VALUES (13, '网络', '信息工程学院网络专业2019届。');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clazzId` int NOT NULL,
  `sn` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `remark` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `gradeId`(`clazzId`) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`clazzId`) REFERENCES `clazz` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (24, 13, 'S1543327958875', '张三', '123', '男', '/StudentManagerSSM/upload/1624603129877.jpg', '张三是河南人。');
INSERT INTO `student` VALUES (25, 13, 'S1543328011478', '李四', '123456', '男', '/StudentManagerSSM/upload/1543408773940.jpg', '李四是浏阳人');
INSERT INTO `student` VALUES (27, 14, 'S1543329112844', '合肥豪', '344', '男', '/StudentManagerSSM/photo/student.jpg', '合肥豪是个好人');
INSERT INTO `student` VALUES (32, 18, 'S123456789', '牛马', '1901', '男', '/StudentManagerSSM/photo/niuma.jpg', '牛马是株洲人');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin');
INSERT INTO `user` VALUES (2, 'waiting', '123456');
INSERT INTO `user` VALUES (8, 'hhh', '654321');

SET FOREIGN_KEY_CHECKS = 1;
