/*
 Navicat Premium Data Transfer

 Source Server         : 百度云
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 106.12.56.151:3306
 Source Schema         : drug_management_system

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 11/08/2021 17:05:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `DrugCode` varchar(17) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '药物链码（日期+单号）',
  `DrugID` int NOT NULL COMMENT '药物ID',
  `Owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '药品持有者',
  `OwnerID` int NULL DEFAULT NULL COMMENT '药品持有者ID',
  `ShipmentNUM` varchar(17) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '交易单号（日期+单号）',
  `Receive` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '药品收货方',
  `ReceiveID` int NULL DEFAULT NULL COMMENT '药品收货方ID',
  `ProductionDate` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '药品生产日期',
  `OptStatus` int NOT NULL COMMENT '药物状态（1-在库，2-交易，3-售出）',
  `TradingTime` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '交易日期',
  `ProductionCompany` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '生产公司',
  PRIMARY KEY (`DrugCode`) USING BTREE,
  INDEX `DrugID`(`DrugID`) USING BTREE,
  INDEX `Owner`(`Owner`) USING BTREE,
  INDEX `OwnerID`(`OwnerID`) USING BTREE,
  INDEX `Receive`(`Receive`) USING BTREE,
  INDEX `ReceiveID`(`ReceiveID`) USING BTREE,
  CONSTRAINT `drug_ibfk_1` FOREIGN KEY (`DrugID`) REFERENCES `drug_type` (`DrugID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drug_ibfk_2` FOREIGN KEY (`Owner`) REFERENCES `user_information` (`CompanyName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drug_ibfk_3` FOREIGN KEY (`OwnerID`) REFERENCES `user_information` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drug_ibfk_4` FOREIGN KEY (`Receive`) REFERENCES `user_information` (`CompanyName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drug_ibfk_5` FOREIGN KEY (`ReceiveID`) REFERENCES `user_information` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES ('DC120210809165825', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-09', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809170011', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809170014', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809170016', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809170017', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809170018', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809205059', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809205107', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC120210809205108', 1, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC620210809173825', 6, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-12', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC620210809205056', 6, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC620210809205102', 6, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC620210809205104', 6, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC620210809205105', 6, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-03', 1, NULL, '国药集团德众（佛山）药业有限公司');
INSERT INTO `drug` VALUES ('DC720210810103901', 7, '国药集团德众（佛山）药业有限公司', 47, NULL, NULL, NULL, '2021-08-02', 1, NULL, '国药集团德众（佛山）药业有限公司');

-- ----------------------------
-- Table structure for drug_type
-- ----------------------------
DROP TABLE IF EXISTS `drug_type`;
CREATE TABLE `drug_type`  (
  `DrugID` int NOT NULL AUTO_INCREMENT,
  `DrugName` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '药品名称',
  `DrugComposition` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '药物成分',
  `UsageMethod` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '使用方法',
  `MainFunction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '主治功能',
  PRIMARY KEY (`DrugID`) USING BTREE,
  UNIQUE INDEX `DrugName`(`DrugName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug_type
-- ----------------------------
INSERT INTO `drug_type` VALUES (1, '阿莫西林', '阿莫西林', '口服：①成人1次0.5g，每6～8小时1次，每日剂量不超过4g；②小儿每日20～40mg/kg，每8小时1次服用。', '阿莫西林主要用于治疗敏感菌所致的呼吸道感染，尿路感染和胆道感染及伤寒等感染，其治疗效果也是比较好的。阿莫西林属于广谱的抗生素，可以通过抑制细菌细胞壁合成而发挥杀菌的作用。可以使细菌迅速成为球状体而溶解，破裂，对于革兰氏阴性菌和阳性菌具有较强的迅速的杀灭作用，对钩端螺旋体也有杀灭的作用。');
INSERT INTO `drug_type` VALUES (6, '碘酒', '聚维酮碘粉，纯化水', '1、手术补位及注射部位的皮肤消毒：用原注直接擦拭2遍，作用3-5分钟。2、外科手术消毒：用原注直接擦拭2遍，作用3-5分钟，再用无菌水洗净。', '碘伏具有广谱杀菌作用，可杀灭细菌繁殖体、真菌、原虫和部分病毒。在医疗上用作杀菌消毒剂，可用于皮肤、粘膜的消毒，也可处理烫伤、治疗滴虫性阴道炎、霉菌性阴道炎、皮肤霉菌感染等。也可用于手术前和其它皮肤的消毒、各种注射部位皮肤消毒、器械浸泡消毒以及阴道手术前消毒等。');
INSERT INTO `drug_type` VALUES (7, '娃哈哈', 'bb', '123', '123');
INSERT INTO `drug_type` VALUES (9, '哇哈哈', '哇哈哈', '哇哈哈', '哇哈哈');
INSERT INTO `drug_type` VALUES (12, '哈哈药', '哈哈哈', '口服', '分泌多巴胺');

-- ----------------------------
-- Table structure for user_account
-- ----------------------------
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account`  (
  `UID` int NOT NULL AUTO_INCREMENT,
  `Uname` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `Upwd` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE INDEX `Uname`(`Uname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_account
-- ----------------------------
INSERT INTO `user_account` VALUES (47, '123', '123');
INSERT INTO `user_account` VALUES (50, '1', '1');
INSERT INTO `user_account` VALUES (51, 'xsk', '123456789');

-- ----------------------------
-- Table structure for user_information
-- ----------------------------
DROP TABLE IF EXISTS `user_information`;
CREATE TABLE `user_information`  (
  `UID` int NOT NULL,
  `CompanyName` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公司名称',
  `Director` varchar(6) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公司负责人',
  `Address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公司地址',
  `CompanyProfile` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '公司简介',
  `PhoneNUM` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '公司电话',
  `Power` int NOT NULL COMMENT '权限（1-生产商，2-经销商）',
  UNIQUE INDEX `ConpanyName`(`CompanyName`) USING BTREE,
  INDEX `UID`(`UID`) USING BTREE,
  CONSTRAINT `user_information_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user_account` (`UID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_information
-- ----------------------------
INSERT INTO `user_information` VALUES (51, '123', '123', '123', NULL, '18574452339', 1);
INSERT INTO `user_information` VALUES (47, '国药集团德众（佛山）药业有限公司', '张三', '广州佛山', NULL, '13811111111', 1);
INSERT INTO `user_information` VALUES (50, '老百姓大药房（永州）', '李四', '湖南省永州市冷水滩区长丰集团', NULL, '13966666666', 2);

-- ----------------------------
-- Table structure for user_jurisdiction
-- ----------------------------
DROP TABLE IF EXISTS `user_jurisdiction`;
CREATE TABLE `user_jurisdiction`  (
  `ClassName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ImgSrc` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `Jurisdiction` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_jurisdiction
-- ----------------------------
INSERT INTO `user_jurisdiction` VALUES ('Anti_counterfeiting', './img/查询.svg', '防伪查询', 0);
INSERT INTO `user_jurisdiction` VALUES ('Trace', './img/订单溯源.svg', '溯源查询', 0);
INSERT INTO `user_jurisdiction` VALUES ('Warehousing', './img/收货.svg', '收货', 0);
INSERT INTO `user_jurisdiction` VALUES ('Shipment', './img/发货-01.svg', '发货', 0);
INSERT INTO `user_jurisdiction` VALUES ('Warehouse', './img/仓库.svg', '仓库', 0);
INSERT INTO `user_jurisdiction` VALUES ('Production', './img/药品.svg', '生产入库', 1);
INSERT INTO `user_jurisdiction` VALUES ('R&D', './img/药物分析.svg', '药物研发', 1);
INSERT INTO `user_jurisdiction` VALUES ('Retail', './img/零售业.svg', '零售', 2);

-- ----------------------------
-- Table structure for verification_code
-- ----------------------------
DROP TABLE IF EXISTS `verification_code`;
CREATE TABLE `verification_code`  (
  `VerificationCode` varchar(4) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '验证码内容',
  UNIQUE INDEX `VerificationCode`(`VerificationCode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of verification_code
-- ----------------------------
INSERT INTO `verification_code` VALUES ('1p2o');
INSERT INTO `verification_code` VALUES ('2d4p');
INSERT INTO `verification_code` VALUES ('2n3k');
INSERT INTO `verification_code` VALUES ('abdp');
INSERT INTO `verification_code` VALUES ('dfnd');
INSERT INTO `verification_code` VALUES ('dppd');
INSERT INTO `verification_code` VALUES ('kmkj');
INSERT INTO `verification_code` VALUES ('lkm8');
INSERT INTO `verification_code` VALUES ('nnmm');
INSERT INTO `verification_code` VALUES ('ppop');
INSERT INTO `verification_code` VALUES ('unix');

SET FOREIGN_KEY_CHECKS = 1;
