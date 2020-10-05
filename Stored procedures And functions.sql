/******************STORED PROCEDURE********************/
CREATE DEFINER=`admin`@`localhost` PROCEDURE `find_room`(IN room_number INT)
BEGIN
  SELECT blockfloor, blockcode
  FROM room
  where roomnumber = room_number;
END

CREATE DEFINER=`admin`@`localhost` PROCEDURE `physician_affiliation`(IN employee_id INT)
BEGIN
   SELECT phy.name physician, dept.name department
   FROM physician phy, department dept, affiliated_with afw
   WHERE phy.employeeid = afw.physician
   AND dept.departmentid = afw.department
   AND afw.primaryaffiliation = 't'
   AND phy.employeeid = employee_id;
END


CREATE DEFINER=`admin`@`localhost` PROCEDURE `registered_nurse`()
BEGIN
  SELECT *
  FROM nurse
  WHERE `registered` = 'f';
END


CREATE DEFINER=`admin`@`localhost` PROCEDURE `room_available`()
BEGIN
   SELECT COUNT(unavailable) Room_available
   FROM room
   WHERE unavailable = 'f';
END

/******************FUNCTION********************/
CREATE DEFINER=`admin`@`localhost` FUNCTION `available_room`() RETURNS int
    DETERMINISTIC
BEGIN
   DECLARE num INTEGER;
   SELECT COUNT(unavailable) INTO num
   FROM room
   WHERE unavailable = 'f';
RETURN num;
END
