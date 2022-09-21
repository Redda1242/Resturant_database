--Raghd Al Juma D19125768
--YuJiao kan D20125727

-----------------DROP CONSTRAINTS--------------------------------

ALTER TABLE booking
    DROP CONSTRAINT booking_manager_fk;
        
ALTER TABLE booking
    DROP CONSTRAINT booking_staff_fk;

ALTER TABLE guest
    DROP CONSTRAINT guest_booking_fk;
        
ALTER TABLE tableData
    DROP CONSTRAINT table_branch_fk;
        
ALTER TABLE staff
    DROP CONSTRAINT staff_branch_fk;
        
ALTER TABLE manager
    DROP CONSTRAINT manager_branch_fk;
        
ALTER TABLE booking
    DROP CONSTRAINT booking_tableNum_fk;
        
ALTER TABLE booking
    DROP CONSTRAINT booking_customer_fk;
        
ALTER TABLE bill
    DROP CONSTRAINT bill_customer_fk;

ALTER TABLE bill
    DROP CONSTRAINT bill_booking_fk;   
    
--------------DROP TABLES-------------------------------------  

Drop table tableData;
Drop table staff;
Drop table manager;
Drop table guest;
Drop table customer;
Drop table branch;
Drop table booking;
Drop table bill;

----------------------CREATE TABLES-----------------------

CREATE TABLE bill (
    bill_ID         NUMBER(10) NOT NULL,
    bookingDuration FLOAT  NOT NULL,
    charge          FLOAT,
    fine            FLOAT,
    custID NUMBER(10) NOT NULL,
    bookingID NUMBER(10) NOT NULL,
    PRIMARY KEY (bill_ID)
);


CREATE TABLE booking (
    bookingID          NUMBER(10) NOT NULL,
    peopleAttending      INTEGER NOT NULL,
    custID    NUMBER(10) NOT NULL,
    bookingTime    TIMESTAMP,
    tableNum NUMBER(10),
    managerID  NUMBER(7) NOT NULL,
    staffID      NUMBER(7) NOT NULL,
    PRIMARY KEY (bookingID)
);

CREATE TABLE branch (
    branchID          NUMBER(10) NOT NULL,
    branchAddress     VARCHAR2(50) NOT NULL,
    phoneNumber       NUMBER NOT NULL,
    PRIMARY KEY (branchID)
);

CREATE TABLE customer (
    custID    NUMBER(10) NOT NULL,
    firstname VARCHAR2(20) NOT NULL,
    lastname  VARCHAR2(20) NOT NULL,
    address   VARCHAR2(50) NOT NULL,
    email     VARCHAR2(30) NOT NULL,
    age       INTEGER NOT NULL,
    PRIMARY KEY (custID)
);

CREATE TABLE guest (
    guestID           NUMBER(10) NOT NULL,
    firstname         VARCHAR2(20) NOT NULL,
    lastname          VARCHAR2(20) NOT NULL,
    email             VARCHAR2(30) NOT NULL,
    phoneNumber       NUMBER NOT NULL,
    bookingID 		  NUMBER(10) NOT NULL,
    PRIMARY KEY (guestID)
);

CREATE TABLE manager (
    managerID         NUMBER(7) NOT NULL,
    firstname         VARCHAR2(20) NOT NULL,
    lastname          VARCHAR2(20) NOT NULL,
    address           VARCHAR2(100) NOT NULL,
    phoneNumber       VARCHAR2(9) NOT NULL,
    email             VARCHAR2(30) NOT NULL,
    DOB               DATE NOT NULL,
    startDate         DATE,
    branchID   NUMBER(7) NOT NULL,
    PRIMARY KEY (managerID)
);

CREATE TABLE staff (
    staffID           NUMBER(7) NOT NULL,
    firstname         VARCHAR2(20) NOT NULL,
    lastname          VARCHAR2(20) NOT NULL,
    address           VARCHAR2(50) NOT NULL,
    phoneNumber       NUMBER NOT NULL,
    email             VARCHAR2(30) NOT NULL,
    DOB               DATE NOT NULL,
    startDate         DATE,
    branchID   NUMBER(7) NOT NULL,
    PRIMARY KEY ( staffID )
);

CREATE TABLE tableData (
    tableNum          NUMBER(10) NOT NULL,
    tableLocation     VARCHAR2(30) NOT NULL,
    tableType         VARCHAR2(30) NOT NULL,
    branchID   NUMBER(7) NOT NULL,
    PRIMARY KEY ( tableNum )
);


----------------------------ADD FOREIGN KEY CONSTRAINTS------------------------------------
ALTER TABLE bill
    ADD CONSTRAINT bill_customer_fk FOREIGN KEY ( custID )
        REFERENCES customer ( custID );

ALTER TABLE bill
    ADD CONSTRAINT bill_booking_fk FOREIGN KEY ( bookingID )
        REFERENCES booking ( bookingID );

ALTER TABLE booking
    ADD CONSTRAINT booking_customer_fk FOREIGN KEY ( custID )
        REFERENCES customer ( custID );
        
ALTER TABLE booking
    ADD CONSTRAINT booking_tableNum_fk FOREIGN KEY ( tableNum )
        REFERENCES tableData ( tableNum );
        
ALTER TABLE booking
    ADD CONSTRAINT booking_manager_fk FOREIGN KEY ( managerID )
        REFERENCES manager ( managerID );
        
ALTER TABLE booking
    ADD CONSTRAINT booking_staff_fk FOREIGN KEY ( staffID )
        REFERENCES staff ( staffID );
        
        
ALTER TABLE staff
    ADD CONSTRAINT staff_branch_fk FOREIGN KEY ( branchID )
        REFERENCES branch ( branchID );
        
ALTER TABLE manager
    ADD CONSTRAINT manager_branch_fk FOREIGN KEY ( branchID )
        REFERENCES branch ( branchID );
        
ALTER TABLE guest
    ADD CONSTRAINT guest_booking_fk FOREIGN KEY ( bookingID )
        REFERENCES booking ( bookingID );

ALTER TABLE tableData
      ADD CONSTRAINT table_branch_fk FOREIGN KEY ( branchID )
          REFERENCES branch ( branchID );

------------------ADD CHECK CONSTRAINTS------------------------------------

-- customer age should not be lower than 18
ALTER TABLE customer
ADD CONSTRAINT CHK_custAge CHECK (Age>=18);

-- check that no more than 6 people in one booking
ALTER TABLE booking
ADD CONSTRAINT CHK_peopleAttending CHECK (peopleAttending <=6);

--staff emails  should end with @burgershack.com
ALTER TABLE manager
ADD CONSTRAINT CHK_manager_email CHECK (email LIKE '%___@burgershack.com');

ALTER TABLE staff
ADD CONSTRAINT CHK_staff_email CHECK (email LIKE '%___@burgershack.com');

------------------------------------------------------------------------------
------------------------POPULATE DATA-------------------------------------------

---------CUSTOMER DATA------------

INSERT INTO customer (custID, firstname, lastname, address, email, age)
VALUES (65124,'Ishaan', 'Hurley','Carrowcusmacloy, Ballymote, Sligo','timtroyr@comcast.net', 20);

INSERT INTO customer (custID, firstname, lastname, address, email, age)
VALUES (63461,'Jensen', 'Wiggins', '36 Castle stralee', 'monopole@live.com', 32);

INSERT INTO customer (custID, firstname, lastname, address, email, age)
VALUES (81963,'Susie', 'Lee', 'King St, Drogheda', 'afeldspar@sbcglobal.net', 45);

INSERT INTO customer (custID, firstname, lastname, address, email, age)
VALUES (58618,'Caspian', 'Mcfadden', 'Bridge St.Kenmare', 'janneh@me.com', 25);

INSERT INTO customer (custID, firstname, lastname, address, email, age)
VALUES (83790,'Emaan', 'Fountain', 'Post Office Foxford Foxford', 'aardo@verizon.net', 28);

--------BRANCH DATA---------

INSERT INTO branch (branchID, branchAddress, phoneNumber)
VALUES (1, 'Unit 3 River Valley S.C.', 894774308);  

INSERT INTO branch (branchID, branchAddress, phoneNumber)
VALUES (2, '24 upr Mallow st Limerick',  899598866);  

INSERT INTO branch (branchID, branchAddress, phoneNumber)
VALUES (3, 'New Building Lane Kilkenny',  822294784);  

INSERT INTO branch (branchID, branchAddress, phoneNumber)
VALUES (4, '32 Shamrock Pk.',  899951078);  

INSERT INTO branch (branchID, branchAddress, phoneNumber)
VALUES (5, 'Brewery Rd.', 830419213); 

-----------MANAGER DATA----------

INSERT INTO manager (managerID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(33388, 'Elsa','Burris','Cork rd Newport Newport', 'fa2345@burgershack.com', '822120189', TO_DATE('1981/05/10', 'yyyy/mm/dd'), TO_DATE('2014/10/23','yyyy/mm/dd'), 1 );

INSERT INTO manager (managerID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(74511,'Kerry' ,'Hampton', 'Unit 26 1 Ballingly Wellington BridgeWexford','gozer@burgershack.com', '860206748', TO_DATE('1988/04/28', 'yyyy/mm/dd'), TO_DATE('2018/04/24','yyyy/mm/dd'), 2);

INSERT INTO manager (managerID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(78520,'Siana', 'Chapman','Westside Retail Pk Ballincollig','tbusch@burgershack.com', '878017433', TO_DATE('1988/06/18','yyyy/mm/dd'), TO_DATE('2019/10/27','yyyy/mm/dd'), 3);

INSERT INTO manager (managerID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(87399,'Keon', 'Coles','New st Bantry ,Bantry','tjensen@burgershack.com', '822137994',TO_DATE('1992/09/17','yyyy/mm/dd'), TO_DATE('2020/09/24', 'yyyy/mm/dd'), 4);

INSERT INTO manager (managerID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(46124,'Sean', 'Pennington','Unit 2 Enterprise Fund Business Centre Letterkenny','esasaki@burgershack.com', '868532210', TO_DATE('1996/12/08','yyyy/mm/dd'), TO_DATE('2021/04/06', 'yyyy/mm/dd'), 5);

--------STAFF DATA-----------

INSERT INTO staff (staffID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(82312,'Kaidan', 'Jackson','29 Derrigra Cres Ballineen','munjal@burgershack.com', '822137994',TO_DATE('1981/08/23','yyyy/mm/dd'), TO_DATE('2016/08/31', 'yyyy/mm/dd'), 1);

INSERT INTO staff (staffID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(14015,'Bailey', 'Benjamin','56 Strahulter Rd','drezet@burgershack.com', ' 837217426',TO_DATE('1986/08/08','yyyy/mm/dd'), TO_DATE('2017/02/14', 'yyyy/mm/dd'), 2);

INSERT INTO staff (staffID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(45582,'Rosalind', 'Kaur','54 Rushbrook Court, Dublin','pkplex@burgershack.com', '822963384',TO_DATE('1986/12/04','yyyy/mm/dd'), TO_DATE('2018/02/07', 'yyyy/mm/dd'), 3);

INSERT INTO staff (staffID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(20800,'Janet', 'Haynes','123 East Wall rd Dublin 3','tcredmondn@burgershack.com', '838972668',TO_DATE('1988/09/20','yyyy/mm/dd'), TO_DATE('2021/05/08', 'yyyy/mm/dd'), 4);

INSERT INTO staff (staffID, firstname, lastname, address, email, phoneNumber, DOB, startDate, branchID)
VALUES(29699,'Nolan', 'Liu','Unit 1 Jamestown Ind Est Jamestown Rd Dublin, 8','kmiller@burgershack.com', '850108170',TO_DATE('1996/02/15','yyyy/mm/dd'), TO_DATE('2021/09/30', 'yyyy/mm/dd'), 5);

-------TABLES DATA----------

INSERT INTO tableData(tableNum, tableLocation, tableType, branchID)
VALUES (1, 'Window', '2 Seater', 1);

INSERT INTO tableData(tableNum, tableLocation, tableType, branchID)
VALUES (2, 'Window', '4 Seater', 2);

INSERT INTO tableData(tableNum, tableLocation, tableType, branchID)
VALUES (3, 'Interior', '6 Seater', 3);

INSERT INTO tableData(tableNum, tableLocation, tableType, branchID)
VALUES (4, 'Interior', '8 Seater', 4);

INSERT INTO tableData(tableNum, tableLocation, tableType, branchID)
VALUES (5, 'Window', '4 Seater', 5);

------BOOKING DATA------------

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (1, 4,65124, TO_TIMESTAMP('2021-07-02 13:14:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 2, 74511, 14015);

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (2, 5,63461, TO_TIMESTAMP('2021-08-12 16:00:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 3, 78520, 45582);

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (3, 2,81963, TO_TIMESTAMP('2021-10-05 15:30:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 1, 33388, 82312);

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (4, 2,58618, TO_TIMESTAMP('2021-11-23 19:00:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 1, 33388, 82312);

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (5, 4,58618, TO_TIMESTAMP('2021-09-12 18:30:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 2, 74511, 14015);

INSERT INTO booking(bookingID, peopleAttending, custID, bookingTime, tableNum, managerID, staffID)
VALUES (6, 3,83790, TO_TIMESTAMP('2021-10-30 14:00:00', 'YYYY-MM-DD HH24:MI:SS.FF'), 2, 74511, 14015);

------BILL DATA-----------
--fine is not inserted as it is calculated in the dml using an update query
-- the booking duration is in the datatype float to calculate the fine 
INSERT INTO bill(bill_ID, bookingDuration, custID, bookingID, charge)
VALUES (1, 2.0, 58618, 4, 125);

INSERT INTO bill(bill_ID, bookingDuration, custID, bookingID, charge)
VALUES (2, 2.16666667 ,58618, 5, 180);

INSERT INTO bill(bill_ID, bookingDuration, custID, bookingID, charge)
VALUES (3, 2.16666667 ,81963, 3, 103);

INSERT INTO bill(bill_ID, bookingDuration, custID, bookingID, charge)
VALUES (4, 2.16666667 ,83790, 6, 85);

INSERT INTO bill(bill_ID, bookingDuration, custID, bookingID, charge)
VALUES (5, 2.5 ,65124, 1, 350);

---------GUEST DATA----------------

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (1, 'Maria', 'Jackson', 'jmgomez@aol.com', 822077734, 1);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (2, 'Abbas ', 'OReilly', 'jajlitt@comcast.net', 822826879, 1);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (3, 'Manon', 'Kirkpatrick', 'msherr@hotmail.com', 855134708, 1);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (4, 'Halle', 'Henderson', 'sartak@hotmail.com', 888645351, 2);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (5, 'Adina', 'Hardy', 'jguyer@mac.com', 822652280, 2);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (6, 'Mandeep', 'Knapp', 'themer@gmail.com', 884749714, 2);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (7, 'Jonah', 'Mansell', 'peoplesr@live.com', 822378443, 2);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (8, 'Robin', 'Sanford', 'stellaau@aol.com', 861485305, 3);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (9, 'Juniper', 'Derrick', 'jbailie@yahoo.com', 894368955, 3);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (10, 'Alfie', 'Paine', 'wetter@yahoo.com', 822731715, 4);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (11, 'Belinda', 'Steele', 'tmaek@att.net', 822181613, 5);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (12, 'Mamie', 'Bob', 'maratb@verizon.net', 854522135, 5);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (13, 'Arisha', 'Lovell', 'linuxhack@hotmail.com', 830396948, 5);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (14, 'Lex', 'Brady', 'dartlife@yahoo.com', 882189319, 6);

INSERT INTO guest (guestID, firstname, lastname, email, phoneNumber, bookingID)
VALUES (15, 'Clifford', 'Mcdowell', 'tromey@gmail.com', 822321862, 6);

-----COMMIT ALL-----------
COMMIT;







