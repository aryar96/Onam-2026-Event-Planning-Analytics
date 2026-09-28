create database Onam26;
use onam26;
#Participants table
Create table Participants(        
    ParticipantID INT PRIMARY KEY,
    ParticipantName VARCHAR(100),
    Department VARCHAR(50),
    Age INT,
    Gender VARCHAR(20),
    Phone VARCHAR(15)
);
select*from Participants;
insert into Participants values
(1001, 'Aarav', 'Data Analytics', 24, 'Male', '9876500001'),
(1002, 'Ananya', 'Data Analytics', 27, 'Female', '9876500002'),
(1003, 'Rahul', 'Python', 25, 'Male', '9876500003'),
(1004, 'Meera', 'Power BI', 29, 'Female', '9876500004'),
(1005, 'Arjun', 'SQL', 26, 'Male', '9876500005'),
(1006, 'Diya', 'Excel', 23, 'Female', '9876500006'),
(1007, 'Vishnu', 'Data Analytics', 31, 'Male', '9876500007'),
(1008, 'Anjali', 'Power BI', 28, 'Female', '9876500008'),
(1009, 'Nikhil', 'SQL', 30, 'Male', '9876500009'),
(1010, 'Devika', 'Python', 26, 'Female', '9876500010');

#Events table
create table Events (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    Category VARCHAR(50),
    EventDate DATE,
    Venue VARCHAR(100),
    Capacity INT,
    EstimatedCost DECIMAL(10,2)
);
select*from Events;
INSERT INTO Events
VALUES
(1, 'Pookalam Competition', 'Cultural', '2026-08-17',
 'Main Hall', 100, 5000),

(2, 'Onam Games', 'Games & Sports', '2026-08-18',
 'Ground', 150, 8000),

(3, 'Thiruvathira', 'Cultural', '2026-08-20',
 'Auditorium', 100, 10000),

(4, 'Music Program', 'Entertainment', '2026-08-21',
 'Open Stage', 120, 7000),

(5, 'Onam Sadya', 'Food & Sadya', '2026-08-22',
 'Dining Hall', 200, 25000),

(6, 'Traditional Dress Contest', 'Games & Sports', '2026-08-23',
 'Auditorium', 80, 3000),

(7, 'Cultural Program', 'Cultural', '2026-08-24',
 'Auditorium', 200, 15000),

(8, 'Best Pookalam Contest', 'Cultural', '2026-08-25',
 'Open Stage', 100, 3000),

(9, 'Thiruvonam Celebration', 'Main Event', '2026-08-26',
 'Main Hall', 300, 35000);
 
#Registrations table
CREATE TABLE Registrations (
    RegistrationID INT PRIMARY KEY,
    ParticipantID INT,
    EventID INT,
    RegistrationDate DATE,
    foreign key (ParticipantID)
    references Participants (ParticipantID),
    foreign key (EventID)
    references Events (EventID));
    INSERT INTO Registrations
VALUES
(1, 1001, 1, '2026-08-10'),
(2, 1002, 3, '2026-08-10'),
(3, 1003, 2, '2026-08-10'),
(4, 1004, 7, '2026-08-11'),
(5, 1005, 2, '2026-08-11'),
(6, 1006, 1, '2026-08-11'),
(7, 1007, 5, '2026-08-11'),
(8, 1008, 3, '2026-08-12'),
(9, 1009, 9, '2026-08-12'),
(10, 1010, 7, '2026-08-12'),

(11, 1001, 9, '2026-08-12'),
(12, 1002, 5, '2026-08-12'),
(13, 1003, 4, '2026-08-12'),
(14, 1005, 6, '2026-08-12'),
(15, 1007, 9, '2026-08-12');
select*from Registrations;
#Budget table
CREATE TABLE Budget (
    BudgetID INT PRIMARY KEY,
    Category VARCHAR(50),
    EstimatedBudget DECIMAL(10,2),
    ActualSpent DECIMAL(10,2),
    BudgetStatus VARCHAR(30)
);
INSERT INTO Budget
VALUES
(1, 'Food & Sadya', 45000, 12000, 'Within Budget'),
(2, 'Decoration', 20000, 9300, 'Within Budget'),
(3, 'Cultural Programs', 25000, 10000, 'Within Budget'),
(4, 'Games & Sports', 15000, 10000, 'Within Budget'),
(5, 'Prizes & Gifts', 10000, 1000, 'Within Budget'),
(6, 'Entertainment', 10000, 1500, 'Within Budget');
select*from Budget;

#Query 1 — View all upcoming events
select EventDate,EventName from Events order by EventDate;
#Query 2 — Count total participants
select count(ParticipantName) as Total_participants
from Participants;
#Query 3 — Number of registrations per event
select e.EventName,count(r.RegistrationID) as Total_Registrations 
from Events e join Registrations r 
on e.EventID=r.EventID group by EventName order by Total_Registrations desc;

#Query 4 — Most popular event
select e.EventName,count(r.RegistrationID) 
as Total_Registrations 
from Events e join Registrations r 
on e.EventID=r.EventID group by EventName
order by Total_Registrations 
desc limit 1;

#Query 5 — Department-wise participation
select p.Department,count(r.registrationID) 
as Total_Registrations 
from participants p join registrations r
on p.participantID=r.participantID
group by Department 
order by Total_Registrations 
desc;

#Query 6 — Participants registered for multiple events
select p.ParticipantName,count(r.eventID)
as Events_Registered 
from participants p join registrations r 
on p.participantID=r.participantID
group by ParticipantName
having count(r.eventID)>1;

#Query 7 — Event-wise participant names
select e.EventName,p.ParticipantName 
from registrations r
join events e
on e.EventID=r.EventID
join participants p
on r.participantID=p.participantID
order by EventName;

#Query 8 — Estimated budget by category
select Category,EstimatedBudget 
from budget order by EstimatedBudget desc;

#Query 9— Remaining budget and Budget utilization
select Category,EstimatedBudget,ActualSpent,
(EstimatedBudget-ActualSpent) as Remaining_Budget,
round((ActualSpent/EstimatedBudget)*100,2)
as Budget_Utilization
from budget;

#Query 10 — Top 5 Events based on estimated cost
select EventName,EstimatedCost 
from events
order by EstimatedCost desc limit 5;

 


