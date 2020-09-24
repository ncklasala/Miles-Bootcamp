

DROP TABLE IF EXISTS Taverns;
CREATE TABLE Taverns(
	Id INT IDENTITY(1, 1),
	TavernName varchar(250),
    LocationId INT,
    OwnerId Int
);
INSERT INTO Taverns (TavernName,LocationId,OwnerId) VALUES ('The Hall',1,1),('Moes',2,2),('Petrocks',1,3),('Petrocks',2,4),('Rat R US',5,5);

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
	Id INT IDENTITY(1, 1),
	Name varchar(250),
    RoleId INT
);

INSERT INTO Users (Name,RoleId) VALUES ('Kathy',1),('Moe',1),('Jim',1),('sam',2),('Rat King',1),('Tim', 2),('Bethany',2);

DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles (
	Id TINYINT IDENTITY(1, 1),
	Name varchar(50),
    Description varchar(Max)
);

INSERT INTO Roles (Name,Description) VALUES ('Owner','The owner of the Tavern'),('Bartender','Server the beer'),('Waiter','Servers Tables'),('Dish washer','Washes dishes'),('Customer','Patron of the Tavern');

DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
	Id TINYINT IDENTITY(1, 1),
	Name varchar(250),
);

INSERT INTO Location (Name) VALUES ('NJ'),('NY'),('MA'),('DE'),('MD'),('VA');

DROP TABLE IF EXISTS Rats;
CREATE TABLE Rats (
	Id TINYINT IDENTITY(1, 1),
	Name varchar(250),
);

INSERT INTO Rats (Name) VALUES ('Micky'),('Pikachu'),('Lou'),('Charlie'),('Minnie'),('Ricky'),('Bubbles');

DROP TABLE IF EXISTS Supplies;
CREATE TABLE Supplies (
	Id TINYINT IDENTITY(1, 1),
	Name varchar(250),
);

INSERT INTO Supplies (Name) VALUES ('Coors'),('Guinness'),('Reds'),('Heineken'),('Blue Moon'),('Popcorn');

DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory (
	Id TINYINT IDENTITY(1, 1),
    tavernId INT,
    supplyId TINYINT,
    Updated DATETIME,
);

INSERT INTO Inventory (tavernId, supplyId) VALUES (1,1),(1,2),(1,3),(2,1),(2,4);

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
	Id TINYINT IDENTITY(1, 1),
    tavernId Int,
    userId INT,
    price Int,
    supplyId TINYINT,
    Updated DATETIME,
);

INSERT INTO Sales (tavernId, userId, price, supplyId) VALUES (1,2, 5, 1),(1,2, 50, 2),(2,3, 5, 3),(3,2, 7, 1),(5,2, 9, 4), (4,4, 18, 4);

DROP TABLE IF EXISTS Service;
CREATE TABLE Service (
	Id TINYINT IDENTITY(1, 1),
    name varchar(250),
    tavernId Int,
    price Int,
    status varchar(250),
    Updated DATETIME,
);

INSERT INTO Service (name, tavernId, price, status) VALUES ('Bar Service',1,NULL, 'Active'),('Bar Service',2,NULL, 'Active'),('Bar Service',3,NULL, 'Active'),('Bar Service',4,NULL, 'Active'),('Bar Service',5,NULL, 'Active'),('Pool',1,NULL, 'Not Active'),('Pool',3,NULL, 'Active'),('Darts',2,NULL, 'Active'),('Darts',4,NULL, 'Not Active');
