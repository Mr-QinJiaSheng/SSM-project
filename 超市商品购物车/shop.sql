/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50521
Source Host           : localhost:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50521
File Encoding         : 65001

Date: 2021-06-16 16:00:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `goodsid` int(11) NOT NULL COMMENT '商品id',
  `goodsname` varchar(50) NOT NULL COMMENT '商品名称',
  `goodsprice` double NOT NULL COMMENT '商品单价',
  `goodscount` int(11) NOT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for discount
-- ----------------------------
DROP TABLE IF EXISTS `discount`;
CREATE TABLE `discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打折编号',
  `moneycondition` double DEFAULT NULL COMMENT '满多少',
  `moneyreturn` double DEFAULT NULL COMMENT '减多少',
  `rate` double DEFAULT NULL COMMENT '打折率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of discount
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goodsname` varchar(50) NOT NULL COMMENT '商品名称',
  `price` double NOT NULL COMMENT '商品价格',
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '雨伞', '20', '10');
INSERT INTO `goods` VALUES ('2', '书包', '50', '10');
INSERT INTO `goods` VALUES ('3', '鼠标', '200', '10');
INSERT INTO `goods` VALUES ('4', '变形金刚', '10', '50');
INSERT INTO `goods` VALUES ('5', '键盘', '100', '20');
INSERT INTO `goods` VALUES ('6', '保温杯', '100', '30');
INSERT INTO `goods` VALUES ('7', '洗发露', '20', '50');
INSERT INTO `goods` VALUES ('8', '香皂', '10', '50');
INSERT INTO `goods` VALUES ('9', '插座', '60', '10');
INSERT INTO `goods` VALUES ('10', '电吹风', '40', '15');
INSERT INTO `goods` VALUES ('11', '水杯', '6', '20');
INSERT INTO `goods` VALUES ('12', '遥控飞机', '100', '15');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(50) NOT NULL COMMENT '用户姓名',
  `phone` varchar(50) NOT NULL COMMENT '用户手机号',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `status` int(11) NOT NULL COMMENT '1为用户；2为店主',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '买家', '12345678910', '123456', '1');
INSERT INTO `user` VALUES ('2', '店主', '19892027565', '123456', '2');
