-- Passengers Table
CREATE TABLE Passengers (
    PassengerID INTEGER PRIMARY KEY,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Age INTEGER NOT NULL
);

-- Check-Ins Table
CREATE TABLE Check_Ins (
    CheckInID INTEGER PRIMARY KEY,
    CheckInDateTime TEXT NOT NULL,
    PassengerID INTEGER,
    FlightID INTEGER,
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID)
);

-- Airlines Table
CREATE TABLE Airlines (
    AirlineID INTEGER PRIMARY KEY,
    AirlineName TEXT NOT NULL,
    Concourse TEXT NOT NULL
);

-- Flights Table
CREATE TABLE Flights (
    FlightID INTEGER PRIMARY KEY,
    FlightNumber TEXT NOT NULL,
    AirlineID INTEGER,
    DepartureAirportCode TEXT NOT NULL,
    ArrivalAirportCode TEXT NOT NULL,
    ExpectedDepartureDateTime TEXT NOT NULL,
    ExpectedArrivalDateTime TEXT NOT NULL,
    FOREIGN KEY (AirlineID) REFERENCES Airlines(AirlineID)
);
