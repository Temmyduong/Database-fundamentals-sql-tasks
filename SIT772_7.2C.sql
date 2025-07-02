CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255),
    JoinDate DATE,
    MembershipType VARCHAR(50)
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Publisher VARCHAR(100),
    PublicationYear INT,
    ISBN VARCHAR(20),
    AvailabilityStatus VARCHAR(20)
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATE,
    EventTime TIME,
    Location VARCHAR(100),
    Organizer VARCHAR(100),
    EventDescription TEXT
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100),
    StaffRole VARCHAR(50),
    StaffEmail VARCHAR(100),
    StaffPhone VARCHAR(20)
);

CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    LoanDate DATE,
    ReturnDate DATE,
    LoanStatus VARCHAR(20),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

CREATE TABLE Event_Participation (
    Event_Participation_ID INT PRIMARY KEY,
    Member_ID INT,
    Event_ID INT,
    FOREIGN KEY (Member_ID) REFERENCES Member(MemberID),
    FOREIGN KEY (Event_ID) REFERENCES Event(EventID)
);
    
show tables;


INSERT INTO Member VALUES (1, 'Alice Smith', 'alice@email.com', '0411111111', '123 Main St', '2022-01-01', 'Adult');
INSERT INTO Member VALUES (2, 'Bob Jones', 'bob@email.com', '0422222222', '456 Side St', '2022-02-01', 'Student');
INSERT INTO Member VALUES (3, 'Cathy Brown', 'cathy@email.com', '0433333333', '789 Hill St', '2023-03-01', 'Senior');
INSERT INTO Member VALUES (4, 'David Lee', 'david@email.com', '0444444444', '321 Lake Rd', '2023-04-01', 'Adult');
INSERT INTO Member VALUES (5, 'Eva Green', 'eva@email.com', '0455555555', '654 River Dr', '2023-05-01', 'Student');

INSERT INTO Book VALUES (1, 'Book A', 'Author A', 'Fiction', 'Publisher X', 2010, 'ISBN001', 'Available');
INSERT INTO Book VALUES (2, 'Book B', 'Author B', 'Science', 'Publisher Y', 2012, 'ISBN002', 'Borrowed');
INSERT INTO Book VALUES (3, 'Book C', 'Author C', 'History', 'Publisher Z', 2015, 'ISBN003', 'Available');
INSERT INTO Book VALUES (4, 'Book D', 'Author D', 'Technology', 'Publisher X', 2018, 'ISBN004', 'Available');
INSERT INTO Book VALUES (5, 'Book E', 'Author E', 'Fiction', 'Publisher Y', 2020, 'ISBN005', 'Borrowed');

INSERT INTO Event VALUES (1, 'Book Club', '2024-05-10', '14:00:00', 'Meeting Room 1', 'Alice Smith', 'Monthly book discussion.');
INSERT INTO Event VALUES (2, 'Children Storytime', '2024-05-12', '10:00:00', 'Kids Area', 'Bob Jones', 'Stories for children.');
INSERT INTO Event VALUES (3, 'Author Talk', '2024-06-01', '16:00:00', 'Main Hall', 'Library Staff', 'Meet a local author.');
INSERT INTO Event VALUES (4, 'Tech Help', '2024-06-05', '11:00:00', 'Computer Lab', 'David Lee', 'Help with technology.');
INSERT INTO Event VALUES (5, 'Seminar Series', '2024-06-10', '15:00:00', 'Conference Room', 'Eva Green', 'Educational sessions.');

INSERT INTO Staff VALUES (1, 'John White', 'Librarian', 'john@email.com', '0466666666');
INSERT INTO Staff VALUES (2, 'Jane Black', 'Event Manager', 'jane@email.com', '0477777777');
INSERT INTO Staff VALUES (3, 'Peter Gray', 'Support Staff', 'peter@email.com', '0488888888');
INSERT INTO Staff VALUES (4, 'Mary Blue', 'Librarian', 'mary@email.com', '0499999999');
INSERT INTO Staff VALUES (5, 'Tom Red', 'Event Manager', 'tom@email.com', '0410101010');

INSERT INTO Loan VALUES (1, 1, 1, '2024-04-01', '2024-04-15', 'Returned');
INSERT INTO Loan VALUES (2, 2, 2, '2024-04-03', NULL, 'Borrowed');
INSERT INTO Loan VALUES (3, 3, 3, '2024-04-05', '2024-04-20', 'Returned');
INSERT INTO Loan VALUES (4, 4, 4, '2024-04-07', NULL, 'Borrowed');
INSERT INTO Loan VALUES (5, 5, 5, '2024-04-09', '2024-04-25', 'Returned');

INSERT INTO Event_Participation VALUES (1, 1, 1);
INSERT INTO Event_Participation VALUES (2, 2, 2);
INSERT INTO Event_Participation VALUES (3, 3, 3);
INSERT INTO Event_Participation VALUES (4, 4, 4);
INSERT INTO Event_Participation VALUES (5, 5, 5);


ALTER TABLE Member ADD COLUMN Status VARCHAR(20) DEFAULT 'Active';

SET SQL_SAFE_UPDATES = 0;

UPDATE Member
SET Status = 'Inactive'
WHERE JoinDate < '2023-01-01';

SET SQL_SAFE_UPDATES = 1;

-- a) INNER JOIN + ORDER BY: List loan records with member names ordered by name
SELECT l.LoanID, m.Name, b.Title, l.LoanDate
FROM Loan l
JOIN Member m ON l.MemberID = m.MemberID
JOIN Book b ON l.BookID = b.BookID
ORDER BY m.Name;

-- b) WHERE + IN: Find all books in genres Fiction or Science
SELECT * FROM Book WHERE Genre IN ('Fiction', 'Science');

-- c) DATE FUNCTION: Get all members who joined in the year 2023
SELECT * FROM Member WHERE YEAR(JoinDate) = 2023;

-- d) VIEW + JOIN: Create view of active loans
CREATE VIEW ActiveLoansView AS
SELECT l.LoanID, m.Name AS MemberName, b.Title AS BookTitle
FROM Loan l
JOIN Member m ON l.MemberID = m.MemberID
JOIN Book b ON l.BookID = b.BookID
WHERE l.LoanStatus = 'Borrowed';

SELECT * FROM ActiveLoansView;
