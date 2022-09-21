--Raghd Al Juma D19125768
--YuJiao kan D20125727
------------------------QUERIES---------------------------------

---------RETRIEVE ALL DATA----------------
SELECT * FROM tableData;
SELECT * FROM staff;
SELECT * FROM manager;
SELECT * FROM guest;
SELECT * FROM customer;
SELECT * FROM branch;
SELECT * FROM booking;
SELECT * FROM bill;

----UPDATE FINE by calculating the duration of the customer stay with the condition that customer stayed longer than 2 hours--

UPDATE bill SET fine=(((bookingDuration-2)*60)*5) WHERE bookingDuration>2;
UPDATE bill SET fine=0 WHERE bookingDuration=2;

----------UPDATE CHARGE to the new final amount by adding the fine.

UPDATE bill SET charge=charge+fine WHERE bookingDuration>2;

--for update people attend numbers when guest match booking ID is 4 
----Update subquery----
UPDATE booking
SET peopleAttending=peopleAttending + 2
WHERE  bookingID IN (select bookingID 
from guest where bookingID=4);

---- show customers who have overstayed their booking
----case-----

SELECT bill_ID, custID, fine,
CASE
    WHEN  fine>0.0 THEN 'Duration over 2 hours'
    WHEN  fine=0 THEN 'Duration is 2 hours'
    else 'Duration under 2 hours'
    END  DurationTime
FROM bill;


--for customer name and table number return only match in customer and booking
----inner join----
SELECT firstname customerName,tableNum FROM customer
inner JOIN booking USING (custID);

--for all manager name and booking time return of the manager and match in booking
----left join----

SELECT firstname managerName , bookingTime FROM manager m
LEFT OUTER JOIN booking b on m.managerID = b.managerID;

--for everthing return of the tableDate and match in booking
----right join----
select * from booking RIGHT OUTER 
JOIN tableData using(tableNum);

--for all customer ID and booking ID from bill table and booking table 
---union join----
SELECT bookingID, custID
FROM   bill
UNION 
SELECT bookingID, custID
FROM   booking;

--for same customer ID and booking ID from bill table and booking table 
----intersect----

SELECT custID, bookingID
FROM bill
INTERSECT
SELECT custID, bookingID
FROM   booking;

--check managerID and staffID which from same restaurants branchID
------one view----
select managerID,staffID ,branchID
from manager m
join staff s using(branchID)

