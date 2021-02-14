

/* Write a query to display all appointments made by the patient with patientID 2200003 

SELECT * FROM APPOINTMENT
WHERE PatientID = 2200003;
*/

/*Write a query to display names of doctors and patients, doctors' specialism, 
appointment' ID, date and time made by the patient with patientID 2200003

SELECT ApptID, ApptDate, ApptTime, PatientName, DoctorName, Speialism
FROM APPOINTMENT
JOIN DOCTOR on APPOINTMENT.DoctorID = DOCTOR.DoctorID
JOIN PATIENT on APPOINTMENT.PatientID = PATIENT.PatientID
WHERE APPOINTMENT.PatientID = 2200003;
*/

/*Write a query to display the names and phone of all patient and doctor
Assume that no patient is also a doctor. 

SELECT 'Doctor' as Type, DoctorName, DoctorPhone
FROM DOCTOR
UNION
SELECT 'Patient', PatientName, PatientPhone
FROM PATIENT;
*/

/*Write a query display the name of all doctor and the name of their supervisor

SELECT a.DoctorName, b.DoctorName as SupervisorName
FROM DOCTOR a 
LEFT JOIN DOCTOR b ON a.DoctorID = b.SuperID;
*/

/*Write a query display the department number( from smallest to largest), department name,
 doctor names, Speialism of all female doctors 
 
 SELECT DeptNo, DeptName, DoctorName, Speialism
 FROM DEPARTMENT
 LEFT JOIN DOCTOR ON DEPARTMENT.DeptNo = DOCTOR.DNo
 WHERE DoctorSex = 'F'
 ORDER BY DeptNo;
 */
 

 
