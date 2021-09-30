
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `code` varchar(64) NOT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` bigint(19) DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='组织机构';

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('1', '总经办', '', '01', 'define-depart', null, '0', '2014-02-19 01:00:00');
INSERT INTO `organization` VALUES ('3', '技术部', '', '02', 'define-depart', null, '1', '2015-10-01 13:10:42');
INSERT INTO `organization` VALUES ('5', '产品部', '', '03', 'define-depart', null, '2', '2015-12-06 12:15:30');
INSERT INTO `organization` VALUES ('6', '测试组', 'www.baidu.com', '04', 'define-group', '3', '0', '2015-12-06 13:12:18');

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(32) DEFAULT NULL,
  `pid` bigint(19) DEFAULT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `resourcetype` tinyint(2) NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8 COMMENT='资源';

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('1', '系统管理', '', null, '系统管理', 'icon-xitongguanli', null, '3', '0', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('11', '资源管理', '/resource/manager', null, '资源管理', 'icon-ziyuanguanli1', '223', '3', '0', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('12', '角色管理', '/role/manager', null, '角色管理', 'icon-jiaoseguanli', '223', '2', '0', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('13', '用户信息管理', '/user/manager', null, '用户管理', 'icon-untitled85', '223', '1', '0', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('14', '部门资源', '/organization/manager', null, '部门管理', 'icon-bumen1', '223', '4', '0', '0', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('111', '列表', '/resource/treeGrid', 'resource:list', '资源列表', 'define-list', '11', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('112', '添加', '/resource/add', 'resource:add', '资源添加', 'define-add', '11', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('113', '编辑', '/resource/edit', 'resource:edit', '资源编辑', 'define-edit', '11', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('114', '删除', '/resource/delete', 'resource:delete', '资源删除', 'define-del', '11', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('121', '列表', '/role/dataGrid', 'role:list', '角色列表', 'define-list', '12', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('122', '添加', '/role/add', 'role:add', '角色添加', 'define-add', '12', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('123', '编辑', '/role/edit', 'role:edit', '角色编辑', 'define-edit', '12', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('124', '删除', '/role/delete', 'role:delete', '角色删除', 'define-del', '12', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('125', '授权', '/role/grant', 'role:grant', '角色授权', 'define-true', '12', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('131', '列表', '/user/dataGrid', 'user:list', '用户列表', 'define-list', '13', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('132', '添加', '/user/add', 'user:add', '用户添加', 'define-add', '13', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('133', '编辑', '/user/edit', 'user:edit', '用户编辑', 'define-edit', '13', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('134', '删除', '/user/delete', 'user:delete', '用户删除', 'define-del', '13', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('141', '列表', '/organization/treeGrid', 'organization:list', '用户列表', 'define-list', '14', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('142', '添加', '/organization/add', 'organization:add', '部门添加', 'define-add', '14', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('143', '编辑', '/organization/edit', 'organization:edit', '部门编辑', 'define-edit', '14', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('144', '删除', '/organization/delete', 'organization:delete', '部门删除', 'define-del', '14', '0', '0', '1', '2014-02-19 01:00:00');
INSERT INTO `resource` VALUES ('221', '日志管理', '/log/manager', null, null, 'icon-rizhiguanli', '1', '1', '0', '0', '2015-12-01 11:44:20');
INSERT INTO `resource` VALUES ('222', '后台首页', '/main', '', null, 'icon-houtai', null, '0', '0', '0', '2019-01-11 10:16:17');
INSERT INTO `resource` VALUES ('223', '管理员管理', '', null, null, 'icon-guanliyuan', null, '1', '0', '0', '2019-01-11 11:06:20');
INSERT INTO `resource` VALUES ('224', '字典管理', '/dictionary/manager', '', null, 'icon-rizhiguanli1', '1', '0', '0', '0', '2019-01-23 09:43:19');
INSERT INTO `resource` VALUES ('225', '批量删除', '/log/batchDelete', 'log:batchDelete', null, 'define-del', '221', '1', '0', '1', '2019-02-21 15:43:54');
INSERT INTO `resource` VALUES ('226', '列表', '/log/dataGrid', 'log:list', null, 'define-list', '221', '0', '0', '1', '2019-02-22 11:31:37');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `seq` tinyint(2) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级管理员', '0', '超级管理员', '0');
INSERT INTO `role` VALUES ('2', '技术部经理', '0', '技术部经理', '1');
INSERT INTO `role` VALUES ('8', '测试账户', '0', '测试账户', '0');
INSERT INTO `role` VALUES ('10', '部门管理员', '0', '管理相关部门', '0');

-- ----------------------------
-- Table structure for role_resource
-- ----------------------------
DROP TABLE IF EXISTS `role_resource`;
CREATE TABLE `role_resource` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(19) NOT NULL,
  `resource_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1159 DEFAULT CHARSET=utf8 COMMENT='角色资源';

-- ----------------------------
-- Records of role_resource
-- ----------------------------
INSERT INTO `role_resource` VALUES ('1089', '8', '222');
INSERT INTO `role_resource` VALUES ('1090', '8', '223');
INSERT INTO `role_resource` VALUES ('1091', '8', '13');
INSERT INTO `role_resource` VALUES ('1092', '8', '131');
INSERT INTO `role_resource` VALUES ('1093', '8', '12');
INSERT INTO `role_resource` VALUES ('1094', '8', '121');
INSERT INTO `role_resource` VALUES ('1095', '8', '11');
INSERT INTO `role_resource` VALUES ('1096', '8', '111');
INSERT INTO `role_resource` VALUES ('1097', '8', '14');
INSERT INTO `role_resource` VALUES ('1098', '8', '141');
INSERT INTO `role_resource` VALUES ('1099', '8', '1');
INSERT INTO `role_resource` VALUES ('1100', '8', '224');
INSERT INTO `role_resource` VALUES ('1101', '8', '221');
INSERT INTO `role_resource` VALUES ('1102', '8', '226');
INSERT INTO `role_resource` VALUES ('1103', '1', '222');
INSERT INTO `role_resource` VALUES ('1104', '1', '223');
INSERT INTO `role_resource` VALUES ('1105', '1', '13');
INSERT INTO `role_resource` VALUES ('1106', '1', '131');
INSERT INTO `role_resource` VALUES ('1107', '1', '132');
INSERT INTO `role_resource` VALUES ('1108', '1', '133');
INSERT INTO `role_resource` VALUES ('1109', '1', '134');
INSERT INTO `role_resource` VALUES ('1110', '1', '12');
INSERT INTO `role_resource` VALUES ('1111', '1', '121');
INSERT INTO `role_resource` VALUES ('1112', '1', '122');
INSERT INTO `role_resource` VALUES ('1113', '1', '123');
INSERT INTO `role_resource` VALUES ('1114', '1', '124');
INSERT INTO `role_resource` VALUES ('1115', '1', '125');
INSERT INTO `role_resource` VALUES ('1116', '1', '11');
INSERT INTO `role_resource` VALUES ('1117', '1', '111');
INSERT INTO `role_resource` VALUES ('1118', '1', '112');
INSERT INTO `role_resource` VALUES ('1119', '1', '113');
INSERT INTO `role_resource` VALUES ('1120', '1', '114');
INSERT INTO `role_resource` VALUES ('1121', '1', '14');
INSERT INTO `role_resource` VALUES ('1122', '1', '141');
INSERT INTO `role_resource` VALUES ('1123', '1', '142');
INSERT INTO `role_resource` VALUES ('1124', '1', '143');
INSERT INTO `role_resource` VALUES ('1125', '1', '144');
INSERT INTO `role_resource` VALUES ('1126', '1', '1');
INSERT INTO `role_resource` VALUES ('1127', '1', '224');
INSERT INTO `role_resource` VALUES ('1128', '1', '221');
INSERT INTO `role_resource` VALUES ('1129', '1', '226');
INSERT INTO `role_resource` VALUES ('1130', '1', '225');
INSERT INTO `role_resource` VALUES ('1131', '2', '222');
INSERT INTO `role_resource` VALUES ('1132', '2', '223');
INSERT INTO `role_resource` VALUES ('1133', '2', '13');
INSERT INTO `role_resource` VALUES ('1134', '2', '131');
INSERT INTO `role_resource` VALUES ('1135', '2', '12');
INSERT INTO `role_resource` VALUES ('1136', '2', '121');
INSERT INTO `role_resource` VALUES ('1137', '2', '11');
INSERT INTO `role_resource` VALUES ('1138', '2', '111');
INSERT INTO `role_resource` VALUES ('1139', '2', '14');
INSERT INTO `role_resource` VALUES ('1140', '2', '141');
INSERT INTO `role_resource` VALUES ('1141', '2', '1');
INSERT INTO `role_resource` VALUES ('1142', '2', '224');
INSERT INTO `role_resource` VALUES ('1143', '2', '221');
INSERT INTO `role_resource` VALUES ('1144', '2', '226');
INSERT INTO `role_resource` VALUES ('1145', '10', '222');
INSERT INTO `role_resource` VALUES ('1146', '10', '223');
INSERT INTO `role_resource` VALUES ('1147', '10', '13');
INSERT INTO `role_resource` VALUES ('1148', '10', '131');
INSERT INTO `role_resource` VALUES ('1149', '10', '12');
INSERT INTO `role_resource` VALUES ('1150', '10', '121');
INSERT INTO `role_resource` VALUES ('1151', '10', '11');
INSERT INTO `role_resource` VALUES ('1152', '10', '111');
INSERT INTO `role_resource` VALUES ('1153', '10', '14');
INSERT INTO `role_resource` VALUES ('1154', '10', '141');
INSERT INTO `role_resource` VALUES ('1155', '10', '1');
INSERT INTO `role_resource` VALUES ('1156', '10', '224');
INSERT INTO `role_resource` VALUES ('1157', '10', '221');
INSERT INTO `role_resource` VALUES ('1158', '10', '226');

-- ----------------------------
-- Table structure for syslog
-- ----------------------------
DROP TABLE IF EXISTS `syslog`;
CREATE TABLE `syslog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(60) DEFAULT NULL,
  `operationName` varchar(60) NOT NULL COMMENT '操作',
  `operationClass` varchar(120) DEFAULT NULL,
  `operationAddress` varchar(120) DEFAULT NULL COMMENT '执行方法',
  `params` varchar(500) DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(80) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syslog
-- ----------------------------
INSERT INTO `syslog` VALUES ('83', '系统自动任务', '定时删除日志：1条', '', '', '', '', '2019-02-22 09:52:30');
INSERT INTO `syslog` VALUES ('84', '系统自动任务', '定时删除日志：0条', '', '', '', '', '2019-02-22 10:41:32');
INSERT INTO `syslog` VALUES ('85', '系统自动任务', '定时删除日志：0条', '', '', '', '', '2019-02-22 10:41:40');
INSERT INTO `syslog` VALUES ('86', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 10:51:52');
INSERT INTO `syslog` VALUES ('87', 'admin', '用户信息编辑', 'SystemManage.UserManage.controller.UserController', '/user/edit', 'id=16&loginname=admin&name=yongfeng.L&password=&sex=0&age=21&usertype=1&organizationId=1&roleIds=1&phone=18296633676&status=0&', '127.0.0.1', '2019-02-22 10:52:36');
INSERT INTO `syslog` VALUES ('88', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 10:52:50');
INSERT INTO `syslog` VALUES ('89', 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=10&resourceIds=222,223,13,131,1,221&', '127.0.0.1', '2019-02-22 10:52:57');
INSERT INTO `syslog` VALUES ('90', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 10:53:00');
INSERT INTO `syslog` VALUES ('91', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 10:53:00');
INSERT INTO `syslog` VALUES ('92', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 11:00:53');
INSERT INTO `syslog` VALUES ('93', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 11:00:57');
INSERT INTO `syslog` VALUES ('94', 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '127.0.0.1', '2019-02-22 11:00:59');
INSERT INTO `syslog` VALUES ('113', 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=8&resourceIds=222,223,13,131,12,121,11,111,1,224,221&', '127.0.0.1', '2019-02-22 11:37:16');
INSERT INTO `syslog` VALUES ('116', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 11:37:18');
INSERT INTO `syslog` VALUES ('132', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:05');
INSERT INTO `syslog` VALUES ('134', 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=1&resourceIds=222,223,13,131,132,133,134,12,121,122,123,124,125,11,111,112,113,114,14,141,142,143,144,1,224,221,226,225&', '127.0.0.1', '2019-02-22 12:49:16');
INSERT INTO `syslog` VALUES ('135', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:18');
INSERT INTO `syslog` VALUES ('136', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:49:18');
INSERT INTO `syslog` VALUES ('137', 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=2&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '127.0.0.1', '2019-02-22 12:49:25');
INSERT INTO `syslog` VALUES ('138', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:49:27');
INSERT INTO `syslog` VALUES ('139', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:49:27');
INSERT INTO `syslog` VALUES ('140', 'admin', '角色授权', 'SystemManage.RoleManage.controller.RoleController', '/role/grant', 'id=10&resourceIds=222,223,13,131,12,121,11,111,14,141,1,224,221,226&', '127.0.0.1', '2019-02-22 12:50:05');
INSERT INTO `syslog` VALUES ('141', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '127.0.0.1', '2019-02-22 12:50:07');
INSERT INTO `syslog` VALUES ('142', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:50:07');
INSERT INTO `syslog` VALUES ('143', 'admin', '角色信息编辑', 'SystemManage.RoleManage.controller.RoleController', '/role/edit', 'id=10&name=部门管理员&seq=0&status=0&description=管理相关部门&', '127.0.0.1', '2019-02-22 12:50:13');
INSERT INTO `syslog` VALUES ('144', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '127.0.0.1', '2019-02-22 12:50:20');
INSERT INTO `syslog` VALUES ('145', 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '127.0.0.1', '2019-02-22 12:50:39');
INSERT INTO `syslog` VALUES ('146', 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '127.0.0.1', '2019-02-22 12:51:26');
INSERT INTO `syslog` VALUES ('147', 'admin', '部门信息编辑', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/edit', 'id=6&code=04&name=测试组&seq=0&icon=define-group&address=www.baidu.com&pid=3&', '127.0.0.1', '2019-02-22 12:51:37');
INSERT INTO `syslog` VALUES ('148', 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:51:46');
INSERT INTO `syslog` VALUES ('149', 'admin', '日志信息批量删除', 'SystemManage.LogManage.controller.LogController', '/log/batchDelete', 'ids=112,111,110,109,108,107,106,105,104,102,103,101,100,99,98,97,96,95&', '127.0.0.1', '2019-02-22 12:52:13');
INSERT INTO `syslog` VALUES ('150', 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:52:15');
INSERT INTO `syslog` VALUES ('151', 'admin', '日志信息批量删除', 'SystemManage.LogManage.controller.LogController', '/log/batchDelete', 'ids=133,131,130,129,128,127,126,125,123,124,122,121,120,119,118,117,114,115&', '127.0.0.1', '2019-02-22 12:53:05');
INSERT INTO `syslog` VALUES ('152', 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:53:06');
INSERT INTO `syslog` VALUES ('153', 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '127.0.0.1', '2019-02-22 12:54:14');
INSERT INTO `syslog` VALUES ('154', 'admin', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '117.44.235.8', '2019-02-22 13:15:09');
INSERT INTO `syslog` VALUES ('155', 'admin', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '117.44.235.8', '2019-02-22 13:15:13');
INSERT INTO `syslog` VALUES ('156', 'admin', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '117.44.235.8', '2019-02-22 13:15:14');
INSERT INTO `syslog` VALUES ('157', 'admin', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '117.44.235.8', '2019-02-22 13:15:16');
INSERT INTO `syslog` VALUES ('158', 'admin', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:15:21');
INSERT INTO `syslog` VALUES ('159', 'test', '用户信息查看', 'SystemManage.UserManage.controller.UserController', '/user/manager', '', '117.44.235.8', '2019-02-22 13:15:55');
INSERT INTO `syslog` VALUES ('160', 'test', '角色信息查看', 'SystemManage.RoleManage.controller.RoleController', '/role/manager', '', '117.44.235.8', '2019-02-22 13:16:04');
INSERT INTO `syslog` VALUES ('161', 'test', '资源信息查看', 'SystemManage.ResourceManage.controller.ResourceController', '/resource/manager', '', '117.44.235.8', '2019-02-22 13:16:09');
INSERT INTO `syslog` VALUES ('162', 'test', '部门信息查看', 'SystemManage.OrganizationManage.controller.OrganizationController', '/organization/manager', '', '117.44.235.8', '2019-02-22 13:16:19');
INSERT INTO `syslog` VALUES ('163', 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:16:23');
INSERT INTO `syslog` VALUES ('164', 'test', '日志信息查看', 'SystemManage.LogManage.controller.LogController', '/log/manager', '', '117.44.235.8', '2019-02-22 13:17:28');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `sex` tinyint(2) NOT NULL DEFAULT '0',
  `age` tinyint(2) DEFAULT '0',
  `usertype` tinyint(2) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `organization_id` varchar(100) NOT NULL DEFAULT '0',
  `createdate` datetime NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('14', 'feng', 'feng', 'ada1be43ad606a0131b74c44b88c2dd2', '1', '25', '1', '0', '6', '2018-12-29 17:40:18', '18707173376');
INSERT INTO `user` VALUES ('15', 'test', '测试账户', 'b0ce72ed0b24728785094ef90b6d00c3', '0', '6', '1', '0', '6', '2019-01-21 15:21:19', '18707173376');
INSERT INTO `user` VALUES ('16', 'admin', 'yongfeng.L', 'c41d7c66e1b8404545aa3a0ece2006ac', '0', '21', '1', '0', '1', '2019-02-18 09:01:08', '18296633676');
INSERT INTO `user` VALUES ('18', 'test2', '测试账户2', '191dd868a777ff98f650c59d87ed6563', '1', '20', '1', '0', '3', '2019-02-18 00:34:47', '12306');
INSERT INTO `user` VALUES ('19', 'test3', '测试账户3', '326f03ff1f335b2583041c6239c25777', '0', '14', '1', '0', '5', '2019-01-24 10:51:00', '12345609');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` bigint(19) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(19) NOT NULL,
  `role_id` bigint(19) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('164', '18', '8');
INSERT INTO `user_role` VALUES ('176', '14', '2');
INSERT INTO `user_role` VALUES ('182', '15', '8');
INSERT INTO `user_role` VALUES ('183', '19', '8');
INSERT INTO `user_role` VALUES ('184', '16', '1');
INSERT INTO `user_role` VALUES ('185', '16', '2');
INSERT INTO `user_role` VALUES ('186', '16', '8');
INSERT INTO `user_role` VALUES ('187', '16', '10');
