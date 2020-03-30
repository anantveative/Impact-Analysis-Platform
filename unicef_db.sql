/*
Navicat MySQL Data Transfer

Source Server         : Veative Staging RDS
Source Server Version : 50641
Source Host           : veativestaging.csvewner5nyp.us-east-1.rds.amazonaws.com:3306
Source Database       : unicef_db

Target Server Type    : MYSQL
Target Server Version : 50641
File Encoding         : 65001

Date: 2020-03-30 12:47:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_unicef_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_unicef_user`;
CREATE TABLE `t_unicef_user` (
  `USER_OID` int(11) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(55) DEFAULT NULL,
  `EMAIL_ID` varchar(85) DEFAULT NULL,
  `PASSWORD` varchar(50) DEFAULT NULL,
  `FIRST_NAME` varchar(50) DEFAULT NULL,
  `LAST_NAME` varchar(50) DEFAULT NULL,
  `USER_AGE` varchar(3) DEFAULT NULL,
  `GENDER_ID` enum('M','F') DEFAULT NULL,
  `IP_ADDRESS` varchar(15) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL COMMENT 'to track the user location',
  `CREATED_ON` datetime DEFAULT NULL,
  `LAST_UPDATED_BY` int(11) DEFAULT '0',
  `LAST_UPDATED_ON` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`USER_OID`),
  UNIQUE KEY `UK_USR_EMAIL` (`EMAIL_ID`) USING BTREE,
  UNIQUE KEY `UK_USR_UNAME` (`USERNAME`) USING BTREE,
  KEY `USER_OID` (`USER_OID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=515 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_unicef_user
-- ----------------------------
INSERT INTO `t_unicef_user` VALUES ('1', 'unicef', 'fabien@benetou.fr ', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 'Fabien', null, '30', 'M', '119.82.67.242', '2019-10-30 12:37:17', '0', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `t_unicef_usractivity`
-- ----------------------------
DROP TABLE IF EXISTS `t_unicef_usractivity`;
CREATE TABLE `t_unicef_usractivity` (
  `ACTIVITY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_OID` int(11) NOT NULL,
  `GL_MODULE_ID` varchar(10) NOT NULL,
  `GL_MODULE_NAME` varchar(100) NOT NULL,
  `GL_LEVEL_ID` varchar(5) NOT NULL,
  `GL_LEVEL_NAME` varchar(80) NOT NULL,
  `GL_LEVEL_KNOWLEDGE_DOMAIN` varchar(50) NOT NULL,
  `GL_LEVEL_COGNITIVE_DOMAIN` varchar(50) NOT NULL,
  `GL_LEVEL_TYPE` varchar(50) NOT NULL,
  `GL_LEVEL_INTERACTIVITY` varchar(50) NOT NULL,
  `GL_QUESTION_ID` varchar(10) NOT NULL,
  `GL_QUESTION_COGNITIVE` varchar(50) NOT NULL,
  `GL_QUESTION_ACTION_VERB` varchar(50) NOT NULL,
  `LL_QUESTION_TYPE` varchar(50) NOT NULL,
  `LL_MAX_SCORE` tinyint(3) NOT NULL DEFAULT '1',
  `TR_USER_SCORE` tinyint(3) NOT NULL,
  `HOST_IP` varchar(15) DEFAULT NULL,
  `DEVICE_BROWSER_VERSION` varchar(80) DEFAULT NULL,
  `DEVICE_MODEL` varchar(50) DEFAULT NULL,
  `DEVICE_KERNEL_VERSION` varchar(100) DEFAULT NULL,
  `DEVICE_SERIAL_NUMBER` varchar(50) DEFAULT NULL,
  `DEVICE_PLATFORM` varchar(20) NOT NULL,
  `ATTEMPTED_ON` datetime NOT NULL,
  PRIMARY KEY (`ACTIVITY_ID`),
  KEY `USER_OID` (`USER_OID`)
) ENGINE=InnoDB AUTO_INCREMENT=1692 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_unicef_usractivity
-- ----------------------------
INSERT INTO `t_unicef_usractivity` VALUES ('1', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Apply', 'Model', 'Click and Explore', 'Q1', 'Apply', 'Identify', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:35:44');
INSERT INTO `t_unicef_usractivity` VALUES ('2', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Apply', 'Model', 'Click and Explore', 'Q2', 'Apply', 'Identify', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:35:59');
INSERT INTO `t_unicef_usractivity` VALUES ('3', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Apply', 'Model', 'Click and Explore', 'Q3', 'Apply', 'Identify', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:36:09');
INSERT INTO `t_unicef_usractivity` VALUES ('4', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Apply', 'Model', 'Click and Explore', 'Q4', 'Apply', 'Identify', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:36:18');
INSERT INTO `t_unicef_usractivity` VALUES ('5', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Apply', 'Model', 'Click and Explore', 'Q5', 'Apply', 'Identify', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:36:33');
INSERT INTO `t_unicef_usractivity` VALUES ('6', '1', 'MS300035', 'Line and Plane of Symmetry', 'AS', 'Assess your knowledge', 'Procedural Knowledge', 'Understand', 'Model', 'Click and Explore', 'Q6', 'Understand', 'Identify', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 75', 'NA', 'NA', 'NA', 'Desktop', '2019-06-26 17:36:49');
INSERT INTO `t_unicef_usractivity` VALUES ('54', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q1', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:07');
INSERT INTO `t_unicef_usractivity` VALUES ('55', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q2', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:17');
INSERT INTO `t_unicef_usractivity` VALUES ('56', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q3', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:23');
INSERT INTO `t_unicef_usractivity` VALUES ('57', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q4', 'Apply', 'Solve', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:29');
INSERT INTO `t_unicef_usractivity` VALUES ('58', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q5', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:44');
INSERT INTO `t_unicef_usractivity` VALUES ('59', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q6', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:49');
INSERT INTO `t_unicef_usractivity` VALUES ('60', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q7', 'Apply', 'Solve', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:52:59');
INSERT INTO `t_unicef_usractivity` VALUES ('61', '1', 'HS300012', 'Introduction to Complex Numbers', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Apply', 'Calculation', 'Click and Explore', 'Q8', 'Apply', 'Solve', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Chrome 74', 'NA', 'NA', 'NA', 'GearVR', '2019-06-29 15:53:14');
INSERT INTO `t_unicef_usractivity` VALUES ('66', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q1', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:45:11');
INSERT INTO `t_unicef_usractivity` VALUES ('67', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q2', 'Understand', 'Label', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:47:28');
INSERT INTO `t_unicef_usractivity` VALUES ('68', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q3', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:47:50');
INSERT INTO `t_unicef_usractivity` VALUES ('69', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q4', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:48:04');
INSERT INTO `t_unicef_usractivity` VALUES ('70', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q5', 'Understand', 'Label', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:48:21');
INSERT INTO `t_unicef_usractivity` VALUES ('71', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q6', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:48:31');
INSERT INTO `t_unicef_usractivity` VALUES ('72', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q7', 'Understand', 'Label', 'Multiple Choice Question', '1', '0', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:48:43');
INSERT INTO `t_unicef_usractivity` VALUES ('73', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q8', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:48:54');
INSERT INTO `t_unicef_usractivity` VALUES ('74', '1', 'MS100027', 'Reproductive Parts of a Flower', 'AS', 'Assess Your Knowledge', 'Conceptual Knowledge', 'Understand', 'Structure', 'Explore Strucure', 'Q9', 'Understand', 'Label', 'Multiple Choice Question', '1', '1', 'ec2-52-5-117-32', 'Firefox 68', 'NA', 'NA', 'NA', 'Desktop', '2019-07-07 14:50:03');

-- ----------------------------
-- Table structure for `t_unicef_usractivity_copy`
-- ----------------------------
DROP TABLE IF EXISTS `t_unicef_usractivity_copy`;
CREATE TABLE `t_unicef_usractivity_copy` (
  `ACTIVITY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_OID` int(11) NOT NULL,
  `GL_MODULE_ID` varchar(10) NOT NULL,
  `GL_MODULE_NAME` varchar(100) NOT NULL,
  `GL_LEVEL_ID` varchar(5) NOT NULL,
  `GL_LEVEL_NAME` varchar(80) NOT NULL,
  `GL_LEVEL_KNOWLEDGE_DOMAIN` varchar(50) NOT NULL,
  `GL_LEVEL_COGNITIVE_DOMAIN` varchar(50) NOT NULL,
  `GL_LEVEL_TYPE` varchar(50) NOT NULL,
  `GL_LEVEL_INTERACTIVITY` varchar(50) NOT NULL,
  `GL_QUESTION_ID` varchar(10) NOT NULL,
  `GL_QUESTION_COGNITIVE` varchar(50) NOT NULL,
  `GL_QUESTION_ACTION_VERB` varchar(50) NOT NULL,
  `LL_QUESTION_TYPE` varchar(50) NOT NULL,
  `LL_MAX_SCORE` tinyint(3) NOT NULL DEFAULT '1',
  `TR_USER_SCORE` tinyint(3) NOT NULL,
  `HOST_IP` varchar(15) DEFAULT NULL,
  `DEVICE_BROWSER_VERSION` varchar(80) DEFAULT NULL,
  `DEVICE_MODEL` varchar(50) DEFAULT NULL,
  `DEVICE_KERNEL_VERSION` varchar(100) DEFAULT NULL,
  `DEVICE_SERIAL_NUMBER` varchar(50) DEFAULT NULL,
  `DEVICE_PLATFORM` varchar(20) NOT NULL,
  `ATTEMPTED_ON` datetime NOT NULL,
  PRIMARY KEY (`ACTIVITY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for `module_attempt`
-- ----------------------------
DROP VIEW IF EXISTS `module_attempt`;
CREATE VIEW `module_attempt` AS select `t_unicef_usractivity`.`GL_MODULE_NAME` AS `GL_MODULE_NAME`,count(`t_unicef_usractivity`.`GL_MODULE_NAME`) AS `COUNT` from `t_unicef_usractivity` group by `t_unicef_usractivity`.`GL_MODULE_NAME` ;
