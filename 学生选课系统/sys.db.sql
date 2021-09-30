/*
SQLyog Ultimate v8.32 
MySQL - 5.5.49 : Database - course_selection_system
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`course_selection_system` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `course_selection_system`;

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `classId` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(200) NOT NULL,
  `classNum` int(11) NOT NULL,
  `teaId` int(11) NOT NULL,
  `classChooseNum` int(11) NOT NULL,
  PRIMARY KEY (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=1010 DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`classId`,`className`,`classNum`,`teaId`,`classChooseNum`) values (1001,'c语言程序设计',5,2018100001,2),(1002,'宏观经济学',3,2018100002,3),(1004,'java程序设计',4,2018100001,1),(1005,'市场营销学',6,2018100002,2),(1006,'大学英语',3,2018100003,1),(1007,'大学英语',3,2018100003,1),(1008,'高等数学',6,2018100004,1),(1009,'C++',40,2018100001,0);

/*Table structure for table `course_choose` */

DROP TABLE IF EXISTS `course_choose`;

CREATE TABLE `course_choose` (
  `chooseId` int(11) NOT NULL AUTO_INCREMENT,
  `stuId` int(11) NOT NULL,
  `classId` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`chooseId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `course_choose` */

insert  into `course_choose`(`chooseId`,`stuId`,`classId`,`score`) values (2,2018000003,1002,85),(3,2018000004,1002,60),(9,2018000002,1001,100),(10,2018000001,1002,0),(11,2018000006,1001,0),(12,2018000001,1005,0),(13,2018000001,1007,0),(14,2018000002,1004,0),(15,2018000002,1006,0),(16,2018000002,1008,0),(17,2018000004,1005,0);

/*Table structure for table `course_limit` */

DROP TABLE IF EXISTS `course_limit`;

CREATE TABLE `course_limit` (
  `limitId` int(11) NOT NULL AUTO_INCREMENT,
  `classId` int(11) NOT NULL,
  `insId` int(11) NOT NULL,
  PRIMARY KEY (`limitId`)
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8;

/*Data for the table `course_limit` */

insert  into `course_limit`(`limitId`,`classId`,`insId`) values (1001,1001,1001),(1002,1002,1004),(1003,1002,1005),(1005,1004,1001),(1006,1005,1005),(1007,1006,1001),(1008,1006,1002),(1009,1007,1004),(1010,1007,1005),(1011,1008,1001),(1012,1009,1001);

/*Table structure for table `institution` */

DROP TABLE IF EXISTS `institution`;

CREATE TABLE `institution` (
  `insId` int(11) NOT NULL AUTO_INCREMENT,
  `insName` varchar(200) NOT NULL,
  PRIMARY KEY (`insId`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8;

/*Data for the table `institution` */

insert  into `institution`(`insId`,`insName`) values (1001,'信息科学技术学院'),(1002,'医学院'),(1004,'管理学院'),(1005,'经济学院');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `stuId` int(11) NOT NULL,
  `stuName` varchar(200) NOT NULL,
  `stuPass` varchar(200) NOT NULL,
  `insId` int(11) DEFAULT NULL,
  `insName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`stuId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`stuId`,`stuName`,`stuPass`,`insId`,`insName`) values (2018000001,'张三','2018000001',1005,'经济学院'),(2018000002,'李四','2018000002',1001,'信息科学技术学院'),(2018000003,'王五','2018000003',1005,'经济学院'),(2018000004,'赵六','2018000004',1005,'经济学院'),(2018000005,'孙七','2018000005',1004,'管理学院'),(2018000006,'周八','2018000006',1001,'信息科学技术学院'),(2018000007,'吴九','2018000007',1004,'管理学院'),(2018000008,'郑十','2018000008',1001,'信息科学技术学院'),(2018000009,'刘备','2018000009',1004,'管理学院'),(2018000010,'关羽','2018000010',1002,'医学院'),(2018000011,'张飞','2018000011',1002,'医学院');

/*Table structure for table `teacher` */

DROP TABLE IF EXISTS `teacher`;

CREATE TABLE `teacher` (
  `teaId` int(11) NOT NULL,
  `teaName` varchar(200) NOT NULL,
  `teaPass` varchar(200) NOT NULL,
  PRIMARY KEY (`teaId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teacher` */

insert  into `teacher`(`teaId`,`teaName`,`teaPass`) values (2018100001,'张老师','2018100001'),(2018100002,'李老师','2018100002'),(2018100003,'王老师','2018100003'),(2018100004,'陈老师','2018100004');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
