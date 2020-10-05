/* hospital database

Table list:
department,room;
physician, procedure, trained_in,affiliated_with;
nurse, on_call;
patient,appointment,stay,prescribes, medication,undergoes.

ER diagram: conducted


data source: https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php#h_one

 */
DROP DATABASE IF EXISTS `hospital`;
CREATE DATABASE `hospital`;

USE `hospital`;

/* table structure for: nurse*/
DROP TABLE IF EXISTS `nurse`;
CREATE TABLE `nurse` (
`employeeid` INT PRIMARY KEY,
`name` VARCHAR(20),
`position` VARCHAR(20),
`registered` ENUM('f','t'),
`ssn` INT
);
INSERT INTO `nurse` (`employeeid`,`name`,`position`,`registered`,`ssn`) VALUES
(101, 'Carla Espinosa', 'Head Nurse','t',111111110),
(102, 'Laverne Roberts', 'Nurse','t',222222220),
(103, 'Paul Flowers', 'Nurse', 'f', 333333330);


/* Table structure for: physician*/
DROP TABLE IF EXISTS `physician`;
CREATE TABLE `physician` (
`employeeid` INT PRIMARY KEY,
`name` varchar(20),
`position` varchar(50),
`ssn` INT
);
INSERT INTO `physician` (`employeeid`, `name`, `position`, `ssn`) VALUES
(1, 'John Dorian', 'Staff Internist', 111111111),
(2,'Elliot Reid', 'Attending Physician', 222222222),
(3,'Christopher Turk', 'Surgical Attending Physician', 333333333),
(4, 'Percival Cox', 'Senior Attending Physician', 444444444),
(5, 'Bob Kelso', 'Head Chief of Medicine', 555555555),
(6, 'Todd Quinlan', 'Surgical Attending Physician', 666666666),
(7, 'John Wen', 'Surgical Attending Physician', 777777777), 
(8, 'Keith Dudemeister', 'MD Resident', 888888888), 
(9, 'Molly Clock', 'Attending Psychiatrist', 999999999);

/* Table structure for: department*/
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
`departmentid` INT PRIMARY KEY,
`name` varchar(20),
`head` INT
);
INSERT INTO `department` (`departmentid`,`name`,`head`) VALUES
(1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9);

/* Table structure for: appointment */
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment` (
  `appointmentid` INT PRIMARY KEY,
  `patient` INT,
  `prepnurse` INT, 
  `physician` INT,
  `start_dt_time` DATETIME,
  `end_dt_time` DATETIME,
  `examinationroom` VARCHAR(1)
);
INSERT INTO `appointment` (`appointmentid`,`patient`,`prepnurse`,`physician`,`start_dt_time`,`end_dt_time`,`examinationroom`) VALUES
(13216584,100000001,101,1,'2008-04-24 10:00:00','2008-04-24 11:00:00','A'),
(26548913,100000002,101,2,'2008-04-24 10:00:00','2008-04-24 11:00:00','B'),
(36549879,100000001,102,1,'2008-04-25 10:00:00','2008-04-25 11:00:00','A'),
(46846589,100000004,103,4,'2008-04-25 10:00:00','2008-04-25 11:00:00','B'),
(59871321,100000004,null,4,'2008-04-26 10:00:00','2008-04-26 11:00:00','C'),
(69879231,100000003,103,2,'2008-04-26 11:00:00','2008-04-26 12:00:00','C'),
(76983231,100000001,null,3,'2008-04-26 12:00:00','2008-04-26 13:00:00','C'),
(86213939,100000004,102,9,'2008-04-27 10:00:00','2008-04-21 11:00:00','A'),
(93216548,100000002,101,2,'2008-04-27 10:00:00','2008-04-27 11:00:00','B');

/* Table structure for: room*/
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
`roomnumber` INT PRIMARY KEY,
`roomtype` VARCHAR(8),
`blockfloor` INT,
`blockcode` INT,
`unavailable` ENUM('f','t'));
INSERT INTO `room` (`roomnumber`,`roomtype`,`blockfloor`,`blockcode`,`unavailable`) VALUES
(101,'Single',1,1,'f'),
(102,'Single',1,1,'f'),
(103,'Single',1,1,'f'),
(111,'Single',1,2,'f'),
(112,'Single',1,2,'t'),
(113,'Single',1,2,'f'),
(121,'Single',1,3,'f'),
(122,'Single',1,3,'f'),
(123,'Single',1,3,'f'),
(201,'Single',2,1,'t'),
(202,'Single',2,1,'f'),
(203,'Single',2,1,'f'),
(211,'Single',2,2,'f'),
(212,'Single',2,2,'f'),
(213,'Single',2,2,'t'),
(221,'Single',2,3,'f'),
(222,'Single',2,3,'f'),
(223,'Single',2,3,'f'),
(301,'Single',3,1,'f'),
(302,'Single',3,1,'t'),
(303,'Single',3,1,'f'),
(311,'Single',3,2,'f'),
(312,'Single',3,2,'f'),
(313,'Single',3,2,'f'),
(321,'Single',3,3,'t'),
(322,'Single',3,3,'f'),
(323,'Single',3,3,'f'),
(401,'Single',4,1,'f'),
(402,'Single',4,1,'t'),
(403,'Single',4,1,'f'),
(411,'Single',4,2,'f'),
(412,'Single',4,2,'f'),
(413,'Single',4,2,'f'),
(421,'Single',4,3,'t'),
(422,'Single',4,3,'f'),
(423,'Single',4,3,'f');

/* Table structure for: affiliated_with*/
DROP TABLE IF EXISTS `affiliated_with`;
CREATE TABLE `affiliated_with`(
`physician` INT,
`department` INT,
`primaryaffiliation` ENUM('t','f')
);
INSERT INTO `affiliated_with`(`physician`,`department`,`primaryaffiliation`) VALUES
('1','1','t'),
('2','1','t'),
('3','1','f'),
('3','2','t'),
('4','1','t'),
('5','1','t'),
('6','2','t'),
('7','1','f'),
('7','2','t'),
('8','1','t'),
('9','3','t');

/* Table structure for: procedure*/
DROP TABLE IF EXISTS `procedure`;
CREATE TABLE `procedure` (
`code` INT PRIMARY KEY,
`name` VARCHAR(50),
`cost` REAL
);
INSERT INTO `procedure` (`code`,`name`,`cost`) VALUES
(1,'Reverse Rhinopodoplasty',1500),
(2,'Obtuse Pyloric Recombobulation',3750),
(3,'Folded Demiophtalmectomy',4500),
(4,'Complete Walletectomy',10000),
(5,'Obfuscated Dermogastrotomy',4899),
(6,'Reversible Pancreomyoplasty',5600),
(7,'Follicular Demiectomy', 25);


/* Table structure for: trained_in*/
DROP TABLE IF EXISTS `trained_in`;
CREATE TABLE `trained_in` (
`physician` INT,
`treatment` INT,
`certificationdate` DATE,
`certificationexpires` DATE,
PRIMARY KEY (`physician`, `treatment`)
);
INSERT INTO `trained_in`(`physician`,`treatment`,`certificationdate`,`certificationexpires`) VALUES
(3,1,'2008-01-01','2008-12-31'),
(3,2,'2008-01-01','2008-12-31'),
(3,5,'2008-01-01','2008-12-31'),
(3,6,'2008-01-01','2008-12-31'),
(3,7,'2008-01-01','2008-12-31'),
(6,2,'2008-01-01','2008-12-31'),
(6,5,'2007-01-01','2007-12-31'),
(6,6,'2008-01-01','2008-12-31'),
(7,1,'2008-01-01','2008-12-31'),
(7,2,'2008-01-01','2008-12-31'),
(7,3,'2008-01-01','2008-12-31'),
(7,4,'2008-01-01','2008-12-31'),
(7,5,'2008-01-01','2008-12-31'),
(7,6,'2008-01-01','2008-12-31'),
(7,7,'2008-01-01','2008-12-31');

/*Table structure for table: patient*/
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
`ssn` INT PRIMARY KEY,
`name` varchar(40),
`address` varchar(50),
`phone` varchar(10),
`insuranceid` INT,
`pcp` INT
);
INSERT INTO `patient` (`ssn`,`name`,`address`,`phone`, `insuranceid`,`pcp`) VALUES
(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1),
(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2),
(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2),
(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

/*Table structure for table: prescribes*/
DROP TABLE IF EXISTS `prescribes`;
CREATE TABLE `prescribes` (
`physician` INT,
`patient` INT,
`medication` INT,
`date` DATETIME,
`appointment` INT,
`dose` VARCHAR(2),
PRIMARY KEY (`physician`,`patient`,`medication`,`date`)
);
INSERT INTO `prescribes` (`physician`,`patient`,`medication`,`date`,`appointment`,`dose`) VALUES
(1,100000001,1,'2008-04-24 10:47:00',13216584,'5'),
(9,100000004,2,'2008-04-27 10:53:00',86213939,'10'),
(9,100000004,2,'2008-04-30 16:53:00',null,'5');

/*Table structure for: medication*/
DROP TABLE IF EXISTS `medication`;
CREATE TABLE `medication` (
code INT PRIMARY KEY,
name varchar(50),
brand varchar(50),
description varchar(5)
);
INSERT INTO `medication`(code,name,brand, description) VALUES
(1,'Procrastin-X','X','N/A'),
(2,'Thesisin','Foo Labs','N/A'),
(3,'Awakin','Bar Laboratories','N/A'),
(4,'Crescavitin','Baz Industries','N/A'),
(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

/*Table structure for: stay*/
DROP TABLE IF EXISTS `stay`;
CREATE TABLE `stay` (
stayid INT PRIMARY KEY,
patient INT,
room INT,
start_time DATETIME,
end_time DATETIME
);
INSERT INTO `stay`(stayid,patient,room,start_time,end_time) VALUES
(3215,100000001,111,'2008-05-01 00:00:00','2008-05-04 00:00:00'),
(3216,100000003,123,'2008-05-03 00:00:00','2008-05-14 00:00:00'),
(3217,100000004,112,'2008-05-02 00:00:00','2008-05-03 00:00:00');


/*Table structure for: on_call*/
DROP TABLE IF EXISTS `on_call`;
CREATE TABLE `on_call` (
`nurse` INT,
`blockfloor` INT,
`blockcode` INT,
`oncallstart` DATETIME,
`oncallend` DATETIME,
PRIMARY KEY(`nurse`,`blockfloor`,`blockcode`,`oncallstart`,`oncallend`)
);
INSERT INTO on_call (`nurse`,`blockfloor`,`blockcode`,`oncallstart`,`oncallend`) VALUES
(101,1,1,'2008-11-04 11:00:00','2008-11-04 19:00:00'),
(101,1,2,'2008-11-04 11:00:00','2008-11-04 19:00:00'),
(102,1,3,'2008-11-04 11:00:00','2008-11-04 19:00:00'),
(103,1,1,'2008-11-04 19:00:00','2008-11-05 03:00:00'),
(103,1,2,'2008-11-04 19:00:00','2008-11-05 03:00:00'),
(103,1,3,'2008-11-04 19:00:00','2008-11-05 03:00:00');

/*Table structure for: undergoes*/
DROP TABLE IF EXISTS `undergoes`;
CREATE TABLE `undergoes`(
`patient` INT,
`procedure` INT,
`stay` INT,
`date` DATETIME,
`physician` INT,
`assistingnurse` INT,
PRIMARY KEY (`patient`,`procedure`,`stay`,`date`)
);
INSERT INTO `undergoes`(patient,`procedure`,`stay`,`date`,physician,assistingnurse) VALUES
(100000001,6,3215,'2008-05-02 00:00:00',3,101),
(100000001,2,3215,'2008-05-03 00:00:00',7,101),
(100000004,1,3217,'2008-05-07 00:00:00',3,102),
(100000004,5,3217,'2008-05-09 00:00:00',6,null),
(100000001,7,3217,'2008-05-10 00:00:00',7,101),
(100000004,4,3217,'2008-05-13 00:00:00',3,103);




ALTER TABLE `on_call` 
ADD CONSTRAINT `FK_oncall_nurse_employeeid` FOREIGN KEY (`nurse`) REFERENCES `nurse`(`employeeid`);

ALTER TABLE `appointment` 
ADD CONSTRAINT `FK_appointment_nurse_employeeid` FOREIGN KEY (`prepnurse`) REFERENCES `nurse`(`employeeid`),
ADD CONSTRAINT `FK_appointment_patient_ssn` FOREIGN KEY (`patient`) REFERENCES `patient`(`ssn`),
ADD CONSTRAINT `FK_appointment_physician_employeeid` FOREIGN KEY (`physician`) REFERENCES `physician`(`employeeid`);


ALTER TABLE `undergoes` 
ADD CONSTRAINT `FK_undergoes_nurse_employeeid` FOREIGN KEY (`assistingnurse`) REFERENCES `nurse`(`employeeid`),
ADD CONSTRAINT `FK_undergoes_stay_stayid` FOREIGN KEY (`stay`) REFERENCES `stay`(`stayid`),
ADD CONSTRAINT `FK_undergoes_procedure_code` FOREIGN KEY (`procedure`) REFERENCES `procedure`(`code`),
ADD CONSTRAINT `FK_undergoes_patient_ssn` FOREIGN KEY (`patient`) REFERENCES `patient`(`ssn`),
ADD CONSTRAINT `FK_undergoes_physician_employeeid` FOREIGN KEY (`physician`) REFERENCES `physician`(`employeeid`);


ALTER TABLE `stay` 
ADD CONSTRAINT `FK_stay_patient_ssn` FOREIGN KEY (`patient`) REFERENCES `patient`(`ssn`),
ADD CONSTRAINT `FK_stay_room_roomnumber` FOREIGN KEY (`room`) REFERENCES `room`(`roomnumber`);

ALTER TABLE `trained_in`
ADD CONSTRAINT `FK_trained_in_procedure_code` FOREIGN KEY (`treatment`) REFERENCES `procedure`(`code`),
ADD CONSTRAINT `FK_trained_in_physician_employeeid` FOREIGN KEY (`physician`) REFERENCES `physician`(`employeeid`);

ALTER TABLE `prescribes` 
ADD CONSTRAINT `FK_prescribes_appointment_patient` FOREIGN KEY (`patient`) REFERENCES `appointment`(`patient`),
ADD CONSTRAINT `FK_prescribes_patient_ssn` FOREIGN KEY (`patient`) REFERENCES `patient`(`ssn`),
ADD CONSTRAINT `FK_prescribes_medication_code` FOREIGN KEY (`medication`) REFERENCES `medication`(`code`),
ADD CONSTRAINT `FK_prescribes_physician_employeeid` FOREIGN KEY (`physician`) REFERENCES `physician`(`employeeid`);


ALTER TABLE `affiliated_with`
ADD CONSTRAINT `FK_affiliated_department_departmentid` FOREIGN KEY (`department`) REFERENCES `department`(`departmentid`),
ADD CONSTRAINT `FK_affiliated_physician_employeeid` FOREIGN KEY (`physician`) REFERENCES `physician`(`employeeid`);

ALTER TABLE `patient`
ADD CONSTRAINT `FK_patient_physician_employeeid` FOREIGN KEY (`pcp`) REFERENCES `physician`(`employeeid`);

ALTER TABLE `department`
ADD CONSTRAINT `FK_department_physician_employeeid` FOREIGN KEY (`head`) REFERENCES `physician`(`employeeid`);


