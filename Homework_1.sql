
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Rats;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Statuses;

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
	Id TINYINT IDENTITY(1, 1) PRIMARY KEY,
	Name varchar(50),
    Description varchar(Max)
);

INSERT INTO Roles (Name,Description) VALUES ('Owner','The owner of the Tavern'),('Bartender','Server the beer'),('Waiter','Servers Tables'),('Dish washer','Washes dishes'),('Customer','Patron of the Tavern');


CREATE TABLE Location (
	Id INT IDENTITY(1, 1) PRIMARY KEY,
	Name varchar(250),
);

INSERT INTO Location (Name) VALUES ('NJ'),('NY'),('MA'),('DE'),('MD'),('VA');



CREATE TABLE Rats (
	Id TINYINT IDENTITY(1, 1) PRIMARY KEY,
	Name varchar(250),
);


INSERT INTO Rats (Name) VALUES ('Micky'),('Pikachu'),('Lou'),('Charlie'),('Minnie'),('Ricky'),('Bubbles');


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
	Id TINYINT IDENTITY(1, 1) PRIMARY KEY,
    tavernId Int,
    userId INT,
    price Int,
    supplyId TINYINT,
    Updated DATETIME,
);
ALTER TABLE Sales ADD FOREIGN KEY (supplyId) REFERENCES Supplies(Id);
INSERT INTO Sales (tavernId, userId, price, supplyId) VALUES (1,2, 5, 1),(1,2, 50, 2),(2,3, 5, 3),(3,2, 7, 1),(5,2, 9, 4), (4,4, 18, 4);


CREATE TABLE Service (
	Id TINYINT IDENTITY(1, 1) PRIMARY KEY,
    name varchar(250),
    tavernId Int,
    price Int,
    status varchar(250),
    Updated DATETIME,
);

INSERT INTO Service (name, tavernId, price, status) VALUES ('Bar Service',1,NULL, 'Active'),('Bar Service',2,NULL, 'Active'),('Bar Service',3,NULL, 'Active'),('Bar Service',4,NULL, 'Active'),('Bar Service',5,NULL, 'Active'),('Pool',1,NULL, 'Not Active'),('Pool',3,NULL, 'Active'),('Darts',2,NULL, 'Active'),('Darts',4,NULL, 'Not Active');

ALTER TABLE Taverns ADD FOREIGN KEY (LocationId) REFERENCES Location(Id);

CREATE TABLE Guests (
	Id INT IDENTITY(1, 1) PRIMARY KEY,
    name varchar(250),
    notes varchar(MAX),
    birthday varchar(50),
    cakeday varchar(50),
    statusId INT,
);




CREATE TABLE Classes(
  Id INT IDENTITY(1, 1) PRIMARY KEY,
  name varchar(250),
);

INSERT INTO Classes (name) VALUES ('Knight'),('Mage'),('Cleric'),('Ranger'),('Thief'),('Brawler');


CREATE TABLE GuestsClasses (
	Id INT IDENTITY(1, 1) PRIMARY KEY,
    guestId INT,
    classId INT,
    Lvl INT,
);
CREATE TABLE Statuses (
	Id INT IDENTITY(1, 1) PRIMARY KEY,
    name varchar(250),
);

/* this statement will fail prior to establishing the foreign key relations */
/* Select Guests.name, Classes.name, GuestsClasses.lvl FROM Guests, Classes, GuestsClasses WHERE GuestsClasses.guestId = Guests.Id AND GuestsClasses.classId = Classes.Id */

ALTER TABLE GuestsClasses ADD FOREIGN KEY (guestId) REFERENCES Guests(Id);
ALTER TABLE GuestsClasses ADD FOREIGN KEY (classId) REFERENCES Classes(Id);
ALTER TABLE Guests ADD FOREIGN KEY (statusId) REFERENCES Statuses(Id);

INSERT INTO Statuses (name) VALUES ('Healthy');
INSERT INTO Guests (name,birthday,cakeday, notes, statusId) VALUES ('Nick','5/26','1/1','Left',1);
INSERT INTO GuestsClasses (guestId, classId, lvl) VALUES (1,2,10);
