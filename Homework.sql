Use TavernsDB;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Rats;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS ServicesSales;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS GuestsClasses;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS RoomStays;
DROP TABLE IF EXISTS Statuses;


CREATE TABLE Locations (
	Id INT IDENTITY(1, 1),
	Name varchar(250),
);
ALTER TABLE Locations ADD PRIMARY KEY (Id);
INSERT INTO Locations (Name) VALUES ('NJ'),('NY'),('MA'),('DE'),('MD'),('VA');

CREATE TABLE Taverns(
	Id INT IDENTITY(1, 1),
    LocationId INT,
	TavernName varchar(250),
    OwnerId Int
);
ALTER TABLE Taverns ADD PRIMARY KEY (Id);

INSERT INTO Taverns (TavernName,LocationId,OwnerId) VALUES ('The Hall',1,1),('Moes',2,2),('Petrocks',1,3),('Petrocks',2,4),('Rat R US',5,5);

CREATE TABLE Users (
	Id INT IDENTITY(1, 1),
	Name varchar(250),
    RoleId INT
);
ALTER TABLE Users ADD PRIMARY KEY (Id);
INSERT INTO Users (Name,RoleId) VALUES ('Kathy',1),('Moe',1),('Jim',1),('sam',2),('Rat King',1),('Tim', 2),('Bethany',2);

CREATE TABLE Roles (
	Id INT IDENTITY(1, 1),
	Name varchar(50),
    Description varchar(Max)
);
ALTER TABLE Roles ADD PRIMARY KEY (Id);
INSERT INTO Roles (Name,Description) VALUES ('Owner','The owner of the Tavern'),('Bartender','Server the beer'),('Waiter','Servers Tables'),('Dish washer','Washes dishes'),('Customer','Patron of the Tavern');

CREATE TABLE Rats (
	Id TINYINT IDENTITY(1, 1) PRIMARY KEY,
	Name varchar(250),
);
INSERT INTO Rats (Name) VALUES ('Micky'),('Pikachu'),('Lou'),('Charlie'),('Minnie'),('Ricky'),('Bubbles');
DROP TABLE Rats; 

CREATE TABLE Supplies (
	Id INT IDENTITY(1, 1),
	Name varchar(250),
);
ALTER TABLE Supplies ADD PRIMARY KEY (Id);
INSERT INTO Supplies (Name) VALUES ('Coors'),('Guinness'),('Reds'),('Heineken'),('Blue Moon'),('Popcorn');

CREATE TABLE Inventory (
	Id INT IDENTITY(1, 1),
    tavernId INT,
    supplyId INT,
    Updated DATETIME,
);
ALTER TABLE Inventory ADD PRIMARY KEY (Id);
INSERT INTO Inventory (tavernId, supplyId) VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

CREATE TABLE Sales (
	Id INT IDENTITY(1, 1),
    tavernId Int,
    userId INT,
    price Int,
    supplyId INT,
    Updated DATETIME,
);
ALTER TABLE Sales ADD PRIMARY KEY (Id);
ALTER TABLE Sales ADD FOREIGN KEY (supplyId) REFERENCES Supplies(Id);
INSERT INTO Sales (tavernId, userId, price, supplyId) VALUES (1,2, 5, 1),(1,2, 50, 2),(2,3, 5, 3),(3,2, 7, 1),(5,2, 9, 4), (4,4, 18, 4);

CREATE TABLE Services (
	Id INT IDENTITY(1, 1),
    name varchar(250),
    tavernId Int,
    price Int,
    status varchar(250),
    Updated DATETIME,
);
ALTER TABLE Services ADD PRIMARY KEY (Id);
INSERT INTO Services (name, tavernId, price, status) VALUES ('Bar Service',1,NULL, 'Active'),('Bar Service',2,NULL, 'Active'),('Bar Service',3,NULL, 'Active'),('Bar Service',4,NULL, 'Active'),('Bar Service',5,NULL, 'Active'),('Pool',1,NULL, 'Not Active'),('Pool',3,NULL, 'Active'),('Darts',2,NULL, 'Active'),('Darts',4,NULL, 'Not Active');
ALTER TABLE Taverns ADD FOREIGN KEY (LocationId) REFERENCES Locations(Id);

CREATE TABLE Guests (
	Id INT IDENTITY(1, 1),
    name varchar(250),
    notes varchar(MAX),
    birthday DATETIME,
    cakeday DATETIME,
    statusId INT,
);
ALTER TABLE Guests ADD PRIMARY KEY (Id);

CREATE TABLE Classes(
  Id INT IDENTITY(1, 1),
  name varchar(250),
);
ALTER TABLE Classes ADD PRIMARY KEY (Id);
INSERT INTO Classes (name) VALUES ('Knight'),('Mage'),('Cleric'),('Ranger'),('Thief'),('Brawler');

CREATE TABLE GuestsClasses (
	Id INT IDENTITY(1, 1),
    guestId INT,
    classId INT,
    Lvl INT,
);
ALTER TABLE GuestsClasses ADD PRIMARY KEY (Id);
CREATE TABLE Statuses (
	Id INT IDENTITY(1, 1),
    name varchar(250),
);
ALTER TABLE Statuses ADD PRIMARY KEY (Id);

/* this statement will fail prior to establishing the foreign key relations */
/* Select Guests.name, Classes.name, GuestsClasses.lvl FROM Guests, Classes, GuestsClasses WHERE GuestsClasses.guestId = Guests.Id AND GuestsClasses.classId = Classes.Id */

ALTER TABLE Taverns ADD FOREIGN KEY (OwnerId) REFERENCES Users(Id);
ALTER TABLE GuestsClasses ADD FOREIGN KEY (guestId) REFERENCES Guests(Id);
ALTER TABLE GuestsClasses ADD FOREIGN KEY (classId) REFERENCES Classes(Id);
ALTER TABLE Guests ADD FOREIGN KEY (statusId) REFERENCES Statuses(Id);

/*The select from before will now work*/
INSERT INTO Statuses (name) VALUES ('Healthy');
INSERT INTO Guests (name,birthday,cakeday, notes, statusId) VALUES ('Nick','5/26/1996','1/1/2020','Left',1);
INSERT INTO Guests (name,birthday,cakeday, notes, statusId) VALUES ('Matt','5/26/1996','1/1/2020','Right',1);
INSERT INTO Guests (name,birthday,cakeday, notes, statusId) VALUES ('Nick','5/26/1996','1/1/2020','Here',1);
INSERT INTO Guests (name,birthday,cakeday, notes, statusId) VALUES ('Ryan','6/15/1996','1/1/2020','Here',1),('Hannah','10/5/1996','1/1/2020','Here',1);
INSERT INTO GuestsClasses (guestId, classId, lvl) VALUES (1,2,10);
INSERT INTO GuestsClasses (guestId, classId, lvl) VALUES (2,3,20);
/* Homework 3 */
CREATE TABLE Rooms (
	Id INT IDENTITY(1, 1),
    tavernId INT,
	statusId INT,
	rate INT,
);
ALTER TABLE Rooms ADD PRIMARY KEY (Id);
ALTER TABLE Rooms ADD FOREIGN KEY (tavernId) REFERENCES Taverns(Id);
ALTER TABLE Rooms ADD FOREIGN KEY (statusId) REFERENCES Statuses(Id);
INSERT INTO Rooms (tavernId, statusId, rate) VALUES (1,1,105);
INSERT INTO Statuses (name) VALUES ('vacant'),('occupied');
INSERT INTO Rooms (tavernId, statusId, rate) VALUES (2,2,95),(1,2,115),(1,2,80),(3,2,87),(1,2,125),(1,2,95),(4,3,156),(3,3,200),(5,3,15),(5,3,16),(2,3,65),(2,3,65);

CREATE TABLE RoomStays (
	Id INT IDENTITY(1, 1),
    roomId INT,
    guestId INT,
    saleId INT,
    stay DATETIME,
);
ALTER TABLE RoomStays ADD PRIMARY KEY (Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (roomId) REFERENCES Rooms(Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (guestId) REFERENCES Guests(Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (saleId) REFERENCES Sales(Id);

INSERT INTO RoomStays (roomId, guestId, saleId, stay) VALUES (1,1,1, 5/26/2020);
/* 2 */
SELECT * FROM Guests where birthday > 1/1/2000 ;
/* 3 */
SELECT * FROM Rooms where rate > 100 ;
/* 4 */
SELECT DISTINCT name FROM Guests;
/* 5 */
SELECT * FROM Guests ORDER BY name asc;
/* 6 */
SELECT TOP 10 rate FROM Rooms;
/* 7 */
SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS;
/* 8 */
SELECT G.RANGE AS [score range], COUNT(*) AS [number of occurences]
FROM (
  SELECT CASE  
    WHEN lvl between 1 and 10 THEN ' 1-10'
    WHEN lvl between 11 and 20 THEN '11-20'
	WHEN lvl between 21 and 30 THEN '21-30'
	WHEN lvl between 31 and 40 THEN '31-40'
	WHEN lvl between 41 and 50 THEN '41-50'
	WHEN lvl between 51 and 60 THEN '51-60'
	WHEN lvl between 61 and 70 THEN '61-70'
	WHEN lvl between 71 and 80 THEN '71-80'
	WHEN lvl between 81 and 90 THEN '81-90'
	WHEN lvl between 91 and 98 THEN '91-99'
    ELSE 'Max' END AS RANGE
  FROM GuestsClasses) G
GROUP BY G.RANGE
/*9*/
SELECT CONCAT('INSERT INTO ',TABLE_NAME,' (Name) VALUES') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Guests' UNION ALL SELECT CONCAT('(''',name,'''),') FROM Statuses;

/* Lab 4 */
SELECT Guests.*, Classes.name, GuestsClasses.lvl FROM Guests 
FULL JOIN GuestsClasses 
ON Guests.Id = GuestsClasses.guestId 
FULL JOIN Classes 
On Classes.Id = GuestsClasses.classId;


SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS

SELECT INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME, 
INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME, 
INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE,
INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
ON INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME = INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
ON INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS.CONSTRAINT_NAME = INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME;

SELECT INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME, 
INFORMATION_SCHEMA.KEY_COLUMN_USAGE.TABLE_NAME, 
INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE;

SELECT INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS.CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS;

/*Lab 5 ? */
/* ALTER TABLE Rooms ADD PRIMARY KEY (Id);*/
/* ALTER TABLE GuestsClasses ADD FOREIGN KEY (guestId) REFERENCES Guests(Id);*/
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
Then CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), 
')') Else '' END), ',') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols WHERE
TABLE_NAME = 'Taverns'
UNION ALL
SELECT ')'
UNION ALL
SELECT 
CONCAT('ALTER TABLE ',INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME, ' ADD ', 'PRIMARY KEY',' (', INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME, ')')
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
ON INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME = INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME 
WHERE INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME = 'Taverns' AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'PRIMARY KEY'
UNION ALL
SELECT 
CONCAT('ALTER TABLE ',INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME, ' ADD',' FOREIGN KEY',' (', INFORMATION_SCHEMA.KEY_COLUMN_USAGE.COLUMN_NAME, ') REFERENCES')
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
ON INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_NAME = INFORMATION_SCHEMA.KEY_COLUMN_USAGE.CONSTRAINT_NAME 
WHERE INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME = 'Taverns' AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY';

/* Homework 4 */
/* 1 */
/*Insert for testing purpose*/
INSERT INTO Roles (Name,Description) VALUES ('Admin','System Admin');
INSERT INTO Users (Name,RoleId) VALUES ('Don',6);

SELECT * FROM Users 
INNER JOIN Roles ON (Users.roleId = Roles.Id) 
WHERE Roles.Name = 'Admin';

/* 2 */
/*Insert for testing purpose*/
INSERT INTO Taverns (TavernName,LocationId,OwnerId) VALUES ('Kona',1,8);

SELECT Users.name, Taverns.* FROM Users 
INNER JOIN Roles ON (Users.RoleId = Roles.Id)
INNer JOIN Taverns ON (Taverns.ownerId = Users.Id)
WHERE Roles.name = 'Admin';

/* 3 */
SELECT Guests.name, Classes.name, GuestsClasses.lvl FROM Guests 
JOIN GuestsClasses 
ON Guests.Id = GuestsClasses.guestId 
JOIN Classes 
On Classes.Id = GuestsClasses.classId
ORDER BY Guests.name ASC;

/* 4 */
CREATE TABLE ServicesSales (
	Id INT IDENTITY(1, 1) Primary Key,
    serviceId INT FOREIGN KEY REFERENCES Services(Id),
	guestId INT FOREIGN KEY REFERENCES Guests(Id),
);
/*Insert for testing purpose*/
INSERT INTO ServicesSales (serviceId,guestId) VALUES (1,4);

SELECT TOP 10 ServicesSales.*, Services.name, Services.price, Guests.name
FROM ServicesSales
JOIN Services 
ON (ServicesSales.serviceId = Services.Id)
JOIN Guests 
ON (ServicesSales.guestId = Guests.Id);

/* 5 */
SELECT Guests.name, COUNT(Classes.name) AS 'Class Count' FROM Classes
JOIN GuestsClasses 
ON (GuestsClasses.classId = Classes.Id)
JOIN Guests 
ON (GuestsClasses.guestId = Guests.Id)
GROUP BY Guests.name
HAVING COUNT(Classes.name) > 1;

/* 6 */
SELECT Guests.name, COUNT(Classes.name) AS 'Class Count' FROM Classes
JOIN GuestsClasses 
ON (GuestsClasses.classId = Classes.Id)
JOIN Guests 
ON (GuestsClasses.guestId = Guests.Id)
Where GuestsClasses.lvl > 5
GROUP BY Guests.name
HAVING COUNT(Classes.name) > 1;

/*7 */
/*Insert for testing purpose*/
INSERT INTO GuestsClasses (guestId, classId, lvl) VALUES (2,4,35),(1,2,20);

SELECT Guests.Name, MAX(GuestsClasses.lvl) AS 'Max lvl' FROM Guests
JOIN GuestsClasses 
ON (GuestsClasses.guestId = Guests.Id)
JOIN Classes ON (GuestsClasses.classId = Classes.Id)
GROUP BY Guests.Name;

/*8 */
INSERT INTO RoomStays (roomId, guestId, saleId, stay) VALUES (1,2,3, 01/01/2010);

SELECT Guests.name, RoomStays.stay FROM Guests
JOIN RoomStays ON (Guests.Id = RoomStays.guestId)
WHERE RoomStays.stay BETWEEN 01/01/1999 AND 01/01/2020;

/* 9 */
/* Built off sample provided rather than my attempt*/
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
	Else '' 
	END)
, 

	CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
	Then 
		(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
	Else '' 
	END,

	CASE WHEN cols.COLUMN_NAME = 'Id'
	THEN (' IDENTITY (1,1) Primary Key')
	ELSE ''
	END
,
',') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
 WHERE cols.TABLE_NAME = 'Taverns'
UNION ALL
SELECT ')'; 

/*Homework 5*/
/* 1 */

SELECT Users.name, Roles.name FROM Users JOIN Roles 
ON (Users.roleId = Roles.Id);

/*2*/
SELECT Classes.Id, Classes.name AS 'Class Name', COUNT(Guests.name) AS 'Guests #' FROM Classes
LEFT JOIN GuestsClasses 
ON (Classes.Id = GuestsClasses.classId)
LEFT JOIN Guests 
ON (guests.Id = GuestsClasses.guestId)
GROUP BY Classes.Id, Classes.name;

/*3*/
SELECT Guests.name AS 'Guest', Classes.name AS 'Class', GuestsClasses.lvl, (
	CASE 
	WHEN lvl < 5 
	THEN 'Beginner'
	WHEN lvl BETWEEN 5 AND 9
	THEN 'Intermediate'
	WHEN lvl >= 10
	THEN 'Expert'
	ELSE 'No Class'
	END) AS 'Label'
FROM Guests
JOIN GuestsClasses ON (Guests.Id = GuestsClasses.guestId)
JOIN Classes ON (Classes.Id = GuestsClasses.classId)
ORDER BY Guests.name ASC;

/*4*/
IF OBJECT_ID (N'dbo.getLevels', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.getLevels;  
GO  
CREATE FUNCTION dbo.getLevels(@lvl int)
RETURNS varchar(20)
AS
BEGIN
	DECLARE @ret varchar(20)
	SELECT @ret = (CASE 
	WHEN @lvl < 5
	THEN 'Beginner'
	WHEN @lvl BETWEEN 5 AND 9
	THEN 'Intermediate'
	WHEN @lvl >= 10
	THEN 'Expert'
	ELSE 'No Class'
	END)
	RETURN @ret;
END;

/*5*/
IF OBJECT_ID (N'dbo.getLevels', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.getRooms;  
GO  
CREATE FUNCTION dbo.getRooms(@day DATETIME)
RETURNS TABLE  
AS                
RETURN   

	SELECT DISTINCT Rooms.Id AS 'Room #', Rooms.rate, Taverns.TavernName FROM Rooms
	LEFT JOIN Taverns ON (Taverns.Id = Rooms.tavernId)
	LEFT JOIN RoomStays ON (Rooms.Id = RoomStays.roomId)
	WHERE RoomStays.stay != @day
;
/*6*/

IF OBJECT_ID (N'dbo.getRoomsPrice', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.getRoomsPrice;  
GO  
CREATE FUNCTION dbo.getRoomsPrice(@min int, @max int)
RETURNS TABLE  
AS                
RETURN   

	SELECT DISTINCT Rooms.Id AS 'Room #', Rooms.rate, Taverns.TavernName, Rooms.tavernId FROM Rooms
	LEFT JOIN Taverns ON (Taverns.Id = Rooms.tavernId)
	WHERE Rooms.rate BETWEEN @min AND @max
;

/*7*/
SELECT 'INSERT INTO Rooms (tavernId, statusId, rate)'
UNION ALL
SELECT CONCAT('VALUES (3,2,', (rate)-1 ,');'
) FROM dbo.getRoomsPrice(1, 999) AS rooms
WHERE rate = (SELECT Min(rate) FROM dbo.getRoomsPrice(1, 999))
