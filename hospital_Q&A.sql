
USE `hospital`;
/* 1. Write a query in SQL to find all the information of the nurses 
who are yet to be registered.*/
SELECT * FROM `nurse`
WHERE `registered` = 'f';

CALL `hospital`.`registered_nurse`();


/* 2. Write a query in SQL to find the name of the nurse who are the head of their department.*/
SELECT `name` 
FROM `nurse`
WHERE `position` LIKE 'HEAD%';


/* 3. Write a query in SQL to obtain the name of the physicians who are the head of each department.*/
SELECT `name` FROM `physician`
WHERE `employeeid` IN (SELECT `head` FROM `department`);

/* 4.Write a query in SQL to count the number of patients who taken appointment with at least one physician. */
SELECT `patient`, COUNT(`patient`) patient_pop
FROM `appointment`
WHERE `physician` IS NOT NULL
GROUP BY `patient`;

/* 5.Write a query in SQL to find the floor and block where the room number 212 belongs to.*/
SELECT blockfloor, blockcode
FROM room
where roomnumber = 212;

CALL `hospital`.`find_room`(103);


/* 6.Write a query in SQL to count the number available rooms.*/
SELECT COUNT(unavailable) Room_available
FROM room
WHERE unavailable = 'f';

CALL `hospital`.`room_available`();

SELECT `hospital`.`available_room`() FROM DUAL;

/* 7. Write a query in SQL to count the number of unavailable rooms.  */
SELECT COUNT(unavailable)
FROM room
WHERE unavailable = 't';


/* 8. Write a query in SQL to obtain the name of the physician and the departments they are affiliated with.*/
SELECT phy.name physician, dept.name department
FROM physician phy, department dept, affiliated_with afw
WHERE phy.employeeid = afw.physician
AND dept.departmentid = afw.department
AND afw.primaryaffiliation = 't';

CALL `hospital`.`physician_affiliation`(8);


/* 9. Write a query in SQL to obtain the name of the physicians who are trained for a special treatement.*/
SELECT phy.name, PRO.NAME TREATMENT_NAME
FROM physician phy, trained_in tin,`PROCEDURE` PRO
WHERE phy.employeeid=tin.physician
AND tin.treatment = pro.code;


/* 10. Write a query in SQL to obtain the name of the physicians with department who are yet to be affiliated.*/
SELECT phy.name, dept.name
FROM physician phy, department dept, affiliated_with afw
WHERE phy.employeeid = afw.physician
AND dept.departmentid = afw.department
AND afw.primaryaffiliation = 'f';


/* 11. Write a query in SQL to obtain the name of the physicians who are not a specialized physician.*/
SELECT *
FROM physician
WHERE position NOT LIKE '%Physician';

/* 12. Write a query in SQL to obtain the name of the patients with their physicians by whom they got their preliminary treatement.*/
SELECT patient.name, physician.name
FROM patient, physician
WHERE patient.pcp = physician.employeeid;

/* 13. Write a query in SQL to find the name of the patients and the number of physicians they have taken appointment.*/

SELECT name, count(physician) phy_nb
FROM (SELECT patient.name, appointment.physician, ROW_NUMBER() OVER (PARTITION BY name, physician) NB
      FROM patient, appointment
      WHERE patient.ssn = appointment.patient
      ORDER BY patient.name, appointment.physician) AA
WHERE NB = 1
GROUP BY name;

/* 14. Write a query in SQL to count number of unique patients who got an appointment for examination room C.*/

SELECT COUNT(DISTINCT patient)
FROM appointment
WHERE examinationroom = 'C';

/* 15. Write a query in SQL to find the name of the patients and the number of the room where they have to go for their treatment.*/
SELECT name, examinationroom
FROM patient, appointment
WHERE `patient`.ssn = appointment.patient
ORDER BY name;

/* 16. Write a query in SQL to find the name of the nurses and the room scheduled, where they will assist the physicians. */
SELECT nurse.name, examinationroom
FROM nurse, appointment
WHERE nurse.employeeid = appointment.prepnurse;

/* 17. Write a query in SQL to find the name of the patients who taken the appointment on the 25th of April at 10 am, and also display their physician, assisting nurses and room no.*/
SELECT patient.name, physician, prepnurse, examinationroom, start_dt_time
FROM patient, appointment,physician, nurse
WHERE physician.employeeid = appointment.physician
AND nurse.employeeid=appointment.prepnurse
AND start_dt_time = CONVERT('2008-04-25 10:00:00',DATETIME);

/* 18. Write a query in SQL to find the name of patients and their physicians who does not require any assistance of a nurse. */
SELECT patient.name, physician.name
FROM patient, appointment, physician
WHERE patient.ssn = appointment.patient
AND appointment.physician = physician.employeeid
AND appointment.prepnurse IS NULL;

/* 19. Write a query in SQL to find the name of the patients, their treating physicians and medication.*/
SELECT patient.name patient_name,physician.name physician_name, medication.name medication_name
FROM patient,physician, prescribes, medication
WHERE patient.ssn=prescribes.patient
AND physician.employeeid = prescribes.physician
AND medication.code = prescribes.medication;


/* 20. Write a query in SQL to find the name of the patients who taken an advanced appointment, and also display their physicians and medication.*/
SELECT patient.name, physician.name, medication.name
FROM patient, prescribes, physician, medication
WHERE patient.ssn = prescribes.patient
AND appointment IS NOT NULL
AND physician.employeeid = prescribes.physician
AND medication.code = prescribes.medication;


/* 21. Write a query in SQL to find the name and medication for those patients who did not take any appointment.*/
SELECT patient.name, physician.name, medication.name
FROM patient, prescribes, physician, medication
WHERE patient.ssn = prescribes.patient
AND appointment IS NULL
AND physician.employeeid = prescribes.physician
AND medication.code = prescribes.medication;


/* 22. Write a query in SQL to count the number of available rooms in each block.*/
SELECT blockcode, count(unavailable) room_num
FROM ROOM
WHERE unavailable='f'
GROUP BY blockcode;


/* 23. Write a query in SQL to count the number of available rooms in each floor. */
SELECT blockfloor, count(unavailable) room_num
FROM ROOM
WHERE unavailable='f'
GROUP BY blockfloor;


/* 24. Write a query in SQL to count the number of available rooms for each block in each floor. */
SELECT blockcode, blockfloor, count(unavailable) room_num
FROM ROOM
WHERE unavailable='f'
GROUP BY blockcode, blockfloor;


/* 25. Write a query in SQL to count the number of unavailable rooms for each block in each floor.*/
SELECT blockcode, blockfloor, count(unavailable) room_num
FROM ROOM
WHERE unavailable='t'
GROUP BY blockcode, blockfloor;


/* 26. Write a query in SQL to find out the floor where the maximum no of rooms are available.*/

SELECT blockfloor,count(unavailable) room_num
FROM ROOM
WHERE unavailable='f'
GROUP BY blockfloor
ORDER BY room_num DESC
LIMIT 1;


/* 27. Write a query in SQL to find out the floor where the minimum no of rooms are available.*/
SELECT blockfloor,count(unavailable) room_num
FROM ROOM
WHERE unavailable='f'
GROUP BY blockfloor
ORDER BY room_num
LIMIT 1

/* 28. Write a query in SQL to obtain the name of the patients, their block, floor, and room number where they are admitted. */
SELECT patient.name, stay.room,room.blockfloor,room.blockcode
FROM patient, stay, room
WHERE patient.ssn = stay.patient
AND room.roomnumber = stay.room;

/* 29. Write a query in SQL to obtain the nurses and the block where they are booked for attending the patients on call.*/
SELECT nurse.name,blockcode
FROM nurse, on_call
WHERE nurse.employeeid = on_call.nurse;

/* 30. Write a query in SQL to make a report which will show -
a) name of the patient, 
b) name of the physician who is treating him or her,
c) name of the nurse who is attending him or her,
d) which treatement is going on to the patient,
e) the date of release,
f) in which room the patient has admitted and which floor and block the room belongs to respectively.*/

SELECT patient.name patient_name,physician.name physician_name,nurse.name nurse_name,'procedure',stay.end_time,room.roomnumber,room.blockfloor,room.blockcode
FROM patient, physician, nurse, undergoes, stay,room
WHERE patient.ssn=undergoes.patient
AND physician.employeeid = undergoes.physician
AND nurse.employeeid = undergoes.assistingnurse
AND stay.patient = undergoes.patient
AND room.roomnumber = stay.room;

/* 31. Write a SQL query to obtain the names of all the physicians performed a medical procedure but they are not ceritifed to perform. */
SELECT TT.name,`procedure`,position
FROM (SELECT name, `procedure`, position
      FROM physician, undergoes
      WHERE physician.employeeid = undergoes.physician) TT
LEFT JOIN (SELECT name,treatment
           FROM physician, trained_in
           WHERE trained_in.physician = physician.employeeid) BB
ON TT.name = BB.name AND TT.`procedure` = BB.treatment
WHERE BB.name is null;


/* 32. Write a query in SQL to obtain the names of all the physicians, their procedure, date when the procedure was carried out and name of the patient on which procedure have been carried out but those physicians are not cetified for that procedure. */
SELECT physician,procedure_name, date, patient
FROM (SELECT physician.name physician, physician.employeeid ID, undergoes.procedure, undergoes.date,patient.name patient,`procedure`.name procedure_name
FROM physician, undergoes,patient, `procedure`
WHERE physician.employeeid = undergoes.physician
AND patient.ssn=undergoes.patient
AND `procedure`.code = undergoes.`procedure`) AA

LEFT JOIN (SELECT employeeid,treatment
           FROM physician, trained_in
           WHERE trained_in.physician = physician.employeeid) BB
ON AA.ID = BB.employeeid AND AA.procedure = BB.treatment
WHERE BB.employeeid is null;


/* 33. Write a query in SQL to obtain the name and position of all physicians who completed a medical procedure with certification after the date of expiration of their certificate. */
SELECT name, position
FROM physician, (SELECT undergoes.physician, `procedure`
FROM undergoes, trained_in
WHERE undergoes.`procedure` = trained_in.treatment
AND undergoes.date > certificationexpires) AA
WHERE physician.employeeid = AA.physician;

/* 34. Write a query in SQL to obtain the name of all those physicians who completed a medical procedure with certification after the date of expiration of their certificate, their position, procedure they have done, date of procedure, name of the patient on which the procedure had been applied and the date when the certification expired*/
SELECT physician.name, position, `procedure`.name procedure_name,AA.procedure_date, patient.name patient_name, AA.expire_date
FROM physician, (SELECT undergoes.physician, undergoes.patient, `procedure`, undergoes.date procedure_date, certificationexpires expire_date
				 FROM undergoes, trained_in
				 WHERE undergoes.`procedure` = trained_in.treatment
				 AND undergoes.date > certificationexpires) AA, 
                 `procedure`, patient
WHERE physician.employeeid = AA.physician
AND `procedure`.code = AA.`procedure`
AND patient.ssn = AA.patient;

/* 35. Write a query in SQL to obtain the names of all the nurses who have ever been on call for room 122. */
SELECT name
FROM nurse, on_call,room
WHERE nurse.employeeid = on_call.nurse
AND on_call.blockfloor = room.blockfloor
AND on_call.blockcode = room.blockcode
AND room.roomnumber = 122;

/* 36. Write a query in SQL to Obtain the names of all patients who has been prescribed some medication by his/her physician who has carried out primary care and the name of that physician.*/

SELECT patient.name
FROM patient, prescribes, physician
WHERE patient.ssn = prescribes.patient
AND patient.pcp=prescribes.physician
AND physician.employeeid = patient.pcp;


/* 37. Write a query in SQL to obtain the names of all patients who has been undergone a procedure costing more than $5,000 and the name of that physician who has carried out primary care. */
SELECT patient.name patient_name, physician.name physician_name
FROM patient, undergoes,physician, `procedure`
WHERE patient.ssn=undergoes.patient
AND patient.pcp=physician.employeeid
AND undergoes.`procedure` = `procedure`.code
AND `procedure`.cost > 5000;

/* 38. Write a query in SQL to Obtain the names of all patients who had at least two appointment where the nurse who prepped the appointment was a registered nurse and the physician who has carried out primary care.*/
SELECT DISTINCT patient_name,nurse_name,physician_name
FROM (
SELECT patient.name patient_name,nurse.name nurse_name, physician.name physician_name,
       COUNT(appointmentid) OVER (PARTITION BY patient.name) num_appointment
FROM appointment,patient,nurse, physician
WHERE appointment.patient = patient.ssn
AND appointment.prepnurse = nurse.employeeid
AND physician.employeeid = patient.pcp
AND nurse.registered = 't') TT
WHERE num_appointment >=2;


/* 39. Write a query in SQL to Obtain the names of all patients whose primary care is taken by a physician who is not the head of any department and name of that physician along with their primary care physician.*/
SELECT patient.name patient, physician.name physician
FROM patient, physician
WHERE patient.pcp = physician.employeeid
AND pcp NOT IN (SELECT head FROM department);



