


CREATE TABLE DOCTOR (
  DoctorID    char(5) NOT NULL,
  DoctorName  varchar(15),
  DoctorDOB   date,
  DoctorSex   char,
  Speialism   varchar(20),
  DoctorPhone varchar(20),
  DNo         numeric,
  SuperID     char(5),
  primary key (DoctorID),
  foreign key (SuperID) references DOCTOR(DoctorID)
);


CREATE TABLE PATIENT (
  PatientID    char(9) NOT NULL,
  PatientName  varchar(15),
  PatientDOB   date,
  PatientSex   char,
  PatientPhone varchar(20),
  primary key (PatientID)
  );


CREATE TABLE DEPARTMENT (
  DeptNo       numeric,
  DeptName     varchar(30) NOT NULL,
  MgrID        char(5),
  primary key (DeptNo),
  unique (DeptName),
  foreign key (MgrID) references DOCTOR(DoctorID)
);

ALTER TABLE DOCTOR ADD foreign key (DNo) references DEPARTMENT(DeptNo);

CREATE TABLE APPOINTMENT (
  ApptID       char(10) NOT NULL,
  ApptDate     date,
  ApptTime     varchar(10),
  DoctorID     char(5),
  PatientID    char(9),
  primary key (ApptID),
  foreign key (DoctorID) references DOCTOR(DoctorID),
  foreign key (PatientID) references PATIENT(PatientID)
  );
  

