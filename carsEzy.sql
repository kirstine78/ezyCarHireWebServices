--  CarsEzy
--  Kirstine Nielsen 100527988

-- Delete database and rebuild new database

Drop Database If Exists CarsEzy;
Create Database If Not Exists CarsEzy;
Use CarsEzy;

-- Build tables and Add Test Data

Create Table If Not Exists tblCustomer
(
 fldCustomerId				MEDIUMINT 		Not Null AUTO_INCREMENT,
 fldEmail					VarChar(40) 	Not Null,
 fldSalt					char(10),
 fldAuthenticationKey		char(32) 		Not Null,
 fldFirstName				VarChar(20) 	Not Null,
 fldLastName				VarChar(20)		Not Null,
 fldLicenceNo				Char(9)			Not Null,
 fldMobile					VarChar(10)		Not Null,
 Constraint tblCustomer_pk Primary Key (fldCustomerId),
 UNIQUE KEY fldEmail (fldEmail)
 ) Engine=InnoDB Default Charset=utf8;
 
INSERT INTO tblCustomer VALUES (1, 'anton@mail.com', 	'Q6Q8amXOwG', '3895016ea20bc731c5f539fa4c283f55', 'Anton', 'Marcussen', '789456123', '0448895596');
INSERT INTO tblCustomer VALUES (2, 'brian@mail.com', 	'Xb0fIgdOxu', '590a7813ec4d8efed2c228ca62cb5948', 'Brian', 'Mikkelsen', '222234561', '5044889596');
INSERT INTO tblCustomer VALUES (3, 'cathy@mail.com', 	'fziPHfkLE4', 'c8202b82a60c83cd7b1d47ded73a6910', 'Cathy', 'Smith', '342663561', '5950448896');
INSERT INTO tblCustomer VALUES (4, 'donna@mail.com', 	'tgHK4NWuYk', 'd96f3c18be16f75925bfc67243a0ffbc', 'Donna', 'Lawler', '340263942', '4885950496');
INSERT INTO tblCustomer VALUES (5, 'karo@mail.com', 	'Y2wkSBzKgT', '54c8249405cd7623ba8a7a6cdcd18f18', 'Karoline', 'Anderson', '326394042', '6545958856');

-- INSERT INTO tblCustomer VALUES (6, 'm@m', 				'fkMfmHMoD2', '7862a99f478c2cdab320bf8da24a9cfd', 'Kir', 'Nie', '123456789', '1234567222');



Create Table If Not Exists tblSuburb
(
 fldSuburbId				MEDIUMINT 		Not Null AUTO_INCREMENT,
 fldSuburb					VarChar(20) 	Not Null,
 fldPostCode				Char(4)			Not Null,
 Constraint tblSuburb_pk Primary Key (fldSuburbId)
 ) Engine=InnoDB Default Charset=utf8;
 
 INSERT INTO tblSuburb VALUES (1, 'Melbourne', '3000');
 INSERT INTO tblSuburb VALUES (2, 'Hawthorn', '3122');
 INSERT INTO tblSuburb VALUES (3, 'Chadstone', '3145');
 

 
Create Table If Not Exists tblLocation
(
 fldLocationId				MEDIUMINT 		Not Null AUTO_INCREMENT,
 fldSuburbId				MEDIUMINT 		Not Null,
 fldStreetName				VarChar(40) 	Not Null,
 fldDescription				VarChar(100)	Not Null,
 fldLatitude				double(8,6),
 fldLongitude				double(9,6),
 Constraint tblLocation_pk Primary Key (fldLocationId),
 Constraint tblLocation_Suburb_fk Foreign Key (fldSuburbId) References tblSuburb (fldSuburbId)
 ) Engine=InnoDB Default Charset=utf8;
 
INSERT INTO tblLocation VALUES (1, 1, 'Bourke st', 'In front of Target', -37.813358, 144.966327);
INSERT INTO tblLocation VALUES (2, 1, 'Elizabeth st', 'Opposite St. Franicis Church', -37.811714, 144.961907);
INSERT INTO tblLocation VALUES (3, 2, 'Auburn rd', 'Corner of Auburn rd and Barkers rd', -37.815931, 145.046154);
INSERT INTO tblLocation VALUES (4, 2, 'Barkers rd', 'Corner of Haines st', -37.815269, 145.041530);
INSERT INTO tblLocation VALUES (5, 3, 'Chadstone rd', 'Corner of Bellevue Ave and Chadstone rd', -37.883989, 145.078702);
INSERT INTO tblLocation VALUES (6, 3, 'Warrigal rd', 'Corner of Warrigal rd and Castlebar rd', -37.889269, 145.088805);
  
  

Create Table If Not Exists tblCar
(
 fldCarId				MEDIUMINT 		Not Null AUTO_INCREMENT,
 fldRegoNo				VarChar(6)		Not Null,
 fldLocationId			MEDIUMINT	 	Not Null,
 fldBrand				VarChar(15)		Not Null,
 fldSeating				TINYINT			Not Null,
 fldHirePriceCurrent	double			Not Null,
 Constraint tblCar_pk Primary Key (fldCarId),
 UNIQUE KEY fldRegoNo (fldRegoNo),
 Constraint tblCar_Location_fk Foreign Key (fldLocationId) References tblLocation (fldLocationId)
 ) Engine=InnoDB Default Charset=utf8;

INSERT INTO tblCar VALUES (1, 'ZJR161', 1, 'Subaru', 5, 100);
INSERT INTO tblCar VALUES (2, 'TTR345', 2, 'Subaru', 5, 100);
INSERT INTO tblCar VALUES (3, 'AFF345', 3, 'Subaru', 5, 95);
INSERT INTO tblCar VALUES (4, 'GTR188', 4, 'Toyota', 5, 85);
INSERT INTO tblCar VALUES (5, 'BGT658', 5, 'Toyota', 5, 85);
INSERT INTO tblCar VALUES (6, 'HUT151', 6, 'Toyota', 2, 70);
INSERT INTO tblCar VALUES (7, 'BBT654', 1, 'Holden', 4, 105);
INSERT INTO tblCar VALUES (8, 'WQE161', 2, 'Holden', 5, 110);
INSERT INTO tblCar VALUES (9, 'WKS161', 3, 'Holden', 5, 110);
INSERT INTO tblCar VALUES (10, 'BBR111', 4, 'Nissan', 7, 125);
INSERT INTO tblCar VALUES (11, 'KUE177', 5, 'Nissan', 5, 90);
INSERT INTO tblCar VALUES (12, 'TBR131', 6, 'Nissan', 7, 125);
 
 
 
Create Table If Not Exists tblBooking
(
 fldBookingNo			MEDIUMINT 		Not Null AUTO_INCREMENT,
 fldCarId				MEDIUMINT		Not Null,
 fldCustomerId			MEDIUMINT 		Not Null,
 fldStartDate 			date			Not null,
 fldReturnDate			date			Not null,
 fldActualReturnDate	date,
 fldOdometerFinish		int,
 fldHirePricePerDay		double			Not Null,
 Constraint tblBooking_pk Primary Key (fldBookingNo),
 Constraint tblBooking_CarId_fk Foreign Key (fldCarId) References tblCar (fldCarId),
 Constraint tblBooking_CustomerId_fk Foreign Key (fldCustomerId) References tblCustomer (fldCustomerId)
 ) Engine=InnoDB Default Charset=utf8;
 
 INSERT INTO tblBooking VALUES (1, 8, 	1, 	'2016-02-15', 	'2016-02-18', 	'2016-02-18', 	10500, 	110);
 INSERT INTO tblBooking VALUES (2, 12, 	2, 	'2016-03-30', 	'2016-03-31', 	'2016-03-31', 	17500,	125); 
 INSERT INTO tblBooking VALUES (3, 1, 	3, 	'2016-01-01', 	'2016-01-09', 	'2016-01-09', 	1500, 	100); 
 INSERT INTO tblBooking VALUES (4, 11, 	4, 	'2016-09-25', 	'2016-09-09', 	null, 			null, 	125);
 INSERT INTO tblBooking VALUES (5, 6, 	4, 	'2016-09-22', 	'2016-09-24', 	null, 			null, 	70);
 INSERT INTO tblBooking VALUES (6, 7, 	5, 	'2016-03-16', 	'2016-03-18', 	'2016-03-18', 	9500, 	105);
 INSERT INTO tblBooking VALUES (7, 2, 	5, 	'2016-09-03', 	'2017-09-10',	 null, 			null, 	100);
 
 
-- INSERT INTO tblBooking VALUES (8, 5, 	1, 	'2016-08-25', 	'2016-08-26',	 null, 			null, 	100);
-- INSERT INTO tblBooking VALUES (9, 6, 	2, 	'2016-08-25', 	'2016-08-26',	 null, 			null, 	100);
-- INSERT INTO tblBooking VALUES (10, 12, 5, 	'2016-08-25', 	'2016-08-26',	 null, 			null, 	100);
 
 -- late
-- INSERT INTO tblBooking VALUES (11, 3, 6, 	'2016-08-15', 	'2016-08-16', null, 			null, 	95);
 
 -- today
-- INSERT INTO tblBooking VALUES (12, 3, 6, 	'2016-08-20', 	'2016-08-24',	 '2016-08-20', 			null, 	95);
 
 
 -- future
-- INSERT INTO tblBooking VALUES (13, 3, 6, 	'2016-09-20', 	'2016-09-24',	 null, 			null, 	95);
 
 
 
 
 
 
 
 
 
 
 
 
 
 