/*
 Navicat Premium Data Transfer

 Source Server         : aa
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : rms

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 09/07/2021 10:06:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` bigint(19) NULL DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT 0,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组织机构' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES (1, '总经办', '', '01', 'define-depart', NULL, 0, '2021-07-02 01:00:00');
INSERT INTO `organization` VALUES (3, '技术部', '', '02', 'define-depart', NULL, 1, '2020-07-02 13:10:42');
INSERT INTO `organization` VALUES (6, '测试组', 'www.baidu.com', '04', 'define-group', 3, 0, '2020-07-02 13:12:18');
INSERT INTO `organization` VALUES (8, '开发部', '', '05', 'define-depart', NULL, 0, '2021-07-08 20:44:56');
INSERT INTO `organization` VALUES (9, 'hh', '', '06', 'define-depart', NULL, 0, '2021-07-08 20:55:26');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` bigint(19) NULL DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `resourcetype` tinyint(2) NOT NULL DEFAULT 0,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 227 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资源' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES (1, '系统管理', '', NULL, '系统管理', 'icon-xitongguanli', NULL, 3, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (11, '资源管理', '/resource/manager', NULL, '资源管理', 'icon-ziyuanguanli1', 223, 3, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (12, '角色管理', '/role/manager', NULL, '角色管理', 'icon-jiaoseguanli', 223, 2, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (13, '用户信息管理', '/user/manager', NULL, '用户管理', 'icon-untitled85', 223, 1, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (14, '部门资源', '/organization/manager', NULL, '部门管理', 'icon-bumen1', 223, 4, 0, 0, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (111, '列表', '/resource/treeGrid', 'resource:list', '资源列表', 'define-list', 11, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (112, '添加', '/resource/add', 'resource:add', '资源添加', 'define-add', 11, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (113, '编辑', '/resource/edit', 'resource:edit', '资源编辑', 'define-edit', 11, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (114, '删除', '/resource/delete', 'resource:delete', '资源删除', 'define-del', 11, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (121, '列表', '/role/dataGrid', 'role:list', '角色列表', 'define-list', 12, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (122, '添加', '/role/add', 'role:add', '角色添加', 'define-add', 12, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (123, '编辑', '/role/edit', 'role:edit', '角色编辑', 'define-edit', 12, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (124, '删除', '/role/delete', 'role:delete', '角色删除', 'define-del', 12, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (125, '授权', '/role/grant', 'role:grant', '角色授权', 'define-true', 12, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (131, '列表', '/user/dataGrid', 'user:list', '用户列表', 'define-list', 13, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (132, '添加', '/user/add', 'user:add', '用户添加', 'define-add', 13, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (133, '编辑', '/user/edit', 'user:edit', '用户编辑', 'define-edit', 13, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (134, '删除', '/user/delete', 'user:delete', '用户删除', 'define-del', 13, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (141, '列表', '/organization/treeGrid', 'organization:list', '用户列表', 'define-list', 14, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (142, '添加', '/organization/add', 'organization:add', '部门添加', 'define-add', 14, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (143, '编辑', '/organization/edit', 'organization:edit', '部门编辑', 'define-edit', 14, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (144, '删除', '/organization/delete', 'organization:delete', '部门删除', 'define-del', 14, 0, 0, 1, '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES (221, '日志管理', '/log/manager', NULL, NULL, 'icon-rizhiguanli', 1, 1, 0, 0, '2015-12-01 11:44:20');
INSERT INTO `resource` VALUES (222, '后台首页', '/main', '', NULL, 'icon-houtai', NULL, 0, 0, 0, '2019-01-11 10:16:17');
INSERT INTO `resource` VALUES (223, '管理员管理', '', NULL, NULL, 'icon-guanliyuan', NULL, 1, 0, 0, '2019-01-11 11:06:20');
INSERT INTO `resource` VALUES (224, '字典管理', '/dictionary/manager', '', NULL, 'icon-rizhiguanli1', 1, 0, 0, 0, '2019-01-23 09:43:19');
INSERT INTO `resource` VALUES (225, '批量删除', '/log/batchDelete', 'log:batchDelete', NULL, 'define-del', 221, 1, 0, 1, '2019-02-21 15:43:54');
INSERT INTO `resource` VALUES (226, '列表', '/log/dataGrid', 'log:list', NULL, 'define-list', 221, 0, 0, 1, '2019-02-22 11:31:37');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT 0,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', 0, '超级管理员', 0);
INSERT INTO `role` VALUES (2, '技术部经理', 0, '技术部经理', 1);
INSERT INTO `role` VALUES (8, '测试账户', 0, '测试账户', 0);
INSERT INTO `role` VALUES (10, '部门管理员', 0, '管理相关部门', 0);

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(19) NOT NULL,
  `resource_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1187 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色资源' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES (1089, 8, 222);
INSERT INTO `role_resource` VALUES (1090, 8, 223);
INSERT INTO `role_resource` VALUES (1091, 8, 13);
INSERT INTO `role_resource` VALUES (1092, 8, 131);
INSERT INTO `role_resource` VALUES (1093, 8, 12);
INSERT INTO `role_resource` VALUES (1094, 8, 121);
INSERT INTO `role_resource` VALUES (1095, 8, 11);
INSERT INTO `role_resource` VALUES (1096, 8, 111);
INSERT INTO `role_resource` VALUES (1097, 8, 14);
INSERT INTO `role_resource` VALUES (1098, 8, 141);
INSERT INTO `role_resource` VALUES (1099, 8, 1);
INSERT INTO `role_resource` VALUES (1100, 8, 224);
INSERT INTO `role_resource` VALUES (1101, 8, 221);
INSERT INTO `role_resource` VALUES (1102, 8, 226);
INSERT INTO `role_resource` VALUES (1103, 1, 222);
INSERT INTO `role_resource` VALUES (1104, 1, 223);
INSERT INTO `role_resource` VALUES (1105, 1, 13);
INSERT INTO `role_resource` VALUES (1106, 1, 131);
INSERT INTO `role_resource` VALUES (1107, 1, 132);
INSERT INTO `role_resource` VALUES (1108, 1, 133);
INSERT INTO `role_resource` VALUES (1109, 1, 134);
INSERT INTO `role_resource` VALUES (1110, 1, 12);
INSERT INTO `role_resource` VALUES (1111, 1, 121);
INSERT INTO `role_resource` VALUES (1112, 1, 122);
INSERT INTO `role_resource` VALUES (1113, 1, 123);
INSERT INTO `role_resource` VALUES (1114, 1, 124);
INSERT INTO `role_resource` VALUES (1115, 1, 125);
INSERT INTO `role_resource` VALUES (1116, 1, 11);
INSERT INTO `role_resource` VALUES (1117, 1, 111);
INSERT INTO `role_resource` VALUES (1118, 1, 112);
INSERT INTO `role_resource` VALUES (1119, 1, 113);
INSERT INTO `role_resource` VALUES (1120, 1, 114);
INSERT INTO `role_resource` VALUES (1121, 1, 14);
INSERT INTO `role_resource` VALUES (1122, 1, 141);
INSERT INTO `role_resource` VALUES (1123, 1, 142);
INSERT INTO `role_resource` VALUES (1124, 1, 143);
INSERT INTO `role_resource` VALUES (1125, 1, 144);
INSERT INTO `role_resource` VALUES (1126, 1, 1);
INSERT INTO `role_resource` VALUES (1127, 1, 224);
INSERT INTO `role_resource` VALUES (1128, 1, 221);
INSERT INTO `role_resource` VALUES (1129, 1, 226);
INSERT INTO `role_resource` VALUES (1130, 1, 225);
INSERT INTO `role_resource` VALUES (1145, 10, 222);
INSERT INTO `role_resource` VALUES (1146, 10, 223);
INSERT INTO `role_resource` VALUES (1147, 10, 13);
INSERT INTO `role_resource` VALUES (1148, 10, 131);
INSERT INTO `role_resource` VALUES (1149, 10, 12);
INSERT INTO `role_resource` VALUES (1150, 10, 121);
INSERT INTO `role_resource` VALUES (1151, 10, 11);
INSERT INTO `role_resource` VALUES (1152, 10, 111);
INSERT INTO `role_resource` VALUES (1153, 10, 14);
INSERT INTO `role_resource` VALUES (1154, 10, 141);
INSERT INTO `role_resource` VALUES (1155, 10, 1);
INSERT INTO `role_resource` VALUES (1156, 10, 224);
INSERT INTO `role_resource` VALUES (1157, 10, 221);
INSERT INTO `role_resource` VALUES (1158, 10, 226);
INSERT INTO `role_resource` VALUES (1173, 2, 222);
INSERT INTO `role_resource` VALUES (1174, 2, 223);
INSERT INTO `role_resource` VALUES (1175, 2, 13);
INSERT INTO `role_resource` VALUES (1176, 2, 131);
INSERT INTO `role_resource` VALUES (1177, 2, 12);
INSERT INTO `role_resource` VALUES (1178, 2, 121);
INSERT INTO `role_resource` VALUES (1179, 2, 11);
INSERT INTO `role_resource` VALUES (1180, 2, 111);
INSERT INTO `role_resource` VALUES (1181, 2, 14);
INSERT INTO `role_resource` VALUES (1182, 2, 141);
INSERT INTO `role_resource` VALUES (1183, 2, 1);
INSERT INTO `role_resource` VALUES (1184, 2, 224);
INSERT INTO `role_resource` VALUES (1185, 2, 221);
INSERT INTO `role_resource` VALUES (1186, 2, 226);

-- ----------------------------
-- Table structure for syslog
-- ----------------------------
DROP TABLE IF EXISTS `syslog`;
CREATE TABLE `syslog`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operationName` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作',
  `operationClass` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `operationAddress` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行方法',
  `params` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 369 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of syslog
-- ----------------------------
INSERT INTO `syslog` VALUES (83, '系统自动任务', '定时删除日志：1条', '', '', '', '', '2019-02-22 09:52:30');
INSERT INTO `syslog` VALUES (84, '系统自动任务', '定时删除日志：0条', '', '', '', '', '2019-02-22 10:41:32');
INSERT INTO `syslog` VALUES (85, '系统自动任务', '定时删除日志：0条', '', '', '', '', '2019-02-22 10:41:40');
INSERT INTO `syslog` VALUES (86, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 10:51:52');
INSERT INTO `syslog` VALUES (87, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=yongfeng.L&password=&sex=0&age=21&usertype=1&organizationId=1&roleIds=1&phone=18296633676&status=0&', '127.0.0.1', '2019-02-22 10:52:36');
INSERT INTO `syslog` VALUES (88, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 10:52:50');
INSERT INTO `syslog` VALUES (89, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=10&resourceIds=222,223,13,131,1,221&', '127.0.0.1', '2019-02-22 10:52:57');
INSERT INTO `syslog` VALUES (90, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 10:53:00');
INSERT INTO `syslog` VALUES (91, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 10:53:00');
INSERT INTO `syslog` VALUES (92, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 11:00:53');
INSERT INTO `syslog` VALUES (93, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 11:00:57');
INSERT INTO `syslog` VALUES (94, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '127.0.0.1', '2019-02-22 11:00:59');
INSERT INTO `syslog` VALUES (113, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=8&resourceIds=222,223,13,131,12,121,11,111,1,224,221&', '127.0.0.1', '2019-02-22 11:37:16');
INSERT INTO `syslog` VALUES (116, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 11:37:18');
INSERT INTO `syslog` VALUES (132, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:05');
INSERT INTO `syslog` VALUES (134, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=1&resourceIds=222,223,13,131,132,133,134,12,121,122,123,124,125,11,111,112,113,114,14,141,142,143,144,1,224,221,226,225&', '127.0.0.1', '2019-02-22 12:49:16');
INSERT INTO `syslog` VALUES (135, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:18');
INSERT INTO `syslog` VALUES (136, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:49:18');
INSERT INTO `syslog` VALUES (137, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=2&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '127.0.0.1', '2019-02-22 12:49:25');
INSERT INTO `syslog` VALUES (138, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:49:27');
INSERT INTO `syslog` VALUES (139, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:27');
INSERT INTO `syslog` VALUES (140, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=10&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '127.0.0.1', '2019-02-22 12:50:05');
INSERT INTO `syslog` VALUES (141, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:50:07');
INSERT INTO `syslog` VALUES (142, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:50:07');
INSERT INTO `syslog` VALUES (143, 'admin', '角色信息编辑', 'SystemManage.RoleManage.controller.RoleController', '/role/edit', 'id=10&name=部门管理员&seq=0&status=0&description=管理相关部门&', '127.0.0.1', '2019-02-22 12:50:13');
INSERT INTO `syslog` VALUES (144, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:50:20');
INSERT INTO `syslog` VALUES (145, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '127.0.0.1', '2019-02-22 12:50:39');
INSERT INTO `syslog` VALUES (146, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '127.0.0.1', '2019-02-22 12:51:26');
INSERT INTO `syslog` VALUES (147, 'admin', '部门信息编辑', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/edit', 'id=6&code=04&name=测试组&seq=0&icon=define-group&address=www.baidu.com&pid=3&', '127.0.0.1', '2019-02-22 12:51:37');
INSERT INTO `syslog` VALUES (148, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:51:46');
INSERT INTO `syslog` VALUES (149, 'admin', '日志信息批量删除', 'SystemManage.LogManage.controller.LogController', '/log/batchDelete', 'ids=112,111,110,109,108,107,106,105,104,102,103,101,100,99,98,97,96,95&', '127.0.0.1', '2019-02-22 12:52:13');
INSERT INTO `syslog` VALUES (150, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:52:15');
INSERT INTO `syslog` VALUES (151, 'admin', '日志信息批量删除', 'SystemManage.LogManage.controller.LogController', '/log/batchDelete', 'ids=133,131,130,129,128,127,126,125,123,124,122,121,120,119,118,117,114,115&', '127.0.0.1', '2019-02-22 12:53:05');
INSERT INTO `syslog` VALUES (152, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:53:06');
INSERT INTO `syslog` VALUES (153, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:54:14');
INSERT INTO `syslog` VALUES (154, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '117.44.235.8', '2019-02-22 13:15:09');
INSERT INTO `syslog` VALUES (155, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '117.44.235.8', '2019-02-22 13:15:13');
INSERT INTO `syslog` VALUES (156, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '117.44.235.8', '2019-02-22 13:15:14');
INSERT INTO `syslog` VALUES (157, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '117.44.235.8', '2019-02-22 13:15:16');
INSERT INTO `syslog` VALUES (158, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:15:21');
INSERT INTO `syslog` VALUES (159, 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '117.44.235.8', '2019-02-22 13:15:55');
INSERT INTO `syslog` VALUES (160, 'test', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '117.44.235.8', '2019-02-22 13:16:04');
INSERT INTO `syslog` VALUES (161, 'test', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '117.44.235.8', '2019-02-22 13:16:09');
INSERT INTO `syslog` VALUES (162, 'test', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '117.44.235.8', '2019-02-22 13:16:19');
INSERT INTO `syslog` VALUES (163, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:16:23');
INSERT INTO `syslog` VALUES (164, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:17:28');
INSERT INTO `syslog` VALUES (165, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:15');
INSERT INTO `syslog` VALUES (166, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:18');
INSERT INTO `syslog` VALUES (167, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:19');
INSERT INTO `syslog` VALUES (168, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:19');
INSERT INTO `syslog` VALUES (169, 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:42');
INSERT INTO `syslog` VALUES (170, 'test', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:42');
INSERT INTO `syslog` VALUES (171, 'test', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:42');
INSERT INTO `syslog` VALUES (172, 'test', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:32:42');
INSERT INTO `syslog` VALUES (173, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:36:31');
INSERT INTO `syslog` VALUES (174, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:36:31');
INSERT INTO `syslog` VALUES (175, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:36:31');
INSERT INTO `syslog` VALUES (176, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:36:31');
INSERT INTO `syslog` VALUES (177, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:37:00');
INSERT INTO `syslog` VALUES (178, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:40:03');
INSERT INTO `syslog` VALUES (179, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:40:03');
INSERT INTO `syslog` VALUES (180, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:40:03');
INSERT INTO `syslog` VALUES (181, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:40:03');
INSERT INTO `syslog` VALUES (182, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 15:40:03');
INSERT INTO `syslog` VALUES (183, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 16:21:47');
INSERT INTO `syslog` VALUES (184, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 16:21:48');
INSERT INTO `syslog` VALUES (185, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 16:22:01');
INSERT INTO `syslog` VALUES (186, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-15 16:22:02');
INSERT INTO `syslog` VALUES (187, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 08:28:34');
INSERT INTO `syslog` VALUES (188, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 08:28:35');
INSERT INTO `syslog` VALUES (189, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 08:28:35');
INSERT INTO `syslog` VALUES (190, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 19:29:39');
INSERT INTO `syslog` VALUES (191, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 19:29:40');
INSERT INTO `syslog` VALUES (192, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 19:29:41');
INSERT INTO `syslog` VALUES (193, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 19:29:44');
INSERT INTO `syslog` VALUES (194, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-16 19:30:00');
INSERT INTO `syslog` VALUES (195, 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:16:42');
INSERT INTO `syslog` VALUES (196, 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:20:20');
INSERT INTO `syslog` VALUES (197, 'test', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:20:23');
INSERT INTO `syslog` VALUES (198, 'test', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:20:28');
INSERT INTO `syslog` VALUES (199, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:21:09');
INSERT INTO `syslog` VALUES (200, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:21:53');
INSERT INTO `syslog` VALUES (201, 'test', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:22:33');
INSERT INTO `syslog` VALUES (202, 'test', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:23:45');
INSERT INTO `syslog` VALUES (203, 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:23:47');
INSERT INTO `syslog` VALUES (204, 'test', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:23:56');
INSERT INTO `syslog` VALUES (205, 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:24:06');
INSERT INTO `syslog` VALUES (206, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:27:05');
INSERT INTO `syslog` VALUES (207, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:27:08');
INSERT INTO `syslog` VALUES (208, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:27:09');
INSERT INTO `syslog` VALUES (209, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:27:13');
INSERT INTO `syslog` VALUES (210, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-28 11:27:17');
INSERT INTO `syslog` VALUES (211, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:05:51');
INSERT INTO `syslog` VALUES (212, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:05:53');
INSERT INTO `syslog` VALUES (213, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:05:54');
INSERT INTO `syslog` VALUES (214, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:05:55');
INSERT INTO `syslog` VALUES (215, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:05:57');
INSERT INTO `syslog` VALUES (216, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=&sex=0&age=21&usertype=1&organizationId=1&roleIds=1&phone=18296633676&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:06:50');
INSERT INTO `syslog` VALUES (217, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=14&loginname=tian&name=田思凯&password=&sex=0&age=25&usertype=1&organizationId=6&roleIds=2&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:07:33');
INSERT INTO `syslog` VALUES (218, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=15&loginname=yyc&name=于一川&password=123&sex=0&age=6&usertype=1&organizationId=6&roleIds=8&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:20');
INSERT INTO `syslog` VALUES (219, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=14&loginname=tian&name=田思凯&password=123&sex=0&age=25&usertype=1&organizationId=6&roleIds=2&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:25');
INSERT INTO `syslog` VALUES (220, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=123&sex=0&age=21&usertype=1&organizationId=1&roleIds=1&phone=18296633676&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:32');
INSERT INTO `syslog` VALUES (221, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=&sex=0&age=19&usertype=1&organizationId=1&roleIds=1&phone=18296633676&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:44');
INSERT INTO `syslog` VALUES (222, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=14&loginname=tian&name=田思凯&password=&sex=0&age=19&usertype=1&organizationId=6&roleIds=2&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:51');
INSERT INTO `syslog` VALUES (223, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=15&loginname=yyc&name=于一川&password=&sex=0&age=19&usertype=1&organizationId=6&roleIds=8&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:08:57');
INSERT INTO `syslog` VALUES (224, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=18&loginname=hsy&name=郝诗扬&password=123&sex=0&age=20&usertype=1&organizationId=3&roleIds=8&phone=12306&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:09:34');
INSERT INTO `syslog` VALUES (225, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=19&loginname=yir&name=易如&password=123&sex=1&age=19&usertype=1&organizationId=5&roleIds=8&phone=12345609&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:10:22');
INSERT INTO `syslog` VALUES (226, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=14&loginname=tian&name=田思凯&password=&sex=0&age=19&usertype=1&organizationId=3&roleIds=2&phone=18707173376&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:10:40');
INSERT INTO `syslog` VALUES (227, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=18&loginname=hsy&name=郝诗扬&password=&sex=0&age=20&usertype=1&organizationId=6&roleIds=8&phone=12306&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:10:46');
INSERT INTO `syslog` VALUES (228, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=&sex=0&age=19&usertype=1&organizationId=1&roleIds=1&phone=18173526621&status=0&', '0:0:0:0:0:0:0:1', '2021-06-29 14:11:17');
INSERT INTO `syslog` VALUES (229, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 14:19:16');
INSERT INTO `syslog` VALUES (230, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 15:32:04');
INSERT INTO `syslog` VALUES (231, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 15:34:12');
INSERT INTO `syslog` VALUES (232, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 15:38:41');
INSERT INTO `syslog` VALUES (233, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 15:38:41');
INSERT INTO `syslog` VALUES (234, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 15:53:42');
INSERT INTO `syslog` VALUES (235, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:00:21');
INSERT INTO `syslog` VALUES (236, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:00:23');
INSERT INTO `syslog` VALUES (237, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:00:24');
INSERT INTO `syslog` VALUES (238, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:00:29');
INSERT INTO `syslog` VALUES (239, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:03:15');
INSERT INTO `syslog` VALUES (240, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:03:15');
INSERT INTO `syslog` VALUES (241, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:03:15');
INSERT INTO `syslog` VALUES (242, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:03:15');
INSERT INTO `syslog` VALUES (243, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:31');
INSERT INTO `syslog` VALUES (244, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:31');
INSERT INTO `syslog` VALUES (245, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:31');
INSERT INTO `syslog` VALUES (246, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:31');
INSERT INTO `syslog` VALUES (247, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:33');
INSERT INTO `syslog` VALUES (248, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:33');
INSERT INTO `syslog` VALUES (249, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:33');
INSERT INTO `syslog` VALUES (250, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:33');
INSERT INTO `syslog` VALUES (251, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:34');
INSERT INTO `syslog` VALUES (252, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:34');
INSERT INTO `syslog` VALUES (253, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:34');
INSERT INTO `syslog` VALUES (254, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-06-29 16:09:34');
INSERT INTO `syslog` VALUES (255, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-01 19:39:07');
INSERT INTO `syslog` VALUES (256, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-01 19:39:10');
INSERT INTO `syslog` VALUES (257, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-01 19:39:32');
INSERT INTO `syslog` VALUES (258, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-01 19:39:33');
INSERT INTO `syslog` VALUES (259, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 15:18:07');
INSERT INTO `syslog` VALUES (260, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 15:18:55');
INSERT INTO `syslog` VALUES (261, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 15:18:57');
INSERT INTO `syslog` VALUES (262, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 15:19:00');
INSERT INTO `syslog` VALUES (263, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 15:19:42');
INSERT INTO `syslog` VALUES (264, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 17:34:53');
INSERT INTO `syslog` VALUES (265, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 17:34:57');
INSERT INTO `syslog` VALUES (266, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 17:34:57');
INSERT INTO `syslog` VALUES (267, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-02 17:34:59');
INSERT INTO `syslog` VALUES (268, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 15:59:22');
INSERT INTO `syslog` VALUES (269, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:02:48');
INSERT INTO `syslog` VALUES (270, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:18:23');
INSERT INTO `syslog` VALUES (271, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:18:24');
INSERT INTO `syslog` VALUES (272, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:36:14');
INSERT INTO `syslog` VALUES (273, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:36:14');
INSERT INTO `syslog` VALUES (274, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:36:14');
INSERT INTO `syslog` VALUES (275, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:36:14');
INSERT INTO `syslog` VALUES (276, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 16:36:23');
INSERT INTO `syslog` VALUES (277, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 21:47:07');
INSERT INTO `syslog` VALUES (278, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 21:47:15');
INSERT INTO `syslog` VALUES (279, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 21:47:16');
INSERT INTO `syslog` VALUES (280, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 21:47:17');
INSERT INTO `syslog` VALUES (281, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-06 21:47:19');
INSERT INTO `syslog` VALUES (282, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:41:33');
INSERT INTO `syslog` VALUES (283, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:41:43');
INSERT INTO `syslog` VALUES (284, 'admin', '用户信息添加', 'SystemManage.UserManage.controller.UserController', '/user/add', 'loginname=fghc&name=ak&password=123456&sex=0&age=&usertype=1&organizationId=6&roleIds=8&phone=&status=0&', '0:0:0:0:0:0:0:1', '2021-07-07 08:42:25');
INSERT INTO `syslog` VALUES (285, 'admin', '用户信息删除', 'SystemManage.UserManage.controller.UserController', '/user/delete', 'id=20&', '0:0:0:0:0:0:0:1', '2021-07-07 08:42:34');
INSERT INTO `syslog` VALUES (286, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:43:13');
INSERT INTO `syslog` VALUES (287, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:43:40');
INSERT INTO `syslog` VALUES (288, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:44:02');
INSERT INTO `syslog` VALUES (289, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:44:34');
INSERT INTO `syslog` VALUES (290, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:59:00');
INSERT INTO `syslog` VALUES (291, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:59:02');
INSERT INTO `syslog` VALUES (292, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 08:59:11');
INSERT INTO `syslog` VALUES (293, 'hsy', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:23:24');
INSERT INTO `syslog` VALUES (294, 'hsy', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:23:24');
INSERT INTO `syslog` VALUES (295, 'hsy', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:23:24');
INSERT INTO `syslog` VALUES (296, 'hsy', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:23:24');
INSERT INTO `syslog` VALUES (297, 'hsy', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:32:11');
INSERT INTO `syslog` VALUES (298, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:34:57');
INSERT INTO `syslog` VALUES (299, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:34:59');
INSERT INTO `syslog` VALUES (300, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=2&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '0:0:0:0:0:0:0:1', '2021-07-07 09:35:34');
INSERT INTO `syslog` VALUES (301, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:35:36');
INSERT INTO `syslog` VALUES (302, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:35:36');
INSERT INTO `syslog` VALUES (303, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:37:48');
INSERT INTO `syslog` VALUES (304, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:37:52');
INSERT INTO `syslog` VALUES (305, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 09:37:55');
INSERT INTO `syslog` VALUES (306, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=&sex=0&age=19&usertype=1&organizationId=1&roleIds=1&phone=18173526621&status=0&', '0:0:0:0:0:0:0:1', '2021-07-07 09:39:07');
INSERT INTO `syslog` VALUES (307, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=何宇杰&password=&sex=0&age=19&usertype=1&organizationId=1&roleIds=1&phone=18173526621&status=0&', '0:0:0:0:0:0:0:1', '2021-07-07 09:39:10');
INSERT INTO `syslog` VALUES (308, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 19:44:14');
INSERT INTO `syslog` VALUES (309, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 19:44:17');
INSERT INTO `syslog` VALUES (310, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 19:44:18');
INSERT INTO `syslog` VALUES (311, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 19:44:37');
INSERT INTO `syslog` VALUES (312, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 20:04:14');
INSERT INTO `syslog` VALUES (313, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 20:04:14');
INSERT INTO `syslog` VALUES (314, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 20:04:14');
INSERT INTO `syslog` VALUES (315, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 20:04:14');
INSERT INTO `syslog` VALUES (316, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-07 20:04:14');
INSERT INTO `syslog` VALUES (317, 'admin', '用户信息添加', 'SystemManage.UserManage.controller.UserController', '/user/add', 'loginname=sb&name=sb&password=123&sex=0&age=&usertype=1&organizationId=6&roleIds=2&phone=123456&status=0&', '0:0:0:0:0:0:0:1', '2021-07-07 20:07:04');
INSERT INTO `syslog` VALUES (318, 'admin', '用户信息删除', 'SystemManage.UserManage.controller.UserController', '/user/delete', 'id=20&', '0:0:0:0:0:0:0:1', '2021-07-07 20:09:13');
INSERT INTO `syslog` VALUES (319, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:09:54');
INSERT INTO `syslog` VALUES (320, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:10:13');
INSERT INTO `syslog` VALUES (321, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:10:14');
INSERT INTO `syslog` VALUES (322, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:10:15');
INSERT INTO `syslog` VALUES (323, 'admin', '部门信息添加', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/add', 'code=12&name=qw&seq=2&icon=define-depart&address=hhh&pid=6&', '0:0:0:0:0:0:0:1', '2021-07-08 19:11:32');
INSERT INTO `syslog` VALUES (324, 'admin', '部门信息删除', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/delete', 'id=7&', '0:0:0:0:0:0:0:1', '2021-07-08 19:11:48');
INSERT INTO `syslog` VALUES (325, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:21:59');
INSERT INTO `syslog` VALUES (326, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:21:59');
INSERT INTO `syslog` VALUES (327, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:21:59');
INSERT INTO `syslog` VALUES (328, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:21:59');
INSERT INTO `syslog` VALUES (329, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:22:34');
INSERT INTO `syslog` VALUES (330, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:22:50');
INSERT INTO `syslog` VALUES (331, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:22:59');
INSERT INTO `syslog` VALUES (332, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:23:39');
INSERT INTO `syslog` VALUES (333, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:24:13');
INSERT INTO `syslog` VALUES (334, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:11');
INSERT INTO `syslog` VALUES (335, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:11');
INSERT INTO `syslog` VALUES (336, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:11');
INSERT INTO `syslog` VALUES (337, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:11');
INSERT INTO `syslog` VALUES (338, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:11');
INSERT INTO `syslog` VALUES (339, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:21');
INSERT INTO `syslog` VALUES (340, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:29');
INSERT INTO `syslog` VALUES (341, 'admin', '用户信息添加', 'SystemManage.UserManage.controller.UserController', '/user/add', 'loginname=123&name=王八&password=123&sex=0&age=&usertype=1&organizationId=3&roleIds=8&phone=&status=0&', '0:0:0:0:0:0:0:1', '2021-07-08 19:33:59');
INSERT INTO `syslog` VALUES (342, 'admin', '用户信息删除', 'SystemManage.UserManage.controller.UserController', '/user/delete', 'id=20&', '0:0:0:0:0:0:0:1', '2021-07-08 19:34:19');
INSERT INTO `syslog` VALUES (343, 'hsy', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:35:07');
INSERT INTO `syslog` VALUES (344, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:35:36');
INSERT INTO `syslog` VALUES (345, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:35:37');
INSERT INTO `syslog` VALUES (346, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:35:40');
INSERT INTO `syslog` VALUES (347, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:35:41');
INSERT INTO `syslog` VALUES (348, 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=2&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '0:0:0:0:0:0:0:1', '2021-07-08 19:36:23');
INSERT INTO `syslog` VALUES (349, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:36:25');
INSERT INTO `syslog` VALUES (350, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:36:25');
INSERT INTO `syslog` VALUES (351, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:36:25');
INSERT INTO `syslog` VALUES (352, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:36:25');
INSERT INTO `syslog` VALUES (353, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:39:54');
INSERT INTO `syslog` VALUES (354, 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:40:06');
INSERT INTO `syslog` VALUES (355, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:40:06');
INSERT INTO `syslog` VALUES (356, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:40:35');
INSERT INTO `syslog` VALUES (357, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:56:01');
INSERT INTO `syslog` VALUES (358, 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 19:58:49');
INSERT INTO `syslog` VALUES (359, 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 20:44:15');
INSERT INTO `syslog` VALUES (360, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 20:44:22');
INSERT INTO `syslog` VALUES (361, 'admin', '部门信息添加', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/add', 'code=05&name=开发部&seq=0&icon=define-depart&address=&pid=&', '0:0:0:0:0:0:0:1', '2021-07-08 20:44:56');
INSERT INTO `syslog` VALUES (362, 'admin', '部门信息删除', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/delete', 'id=5&', '0:0:0:0:0:0:0:1', '2021-07-08 20:45:15');
INSERT INTO `syslog` VALUES (363, 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 20:49:07');
INSERT INTO `syslog` VALUES (364, 'admin', '用户信息添加', 'SystemManage.UserManage.controller.UserController', '/user/add', 'loginname=west&name=hhh&password=123&sex=0&age=&usertype=1&organizationId=8&roleIds=2&phone=&status=0&', '0:0:0:0:0:0:0:1', '2021-07-08 20:49:52');
INSERT INTO `syslog` VALUES (365, 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=21&loginname=eeee&name=hhh&password=&sex=0&age=&usertype=1&organizationId=8&roleIds=2&phone=&status=0&', '0:0:0:0:0:0:0:1', '2021-07-08 20:50:02');
INSERT INTO `syslog` VALUES (366, 'admin', '用户信息删除', 'SystemManage.UserManage.controller.UserController', '/user/delete', 'id=21&', '0:0:0:0:0:0:0:1', '2021-07-08 20:50:05');
INSERT INTO `syslog` VALUES (367, 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '0:0:0:0:0:0:0:1', '2021-07-08 20:52:50');
INSERT INTO `syslog` VALUES (368, 'admin', '部门信息添加', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/add', 'code=06&name=hh&seq=0&icon=define-depart&address=&pid=&', '0:0:0:0:0:0:0:1', '2021-07-08 20:55:26');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` tinyint(2) NOT NULL DEFAULT 0,
  `age` tinyint(2) NULL DEFAULT 0,
  `usertype` tinyint(2) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `organization_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (14, 'tian', '田思凯', 'ada340724ef4ce6547c123a0f9a3c241', 0, 19, 1, 0, '3', '2018-12-29 17:40:18', '18707173376');
INSERT INTO `user` VALUES (15, 'yyc', '于一川', 'a1b0f062b5a861651e0edf8e318d7186', 0, 19, 1, 0, '6', '2019-01-21 15:21:19', '18707173376');
INSERT INTO `user` VALUES (16, 'admin', '何宇杰', 'c41d7c66e1b8404545aa3a0ece2006ac', 0, 19, 1, 0, '1', '2019-02-18 09:01:08', '18173526621');
INSERT INTO `user` VALUES (18, 'hsy', '郝诗扬', '5d97106306f87a321c1655ae406db3ed', 0, 20, 1, 0, '6', '2019-02-18 00:34:47', '12306');
INSERT INTO `user` VALUES (19, 'yir', '易如', '91f9f77c9160d283ba2c203a1186d74f', 1, 19, 1, 0, '5', '2019-01-24 10:51:00', '12345609');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(19) NOT NULL,
  `role_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 222 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (204, 15, 8);
INSERT INTO `user_role` VALUES (206, 19, 8);
INSERT INTO `user_role` VALUES (207, 14, 2);
INSERT INTO `user_role` VALUES (208, 18, 8);
INSERT INTO `user_role` VALUES (218, 16, 1);
INSERT INTO `user_role` VALUES (219, 16, 2);
INSERT INTO `user_role` VALUES (220, 16, 8);
INSERT INTO `user_role` VALUES (221, 16, 10);

SET FOREIGN_KEY_CHECKS = 1;
