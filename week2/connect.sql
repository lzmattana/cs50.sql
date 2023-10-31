-- Drop all tables if they exist
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS School;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Connections;
DROP TABLE IF EXISTS SchoolAffiliation;
DROP TABLE IF EXISTS CompanyAffiliation;

CREATE TABLE User (
    UserID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT,
    LastName TEXT,
    Username TEXT,
    Password TEXT
);

CREATE TABLE School (
    SchoolID INTEGER PRIMARY KEY AUTOINCREMENT,
    SchoolName TEXT,
    SchoolType TEXT,
    Location TEXT,
    YearFounded INTEGER
);

CREATE TABLE Company (
    CompanyID INTEGER PRIMARY KEY AUTOINCREMENT,
    CompanyName TEXT,
    Industry TEXT,
    Location TEXT
);

CREATE TABLE Connections (
    ConnectionID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER,
    SchoolID INTEGER,
    CompanyID INTEGER,
    ConnectionType TEXT,
    FOREIGN KEY (UserID) REFERENCES User (UserID),
    FOREIGN KEY (SchoolID) REFERENCES School (SchoolID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);

CREATE TABLE SchoolAffiliation (
    AffiliationID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER,
    SchoolID INTEGER,
    StartDate DATE,
    EndDate DATE,
    Degree TEXT,
    FOREIGN KEY (UserID) REFERENCES User (UserID),
    FOREIGN KEY (SchoolID) REFERENCES School (SchoolID)
);

CREATE TABLE CompanyAffiliation (
    AffiliationID INTEGER PRIMARY KEY AUTOINCREMENT,
    UserID INTEGER,
    CompanyID INTEGER,
    StartDate DATE,
    EndDate DATE,
    Title TEXT,
    FOREIGN KEY (UserID) REFERENCES User (UserID),
    FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID)
);
