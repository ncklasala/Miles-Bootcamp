DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Rats;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Statuses;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS RoomStays;

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
	Id TINYINT IDENTITY(1, 1),
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
	Id TINYINT IDENTITY(1, 1),
	Name varchar(250),
);
ALTER TABLE Supplies ADD PRIMARY KEY (Id);
INSERT INTO Supplies (Name) VALUES ('Coors'),('Guinness'),('Reds'),('Heineken'),('Blue Moon'),('Popcorn');

CREATE TABLE Inventory (
	Id TINYINT IDENTITY(1, 1),
    tavernId INT,
    supplyId TINYINT,
    Updated DATETIME,
);
ALTER TABLE Inventory ADD PRIMARY KEY (Id);
INSERT INTO Inventory (tavernId, supplyId) VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

CREATE TABLE Sales (
	Id INT IDENTITY(1, 1),
    tavernId Int,
    userId INT,
    price Int,
    supplyId TINYINT,
    Updated DATETIME,
);
ALTER TABLE Sales ADD PRIMARY KEY (Id);
ALTER TABLE Sales ADD FOREIGN KEY (supplyId) REFERENCES Supplies(Id);
INSERT INTO Sales (tavernId, userId, price, supplyId) VALUES (1,2, 5, 1),(1,2, 50, 2),(2,3, 5, 3),(3,2, 7, 1),(5,2, 9, 4), (4,4, 18, 4);

CREATE TABLE Services (
	Id TINYINT IDENTITY(1, 1),
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
INSERT INTO GuestsClasses (guestId, classId, lvl) VALUES (1,2,10);

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
    saleId TINYINT,
    stay DATETIME,
);
ALTER TABLE RoomStays ADD PRIMARY KEY (Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (roomId) REFERENCES Rooms(Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (guestId) REFERENCES Guests(Id);
ALTER TABLE RoomStays ADD FOREIGN KEY (saleId) REFERENCES Sales(Id);
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
select G.range as [score range], count(*) as [number of occurences]
from (
  select case  
    when lvl between 1 and 10 then ' 1-10'
    when lvl between 11 and 20 then '11-20'
	when lvl between 21 and 30 then '21-30'
	when lvl between 31 and 40 then '31-40'
	when lvl between 41 and 50 then '41-50'
	when lvl between 51 and 60 then '51-60'
	when lvl between 61 and 70 then '61-70'
	when lvl between 71 and 80 then '71-80'
	when lvl between 81 and 90 then '81-90'
	when lvl between 91 and 98 then '91-99'
    else 'Max' end as range
  from GuestsClasses) G
group by G.range
